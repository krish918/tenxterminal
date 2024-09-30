#!/bin/bash

# Personal Workspace setup script
# Author: Krishna Murti

clear

SESS_OFFICIAL="opea-job"
SESS_PERSONAL="tenx-session"

tmux has-session -t $SESS_OFFICIAL 2>/dev/null

if [ $? != 0 ]; then

  tmux new-session -d -s $SESS_OFFICIAL -n "dev"
  tmux send-keys -t $SESS_OFFICIAL:dev "cd ~/10xengineer/my10xproject/" C-m
  tmux send-keys -t $SESS_OFFICIAL:dev "nv" C-m
  tmux split-window -h
  tmux send-keys -t $SESS_OFFICIAL:dev.2 "cd ~/10xengineer/my10xproject/" C-m
  tmux select-pane -t 1


  tmux new-window -t $SESS_OFFICIAL -n "devops"
  tmux send-keys -t $SESS_OFFICIAL:devops "cd ~/10xengineer/my10xproject/" C-m
  tmux split-window -h
  tmux split-window -h
  tmux select-pane -t 1


  tmux new-window -t $SESS_OFFICIAL -n "test-drive"
  tmux send-keys -t $SESS_OFFICIAL:test-drive "cd ~/10xengineer/my10xproject/" C-m

  tmux split-window -h
  tmux send-keys -t $SESS_OFFICIAL:test-drive.2 "cd ~/10xengineer/my10xproject/" C-m

  tmux split-window -v
  tmux send-keys -t $SESS_OFFICIAL:test-drive.3 "cd ~/10xengineer/my10xproject/" C-m

  tmux select-pane -t 1
  tmux split-window -v
  tmux select-pane -t 1

  tmux select-window -t $SESS_OFFICIAL:dev

fi

tmux -u attach-session -t $SESS_OFFICIAL

