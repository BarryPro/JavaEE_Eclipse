<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-3-9 14:05:38-------------------
 
 -------------------------后台人员：zuolf--------------------------------------------
********************/ 
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String count_result = "0";
	
	//7个标准化入参
	String paraAray[] = new String[8];
	
	String paramIn =  " SELECT COUNT(*) "+
										"   FROM DDSMPORDERMSG A,DCUSTMSG B "+
										"  WHERE A.ID_NO = B.ID_NO "+
										" AND A.SERV_CODE = '51' "+
										"    AND A.VALID_FLAG = '1' "+
										"    AND B.PHONE_NO=:phoneNo ";
										
	String param = "phoneNo="+phoneNo;										
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramIn%>" />
		<wtc:param value="<%=param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"   />
<%
	retCode = code;
	retMsg  = msg;
	if(result_t.length>0){
		count_result = result_t[0][0];
	}
	
	System.out.println("-----hejwa-------count_result-------------->"+count_result);
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务TlsPubSelCrm出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("count_result","<%=count_result%>");
core.ajax.receivePacket(response);
