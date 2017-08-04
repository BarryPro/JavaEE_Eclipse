<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-12-17 9:51:22-------------------
 
 -------------------------后台人员：jingang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String iChrgType     = WtcUtil.repNull(request.getParameter("iChrgType"));
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	String in_sql =   " SELECT a.bizcode,a.servname||'('||trim(to_char(a.price,'99999990.00'))||'元)' "+
										"  FROM ddsmpspbizinfo a                                                 "+
										" WHERE spid = '698034'                                                  "+
										"   and a.billingtype = :iChrgType                                       "+
										" order by a.bizcode                                                    ";

	String in_sql_param = "iChrgType="+iChrgType;
	
	System.out.println("------hejwa--------in_sql--------------------->"+in_sql);
	System.out.println("------hejwa--------in_sql_param--------------->"+in_sql_param);
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=in_sql%>" />
		<wtc:param value="<%=in_sql_param%>" />	
	</wtc:service>
	<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
