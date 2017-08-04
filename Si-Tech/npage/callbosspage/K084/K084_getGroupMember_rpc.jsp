<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	  String class_id  = (String)request.getParameter("class_id");
	  StringBuffer memberListBuf = new StringBuffer();
	  String sqlStr = "";
	  String memberList = "";
	  if(null!=class_id&&!("".equals(class_id))){
	  	sqlStr = "select t1.kf_no from dstaffstatus t1,scallclass t2 where t2.class_id=:class_id and t1.class_id=t2.class_id";
	  	myParams = "class_id="+class_id ;
	  }else{
	  	sqlStr = "select t1.kf_no from dstaffstatus t1,scallclass t2 where t1.class_id=t2.class_id";
	  }

%>
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	       <wtc:param value="<%=sqlStr%>" />
	       <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
      <wtc:array id="queryList"  scope="end"/>
<%
   for(int i=0;i<queryList.length;i++){
     memberListBuf.append(queryList[i][0]);
     memberListBuf.append(",");
   }
  memberList =  memberListBuf.toString();
  if(memberList.endsWith(",")){
    memberList = memberList.substring(0,memberList.length()-1);
  }
  System.out.println("\n\n\n======"+memberList);
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("memberList","<%=memberList%>");
core.ajax.receivePacket(response);