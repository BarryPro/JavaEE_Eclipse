<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	int recordNum = 0; //查询结果记录数量
	String memberId = "";
%>

<wtc:service name="sDynSqlCfm" outnum="3">
  <wtc:param value="12"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>

<%
	if(retCode.equals("000000") && result1.length > 0){
		memberId = result1[0][0];
	}
%>	


var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("memberId","<%=memberId%>");
core.ajax.receivePacket(response);