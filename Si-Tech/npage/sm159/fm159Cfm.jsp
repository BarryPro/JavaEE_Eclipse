<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
 
  String srv_no = WtcUtil.repNull((String)request.getParameter("srv_no"));
  //String userpwd = WtcUtil.repNull((String)request.getParameter("userpwd"));
  String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
  String banlitype = WtcUtil.repNull((String)request.getParameter("banlitype"));
  
   
  String loginAccept = request.getParameter("loginAccept");
  String groupId = (String)session.getAttribute("groupId");
	
	String  inputParsm [] = new String[16];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = "m159";
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = srv_no;
	inputParsm[6] = "";
	inputParsm[7] = "ZY";
	inputParsm[8] = "045106";
	inputParsm[9] = "ZY0601";
	inputParsm[10] = "06";
	inputParsm[11] = current_timeNAME;
	inputParsm[12] = "20501230000000";
	inputParsm[13] = current_timeNAME;
	inputParsm[14] = "二维码身份标识受理";
	inputParsm[15] = banlitype;

		
%>
	<wtc:service name="sProWorkFlowCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		System.out.println(" ======== sProWorkFlowCfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("二维码身份标识受理成功！",2);
 	      window.location="fm159.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== sProWorkFlowCfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("二维码身份标识受理失败！，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm159.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
