# Changelog
All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]
- Install TensorFlow (1.6.0?) in the virtual environment.

## [0.3.0] - 2025-12-16
### Added
- Added `-u`/`--update` option: updates the current `abtab` installation, using the configuration in the existing `config.cfg`.
### Changed
- Added `examples/` directory in `ROOT_PATH`, containing the example files. 
- Example files are no longer copied into the `data/` subdirectories when installing/updating.
- When updating
  - The entire `data/` directory, containing user files, is kept as-is.
  - The pre-update default example files and the default template file are kept (with a name suffix).
- Updated `README`.
### Deprecated
- Manual reinstallation process.

## [0.2.4] - 2025-12-11
### Changed
- Restructured `abtab` repository. 
- Updated `README`.

## [0.2.3] - 2025-11-30
### Fixed
- `.venv` is deleted when emptying `LIB_PATH` during installation.

## [0.2.2] - 2025-11-30
### Fixed
- `.git` and `.gitignore` are deleted instead of moved to `LIB_PATH` (now correctly).
- Name fix of `venv` paths (`PythonInterface`).
- Updated `README`.

## [0.2.1] - 2025-11-30
### Fixed
- Copying of both example files into `data/` directory structure.
- `.git` and `.gitignore` are deleted instead of moved to `LIB_PATH`.
- Copying of `.venv` into `LIB_PATH`.
- Removed TensorFlow dependency from `requirements.txt` (too old; gives 'could not find a version error').
- Cleanup of `venv` paths (`abtab` and `PythonInterface`) and some minor refactoring/cleanup.
- Updated `README`.

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