<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>


<%

	String orgId=WtcUtil.repNull(request.getParameter("orgId"));//地市
	String classId=WtcUtil.repNull(request.getParameter("classId"));//班组
	String state=	WtcUtil.repNull(request.getParameter("state"));//状态
	String flashTime=WtcUtil.repNull(request.getParameter("flashTime"));//刷新间隔时间
	String endNum=WtcUtil.repNull(request.getParameter("endNum"));//显示行数	
	
	Map map=new HashMap();
	map.put("orgId",orgId);
	map.put("classId",classId);
	map.put("state",state);
	map.put("flashTime",flashTime);
	map.put("endNum",endNum);

	session.setAttribute("rememberMap",map);
%>

var response = new AJAXPacket();
core.ajax .receivePacket(response);
