<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	opCode="0001";
	opName="����Ʒ���";
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
System.out.println("=====retMsg======"+retMsg);	
	if(retCode.equals("0"))
	{
			planName=retVal.getValue("2.0.0");
			planFeeIntro=retVal.getValue("2.0.1");
			planParam=retVal.getValue("2.0.2");
System.out.println("=====planName======"+planName);
System.out.println("=====planFeeIntro======"+planFeeIntro);	
System.out.println("=====planParam======"+planParam);					
%>
<html>
	<title>����Ʒ���۲�ѯ</title>
	<body>
		<div id="operation">
		<form>
		<%@ include file="/npage/include/header.jsp" %>
		<div id="operation_table">
			<div class="input">
		<table>
			<tr>
			<th>���ۼƻ����ƣ�</th>
			<td><%=planName%></td></tr>
			<tr>
			<th>�ʷ�˵����</th>
			<td><%=planFeeIntro%></td></tr>
			<tr>	
			<th>����˵����</th>
			<td><%=planParam%></td></tr>
		</table>
	</div></div>
	<div id="operation_button">
		<input type="button"  class="b_foot" value="�ر�" onclick="window.close()"  />
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
	</form>	
</div>
	</body>	
</html>	
<%
	}else
	{
%>
	<script>
		rdShowMessageDialog("û�д�����Ʒ�Ķ�����Ϣ");
		window.close();
	</script>
<%
	}
%>		