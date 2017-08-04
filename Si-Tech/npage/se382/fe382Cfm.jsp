<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String phoneNo = request.getParameter("phoneNo");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String opNote = request.getParameter("opNote");
		String confimAccept = request.getParameter("confimAccept");
		String password = (String)session.getAttribute("password");
		String oldlogins = request.getParameter("oldlogins");
		String projectType = request.getParameter("projectType");
		String projectCode = request.getParameter("projectCode");
		String serverIp=realip.trim();
		
		String  inputParsm [] = new String[12];
		inputParsm[0] = confimAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = oldlogins;
		inputParsm[8] = serverIp;
		inputParsm[9] = opNote;
		inputParsm[10] = projectType;
		inputParsm[11] = projectCode;
%>
		<wtc:service name="se382Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
	
	if("000000".equals(retCode)){
		%>
		<script language="javascript">
			rdShowMessageDialog("取消成功！",2);
			window.location="fe382.jsp?activePhone=<%=phoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>";
		</script>
		<%
	}else {
				%>
		<script language="javascript">
			rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
			window.location="fe382.jsp?activePhone=<%=phoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>";
		</script>
		<%
		}
%>

