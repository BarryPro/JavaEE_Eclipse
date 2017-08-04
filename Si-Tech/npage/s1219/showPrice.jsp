<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String opCode="0001";
	String opName="销售品变更";
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
	<div id="title_zi">销售品定价查询</div>
</div>
		<table cellspacing=0>
			<tr>
			<td class="blue">定价计划名称</td>
			<td><%=planName%></td></tr>
			<tr>
			<td class="blue">资费说明</td>
			<td><%=planFeeIntro%></td></tr>
			<tr>	
			<td class="blue">参数说明</td>
			<td><%=planParam%></td></tr>
		</table>

	<table cellspacing=0>
			<tr><td id="footer">
		<input type="button"  class="b_foot" value="关闭" onclick="window.close()"  />
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
		alert("没有此销售品的定价信息");
		window.close();
	</script>
<%
	}
%>		