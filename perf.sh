#!/bin/sh

if [ $# -ne 2 ];then
echo "Usage: $0 seconds $1 process"
exit 1
fi

sudo rm -f perf.data perf.unfold perf.folded perf.svg
sleep 1

PID=`ps -ef | grep "$2" | awk '{print $2}' | tail -n 1`
echo $PID
sudo perf record -e cpu-clock -g -p $PID &

PERF_PID=`ps aux| grep "perf record"| grep -v grep| awk '{print $2}'`

if [ -n "$PERF_PID" ]; then
sleep $1
sudo kill -s INT $PERF_PID
fi
echo "perf exit"
# wait until perf exits

#while [ ! -s "./perf.data" ]; do
#sleep 1
#echo "wait for perf.data"
#done
#sleep 5

#sudo perf script -i perf.data &> perf.unfold
#echo "perf.unfold"
#sudo /home/ubuntu/FlameGraph/stackcollapse-perf.pl perf.unfold &> perf.folded
#echo "perf.folded"
#sudo /home/ubuntu/FlameGraph/flamegraph.pl perf.folded >perf.svg
