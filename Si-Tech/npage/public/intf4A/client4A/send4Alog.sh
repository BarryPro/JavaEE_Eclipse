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
hn=`hostname`;
echo $hn

if [ $hn == "ws1" ] #121主机
then
localmach="A"
elif [ $hn == "ws2" ] #122主机
then
localmach="B"
elif [ $hn == "ws3" ] #123主机
then
localmach="C"
elif [ $hn == "ws4" ] #124主机
then
localmach="D"
elif [ $hn == "ws5" ] #125,VIP客户管理系统主机
then
localmach="E"
elif [ $hn == "ws6" ] #126,VIP客户管理系统主机
then
localmach="F"
elif [ $hn == "ALL_T" ] #iwebd2 测试环境
then
localmach="T"
fi

#测试环境配置文件路径 上线需要注释
#PROFILE=/iwebd2/applications/QtWebApp/npage/public/intf4A/properties/ftp4A.properties
#生产环境配置文件路径 上线需要放开
PROFILE=/webapp/applications/QtWebApp/npage/public/intf4A/properties/ftp4A.properties

#按行读取文件,每行放到数组proArr中
set -A proArr $( cat ${PROFILE}|while read row; do echo $row; done) ;

#遍历数组proArr
for i in ${proArr[*]}
do
	
	#取每行第一个字符
	CFGINFO=`expr substr $i 1 1`;
	
	#判断第一个字符是不是#不是注释则读取
	if [[ $CFGINFO -ne "#" ]];then
		#读取FTP相关信息
		ftpip=`echo $i|cut -f 1 -d "|"`
		ftpport=`echo $i|cut -f 2 -d "|"`
		ftpusr=`echo $i|cut -f 3 -d "|"`
		ftppwd=`echo $i|cut -f 4 -d "|"`
		ftpdir=`echo $i|cut -f 5 -d "|"`
		localdir=`echo $i|cut -f 6 -d "|"`
		localfile=`echo $i|cut -f 7 -d "|"`
		infId=`echo $i|cut -f 8 -d "|"`
		
		#复制日志文件,修改日志文件名为安氏约定格式
		cat ${localdir}/${infId}.AVL >> ${localdir}/${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
		
		#上传ftp
		echo "open ${ftpip} ${ftpport}
			user ${ftpusr} ${ftppwd}
			cd ${ftpdir}
			lcd ${localdir}
			prompt off
			mput ${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
			close
			
			bye"|ftp -i -in 
		
		#清空本地日志
		cat ${localdir}/${infId}.AVL >  ${localdir}/${infId}.AVL 
		
		#删除上传后的日志
		#rm ${localdir}/${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
	fi
done


