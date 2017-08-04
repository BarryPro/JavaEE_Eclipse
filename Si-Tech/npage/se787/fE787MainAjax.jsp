<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
String regCode	=(String)session.getAttribute("regCode");
String workNo	=(String)session.getAttribute("workNo");

/*主页面传递的参数*/
String getType=(String)request.getParameter("getType");


/*绑定人信息*/
if (getType.equals("getBid"))
{
	String jsonBind=request.getParameter("jsonBind");
	String bindCode=request.getParameter("bindCode");
 	String iLoginAccept="0";		
	String iChnSource="01";		
	String iOpCode="e787";			
	String iloginNo=(String)session.getAttribute("workNo");         
	String iloginPwd=(String)session.getAttribute("passwd");        
	String iPhoneNo="";			
	String iUserPwd="";
	String iIpAddr="";          
	String ijson=request.getParameter("jsonBind");		
	/*英文的逗号转成中文的逗号*/
	ijson=ijson.replaceAll(",","，");
	%>
	<wtc:service name="se787Chk" 
		routerKey="region" routerValue="<%=regCode%>" 
		retmsg="retMsg" retcode="retCode" outnum="1">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iloginNo%>"/>
		<wtc:param value="<%=iloginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iIpAddr%>"/>
		<wtc:param value="<%=ijson%>"/>
	</wtc:service>
	<wtc:array id="rstE787Chk" scope="end" />	
	
	var response = new AJAXPacket();
	response.data.add("oBindJson",'<%=rstE787Chk[0][0]%>');
	response.data.add("bindCode",'<%=bindCode%>');
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);	
<%
}/* end if (getType.equals("getBid"))*/
%>
