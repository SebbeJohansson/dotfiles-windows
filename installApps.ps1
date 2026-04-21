$apps = @("Git.Git","Atlassian.Sourcetree","CoreyButler.NVMforWindows","Microsoft.PowerToys","Microsoft.VisualStudioCode.Insiders","Docker.DockerDesktop","Notepad++.Notepad++","Postman.Postman","CoreyButler.NVMforWindows","ajeetdsouza.zoxide","fzf","Microsoft.Teams","Flow-Launcher.Flow-Launcher","voidtools.Everything.Alpha","ShareX.ShareX","Google.Chrome","AgileBits.1Password","Logitech.OptionsPlus","Ditto.Ditto","Obsidian.Obsidian","7zip.7zip","Discord.Discord","Spotify.Spotify","Doist.Todoist","TeamViewer.TeamViewer","flux.flux","WhatsApp.WhatsApp","CPUID.HWMonitor","Parsec.Parsec")

Write-Host "Installing Winget packages..." -ForegroundColor Cyan
foreach ($app in $apps) {
winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}