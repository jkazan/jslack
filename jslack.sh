#!/bin/bash

token='xxxx-xxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
channels=('XXXXXXXXX' 'XXXXXXXXX' 'XXXXXXXXX')
conversations=('XXXXXXXXX' 'XXXXXXXXX' 'XXXXXXXXX')

# relative path
path="`dirname \"$0\"`"

# absolutized and normalized path
path="`( cd \"$path\" && pwd )`"

# Check if cache file exists
if [ ! -f ~/.cache/slack.unread ]; then
    echo 0 > ~/.cache/slack.unread
fi

while true ; do
    unreadCount=0

    # Check unread message count in all specified channels
    for i in ${channels[@]} ; do
        (( unreadCount+=$(curl -s 'https://slack.com/api/channels.info?token='$token'&channel='$i | jq '.channel.unread_count_display') ))
    done

    # Check unread message count in all specified private conversations
    for i in ${conversations[@]} ; do
        (( unreadCount+=$(curl -s 'https://slack.com/api/conversations.info?token='$token'&channel='$i | jq '.channel.unread_count_display') ))
    done

    # Send notification if there is a new message
    if [[ $unreadCount -gt $(head -n 1 ~/.cache/slack.unread) ]] ; then
        if [[ $unreadCount == 1 ]] ; then
            notify-send -i $path/web-slack.png $unreadCount "unread message"
        else
            notify-send -i $path/web-slack.png $unreadCount "unread messages"
        fi
    fi

    # Update cache
    echo $unreadCount > ~/.cache/slack.unread

    sleep 2
done
