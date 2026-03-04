Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

$Host.UI.RawUI.WindowTitle = $ExecutionContext.SessionState.Path.CurrentLocation

# For wezterm
function prompt {
    # Get the name of the current folder only
    $currentFolder = Split-Path -Leaf $ExecutionContext.SessionState.Path.CurrentLocation
    
    # If you are at the root (like C:\), Split-Path returns empty, so we handle that:
    if ([string]::IsNullOrWhiteSpace($currentFolder)) { 
        $currentFolder = $ExecutionContext.SessionState.Path.CurrentLocation 
    }

    # Set the WezTerm tab/window title to just that folder
    $Host.UI.RawUI.WindowTitle = $currentFolder
    
    # Keep the actual command line prompt showing the full path (optional)
    "PS $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedpromptlevel + 1)) "
}

function New-TabHere {
    wt -w 0 new-tab -d .
}
function OpenOpenCode {
    wsl bash -i -c "opencode $Path"
}
function OpenOpenCodeWithGhostty {
    ghost -cmd "opencode"
}
function OpenGhostty {
    param([string]$cmd)

    # 1. Convert the path
    $wslPath = wsl.exe wslpath $pwd.Path
    
    # 2. Build the launch argument
    # We use --command= to ensure the entire string stays together
    $args = "-e ghostty --working-directory=$wslPath"
    
    if ($cmd) {
        # This tells Ghostty: run bash, find 'opencode', run it, then give me a prompt
        $args += " --command=`"bash -i -c '$cmd; exec bash'`""
    }

    # 3. Launch
    Start-Process "wsl.exe" -ArgumentList $args -WindowStyle Hidden
}
Set-Alias nt New-TabHere
Set-Alias oc OpenOpenCodeWithGhostty
Set-Alias ghost OpenGhostty