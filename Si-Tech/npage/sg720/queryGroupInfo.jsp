

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>选择群组信息</title>
		 <script type="text/javascript">
		 	$(document).ready(function (){
		 			document.frm.groupName.focus();
		 		});
		 	function haveChose(){
		 			var e = arguments[0] || window.event;
					var trCur = e.srcElement.parentNode.parentNode || e.target.parentNode.parentNode;
					var selectValue = trCur.getElementsByTagName("span")[0].innerHTML;
					window.returnValue = selectValue;
					window.close();
		 		}
		 	function searchGroupInfo(){
		 		if(!checksubmit(frm)) return false ;
		 		var groupName = document.frm.groupName.value;
				var packet = new AJAXPacket("ajax_queryGroupInfo.jsp","请稍后...");
				packet.data.add("groupName",groupName);
				core.ajax.sendPacketHtml(packet,doSearchGroupInfo,true);
				packet =null;
		 		}
		 	function doSearchGroupInfo(data){
		 		$("#groupInfoList").html(data);
		 		}
		 </script>
	</head>
	<body>
	<div id="operation">
	<form method=post name="frm" >
	<%@ include file="/npage/include/header.jsp" %>
	<div id="operation_table">
		<div class="input">
			<table>
			<tr>
				<th>请输入群组名称：</th>
		<td>
			<input type="text" class="required" name="groupName" value="">
			<input type="button" class="b_text" name="groupInfoSearchBut" value="查询" onKeyPress="if(event.keyCode == 13)searchGroupInfo()" onclick="searchGroupInfo();">
		</td>
			</tr>
			</table>
			</div>
		<div class="list">
			<div id="groupInfoList"></div>
		</div>
 	</div>
 	<div id="operation_button">
		<input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
	</div>
 		<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html>