# https://www.appveyor.com/docs/environment-variables/

# Script static variables
$buildDir = $env:APPVEYOR_BUILD_FOLDER # e.g. C:\projects\rn-common\
$buildNumber = $env:APPVEYOR_BUILD_VERSION # e.g. 1.0.17

# C:\projects\rn-common\src\Rn.Common
$projectDir = $buildDir + "\src\Rn.Common";
# C:\projects\rn-common\src\Rn.Common\Rn.Common.csproj
$projectFile = $projectDir + "\Rn.Common.csproj";
# C:\projects\rn-common\src\Rn.CommonTests
$testDir = $buildDir + "\src\Rn.CommonTests";
# C:\projects\rn-common\src\Rn.Common\Rn.Common.x.x.x.nupkg
$nugetFile = $projectDir + "\Rn.Common." + $buildNumber + ".nupkg";


# Display .Net Core version
Write-Host "Checking .NET Core version" -ForegroundColor Green
& dotnet --version

# Restore the main project
Write-Host "Restoring project" -ForegroundColor Green
& dotnet restore $projectFile --verbosity m

# Publish the project
Write-Host "Publishing project" -ForegroundColor Green
& dotnet publish $projectFile

# Discover and run tests
Write-Host "Running tests" -ForegroundColor Green
cd $testDir
& dotnet restore Rn.CommonTests.csproj --verbosity m
$testOutput = & dotnet test | Out-String
Write-Host $testOutput

# Ensure that the tests passed
if ($testOutput.Contains("Test Run Successful.") -eq $False) {
  Write-Host "Build failed!";
  Exit;
}

# Generate a NuGet package for publishing
Write-Host "Building NuGet package" -ForegroundColor Green
cd $projectDir
& dotnet pack -c Release /p:PackageVersion=$buildNumber -o $projectDir

# Save generated artifacts
Write-Host "Saving artifacts..." -ForegroundColor Green
Push-AppveyorArtifact $nugetFile

# Publish package to NuGet
Write-Host "Attempting to publish NuGet package" -ForegroundColor Green
& nuget push $nugetFile -ApiKey $env:NUGET_API_KEY -Source https://www.nuget.org/api/v2/package

# Done
Write-Host "All done." -ForegroundColor Green