<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%


	/*===========获取参数============*/
	String iLoginAccept = (String)request.getParameter("iLoginAccept");
  String iChnSource = (String)request.getParameter("iChnSource");
	String iOpCode = (String)request.getParameter("iOpCode");
	String opCode = iOpCode;
	
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	System.out.println("gao=====================iPhoneNo==="+iPhoneNo);	

 	String opName = 	(String)request.getParameter("opName"); 	
  String regionCode = (String)session.getAttribute("regCode");		
  
  String[] iPhoneNoArrs = new String[]{""};

  
  iPhoneNoArrs = iPhoneNo.split(",");

  
  if(iPhoneNoArrs.length == 0){
		iPhoneNoArrs = new String[]{""};
	}

  
  String inParam[] = new String[5];
  
  inParam[0] =  iLoginAccept  				;                 
  inParam[1] =  iChnSource           ;
  inParam[2] =  iOpCode              ;                  
  inParam[3] =  iLoginNo             ;                  
  inParam[4] =  iLoginPwd            ;                  
     
 
String beizhu ="工号"+iLoginNo+"进行虚拟副号批量开户";
  
  
%>

<wtc:service name="sm165Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=inParam[0]%>" />
		<wtc:param value="<%=inParam[1]%>" />
		<wtc:param value="<%=inParam[2]%>" />
		<wtc:param value="<%=inParam[3]%>" />
		<wtc:param value="<%=inParam[4]%>" />
		<wtc:params value="<%=iPhoneNoArrs%>" />
		<wtc:param value="" />
		<wtc:param value="<%=beizhu%>" />

		
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务 sBatchCustCfm in fm108BatCfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println(" 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location.href="fm165.jsp?opCode=<%=iOpCode%>&opName=<%=opName%>";
	</script>
<%
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
			<%if(errCode.equals("0")||errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">失败条数：<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>手机号码</th>
				<th>失败原因</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>
			 <tr> 
					<td align="center" colspan="2" id="footer">
						<input class="b_foot" name="sure"  type="button" value="返回"  onclick="window.location.href='fm165.jsp?opCode=<%=iOpCode%>&opName=<%=opName%>';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

