<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String login_no =(String) session.getAttribute("workNo");//工号
  String offer_id = WtcUtil.repNull(request.getParameter("offer_id"));//销售品编码
  
  System.out.println("---------------------------ajax_DelMyFavorite.jsp----------------------");
  System.out.println("---------------------------login_no----------------------"+login_no);
  System.out.println("---------------------------offer_id----------------------"+offer_id);
  
%>

<wtc:utype name="sPMDBookMark" id="retVal" scope="end">
			<wtc:uparam value="<%=login_no%>" type="STRING"/>  
			<wtc:uparam value="<%=offer_id%>" type="LONG"/>  
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
   System.out.println("---------------------------retCode----------------------"+retCode);
   System.out.println("---------------------------retMsg-----------------------"+retMsg);
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);