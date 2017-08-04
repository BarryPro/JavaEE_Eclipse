<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	opCode="0001";
	opName="销售品变更";
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
	<title>销售品定价查询</title>
	<body>
		<div id="operation">
		<form>
		<%@ include file="/npage/include/header.jsp" %>
		<div id="operation_table">
			<div class="input">
		<table>
			<tr>
			<th>定价计划名称：</th>
			<td><%=planName%></td></tr>
			<tr>
			<th>资费说明：</th>
			<td><%=planFeeIntro%></td></tr>
			<tr>	
			<th>参数说明：</th>
			<td><%=planParam%></td></tr>
		</table>
	</div></div>
	<div id="operation_button">
		<input type="button"  class="b_foot" value="关闭" onclick="window.close()"  />
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
		rdShowMessageDialog("没有此销售品的定价信息");
		window.close();
	</script>
<%
	}
%>		