#!/bin/sh

tmpdir=/tmp/tg-i18n
mkdir $tmpdir

for file in ./input/*
do
  if test -f $file
  then
    filename=`basename $file`
    out=$(file $file | grep UTF-16)
    if [[ "$out" != "" ]];then
      iconv -f UTF-16LE -t UTF-8 ./input/$filename >$tmpdir/$filename
    else
      cp ./input/$filename $tmpdir/$filename
    fi
    sed -i "" 's/正體中文/简体中文/g' $tmpdir/Android_TW.xml
    sed -i "" 's/Traditional (Taiwan)/Simplified/g' $tmpdir/Android_TW.xml
    sed -i "" 's/zh_TW/zh_CN/g' $tmpdir/Android_TW.xml
    out_filename=$(echo $filename|sed 's/TW/CN/')
    opencc -i $tmpdir/$filename -o ./output/$out_filename -c tw2sp.json

    sed -i "" 's/转寄/转发/g' ./output/$out_filename
    sed -i "" 's/国码/国家代码/g' ./output/$out_filename
  fi
done

rm -rf $tmpdir
