<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String beizhu=workNo+"对号码"+phoneNo+"进行终端套餐办理操作";
  String loginAccept = request.getParameter("loginAccept");
  String groupId = (String)session.getAttribute("groupId");
	
 String custname = WtcUtil.repNull((String)request.getParameter("custname"));
 String iofferid = WtcUtil.repNull((String)request.getParameter("iofferid"));

 String imeino = WtcUtil.repNull((String)request.getParameter("imeino"));

	String  inputParsm [] = new String[9];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = imeino;
	inputParsm[8] = "1";


%>
	<wtc:service name="sOfferChgCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
      <wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=iofferid%>"/>
			<wtc:param value="1"/>
			<wtc:param value=""/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){	

%>	
	<wtc:service name="sOfferImeiCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodess" retmsg="retMsgss" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=iofferid%>"/>

	</wtc:service>
	<wtc:array id="retss" scope="end"/>
<%
		if("000000".equals(retCodess)){
%>
    <script language="javascript">
 	      rdShowMessageDialog("终端型号捆绑套餐办理成功！",2);
 	      window.location="fm135.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
 	  </script>

<%
  }else {
%>
  	<script language="javascript">
 	    rdShowMessageDialog("终端型号捆绑套餐办理失败！，错误代码：<%=retCodess%> ，错误信息：<%=retMsgss%>",0);
 		  window.location="fm135.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
 	  </script>
<%}
}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("终端型号捆绑套餐办理失败！，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm135.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
 	  </script>
<%
	}
%>
