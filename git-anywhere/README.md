# GIT ANYWHERE

A simple alias that intercepts your 'git' command invocation and keeps track of root working dirs that you have been using. Invoking git outside a valid working dir will result in a popup for selecting one of the previously used dirs.

Install:
```bash
$ mkdir -p /home/$USER/git_alias/; wget -O /home/$USER/git_alias/git-alias.sh https://raw.githubusercontent.com/nick4ever/bashket/master/git-anywhere/git-alias.sh; cd /home/$USER/git_alias/ && chmod +x git-alias.sh && sh git-alias.sh @install
```

Have fun!
