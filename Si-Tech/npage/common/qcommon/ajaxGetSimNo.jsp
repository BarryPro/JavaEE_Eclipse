<%
  /*
   * 功能:查询帐号
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: zhanghb
　 * 版权: sitech
　*/
%> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

String phHd = request.getParameter("phHd");
String regionCode = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");
String retSimNo = "";
//String sqlStr1 = "select sim_no  from dSimRes  where phoneno_head ='"+phHd+"' and group_id in ('"+groupId+"','10014') and sim_type='10049' and sim_status='2'  and op_time<sysdate and rownum<2";
String sqlStr1 = "select sim_no from dblkcarddata where sim_type='10049' and phoneno_head='"+phHd+"' and sim_status='2' and group_id in ('"+groupId+"','10014') and rownum =1";
System.out.println("-------sqlStr1---------"+sqlStr1);
%>
 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	 	
<%
if(result_t.length>0&&result_t[0][0]!=null){
	retSimNo = result_t[0][0];
}
System.out.println("-------retSimNo-----------"+retSimNo);
%>	 	
var response = new AJAXPacket();
response.data.add("retSimNo","<%= retSimNo %>");
core.ajax.receivePacket(response);
