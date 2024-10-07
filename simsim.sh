#!/bin/bash

# Install tmux. Run the script as sudo if required.
sudo apt install -y tmux

# Install tmux plugin manager.
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm


CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

# Setup tmux config file
TMUX_CONFIG_FILE="${CONFIG_HOME}/tmux/tmux.conf"

[ ! -d "$(dirname $TMUX_CONFIG_FILE)" ] && mkdir -p "$(dirname $TMUX_CONFIG_FILE)"

[ -f "${TMUX_CONFIG_FILE}" ] && mv $TMUX_CONFIG_FILE "${TMUX_CONFIG_FILE}.old"

# Setup tmux config
cp tmux.conf $TMUX_CONFIG_FILE

# Install all tmux plugins
$HOME/.tmux/plugins/tpm/bin/install_plugins

# Install zsh
sudo apt install -y zsh

# Install fzf tool
if [ ! -d $HOME/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --bin --no-update-rc
fi

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
sudo rm -rf nvim-linux64.tar.gz

# Install nvchad plugin
if [ ! -d "${CONFIG_HOME}/nvim" ]; then
  git clone https://github.com/NvChad/starter $CONFIG_HOME/nvim 
  rm -rf $CONFIG_HOME/nvim/.git
fi  

# Configure vim-tmux-navigator for neovim
mv $CONFIG_HOME/nvim/lua/plugins/init.lua $CONFIG_HOME/nvim/lua/plugins/init.lua.old
cp init.lua $CONFIG_HOME/nvim/lua/plugins/init.lua  
mv $CONFIG_HOME/nvim/lua/mappings.lua $CONFIG_HOME/nvim/lua/mappings.lua.old
cp mappings.lua $CONFIG_HOME/nvim/lua/mappings.lua 

# Start Tmux. Starting Tmux will auto initialize a zsh shell which in-turn will start an interactive powerline10k configuration. 
tmux -u
