#!/usr/bin/sh

## 传入两个参数，判断文件/文件夹是否存在
## -d 文件夹是否存在
## -f 文件是否存在
## -L 链接文件是否存在
## -x 可执行文件夹/文件是否存在
## -X 可执行文件是否存在
isexists()
{
    case $2 in

    '-d')

        if [[ -d $1 ]]; then

            return '1'

        else

            return '0'
        fi

    ;;

    '-f')

        if [[ -f $1 ]]; then

            return '1'

        else

            return '0'
        fi

    ;;

    '-L')

        if [[ -L $1 ]]; then

            return '1'

        else

            return '0'
        fi

    ;;


    '-x')

        if [[ -x $1 ]]; then

            return '1'

        else

            return '0'
        fi

    ;;

    '-X')

        if [[ -x $1 ]] && [[ -f $1 ]]; then

            return '1'

        else

            return '0'
        fi

    ;;

    esac
}

## 传入一个参数
## 目录是否为空，有三种返回结果
## 目录不存在返回 255
## 目录为空返回0 否则返回其他数
isempty()
{

    isexists $1 "-d"
    if [[ '0' -eq $? ]]; then return 255; fi
    isempty_count=`ls -1 $1 | wc -l`
    return ${isempty_count}
}

## 传入一个参数
## 判断文件夹下是否存在可执行文件
## 存在返回1 否则返回0
childisexec()
{
    isempty "$1"

    if [[ '0' -eq $? ]] || [[ '255' -eq $? ]]; then
        return '0'
    fi


    for ex in `ls -1 $1`;
    do
        echo "$1/${ex}"
        isexists "$1/${ex}" "-X"
        if [[ '1' -eq $? ]]; then return '1'; fi
    done

    return '0'
}
