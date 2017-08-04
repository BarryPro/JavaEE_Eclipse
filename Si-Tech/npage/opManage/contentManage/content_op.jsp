<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>

<%-- 新增、修改、删除操作  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
  	String workNo = (String)session.getAttribute("workNo");
  
	String opType = request.getParameter("opType")==null?"":request.getParameter("opType");
	
	if("add".equals(opType.trim())){
		String content_id = request.getParameter("content_id")==null?"":((String)request.getParameter("content_id")).trim();
		String content_name = request.getParameter("content_name")==null?"":(request.getParameter("content_name")).trim();
		String content_type = request.getParameter("content_type")==null?"":(request.getParameter("content_type")).trim();
		String is_effect = request.getParameter("is_effect")==null?"":(request.getParameter("is_effect")).trim();
		String content_detail = request.getParameter("content_detail")==null?"":(request.getParameter("content_detail")).trim();
		String conCls = request.getParameter("conCls")==null?"":(request.getParameter("conCls")).trim();
		String oproleidhide = request.getParameter("oproleidhide")==null?"":(request.getParameter("oproleidhide")).trim();
		content_type = "1";
		System.out.println("------add------oproleidhide------------------"+oproleidhide);
		//调用后台服务进行增加操作
		%>
		<wtc:service name="sDcontentMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="<%=content_type%>" />
			<wtc:param value="<%=content_id%>" />
			<wtc:param value="<%=content_name%>" />
			<wtc:param value="<%=content_detail%>" />
			<wtc:param value="<%=is_effect%>" />
			<wtc:param value="" />
			<wtc:param value="<%=oproleidhide%>" />
			<wtc:param value="e489" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="内容管理增加" />
      	<wtc:param value="<%=conCls%>" />
      		<wtc:param value="<%=workNo%>" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String content_seq = request.getParameter("content_seq")==null?"":request.getParameter("content_seq");
		String content_id = request.getParameter("content_id")==null?"":((String)request.getParameter("content_id")).trim();
		String content_name = request.getParameter("content_name")==null?"":(request.getParameter("content_name")).trim();
		String content_type = request.getParameter("content_type")==null?"":(request.getParameter("content_type")).trim();
		String is_effect = request.getParameter("is_effect")==null?"":(request.getParameter("is_effect")).trim();
		String content_detail = request.getParameter("content_detail")==null?"":(request.getParameter("content_detail")).trim();
		String conCls = request.getParameter("conCls")==null?"":(request.getParameter("conCls")).trim();
		String oproleidhide = request.getParameter("oproleidhide")==null?"":(request.getParameter("oproleidhide")).trim();
		content_type = "1";
		//调用后台服务进行修改操作
		
		%>
		<wtc:service name="sDcontentMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=content_type%>" />
			<wtc:param value="<%=content_id%>" />
			<wtc:param value="<%=content_name%>" />
			<wtc:param value="<%=content_detail%>" />
			<wtc:param value="<%=is_effect%>" />
			<wtc:param value="<%=content_seq%>" />
		  	<wtc:param value="<%=oproleidhide%>" />
			<wtc:param value="e489" />
	       <wtc:param value="<%=ip_Addr%>" />
	       <wtc:param value="<%=powerCode%>" />
	       <wtc:param value="内容管理修改" />
	       <wtc:param value="<%=conCls%>" />
	       	<wtc:param value="<%=workNo%>" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String content_seq = request.getParameter("content_seq")==null?"":request.getParameter("content_seq");
		//调用后台服务进行删除操作
		%>
		<wtc:service name="sDcontentMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="d" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=content_seq%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e489" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="内容管理删除" />
      	<wtc:param value="" />
      		<wtc:param value="<%=workNo%>" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//校验wkCode是否存在
		String content_id = request.getParameter("content_id")==null?"":request.getParameter("content_id");
		String oproleidhide = request.getParameter("oproleidhide")==null?"":request.getParameter("oproleidhide");
		
		System.out.println("----------------oproleidhide------------"+oproleidhide);
		String sql = "select content_id,content_name from dcontentmsg where content_id=:content_id and op_roleid=:powerCode ";
		String param1 = "content_id="+content_id;
		String param2 = "powerCode="+oproleidhide;
		String isAdd="1";
		%>
		<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param1%>" />
			<wtc:param value="<%=param2%>" />
		</wtc:service>
		<wtc:array id="theme" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			if(theme.length==0){
				isAdd = "0";//不存在
			}
		}
		
	%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			response.data.add("isAdd","<%=isAdd%>");
			core.ajax.receivePacket(response);	
	
	<%
	}
	%>

