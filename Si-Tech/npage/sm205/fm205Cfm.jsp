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
 
  String srv_no = WtcUtil.repNull((String)request.getParameter("phoneNo"));
  String offer_id = WtcUtil.repNull((String)request.getParameter("offer_id"));
  String newOffer_id = WtcUtil.repNull((String)request.getParameter("newOffer_id"));
  
  
  String changeopcode = WtcUtil.repNull((String)request.getParameter("changeopcode"));
  String banlitype = WtcUtil.repNull((String)request.getParameter("banlitype"));
  
  String loginAccept = WtcUtil.repNull((String)request.getParameter("loginAccept"));
  
  
  String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
  
  
   

  String groupId = (String)session.getAttribute("groupId");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = srv_no;
	inputParsm[6] = "";
	inputParsm[7] = "ZY";
	inputParsm[8] = "045107";
	inputParsm[9] = "ZY0701";
	inputParsm[10] = banlitype;
	inputParsm[11] = current_timeNAME;
	inputParsm[12] = "20501230000000";
	inputParsm[13] = current_timeNAME;
	inputParsm[14] = "和生活会员管理";
	inputParsm[15] = offer_id;
	inputParsm[16] = newOffer_id;
	
	String returnmsg="";
		  if("m205".equals(opCode)) {
	       returnmsg="和生活会员管理订购";
			}else if("m206".equals(opCode)) {
			   returnmsg="和生活会员管理变更";
			}else if("m207".equals(opCode)) {
			   returnmsg="和生活会员管理退订";
			}
		
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
			<wtc:param value="<%=inputParsm[16]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>

<%
	if("000000".equals(retCode)){

%>	

    <script language="javascript">
 	      rdShowMessageDialog("<%=returnmsg%>成功！",2);
 	      //window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=srv_no%>";
 	      removeCurrentTab();
 	  </script>

<%
}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("<%=returnmsg%>失败！，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=srv_no%>";
 	  </script>
<%
	}
%>
