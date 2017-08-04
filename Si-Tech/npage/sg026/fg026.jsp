<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
version v1.0
������: si-tech
ningtn 2012-8-17 11:20:16
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
 		
%>

<html>
<head>
	<title>G3�ն˹��ŵ�½����</title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
			function searchLoginInfo(){
				var searchLoginNo = $("#searchLoginNo").val().trim();
				if(viewModel.opValue()==1){
					if(searchLoginNo == ""){
						rdShowMessageDialog("�����빤�Ŵ���",0);
						return false;
					}
					var selectSql = "select login_name from dloginmsg where login_no=:loginNo";
					var params = "loginNo="+searchLoginNo;
					var getLoginName_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","����У�����Ժ�......");
					getLoginName_Packet.data.add("selectSql",selectSql);
					getLoginName_Packet.data.add("params",params);
					getLoginName_Packet.data.add("wtcOutNum","1");
					core.ajax.sendPacket(getLoginName_Packet,doGetLoginNameBack);
				}else{
					var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("serviceName","sG026Cfm");
					getdataPacket.data.add("outnum","3");
					getdataPacket.data.add("inputParamsLength","10");
					getdataPacket.data.add("inParams0","");
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workNo%>");
					getdataPacket.data.add("inParams4","<%=password%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7",$("#opNote").val());
					getdataPacket.data.add("inParams8","S");
					getdataPacket.data.add("inParams9",searchLoginNo);
					core.ajax.sendPacket(getdataPacket,doGetLoginInfoBack);
					getdataPacket = null;
				}
			}
			function doGetLoginInfoBack(packet){
				var retCode = packet.data.findValueByName("retcode");
				var retMsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retCode == "000000"){
					viewModel.checkLoginFlag(true);
					$("#delTab").empty();
					$.each(result,function(i,n){
						var insertStr = "<tr><td>"+n[0]+"</td><td>"+n[1]+"</td><td>"+n[2]+"</td>";
						insertStr += "<td><input type='button' class='b_text' value='ɾ��' onclick='delFunc(\""+n[0]+"\")'/></td></tr>";
						$("#delTab").append(insertStr);
					});
				}else{
					rdShowMessageDialog(retCode + ":" + retMsg,0);
				}
			}
			function doGetLoginNameBack(packet){
				var retCode = packet.data.findValueByName("retcode");
				var retMsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retCode == "000000" && result.length > 0){
					viewModel.checkLoginFlag(true);
					$("#searchLoginName").text(result[0][0]);
					
				}else{
					rdShowMessageDialog("�����ڴ˹���",0);
				}
			}
			function delFunc(loginNo){
				$("#optionLogin").val(loginNo);
				var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("serviceName","sG026Cfm");
				getdataPacket.data.add("outnum","2");
				getdataPacket.data.add("inputParamsLength","10");
				getdataPacket.data.add("inParams0","");
				getdataPacket.data.add("inParams1","01");
				getdataPacket.data.add("inParams2","<%=opCode%>");
				getdataPacket.data.add("inParams3","<%=workNo%>");
				getdataPacket.data.add("inParams4","<%=password%>");
				getdataPacket.data.add("inParams5","");
				getdataPacket.data.add("inParams6","");
				getdataPacket.data.add("inParams7",$("#opNote").val());
				getdataPacket.data.add("inParams8","D");
				getdataPacket.data.add("inParams9",loginNo);
				core.ajax.sendPacket(getdataPacket,doDelCfmBack);
				getdataPacket = null;
			}
			function doDelCfmBack(packet){
				var retCode = packet.data.findValueByName("retcode");
				var retMsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retCode == "000000"){
					var optionLoginNo = $("#optionLogin").val();
					var trLen = $("#delTab").find("tr").length;
					$.each($("#delTab").find("tr"),function(i,n){
						if($(this).find("td").eq(0).html() == optionLoginNo){
							$(this).remove();
						}
					});
					rdShowMessageDialog("�����ɹ�",2);
				}else{
					rdShowMessageDialog(retCode + ":" + retMsg,0);
				}
			}
			function nextStep(){
				var searchLoginNo = $("#searchLoginNo").val().trim();
				var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("serviceName","sG026Cfm");
				getdataPacket.data.add("outnum","2");
				getdataPacket.data.add("inputParamsLength","10");
				getdataPacket.data.add("inParams0","");
				getdataPacket.data.add("inParams1","01");
				getdataPacket.data.add("inParams2","<%=opCode%>");
				getdataPacket.data.add("inParams3","<%=workNo%>");
				getdataPacket.data.add("inParams4","<%=password%>");
				getdataPacket.data.add("inParams5","");
				getdataPacket.data.add("inParams6","");
				getdataPacket.data.add("inParams7",$("#opNote").val());
				getdataPacket.data.add("inParams8","A");
				getdataPacket.data.add("inParams9",searchLoginNo);
				core.ajax.sendPacket(getdataPacket,doGetCfmBack);
				getdataPacket = null;
			}
			function doGetCfmBack(packet){
				var retCode = packet.data.findValueByName("retcode");
				var retMsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retCode == "000000"){
					rdShowMessageDialog("�����ɹ�",2);
					clearPage();
				}else{
					rdShowMessageDialog(retCode + ":" + retMsg,0);
					clearPage();
				}
			}
			function clearPage(){
				location.href="/npage/sg026/fg026.jsp?opCode=g026&opName=G3�ն˹��ŵ�½����"
			}
			function changeOp(){
				viewModel.checkLoginFlag(false);
				$("#searchLoginNo").val("");
				$("#delTab").empty();
			}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">G3�ն˹��ŵ�½����</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="15%">��������</td>
			<td colspan="3">
				<input type="radio" value="1" name="opFlag" 
				 data-bind="checked:opValue" onclick="changeOp()"/>
				����
				<input type="radio" value="2" name="opFlag"
				 data-bind="checked:opValue" onclick="changeOp()"/>
				��ѯ&ɾ��
			</td>
		</tr>
		<tr>
			<td class="blue">���Ŵ���</td>
			<td>
				<input type="text" name="searchLoginNo" id="searchLoginNo"
				 maxlength="6" data-bind="attr:{readOnly:checkLoginFlag}"/>
				<font class="orange" data-bind="visible:opValue()==1">*</font>
				<input type="button" data-bind="disable:checkLoginFlag" name="searchBtn" id="searchBtn"
				 value="��ѯ" onclick="searchLoginInfo()" class="b_text" />
			</td>
			<td class="blue" data-bind="visible:opValue()==1" width="15%">��������</td>
			<td data-bind="visible:opValue()==1" width="35%"><span id="searchLoginName"><span></td>
		</tr>
	</table>
	<table data-bind="visible:opValue()==2">
		<tr>
			<th>���Ŵ���</th>
			<th>��������</th>
			<th>���Ź���</th>
			<th>����</th>
		</tr>
		<tbody id="delTab">
		</tbody>
	</table>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="15%">������ע</td>
			<td>
				<input type="text" name="opNote" id="opNote" size="80" maxlength="50"/>
			</td>
		</tr>
	</table>
	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" type="button" class="b_foot" index="2" 
			 onClick="nextStep(this)" value="ȷ��" data-bind="visible:opValue()==1,enable:checkLoginFlag"/>
			&nbsp; 
			<input name="confirm" type="button" class="b_foot"
			 onClick="clearPage()" value="���"/>
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<!-- ���ر����֣�Ϊ��һҳ�洫���� -->
	<input type="hidden" name="opCode" id="opCode" />
	<input type="hidden" name="opName" id="opName" />
	<input type="hidden" name="optionLogin" id="optionLogin" />
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
<script language="javascript">
		var viewModel = {
			opValue:ko.observable("1"),
			checkLoginFlag:ko.observable(false)
		}
		ko.applyBindings(viewModel);
</script>
</html>
