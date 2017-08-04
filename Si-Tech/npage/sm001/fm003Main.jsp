<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String workNo = (String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String smzflag ="";

	String idIccid = request.getParameter("idIccid");
	String cus_pass = request.getParameter("cus_pass");
	String opnote =workNo+"进行"+opCode+"写卡受理查询";

	String orderStatus = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
		routerValue="<%=regionCode%>"  id="loginAccept" />
		
	 <wtc:service name="sg530Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="19">
	    <wtc:param value="<%=loginAccept%>"/>
	    <wtc:param value="01"/>
	    <wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
	 	<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opnote%>"/>
		<wtc:param value="0"/>
	</wtc:service>
	<wtc:array id="dcust2" scope="end" />
	<script language="javascript">
		function holdOnSe(tempPhone, downNum, orderId){
			var myPacket = new AJAXPacket("holdNo.jsp","正在获得记录总数，请稍候...");
			myPacket.data.add("accept","<%=loginAccept%>");
			myPacket.data.add("opCode","<%=opCode%>");
			myPacket.data.add("phoneNo",tempPhone.trim());
			
			myPacket.data.add("orderId", orderId);
			myPacket.data.add("oprType", '11');
			
    		core.ajax.sendPacket(myPacket, function(packet){
    			var errorCode = packet.data.findValueByName('retCode');
    			var errorMsg = packet.data.findValueByName('retMsg');
    					
    			if (errorCode == '000000'){
    					rdShowMessageDialog("预占成功！");
    					$("#holdOnIt"+downNum).attr("disabled","disabled");
    					$("#writeCard"+downNum).attr("disabled","");
    			} else {
    					rdShowMessageDialog("预占失败！" + errorCode + errorMsg);
    			}
    		});
    		
    		myPacket=null;
		}
	</script>
<body>
	<form name="frm" method="post" action="">
		<%@ include file="/npage/include/header.jsp" %>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">移动商城开户写卡</div>
			</div>
				<table >
					<tr >
						<th>操作</th>
						<th>手机号码</th>
						<th>订单状态</th>
						<th>用户编码</th>
						<th>sim卡号</th>
						<th>卡片号码</th>
						<th>sim卡类型</th>
						<th>证件号码</th>
						<th>订单号码</th>
					</tr>
			<%
					if(retCode2.equals("000000")) {
					   if(dcust2.length>0) {
						   for(int i=0;i<dcust2.length; i++) {
						   		orderStatus = dcust2[i][8];
						   		
						   		System.out.println(" zhoubyx + --- " + orderStatus);
						%>
								<tr>
									<td width="5%">
										<%if("11".equals(orderStatus)){%> <!-- 写卡  -->
										<input type="button" id="holdOnIt<%=i%>" name="holdOnIt<%=i%>" value="预占" disabled="disabled" class="b_text" onclick="holdOnSe('<%=dcust2[i][0]%>','<%=i%>', '<%=dcust2[i][13]%>')"/>
									&nbsp;
										<input type="button" id="writeCard<%=i%>" name="writeCard<%=i%>"  value="写卡" class="b_text" onclick="javascript:window.location.href='<%=request.getContextPath()%>/npage/sm001/fm003writecard.jsp?opCode=<%=opCode%>&groupids=<%=dcust2[i][3]%>&opName=<%=opName%>&phoneNO=<%=dcust2[i][0]%>&kehuxingming=<%=dcust2[i][4]%>&zhengjianmingcheng=<%=dcust2[i][11]%>&zhengjianhaoma=<%=dcust2[i][5]%>&simming=<%=dcust2[i][9]%>&haomaguishu=<%=dcust2[i][10]%>&dingdanzhuangtai=<%=orderStatus%>&kehudizhi=<%=dcust2[i][12]%>&simtype=<%=dcust2[i][2]%>&kapianhaoma=<%=dcust2[i][6]%>&yonghubianma=<%=dcust2[i][7]%>&simnono=<%=dcust2[i][1]%>&offerids=<%=dcust2[i][17]%>&offernames=<%=dcust2[i][18]%>&offfercomments=<%=dcust2[i][15]%>&prePay=<%=dcust2[i][16]%>'"/>
									<%}else{%><!-- 预占  -->
										<input type="button" id="holdOnIt<%=i%>" name="holdOnIt<%=i%>"  value="预占" class="b_text" onclick="holdOnSe('<%=dcust2[i][0]%>','<%=i%>', '<%=dcust2[i][13]%>')"/>
									&nbsp;
										<input type="button" id="writeCard<%=i%>" name="writeCard<%=i%>"  value="写卡" disabled="disabled" class="b_text" onclick="javascript:window.location.href='<%=request.getContextPath()%>/npage/sm001/fm003writecard.jsp?opCode=<%=opCode%>&groupids=<%=dcust2[i][3]%>&opName=<%=opName%>&phoneNO=<%=dcust2[i][0]%>&kehuxingming=<%=dcust2[i][4]%>&zhengjianmingcheng=<%=dcust2[i][11]%>&zhengjianhaoma=<%=dcust2[i][5]%>&simming=<%=dcust2[i][9]%>&haomaguishu=<%=dcust2[i][10]%>&dingdanzhuangtai=<%=orderStatus%>&kehudizhi=<%=dcust2[i][12]%>&simtype=<%=dcust2[i][2]%>&kapianhaoma=<%=dcust2[i][6]%>&yonghubianma=<%=dcust2[i][7]%>&simnono=<%=dcust2[i][1]%>&offerids=<%=dcust2[i][17]%>&offernames=<%=dcust2[i][18]%>&offfercomments=<%=dcust2[i][15]%>&prePay=<%=dcust2[i][16]%>'"/>
									<%}%>
									</td> 
									<td width="8%"><%=dcust2[i][0]%></td>
									<td width="10%">
<%
										/*vSaleFlag返回值对应订单状态展示
											0外呼成功未写卡，1已写卡未邮寄，2已邮寄未反馈结果，
											3配送成功，4配送失败，5未外呼，6外呼失败，7用户拒收，8已预占'*/
										if(orderStatus.equals("00")) {
											out.print("未出库或未写卡");
										}else if(orderStatus.equals("01")) {
											out.print("已出库或已写卡未邮寄");
										}else if(orderStatus.equals("02")) {
											out.print("已邮寄未反馈结果");
										}else if(orderStatus.equals("03")) {
											out.print("配送成功");
										}else if(orderStatus.equals("04")) {
											out.print("配送失败");
										}else if(orderStatus.equals("05")) {
											out.print("用户拒收");
										}else if(orderStatus.equals("06")) {
											out.print("外呼预占");
										}else if(orderStatus.equals("07")) {
											out.print("物流单下单预占");
										}else if(orderStatus.equals("08")) {
											out.print("移动商城开户外呼预占");
										} else if(orderStatus.equals("09")) {
											out.print("外呼成功待写卡");
										} else if(orderStatus.equals("10")) {
											out.print("移动商城外呼失败");
										} else if(orderStatus.equals("11")) {
											out.print("移动商城写卡预占");
										} 
%>
                                    </td>
									<td width="8%"><%=dcust2[i][7]%></td>
									<td width="10%"><%=dcust2[i][1]%></td>
									<td width="10%"><%=dcust2[i][6]%></td>
									<td width="5%"><%=dcust2[i][2]%></td>
									<td width="10%"><%=dcust2[i][5]%></td>
									<td width="10%"><%=dcust2[i][13]%></td>
								</tr>
				<%
						   }
		    	%>
						    <table cellspacing="0">
								<tr>
									<td noWrap id="footer">
									<div align="center">
											<input class="b_foot" type="button" name="b_return" value="返回" onmouseup="doreturn()" />
									</div>
									</td>
								</tr>
							</table>
	<%
		    		   }else {
	%>
							<tr height='25' align='center'><td colspan='9'>查询信息为空！</td></tr>
							<tr height='25' align='center'>
								<td colspan='9'>
									<input class="b_foot" type="button" name="b_return" value="返回" onmouseup="doreturn()" />
								</td>
							</tr>
					<%
					   }
				    }else {
					%>
						<script language="JavaScript">
						    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
						</script>
						<tr height='25' align='center'>
							<td colspan='9'>查询信息为空！</td>
						</tr>
						<tr height='25' align='center'>
							<td colspan='9'>
								<input class="b_foot" type="button" name="b_return" value="返回" onmouseup="doreturn()" />
							</td>
						</tr>
					<%
					}
					%>
				</table>
			</div>
		</div>
 <%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>
<script language="javascript">					  	

	function doreturn(){
		window.location.href = "/npage/sm001/fm003Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
		
</script>