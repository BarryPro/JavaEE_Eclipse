<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	  String send_time  = (String)request.getParameter("send_time");
	  //modify wangyong 20090928
	  //String send_login_no = (String)session.getAttribute("kfWorkNo");
	  String send_login_no = (String)session.getAttribute("workNo");
	  String work_no = (String)session.getAttribute("workNo");
	  String[][] dataRows = new String[][]{};
	  StringBuffer contentList = new StringBuffer();

    String sqlStr = "";
	      sqlStr = "select send_login_no,RECEIVE_LOGIN_NO,to_char(send_time,'hh24:mi:ss'),content from dnoticecontent where send_login_no=:send_login_no and bak1='Y'  and to_char(send_time,'yyyymmdd')=to_char(sysdate,'yyyymmdd') order by send_time  ";
		myParams = "send_login_no="+send_login_no ;
	  //System.out.println("\n\n==============sqlStr k084_shistory_rpc=="+sqlStr);	  
	  //String param = "v1="+send_time;
%>
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
	     	 <wtc:param value="<%=sqlStr%>" />
	     	 <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
				<wtc:array id="queryList"  start="0" length="4" scope="end"/>
<%
				dataRows = queryList;
				for(int i=0;i<dataRows.length;i++){
				  contentList.append("\\r["+work_no); 
				  //contentList.append("   ");
				  contentList.append("] 发给 ["+dataRows[i][1]);
				  contentList.append("]   ");
				  contentList.append("时间:"+dataRows[i][2]);
				  contentList.append("   ");
				  contentList.append("\\r");
				  contentList.append("     ");
				  contentList.append(dataRows[i][3]);
				  contentList.append("\\r");
				}
				//System.out.println("===========dataRows.length="+dataRows.length);
				String contentList_s = contentList.toString();
				contentList_s = contentList_s.replaceAll("\"","'");
				contentList_s = contentList_s.replaceAll("'","\\\\\'");
				contentList_s = contentList_s.replaceAll("\n"," ");
				contentList_s = contentList_s.replaceAll("%2B","+");
%>
var response = new AJAXPacket();
response.data.add("contentList","<%=contentList_s%>");
core.ajax.receivePacket(response);
