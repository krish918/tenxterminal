#!/bin/bash

# Install tmux. Run the script as sudo if required.
apt install -y tmux

# Install tmux plugin manager.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/

CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

if [ ! -f $CONFIG_HOME ]; then
  mkdir $CONFIG_HOME
fi

# Setup tmux config file
TMUX_CONFIG_FILE="${CONFIG_HOME:g}/tmux/tmux.conf"

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
sudo mv /opt/nvim-linux64 /opt/nvim

# Install nvchad plugin
git clone https://github.com/NvChad/starter $CONFIG_HOME/nvim 
rm -rf $CONFIG_HOME/nvim/.git

# Configure vim-tmux-navigator for neovim
mv $CONFIG_HOME/nvim/lua/plugins/init.lua $CONFIG_HOME/nvim/lua/plugins/init.lua.old
cp init.lua $CONFIG_HOME/nvim/lua/plugins/init.lua  
mv $CONFIG_HOME/nvim/lua/mappings.lua $CONFIG_HOME/nvim/lua/mappings.lua.old
cp mappings.lua $CONFIG_HOME/nvim/lua/ 
