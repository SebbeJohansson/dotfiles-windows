Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

$Host.UI.RawUI.WindowTitle = $ExecutionContext.SessionState.Path.CurrentLocation

# ── Helpers ───────────────────────────────────────────────────────────────────

function Get-FolderName {
    $p = $ExecutionContext.SessionState.Path.CurrentLocation
    $leaf = Split-Path -Leaf $p
    if ([string]::IsNullOrWhiteSpace($leaf)) { $leaf = $p }
    return $leaf
}

function Set-TermTitle([string]$title) {
    Write-Host -NoNewline "$([char]27)]2;$title$([char]7)"
}

function Set-Osc7 {
    $p = $ExecutionContext.SessionState.Path.CurrentLocation.ProviderPath -replace '\\', '/'
    Write-Host -NoNewline "$([char]27)]7;file://$($env:COMPUTERNAME)/$p$([char]27)\"
}

# ── Override PSConsoleHostReadLine to intercept commands ──────────────────────

function global:PSConsoleHostReadLine {
    # Read the command as normal
    $input = [Microsoft.PowerShell.PSConsoleReadLine]::ReadLine(
        $Host.Runspace, $ExecutionContext
    )

    # Set title to "Folder: command" right before execution
    if (-not [string]::IsNullOrWhiteSpace($input)) {
        Set-TermTitle "$(Get-FolderName): $($input.Trim())"
    }

    return $input
}

# ── Prompt — shown AFTER command finishes (idle state) ────────────────────────

function prompt {
    # Reset title to just folder name when idle
    Set-TermTitle (Get-FolderName)
    Set-Osc7

    return "PS $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedpromptlevel + 1)) "
}

# ── Aliases & utilities ───────────────────────────────────────────────────────

function New-TabHere { wezterm cli spawn --cwd . }
function OpenOpenCodeWithGhostty { ghost -cmd "opencode" }
function OpenGhostty {
    param([string]$cmd)
    $wslPath = wsl.exe wslpath $pwd.Path
    $a = "-e ghostty --working-directory=$wslPath"
    if ($cmd) { $a += " --command=`"bash -i -c '$cmd; exec bash'`"" }
    Start-Process "wsl.exe" -ArgumentList $a -WindowStyle Hidden
}
function OpenWsl {
    param([string]$cmd)
    if ($cmd) {
        wsl.exe --cd "$($pwd.Path)" -- bash -i -c "$cmd; exec `$SHELL"
    } else {
        wsl.exe --cd "$($pwd.Path)"
    }
}

function RunWsl {
    param([string]$cmd)
    wsl.exe --cd "$($pwd.Path)" -- bash -c "$cmd; exec `$SHELL"
}

# ── Wezterm Helpers ───────────────────────────────────────────────────────────

function StartStorefront {
	# cdsf
	$cwd = (Get-Location).Path
	$w = "wezterm"
	$vimPane = $env:WEZTERM_PANE

	function Send-Command($paneId, $cmd) {
			& $w cli send-text --pane-id $paneId $cmd
			& $w cli send-text --pane-id $paneId "`n"
	}

	# Send-Command $vimPane "vim ."

	$yarnPane = & $w cli split-pane --pane-id $vimPane --right --cwd $cwd
	Start-Sleep -Milliseconds 300
	Send-Command $yarnPane "owsl yarn dev"

	$proxyPane = & $w cli split-pane --pane-id $yarnPane --bottom --cwd $cwd
	Start-Sleep -Milliseconds 300
	Send-Command $proxyPane ".\proxy-win.ps1"

	# $gitPane = & $w cli split-pane --pane-id $proxyPane --bottom --cwd $cwd
	# Start-Sleep -Milliseconds 300
	# Send-Command $gitPane "git status"

	# & $w cli activate-pane --pane-id $vimPane
}


Set-Alias nt New-TabHere
Set-Alias oc OpenOpenCodeWithGhostty
Set-Alias ghost OpenGhostty
Set-Alias owsl OpenWsl
Set-Alias rwsl RunWsl
Set-Alias sf StartStorefront
# OPENSPEC:START - OpenSpec completion (managed block, do not edit manually)
. "C:\Users\DragonSebastianJohan\Documents\PowerShell\OpenSpecCompletion.ps1"
# OPENSPEC:END
