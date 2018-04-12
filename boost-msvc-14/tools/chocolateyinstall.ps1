$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.sourceforge.net/project/boost/boost-binaries/1.62.0/boost_1_62_0-msvc-14.0-32.exe'
$url64      = 'http://downloads.sourceforge.net/project/boost/boost-binaries/1.62.0/boost_1_62_0-msvc-14.0-64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'boost-msvc-14*'

  checksum      = '3e43c3a9f65f47fa242d0a825c6a56abf96fb80e'
  checksumType  = 'sha1'
  checksum64    = '4a952d31dbe6f5a62743c8430b2b3b1d569a392e'
  checksumType64= 'sha1'

  silentArgs    = "/VERYSILENT /qn /norestart /DIR=C:\boost_1_62 /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
