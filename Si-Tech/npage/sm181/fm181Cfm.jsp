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
  String beizhu=zr_phone+"和"+sr_phone+"进行积分转赠设置";
  String sr_name = request.getParameter("sr_name");
  String sr_zjlx = request.getParameter("sr_zjlx");
  String sr_cardno = request.getParameter("sr_cardno");
  String banlitype = request.getParameter("banlitype");
  String xuanzhongsrephone = request.getParameter("srephonenumber");
  
  

	String  inputParsm [] = new String[12];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = zr_phone;
	inputParsm[6] = "";
	inputParsm[7] = banlitype;
	inputParsm[8] = xuanzhongsrephone;
	inputParsm[9] = sr_zjlx;
	inputParsm[10] = sr_cardno;
	inputParsm[11] = sr_phone;
		


	
%>
	<wtc:service name="sm181Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
			<wtc:param value="0003"/>
			<wtc:param value="<%=inputParsm[11]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		System.out.println(" ======== fm181Cfm 调用成功 ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("积分受让人设置成功！",2);
 	      window.location="fm181.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== fm181Cfm 调用失败 ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("积分受让人设置失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm181.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
