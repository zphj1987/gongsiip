#! /bin/sh
a=`curl http://ipecho.net/plain;echo`
nowtime=`date +%Y%m%d%H%M`
echo "ip更新时间$nowtime" >/ip/gongsiip/nowip
echo "$a" >>/ip/gongsiip/nowip
while true
do
sleep 30
nowip=`curl http://ipecho.net/plain;echo`
oldip=`tail -n 1 /ip/gongsiip/nowip`
if [ $nowip != $oldip ];
then
    b=`curl http://ipecho.net/plain;echo`
    nowtime=`date +%Y%m%d%H%M`
    echo "ip更新时间$nowtime" >/ip/gongsiip/nowip
    echo "$a" >>/ip/gongsiip/nowip
    cd /ip/gongsiip/
    git add nowip
    git commit -m "`date`"
    git push
    cd /
fi

done
