#!/usr/bin/env bash

set -e  # Exit immediately if any command fails

# Parse options
USE_ENCA=false
OUTPUT_FORMAT=flac
while getopts "ew" opt; do
  case $opt in
    e)
      USE_ENCA=true
      ;;
    w)
      OUTPUT_FORMAT=wav
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

# Check required tools
command -v fd >/dev/null 2>&1 || { echo "Error: fd command not found" >&2; exit 1; }
command -v shnsplit >/dev/null 2>&1 || { echo "Error: shnsplit command not found" >&2; exit 1; }
command -v cuetag.sh >/dev/null 2>&1 || { echo "Error: cuetag.sh command not found" >&2; exit 1; }
command -v flac >/dev/null 2>&1 || { echo "Error: flac command not found" >&2; exit 1; }

# Check enca if needed
if [ "$USE_ENCA" = true ]; then
  command -v enca >/dev/null 2>&1 || { echo "Error: enca command not found (required with -e flag)" >&2; exit 1; }
fi

DIR=$1

if [ -z "$DIR" ]; then
    echo "Usage: $0 [-e] [-w] <directory>"
    echo "  -e  Enable encoding conversion with enca"
    echo "  -w  Output to wav instead of flac"
    exit 1
fi

if [ ! -d "$DIR" ]; then
    echo "Directory $DIR does not exist"
    exit 1
fi

fd . -e cue "$DIR" --print0 | while IFS= read -r -d '' FILE; do
  echo "Splitting $FILE"
  CUE_DIR=$(dirname "$FILE")
  
  # Check if corresponding FLAC file exists
  if ! ls "$CUE_DIR"/*.flac >/dev/null 2>&1; then
    echo "Error: No FLAC file found in $CUE_DIR" >&2
    exit 1
  fi

  mkdir -p "$CUE_DIR/.split"

  # Convert CUE file encoding if enabled
  if [ "$USE_ENCA" = true ]; then
    if ! enca -L russian -x UTF-8 "$FILE"; then
      echo "Error: Failed to convert encoding for $FILE" >&2
      exit 1
    fi
  fi

  # Split the FLAC file with explicit error checking
  if [ "$OUTPUT_FORMAT" = "flac" ]; then
    SHNSPLIT_OUTPUT="flac flac -V --best -o %f -"
  else
    SHNSPLIT_OUTPUT="$OUTPUT_FORMAT"
  fi
  if ! shnsplit -D -d "$CUE_DIR/.split" -f "$FILE" -t "%n. %t" -o "$SHNSPLIT_OUTPUT" "$CUE_DIR"/*.flac; then
    echo "Error: Failed to split $FILE" >&2
    exit 1
  fi

  rm -f "$CUE_DIR/.split"/00*pregap*

  # Add tags to the split files
  if ! cuetag.sh "$FILE" "$CUE_DIR/.split"/*."$OUTPUT_FORMAT"; then
    echo "Error: Failed to add tags for $FILE" >&2
    exit 1
  fi

  # for f in "$CUE_DIR/.split"/*.flac; do
  #   FILENAME=$(basename "$f")
  #   DIRNAME=$(dirname "$f")
  #   NEW_FILENAME=$(echo "$FILENAME" | tr -d '?' | tr -d ':')

  #   if [ "$FILENAME" != "$NEW_FILENAME" ]; then
  #     mv "$f" "$DIRNAME/$NEW_FILENAME"
  #   fi
  # done

  # # Clean
  # rm "$FILE"
  # rm "$CUE_DIR"/*.flac
  # mv "$CUE_DIR/.split"/* "$CUE_DIR"
  # rm -r "$CUE_DIR/.split"
  printf "\n"
done
