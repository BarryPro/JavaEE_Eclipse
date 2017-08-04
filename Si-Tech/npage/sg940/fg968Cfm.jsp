<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String opCode = request.getParameter("opCode");
  String fuphoneNo = request.getParameter("fuphoneNo");
 	String beizhu="主号"+phoneNo+"和副号"+fuphoneNo+"进行银行副号码签约确认";
  String loginAccept = request.getParameter("loginAccept");
	String opName = request.getParameter("opName");
  
	String  inputParsm [] = new String[12];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = "01";
	inputParsm[9] = phoneNo;
	inputParsm[10] = "01";
	inputParsm[11] = fuphoneNo;
	
%>
	<wtc:service name="sG968Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
		System.out.println(" ======== sG968Cfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("银行副号码签约成功！",2);
 	      window.location="fg968.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== sG968Cfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fg968.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
