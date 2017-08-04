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
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String idIccid = request.getParameter("idIccid");
		String cus_pass = request.getParameter("cus_pass");
		String opnote =workNo+"进行"+opCode+"配送结果记录受理查询";


%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
     <wtc:service name="sg530Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
    	<wtc:param value="<%=workNo%>"/>
    	<wtc:param value="<%=password%>"/>
     	<wtc:param value=""/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=opnote%>"/>
    	<wtc:param value="2"/>
    </wtc:service>
    <wtc:array id="dcust6" scope="end" />
<body>
	<form name="frm" method="post" action="">
		<%@ include file="/npage/include/header.jsp" %>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">网上售卡受理-配送结果记录</div>
			</div>
			
							<table>
							<tr >
								<th id="yincang"></th>
								<th>手机号码</th>
								<th>收货人姓名</th>
								<th>收货人固定电话</th>
								<th>收货人联系电话</th>
								<th>收货人地址</th>
								<th>物流单号</th>
								<th>物流公司名称</th>
								<th>订单处理天数</th>
							</tr>
							<%if(retCode2.equals("000000")) {

							   if(dcust6.length>0) {
							   for(int i=0;i<dcust6.length; i++) {
							%>
							<tr> 
								
 						<td width="3%"><input name="opFlag" type="radio" value="<%=dcust6[i][0]%>" ></td>
 						<td ><%=dcust6[i][0]%></td>
 						<td ><%=dcust6[i][1]%></td>
 						<td ><%=dcust6[i][6]%></td>
 						<td ><%=dcust6[i][2]%></td>
 						<td ><%=dcust6[i][3]%></td>
 						<td ><%=dcust6[i][4]%></td>
 						<td><%=dcust6[i][5]%></td>
 					
 						<td align='center'>
 							<%if(!"".equals(dcust6[i][7])){%>
 							<%if(Integer.parseInt(dcust6[i][7])>=7) {out.print("<font color='red'>"+dcust6[i][7]+"天</font>");}else {out.print(dcust6[i][7]+"天");}%>
 							<%}%>
 							</td>
						  </tr>
						  		<%
		    }
		    %>
		    </table>
		    <br>
		    	<table cellspacing="0">
					<tr>
         				<td class='blue' width="15%">配送结果</td>
         				<td id="resultTd">
	         				<select id="Pselect1">
								<option value="0">配送成功</option>
								<option value="1">配送失败</option>
								<option value="5">用户拒收</option>
							</select>
							<input type="button" value="提交配送结果" id="commitBtn" onclick="comitss()" class="b_text" />
							
						</td>
						
					</tr>
					<tr id="shibai" style="display:none">
						<td >
							<input type="hidden" value="" size="65" maxlength="80" id='shibaireson' name='shibaireson'>
						</td>																			
					 </tr>
		    		</table>
		    		
		    		
		    	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
			<!--	<input class="b_foot" type="button" name="b_write" value="确定" onmouseup="comitss()"   /> -->
					<input class="b_foot" type="button" name="b_return" value="返回" onmouseup="doreturn()" />
			</div>
			</td>
		</tr>
	</table>
	<%
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='9'>查询信息为空！</td></tr>
		<tr height='25' align='center'><td colspan='9'><input class="b_foot" type="button" name="b_return" value="返回" onmouseup="doreturn()" /></td>
					</tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<tr height='25' align='center'><td colspan='7'>查询信息为空！</td>
						
					</tr>
										<tr height='25' align='center'><td colspan='7'><input class="b_foot" type="button" name="b_return" value="返回" onmouseup="doreturn()" /></td>
					</tr>
					
					<%
	}%>
						</table>
					</div>
				</div>
 <%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>
<script language="javascript">
	$(function() {
		if("<%=opCode%>" == "g844")
		{
			$("#Pselect1").find("option").eq(2).remove();
		}
		var selectText = $("#Pselect1 option[@selected]").text();
		$('#shibaireson').val(selectText);
		$('#backOrderBtn').remove();
		$('#Pselect1').change(function() {
			var Pselect1 =$("#Pselect1").val();
			var selectText = $("#Pselect1 option[@selected]").text();
			$('#shibaireson').val(selectText);
			if(Pselect1 == '1' || Pselect1 == '5') {
				$('#backOrderBtn').remove();				
				$('#resultTd').append('<input type="button" value="撤单" id="backOrderBtn" onclick="backOrder();" class="b_text" disabled/>');
			}else {
				$('#backOrderBtn').remove();
			}
		});	
		
	});

	function backOrder() {
		var phonenos=""
		var peisongjieguo =$("#Pselect1").val();
		var shibaireson =$("#shibaireson").val();
		var radio1 = document.getElementsByName("opFlag");
		for(var i=0;i<radio1.length;i++) {
			if(radio1[i].checked) {
				var opFlag = radio1[i].value;
				phonenos=opFlag;
			}
		}
		if(phonenos.trim()=="") {
			rdShowMessageDialog("请选择一项进行操作！");
			return false;
		}
		var myPacket = new AJAXPacket("fg604Ajax.jsp","正在入库配送结果入库信息请稍候......");
		myPacket.data.add("phonenos",phonenos);
		myPacket.data.add("peisongjieguo",peisongjieguo);
		myPacket.data.add("shibaireson",shibaireson);
		myPacket.data.add("opCode","backOrder|<%=opCode%>");
		core.ajax.sendPacket(myPacket,doBackOrder);
		myPacket = null;
	}
	
	function doBackOrder(packet) {
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
			 rdShowMessageDialog("撤单成功！");
			 $('input[@name=opFlag][@checked]').parent().parent().remove();
			 //$('#yincang').hide();
			 document.all.commitBtn.disabled=true;
		//	 location = location;
		}else {
			rdShowMessageDialog("撤单失败！错误代码"+retcode+"，错误原因："+retmsg,0);
		}
		 document.all.commitBtn.disabled=false;//写卡成功能提交
	}
	
	function comitss(){
		var phonenos=""
		var peisongjieguo =$("#Pselect1").val();
		var shibaireson =$("#shibaireson").val();
		var radio1 = document.getElementsByName("opFlag");
		for(var i=0;i<radio1.length;i++) {
			if(radio1[i].checked) {
				var opFlag = radio1[i].value;
				phonenos=opFlag;
			}
		}
		if(phonenos.trim()=="") {
			rdShowMessageDialog("请选择一项进行操作！");
			return false;
		}

		var Pselect1sss =$("#Pselect1").val();		
		var sflagss  ="";
		if(Pselect1sss=="5") {
				sflagss="3";
		}else {
				sflagss="2";
		}
    	var myPacket = new AJAXPacket("fg604Ajax.jsp","正在入库配送结果入库信息请稍候......");
		myPacket.data.add("phonenos",phonenos);
		myPacket.data.add("peisongjieguo",peisongjieguo);
		myPacket.data.add("shibaireson",shibaireson);
		myPacket.data.add("opCode","<%=opCode%>");
		myPacket.data.add("sflagss",sflagss);
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}

	function doSetStsDate(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		var sendStatus = packet.data.findValueByName("sendStatus");
		if(retcode=="000000"){
			 
			 if(sendStatus == '0') {
			 rdShowMessageDialog("配送结果录入成功！");
			 	$('input[@name=opFlag][@checked]').parent().parent().remove();
			 	//$('#yincang').hide();
			 }else if(sendStatus == '1' || sendStatus == '5'){
			 rdShowMessageDialog("配送结果录入成功，请进行撤单操作！");
			 	 document.all.commitBtn.disabled=true;
			 	 document.all.backOrderBtn.disabled=false;
			 }
			 //location = location;
		}else {
			rdShowMessageDialog("提交失败！错误代码"+retcode+"，错误原因："+retmsg,0);
		}
		
	}						  	

	function doreturn(){
		if("<%=opCode%>"=="g844"){
			window.location.href = "/npage/sg603/fg607Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}else{
			window.location.href = "fg604Dispatch.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
</script>