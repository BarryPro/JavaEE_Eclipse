<%
	/*
	 * 功能: 综合V网成员查询
	 * 版本: v1.0
	 * 日期: 2009年08月06日
	 * 作者: wangzn
	 * 版权: sitech
	 */
%>

<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String regionCode = (String) session.getAttribute("regCode");

	String[][] callData = null;

	String errorCode = "444444";
	String errorMsg = "系统错误，请与系统管理员联系，谢谢!!";
	
	String strArray = "var arrMsg; ";

	String verifyType = request.getParameter("verifyType");
	String groupNo = request.getParameter("groupNo");

	String insql = "select trim(a.field_value),b.field_value,c.field_value from dgrpusermsgadd a,dgrpusermsgadd b,dgrpusermsgadd c,dgrpusermsgadd d where a.id_no=b.id_no and a.id_no=c.id_no and a.id_no=d.id_no and a.field_code='ZHWW0' and b.field_code ='20002' and c.field_code ='20006' and d.field_code ='20000' and d.field_value = '"+groupNo+"'";
%>
<wtc:pubselect name="sPubSelect" routerKey="region"
	routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"
	outnum="3">
	<wtc:sql><%=insql%></wtc:sql>
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
response.data.add("verifyType","GroupNo");
response.data.add("errorCode","1231231");
response.data.add("errorMsg","asdfasdf");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);

