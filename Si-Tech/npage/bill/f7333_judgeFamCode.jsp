<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
	String famCode = request.getParameter("famCode");
	String regionCode=(String)session.getAttribute("regCode");
    String sqlStr2 = "  select count(*) from sfamilyproduct where fam_prod_id ='"+famCode+"' and fam_type = 'TDTF'";
%>
    <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
    	<wtc:param value="<%=sqlStr2%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
    	
var response = new AJAXPacket();
response.data.add("result","<%=result[0][0]%>"); 
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);


