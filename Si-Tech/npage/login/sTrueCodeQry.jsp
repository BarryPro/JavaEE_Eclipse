<%
/********************
 -------------------------创建-----------何敬伟(hejwa) 2015/5/12 9:54:44-------------------
 关于进一步加强省级支撑系统实名补登记功能的通知
 
 核心业务逻辑设计：
1、输入手机号码后(即右图红框输入完手机号码弹出即可)，如果用户是非实名或者准实名用户，则弹出提示框，
		提示信息为“请进行实名登记，补充客户资料。”说明：只是提示，不是限制。
 -------------------------后台人员：无--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	System.out.println("--hejwa-------------sTrueCodeQry.jsp------------->");
	
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
	String retCode    = "000000";
	String retMsg     = "";
	String result     = "1";//此处写死，实名制放到购物车中进行判断
	 
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result","<%=result%>");
core.ajax.receivePacket(response);
