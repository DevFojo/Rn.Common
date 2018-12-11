# https://www.appveyor.com/docs/environment-variables/

# APPVEYOR_BUILD_NUMBER - build number        | 17
# APPVEYOR_BUILD_VERSION - build version      | 1.0.17

$buildDir = $env:APPVEYOR_BUILD_FOLDER
$fullBuildNumber = $env:APPVEYOR_BUILD_VERSION
$projectDir = $buildDir + "\src\Rn.Common";
$testDir = $buildDir + "\src\Rn.CommonTests";
$nugetFile = $projectDir + "\Rn.Common." + $fullBuildNumber + ".nupkg";

Write-Host "Checking .NET Core version" -ForegroundColor Green
& dotnet --version

Write-Host "Running tests" -ForegroundColor Green
cd $testDir
& dotnet restore Rn.CommonTests.csproj --verbosity m
& dotnet test

Write-Host "Building NuGet package" -ForegroundColor Green
cd $projectDir
& dotnet pack -c Release /p:PackageVersion=$fullBuildNumber -o $projectDir

Write-Host "Saving artifacts..." -ForegroundColor Green
Get-ChildItem .\*.nupkg | % { Push-AppveyorArtifact $_.FullName -FileName $_.Name }

Write-Host "Attempting to publish NuGet package" -ForegroundColor Green
& nuget push $nugetFile -ApiKey $env:NUGET_API_KEY -Source https://www.nuget.org/api/v2/package
