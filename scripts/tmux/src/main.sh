#!/bin/bash

# Works with tmux 2.6 on Ubuntu 18.04. Your mileage may vary.
# 'send-keys' exists only to show/prove what's going where: the space prevents command history retention
#   and the hashtag indicates a comment so bash doesn't try to run it.

session="testing"

# Removed: seems unnecessary.
# tmux start-server

# Create new session, and extra windows.
tmux new-session -d -s $session -n Window\ 1
tmux send-keys " # screen 1, pane 1" C-m

# Split window into two, horizontally: 67%/33% of current window.
tmux split-window -h -p 33
tmux send-keys " # screen 1, pane 2" C-m

# Split (new) window into two, vertically: 33%/67% of current window.
tmux split-window -v -p 67
tmux send-keys " # screen 1, pane 3" C-m

# Split (new new) window into two, vertically: 50%/50% of current window.
tmux split-window -v -p 50
tmux send-keys " # screen 1, pane 4" C-m

# Select pane 0.
tmux select-pane -t 1
tmux send-keys " # back here again" C-m

# Split window into two, vertically: 50%/50% of current window.
tmux split-window -v -p 50
tmux send-keys " # screen 1, pane 5" C-m
# All the other panes are now renumbered!!

# Focus the top-left pane. For sanity.
tmux select-pane -t 1

# A second whole window!
tmux new-window -t $session:2 -n Window\ 2
tmux send-keys " # screen 2, pane 1" C-m
tmux split-window -h -p 50
tmux send-keys " # screen 2, pane 2" C-m
tmux select-pane -t 0

# A THIRD whole window!
tmux new-window -t $session:3 -n Window\ 3
tmux send-keys " # screen 3, pane 1" C-m
tmux split-window -v -p 50
tmux send-keys " # screen 3, pane 2" C-m
tmux select-pane -t 0

# Select the second window, then the first window (so that the second window is the 'next' one).
tmux select-window -t $session:2
tmux select-window -t $session:1

# Make it so. This must be the very last command.
tmux attach-session -t $session