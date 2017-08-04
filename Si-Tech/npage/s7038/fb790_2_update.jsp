<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

<head>
<title>身份证录入</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="身份证录入";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	
	String regionCode= (String)session.getAttribute("regCode");
	
	
	
	String printAcc = request.getParameter("prtAcc");
	String showBody = request.getParameter("showBody");
	/* 都展示哪些信息
			01：只展示身份证
			10：只展示附件
			11：身份证与附件都展示
	*/
	System.out.println("-------- 展示什么信息了 ---------" + showBody);
	String iccidInfoStyle = "";
	String accInfoStyle = "";
	if("01".equals(showBody)){
		iccidInfoStyle = "block";
		accInfoStyle = "none";
	}else if("10".equals(showBody)){
		iccidInfoStyle = "none";
		accInfoStyle = "block";
	}else{
		iccidInfoStyle = "block";
		accInfoStyle = "block";
	}
%>

	

<script language="javascript">
	




function RecogNewIDOnly_two(cardnum)
{
	//扫描二代身份证
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//取得系统目录盘符
	var cre_dir = filep1+":\\custID";//创建目录
	if(!fso.FolderExists(cre_dir)) {
		var newFolderName = fso.CreateFolder(cre_dir);
	}
	try{
		if(objIDCard.LibIsLoaded()){
			if(cardnum==1){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid.jpg";
			}else if(cardnum==2){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid2.jpg";
			}
			
			objIDCard.SaveResultFile = true;
			objIDCard.Content = 63;
			if(objIDCard.RecogNewIDCardALL()){
				rdShowMessageDialog("扫描成功！",2);
								/** ttest **/
				var b3 = window.opener.document.getElementById("b3_flag").value ;		
				window.opener.document.getElementById(b3).disabled = false ;
			}			
		}
		else
		{
			rdShowMessageDialog( objIDCard.GetLastErrorInfo(),0 );
		}
	}catch(e){
		rdShowMessageDialog("未连接扫描仪！",0);
	}
}

function RecogNewIDOnly_one(cardnum)
{
	//扫描一代身份证
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//取得系统目录盘符
	var cre_dir = filep1+":\\custID";
	if(!fso.FolderExists(cre_dir)) {
		var newFolderName = fso.CreateFolder(cre_dir);
	}
	try{	
		if( objIDCard.LibIsLoaded() )
		{
			var picpath_n = "";
			if(cardnum==1){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid.jpg";
				picpath_n = cre_dir + "\\print_iccid.jpg";
			}else if(cardnum==2){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid2.jpg";
				picpath_n = cre_dir + "\\print_iccid2.jpg";
			}else if(cardnum==3){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid3.jpg";
				picpath_n = cre_dir + "\\print_iccid3.jpg";
			}else if(cardnum==4){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid4.jpg";
				picpath_n = cre_dir + "\\print_iccid4.jpg";
			}else if(cardnum==5){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid5.jpg";
				picpath_n = cre_dir + "\\print_iccid5.jpg";
			}else if(cardnum==6){
				objIDCard.ImageFileName =  cre_dir + "\\print_iccid6.jpg";
				picpath_n = cre_dir + "\\print_iccid6.jpg";
			}
			
			objIDCard.SaveResultFile = true;
			objIDCard.Content = 63;
			if( objIDCard.RecogIDCardExALL() ){
				
				rdShowMessageDialog("扫描成功！",2);
								/** ttest **/
				/* ningtn 将路径记录下来 */
				if(cardnum==1){
					$("#firstId").val(picpath_n);
				}else if(cardnum==2){
					$("#secondId").val(picpath_n);
				}else if(cardnum==3){
					$("#accInfoHid1").val(picpath_n);
				}else if(cardnum==4){
					$("#accInfoHid2").val(picpath_n);
				}else if(cardnum==5){
					$("#accInfoHid3").val(picpath_n);
				}else if(cardnum==6){
					$("#accInfoHid4").val(picpath_n);
				}
				var b3 = window.opener.document.getElementById("b3_flag").value ;		
				window.opener.document.getElementById(b3).disabled = false ;
			}
		}
		else
		{
			rdShowMessageDialog( objIDCard.GetLastErrorInfo() ,0);
		}
	}catch(e){
		rdShowMessageDialog("未连接扫描仪！",0);
	}
}



