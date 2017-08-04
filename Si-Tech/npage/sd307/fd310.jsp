<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String workNo = (String)session.getAttribute("workNo");
  	String password = (String)session.getAttribute("password");
 		String regionCode= (String)session.getAttribute("regCode");
 		String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		function doQuery(){
			$.each($("input[@name='opType']"),function(){
				hiddenTip($(this)[0]);
			});
			
			if(!checkElement($("#"+viewModel.opType())[0])){
				return false;
			}
			
			controlButt($("#query")[0]);
			
			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("serviceName","sD310Qry");
			getdataPacket.data.add("outnum","2");
			getdataPacket.data.add("inputParamsLength","10");
			getdataPacket.data.add("inParams0","");
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5","");
			getdataPacket.data.add("inParams6","");
			if(viewModel.opType() == "cardNo"){
				getdataPacket.data.add("inParams7","0");
			}else{
				getdataPacket.data.add("inParams7","1");
			}
			getdataPacket.data.add("inParams8",$("#cardNo").val());
			getdataPacket.data.add("inParams9",$("#cardPwdPrefix").val());
			core.ajax.sendPacket(getdataPacket,doAddBack);
			getdataPacket = null;
		}
		function doAddBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode == "000000"){
				if(result.length > 0){
					$("#cardVCNo").text(result[0][0]);
					$("#cardVCName").text(result[0][1]);
					$("#resultTab").show();
				}
			}else{
				rdShowMessageDialog(retCode + ":" + retMsg,0);
			}
		}
		
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">功能类型</td>
			<td colspan="3">
					<input type="radio" name="opType" value="cardNo"
					 data-bind="checked:opType"  />
					 有价卡序列号
					<input type="radio" name="opType" value="cardPwdPrefix"
					 data-bind="checked:opType" >
					 有价卡密码前缀
			</td>
		</tr>
		<tr data-bind="visible:opType()=='cardNo'">
			<td class="blue">有价卡序列号</td>
			<td colspan="3">
				<input type="text" name="cardNo" id="cardNo" 
				 v_must="1" maxlength="20" onblur="checkElement(this)" />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr data-bind="visible:opType()=='cardPwdPrefix'">
			<td class="blue">有价卡密码前缀</td>
			<td colspan="3">
				<input type="text" name="cardPwdPrefix" id="cardPwdPrefix" 
				v_must="1" maxlength="2" onblur="checkElement(this)" />
				<font class="orange">*</font>
			</td>
		</tr>
	</table>
	<table cellspacing="0" id="resultTab" style="display:none;">
		<tr>
			<td class="blue">有价卡归属VC编号</td>
			<td><span id="cardVCNo"></span></td>
			<td class="blue">有价卡归属VC名称</td>
			<td><span id="cardVCName"></span></td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer">
				<input type="button" name="query" id="query" class="b_foot" value="查询" 
          style="cursor:hand;" onClick="doQuery()">
				<input type="button" name="close" class="b_foot" value="关闭" 
          style="cursor:hand;" onClick="removeCurrentTab()" />
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
<script language="javascript">
		var viewModel = {
			/*功能类型值*/
			opType:ko.observable("cardNo")
		}

		ko.applyBindings(viewModel);
</script>
</html>
