<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String op_strong_pwd  = (String)session.getAttribute("password");//µÇÂ½ÃÜÂë
		String opCode = request.getParameter("opCode");
		String modelCode = request.getParameter("modelCode");
		String fileName = request.getParameter("fileName");
		String method = request.getParameter("method");
		String filePath = request.getRealPath("/npage/tmp/");
		System.out.println("-liujian-opCode=" + opCode + "--modelCode=" + modelCode + "--method=" + method);
		System.out.println("-liujian-fileName=" + fileName + "--filePath=" + filePath);
		System.out.println("-liujian-realip=" + realip);
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
	if(method != null && method != "" && method.equals("search")) {
%>
		<wtc:service name="sg079Qry" routerKey="phone" retcode="retCodeQry" retmsg="retMsgQry" outnum="7">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>	
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=modelCode%>"/>
		</wtc:service>
		<wtc:array id="qryRst"  scope="end"/>	
		var array = [];
<%
	  if(retCodeQry.equals("000000")) {
			//·â×°jsÊý×é
			for(int i=0;i<qryRst.length;i++) 
			{
		%>
				var fileObj = {};
				fileObj.fnName   = '<%=qryRst[i][0]%>';
				fileObj.opNote   = '<%=qryRst[i][1]%>';
				fileObj.opTime   = '<%=qryRst[i][2]%>';
				fileObj.dealMsg  = '<%=qryRst[i][3]%>';
				fileObj.dealTime = '<%=qryRst[i][4]%>';
				fileObj.dealMsg2 = '<%=qryRst[i][5]%>';
				fileObj.fileName = '<%=qryRst[i][6]%>';
				array.push(fileObj);
		<%
			}
	 }	
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCodeQry %>");
		response.data.add("retmsg","<%= retMsgQry %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
    }else if(method != null && method != "" && method.equals("download")) {
%>
		<wtc:service name="sg079File" routerKey="phone" retcode="retCodeDown" retmsg="retMsgDown" outnum="7">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>	
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=fileName%>"/>
			<wtc:param value="<%=realip%>"/>
			<wtc:param value="<%=filePath%>"/>
		</wtc:service>
		<wtc:array id="downRst"  scope="end"/>	
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCodeDown %>");
		response.data.add("retmsg","<%= retMsgDown %>");
		response.data.add("fileName","<%= fileName %>");
		
		core.ajax.receivePacket(response);
<%
  } 
%>