#!/bin/bash -e
#copy ssh keys and git configuration
cp -R ~/.ssh/ ./.docker/ssh/
cp ~/.gitconfig .docker/git/.gitconfig
cp .docker/fig/fig_dev.yml ./fig.yml

OS=${OS:-`uname`};
if [ "$OS" = 'Darwin' ]
then
    OUTER_IP=$(/sbin/ifconfig en1|grep inet|head -2|sed 's/\:/ /'|awk '{print $2}'|tail -1);
    echo "intento con en1 $OUTER_IP"
    if [ "$OUTER_IP" = "" ];then
    OUTER_IP=$(/sbin/ifconfig en0|grep inet|head -2|sed 's/\:/ /'|awk '{print $2}'|tail -1);
    echo "intento con en0 $OUTER_IP"
    fi
    sed -i '' "s/REPLACE_OUTERIP/$OUTER_IP/g" fig.yml
else    
    OUTER_IP=$(/sbin/ifconfig eth0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'|tail -1);
    if [ "$OUTER_IP" = "" ];then
        OUTER_IP=$(/sbin/ifconfig eth1|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'|tail -1);
    fi
    if [ "$OUTER_IP" = "" ];then
        OUTER_IP=$(/sbin/ifconfig wlan0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'|tail -1);
    fi
    sed -i "s/REPLACE_OUTERIP/$OUTER_IP/g" fig.yml
fi 
docker build -t andresroot/bigvasp ./.docker/
fig up