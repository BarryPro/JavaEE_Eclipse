<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>

<%-- 新增、修改、删除页面导航信息的操作  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
  String workNo = (String)session.getAttribute("workNo");
  
	String opType = request.getParameter("opType")==null?"":request.getParameter("opType");
	
	if("add".equals(opType.trim())){
		String functionCode = request.getParameter("functionCode")==null?"":request.getParameter("functionCode");
		String nav_path = request.getParameter("nav_path")==null?"":request.getParameter("nav_path");

		String is_use = request.getParameter("is_use")==null?"":request.getParameter("is_use");	
		functionCode = functionCode+";";
	System.out.println("------------functionCode--------------"+functionCode);
		//调用后台服务进行增加操作
		%>
		<wtc:service name="sFuncNavOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="<%=functionCode%>" />
			<wtc:param value="<%=nav_path%>" />
			<wtc:param value="<%=is_use%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e491" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="页面导航管理增加" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String function_seq = request.getParameter("function_seq")==null?"":request.getParameter("function_seq");
		String functionCode = request.getParameter("functionCode")==null?"":request.getParameter("functionCode");
		String nav_path = request.getParameter("nav_path")==null?"":request.getParameter("nav_path");
		String is_use = request.getParameter("is_use")==null?"":request.getParameter("is_use");
		
		//调用后台服务进行修改操作
		System.out.println("function_seq="+function_seq);
		System.out.println("functionCode="+functionCode);
		System.out.println("nav_path="+nav_path);
		System.out.println("is_use="+is_use);
		%>
	 <wtc:service name="sFuncNavOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=functionCode%>" />
			<wtc:param value="<%=nav_path%>" />
			<wtc:param value="<%=is_use%>" />
			<wtc:param value="<%=function_seq%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e491" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="页面导航管理修改" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String function_seq = request.getParameter("function_seq")==null?"":request.getParameter("function_seq");
		//调用后台服务进行删除操作
		%>
		 <wtc:service name="sFuncNavOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="d" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=function_seq%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e491" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="页面导航管理删除" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){
		String functionCode = request.getParameter("functionCode")==null?"":request.getParameter("functionCode");
		String sql = "select function_code from dfuncnavmsg where function_code=:functionCode";
		String param = "functionCode="+functionCode;
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
			}else{
				retMsg = "此功能的导航信息已经存在！";
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
	}else if("suggest".equals(opType.trim())){
		String suggestInfo = request.getParameter("suggestInfo")==null?"":request.getParameter("suggestInfo");
		String sql = " select a.* from(select function_code||' '||function_name from sfunccodenew where function_code like '%"+suggestInfo+"%' "+
								"union all select function_code||' '||function_name from sfunccodenew where function_name like '%"+suggestInfo+"%') a where rownum<=5";
		System.out.println("suggestInfo============"+suggestInfo);
		StringBuffer suggestsText = new StringBuffer("");
		%>
		<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
		</wtc:service>
		<wtc:array id="suggestList" scope="end"/>
		<%				
		System.out.println(sql);
		System.out.println(retCode);
		if("000000".equals(retCode)){ 
		System.out.println("suggestList.length====="+suggestList.length);
			if(suggestList.length>0){
				for(int i=0;i<suggestList.length;i++){
					suggestsText.append(suggestList[i][0]);
					suggestsText.append("|");
				}
			}
		}
		
		%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			response.data.add("suggestsText","<%=suggestsText.toString()%>");
			core.ajax.receivePacket(response);	
		<%
	}
	%>

