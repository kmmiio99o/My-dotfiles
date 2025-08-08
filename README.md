# My Dotfiles

These are my personal dotfiles for creating a customized and efficient development environment. These configurations are tailored to my specific needs and preferences.

## Preview

Here's a glimpse of my setup:

<img src="images/preview.png" width="1000">

## Configurations

-   **Zsh**: Shell configuration with Oh-My-Zsh and custom plugins for enhanced productivity, including git, zsh-history-substring-search, and more. Aliases and functions are defined for common tasks. **Includes a custom `fresh` function for Kitty terminal.**
-   **Kitty**: Terminal emulator settings located in `.config/kitty/kitty.conf` with the Nord theme, font customizations, and keybindings for a streamlined terminal experience. **Additional themes are located in `.config/kitty/kitty-themes/themes/.**`
-   **Neofetch**: System information display customized with a unique aesthetic, showcasing system details in a visually appealing way. **The image backend is set to Kitty, displaying a random image from the waifu directory.**
-   **Neovim**: Code editor configuration managed with LazyVim, providing a rich set of plugins and settings for coding in various languages. This includes support for LSP, autocompletion, and syntax highlighting. **Includes treesitter parsers for multiple languages.**
-   **Zed**: Code editor configuration located in `.config/zed/` for a modern and collaborative coding experience. **Provides custom keybindings, settings, and the Tokyo Midnight theme.**

## Installation

There are two ways to install these dotfiles: automatic and manual.

### Automatic Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/kmmiio99o/My-dotfiles.git ~/My-dotfiles
    cd ~/My-dotfiles
    ./install.sh
    ```
    The script will ask if you want to back up your existing dotfiles before installing. (if script is not running, try `chmod +x install.sh`)

### Manual Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/kmmiio99o/My-dotfiles.git ~/My-dotfiles
    ```

2.  Backup existing configurations: Manually back up your existing dotfiles to a safe location.

3.  Create symbolic links:
    ```bash
    ln -s ~/My-dotfiles/.zshrc ~/.zshrc
    ln -s ~/My-dotfiles/.config/kitty ~/.config/kitty
    ln -s ~/My-dotfiles/.config/neofetch ~/.config/neofetch
    ln -s ~/My-dotfiles/.config/nvim ~/.config/nvim
    ln -s ~/My-dotfiles/.config/zed ~/.config/zed
    ```

4.  Install dependencies: Ensure you have the necessary applications and their dependencies installed (Zsh, Oh My Zsh, Kitty, Neofetch, Neovim, Zed, plugins, language servers).

5.  Restart the shell and applications.

## Credits

-   [Oh My Zsh](https://ohmyz.sh/)
-   [Kitty](https://sw.kovidgoyal.net/kitty/)
-   [Neofetch](https://github.com/dylanaraps/neofetch)
-   [LazyVim](https://www.lazyvim.org/)
-   [Zed](https://zed.dev/)

Feel free to explore and adapt these dotfiles to your own needs. Contributions and suggestions are welcome!
