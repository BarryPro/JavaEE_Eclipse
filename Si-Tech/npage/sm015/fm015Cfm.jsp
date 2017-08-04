<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String beizhu=workNo+"对号码"+phoneNo+"进行营销案实物领取登记操作";
  String loginAccept = request.getParameter("loginAccept");
  String groupId = (String)session.getAttribute("groupId");
	
 String custname = WtcUtil.repNull((String)request.getParameter("custname"));
 String iofferid = WtcUtil.repNull((String)request.getParameter("iofferid"));

 String giftcode = WtcUtil.repNull((String)request.getParameter("giftcode"));

	String  inputParsm [] = new String[9];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";

%>
	<wtc:service name="sM015Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
 	      rdShowMessageDialog("营销案实物领取登记成功！",2);
 	      window.location="fm015Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
 	  </script>

<%
}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("营销案实物领取登记失败！，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm015Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
 	  </script>
<%
	}
%>
