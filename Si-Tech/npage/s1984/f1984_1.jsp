<%
/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.15
 ģ��:�û�������ҵ��
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%
String Msg = request.getParameter("errMsg");
if(!"".equals(Msg) && Msg!=null)
{
%>
<script language="javascript">
rdShowMessageDialog("<%=Msg%>");
</script>
<%}
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<!----------------------����--------------------->
<body>
<%  //----head ���⼰opcode
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
    String pageName="����ҵ�񿪹�����";
    String opcode = "1984"; 
	String message="";
%>
<!--@ include file="../../public/head.jsp" -->
<%
	String phoneNo = request.getParameter("activePhone");
	
    System.out.println("f1984 Start....");

    String phone_no = request.getParameter("phone_no");

	boolean needPassword = true;

%>

<script>
	
//�����飬��ת����ѯ���ҳ
function docheck(){		
	
		if(!checkElement(document.all.phone_no)) return false;

		document.form1.action="f1984_info.jsp";
		document.form1.submit();
	
}
function GetResult()
		{
		   var str=document.form1.phone_no.value;

			var oBao = new ActiveXObject("Microsoft.XMLHTTP");
			oBao.open("POST","f1984_panduan.jsp?phone_no="+str,false);
			oBao.send();
			var arrstr = new Array();
			arrstr = unescape(oBao.responseText).split("#");
			document.all.panduan.value=arrstr[1];

		}
 </script>



 <!-----------����-------->
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
 	
<table cellspacing="0">
	<tr>
		<td class="blue">�û�����</td>
		<td>
			<input type="text" name="phone_no" v_must=1 v_type="phone_no" class="InputGrey" value="<%=phoneNo%>" readOnly>
		</td>
	</tr>
<input type="hidden" name = "panduan" value = "">
</table>
<TABLE cellSpacing="0">
	<TR>
		<TD id="footer">
			<input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" index="9">
			<input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</TABLE>
  <%@ include file="/npage/include/footer_simple.jsp" %>   
</form>
</body>
</html>
<!------------------------------------->
