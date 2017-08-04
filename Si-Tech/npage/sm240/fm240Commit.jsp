<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String loginAccept = request.getParameter("sysAccept");
  
  String oldbegin = WtcUtil.repNull((String)request.getParameter("oldbegin"));
  String oldend = WtcUtil.repNull((String)request.getParameter("oldend"));	
  String newbegin = WtcUtil.repNull((String)request.getParameter("newbegin"));	
  String newend = WtcUtil.repNull((String)request.getParameter("newend"));	
  String opflag = WtcUtil.repNull((String)request.getParameter("opflag"));	
  String filenamess = WtcUtil.repNull((String)request.getParameter("filenamess"));
  String orgCode = (String)session.getAttribute("orgCode");
  String isgua = WtcUtil.repNull((String)request.getParameter("isgua"));
  String ischong = WtcUtil.repNull((String)request.getParameter("ischong"));


	String  inputParsm [] = new String[17];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = oldbegin+"|"+oldend;
	inputParsm[8] = newbegin+"|"+newend;
	inputParsm[9] = filenamess;
	inputParsm[10] = opflag;
	inputParsm[11] = orgCode;
	inputParsm[12] = isgua+"|"+ischong;

	
%>
	<wtc:service name="s3075CfmBat" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){

%>	
    <script language="javascript">
 	      rdShowMessageDialog("特定有价卡换卡操作成功！",2);
 	      window.location="fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	
%>
  	<script language="javascript">
 	    rdShowMessageDialog("特定有价卡换卡操作失败，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
