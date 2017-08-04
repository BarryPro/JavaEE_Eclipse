<%
  /*
   * 功能: 插入按键
　 * 版本: 1.0.0
　 * 日期: 2009/04/10
　 * 作者: tancf
　 * 版权: sitech
   *update:
　*/
%>


<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  java.util.Date current=new java.util.Date();
	java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMM"); 
	String table_name="dbcontact.dcontacttrack"+sdf.format(current);
	
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contact_id = WtcUtil.repNull(request.getParameter("contact_id"));
   String track_info = WtcUtil.repNull(request.getParameter("track_info"));
   		String sql= "insert into "+table_name+" (contact_id,track_id,contact_accept,tract_info)values "+
		"('"+contact_id+"','01','"+contact_id+"','"+track_info+"')";
//System.out.println("CCCCCCCCCCCCCCCCCCCCCCCC"+sql);
%>
	<wtc:service name="sPubModify" outnum="2">
			<wtc:param value="<%=sql%>"/>
				<wtc:param value="dbcntt"/>
				
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


