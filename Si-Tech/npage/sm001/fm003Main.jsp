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
	String opnote =workNo+"����"+opCode+"д�������ѯ";

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
			var myPacket = new AJAXPacket("holdNo.jsp","���ڻ�ü�¼���������Ժ�...");
			myPacket.data.add("accept","<%=loginAccept%>");
			myPacket.data.add("opCode","<%=opCode%>");
			myPacket.data.add("phoneNo",tempPhone.trim());
			
			myPacket.data.add("orderId", orderId);
			myPacket.data.add("oprType", '11');
			
    		core.ajax.sendPacket(myPacket, function(packet){
    			var errorCode = packet.data.findValueByName('retCode');
    			var errorMsg = packet.data.findValueByName('retMsg');
    					
    			if (errorCode == '000000'){
    					rdShowMessageDialog("Ԥռ�ɹ���");
    					$("#holdOnIt"+downNum).attr("disabled","disabled");
    					$("#writeCard"+downNum).attr("disabled","");
    			} else {
    					rdShowMessageDialog("Ԥռʧ�ܣ�" + errorCode + errorMsg);
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
				<div id="title_zi">�ƶ��̳ǿ���д��</div>
			</div>
				<table >
					<tr >
						<th>����</th>
						<th>�ֻ�����</th>
						<th>����״̬</th>
						<th>�û�����</th>
						<th>sim����</th>
						<th>��Ƭ����</th>
						<th>sim������</th>
						<th>֤������</th>
						<th>��������</th>
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
										<%if("11".equals(orderStatus)){%> <!-- д��  -->
										<input type="button" id="holdOnIt<%=i%>" name="holdOnIt<%=i%>" value="Ԥռ" disabled="disabled" class="b_text" onclick="holdOnSe('<%=dcust2[i][0]%>','<%=i%>', '<%=dcust2[i][13]%>')"/>
									&nbsp;
										<input type="button" id="writeCard<%=i%>" name="writeCard<%=i%>"  value="д��" class="b_text" onclick="javascript:window.location.href='<%=request.getContextPath()%>/npage/sm001/fm003writecard.jsp?opCode=<%=opCode%>&groupids=<%=dcust2[i][3]%>&opName=<%=opName%>&phoneNO=<%=dcust2[i][0]%>&kehuxingming=<%=dcust2[i][4]%>&zhengjianmingcheng=<%=dcust2[i][11]%>&zhengjianhaoma=<%=dcust2[i][5]%>&simming=<%=dcust2[i][9]%>&haomaguishu=<%=dcust2[i][10]%>&dingdanzhuangtai=<%=orderStatus%>&kehudizhi=<%=dcust2[i][12]%>&simtype=<%=dcust2[i][2]%>&kapianhaoma=<%=dcust2[i][6]%>&yonghubianma=<%=dcust2[i][7]%>&simnono=<%=dcust2[i][1]%>&offerids=<%=dcust2[i][17]%>&offernames=<%=dcust2[i][18]%>&offfercomments=<%=dcust2[i][15]%>&prePay=<%=dcust2[i][16]%>'"/>
									<%}else{%><!-- Ԥռ  -->
										<input type="button" id="holdOnIt<%=i%>" name="holdOnIt<%=i%>"  value="Ԥռ" class="b_text" onclick="holdOnSe('<%=dcust2[i][0]%>','<%=i%>', '<%=dcust2[i][13]%>')"/>
									&nbsp;
										<input type="button" id="writeCard<%=i%>" name="writeCard<%=i%>"  value="д��" disabled="disabled" class="b_text" onclick="javascript:window.location.href='<%=request.getContextPath()%>/npage/sm001/fm003writecard.jsp?opCode=<%=opCode%>&groupids=<%=dcust2[i][3]%>&opName=<%=opName%>&phoneNO=<%=dcust2[i][0]%>&kehuxingming=<%=dcust2[i][4]%>&zhengjianmingcheng=<%=dcust2[i][11]%>&zhengjianhaoma=<%=dcust2[i][5]%>&simming=<%=dcust2[i][9]%>&haomaguishu=<%=dcust2[i][10]%>&dingdanzhuangtai=<%=orderStatus%>&kehudizhi=<%=dcust2[i][12]%>&simtype=<%=dcust2[i][2]%>&kapianhaoma=<%=dcust2[i][6]%>&yonghubianma=<%=dcust2[i][7]%>&simnono=<%=dcust2[i][1]%>&offerids=<%=dcust2[i][17]%>&offernames=<%=dcust2[i][18]%>&offfercomments=<%=dcust2[i][15]%>&prePay=<%=dcust2[i][16]%>'"/>
									<%}%>
									</td> 
									<td width="8%"><%=dcust2[i][0]%></td>
									<td width="10%">
<%
										/*vSaleFlag����ֵ��Ӧ����״̬չʾ
											0����ɹ�δд����1��д��δ�ʼģ�2���ʼ�δ���������
											3���ͳɹ���4����ʧ�ܣ�5δ�����6���ʧ�ܣ�7�û����գ�8��Ԥռ'*/
										if(orderStatus.equals("00")) {
											out.print("δ�����δд��");
										}else if(orderStatus.equals("01")) {
											out.print("�ѳ������д��δ�ʼ�");
										}else if(orderStatus.equals("02")) {
											out.print("���ʼ�δ�������");
										}else if(orderStatus.equals("03")) {
											out.print("���ͳɹ�");
										}else if(orderStatus.equals("04")) {
											out.print("����ʧ��");
										}else if(orderStatus.equals("05")) {
											out.print("�û�����");
										}else if(orderStatus.equals("06")) {
											out.print("���Ԥռ");
										}else if(orderStatus.equals("07")) {
											out.print("�������µ�Ԥռ");
										}else if(orderStatus.equals("08")) {
											out.print("�ƶ��̳ǿ������Ԥռ");
										} else if(orderStatus.equals("09")) {
											out.print("����ɹ���д��");
										} else if(orderStatus.equals("10")) {
											out.print("�ƶ��̳����ʧ��");
										} else if(orderStatus.equals("11")) {
											out.print("�ƶ��̳�д��Ԥռ");
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
											<input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" />
									</div>
									</td>
								</tr>
							</table>
	<%
		    		   }else {
	%>
							<tr height='25' align='center'><td colspan='9'>��ѯ��ϢΪ�գ�</td></tr>
							<tr height='25' align='center'>
								<td colspan='9'>
									<input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" />
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
							<td colspan='9'>��ѯ��ϢΪ�գ�</td>
						</tr>
						<tr height='25' align='center'>
							<td colspan='9'>
								<input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" />
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