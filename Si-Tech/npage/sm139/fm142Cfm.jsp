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
  String beizhu=workNo+"对号码"+phoneNo+"进行集团订单换号开户操作";
  String loginAccept = request.getParameter("loginAccept");
  String groupId = (String)session.getAttribute("groupId");
	
 String custname = WtcUtil.repNull((String)request.getParameter("custname"));
 String userpwd = WtcUtil.repNull((String)request.getParameter("userpwd"));
 String newPWD =(String)Encrypt.encrypt(userpwd);
 String iccidkh = WtcUtil.repNull((String)request.getParameter("iccidkh"));
 String newSmCode = WtcUtil.repNull((String)request.getParameter("newSmCode"));
 String offerId = WtcUtil.repNull((String)request.getParameter("offerId"));
 String lianxiren = WtcUtil.repNull((String)request.getParameter("lianxiren"));
 String lianxirenphone = WtcUtil.repNull((String)request.getParameter("lianxirenphone"));
 String dizhi = WtcUtil.repNull((String)request.getParameter("dizhi"));
 String youbian = WtcUtil.repNull((String)request.getParameter("youbian"));
 String simTypeCfm = WtcUtil.repNull((String)request.getParameter("simTypeCfm"));
 String simCode = WtcUtil.repNull((String)request.getParameter("simCodeCfm"));
 String cardTypeN = WtcUtil.repNull((String)request.getParameter("cardTypeN"));
    

	String  inputParsm [] = new String[40];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = userpwd;
	inputParsm[7] = beizhu;
	inputParsm[8] = groupId;
	inputParsm[9] = custname;
	inputParsm[10] = userpwd;
	inputParsm[11] = "0";
	inputParsm[12] = iccidkh;
	inputParsm[13] = "";
	inputParsm[14] = newSmCode;
	inputParsm[15] = offerId;
	inputParsm[16] = "";
	inputParsm[17] = "0";
	inputParsm[18] = lianxiren;
	inputParsm[19] = lianxirenphone;
	inputParsm[20] = dizhi;
	inputParsm[21] = "";
	inputParsm[22] = dizhi;
	inputParsm[23] = cardTypeN;
	inputParsm[24] = "";
	inputParsm[25] = youbian;
	inputParsm[26] = "";
	inputParsm[27] = "";
	inputParsm[28] = "";
	inputParsm[29] = "";
	inputParsm[30] = "";
	inputParsm[31] = "";
	inputParsm[32] = "";
	inputParsm[33] = "";
	inputParsm[34] = "";
	inputParsm[35] = "";
	inputParsm[36] = simTypeCfm;
	inputParsm[37] = "";
	inputParsm[38] = "";
	inputParsm[39] = simCode;

	
%>
	<wtc:service name="sPayWebOpenCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
			<wtc:param value="<%=inputParsm[17]%>"/>
			<wtc:param value="<%=inputParsm[18]%>"/>
			<wtc:param value="<%=inputParsm[19]%>"/>
			<wtc:param value="<%=inputParsm[20]%>"/>
			<wtc:param value="<%=inputParsm[21]%>"/>
			<wtc:param value="<%=inputParsm[22]%>"/>
			<wtc:param value="<%=inputParsm[23]%>"/>
			<wtc:param value="<%=inputParsm[24]%>"/>
			<wtc:param value="<%=inputParsm[25]%>"/>
			<wtc:param value="<%=inputParsm[26]%>"/>
			<wtc:param value="<%=inputParsm[27]%>"/>
			<wtc:param value="<%=inputParsm[28]%>"/>
			<wtc:param value="<%=inputParsm[29]%>"/>
			<wtc:param value="<%=inputParsm[30]%>"/>
			<wtc:param value="<%=inputParsm[31]%>"/>
			<wtc:param value="<%=inputParsm[32]%>"/>
			<wtc:param value="<%=inputParsm[33]%>"/>	
			<wtc:param value="<%=inputParsm[34]%>"/>
			<wtc:param value="<%=inputParsm[35]%>"/>
			<wtc:param value="<%=inputParsm[36]%>"/>
			<wtc:param value="<%=inputParsm[37]%>"/>
			<wtc:param value="<%=inputParsm[38]%>"/>
			<wtc:param value="<%=inputParsm[39]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		System.out.println(" ======== sPayWebOpenCfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("集团订单换号开户成功！",2);
 	      window.location="fm139.jsp?opCode=m139&opName=校园营销活动订单查询";
 	  </script>
<%}else{
	  System.out.println(" ======== sG940Cfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("集团订单换号开户失败！，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm139.jsp?opCode=m139&opName=校园营销活动订单查询";
 	  </script>
<%
	}
%>
