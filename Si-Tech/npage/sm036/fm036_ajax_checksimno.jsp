<%
  /*
   * ����: 4G��������¼�� m036
   * �汾: 1.0
   * ����: 2016/3/31 
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String simNo = request.getParameter("simNo");
	String notes = "��ѯsim����groupid";
	
	String regCode = (String)session.getAttribute("regCode");
	String[] inParams = new String[2];
	inParams[0] = "select group_id from dsimres where sim_no=:sim_no";
	inParams[1] = "sim_no="+simNo;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
	<% if("000000".equals(retCode)){%>
		var response = new AJAXPacket();
		response.data.add("simgroupid","<%=result.length>0?result[0][0]:""%>");
		core.ajax.receivePacket(response);
	<%}else{%>
		var response = new AJAXPacket();
		response.data.add("simgroupid","abcd");
		core.ajax.receivePacket(response);
	<%}%>
