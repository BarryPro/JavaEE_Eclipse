<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String[][] callData = null;
	String strArray = "var arrMsg; ";
	String errorCode = "444444";
	String errorMsg = "系统错误，请与系统管理员联系，谢谢!!";
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String verifyType = request.getParameter("verifyType");
	String outAble = request.getParameter("outAble");
	
	String productSpec_number = request.getParameter("proSpecNum");
	String memberType = request.getParameter("memberType");
	String validFlag = request.getParameter("validFlag");
	String workNo = (String) session.getAttribute("workNo");
	String sqlStr = "SELECT productspec_number,decode(member_type,'0','黑名单','1','签约成员','2','白名单'),decode(valid_Flag,'0','确认报文','1','归档报文'),decode(out_able,'0','不可以','1','可以') "
	                 +" FROM sMemberType "
	                 +" WHERE productspec_number = "+productSpec_number;
%>


<wtc:service name="sDynSqlCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="Code1" retmsg="Msg1">
		<wtc:param value="203907"/>
		<wtc:param value="<%=productSpec_number%>"/>
	  <wtc:param value="<%=memberType%>"/>
	  <wtc:param value="<%=validFlag%>"/>
	  <wtc:param value="<%=outAble%>"/>
	  <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=productSpec_number%>"/>   
</wtc:service>
<wtc:array id="result1"  scope="end" />


<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"
	retcode="retCode" retmsg="retMsg"
	outnum="4">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
callData = result;
strArray = WtcUtil.createArray("arrMsg",callData.length);
%>
<%=strArray%>
<%
	for (int i = 0; i < callData.length; i++) {
		for (int j = 0; j < callData[i].length; j++) {

			if (callData[i][j].trim().equals("") || callData[i][j] == null) {
				callData[i][j] = "";
			}
%>
arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
		}
	}
%>


var response = new AJAXPacket(); 
response.data.add("verifyType","setMemType");
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);

