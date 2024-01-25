﻿$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName    = 'geforce-game-ready-driver'
  fileType       = 'EXE'
  url64          = 'https://us.download.nvidia.com/Windows/551.23/551.23-desktop-win10-win11-64bit-international-dch-whql.exe'
  checksum64     = '6090cf8b003687901c67b12517d8bc8e2751b122c8d29f2087432ff85fdf58a4'
  checksumType64 = 'sha256'
  silentArgs     = '-s -noreboot'
  validExitCodes = @(0,1)
  softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  $packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/474.66/474.66-desktop-win8-win7-64bit-international.exe'
  $packageArgs['checksum64'] = '4c9b2d5a5afcaf07d30f7a254f29de0cee92ac59c55a479c6ed11ec92d272d9d'
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
  Write-Warning "NVIDIA has ended support for 32bit operating systems."
  Write-Warning "32 bit users should specify version 391.35."
  Write-Warning "Security patches for 32bit may be available on geforce.com"
  Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
