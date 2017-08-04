<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>操作代码路径查询</title>
	<%
		String opCode = "d200";
		String opName = "操作代码路径查询";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<script language="javascript">
		function qry(){
			if(!check(document.frm)){
				return false;
			}	
			var searchCode = $("#searchOpCode").val();
			
			var getdataPacket = new AJAXPacket("fd200_qry.jsp","正在获得操作代码路径，请稍候......");
			getdataPacket.data.add("searchOpCode",searchCode);
			getdataPacket.data.add("OpCode","<%=opCode%>");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var vSrvName = packet.data.findValueByName("vSrvName");
			if(retCode == "000000"){
				if(vSrvName.length > 2){
					vSrvName = vSrvName.substring(0,vSrvName.length-3);
				}
				$("#resultMsg").text(vSrvName);
				$("#showMsg").show();
			}else{
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				initPage();
				return false;
			}
		}
		$(document).ready(function(){
			initPage();
		});
		function initPage(){
			$("#resultMsg").text("");
			$("#showMsg").hide();
			$("#searchOpCode")[0].focus();
		}
	</script>
<body>
<form name="frm" method="POST" action="selectserv_Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">操作代码路径查询</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="25%">操作代码</td>
			<td>
				<input type="text" id="searchOpCode" name="searchOpCode" maxlength="10" v_must="1" 
						v_type="string" onblur="checkElement(this)" />
				<input type="button" class="b_text" value="查询" onclick="qry()" />
			</td>
		</tr>
		<tr id="showMsg">
			<td class="blue" width="25%">操作代码路径</td>
			<td>
				<!--
				<input type="text" id="resultMsg" readonly Class="InputGrey" style="width:400px;"/>
				-->
				<span id="resultMsg"></span>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="清除" onclick="initPage()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>