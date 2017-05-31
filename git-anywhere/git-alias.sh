#!/bin/sh

if [ "$@" = "" ]; then
    echo "Please specific your git parameter."
    exit
fi

BASHRC=/home/$USER/.bashrc

############################################

GIT_EXEC=/usr/bin/git
echo "Git executable path: $GIT_EXEC"
echo "If your git command is not existed in this path, please specify your git command location by editing GIT_EXEC variable."

############################################

LOCATION=/home/$USER/git_alias
DATA=$LOCATION/git_root_dir_data

############################################

if [ "$1" = "check" ]; then
    source $BASHRC
    alias git > /dev/null 2>&1
    CMD_STATUS=$?
    if [ $CMD_STATUS -gt 0 ]; then
        echo "git alias is not configured yet, adding alias..."
        echo "alias git=\"source $LOCATION/$(basename $0)\"" >> $BASHRC
        source $BASHRC
        exit
    fi

    if [ ! -d $LOCATION ]; then
        echo "Creating directory $LOCATION..."
        mkdir -p $LOCATION
    fi

    if [ ! -f $DATA ]; then
        echo "Creating git root working data file..."
        touch $DATA
    fi

fi

############################################

BACK_TITLE="Git root working directory"
TITLE="Git - Working directory"

INPUT=/tmp/menu.sh.$$

WIDTH=90
HEIGHT=35
LINE=20

INDEX=1

show_menu() {
    if [ -s $DATA ]; then
        dialog --backtitle "$BACK_TITLE" --title "$TITLE" --menu "List:" $HEIGHT $WIDTH $LINE \
        $(while read -r L
        do
            if [ "$L" = "" ]; then
                continue
            fi
            echo "$INDEX. $L"
            INDEX=$((INDEX+1)) 
        done < "$DATA") 2>"${INPUT}"

        MENU_VALUE=$(<"${INPUT}")
        MENU_VALUE=$(echo $MENU_VALUE | cut -d'.' -f1)
    
        FILELINE=$(head -n $MENU_VALUE $DATA | tail -1)
            
        if [ "$FILELINE" != "" ]; then
            pushd $FILELINE
            echo "Move to $FILELINE"
        fi
    fi
    $GIT_EXEC $@
    check_location
}

############################################

check_location() {
    GIT_ROOT=`$GIT_EXEC rev-parse --show-toplevel` > /dev/null 2>&1
    GIT_STATUS=$?
    if [ $GIT_STATUS -gt 0 ]; then
        echo "This location is not git working directory."
    else 
        IS_EXISTED=0
        while read -r L
        do
            if [ "$GIT_ROOT" = "$L" ]; then
                IS_EXISTED=1
            fi
        done < "$DATA"

        if [ $IS_EXISTED -eq 0 ]; then
            echo "New git location has been stored."
            echo -e "$GIT_ROOT\n$(cat $DATA)" > $DATA
        fi
    fi
}

############################################

PWD=$(pwd)
echo "Current path: $PWD"

IS_EXISTED=0
while read -r READ
do
    if [ "$PWD" = "$READ" ]; then
        IS_EXISTED=1
        break
    fi
done < "$DATA"

if [ $IS_EXISTED -eq 0 ]; then
    show_menu $@
else
    $GIT_EXEC $@
fi
















