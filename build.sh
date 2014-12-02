#!/bin/bash

# Builds the NextEuropa distribution.
#
# Options:
# --help: Show help text.
# --clean: Retain the git repositories of all downloaded projects.
# --quick: Do a quick build. This will download tarballs rather than git
#   repositories where possible.
# --verbose: Show debugging information.

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR="${ROOT_DIR}/build"
DRUSH_MAKE_OPTIONS=""

# Print out documentation.
function show_help {
  echo -e "Usage: ./build.sh [OPTIONS]"
  echo -e "Builds the NextEuropa distribution in the 'build' subfolder. Options:"
  echo -e "-h\t--help\tShow this help text."
  echo -e "-g\t--clean\tRemove the git repositories of all downloaded projects."
  echo -e "-q\t--quick\tDo a quick install, using packaged downloads rather than full git repositories."
  echo -e "-v\t--verbose\tShow what is going on during the build."
}

# Check command line arguments.
while [[ "$1" == -* ]]; do
  case "$1" in
    -h|--help|-\?) show_help; exit 0;;
    -g|--clean) CLEAN=true; shift;;
    -q|--quick) QUICK=true; shift;;
    -v|--verbose) VERBOSE=true; shift;;
    --) shift; break;;
    -*) echo "invalid option: $1" 1>&2; show_help; exit 1;;
  esac
done

# Do not continue if the distribution was already built.
if [ -d "${BUILD_DIR}" ] ; then
  echo "Error: Target directory already exists: ${BUILD_DIR}"
  echo "Please rename or remove this directory before continuing."
  exit 1
fi

# Set up Drush make options
if [ -z $CLEAN ] ; then
  # If the --clean option is not passed, let drush make retain git repositories.
  DRUSH_MAKE_OPTIONS="$DRUSH_MAKE_OPTIONS --working-copy"
fi

if [ $VERBOSE ] ; then
  DRUSH_MAKE_OPTIONS="$DRUSH_MAKE_OPTIONS --debug"
fi

# Move the distribution files into a profile.
mkdir -p "${BUILD_DIR}/profiles/nexteuropa"
find "${ROOT_DIR}" -mindepth 1 -maxdepth 1 ! -iname "build" -exec cp -r {} "${BUILD_DIR}/profiles/nexteuropa/" \;

cd "${BUILD_DIR}"

# Make the build.
if [ -z $QUICK ] ; then
  FILE=drupal-org.make
else
  FILE=drupal-org-quick.make
fi

drush make --contrib-destination=profiles/nexteuropa "${ROOT_DIR}/${FILE}" -y $DRUSH_MAKE_OPTIONS
if [ $? -ne 0 ] ; then { echo "error: contributed modules could not be built" ; exit 1 ; } fi

# Remove all .git directories if they are not needed.
if [ $CLEAN ] ;  then
  find . -type d -name ".git" -print0 | xargs -0 rm -rf
fi

# Install dependencies.
cd "${BUILD_DIR}/profiles/nexteuropa/"
composer install

cd "${ROOT_DIR}"

echo -e "\nBuild is available in ${BUILD_DIR}."

exit 0
