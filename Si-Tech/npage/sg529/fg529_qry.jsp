<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String idIccid = request.getParameter("idIccid");
		String cus_pass = request.getParameter("cus_pass");
		String opnote =workNo+"进行g529查询";


%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
     <wtc:service name="sg529Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="g529"/>
        	<wtc:param value="<%=workNo%>"/>
        		<wtc:param value="<%=password%>"/>
         <wtc:param value=""/>
        	<wtc:param value="<%=cus_pass%>"/>
        	<wtc:param value="<%=opnote%>"/>
        			<wtc:param value="<%=idIccid%>"/>
        </wtc:service>
        <wtc:array id="dcust2" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>

<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
									<tr >
								<th>订单生成时间</th>						
								<th>订单编号</th>
								<th>手机号</th>								
								<th>套餐名称</th>
								<th>预存金额</th>
								<th>数量</th>
								<th>收货人</th>
								<th>金额</th>
								<th>物流单号</th>
								<th>物流公司</th>
								<th>订单状态</th>
							
								<th></th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							%>
							<tr> 
								<td width="5%"><%=dcust2[i][0]%></td>
								<td width="5%"><%=dcust2[i][1]%></td>
								<td width="5%"><%=dcust2[i][2]%></td>
								<td width="7%"><%=dcust2[i][3]%></td>
								<td width="3%"><%=dcust2[i][4]%></td>
								<td width="2%"><%=dcust2[i][5]%></td>
								<td width="3%"><%=dcust2[i][6]%></td>
								<td width="2%"><%=dcust2[i][7]%></td>
								<td width="5%"><%=dcust2[i][8]%></td>
								<td width="5%"><%=dcust2[i][9]%></td>
								<td width="6%"><%if(dcust2[i][14].equals("1")) {out.print("订单未支付");}if(dcust2[i][14].equals("2")) {out.print("订单支付成功");}if(dcust2[i][14].equals("3")) {out.print("订单已邮寄");}if(dcust2[i][14].equals("4")) {out.print("订单超时");}%></td>
							
								<td width="4%"><a target="_blank" href="<%=request.getContextPath()%>/npage/sg529/fg529_qry1.jsp?bianhao=<%=dcust2[i][1]%>">详细信息</a>&nbsp;</td>
						  </tr>
						  		<%
		    }}
		  else {
		%>
		<tr height='25' align='center'><td colspan='12'>查询信息为空！</td></tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<%
	}%>
						</table>
					</div>
				</div>
</body>
</html>
