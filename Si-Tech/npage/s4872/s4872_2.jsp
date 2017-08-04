<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.util.*;"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	String sqlStr = request.getParameter("sqlStr");
	String param1 = request.getParameter("param1");
	System.out.println("------>"+sqlStr);
	String[][] tri_metaData = new String [][]{};

%>
<wtc:service name="sBossDefSqlSel" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=param1%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />

 

<%
	
		tri_metaData = result1;

	String aaa = tri_metaData[0][0];
	String bbb = tri_metaData[0][1];
	String ccc = tri_metaData[0][2];
	String ddd = tri_metaData[0][3];
	String eee = tri_metaData[0][4];
	String fff = tri_metaData[0][5];
	String ggg = tri_metaData[0][6];
	String hhh = tri_metaData[0][7];
	String phone_no = tri_metaData[0][8];
	
	if(hhh.equals("0")){
		eee="0";
	}
%>

var response = new RPCPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("aaa",<%=aaa%>);
response.data.add("bbb",<%=bbb%>);
response.data.add("ccc",<%=ccc%>);
response.data.add("ddd",<%=ddd%>);
response.data.add("eee",<%=eee%>);
response.data.add("fff",<%=fff%>);
response.data.add("ggg",<%=ggg%>);
response.data.add("hhh",<%=hhh%>);
response.data.add("phone_no",<%=phone_no%>);
core.rpc.receivePacket(response);