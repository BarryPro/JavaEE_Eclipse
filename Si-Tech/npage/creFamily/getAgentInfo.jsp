<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%System.out.println("----------------------------getAgentInfo.jsp------------------------------------");  %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
	String classCode = WtcUtil.repNull(request.getParameter("classCode"));
	String groupName = WtcUtil.repNull(request.getParameter("groupName"));
System.out.println("classCode-------->"+classCode+"||groupName---------->"+groupName);	
	StringBuffer sb = new StringBuffer(80);
	String sqlStr = "SELECT group_Id,group_name FROM DCHNGROUPMSG WHERE CLASS_CODE= '"+classCode+"'";
	if(!groupName.equals("")){
		sqlStr += "AND group_name LIKE '%"+groupName+"%'";
	}
%>

<wtc:pubselect name="sPubSelect" outnum="4">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>

<%
	System.out.println("<<------------result.length----------->>"+result.length);
	if(retCode.equals("000000") && result.length > 0){
		for(int i=0;i<+result.length;i++){
			sb.append("<option value='"+result[i][0]+"'>"+result[i][1]+"</option>");
		}
	}
%>
<%=sb.toString()%>

