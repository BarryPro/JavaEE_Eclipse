diff $1 $1.diff | wc -l | read num

if(( 0 == $num ))
then
	echo "两个文件一致，核对成功！"
else
	echo "两个文件不一致，核对失败"
fi
