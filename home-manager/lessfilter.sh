#!/usr/bin/env bash
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
if [ -d "$1" ]; then
	eza -hl --color=always --icons "$1"
else
	lesspipe.sh "$1": | bat --color=always -p
fi
# lesspipe.sh don't use eza, bat and chafa, it use ls and exiftool. so we create a lessfilter.
