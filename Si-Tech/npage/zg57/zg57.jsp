<%
/********************
 version v2.0
 ������: si-tech
 ����: 
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>�������������ܺ������ۺ�����</title>
<%
	
    String opCode = "zg57";
    String opName = "������ϢͶ�߹ػ�";
//    String opCode=request.getParameter("opCode");
//    String opName=request.getParameter("opName");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	/*liujian 2012-6-19 10:09:24 ��������������� begin*/
	String netImport = request.getParameter("netImport");
	if(netImport == null) {
		netImport = "";
	}
	/*liujian 2012-6-19 10:09:24 ��������������� end*/
	String wjpldr = request.getParameter("wjpldr");
	if(wjpldr == null) {
		wjpldr = "";
	}
	String printAccept="";
	printAccept = getMaxAccept();
    
%>


</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	var phoneNo = "";


	opchange();

}

function controlButt(subButton)
{
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}


//----------------��֤���ύ����-----------------
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
	{
		 rdShowMessageDialog("�������ֻ�����!");
		 document.frm.phoneNo.focus();
		 return false;
	}

  	if( document.frm.phoneNo.value.length == 11 || document.frm.phoneNo.value.length == 12 ) {
		return true;
	}
  	else {
		rdShowMessageDialog("�ֻ����������11λ����12λ!");
		document.frm.phoneNo.value = "";
		return false;
  	}
}

function doCfm()
{

	var radio1 = document.getElementsByName("opFlag");
  	for(var i=0;i<radio1.length;i++)
  	{
    	if(radio1[i].checked)
		{
	  		var opFlag = radio1[i].value;
	  		if(opFlag=="one")
	  		{
	    		if(document.frm.phoneNo.value=="")
			  	{
				     rdShowMessageDialog("�������ֻ�����!");
				     document.frm.phoneNo.focus();
				     return false;
			  	}
				if(!check_HidPwd()) {
					return false;
				}

		  	}
		}
 	}
 	
  	var radio2 = document.getElementsByName("opFlag");
  	for(var i=0;i<radio2.length;i++)
  	{
    	if(radio2[i].checked)
		{
	  		var opFlag = radio2[i].value;
	  		if(opFlag=="one")
	  		{
	    		frm.action="zg57_1.jsp";
		  	}
		  	else if(opFlag=="two"){
		  	  frm.action="zg57_2.jsp";
		  	}
		  	else
		  	{
	    		frm.action="zg57_3.jsp";		  //huangrong add  for 2011-6-1 		����������������
		  	}	
		}
 	}
  	document.all.confirm.disabled=true;//��ֹ����ȷ��
  	document.all.close.disabled=true;
  	frm.submit();
}

function opchange()
{
	if((document.all.opFlag[0].checked==true)||(document.all.opFlag[1].checked==true)) /*diling update for ����ʵ�������������ż�����ط���������@2012/5/16 */
	{
		document.all.zhi.style.display="";/*diling update @2012/5/16 */
		document.frm.phoneNo.value = "";
		//document.all.zhi1.style.display="";
	}else 
	{
		document.all.zhi.style.display="none";
		//document.all.zhi1.style.display="none";
	}
}


</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<table cellspacing="0">
		<TR> 
			<TD class="blue" align="center" width="20%">��������</TD>
			<TD>
				<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >���������ѯ&nbsp;&nbsp;
			</TD>
			<TD>
				<input type="radio" name="opFlag" value="two" onclick="opchange()">��������
			</TD>
		</TR>

		<tr id="zhi">
			<td class="blue" align="center" width="20%">�ֻ�����</td>
			<td colspan="3">
				<input class="button"type="text" name="phoneNo" size="20" maxlength="12" >
			</td>
		</tr>

	</table>
	<table>
		<tr>
		    <td colspan="2" id="footer"> 
		      <div align="center"> 
			      <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm()" index="2">
			      <input class="b_foot" type=button name="close" value="�ر�" onClick="removeCurrentTab();">
		      </div>
		    </td>
		</tr>	
	</table>
   
<input type="hidden" name="loginAccept" value="<%=printAccept%>" >
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>
