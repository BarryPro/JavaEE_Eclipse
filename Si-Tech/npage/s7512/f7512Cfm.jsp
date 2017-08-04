<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-23 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
	String return_code;
	String return_message;
%> 	

<%	
	String workNo   =(String)session.getAttribute("workNo");	
	String ip_Addr  = request.getRemoteAddr();
	String regionCode= (String)session.getAttribute("regCode");	
    	String stampNumber = request.getParameter("stampCount");
    
%>
	<wtc:service name="s7512Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="7512"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=stampNumber%>"/>
		<wtc:param value="<%=ip_Addr%>"/>
	</wtc:service>
	
<%
	//result = callView.callService("s7512Cfm",paramsIn,"2");
	return_code =retCode1;
	return_message = retMsg1;
	
	if(return_code.equals("000000"))
	{
%>
		<SCRIPT type=text/javascript>
				rdShowMessageDialog("设置成功",2);
				history.go(-1);
		</SCRIPT>
<%
	}
	else
	{
%>
		<SCRIPT type=text/javascript>
				rdShowMessageDialog("<%=return_message%>",0);
				history.go(-1);
		</SCRIPT>
<%
	}
%>