#!/usr/bin/ksh
##################################################################
#    FTP上传组件
#	zhangyan 2012-11-02 14:48:49
##################################################################

. ~/.profile
#时间信息
timeY=`date +%Y`;
timem=`date +%m`;
timed=`date +%d`;
timeH=`date +%H`;
timeM=`date +%M`;
timeS=`date +%S`;

#根据主机名拼写主机标识
hn=`hostname`

if [ $hn == "ws1" ]
then
localmach="A"
elif [ $hn == "ws2" ] 
then
localmach="B"
elif [ $hn == "ws3" ] 
then
localmach="C"
elif [ $hn == "ws4" ] 
then
localmach="D"
elif [ $hn == "ws5" ] 
then
localmach="E"
elif [ $hn == "ws6" ] 
then
localmach="F"
elif [ $hn == "ALL_T" ] 
then
localmach="T"
fi

#测试环境配置文件路径 上线需要注释
#PROFILE=/iwebd2/applications/DefaultWebApp/npage/properties/ftp4A.properties

#生产环境配置文件路径 上线需要放开
PROFILE=/webapp/applications/QtWebApp/npage/properties/ftp4A.properties

#按行读取文件,每行放到数组proArr中
cat ${PROFILE}|while read row
do
echo $row
	#取每行第一个字符
	CFGINFO=`expr substr $row 1 1`;
	
	#判断第一个字符是不是#不是注释则读取
	if [[ $CFGINFO -ne "#" ]];then
		#读取FTP相关信息
		ftpip=`echo $row|cut -f 1 -d "|"`
		ftpport=`echo $row|cut -f 2 -d "|"`
		ftpusr=`echo $row|cut -f 3 -d "|"`
		ftppwd=`echo $row|cut -f 4 -d "|"`
		ftpdir=`echo $row|cut -f 5 -d "|"`
		localdir=`echo $row|cut -f 6 -d "|"`
		localfile=`echo $row|cut -f 7 -d "|"`
		infId=`echo $row|cut -f 8 -d "|"`
		
		#复制日志文件,修改日志文件名为安氏约定格式
echo ${localdir}/${infId}.AVL
echo ${localdir}/${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
		
	fi
done
