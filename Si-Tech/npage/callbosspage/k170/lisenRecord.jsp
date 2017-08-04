<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	 String orgCode = (String)session.getAttribute("orgCode");
   String regionCode = orgCode.substring(0,2);
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	 String nowYYYYMM =contactId.substring(0, 6);
   
    String table_name="dcallcall"+nowYYYYMM;
		
		String sql= "update "+table_name+" set LISTEN_FLAG='Y' where contact_id =:v1";  
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
	     retMsg = "更新关系失败";
	     out.print("000001");
	  }
	else
		{
			out.print("000000");
		}
	%>







