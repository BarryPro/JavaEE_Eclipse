<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String sql = request.getParameter("sql");
String regionCode = (String)session.getAttribute("regCode");
System.out.println("SQL==========================="+sql);
%>
<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retcode" retmsg="retmsg" outnum="2" >
	<wtc:param value="<%=sql%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end"/>

<%
	String keyNamesValues = "";
	for ( int i = 0 ; i <resultList.length; i ++  )
	{
		keyNamesValues = keyNamesValues +"\""+resultList[i][0]+"\""+":\""+resultList[i][1]+"\" ,";
	}
	String jasonKeyNames = "{"+keyNamesValues.substring(0 , keyNamesValues.length()-1)+"}";
	System.out.println("~~~~~~~~~~~~"+jasonKeyNames+"~~~~~~~~~~~~~~~~~~~~~~~~~~~`");
%>
var response = new AJAXPacket();
response.data.add("jasonKeyNames",'<%=jasonKeyNames%>'  ); 
core.ajax.receivePacket(response);
