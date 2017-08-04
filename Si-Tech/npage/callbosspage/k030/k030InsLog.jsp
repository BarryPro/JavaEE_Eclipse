%
	/*
	 * 功能: 内部呼叫记录日志
	 * 版本: 1.0
	 * 日期: 2008/10/22
	 * 作者: kouwb 
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String retType = request.getParameter("retType").trim();
    String op_code = request.getParameter("op_code").trim();
    String caller = request.getParameter("caller").trim();
    String called = request.getParameter("called").trim();
    String call_id = request.getParameter("call_id").trim();
	  String login_no = (String)session.getAttribute("workNo");  
	  String login_name = (String)session.getAttribute("workName");
	  String org_code = (String)session.getAttribute("orgCode"); 
	  String region_code = org_code.substring(0,2);
	  String ip_addr = (String)session.getAttribute("ipAddr");
	  String notes = "记录录音日志表";
%>
<%
	/*
	*contact_id      
	*caller          
	*called          
	*cust_name       
	*sm_code         
	*grade_code      
	*region_code     
	*contact_address 
	*contact_phone   
	*accept_phone    
	*accept_login_no 
	*lang_code       
	*accept_id       
	*op_code         
	*call_id         
	*phone_type      
	*chn_code        
	*interface_code  
	*interactive_code
	*contact_status  
	*contact_ip      
	*notes           
	*org_code        
	*op_note         
	*/
%>
<wtc:service name="sK021TEL" outnum="2">
		<wtc:param value="<%=contact_id%>"/>
		<wtc:param value="<%=caller%>"/>
		<wtc:param value="<%=called%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=region_code%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=call_id%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=" "%>"/>
		<wtc:param value="<%=ip_addr%>"/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=notes%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);	
