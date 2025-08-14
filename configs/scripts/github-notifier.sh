#!/bin/bash

github-notifier
exit_code=$?

if [ $exit_code -eq 2 ]; then
    echo '{"text": "", "class": "notification", "tooltip": "You have GitHub notifications"}'
else
    echo '{"text": "", "class": "none", "tooltip": "No notifications"}'
fi
