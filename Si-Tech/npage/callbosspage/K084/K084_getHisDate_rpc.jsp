<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
		  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	  String send_login_no     = WtcUtil.repNull(request.getParameter("send_login_no"));
	  StringBuffer contentListBuf = new StringBuffer();
	  String isMore="N";
	  
    String strSql="select send_login_no,content,to_char(send_time,'yyyy-mm-dd hh24:mi:ss'),read_flag  from dnoticecontent where send_login_no=:send_login_no and to_char(sysdate,'yyyymmdd')=to_char(send_time,'yyyymmdd') and bak1='Y' ";
    myParams = "send_login_no="+send_login_no ; 
%>	  
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
	       <wtc:param value="<%=strSql%>"/>
	       <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
      <wtc:array id="queryList"  scope="end"/>
 <%
int loop=queryList.length;
if(loop>8){
  loop=8;
  isMore="Y";
}
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");  
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");       
     contentListBuf.append("工号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时间<br>");  
   for(int i=0;i<loop;i++){
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");  
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");       
     contentListBuf.append(queryList[i][0]);
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");  
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");       
     contentListBuf.append(queryList[i][1]);
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");  
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");       
     contentListBuf.append(queryList[i][2]);
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");  
     contentListBuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");            
     //contentListBuf.append(queryList[i][3]);  
     contentListBuf.append("<br>");   
   }
  String contentList =  contentListBuf.toString();
  if(contentList.endsWith(",")){
    contentList = contentList.substring(0,contentList.length()-1);
  }
  System.out.println("\n\n\n====contentList=="+contentList);
%>
var response = new AJAXPacket();
response.data.add("contentList",'<%=contentList%>');
response.data.add("isMore",'<%=isMore%>');
core.ajax.receivePacket(response);
