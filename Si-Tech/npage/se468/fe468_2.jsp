<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String regionCode= (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");

		
		%>

		<script language="javascript">

		function quechoosee() {
				var addObjectId = document.frm.addObjectId.value;
				var kehujlxingm = document.frm.kehujlxingm.value;		
				var kehujlhaom = document.frm.kehujlhaom.value;			
				var kehudanwei = document.frm.kehudanwei.value;	
				
				if(addObjectId=="") {
					rdShowMessageDialog("请选择组织节点！");
					return false;
				}
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
					var getdataPacket = new AJAXPacket("fe468_2_query.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("opCode","e468");
					getdataPacket.data.add("groupid",addObjectId);
					getdataPacket.data.add("kehujlxingm",kehujlxingm);
					getdataPacket.data.add("kehujlhaom",kehujlhaom);
					getdataPacket.data.add("kehudanwei",kehudanwei);
					core.ajax.sendPacketHtml(getdataPacket,gongdanquery,true);
					getdataPacket = null;
		}
			 function gongdanquery(data){
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
				
		   }
		
				   function tests1(ss) {
				   	
		  var getdataPacket = new AJAXPacket("fe468_2_del.jsp","正在获得操作代码路径，请稍候......");
			getdataPacket.data.add("phoneNo",ss);
			getdataPacket.data.add("opCode","e471");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;	
		   }
		  	function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
			rdShowMessageDialog("删除成功！",2);
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				quechoosee();
				
			}else{
				rdShowMessageDialog("删除失败！ 错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
		}
		function queryObjectId() {

			var path = "tree/groupTree.jsp";
			window.open(path + "?groupType=frm&groupId=addObjectId","","height=530,width=450,scrollbars=yes");
		}
		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="addObjectId" id="addObjectId" >
		<div class="title">
		<div id="title_zi">客户信息查询与删除</div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">组织节点</td>
		    <td colspan="3">
		  	  				<input type="text" name="groupId" value="" class="InputGrey" readonly style="width:170px;">
	            	<input class="b_text" type="button" name="" value="选择" onclick="queryObjectId();" >
		  
		</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">客户经理姓名</td>
		    <td colspan="3">
		  <input name="kehujlxingm" type="text"   id="kehujlxingm" value=""  v_type="mobphone"  maxlength="11">
		  </tr>
				  <tr>
		</td>
				    <td class="blue" width="15%">客户经理号码</td>
		    <td colspan="3">
		  <input name="kehujlhaom" type="text"   id="kehujlhaom" value=""  v_type="mobphone" >
		  
		</td>

	</tr>
				  <tr>
		    <td class="blue" width="15%">客户单位</td>
		    <td colspan="3">
		  <input name="kehudanwei" type="text"   id="kehudanwei" value=""  v_type="mobphone"  maxlength="11">
		  
		</td>


	</tr>

</table>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="查询" onclick="quechoosee()" />		
				&nbsp;
				<%if(opCode.equals("e468")) {%>
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="返回">
				&nbsp;
				<%}%>
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>

				<div id="gongdans">
		</div>    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>