#!/usr/bin/env bash

## From ThePrimeagen

selected=$(cat ~/.config/tmux/scripts/.tmux-cht-languages ~/.config/tmux/scripts/.tmux-cht-command | fzf)
if [[ -z $selected ]]; then
	exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/tmux/scripts/.tmux-cht-languages; then
	query=$(echo $query | tr ' ' '+')
	tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | bat --color=always --paging=always"
else
	tmux neww bash -c "curl -s cht.sh/$selected~$query | bat --color=always --paging=always"
fi
