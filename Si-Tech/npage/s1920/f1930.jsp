<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.14
 ģ��:ͳһ��ѯ�˶�
********************/
%>
<%
/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2004-01-31
* revised : 2004-01-31
*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=gbk"%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ͳһ��ѯ�˶�</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("activePhone");
    
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String login_passwd = (String)session.getAttribute("password");
	String ip_address = (String)session.getAttribute("ipAddr");
	String accountType = (String)session.getAttribute("accountType");
	String regionCode = (String)session.getAttribute("regCode");
		
%>
 	
<script language=javascript>

<!--
//����Ӧ��ȫ�ֵı���
var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
var YE_SUCC_CODE = "000000";		//����Ӫҵϵͳ������޸�
var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

onload=function()
{		
	getUserInfo();
}

//---------1------RPC������------------------
function doProcess(packet){
	//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	self.status="";
	if(verifyType=="phoneno"){
		if( parseInt(error_code) == 0 ){
			var custname= packet.data.findValueByName("custname");
			var runcode= packet.data.findValueByName("runcode");
			var brand=packet.data.findValueByName("brand");
			document.all.value201.value=blurring(custname);
			document.all.runname.value=runcode;
			document.form1.qryPage.disabled=false;
		}
		else{
			rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
			return false;
		}
	}
	
}


/**
 ** ģ�����ͻ�����
 ** ����
 ** ������ �ڶ����� *
 ** ������ �������� *
 ** �ĸ��� ǰ�������� ������ **
 ** �ĸ������ϣ�ǰ������������������ **
 ** hejwa 2017/3/20 ����һ 10:02:45 
 **/
function blurring(custName){
	var ret_S = "";
	if(custName.length==2){
		ret_S = custName.substring(0,1)+"*";
	}
	
	if(custName.length==3){
		ret_S = custName.substring(0,1)+"**";
	}
	
	if(custName.length==4){
		ret_S = custName.substring(0,2)+"**";
	}
	
	if(custName.length>4){
		ret_S = custName.substring(0,2)+"******";
	}
	
	return ret_S;
}

//��֤���ύ����
function doCfm()
{ 
	if(!check(document.form1))
	{
		document.form1.phoneNo.value = "";
		return false;
	}
	form1.action="f1930_info.jsp";
	form1.submit();
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
        TempChar= InString.substring (Count, Count+1);
        if (RefString.indexOf (TempChar, 0)==-1)  
        return (false);
}
return (true);
}

function getUserInfo()
{
		
		if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
			rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
			document.form1.phoneNo.focus();
			return false;
		}
		else if (parseInt(document.form1.phoneNo.value.substring(0,2),10)!=15 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=18 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=14 && (parseInt(document.form1.phoneNo.value.substring(0,3),10)<134 || parseInt(document.form1.phoneNo.value.substring(0,3),10)>139)){
			rdShowMessageDialog("������134-139,��15,14,18��ͷ���ֻ�����!!");
			document.form1.phoneNo.focus();
			return false;
		}
	
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","����ȷ�ϣ����Ժ�......");
	
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form1.phoneNo.value);
		    	    
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;	  	
	  		
	}
 
//-->
</script>
</head>
<body>
<form name="form1" method="POST">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

    <table cellspacing="0">
    <tr> 
      <td class="blue"><div>�ֻ�����</div></td>
      <td colspan="3"> 
        <input type="text" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" maxlength="11" onKeyDown="if(event.keyCode==13)document.all.accountpassword.focus()" onKeyPress="return isKeyNumberdot(0)" readOnly>
      </td>
    </tr>                        
    <tr> 
      <td class="blue"><div>�û�����</div></td>
      <td>
        <input type="hidden" class="InputGrey" readonly name="code201" value="201">
        <input type="text"  class="InputGrey" readonly name="value201" value="">
      </td>
      <td class="blue"><div>����״̬</div></td>
      <td>
        <input type="text" class="InputGrey" readonly name="runname" value="">
      </td>
    </tr> 
 	 <tr>
    	<td colspan="4" id="footer">
      	<div align="center">
          <input class="b_foot" type=button name=qryPage value="��ѯ" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}" disabled>
          <input class="b_foot" type=button name=back value="���" onClick="form1.reset()">
		  <input class="b_foot" type=button name=qryPage1 value="�ر�" onClick="removeCurrentTab()">
        </div>
      </td>
    </tr>
  </table>
 
  <input name="org_code" type="hidden" value="<%=org_code%>">
  <input name="work_no" type="hidden" value="<%=work_no%>">
  <input name="login_passwd" type="hidden" value="<%=login_passwd%>">
  <input name="ip_address" type="hidden" value="<%=ip_address%>">
  <input name="loginName" type="hidden" value="<%=loginName%>">
    <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
