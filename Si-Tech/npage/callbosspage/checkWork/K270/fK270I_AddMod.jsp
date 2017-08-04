<%
  /*
   * 功能: 评定原因定义  
　 * 版本: 2.0
　 * 日期: 2008/11/04
　 * 作者: 
　 * 版权: sitech
　*/
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String retType = request.getParameter("retType");
	String login_no = request.getParameter("login_no");
	String service_name = request.getParameter("service_name");
	String note = request.getParameter("note");
	String service_id = request.getParameter("service_id");
	String parent_service_id = request.getParameter("parent_service_id");
	String valid_flag = request.getParameter("valid_flag");
	String opType = new String();
	if(retType.equals("add")){
		opType = "0";
	}else if(retType.equals("mod")){
		opType = "1";
	}else{
		opType = "2";
	}
	
%> 
 	<wtc:service name="sK270IUCfm"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">
 		<wtc:param value="<%=opType%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=service_name%>"/>
		<wtc:param value="<%=note%>"/>
		<wtc:param value="<%=service_id%>"/>
		<wtc:param value="<%=parent_service_id%>"/>
		<wtc:param value="<%=valid_flag%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

  var response = new AJAXPacket(); 
	response.data.add("retType","<%=retType%>"); 
	response.data.add("retCode","<%=retCode%>" );  
	response.data.add("retMsg","<%=retMsg%>" );                                                                                                                                                                                                                    
	core.ajax.receivePacket(response);	 