<%
  /*
   * 功能: 差错等级定义  
　 * 版本: 2.0
　 * 日期: 2008/11/04
　 * 作者: kouwb
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
	String error_level_name = request.getParameter("error_level_name");
	String note = request.getParameter("note");
	String error_level_id = request.getParameter("error_level_id");
	String parent_error_level_id = request.getParameter("parent_error_level_id");
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
 	<wtc:service name="sK250IUCfm"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">
		<wtc:param value="<%=opType%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=error_level_name%>"/>
		<wtc:param value="<%=note%>"/>
		<wtc:param value="<%=error_level_id%>"/>
		<wtc:param value="<%=parent_error_level_id%>"/>
		<wtc:param value="<%=valid_flag%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

  var response = new AJAXPacket(); 
	response.data.add("retType","<%=retType%>"); 
	response.data.add("retCode","<%=retCode%>" );  
	response.data.add("retMsg","<%=retMsg%>" );                                                                                                                                                                                                                    
	core.ajax.receivePacket(response);	 