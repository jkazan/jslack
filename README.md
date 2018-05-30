# Bash script for customized notifications from Slack

### Instructions
1. Go to https://api.slack.com/custom-integrations/legacy-tokens and generate a legacy token
2. ```sh
   $ git clone https://github.com/jkazan/jslack.git
   ```
2. Open `jslack.sh` in your editor
3. Change the variable `token` to contain the legacy token you generated.
4. Login to Slack in your browser. Click on the channels you would like to get notifications from and find the Channel ID in the url, e.g. in https://my-slack.slack.com/messages/C2GNFHN07/ the Channel ID is `C2GNFHN07`. Now copy this Channel ID into the array in the variable `channels` in `jslack.sh`
5. Repeat 4. for private conversations, with the exception that these Conversations IDs should be in the variable `conversations`.
6. Depending on your OS distribution, the notification function may differ. If needed, google <your OS> + bash notification and you will find the appropriate function.

### Run
```sh
$ bash <my path>/jslack/jslack.sh &
```

##### You may want to put this script amongst your startup applications, such that it will run in the background automatically when you start your computer.
