<%
  /* *********************
   * ����:�����������ʱ���ѯ
   * �汾: 1.0
   * ����: 2010/01/12
   * ����: fengry
   * ��Ȩ: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	request.setCharacterEncoding("GBK");
%>

<html>
<head>
<title>�����������ʱ���ѯ</title>

<%
	String opCode = "6342";
	String opName = "�����������ʱ���ѯ";
	//activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	System.out.println("regionCode======================"+regionCode);
	//System.out.println("f6952_login.jsp-->activePhone==="+activePhone+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language=javascript>
onload = function()
{
	self.status = "";
}

//----------------��֤���ύ����-----------------
function doCfm()
{
	if(!check(document.frm)){
		return false;
	}
	frm.submit();
}

</script>
</head>

<body>
<form name="frm" method="POST" action="s6342_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�����������ʱ���ѯ</div>
	</div>
 	<input type="hidden" name="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
	<table cellspacing="0">
		<tr>
	        <td class="blue" nowrap>�绰����</td>
	        <td nowrap> 
	            <input type="text" name="PhoneNo" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 >
	            <font class="orange">*</font>              
	        </td>
</tr>
	</table>
	
	
	<table cellspacing="0">
		<tr>
			<td id="footer" colspan="4">
				<input class="b_foot" type="button" name="confirm" value="��ѯ" onClick="doCfm()" index="2">&nbsp;
				<input class="b_foot" type="button" name="close" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
