<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016/11/3 19:43:21-------------------
 
 -------------------------后台人员：liyang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String cfm_login         = WtcUtil.repNull(request.getParameter("cfm_login"));
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	String sql_str =  " select a.detail_addr "+
										"	  from dbcustadm.dbroadimsres a, dbcustadm.dbroadbandmsg b "+
										"	 where a.id_no = b.id_no "+
										"	   and cfm_login =:cfm_login ";
	String sql_param = "cfm_login="+cfm_login;				
	
	System.out.println("-------hejwa-----------------sql_str-------->"+sql_str);					
	//7个标准化入参
	String paraAray[] = new String[2];
	
	paraAray[0] = sql_str;                                       // 
	paraAray[1] = sql_param;                                     // 

	String serverName = "TlsPubSelCrm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code-----serverName=["+serverName+"]---------"+code);
	System.out.println("--hejwa--------msg------serverName=["+serverName+"]---------"+msg);
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
		
		System.out.println("-------hejwa-------------serverResult["+i+"]["+j+"]------------>"+serverResult[i][j]);
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j].trim()%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
