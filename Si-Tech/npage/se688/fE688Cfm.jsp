<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
 sChgCityCfm
*/

%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page contentType="text/html;charset=GBK"%>

<%
String myJSONText	=request.getParameter("myJSONText");
String regCode		=	(String)session.getAttribute("regCode");
System.out.println("zhangyan~~~~~~~~~~~~~regCode~~~~~~~~~~~~```"+regCode);
System.out.println("zhangyan~~~~~~~~~~~~~myJSONText~~~~~~~~~~~~```"+myJSONText);
String phoneNo=request.getParameter("phoneNo");
%>

<wtc:utype name="sChgCityCfm" id="retVal" scope="end"  
	routerKey="region" routerValue="<%=regCode%>">
	<wtc:uparam value="<%=myJSONText%>" type="STRING"/>  
</wtc:utype>
<%
String retCode = retVal.getValue(0);
String retMsg = retVal.getValue(1);
System.out.println("zhangyan~~~~~~~~~~~~~retCode~~~~~~~~~~~~```"+retCode);
System.out.println("zhangyan~~~~~~~~~~~~~retMsg~~~~~~~~~~~~```"+retMsg);

if("0".equals(retCode) || "000000".equals(retCode))
{
%>
	<script>
		rdShowMessageDialog("e688提交成功!");
		window.location="fE688Main.jsp?activePhone=<%=phoneNo%>";
	</script>
<%
}
else
{
System.out.println("zhangyan~~~~else~~~~~~~~~retCode~~~~~~~~~~~~```"+retCode);
System.out.println("zhangyan~~~~else~~~~~~~~~retMsg~~~~~~~~~~~~```"+retMsg);
%>
	
	<script>
		rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
		window.location="fE688Main.jsp?activePhone=<%=phoneNo%>";
	</script>
	<%

}%>