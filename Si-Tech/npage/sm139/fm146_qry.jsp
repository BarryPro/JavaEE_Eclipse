<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String PhoneNo = request.getParameter("PhoneNo");
		String opCode = request.getParameter("opCode");
		String workPwd = (String)session.getAttribute("password");
		String beizhu=workNo+"对号码"+PhoneNo+"进行查询";

/*System.out.println("--wanghyd"+begin_time2);
  System.out.println("--wanghyd"+end_time2);
*/
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
		
     <wtc:service name="sm146Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="14">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=PhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=beizhu%>"/
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

							<table name="qryInfo" id="qryInfo">
									<tr >
								<th>手机号码</th>						
								<th>业务类型</th>
							<th>审核时间</th>
							<th>快递单号</th>
							<th>物流公司名称</th>
							<th>SIM卡号</th>
							<th>套餐信息</th>
							<th>配送信息</th>
							<th>审核状态</th>
							<th>业务状态</th>
							<th>激活时间</th>
		
							
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							   System.out.println("@@@@@@@@@@m146" + dcust2[i][12]);
							%>
							<tr align="center" id="row_<%=i%>"> 
								<td ><%=dcust2[i][0]%></td>
								<td><%if(dcust2[i][1].equals("0")){out.print("换卡不换号");}else {out.print("换号");}%></td>
								<td ><%=dcust2[i][2]%></td>
								<td ><%=dcust2[i][3]%></td>
								<td ><%=dcust2[i][4]%></td>
								<td ><%=dcust2[i][5]%></td>
								<td >
									<%if("0".equals(dcust2[i][8])){
										out.print("58元");
									}else if("1".equals(dcust2[i][8])){
										out.print("88元");
									}else if("2".equals(dcust2[i][8])){
										out.print("30元流量包");
									}
									%>
								</td>
								<td ><%=dcust2[i][9]%>&nbsp;&nbsp;<%=dcust2[i][10]%>&nbsp;&nbsp;<%=dcust2[i][11]%></td>
								<td >
									<%if(dcust2[i][6].equals("0")){
										out.print("审核通过");
										}else if(dcust2[i][6].equals("1")){
											out.print("审核未通过");
											out.print("<br/>");
											out.print(dcust2[i][12]);
										}else if(dcust2[i][6].equals("")){
											out.print("未审核");
										}else if(dcust2[i][6].equals("2")){
											out.print("已激活");
										}%>
								</td>
								<td ><%=dcust2[i][7]%></td>
								<td ><%=dcust2[i][13]%></td>

						  </tr>
						  		<%
		    }%>
		    <tr> 
					<td align="center" id="footer" colspan="11"> 
						<input type="button" name="expBtn"  class="b_foot" value="导出" onclick="printTable(qryInfo)">
					</td>
				</tr>
		    <%}
		  else {
		%>
		<tr height='25' align='center'><td colspan='8'>查询信息为空！</td></tr>
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
