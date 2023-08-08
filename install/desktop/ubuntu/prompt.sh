#!/bin/bash

echo "Installing items for your terminal experience"

# Starship prompt
curl -sS https://starship.rs/install.sh | sh
eval "$(starship init bash)"
