<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String iContactAddr = (String)request.getParameter("iContactAddr");
  System.out.println("-------iContactAddr------->"+iContactAddr);
  String phoneNo = request.getParameter("phoneNo");
  String ioprcode = request.getParameter("optype");
  String loginAccept = request.getParameter("loginAccept");
  String tixingphone = WtcUtil.repNull((String)request.getParameter("tixingphone"));
  
	String  inputParsm [] = new String[9];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = tixingphone;
	inputParsm[8] = iContactAddr;
	
	String servicesname="";
	if(ioprcode.equals("add")) {
				 servicesname="sm092Cfm";
	}else {
		     servicesname="sm092Del";
	}
	
%>
	<wtc:service name="<%=servicesname%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>	
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	String vSrvName = "";
	if("000000".equals(retCode)){

%>	
    <script language="javascript">
  	  <%if(ioprcode.equals("add")) {%>
 	      rdShowMessageDialog("提醒号码增加成功！",2);
 	      window.location="fm092.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	    <%}if(ioprcode.equals("del")) {%>
       	rdShowMessageDialog("提醒号码删除成功！",2);
       	 window.location="fm092.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	    <%}%>
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("操作失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm092.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
