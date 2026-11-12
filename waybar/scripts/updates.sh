#!/bin/bash
# Count official repo updates
UPDATES=$(checkupdates 2>/dev/null | wc -l)
# Count AUR updates
AUR_UPDATES=$(yay -Qu 2>/dev/null | wc -l)
TOTAL=$((UPDATES + AUR_UPDATES))

if [ "$TOTAL" -gt 0 ]; then
    echo "{\"text\": \"  $TOTAL\", \"tooltip\": \"$TOTAL updates available\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"\"}"
fi
