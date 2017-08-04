<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%
String s_iLoginAccept=request.getParameter("iLoginAccept");
String s_iOpCode=request.getParameter("iOpCode");
String s_iLoginNo=request.getParameter("iLoginNo");
String s_iLoginPwd=request.getParameter("iLoginPwd");
String s_iPhoneNo=request.getParameter("iPhoneNo");
String s_iUserPwd=request.getParameter("iUserPwd");
String s_iRegionCode=request.getParameter("iRegionCode");

%>
<wtc:service name="sm494Chk" outnum="5"
	routerKey="region" 
	retcode="retCode" retmsg="retMsg" >
	<wtc:param value="<%=s_iLoginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=s_iOpCode%>"/>
	<wtc:param value="<%=s_iLoginNo%>"/>
	<wtc:param value="<%=s_iLoginPwd%>"/>
	<wtc:param value="<%=s_iPhoneNo%>"/>
	<wtc:param value="<%=s_iUserPwd%>"/>
	<wtc:param value="<%=s_iRegionCode%>"/>
</wtc:service>
<wtc:array id="serverResult" scope="end" />
<%
	
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--chenlei--------出参------sm494Chk--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	



	System.out.println("--chenlei--------retCode-----serverName--------"+retCode);
	System.out.println("--chenlei--------retMsg------serverName---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
