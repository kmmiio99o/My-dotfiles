#!/bin/bash

# Improved script to install dotfiles and dependencies

# Set source and destination directories
DOTFILES_DIR="/home/kmmiio99o/Documents/GitHub/My-dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# Function to backup a file or directory
backup_file() {
  local FILE="$1"
  if [ -e "$FILE" ] || [ -L "$FILE" ]; then
    local TIMESTAMP
    TIMESTAMP=$(date +%Y%m%d%H%M%S)
    local BACKUP_DIR_TS="$BACKUP_DIR/$TIMESTAMP"
    echo "Backing up $FILE to $BACKUP_DIR_TS"
    mkdir -p "$BACKUP_DIR_TS"
    if rsync -av "$FILE" "$BACKUP_DIR_TS/"; then
      echo "Successfully backed up $FILE"
    else
      echo "Error backing up $FILE"
      return 1 # Indicate failure
    fi
  fi
}

# Function to install dependencies based on distro
install_dependencies() {
  if command -v pacman &> /dev/null; then
    echo "Detected Arch-based distro"
    # Install prerequisites for building AUR packages and other dependencies
    sudo pacman -Syu --noconfirm --needed base-devel git zsh kitty neovim curl yay

    # Install neofetch using yay if available
    if command -v yay &> /dev/null; then
        echo "Installing neofetch from AUR using yay..."
        yay -S --noconfirm neofetch
    else
        echo "Could not install neofetch automatically because yay is not available. Please install it manually."
    fi
  }

  elif command -v apt-get &> /dev/null; then
    echo "Detected Debian-based distro (e.g., Ubuntu)"
    sudo apt-get update
    sudo apt-get install -y zsh kitty git neovim curl
    echo "NOTE: Please install neofetch manually."

  elif command -v dnf &> /dev/null; then
    echo "Detected Fedora-based distro"
    sudo dnf install -y zsh kitty git neovim curl
    echo "NOTE: Please install neofetch manually."

  elif command -v zypper &> /dev/null; then
    echo "Detected openSUSE-based distro"
    sudo zypper install -y zsh kitty git neovim curl
    echo "NOTE: Please install neofetch manually."

  else
    echo "Unsupported distro. Please install dependencies (zsh, kitty, git, neovim, curl, neofetch) manually."
    return 1 # Indicate failure
  fi
  return 0 # Indicate success
}

# Function to create symbolic link and handle errors
create_symlink() {
  local SOURCE="$1"
  local TARGET="$2"
  # Remove existing symlink or file at target
  if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
    echo "Removing existing file/link: $TARGET"
    rm -rf "$TARGET"
  fi

  echo "Creating symbolic link: $TARGET -> $SOURCE"
  if ln -s "$SOURCE" "$TARGET"; then
    echo "Successfully created symbolic link: $TARGET -> $SOURCE"
  else
    echo "Error creating symbolic link: $TARGET -> $SOURCE"
    return 1 # Indicate failure
  fi
}

# Install Zed
install_zed() {
  echo "Opening Zed download page in your default browser..."
  # Use xdg-open for Linux, open for macOS
  if [[ "$(uname)" == "Linux" ]]; then
    xdg-open "https://zed.dev/download" &>/dev/null
  elif [[ "$(uname)" == "Darwin" ]]; then
    open "https://zed.dev/download" &>/dev/null
  fi
  echo "Please download and install Zed manually."
}

# --- Main script execution ---
echo "Starting dotfiles installation..."

# Check if DOTFILES_DIR exists
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: DOTFILES_DIR '$DOTFILES_DIR' does not exist. Exiting."
  exit 1
fi

# Ask the user if they want to backup existing files
read -p "Do you want to backup your existing dotfiles? (y/n): " -r backup
echo
if [[ "$backup" =~ ^[Yy]$ ]]; then
  echo "Backing up existing dotfiles..."
  backup_file "$HOME/.zshrc"
  backup_file "$HOME/.config/kitty"
  backup_file "$HOME/.config/neofetch"
  backup_file "$HOME/.config/nvim"
  backup_file "$HOME/.config/zed"
else
  echo "Skipping backup."
fi

# Install dependencies
echo
echo "Attempting to install dependencies..."
if install_dependencies; then
  echo "Dependency check complete."
else
  echo "Failed to install some dependencies. Please review the output and install them manually."
fi

# Create symbolic links
echo
echo "Creating symbolic links..."
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
create_symlink "$DOTFILES_DIR/.config/neofetch" "$HOME/.config/neofetch"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/.config/zed" "$HOME/.config/zed"

# Install Zed
echo
install_zed

# Restart terminal
echo
echo "Dotfiles installation complete. Restarting terminal..."
exec zsh
