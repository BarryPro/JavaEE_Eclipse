<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName"); 
  String liushui = request.getParameter("opAccept"); 

	String  inputParsm [] = new String[12];
	inputParsm[0] = liushui.trim();
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";


	
%>
	<wtc:service name="sm292Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
%>	
    <script language="javascript">
 	      rdShowMessageDialog("外省有价卡登记冲正成功！",2);
 	      window.location="fm292.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
%>
  	<script language="javascript">
 	    rdShowMessageDialog("外省有价卡登记冲正失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm292.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
