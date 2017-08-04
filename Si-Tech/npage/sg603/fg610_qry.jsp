<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
	
		String idIccid = request.getParameter("idIccid");
		String cus_pass = request.getParameter("cus_pass");
		
		String opnote = workNo + "进行610查询";
		String smzflag ="";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
		<wtc:service name="sg529Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="g610"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=cus_pass%>"/>
			<wtc:param value="<%=opnote%>"/>
			<wtc:param value="<%=idIccid%>"/>
		</wtc:service>
		<wtc:array id="dcust2" scope="end" />

<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

			<table>
				<tr>
					<th>客户姓名</th>						
					<th>身份证号</th>
					<th>手机号码</th>								
					<th>订单号</th>
					<th>联系人姓名</th>
					<th>联系人地址</th>
					<th>联系人电话</th>
					<th>订单状态</th>
					<th>物流单号</th>
		
					<th>操作</th>
				</tr>
				
<%
		if(retCode2.equals("000000")) {
			if(dcust2.length>0) {
			   for(int i=0; i < dcust2.length; i++) {
%>
					<tr> 
						<td width="5%"><%=dcust2[i][6]%></td>
						<td width="5%"><%=dcust2[i][13]%></td>
						<td width="5%"><%=dcust2[i][2]%></td>
						<td width="7%"><%=dcust2[i][1]%></td>
						<td width="3%"><%=dcust2[i][10]%></td>
						<td width="2%"><%=dcust2[i][12]%></td>
						<td width="3%"><%=dcust2[i][11]%></td>
						<td width="2%">
<%
							 if(dcust2[i][14].equals("5")){
									 out.print("未外呼");
							 }
							 if(dcust2[i][14].equals("0")) {
							 		 out.print("已外呼未写卡");
							 }
							 if(dcust2[i][14].equals("6")) {
							 		 out.print("外呼失败");
							 }
							 if(dcust2[i][14].equals("1")) {
							 		 out.print("已写卡未邮寄");
							 }
							 if(dcust2[i][14].equals("2")) {
							 		 out.print("已邮寄未反馈结果");
							 }
							 if(dcust2[i][14].equals("3")) {
							 		 out.print("配送成功");
							 }
							 if(dcust2[i][14].equals("7")) {
							 		 out.print("用户拒收");
							 }
							 if(dcust2[i][14].equals("4")) {
							 		 out.print("配送失败。");
							 }
%>
						</td>
						<td width="5%"><%=dcust2[i][8]%></td>
				
						<td width="4%">
							<a target="_blank" href="fg610_qry1.jsp?bianhao=<%=dcust2[i][1]%>">详细信息</a>&nbsp;
						</td>
				  </tr>
<%
		    }}
		  else {
%>
		<tr height='25' align='center'><td colspan='12'>查询信息为空！</td></tr>
<%
			}
		}else {
%>
			<script language="JavaScript">
			    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
			</script>
<%
		}
%>
			</table>
		</div>
	</div>
</body>
</html>