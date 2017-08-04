<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>

<%-- 新增、修改、删除工作区模块操作  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
  String workNo = (String)session.getAttribute("workNo");
  
	String opType = request.getParameter("opType")==null?"":request.getParameter("opType");
	
	if("add".equals(opType.trim())){
		String wCode = request.getParameter("wCode")==null?"":request.getParameter("wCode");
		String wName = request.getParameter("wName")==null?"":request.getParameter("wName");
		String wSrc = request.getParameter("wSrc")==null?"":request.getParameter("wSrc");
		String wShow = request.getParameter("wShow")==null?"":request.getParameter("wShow");
		
		//需要调用后台服务进行增加操作
		%>
		
		<wtc:service name="sDwkspaceOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="<%=wCode%>" />
			<wtc:param value="<%=wName%>" />
			<wtc:param value="<%=wSrc%>" />
			<wtc:param value="<%=wShow%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e486" />
	      <wtc:param value="<%=ip_Addr%>" />
	      <wtc:param value="<%=powerCode%>" />
	      <wtc:param value="工作区管理增加" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String wCode = request.getParameter("wCode")==null?"":request.getParameter("wCode");
		String wName = request.getParameter("wName")==null?"":request.getParameter("wName");
		String wSrc = request.getParameter("wSrc")==null?"":request.getParameter("wSrc");
		String wShow = request.getParameter("wShow")==null?"":request.getParameter("wShow");
		String wOldCode = request.getParameter("wCode")==null?"":request.getParameter("wOldCode");
		
		//需要调用后台服务进行修改操作
		
		%>
		<wtc:service name="sDwkspaceOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=wCode%>" />
			<wtc:param value="<%=wName%>" />
			<wtc:param value="<%=wSrc%>" />
			<wtc:param value="<%=wShow%>" />
			<wtc:param value="<%=wOldCode%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e486" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="工作区管理修改" />
		</wtc:service>
			<%
				System.out.println("sDwkspaceOpr---"+retCode);
			%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String wCode = request.getParameter("wCode")==null?"":request.getParameter("wCode");
		String mRole = request.getParameter("mRole")==null?"":request.getParameter("mRole");
		//需要调用后台服务进行删除操作
	%>
			<wtc:service name="sDwkspaceOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
				<wtc:param value="d" />
				<wtc:param value="<%=wCode%>" />
				<wtc:param value="" />
				<wtc:param value="<%=mRole%>" />
				<wtc:param value="" />
				<wtc:param value="" />
				<wtc:param value="<%=workNo%>" />
			  <wtc:param value="e486" />
        <wtc:param value="<%=ip_Addr%>" />
        <wtc:param value="<%=powerCode%>" />
        <wtc:param value="工作区管理删除" />
			</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//校验wCode是否存在
		String wCode = request.getParameter("wCode")==null?"":request.getParameter("wCode");
		String sql = "select wkspace_id,wkspace_name,is_effect from dwkspacemsg where wkspace_id=:wkspace_id";
		String param = "wkspace_id="+wCode;
		String isAdd="1";
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="workspace" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			if(workspace.length==0){
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
	}else if("setRole".equals(opType.trim())){//角色设置
		
		String treeValue = request.getParameter("treeValue")==null?"":request.getParameter("treeValue");
		String defaultworkspace = request.getParameter("defaultworkspace")==null?"":request.getParameter("defaultworkspace");
		String selectValue = request.getParameter("selectValue")==null?"":request.getParameter("selectValue");
		%>
			
			<wtc:service name="sDwsRoleSet" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
				<wtc:param value="<%=treeValue%>" />
				<wtc:param value="<%=selectValue%>" />
				<wtc:param value="" />
				<wtc:param value="<%=workNo%>" />
			    <wtc:param value="e486" />
                <wtc:param value="<%=ip_Addr%>" />
                <wtc:param value="<%=powerCode%>" />
                <wtc:param value="工作区管理角色设置" />
			</wtc:service>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%
}else if("updlen".equals(opType.trim())){
	//修改模块长度
	String wDivid = request.getParameter("wDivid")==null?"":request.getParameter("wDivid");
	String mRole = request.getParameter("mRole")==null?"":request.getParameter("mRole");
	String mlenv = request.getParameter("mlenv")==null?"":request.getParameter("mlenv");
	wDivid = wDivid.trim();
	mRole = mRole.trim();
%>
			<wtc:service name="sDwsUpdLen" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
				<wtc:param value="<%=wDivid%>" />
				<wtc:param value="<%=mRole%>" />
				<wtc:param value="<%=mlenv%>" />	
			</wtc:service>
			
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
<%
}
%>

