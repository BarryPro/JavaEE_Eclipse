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
		String workNo = (String)session.getAttribute("workNo");
		%>
		<script language="javascript">
		function doReset(){
			window.location.href = "fe414.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		function quechoosee() {
					var phoneNos = document.frm.phoneNo.value.trim();
					var idcards = document.frm.idcard.value.trim();
					
					if(phoneNos.trim()=="" && idcards.trim()=="") {
							rdShowMessageDialog("查询条件不能都为空，请重新输入！",0);
							return false;
					}
					
					var getdataPacket = new AJAXPacket("fe414_query.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("phoneNo",phoneNos);
					getdataPacket.data.add("idcard",idcards);
					getdataPacket.data.add("opCode","<%=opCode%>");
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
		   
		   function tests1(obj) {
		  var getdataPacket = new AJAXPacket("fe414_confirm.jsp","正在获得操作代码路径，请稍候......");
			getdataPacket.data.add("phoneNo",obj.value);
			getdataPacket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;	
		   }
		  	function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
			rdShowMessageDialog("工单受理成功！",2);
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				quechoosee();
				
			}else{
				rdShowMessageDialog("工单受理失败！ 错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
		}
		
				
		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">预开户手机号码</td>
		    <td width="35%">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""   v_type="mobphone" onblur="checkElement(this)" maxlength="11">

		</td>
		<td class="blue" width="15%">证件号码</td>
		<td id="zjcar" style="display:block">
			<input name="idcard" type="text"   id="idcard" value=""  >

		</td>

	</tr>
		 
</table>


	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="查询" onclick="quechoosee()" />		
				&nbsp;
				<input name="back" onClick="doReset()" type="button" class="b_foot"  value="清除">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
	   <br></br>
		<div id="gongdans">
		</div>	    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>