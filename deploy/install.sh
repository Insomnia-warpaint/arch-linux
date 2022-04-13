#!/usr/bin/sh

source ./config.sh
source lib/util.sh
source lib/core.sh


case $1 in

   '--run')

       run "${TarArr[*]}" "${#TarArr[@]}" "${HomeArr[*]}" "${#HomeArr[@]}" "${DirNameArr[*]}" "${#DirNameArr[@]}" "${BinArr[*]}" "${#BinArr[@]}"
       
    ;;

   '--extra')
       if [[ $2 = "all" ]]; then
			
           extractive "${TarArr[*]}" "${HomeArr[*]}" "${DirNameArr[*]}" "${BinArr[*]}" "${#TarArr[@]}"
           exit 1
       fi
       case_extra $2

       ;;

   '--build')
	
       if [[ $2 = "all" ]]; then
			
           build_application "${TarArr[*]}" "${HomeArr[*]}" "${DirNameArr[*]}" "${BinArr[*]}" "${#TarArr[@]}"
           exit 1
       fi
       case_build $2

       ;;

   *)
       echo "$0 {--run} or [{--extra|--build} ${ITEM}]" >&2
esac


