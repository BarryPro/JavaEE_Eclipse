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
  String sr_phone = request.getParameter("sr_phone");
  String sr_name = request.getParameter("sr_name");
  String zz_jf = request.getParameter("zz_jf");
  String beizhu=zr_phone+"和"+sr_phone+"进行积分转赠";

	String  inputParsm [] = new String[12];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = zr_phone;
	inputParsm[6] = "";
	inputParsm[7] = sr_phone;
	inputParsm[8] = zz_jf;


	
%>
	<wtc:service name="sm213Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
		System.out.println(" ======== sm213Cfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("积分转赠操作成功！",2);
 	      window.location="fm213.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== sm213Cfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("积分转赠操作失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm213.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
