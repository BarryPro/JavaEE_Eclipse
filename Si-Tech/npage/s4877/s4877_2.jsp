<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1270.viewBean.*" %>
<%@ page import="java.util.*;"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	String[][] tri_metaData = new String [][]{};
	String phone_no = request.getParameter("phone_no");
	String year_month = request.getParameter("year_month");
	System.out.println("phone_no:"+phone_no);
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfo = (String[][])arr.get(0);
  String workno = baseInfo[0][2];
  String return_code = "";
  String return_msg = "";
  String paraAray[] = new String[3];
  boolean flag = false;
  paraAray[0] = phone_no;
	paraAray[1] = workno;
	paraAray[2] = year_month;
	int arrayLength = 1;
	System.out.println("workno:"+workno);

	try{

%>

<wtc:service name="s4877Query" outnum="11">
	<wtc:params value="<%=paraAray%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />

<%
	
	System.out.println("==========result1.length============"+result1.length);
	
	tri_metaData = result1;
	System.out.println("===========tri_metaData.length==============" + tri_metaData.length);
	return_code = tri_metaData[0][0];
	System.out.println("return_code:"+return_code);
	return_msg = tri_metaData[0][1];
	System.out.println("return_msg" + return_msg);

	arrayLength = tri_metaData.length;
	String tri_metaDataStr = CreatePlanerArray.createArray("js_tri_metaDataStr",arrayLength);
	System.out.println(tri_metaDataStr);
%>

<%=tri_metaDataStr%>

<%
  for(int p = 0; p < tri_metaData.length; p++){
	  for(int q = 0; q < tri_metaData[p].length; q++ ){
	  	
	  	System.out.println(tri_metaData[p][q]);
	  	if(tri_metaData[p][q] == null){
	  		tri_metaData[p][q] = "";
	  	}
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
  flag = true;
  }catch(Exception e){
  	e.printStackTrace();
  	return_code = "no_message";
  	return_msg = "此用户该月没有停机信息！";
	}
%>

var response = new RPCPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("return_code","<%=return_code%>");
response.data.add("return_msg","<%=return_msg%>");

<%
if(flag){
%>
response.data.add("tri_list",js_tri_metaDataStr);
<%
}
%>

core.rpc.receivePacket(response);