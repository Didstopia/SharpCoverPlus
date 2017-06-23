#!/bin/bash

# Setup error handling
set -e
set -o pipefail

# Build everything
msbuild /p:Configuration=Debug /t:Restore,Rebuild
#msbuild Gaillard.SharpCover/Program.sln
#msbuild Gaillard.SharpCover.Tests/ProgramTests.sln

# Transform PDBs to MDBs
#pdb2mdb Gaillard.SharpCover/bin/Debug/SharpCover.exe
#pdb2mdb Gaillard.SharpCover.Tests/bin/Debug/ProgramTests.dll

## TODO: This is broken, throws all sorts of exceptions
# Run SharpCover
mono Gaillard.SharpCover/bin/Debug/SharpCover.exe instrument travisCoverageConfig.json

## TODO: This is broken, probably because the test build step was part of the code itself
# Run NUnit
#nunit-console Gaillard.SharpCover.Tests/bin/Debug/ProgramTests.dll

## TOOD: This step might be ok, as it's reporting "Overall coverage was 0%."
# Run SharpCover
mono Gaillard.SharpCover/bin/Debug/SharpCover.exe check