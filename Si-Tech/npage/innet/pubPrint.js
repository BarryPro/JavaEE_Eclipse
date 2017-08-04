//-------引入打印控件----------
<OBJECT
	  classid="clsid:38B67330-98BD-48AE-A0B0-F00A17737EAF"
	  codebase="<%=request.getContextPath()%>/ocx/printctrl.dll#version=1,0,11,0"
	  name="printctrl"
	  align=center
	  hspace=0
	  vspace=0
>
</OBJECT>

function doPrint(printInfo)
{
	//打印初始化
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var chPos = -1;
	var tempObj = new Array(5);
	var temp;
	var strLen,fontSize,fontStyle;
	var printStr,InfoStr; 
	infoStr = printInfo;
	strLen = infoStr.length;
	while(strLen > 0)
	{
		for(i=0;i<5;i++)
		{
			chPos = infoStr.indexOf("|");
			tempObj[i] = infoStr.substring(0,chPos);
			infoStr = infoStr.substring(chPos + 1);
		}
		printctrl.Print(1*tempObj[0],1*tempObj[1],1*tempObj[2],1*tempObj[3],tempObj[4]);
		strLen = infoStr.length;
	}

	//打印结束
	printctrl.PageEnd();
	printctrl.StopPrint();

	window.close(); 
}