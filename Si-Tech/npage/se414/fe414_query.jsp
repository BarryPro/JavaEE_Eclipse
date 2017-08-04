<%
/********************
 * version v2.0
 * 开发商: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		
		String password = (String)session.getAttribute("password");		
		String regionCode= (String)session.getAttribute("regCode");
		String groupId= (String)session.getAttribute("groupId");
		
		String phoneNo = request.getParameter("phoneNo");
		String idcard = request.getParameter("idcard");
		String opCode 	= request.getParameter("opCode");
		%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
			<%
			String  inputParsm [] = new String[10];
			inputParsm[0] = "";
			inputParsm[1] = "";
			inputParsm[2] = opCode;
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";
			inputParsm[7] = "工号"+workNo+"执行特殊号码工单受理查询";
			inputParsm[8] = phoneNo;
			inputParsm[9] = idcard;

			%>
					<wtc:service name="sE414Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="13">
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
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sE414Qry 调用成功 ========"  + retCode + " | " + retMsg);
		%>
<body>
							<table cellspacing="0">
							<tr >
								<th>预开户手机号码</th>
								<th>号码状态</th>
								<th>工单生成工号</th>
								<th>工单生成时间</th>
								<th>工单完成时间</th>
								<th>预开户工号</th>
								<th>预存款</th>
								<th>审批人工号</th>
								<th>开户有效期</th>
								<th>联系人姓名</th>
								<th>联系人电话</th>
								
								<th>工单处理状态</th>
							
							</tr>
							<%for(int i=0;i<result1.length;i++) {%>
							<tr> 
								<td width="8%"><%=result1[i][0]%></td>
								<td width="5%"><%if(result1[i][1].trim().equals("0")){out.print("未开户");}else{out.print("已开户");}%></td>
								<td width="7%"><%=result1[i][2]%></td>
								<td width="8%"><%=result1[i][3]%></td>
								<td width="8%"><%=result1[i][4]%></td>
								<td width="2%"><%=result1[i][5]%></td>
								<td width="4%"><%=result1[i][6]%></td>
								<td width="3%"><%=result1[i][7]%></td>
								<td width="7%"><%=result1[i][8]%></td>
								<td width="8%"><%=result1[i][9]%></td>
								<td width="7%"><%=result1[i][10]%></td>
								
								<td width="7%">
									<%
									if(result1[i][12].trim().equals("2")) {
									out.print("已完成");
									}
								  else{
								  	out.print("<a  onClick='tests1(this)' href='#' value='"+result1[i][0].trim()+"'><font class='red'>未完成</font></a>");
								  }
									%>
								</td>
						  </tr>
						  <tr>				  		
						  			<th>备注：</th>					  
						  		<td colspan="11">
						  			<%=result1[i][11].trim()%>
						  	</td>
						  </tr>
						  <%}%>
						</talbe>
</body>
</html>
<%
	}
else {
		System.out.println(" ======== sE414Qry 调用失败 ========" + retCode + " | " + retMsg);
		%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode%>"+"<%=retMsg%>",0);	
					</script>
					<%
	}
%>