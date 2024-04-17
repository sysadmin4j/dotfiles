#!/bin/bash

# Exit the script when an error occurs
set -e

NERD_FONTS_VERSION="3.1.1"
#NERD_FONTS_FILENAME="NerdFontsSymbolsOnly.zip"
#NERD_FONTS_FILENAME="3270.zip"
NERD_FONTS_FILENAME="Meslo.zip"
NERD_FONTS_GITHUB_RELEASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/${NERD_FONTS_FILENAME}"

# Creating installation tmp dir
NERD_FONTS_INSTALL_TMPDIR="$(mktemp -d -t $(basename $0))"

# Download
curl -fsSL "${NERD_FONTS_GITHUB_RELEASE_URL}" -o "${NERD_FONTS_INSTALL_TMPDIR}/${NERD_FONTS_FILENAME}"

# Extract the nerdfonts archive
unzip -q "${NERD_FONTS_INSTALL_TMPDIR}/${NERD_FONTS_FILENAME}" -x "README*" "LICENSE*" -d "${NERD_FONTS_INSTALL_TMPDIR}"

# Copy the fonts to the user Library
cp -v "${NERD_FONTS_INSTALL_TMPDIR}/"*.ttf ~/Library/Fonts/

# Removing installation tmp dir
rm -r "${NERD_FONTS_INSTALL_TMPDIR}"

#EOF
