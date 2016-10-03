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
    sed -i "" 's/志工/志愿者/g' ./output/$out_filename
    sed -i "" 's/国码/国家代码/g' ./output/$out_filename
    sed -i "" 's/请选择聊天对象开始传讯/请选择好友开始聊天/g' ./output/$out_filename
    sed -i "" 's/图档/图片/g' ./output/$out_filename
    sed -i "" 's/撰写/编写/g' ./output/$out_filename
    sed -i "" 's/盘案/档案/g' ./output/$out_filename
    sed -i "" 's/按下 Enter 键就送出消息/按下 Enter 键发送消息/g' ./output/$out_filename
    sed -i "" 's/按下 Ctrl+Enter 键才送出消息/按下 Ctrl+Enter 键发送消息/g' ./output/$out_filename
    sed -i "" 's/发送消息透过 Cmd+Enter 键/按下 Cmd+Enter 键发送消息/g' ./output/$out_filename
    sed -i "" 's/不要问每个文件的下载路径/不要询问每个文件的下载路径/g' ./output/$out_filename
    sed -i "" 's/铺排/平铺/g' ./output/$out_filename
    sed -i "" 's/语音频息/语音消息/g' ./output/$out_filename
    sed -i "" 's/在在线/在线/g' ./output/$out_filename
    sed -i "" 's/TCP 如果可用或 HTTP/TCP 或 HTTP/g' ./output/$out_filename
    sed -i "" 's/HTTP 用自订 http-代理/HTTP 代理/g' ./output/$out_filename
    sed -i "" 's/TCP 用自订 socks5-代理/SOCKS5 代理/g' ./output/$out_filename
    sed -i "" 's/用户名称/用户名/g' ./output/$out_filename
    sed -i "" 's/{transport} 用代理方式/通过 {transport} 代理访问/g' ./output/$out_filename
    sed -i "" 's/恢复为英文接口/恢复为英文/g' ./output/$out_filename
    sed -i "" 's/作用中的连接/登陆中的设备/g' ./output/$out_filename
    sed -i "" 's/中断所有其他连接/注销所有其他设备/g' ./output/$out_filename
    sed -i "" 's/则将会从设备中被移除/则将会从设备中移除/g' ./output/$out_filename
  fi
done

rm -rf $tmpdir
