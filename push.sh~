#!/bin/bash
# copyright

comment=

push (){
        #git add .
        #git commit -am $comment
        echo "ok for $comment"
}
while getopts "c:" option
do
        case $option in
        c) 
                comment=$OPTARG
                ;;
        esac
done
# if comment is empty 
if [[ -z "$comment" ]]; then
echo "I don't know what you are asking for 
usage ./push.sh -c [comment]"
else
        push
fi 



