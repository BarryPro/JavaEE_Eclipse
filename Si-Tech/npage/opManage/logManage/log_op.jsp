<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>

<%-- 新增、修改、删除操作  --%>

<%

	String workNo = (String)session.getAttribute("workNo");
	String ipAddr = (String)session.getAttribute("ipAddr");

	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String opType = request.getParameter("opType")==null?"":request.getParameter("opType");
	
	if("add".equals(opType.trim())){
		String wkCode = request.getParameter("wkCode")==null?"":request.getParameter("wkCode");
		String wkName = request.getParameter("wkName")==null?"":request.getParameter("wkName");
		String wkField = request.getParameter("wkField")==null?"":request.getParameter("wkField");
		String wkShow = request.getParameter("wkShow")==null?"":request.getParameter("wkShow");	
	
		//调用后台服务进行增加操作
		%>
		<wtc:service name="sDcommOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="" />
			<wtc:param value="<%=wkCode%>" />
			<wtc:param value="<%=wkName%>" />
			<wtc:param value="<%=wkField%>" />
			<wtc:param value="<%=wkShow%>" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String wkSeq = request.getParameter("wkSeq")==null?"":request.getParameter("wkSeq");
		String wkCode = request.getParameter("wkCode")==null?"":request.getParameter("wkCode");
		String wkName = request.getParameter("wkName")==null?"":request.getParameter("wkName");
		String wkField = request.getParameter("wkField")==null?"":request.getParameter("wkField");
		String wkShow = request.getParameter("wkShow")==null?"":request.getParameter("wkShow");
		
		//调用后台服务进行修改操作
		
		%>
		<wtc:service name="sDcommOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=wkSeq%>" />
			<wtc:param value="<%=wkCode%>" />
			<wtc:param value="<%=wkName%>" />
			<wtc:param value="<%=wkField%>" />
			<wtc:param value="<%=wkShow%>" />
		
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String wkSeq = request.getParameter("wkSeq")==null?"":request.getParameter("wkSeq");
		String delFlag = request.getParameter("delFlag")==null?"":request.getParameter("delFlag");
		System.out.println("--------delete-------wkSeq-----------------"+wkSeq);
		String opnotes = "";
		if(delFlag.equals("0")) opnotes = "操作日志记录恢复";
		if(delFlag.equals("1")) opnotes = "操作日志记录删除";
		if(delFlag.equals("a")) opnotes = "操作日志记录彻底删除";
		//调用后台服务进行删除操作
		
		System.out.println("---------workNo-------------"+workNo);
		System.out.println("---------ipAddr-------------"+ipAddr);
		System.out.println("---------powerCode----------"+powerCode);
		System.out.println("---------wkSeq--------------"+wkSeq);
		System.out.println("---------delFlag------------"+delFlag);
		System.out.println("---------opnotes------------"+opnotes);
		%>
		<wtc:service name="sRdopLOGOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=ipAddr%>" />
			<wtc:param value="<%=powerCode%>" />
			<wtc:param value="<%=wkSeq%>" />	
			<wtc:param value="<%=delFlag%>" />	
			<wtc:param value="<%=opnotes%>" />		
		</wtc:service>
		<%
		System.out.println("--------------retCode-------------"+retCode);
		%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	<%

	}else if("check".equals(opType.trim())){
		String wkCode = request.getParameter("wkCode")==null?"":request.getParameter("wkCode");
		String sql = "select wkspace_code,wkspace_name,is_effect from dcommunicate where wkspace_code=:wkspace_code";
		String param = "wkspace_code="+wkCode;
		String isAdd="1";
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
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

