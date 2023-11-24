#!/bin/bash

total=128
num=20000000
threadnum=32
datasize=16

redis_start() {
  count=0
  while [ $count -lt $total ]
  do
    count=`expr $count + 1`
    port=`expr $count + 6379`
    echo $port
    redis-server --port $port > /dev/null 2>&1 &
  done
}

redis_set() {
  count=0
  while [ $count -lt $total ]
  do
    count=`expr $count + 1`
    port=`expr $count + 6379`
    echo $port
    log="log/set_${datasize}_${port}.log"
    current_time=`date '+%Y-%m-%d %H:%M:%S'`
    echo $current_time > $log
    nohup redis-benchmark -p $port -t set -n $num -c $threadnum -d $datasize -r $num -P 8 -k 1 >> $log 2>&1 &
  done
}

redis_get() {
  count=0
  while [ $count -lt $total ]
  do
    count=`expr $count + 1`
    port=`expr $count + 6379`
    echo $port
    log="log/get_${datasize}_${port}.log"
    current_time=`date '+%Y-%m-%d %H:%M:%S'`
    echo $current_time > $log
    nohup redis-benchmark -p $port -t get -n $num -c $threadnum -d $datasize -r $num -P 8 -k 1 >> $log 2>&1 &
  done
}

redis_stop() {
  ps aux | grep 'redis-server' | grep -v 6379 | awk '{print $2}' | xargs -i kill {}
}

set_test() {
  redis_stop
  sleep 5
  redis_start
  sleep 2
  redis_set
}

get_test() {
  redis_get
}

test() {
  set_test
  sleep 1
  while [ 1 ]
  do
    bench_num=`ps aux | grep redis-benchmark | wc -l`
    if [ $bench_num -eq 1 ]; then
      break
    fi
    sleep 2
    echo "wait set"
  done
  sleep 10
  get_test
  sleep 1
  while [ 1 ]
  do
    bench_num=`ps aux | grep redis-benchmark | wc -l`
    if [ $bench_num -eq 1 ]; then
      break
    fi
    sleep 2
    echo "wait get"
  done
  sleep 10
}

datasize=16
test

datasize=32
test

datasize=64
test

datasize=128
num=4000000
test

datasize=256
num=4000000
test
