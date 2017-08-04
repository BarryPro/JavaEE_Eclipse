<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String loginAccept = request.getParameter("sysAccept");
		String phoneNo = request.getParameter("phoneNo");
		String opCode = request.getParameter("opCode");
		String selectvalues = request.getParameter("selectvalues");
		String opName = request.getParameter("opName");
		String locatiurl = request.getParameter("locatiurl");
		String shijianxianzhi = request.getParameter("shijianxianzhi");
		String qiyedaima = request.getParameter("qiyedaima");
		String yewudaima = request.getParameter("yewudaima");
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = qiyedaima;
		inputParsm[8] = yewudaima;
		inputParsm[9] = selectvalues;
		inputParsm[10] = shijianxianzhi;
%>
		<wtc:service name="sg511Cfm" routerKey="region" routerValue="<%=regionCode%>"
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
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		%>	
  <script language="javascript">
 	rdShowMessageDialog("操作成功！",2);
 	window.location="<%=locatiurl%>?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";

 	</script>
 	<%
	}
else {

	%>
  	<script language="javascript">
 	rdShowMessageDialog("操作失败，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		window.location="<%=locatiurl%>?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	</script>
 	<%
	}
%>
