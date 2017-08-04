<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
	String old_rush_contact_id=request.getParameter("old_rush_contact_id");
	String contact_id=request.getParameter("contact_id");
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	old_rush_contact_id="2"+old_rush_contact_id;
	
	java.util.Date current=new java.util.Date();
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMM"); 
  String table_name="dcallcall"+sdf.format(current);
	
	String sql="update "+table_name+" set fax_no=:v1 , trans_flag='1' where contact_id=:v2";
	System.out.println("进入updatePublic_monitor.jsp页面======="+sql);
	System.out.println("进入updatePublic_monitor.jsp页面=======contact_id+"+contact_id+"***old_rush_contact_id="+old_rush_contact_id);
	
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=contact_id%>"/>
	<wtc:param value="<%=old_rush_contact_id%>"/>
</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败1";
	  }
	%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);	