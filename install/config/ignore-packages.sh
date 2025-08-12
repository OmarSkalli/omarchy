#!/bin/bash

IGNORE_PACKAGES=(
  # Not updating `uwsm` to latest version due to breaking change.
  # https://github.com/basecamp/omarchy/issues/688 
  "uwsm"
)

if [ ${#IGNORE_PACKAGES[@]} -gt 0 ]; then
  echo "Configuring ignored packages..."
  
  # Build the IgnorePkg line
  IGNORE_LINE="IgnorePkg = ${IGNORE_PACKAGES[*]}"
  
  # Check if IgnorePkg already exists in pacman.conf
  if grep -q "^IgnorePkg" /etc/pacman.conf; then
    # Update existing IgnorePkg line
    sudo sed -i "s/^IgnorePkg.*/$IGNORE_LINE/" /etc/pacman.conf
  else
    # Add IgnorePkg after [options] section
    sudo sed -i "/^\[options\]/a $IGNORE_LINE" /etc/pacman.conf
  fi
  
  echo "Ignored packages configured: ${IGNORE_PACKAGES[*]}"
fi