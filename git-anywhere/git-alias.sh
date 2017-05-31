#!/bin/sh
BASHRC=/home/$USER/.bashrc
GIT_EXEC=`which git --skip-alias`
LOCATION=/home/$USER/git_alias
DATA=$LOCATION/git_root_dir_data

############################################

install() {
    source $BASHRC
    alias git > /dev/null 2>&1
    CMD_STATUS=$?
    if [ $CMD_STATUS -gt 0 ]; then
        echo "git alias is not configured yet, adding alias..."
        echo "alias git=\"source $LOCATION/$(basename $0)\"" >> $BASHRC
        source $BASHRC
    fi

    if [ ! -d $LOCATION ]; then
        echo "Creating directory $LOCATION..."
        mkdir -p $LOCATION
    fi

    if [ ! -f $DATA ]; then
        echo "Creating git root working data file..."
        touch $DATA
    fi
}

if [ "$1" = "@install" ]; then
    install
elif [ "$1" = "clone" ]; then
    $GIT_EXEC "$@"
else

    BACK_TITLE="Git root working directory"
    TITLE="Git - Working directory"

    INPUT=/tmp/menu.sh.$$

    WIDTH=90
    HEIGHT=15
    LINE=10

    INDEX=1

    GIT_ROOT=`$GIT_EXEC rev-parse --show-toplevel 2>&1`
    GIT_STATUS=$?

    if [ $GIT_STATUS -gt 0 ]; then
        
        if [ -s $DATA ]; then
            
            DIRS=`cat $DATA | sed ':a;N;$!ba;s/[\n]\+/ /g' | sed 's/^ //' | sed 's/ $//' | sed 's/ / . /g'`
            echo $DIRS
            dialog --backtitle "$BACK_TITLE" --title "$TITLE" --menu "Select a previously used git working dir:" $HEIGHT $WIDTH $LINE $DIRS . 2>$INPUT
            
            MENU_VALUE=`cat $INPUT`
            rm $INPUT

            clear
            cd $MENU_VALUE
            echo "* GIT ANYWHERE: Moved to -> $MENU_VALUE"
            echo
            
            $GIT_EXEC "$@"
        else
            echo "* GIT ANYWHERE failed to help. You are invoking git out side a working dir and NO working history logged."
            echo "$GIT_ROOT"
        fi
    else 
        IS_EXISTED=0
        while read -r L
        do
            if [ "$GIT_ROOT" = "$L" ]; then
                IS_EXISTED=1
            fi
        done < "$DATA"

        if [ $IS_EXISTED -eq 0 ]; then
            echo "* GIT ANYWHERE: New git location has been stored."
            echo -e "$GIT_ROOT\n$(cat $DATA)" > $DATA
        fi
        
        $GIT_EXEC "$@"
    fi


fi


