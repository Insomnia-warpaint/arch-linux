#!/bin/bash

skIsRun=`pgrep -x screenkey`

# 进程 ID 不为空 杀死进程,否则 后台运行进程  & : 表示后台运行 
if [ "$skIsRun" != "" ]; then
	killall -q screenkey
else
	screenkey -p bottom -s small &
fi
