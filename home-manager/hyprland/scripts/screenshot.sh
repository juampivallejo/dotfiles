#!/usr/bin/env bash

SCREENSHOTS="$HOME/Pictures/Screenshots"
NOW=$(date +%Y-%m-%d_%H-%M-%S)
TARGET="$SCREENSHOTS/$NOW.png"

mkdir -p $SCREENSHOTS

if [[ -n "$1" ]]; then
	wayshot -f $TARGET || exit 1
else
	wayshot -f $TARGET -s "$(slurp)" || exit 1
fi

wl-copy <$TARGET

RES=$(
	notify-send \
		-a "Screenshot" \
		-i "image-x-generic-symbolic" \
		-h string:image-path:$TARGET \
		-A "file=Show in Files" \
		-A "view=View" \
		-A "edit=Edit" \
		"Screenshot Taken" \
		$TARGET
)

case "$RES" in
"file")
	xdg-open "$SCREENSHOTS"
	;;
"view")
	xdg-open $TARGET
	;;
"edit")
	swappy -f $TARGET
	;;
*) ;;
esac
