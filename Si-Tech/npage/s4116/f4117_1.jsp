<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:һ����Ž��
   * ����: 2009/4/7
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String workNo=(String)session.getAttribute("workNo");
	StringBuffer  insql = new StringBuffer();

	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	

onload=function()
{		
	self.status="";
	document.frm4117.phoneNo2.disabled = true;
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
	
    self.status="";
    
	if(retType == "checkPwd") //��������У��
	{
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false")
            {
    	    	rdShowMessageDialog("����У��ʧ�ܣ���˶��ֻ������������������룡",0);
	        	frm4117.user_passwd.value = "";
    	    	return false;	        	
            }
            else
            {
				rdShowMessageDialog("��������У��ɹ���",2);
				document.frm4117.phoneNo2.disabled = false;
            }
        }
        else
        {
            rdShowMessageDialog("��������У�����������У�飡",0);
    		return false;
        }
	}
	if(retType == "checkPwd2") //��������У��
	{
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false")
            {
    	    	rdShowMessageDialog("����У��ʧ�ܣ���˶��ֻ������������������룡",0);
	        	frm4117.user_passwd2.value = "";
    	    	return false;	        	
            }
            else
            {
            	rdShowMessageDialog("��������У��ɹ���",2);
            	document.frm4117.doConfirm.disabled = false;
            }
        }
        else
        {
            rdShowMessageDialog("��������У�����������У�飡",0);
    		return false;
        }
	} 
}	


function check_HidPwd()
{
    var Pwd1 = document.all.user_passwd.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("phone_no",document.frm4117.phoneNo1.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function check_HidPwd1()
{
	var Pwd1 = document.all.user_passwd2.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd2");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("phone_no",document.frm4117.phoneNo2.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function commitJsp()
{
	if(((document.all.phoneNo1.value).trim()).length<1)
	{
		rdShowMessageDialog("�����ֻ����벻��Ϊ�գ�");
		return;
	}
	if( document.frm4117.phoneNo1.value.length != 11 )
  	{
	     rdShowMessageDialog("�ֻ�����ֻ����11λ!");
	     document.frm4117.phoneNo1.value = "";
	     return false;
  	}

	if(((document.all.user_passwd.value).trim()).length>0)
    {
        if(document.all.user_passwd.value.length!=6)
        {
            rdShowMessageDialog("�������볤������");
            return false;
        }
    }
    else
    {
        rdShowMessageDialog("�������벻��Ϊ�գ�");
        return false;
    }
    
    if(((document.all.phoneNo2.value).trim()).length<1)
	{
		rdShowMessageDialog("�����ֻ����벻��Ϊ�գ�");
		return;
	}
	if( document.frm4117.phoneNo2.value.length != 11 )
  	{
	     rdShowMessageDialog("�ֻ�����ֻ����11λ!");
	     document.frm4117.phoneNo2.value = "";
	     return false;
  	}
	
    if(((document.all.user_passwd2.value).trim()).length>0)
    {
        if(document.all.user_passwd2.value.length!=6)
        {
            rdShowMessageDialog("�������볤������");
            return false;
        }
    }
    else
    {
        rdShowMessageDialog("�������벻��Ϊ�գ�");
        return false;
    }
	
	frm4117.submit();
}
 		
</script> 
 
<title>һ����Ž��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="f4117Cfm.jsp" method="post" name="frm4117"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">һ����Ž��</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue" nowrap>�����ֻ�����</td>
		<td> 
			<input class="button"type="text" name="phoneNo1" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_phoneNo();">
    	</td>
		<td class="blue">��������</td>
		<td> 
			<jsp:include page="/npage/common/pwd_1.jsp">
		      <jsp:param name="width1" value="16%"  />
		      <jsp:param name="width2" value="34%"  />
		      <jsp:param name="pname" value="user_passwd"  />
		      <jsp:param name="pwd" value="account_passwd"  />
	        </jsp:include>
	        <input name=chkPass1 type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass1" value=У��>
            <font class="orange">*</font>
    	</td>
	</tr>
	<tr>
		<td class="blue">�����ֻ�����</td>
		<td>
			<input class="button" type="text" name="phoneNo2" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_phoneNo();" >
		</td>
		<td class="blue">��������</td>
		<td>
			<jsp:include page="/npage/common/pwd_1.jsp">
		      <jsp:param name="width1" value="16%"  />
		      <jsp:param name="width2" value="34%"  />
		      <jsp:param name="pname" value="user_passwd2"  />
		      <jsp:param name="pwd" value="account_passwd2"  />
	        </jsp:include>
	        <input name=chkPass2 type=button onClick="check_HidPwd1();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
            <font class="orange">*</font>
		</td>
	</tr>			
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="doConfirm" class="b_foot" value="ȷ��" onclick="commitJsp()" disabled>
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="window.location='f4117_1.jsp'">
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>