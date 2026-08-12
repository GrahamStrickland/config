# config

Dot files for macOS, WSL, and Windows terminal config

## Windows setup

### PowerShell profile

Windows runs inside a Parallels VM where the *Documents* known folder is mapped
to the Mac home via a shared folder, so `$PROFILE` resolves to:

    C:\Mac\Home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

That path lives on the `prl_fs` filesystem, which doesn't implement NTFS reparse
points. Symlinking the profile there fails with "Symbolic links are not supported
for the specified path" no matter how the shell is elevated — the limitation is
the filesystem, not the privilege.

So this one file can't be linked and has to be created by hand, as a stub that
dot-sources the copy in this repo:

```powershell
New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE) | Out-Null
Set-Content -Path $PROFILE -Value '. "C:\Users\graham\dev\config\windows\PowerShell\Microsoft.PowerShell_profile.ps1"'
```
