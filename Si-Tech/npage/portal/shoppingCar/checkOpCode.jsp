<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String login_no =(String) session.getAttribute("workNo");//工号
  String offerId = WtcUtil.repNull(request.getParameter("offerId"));//销售品编码
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));//销售品名称
  
  
  String idNo = WtcUtil.repNull(request.getParameter("idNo"));
  String opcode = WtcUtil.repNull(request.getParameter("opcode"));
  String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));
  String functionName = WtcUtil.repNull(request.getParameter("functionName"));
  
  String  org_Code = (String) session.getAttribute("orgCode");
  String  regionCode=org_Code.substring(0,2);
  String nopass = (String) session.getAttribute("password");/*操作员密码*/
%>

<wtc:utype name="sLinkOprChk" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:uparam value="<%=phoneNo%>" type="STRING"/>  
			<wtc:uparam value="<%=opcode%>" type="STRING"/>  
			<wtc:uparam value="<%=login_no%>" type="STRING"/>
			<wtc:uparam value="<%=nopass%>" type="STRING"/>
</wtc:utype>


<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 

   System.out.println("retCode=="+retCode);
   System.out.println("retMsg==="+retMsg);
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("idNo","<%=idNo%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("opcode","<%=opcode%>");
response.data.add("servBusiId","<%=servBusiId%>");
response.data.add("phoneNo","<%=phoneNo%>");
response.data.add("functionName","<%=functionName%>");

core.ajax.receivePacket(response);