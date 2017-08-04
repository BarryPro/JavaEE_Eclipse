<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String ioprcode = request.getParameter("ioprcode");
  String loginAccept = request.getParameter("loginAccept");
  String opName = request.getParameter("opName");
  String opCode = request.getParameter("opCode");
   String beizhu=phoneNo+"进行副号签约黑名单管理";



	String  inputParsm [] = new String[11];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = "01";
	inputParsm[9] = phoneNo;
	inputParsm[10] = ioprcode;
%>
	<wtc:service name="sG970Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
	String vSrvName = "";
	if("000000".equals(retCode)){
		System.out.println(" ======== sG970Cfm 调用成功 ========");
%>	
    <script language="javascript">
  	  <%if(ioprcode.equals("0")) {%>
 	      rdShowMessageDialog("副号签约黑名单增加成功！",2);
 	      window.location="fg970.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	    <%}if(ioprcode.equals("1")) {%>
       	rdShowMessageDialog("副号签约黑名单删除成功！",2);
       	window.location="fg970.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	    <%}%>
 	  </script>
<%}else{
	  
%>
  	<script language="javascript">
 	    rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fg970.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
