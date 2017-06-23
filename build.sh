#!/bin/bash

# Setup error handling
set -e
set -o pipefail

# Remove old reports
rm -f coverageResults.txt TestResult.xml

# Build everything
msbuild /p:Configuration=Debug /t:Restore,Rebuild

# Run SharpCoverPlus
mono SharpCoverPlus/bin/Debug/SharpCoverPlus.exe instrument travisCoverageConfig.json

## FIXME: Unit tests throw several of the following exception:
##        System.IO.IOException:
##          Sharing violation on path "SharpCoverPlus.Counter.dll"

# Run NUnit
#mono packages/NUnit.ConsoleRunner.3.6.1/tools/nunit3-console.exe SharpCoverPlus.Tests/bin/Debug/SharpCoverPlus.Tests.dll

# Run SharpCoverPlus
mono SharpCoverPlus/bin/Debug/SharpCoverPlus.exe check