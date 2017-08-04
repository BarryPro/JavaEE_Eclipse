path=$1
ls $path/*.jsp | while read name
do
echo $name 
print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" > $path/$name.bak
print "<html xmlns=\"http://www.w3.org/1999/xhtml\">" >> $path/$name.bak

cat $path/$name >> $path/$name.bak
mv $path/$name.bak $path/$name

done
