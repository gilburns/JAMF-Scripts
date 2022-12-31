#!/bin/bash

#########################################################################################
#
#########################################################################################
#


STATUS_TEXT="$4"
BANNER_IMAGE_PATH="$5"
BANNER_TITLE="$6"
MAIN_TEXT="$7"
DEP_NOTIFY_LOG="${8:-/var/tmp/depnotify.log}"


if [ -f "$DEP_NOTIFY_LOG" ]; then

	# Setting custom status if specified
	if [ "$STATUS_TEXT" != "" ]; then
		echo "Status: $STATUS_TEXT" >> "$DEP_NOTIFY_LOG"
	fi

	# Setting custom image if specified
	if [ "$BANNER_IMAGE_PATH" != "" ]; then
		echo "Command: Image: $BANNER_IMAGE_PATH" >> "$DEP_NOTIFY_LOG"
	fi

	# Setting custom title if specified
	if [ "$BANNER_TITLE" != "" ]; then
		echo "Command: MainTitle: $BANNER_TITLE" >> "$DEP_NOTIFY_LOG"
	fi

	# Setting custom main text if specified
	if [ "$MAIN_TEXT" != "" ]; then
		echo "Command: MainText: $MAIN_TEXT" >> "$DEP_NOTIFY_LOG"
	fi
fi

exit 0