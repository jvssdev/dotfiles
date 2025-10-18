#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up Yazi plugins...${NC}"

# Check if ya (Yazi package manager) is available
if ! command -v ya &> /dev/null; then
    echo -e "${RED}✗ 'ya' command not found. Is Yazi installed?${NC}"
    echo -e "${YELLOW}Install Yazi first: https://github.com/sxyazi/yazi${NC}"
    exit 1
fi

# Install starship plugin
echo -e "${YELLOW}Installing starship plugin...${NC}"
if ya pack add Rolv-Apneseth/starship; then
    echo -e "${GREEN}✓ Starship plugin installed${NC}"
else
    echo -e "${RED}✗ Failed to install starship plugin${NC}"
fi

# Install nord theme
echo -e "${YELLOW}Installing nord theme...${NC}"
if ya pack add AdithyanA2005/nord; then
    echo -e "${GREEN}✓ Nord theme installed${NC}"
else
    echo -e "${RED}✗ Failed to install nord theme${NC}"
fi
