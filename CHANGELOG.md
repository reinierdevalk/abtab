# Changelog
All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]
- Automatic update of `abtab` using `abtab --update`.

## [0.2.0] - 2025-11-29
### Added 
- Automatic creation of virtual environment on `LIB_PATH` during installation.
- `.gitignore`.
### Changed
- venv Python is always selected as Python interpreter.
- Added to parser args in `transcriber.py`.
- Refactored `abtab` and `install.sh`, resulting in `common.sh`. 
- Replaced `@color` with `@head.color` on `<note>` in MEI output (now correctly).
- Restyled `CHANGELOG`.
- Updated `README`.
### Deprecated
- Manual creation and activation of virtual environment.

## [0.1.1] - 2025-11-26
### Added
- `Options` (global) to output of `abtab -h`.

## [0.1.0] - 2025-11-25
### Added
- Version functionality, using VERSION and CHANGELOG.md files.
### Changed
- Normalised `<appInfo>` in all tools; added `@isodate` and `@version` on `<application>`.
- Replaced `@color` with `@head.color` on `<note>` in MEI output.