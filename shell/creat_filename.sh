#########################################################################
# File Name: creat_filename.sh
# Author: lina
# mail: 397236853@qq.com
# Created Time: 2016年11月16日 星期三 10时18分45秒
#########################################################################
#!/bin/bash
#!/usr/bin/env sh

echo "Create train.txt"
rm -rf train.txt
#rm -rf list.txt
path='/deep/DataSet/MVCO_103/2006/'
j=0
for dirname in `ls -F | grep /$`
do
   for filename in `find ${
	   dirname
   } -type f -name '*.png'`
   do
          echo "$path${
		  filename
		  }  ${
			  j
		  }" >> train.txt
   done
      j=`expr $j + 1`
	  done
