<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	if(contactId!=null&&!contactId.equals("")&&contactId.length()>6){
  String nowYYYYMM =contactId.substring(0, 6);
  String table_name="dcallcall"+nowYYYYMM;
/**old sql  String sql="update "+table_name+" set TRANS_FLAG='Y' where contact_id ='"+contactId+"'"; 
*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String sql="update "+table_name+" set TRANS_FLAG='Y' where contact_id = :v1 ";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=contactId%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "更新来电信息表失败";
	  }
	  }
	%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

