<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------后台人员：王文刚--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String sPChanceId     = WtcUtil.repNull(request.getParameter("sPChanceId"));
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String serverName = "sQ018Cfm";
	String result_count = "0";
	String paramIn =  " SELECT COUNT(*) "+
										"  FROM DBSALESADM.dMKTchancetradrel "+
										" WHERE chance_id = :sPChanceId "+
										"    AND status = '6'";
	String param	 = "sPChanceId="+sPChanceId;
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramIn%>" />
		<wtc:param value="<%=param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		result_count = result_t[0][0];
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result_count","<%=result_count%>");
core.ajax.receivePacket(response);
