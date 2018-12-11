# https://www.appveyor.com/docs/environment-variables/

# APPVEYOR_BUILD_NUMBER - build number        | 17
# APPVEYOR_BUILD_VERSION - build version      | 1.0.17

$buildDir = $env:APPVEYOR_BUILD_FOLDER
$fullBuildNumber = $env:APPVEYOR_BUILD_VERSION
$rnCommonDir = $buildDir + "\src\Rn.Common";
$nugetFile = $rnCommonDir + "\Rn.Common." + $fullBuildNumber + ".nupkg";

Write-Host "Checking .NET Core version" -ForegroundColor Green
& dotnet --version

Write-Host "Testing build number variables" -ForegroundColor Green
Write-Host $env:APPVEYOR_BUILD_NUMBER
Write-Host $env:APPVEYOR_BUILD_VERSION

Write-Host "Building NuGet package" -ForegroundColor Green
cd $rnCommonDir
& dotnet pack -c Release /p:PackageVersion=$fullBuildNumber -o $rnCommonDir

Write-Host "Attempting to publish NuGet package" -ForegroundColor Green
& $nuget push $nugetFile -ApiKey $env:NUGET_API_KEY -Source https://www.nuget.org/api/v2/package


# Successfully created package 'C:\projects\rn-common\src\Rn.Common\bin\Release\Rn.Common.1.0.19.nupkg'


#  #- cmd: dotnet nuget push Rn.Common.1.0.%version%.nupkg  -k %NuGetKey%  -s https://www.nuget.org/

#write-host $buildFolder