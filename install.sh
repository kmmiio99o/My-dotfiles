#!/bin/bash

# Improved script to install dotfiles

# Set source and destination directories
DOTFILES_DIR="$HOME/My-dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# Check if DOTFILES_DIR exists
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: DOTFILES_DIR '$DOTFILES_DIR' does not exist.  Exiting."
  exit 1
fi

# Function to backup a file or directory
backup_file() {
  FILE="$1"
  if [ -e "$FILE" ]; then
    TIMESTAMP=$(date +%Y%m%d%H%M%S)
    BACKUP_DIR_TS="$BACKUP_DIR/$TIMESTAMP"
    echo "Backing up $FILE to $BACKUP_DIR_TS"
    mkdir -p "$BACKUP_DIR_TS"
    if rsync -av "$FILE" "$BACKUP_DIR_TS/"; then
      echo "Successfully backed up $FILE"
    else
      echo "Error backing up $FILE"
    fi
  fi
}

# Ask the user if they want to backup existing files
read -p "Do you want to backup your existing dotfiles? (y/n): " backup

if [[ "$backup" == "y" ]]; then
  echo "Backing up existing dotfiles..."
  backup_file "$HOME/.zshrc"
  backup_file "$HOME/.config/kitty"
  backup_file "$HOME/.config/neofetch"
  backup_file "$HOME/.config/nvim"
  backup_file "$HOME/.config/zed"
else
  echo "Skipping backup."
fi

# Create symbolic links
echo "Creating symbolic links..."

# Function to create symbolic link and handle errors
create_symlink() {
  SOURCE="$1"
  TARGET="$2"
  if [ -L "$TARGET" ]; then
    echo "Removing existing symbolic link: $TARGET"
    rm "$TARGET"
  fi

  echo "Creating symbolic link: $TARGET -> $SOURCE"
  if ln -sf "$SOURCE" "$TARGET"; then
    echo "Successfully created symbolic link: $TARGET -> $SOURCE"
  else
    echo "Error creating symbolic link: $TARGET -> $SOURCE"
  fi
}

# Ensure .config exists
mkdir -p "$HOME/.config"

create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
create_symlink "$DOTFILES_DIR/.config/neofetch" "$HOME/.config/neofetch"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/.config/zed" "$HOME/.config/zed"

echo "Dotfiles installation complete."
