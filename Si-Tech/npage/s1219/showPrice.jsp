<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String opCode="0001";
	String opName="����Ʒ���";
	String offerId =request.getParameter("OFFER_ID");	//"10288936";
	String planName="";
	String planFeeIntro="";
	String planParam="";
	System.out.println("=====offerId======"+offerId);
%>	
<wtc:utype name="sPMQPriPln" id="retVal" scope="end">
    <wtc:uparam value="<%=offerId%>" type="long" />							
</wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
System.out.println("=====retCode======"+retCode);
System.out.println("=====retMsg======="+retMsg);	
	if(retCode.equals("0"))
	{
			planName=retVal.getValue("2.0.0");
			planFeeIntro=retVal.getValue("2.0.1");
			planParam=retVal.getValue("2.0.2");
System.out.println("=====planName======"+planName);
System.out.println("=====planFeeIntro======"+planFeeIntro);	
System.out.println("=====planParam======"+planParam);					
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form>
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">����Ʒ���۲�ѯ</div>
</div>
		<table cellspacing=0>
			<tr>
			<td class="blue">���ۼƻ�����</td>
			<td><%=planName%></td></tr>
			<tr>
			<td class="blue">�ʷ�˵��</td>
			<td><%=planFeeIntro%></td></tr>
			<tr>	
			<td class="blue">����˵��</td>
			<td><%=planParam%></td></tr>
		</table>

	<table cellspacing=0>
			<tr><td id="footer">
		<input type="button"  class="b_foot" value="�ر�" onclick="window.close()"  />
	</td></tr></table>
	<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>	
	</body>	
</html>	
<%
	}else
	{
%>
	<script>
		alert("û�д�����Ʒ�Ķ�����Ϣ");
		window.close();
	</script>
<%
	}
%>		