<%
	/*
	 * 功能: 休息
	 * 版本: 1.0
	 * 日期: 2008/10/21
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
    //System.out.println("op_code"+op_code);
    String phone_no = request.getParameter("phone_no").trim();
     //System.out.println("phone_no"+phone_no);
    String status_name = request.getParameter("status_name").trim();
     //System.out.println("status_name"+status_name);
    String op_note="状态更改为"+status_name;
     //System.out.println("op_note"+op_note);
    String staff_status = request.getParameter("status_code").trim();
	   //System.out.println("staff_status"+staff_status);
	  String login_no = (String)session.getAttribute("workNo");  
	  //System.out.println("login_no"+login_no);
	  String login_name = (String)session.getAttribute("workName");
	   //System.out.println("login_name"+login_name);
	  String org_code = (String)session.getAttribute("orgCode"); 
	   //System.out.println("org_code"+org_code);
	  String ip_addr = (String)session.getAttribute("ipAddr");
		// System.out.println("ip_addr"+ip_addr);
		String long_Time = WtcUtil.repNull(request.getParameter("long_Time"));
 //System.out.println("long_Time"+long_Time);
 
 String kf_longin_n=(String)session.getAttribute("kfWorkNo");
%>
<wtc:service name="sKStatChg" outnum="1">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=login_name%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=ip_addr%>"/>
		<wtc:param value="<%=op_note%>"/>
		<wtc:param value="<%=staff_status%>"/>
		<wtc:param value="<%=kf_longin_n%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=long_Time%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
	
	
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);	