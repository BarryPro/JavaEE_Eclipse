<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
  String nowYYYYMM =contactId.substring(0, 6);
  String retType = WtcUtil.repNull(request.getParameter("retType"));
  String table_name="dcallcall"+nowYYYYMM;
  String sql="select accept_long from "+table_name+"  where contact_id =:contactId"; 
  myParams = "contactId="+contactId ;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams%>"/>
			</wtc:service>
		<wtc:array id="tSqlTempData"  scope="end"/>



var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("totalnum","<%=tSqlTempData[0][0]%>");
core.ajax.receivePacket(response);

	
	

