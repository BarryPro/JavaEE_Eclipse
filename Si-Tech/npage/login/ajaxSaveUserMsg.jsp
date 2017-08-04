<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:wanglma@2011-05-18 
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String regionCode = (String)session.getAttribute("regionCode");

String totalMillisecond = request.getParameter("totalMillisecond");
String acceptPageStartDate = request.getParameter("acceptPageStartDate");
String acceptPageEndDate = request.getParameter("acceptPageEndDate");
String transferData = request.getParameter("transferData");
String transferMilliSecond = request.getParameter("transferMilliSecond");
String transferSpeed = request.getParameter("transferSpeed");
String netQuality = request.getParameter("netQuality");
String exePageStartDate = request.getParameter("exePageStartDate");
String exePageEndDate = request.getParameter("exePageEndDate");
String exePageMilliSecond = request.getParameter("exePageMilliSecond");
String pcQuality = request.getParameter("pcQuality");

String sql = "insert into dLoginTerminalPerformance values('" + workNo + "', '" + workName + "', sysdate, "
	 + totalMillisecond + ", to_date('" + acceptPageStartDate + "', 'yyyy-mm-dd hh24:mi:ss'), "
	 + "to_date('" + acceptPageEndDate + "', 'yyyy-mm-dd hh24:mi:ss'), " + transferData + ", "
	 + transferMilliSecond + ", " + transferSpeed + ", '" + netQuality + "', "
	 + "to_date('" + exePageStartDate + "', 'yyyy-mm-dd hh24:mi:ss'), "
	 + "to_date('" + exePageEndDate + "', 'yyyy-mm-dd hh24:mi:ss'), " + exePageMilliSecond + ", "
	 + "'" + pcQuality + "')";
System.out.println("====wanghfa====ajaxSaveUserMsg.jsp==== sql = " + sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result"  scope="end"/>
<%
System.out.println("====wanghfa====ajaxSaveUserMsg.jsp==== sPubSelect " + retCode + ", " + retMsg);
%>
<%=retCode%>
