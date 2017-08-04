#!/usr/bin/ksh
##################################################################
#    FTP�ϴ����
#	zhangyan 2012-11-02 14:48:49
##################################################################

. ~/.profile
#ʱ����Ϣ
timeY=`date +%Y`;
timem=`date +%m`;
timed=`date +%d`;
timeH=`date +%H`;
timeM=`date +%M`;
timeS=`date +%S`;

#����������ƴд������ʶ
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

#���Ի��������ļ�·�� ������Ҫע��
#PROFILE=/iwebd2/applications/DefaultWebApp/npage/properties/ftp4A.properties

#�������������ļ�·�� ������Ҫ�ſ�
PROFILE=/webapp/applications/QtWebApp/npage/properties/ftp4A.properties

#���ж�ȡ�ļ�,ÿ�зŵ�����proArr��
cat ${PROFILE}|while read row
do
echo $row
	#ȡÿ�е�һ���ַ�
	CFGINFO=`expr substr $row 1 1`;
	
	#�жϵ�һ���ַ��ǲ���#����ע�����ȡ
	if [[ $CFGINFO -ne "#" ]];then
		#��ȡFTP�����Ϣ
		ftpip=`echo $row|cut -f 1 -d "|"`
		ftpport=`echo $row|cut -f 2 -d "|"`
		ftpusr=`echo $row|cut -f 3 -d "|"`
		ftppwd=`echo $row|cut -f 4 -d "|"`
		ftpdir=`echo $row|cut -f 5 -d "|"`
		localdir=`echo $row|cut -f 6 -d "|"`
		localfile=`echo $row|cut -f 7 -d "|"`
		infId=`echo $row|cut -f 8 -d "|"`
		
		#������־�ļ�,�޸���־�ļ���Ϊ����Լ����ʽ
echo ${localdir}/${infId}.AVL
echo ${localdir}/${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
		
	fi
done