function Idcard(cardnum)
{	
	//读取二代身份证
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//取得系统目录盘符
	var cre_dir = filep1+":\\custID";//创建目录
	if(!fso.FolderExists(cre_dir)) {	
		var newFolderName = fso.CreateFolder(cre_dir);  
	}
	
	var picpath_n ;
	if(cardnum==1){
		picpath_n = cre_dir + "\\print_iccid.jpg";
	}else if(cardnum==2){
		picpath_n = cre_dir + "\\print_iccid2.jpg";
	}
	
	
	var result;
	var result2;
	var result3;
	var username;
	
	result=IdrControl1.InitComm("1001");
	if (result==1)
	{
		result2=IdrControl1.Authenticate();
		if ( result2>0)
		{              
			result3=IdrControl1.ReadBaseMsgP(picpath_n); 
			if (result3>0)           
			{
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
				var sex = IdrControl1.GetSex();
				var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
				var IDaddress  =  IdrControl1.GetAddress();
				var idValidDate_obj = IdrControl1.GetValid();
				
				try{
					
					var iccidfile ; 
					var iccidFilePath = "";
					if(cardnum==1){
						iccidfile = fso.CreateTextFile(cre_dir + "\\print_iccid_str.txt",true); 
						iccidFilePath = cre_dir + "\\print_iccid_str.txt";
					}else if(cardnum==2){
						iccidfile = fso.CreateTextFile(cre_dir + "\\print_iccid_str2.txt",true); 
						iccidFilePath = cre_dir + "\\print_iccid_str.txt";
					}
				  iccidfile.WriteLine(name+"|"+code+"|"+IDaddress+"|"+bir_day+"|"+sex+"|"+idValidDate_obj);				  
				  iccidfile.Close();
				}catch(e){
					alert("读取二代身份证异常！");
					
				}
				rdShowMessageDialog("读取二代身份证成功！",2);
				/** ttest **/
				var b3 = window.opener.document.getElementById("b3_flag").value ;		
				window.opener.document.getElementById(b3).disabled = false ;
				/* ningtn 将路径记录下来 */
				if(cardnum==1){
					$("#firstId").val(picpath_n + "|" + iccidFilePath);
				}else if(cardnum==2){
					$("#secondId").val(picpath_n + "|" + iccidFilePath);
				}
				
			}
			else
			{
				rdShowMessageDialog(result3); 
				IdrControl1.CloseComm();
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("请重新将卡片放到读卡器上");
		}
	}
	else
	{
		IdrControl1.CloseComm();
		rdShowMessageDialog("端口初始化不成功",0);
	}
	IdrControl1.CloseComm();
}

function saveInfo(){
	var returnStr = "";
	returnStr = returnStr + $("#firstId").val() + "|";
	returnStr = returnStr + $("#secondId").val() + "|";
	returnStr = returnStr + $("#accInfoHid1").val() + "|";
	returnStr = returnStr + $("#accInfoHid2").val() + "|";
	returnStr = returnStr + $("#accInfoHid3").val() + "|";
	returnStr = returnStr + $("#accInfoHid4").val();
	window.opener.document.getElementById("updateInfo").value = returnStr ;
	window.close();
}
</script>

</head>

<body>
	
<form name="frm"  method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">信息录入</div>
</div>
<table cellspacing="0">
	<tr id="iccidInfo1" style="display:<%=iccidInfoStyle%>;">
		<td class="blue" align="center">第一张</td>
		<td>
			<input type="button" name="read_idCard_one1" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_one(1)" >
			<input type="button" name="read_idCard_two1" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_two(1)">
			<input type="button" name="scan_idCard_two1" class="b_text"   value="读卡" onClick="Idcard(1)" >	
			<input type="hidden" name="firstId" id="firstId" />
		</td>
	</tr>
	<tr id="iccidInfo2" style="display:<%=iccidInfoStyle%>;">
		<td class="blue" align="center">第二张</td>
		<td>
			<input type="button" name="read_idCard_one2" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_one(2)" >
			<input type="button" name="read_idCard_two2" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_two(2)">
			<input type="button" name="scan_idCard_two2" class="b_text"   value="读卡" onClick="Idcard(2)" >
			<input type="hidden" name="secondId" id="secondId" />
			<br/>
			<font class="orange">注：只录入一张身份证不需要使用此功能</font>
		</td>
	</tr>
	<tr id="accInfo" style="display:<%=accInfoStyle%>;">
		<td class="blue" align="center">附件</td>
		<td>
			<input type="button" name="accInfo1" class="b_text"   value="附件1" onClick="RecogNewIDOnly_one(3)" >
			<input type="button" name="accInfo2" class="b_text"   value="附件2" onClick="RecogNewIDOnly_one(4)">
			<input type="button" name="accInfo3" class="b_text"   value="附件3" onClick="RecogNewIDOnly_one(5)" >
			<input type="button" name="accInfo4" class="b_text"   value="附件4" onClick="RecogNewIDOnly_one(6)" >
			<input type="hidden" name="accInfoHid1" id="accInfoHid1" />
			<input type="hidden" name="accInfoHid2" id="accInfoHid2" />
			<input type="hidden" name="accInfoHid3" id="accInfoHid3" />
			<input type="hidden" name="accInfoHid4" id="accInfoHid4" />
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center" id="footer"> 
			<input class="b_foot" name=cfmButton type=button value=确认 onclick="saveInfo()">
			<!--
			<input class="b_foot" name=doBackButton type=button value=返回 onclick="goBack();">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
			-->
		</td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<!-- 加载 handwrite 虚拟打印控件 -->
<%@ include file="/npage/innet/pubHWPrint.jsp" %>
</body>
</html>

