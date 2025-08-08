# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Enable lambda theme
ZSH_THEME="lambda"

# Load plugins
plugins=(git zsh-history-substring-search zsh-navigation-tools)
plugins+=(web-search)
zstyle ':omz:autoupdate' frequency 7
plugins+=(copypath)
plugins+=(zsh-completions)

source $ZSH/oh-my-zsh.sh

# Enhanced clear command with neofetch
clear_and_neofetch() {
  command clear
  if command -v neofetch >/dev/null; then
    neofetch
  else
    echo "Install neofetch: \`brew install neofetch\` or \`sudo apt install neofetch\`"
  fi
}

# Create aliases for enhanced clear
alias clear="clear_and_neofetch"

# Syntax highlighting and autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Start neofetch on terminal start
neofetch

# Better clear command
fresh() {
    # Only run in Kitty terminal
    [[ -z "$KITTY_WINDOW_ID" ]] && return

    # Create new tab in the same window and run neofetch
    kitty @ launch --type tab --cwd current --title "neofetch" \
        --location after --allow-remote-control \
        sh -c "neofetch; exec $SHELL"

    # Close original tab after brief delay
    sleep 0.1
    kitty @ close-tab --self
}
