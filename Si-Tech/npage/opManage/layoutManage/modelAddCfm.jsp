<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
		  	
	String mCode = request.getParameter("mCode")==null?"":request.getParameter("mCode");
	String mName = request.getParameter("mName")==null?"":request.getParameter("mName");
	String mShow = request.getParameter("mShow")==null?"":request.getParameter("mShow");
	String defLay = request.getParameter("defLay")==null?"":request.getParameter("defLay");
	String laycStr = request.getParameter("laycStr")==null?"":request.getParameter("laycStr");
	String wcheStr = request.getParameter("wcheStr")==null?"":request.getParameter("wcheStr");
	String wcheLenStr = request.getParameter("wcheLenStr")==null?"":request.getParameter("wcheLenStr");
	String regionCode = (String)session.getAttribute("regCode");
	
	
	
	String ipAddr = (String)session.getAttribute("ipAddr");
	String workNo = (String)session.getAttribute("workNo");
	String powerCode = (String)session.getAttribute("powerCode");
	String opNote = "工号："+workNo+"增加布局模板";
	
%>	 
    <wtc:service name="sModelAddCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=mCode%>" />
		<wtc:param value="<%=mName%>" />
		<wtc:param value="<%=mShow%>" />
		<wtc:param value="<%=defLay%>" />
		<wtc:param value="<%=laycStr%>" />
		<wtc:param value="<%=wcheStr%>" />
		<wtc:param value="<%=wcheLenStr%>" />
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="e484" />
		<wtc:param value="<%=ipAddr%>" />	
		<wtc:param value="<%=powerCode%>" />		
		<wtc:param value="<%=opNote%>" />			
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
		
var response = new AJAXPacket();
response.data.add("retCode","<%=code%>");
response.data.add("retMsg","<%=msg%>");
core.ajax.receivePacket(response);	
	 