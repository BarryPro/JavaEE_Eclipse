<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	  String send_time  = (String)request.getParameter("send_time");
	  String receive_login_no = (String)session.getAttribute("kfWorkNo");
	  String[][] dataRows = new String[][]{};
	  StringBuffer contentList = new StringBuffer();

    String sqlStr = "";
	     sqlStr = "select send_login_no,content,to_char(send_time,'yyyy-MM-dd hh24:mi:ss') from dnoticecontent where receive_login_no=:receive_login_no and bak1='Y'  and to_char(send_time,'yyyymmdd')=to_char(sysdate,'yyyymmdd') order by send_time ";
	     myParams = "receive_login_no="+receive_login_no ;
	  //String param = "v1="+send_time;
%>
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	     	 <wtc:param value="<%=sqlStr%>" />
	     	 <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
				<wtc:array id="queryList"  start="0" length="3" scope="end"/>
<%
				dataRows = queryList;
				for(int i=0;i<dataRows.length;i++){
				  contentList.append(dataRows[i][0]);
				  contentList.append("   ");
				  contentList.append(dataRows[i][1]);
				  contentList.append("   ");
				  contentList.append(dataRows[i][2]);
				  contentList.append("\\r");
				}
				System.out.println("===========dataRows.length="+dataRows.length);
%>
var response = new AJAXPacket();
response.data.add("contentList","<%=contentList.toString()%>");
core.ajax.receivePacket(response);
