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
  String zr_phone = request.getParameter("zr_phone");
  String offeridstr = request.getParameter("offeridstr");
  
  String org_code = (String)session.getAttribute("orgCode");
  String ipAddrss = (String)session.getAttribute("ipAddr");

  String beizhu=workNo+"取消"+zr_phone+"的已下线特服["+offeridstr+"]";

	String  inputParsm [] = new String[19];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = zr_phone;
	inputParsm[6] = "";
	inputParsm[7] = org_code;
	inputParsm[8] = offeridstr;
	inputParsm[9] = "";
	inputParsm[10] = "";
	inputParsm[11] = "";
	inputParsm[12] = "";
	inputParsm[13] = "";
	inputParsm[14] = "0";
	inputParsm[15] = "0";
	inputParsm[16] = beizhu;
	inputParsm[17] = "";
	inputParsm[18] = ipAddrss;

	
%>
	<wtc:service name="s1219Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		System.out.println(" ======== s1219Cfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("取消已下线特服成功！",2);
 	      window.location="fm322.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== sm185Req 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("取消已下线特服失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm322.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
