<%
/********************
 -------------------------创建-----------何敬伟(hejwa) 2015-8-17 16:54:39------------------
 
 -------------------------后台人员：wangleic--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String rateCode     = WtcUtil.repNull(request.getParameter("rateCode"));
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String sql = " SELECT FIELD_CODE3 FROM dbvipadm.scommoncode "+
							 " WHERE COMMON_CODE = '1038' AND FIELD_CODE1 = 'RH' AND FIELD_CODE2 = '01' AND FIELD_CODE3 = :offerCode ";
	String paramIn = "offerCode="+rateCode;				
	
	System.out.println("--hejwa--------sql--------------"+sql);
	System.out.println("--hejwa--------paramIn--------------"+paramIn);
	String result = "";			 
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql%>" />
		<wtc:param value="<%=paramIn%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
  result = result_t.length+"";
	
	System.out.println("--hejwa--------result---------------"+result);
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务TlsPubSelCrm出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result","<%=result%>");
core.ajax.receivePacket(response);
