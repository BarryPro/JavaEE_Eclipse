#!/usr/bin/ksh
##################################################################
#      发4A操作日志 接口ID AAAA01
#	zhangyan 2011-6-29 11:20:23
##################################################################

. ~/.profile
#正式环境
#FTP_IP=10.110.16.234
#FTP_PORT=21
#FTP_USER=hdboss
#FTP_PW=xianjiu10
#FTP_DIR=/SEND/MON_FULL
#LOCAL_DIR=/icrmd2/work/zhangyan/viprpt

#测试环境
FTP_IP=10.110.0.166
FTP_PORT=21
FTP_USER=crmjk
FTP_PW=crmjk
FTP_DIR=/opt/crmjk
LOCAL_DIR=/webapp/applications/QtWebApp/npage/se269

INTF_ID='AAAA02'

export FTP_IP;
export FTP_PORT;
export FTP_USER;
export FTP_PW;
export FTP_DIR;
export LOCAL_DIR;
export INTF_ID;
mnt=$( expr `date +%M` - 10 )
hour=$( expr `date +%H` )
#mnt=10
#hour=15

if [ "$mnt" -le 0 ]
then mnt="50"
hour=$( expr `date +%H` - 1)
fi 

DAT=$( expr `date +%Y%m%d`)

#-----------------------------------------------
echo "open ${FTP_IP} ${FTP_PORT}
      user ${FTP_USER} ${FTP_PW}
      cd ${FTP_DIR}
      lcd /${LOCAL_DIR}
      prompt off
      mput ${INTF_ID}${DAT}${hour}${mnt}00.AVL
      close

      bye"|ftp -i -in
