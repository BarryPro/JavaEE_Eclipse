<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String login_no =(String) session.getAttribute("workNo");//工号
  String offerCode = WtcUtil.repNull(request.getParameter("offerCode"));//销售品编码
  System.out.print("---------------"+login_no+offerCode);
%>

<wtc:utype name="sPMIBookMark" id="retVal" scope="end">
			<wtc:uparam value="<%=login_no%>" type="STRING"/>  
			<wtc:uparam value="<%=offerCode%>" type="LONG"/>  
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," ");
	 String	retVal1="";
	 if(retVal.getValue("2.0")!=null)
	 {retVal1 = retVal.getValue("2.0");}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retVal1","<%=retVal1%>");
core.ajax.receivePacket(response);
