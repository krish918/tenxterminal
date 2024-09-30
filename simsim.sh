#!/bin/bash

# Install tmux. Run the script as sudo if required.
apt install -y tmux

# Install tmux plugin manager.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/

# Setup tmux config file
TMUX_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"

if [ -f $TMUX_CONFIG_FILE ]; then
  mv $TMUX_CONFIG_FILE "${TMUX_CONFIG_FILE}.old"
fi

# Setup tmux config
cp tmux.conf $TMUX_CONFIG_FILE

# Install zsh
apt install -y zsh

# Install fzf tool
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# Setup zsh config
if [ -f "${HOME}/.zshrc" ]; then
  mv $HOME/.zshrc $HOME/.zshrc.old
fi

cp .zshrc $HOME/.zshrc

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Install nvchad plugin
git clone https://github.com/NvChad/starter $HOME/.config/nvim && nvim

# Configure vim-tmux-navigator for neovim
mv $HOME/.config/nvim/lua/plugins/init.lua $HOME/.config/nvim/lua/plugins/init.lua.old
cp init.lua $HOME/.config/nvim/lua/plugins/init.lua  
mv $HOME/.config/nvim/lua/mappings.lua $HOME/.config/nvim/lua/mappings.lua.old
cp mappings.lua $HOME/.config/nvim/lua/ 
