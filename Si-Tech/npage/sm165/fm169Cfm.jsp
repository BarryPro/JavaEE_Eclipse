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
  String beizhu=phoneNo+"进行银行副号码解约";
  String loginAccept = request.getParameter("loginAccept");

  String fuphoneno = request.getParameter("fuphoneno");
  
  if("ALL".equals(fuphoneno)) {
  	fuphoneno="";
  }

	String  inputParsm [] = new String[9];
	inputParsm[0] = "";
	inputParsm[1] = "08";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = fuphoneno;
	
%>
	<wtc:service name="sm169Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
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
	if(!"000000".equals(retCode)){
		System.out.println(" ======== sG970Cfm 调用成功 ========");
%>	
  	<script language="javascript">
 	    rdShowMessageDialog("取消虚拟副号失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm169.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else {	
	System.out.println(" ======== retlength ========"+ret.length);
 if(ret.length>0 && ret[0][0].equals("")) {
   
%>	
  	<script language="javascript">
 	    rdShowMessageDialog("取消虚拟副号成功！",2);
 		  window.location="fm169.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<% 		
 } 
  if(ret.length==0) {
   
%>	
  	<script language="javascript">
 	    rdShowMessageDialog("取消虚拟副号成功！",2);
 		  window.location="fm169.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<% 		
 }
 
 }
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
	</script>
</head>
<body>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">错误信息列表</div>
	</div>
	<div>
		<table>

			<tr>
				<th>副号</th>
				<th>失败原因</th>
			</tr>
			
				<%if(retCode.equals("0")||retCode.equals("000000")){
				  if(ret.length>0) {
				  		 String[] phonestr1=ret[0][0].split("|");
				  		 String[] reson1=ret[0][1].split("|");
				  
					for(int i=0;i<phonestr1.length;i++){
				%>
				<tr>
					<td><%=phonestr1[i]%></td>
					<td><%=reson1[i]%></td>
				</tr>
				<%
				}
				}
				}%>
			 <tr> 
					<td align="center" colspan="2" id="footer">
						<input class="b_foot" name="sure"  type="button" value="返回"  onclick="window.location.href='fm169.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>