<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient170,java.util.*"%>
<%
	String serialnum = request.getParameter("serialnum");
	String tablename = request.getParameter("tablename");
	Map map = new HashMap();
	map.put("serialnum", serialnum);
	map.put("tablename", tablename);
	String flag = (String)KFEjbClient170.queryForObject("getQcFlag",map);
%>
	var response = new AJAXPacket();
	response.data.add("qcFlag","<%=flag%>");
	core.ajax.receivePacket(response);;