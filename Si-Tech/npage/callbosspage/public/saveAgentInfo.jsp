<%
	/*
	 * 功能: 保存各种状态下时间
	 * 版本: 1.0
	 * 日期: 2008/12/21
	 * 作者: lijin 
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
   
   String oprId=""; 
   String sqlStr ="";
   String oprType="";
   String WorkNo="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);  
   String sql="select to_char(sysdate,'yyyymmdd')||lpad(seq_agentopt_id.NEXTVAL,7,0) partoderid  from dual";
 
%>
<wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=sql%>"/>
</wtc:service>
<wtc:array id="rows"  scope="end"/>
<%
   oprId=rows[0][0];
   System.out.println("oprId"+oprId);
   oprType=request.getParameter("oprType");
   //String WorkNo=(String)session.getAttribute("kfWorkNo");
    WorkNo=request.getParameter("WorkNo");
   //System.out.println("aaaaaaaaaaaaaaaaaaa"+WorkNo);
   String otherNo=request.getParameter("otherNo");
   System.out.println("otherNo"+otherNo);
   if(!WorkNo.equals("")&& WorkNo!=null){
/** old sql: sqlStr="insert into dagentoprinfo(partid,staffno,operate_begin,operate_type,operate_object,partoderid) values(to_char(sysdate,'mmdd'),'"+WorkNo+"',sysdate,'"+oprType+"','"+otherNo+"','"+oprId+"')";
*/
	   String orgCode = (String)session.getAttribute("orgCode");
	   String regionCode = orgCode.substring(0,2);
	   sqlStr="insert into dagentoprinfo(partid,staffno,operate_begin,operate_type,operate_object,partoderid) values(to_char(sysdate,mmdd), :v1 ,sysdate, :v2 , :v3 , :v4 )";

   }
   //System.out.println("aaaaaaaaaaaaaaaaaaa"+sqlStr);
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=WorkNo%>"/>
	<wtc:param value="<%=oprType%>"/>
	<wtc:param value="<%=otherNo%>"/>
	<wtc:param value="<%=oprId%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("WorkNo","<%=WorkNo%>");
core.ajax.receivePacket(response);

	
