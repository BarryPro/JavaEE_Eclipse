diff $1 $1.diff | wc -l | read num

if(( 0 == $num ))
then
	echo "�����ļ�һ�£��˶Գɹ���"
else
	echo "�����ļ���һ�£��˶�ʧ��"
fi
