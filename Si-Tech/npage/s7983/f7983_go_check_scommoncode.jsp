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

	String offerId    = WtcUtil.repNull(request.getParameter("offerId"));
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String sql = " SELECT substr(field_code2,1,1) "+
							"		FROM dbvipadm.scommoncode  "+
							"		WHERE common_code='1053' "+
							"		and field_code3 = :offerId ";
	String paramIn = "offerId="+offerId;				
	
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
	retMsg  = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
	if(result_t.length>0){
		result = result_t[0][0];
	}
	
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
