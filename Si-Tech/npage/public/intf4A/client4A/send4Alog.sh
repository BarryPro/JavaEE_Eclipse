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
hn=`hostname`;
echo $hn

if [ $hn == "ws1" ] #121����
then
localmach="A"
elif [ $hn == "ws2" ] #122����
then
localmach="B"
elif [ $hn == "ws3" ] #123����
then
localmach="C"
elif [ $hn == "ws4" ] #124����
then
localmach="D"
elif [ $hn == "ws5" ] #125,VIP�ͻ�����ϵͳ����
then
localmach="E"
elif [ $hn == "ws6" ] #126,VIP�ͻ�����ϵͳ����
then
localmach="F"
elif [ $hn == "ALL_T" ] #iwebd2 ���Ի���
then
localmach="T"
fi

#���Ի��������ļ�·�� ������Ҫע��
#PROFILE=/iwebd2/applications/QtWebApp/npage/public/intf4A/properties/ftp4A.properties
#�������������ļ�·�� ������Ҫ�ſ�
PROFILE=/webapp/applications/QtWebApp/npage/public/intf4A/properties/ftp4A.properties

#���ж�ȡ�ļ�,ÿ�зŵ�����proArr��
set -A proArr $( cat ${PROFILE}|while read row; do echo $row; done) ;

#��������proArr
for i in ${proArr[*]}
do
	
	#ȡÿ�е�һ���ַ�
	CFGINFO=`expr substr $i 1 1`;
	
	#�жϵ�һ���ַ��ǲ���#����ע�����ȡ
	if [[ $CFGINFO -ne "#" ]];then
		#��ȡFTP�����Ϣ
		ftpip=`echo $i|cut -f 1 -d "|"`
		ftpport=`echo $i|cut -f 2 -d "|"`
		ftpusr=`echo $i|cut -f 3 -d "|"`
		ftppwd=`echo $i|cut -f 4 -d "|"`
		ftpdir=`echo $i|cut -f 5 -d "|"`
		localdir=`echo $i|cut -f 6 -d "|"`
		localfile=`echo $i|cut -f 7 -d "|"`
		infId=`echo $i|cut -f 8 -d "|"`
		
		#������־�ļ�,�޸���־�ļ���Ϊ����Լ����ʽ
		cat ${localdir}/${infId}.AVL >> ${localdir}/${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
		
		#�ϴ�ftp
		echo "open ${ftpip} ${ftpport}
			user ${ftpusr} ${ftppwd}
			cd ${ftpdir}
			lcd ${localdir}
			prompt off
			mput ${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
			close
			
			bye"|ftp -i -in 
		
		#��ձ�����־
		cat ${localdir}/${infId}.AVL >  ${localdir}/${infId}.AVL 
		
		#ɾ���ϴ������־
		#rm ${localdir}/${infId}${timeY}${timem}${timed}${timeH}${timeM}${timeS}_${localmach}.AVL
	fi
done


