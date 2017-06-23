#!/bin/bash

# Setup error handling
set -e
set -o pipefail

# Build everything
msbuild /p:Configuration=Debug /t:Restore,Rebuild

## TODO: This is broken, throws all sorts of exceptions
# Run SharpCoverPlus
mono SharpCoverPlus/bin/Debug/SharpCoverPlus.exe instrument travisCoverageConfig.json

## TODO: This is broken, probably because the test build step was part of the code itself
# Run NUnit
nunit-console SharpCoverPlus.Tests/bin/Debug/ProgramTests.dll

## TOOD: This step might be ok, as it's reporting "Overall coverage was 0%."
# Run SharpCoverPlus
mono SharpCoverPlus/bin/Debug/SharpCoverPlus.exe check