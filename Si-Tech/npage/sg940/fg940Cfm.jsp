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
  String beizhu=phoneNo+"进行银行主号码签约";
  String loginAccept = request.getParameter("loginAccept");
	
  
  String custname = request.getParameter("custname");
  String idType = request.getParameter("idType");
  String idIccid = request.getParameter("idIccid");
  String yhbm = request.getParameter("yhbm");
  String yhzhlx = request.getParameter("yhzhlx");
  String yhzh = request.getParameter("yhzh");
  String jffs = request.getParameter("jffs");
  String RechAmount = WtcUtil.repNull((String)request.getParameter("RechAmount"));
  String RechThreshold = WtcUtil.repNull((String)request.getParameter("RechThreshold"));

	String  inputParsm [] = new String[17];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = custname;
	inputParsm[9] = idType;
	inputParsm[10] = idIccid;
	inputParsm[11] = yhbm;
	inputParsm[12] = yhzhlx;
	inputParsm[13] = yhzh;
	inputParsm[14] = jffs;
	inputParsm[15] = RechAmount;
	inputParsm[16] = RechThreshold;
	
%>
	<wtc:service name="sG940Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
			<wtc:param value="<%=inputParsm[12]%>"/>
			<wtc:param value="<%=inputParsm[13]%>"/>
			<wtc:param value="<%=inputParsm[14]%>"/>
			<wtc:param value="<%=inputParsm[15]%>"/>
			<wtc:param value="<%=inputParsm[16]%>"/>
			<wtc:param value="1"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		System.out.println(" ======== sG940Cfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("银行主号码签约成功！",2);
 	      window.location="fg940.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== sG940Cfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fg940.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
