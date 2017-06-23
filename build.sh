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
mono packages/NUnit.ConsoleRunner.3.6.1/tools/nunit3-console.exe SharpCoverPlus.Tests/bin/Debug/SharpCoverPlus.Tests.dll

## FIXME: This is now reporting "Could not find file coverageKnowns"
## TOOD: This step might be ok, as it's reporting "Overall coverage was 0%."
# Run SharpCoverPlus
mono SharpCoverPlus/bin/Debug/SharpCoverPlus.exe check