<%
/********************
 version v2.0
������: si-tech
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
<title>���֤¼��</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="���֤¼��";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	
	String regionCode= (String)session.getAttribute("regCode");
	
	
	
	String printAcc = request.getParameter("prtAcc");
	String showBody = request.getParameter("showBody");
	/* ��չʾ��Щ��Ϣ
			01��ֻչʾ���֤
			10��ֻչʾ����
			11�����֤�븽����չʾ
	*/
	System.out.println("-------- չʾʲô��Ϣ�� ---------" + showBody);
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
	//ɨ��������֤
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
	tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
	var cre_dir = filep1+":\\custID";//����Ŀ¼
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
				rdShowMessageDialog("ɨ��ɹ���",2);
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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}

function RecogNewIDOnly_one(cardnum)
{
	//ɨ��һ�����֤
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
	tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
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
				
				rdShowMessageDialog("ɨ��ɹ���",2);
								/** ttest **/
				/* ningtn ��·����¼���� */
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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}



function Idcard(cardnum)
{	
	//��ȡ�������֤
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
	tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
	var cre_dir = filep1+":\\custID";//����Ŀ¼
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
					alert("��ȡ�������֤�쳣��");
					
				}
				rdShowMessageDialog("��ȡ�������֤�ɹ���",2);
				/** ttest **/
				var b3 = window.opener.document.getElementById("b3_flag").value ;		
				window.opener.document.getElementById(b3).disabled = false ;
				/* ningtn ��·����¼���� */
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
			rdShowMessageDialog("�����½���Ƭ�ŵ���������");
		}
	}
	else
	{
		IdrControl1.CloseComm();
		rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
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
	<div id="title_zi">��Ϣ¼��</div>
</div>
<table cellspacing="0">
	<tr id="iccidInfo1" style="display:<%=iccidInfoStyle%>;">
		<td class="blue" align="center">��һ��</td>
		<td>
			<input type="button" name="read_idCard_one1" class="b_text"   value="ɨ��һ�����֤" onClick="RecogNewIDOnly_one(1)" >
			<input type="button" name="read_idCard_two1" class="b_text"   value="ɨ��������֤" onClick="RecogNewIDOnly_two(1)">
			<input type="button" name="scan_idCard_two1" class="b_text"   value="����" onClick="Idcard(1)" >	
			<input type="hidden" name="firstId" id="firstId" />
		</td>
	</tr>
	<tr id="iccidInfo2" style="display:<%=iccidInfoStyle%>;">
		<td class="blue" align="center">�ڶ���</td>
		<td>
			<input type="button" name="read_idCard_one2" class="b_text"   value="ɨ��һ�����֤" onClick="RecogNewIDOnly_one(2)" >
			<input type="button" name="read_idCard_two2" class="b_text"   value="ɨ��������֤" onClick="RecogNewIDOnly_two(2)">
			<input type="button" name="scan_idCard_two2" class="b_text"   value="����" onClick="Idcard(2)" >
			<input type="hidden" name="secondId" id="secondId" />
			<br/>
			<font class="orange">ע��ֻ¼��һ�����֤����Ҫʹ�ô˹���</font>
		</td>
	</tr>
	<tr id="accInfo" style="display:<%=accInfoStyle%>;">
		<td class="blue" align="center">����</td>
		<td>
			<input type="button" name="accInfo1" class="b_text"   value="����1" onClick="RecogNewIDOnly_one(3)" >
			<input type="button" name="accInfo2" class="b_text"   value="����2" onClick="RecogNewIDOnly_one(4)">
			<input type="button" name="accInfo3" class="b_text"   value="����3" onClick="RecogNewIDOnly_one(5)" >
			<input type="button" name="accInfo4" class="b_text"   value="����4" onClick="RecogNewIDOnly_one(6)" >
			<input type="hidden" name="accInfoHid1" id="accInfoHid1" />
			<input type="hidden" name="accInfoHid2" id="accInfoHid2" />
			<input type="hidden" name="accInfoHid3" id="accInfoHid3" />
			<input type="hidden" name="accInfoHid4" id="accInfoHid4" />
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center" id="footer"> 
			<input class="b_foot" name=cfmButton type=button value=ȷ�� onclick="saveInfo()">
			<!--
			<input class="b_foot" name=doBackButton type=button value=���� onclick="goBack();">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
			-->
		</td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<!-- ���� handwrite �����ӡ�ؼ� -->
<%@ include file="/npage/innet/pubHWPrint.jsp" %>
</body>
</html>

