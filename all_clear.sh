#!/bin/bash

# Clean and uninstall the complete setup

CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

if [ ! -d $CONFIG_HOME ]; then return 0; fi

sudo rm -rf /opt/nvim
rm -rf $CONFIG_HOME/nvim
rm -rf $HOME/.cache/nvim
rm -rf $HOME/.local/state/nvim
rm -rf $HOME/.local/share/nvim

$HOME/.fzf/uninstall
rm -rf $HOME/.fzf
sudo apt remove -y zsh
rm -rf $HOME/.cache/p10k-intel
rm -rf $HOME/.local/share/zinit
rm -rf $HOME/.cache/zinit

rm -rf $HOME/.p10k.zsh
rm -rf $HOME/.fzf.bash
rm -rf $HOME/.fzf.zsh
rm -rf $HOME/.zshrc

tmux kill-server
$HOME/.tmux/plugins/tpm/bin/clean_plugins
sudo apt remove -y tmux
rm -rf $HOME/.tmux
rm -rf $CONFIG_HOME/tmux
