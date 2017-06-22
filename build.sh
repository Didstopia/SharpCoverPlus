#!/bin/bash

# Setup error handling
set -e
set -o pipefail

# Build SharpCover and SharpCover tests
msbuild Gaillard.SharpCover/Program.sln
msbuild Gaillard.SharpCover.Tests/ProgramTests.sln

# Transform PDBs to MDBs
pdb2mdb Gaillard.SharpCover/bin/Debug/SharpCover.exe
pdb2mdb Gaillard.SharpCover.Tests/bin/Debug/ProgramTests.dll

# Run SharpCover
mono Gaillard.SharpCover/bin/Debug/SharpCover.exe instrument travisCoverageConfig.json

# Run NUnit
nunit-console Gaillard.SharpCover.Tests/bin/Debug/ProgramTests.dll

# Run SharpCover
mono Gaillard.SharpCover/bin/Debug/SharpCover.exe check