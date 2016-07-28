# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.1.2] - 2016-07-28
### Changed
- switched to http://gex.jamie.so
- jq is now a requirement for the deploy sections of the makefile
- post deploy check implemented

## [1.1.1] - 2016-07-27
### Changed
- Pipeline now uploads on a new tag

## [1.1.0] - 2016-07-27
### Added
- New version api /api/version
### Changed
- Bash shell now used in Makefile rather than the default shell

## [1.0.6] - 2016-07-26
### Added
- deploy on push to sloppy.io, for testing.

## [1.0.5] - 2016-07-26
### Added
- version now displayed on the root webpage

## [1.0.4] - 2016-07-26
### Added
- Docker hub email added

## [1.0.3] - 2016-07-26
### Added
- Docker hub login added

## [1.0.2] - 2016-07-26
### Changed
- Use the docker image as an artefact rather than uploading an artefact to s3

## [1.0.1] - 2016-07-26
### Added
- new changelog as per - http://keepachangelog.com/
- Travis CI added
- test coverage

### Changed
- test now runs unittest

## [1.0.0] - 2016-07-25
### Added
- initial working version
