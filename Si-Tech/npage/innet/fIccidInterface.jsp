<%
	/**************************** handwrite start **************************/
	String iccidPasPropPath = request.getRealPath("npage/innet/configFtpIccidPas.properties");
	System.out.println("------------------iccidPasPropPath----------"+iccidPasPropPath);
	String iccidFtpPwd = getIccidFtpPas(iccidPasPropPath);
	System.out.println("------------------iccidFtpPwd   getPas()----------"+iccidFtpPwd);
	/**************************** handwrite end   **************************/
%>

<SCRIPT type="text/javascript">
/********************  iccid print start ****************************/
function doIccidPrint(){
	var print_Packet = new AJAXPacket("../public/fPubSavePrint.jsp","正在打印，请稍候......");
	print_Packet.data.add("retType","print");
	print_Packet.data.add("opCode",'<%=opCode%>');
	print_Packet.data.add("phoneNo",'<%=phoneNo%>');
	print_Packet.data.add("billType",'<%=billType%>');
	print_Packet.data.add("login_accept",'<%=login_accept%>');
	core.ajax.sendPacket(print_Packet,getdoIccidPrint);
	print_Packet=null;
}
function getdoIccidPrint(packet){
	
  var retCode = packet.data.findValueByName("errCode"); 
  var retMessage = packet.data.findValueByName("errMsg");	
  var fColor = 0*65536+0*256+0;
	if(retCode=="000000"){
  		var impResultArr = packet.data.findValueByName("impResultArr");
			try{
				//打印初始化
				printctrl.Setup(0);
				printctrl.StartPrint();
				printctrl.PageStart();
				
				for(var i=0;i<impResultArr.length;i++){
							if(impResultArr[i][6]=="N"){
								 impResultArr[i][6]=0
							}else{
								 impResultArr[i][6]=5
							}
					printctrl.PrintEx(parseInt(impResultArr[i][3]),parseInt(impResultArr[i][2]),impResultArr[i][12],parseInt(impResultArr[i][4]),fColor,impResultArr[i][6],impResultArr[i][11],impResultArr[i][10]);
				}
				
				doIccidDownLoad("download");//下载身份证
				//打印结束
				printctrl.PageEnd();
				printctrl.StopPrint();
				doIccidDownLoad("delete");//删除身份证
				
		  }catch(e){
		  	alert(e);
		  }finally{
				//返回打印确认信息
				var cfmInfo = "<%=submitCfm%>";
				var retValue = "";
				if(cfmInfo == "Yes")
				{	retValue = "confirm";	}
				window.returnValue= retValue;
				window.close(); 
			}
  } else{
    alert("错误代码："+retCode+"错误信息："+retMessage);
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;     
		window.close(); 
  }
}
function doIccidDownLoad(retType){
	var print_Packet = new AJAXPacket("fIccidDownLoad.jsp","正在下载，请稍候......");
	print_Packet.data.add("retType",retType);
	print_Packet.data.add("phoneNo","<%=phoneNo%>");
	print_Packet.data.add("ftpPwd","<%=iccidFtpPwd%>");
	core.ajax.sendPacket(print_Packet,getdoIccidDownLoad,false);
	print_Packet=null;
}
function getdoIccidDownLoad(packet){
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("errCode"); 
  var retMessage = packet.data.findValueByName("errMsg");  
  
  if(retType=="download"){
  	var idType = packet.data.findValueByName("idType");
		var custName = packet.data.findValueByName("custName"); 
	  var custSex = packet.data.findValueByName("custSex");
	  var custBirthday = packet.data.findValueByName("custBirthday");
		var custAddress = packet.data.findValueByName("custAddress"); 
	  var custIccid = packet.data.findValueByName("custIccid") ;
  	if(retCode=="000000"){
  		var dir = iccidDownFromWebService("download");
  		//ttest
  		if(idType == "1代"){
				printctrl.DrawImage(dir,114,4,186,49);
				//printctrl.DrawImage(dir,114,54,186,99);	
  		}else if(idType == "2代"){
				printctrl.DrawImage(dir,160,10,180,35);
				printctrl.PrintEx(127,3,"黑体",8,0,0,0,custName);
				printctrl.PrintEx(127,5,"黑体",8,0,0,0,custSex);
				printctrl.PrintEx(127,7,"黑体",8,0,0,0,custBirthday);				
				var address = custAddress;
				for(var i=0;i<(address.length/12);i++){
					printctrl.PrintEx(127,9+i,"黑体",8,0,0,0,address.substr(i*12,(i+1)*12));
				}
				printctrl.PrintEx(127,13,"黑体",8,0,0,0,custIccid);
				
				/*printctrl.DrawImage(dir,160,60,180,85);
				printctrl.PrintEx(127,21,"黑体",8,0,0,0,custName);
				printctrl.PrintEx(127,23,"黑体",8,0,0,0,custSex);
				printctrl.PrintEx(127,24,"黑体",8,0,0,0,custBirthday);				
				var address = custAddress;
				for(var i=0;i<(address.length/12);i++){
					printctrl.PrintEx(127,27+i,"黑体",8,0,0,0,address.substr(i*12,(i+1)*12));
				}
				printctrl.PrintEx(127,31,"黑体",8,0,0,0,custIccid);*/
				
				
  		}
	  }else if(retCode=="000001"){
	  	rdShowMessageDialog("无用户身份证录入记录，打印时不显示身份证信息！", 3);
	  }else{
	  	rdShowMessageDialog("ftp下载身份证信息失败<br/>错误代码："+retCode+"<br/>错误信息："+retMessage, 0);
	  }
  }else if(retType="delete"){
  	if(retCode=="000000"){
  		iccidDownFromWebService("delete");
  	}else if(retCode=="000001"){
  		
	  }else{
	  	rdShowMessageDialog("ftp删除身份证信息失败<br/>错误代码："+retCode+"<br/>错误信息："+retMessage, 0);
	  }  	
  }  
}
function iccidDownFromWebService(oprType){
	try{
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	}catch(e){
		rdShowMessageDialog("请设置客户端安全性",0);
		return false;
	}
	if(fso!=undefined)
	{
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var iccid_photo_dir = filep1+":\\iccid_photo.jpg";
		if(oprType=="download"){
			var iccidret1 = virtualprint.LoadFileEx("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/npage/cust_ID/<%=phoneNo%>_<%=work_no%>.jpg","jpg",0,0);
			var iccidret2 = virtualprint.SaveTo(iccid_photo_dir,"jpg",0);
			if(iccidret1!=1 || iccidret2!=1){
				rdShowMessageDialog("web下载身份证信息失败！<br/>ret1："+ret1+"<br/>ret2："+ret2,0);
			}
			return iccid_photo_dir;
		}else if(oprType=="delete"){
			
			f1 = fso.GetFile(iccid_photo_dir);
			f1.Delete();
			return true;
		}		
	}else{
		rdShowMessageDialog("取系统文件对象 Scripting.FileSystemObject 失败",0);
		return false;
	}
}
/********************  iccid print end ****************************/
</SCRIPT>