<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
   
  String loginAccept = request.getParameter("loginAccept");
  String ywaccept = request.getParameter("accepts");
  String workorgcode = request.getParameter("workorgcode");
  String noteopr =workNo+"进行员工任务记录删除操作";

  
	String  inputParsm [] = new String[12];
	inputParsm[0] = ywaccept;
	inputParsm[1] = "01";
	inputParsm[2] = "m273";
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = noteopr;
	inputParsm[8] = workorgcode;



	
%>
	<wtc:service name="sm273Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
	if("000000".equals(retCode)){
	
%>	
    <script language="javascript">
 	      rdShowMessageDialog("员工任务记录删除成功！",2);
 	      window.location="fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("员工任务记录删除失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm272.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
