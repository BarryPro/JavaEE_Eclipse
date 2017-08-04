<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		//String opCode = request.getParameter("opCode");
		//String opName = request.getParameter("opName");
		String opCode="e860";
		String opName="集团重要成员调出申请";
		String workNo = (String)session.getAttribute("workNo");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		%>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe860.js"></script>
		<script language="javascript">
			var familyRoleList = new FamRoleList();
			var sns="0";
		function doReset(){
			window.location.href = "fe860_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		function returnBefo() {
		  window.location.href = "fe860_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		function quechoosee() {
		 		
				var phoneNos = document.frm.phoneNo.value.trim();
				if(checkElement(document.frm.phoneNo)==false) {
				 return false;
				}
				if(sns=="0") {
				  sns="1";
				  if(!check(frm))
					  {
					    return false;
					  }
					}
					if(phoneNos.trim()=="") {
							rdShowMessageDialog("手机号码不能为空，请重新输入！");
							return false;
					}

  document.all.quchoose.disabled = true;
	var myPacket = new AJAXPacket("fe860_qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("opName","<%=opName%>");
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;

		}
  function checkSMZValue(data) {
  document.all.quchoose.disabled = false;
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
}
	function confirmS() {
		if(!check(frm))
		 {
			 return false;
		 }
		 var intocity = $("#intocity").val();
		 if(intocity=="nn") {
		 rdShowMessageDialog("调入地市不能为空，请选择！");
		 return false;
		 }
		 setJSONText();
		 
	var getdataPacket = new AJAXPacket("fe860_submit.jsp","正在提交中，请稍候......");
	getdataPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());
	getdataPacket.data.add("opCode","<%=opCode%>");
	getdataPacket.data.add("opName","<%=opName%>");
	getdataPacket.data.add("myJSONText",$("#myJSONText").val());
	getdataPacket.data.add("entertime",$("#begin_time").val());
	getdataPacket.data.add("grpname",$("#jtnames1").val());
	getdataPacket.data.add("newregion",$("#intocity").val());
	core.ajax.sendPacket(getdataPacket);
	getdataPacket = null;
					  
	}
			function doProcess(packet) {

			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog(retMsg,2);
				doReset();
				//removeCurrentTab();
			}else {
				rdShowMessageDialog("提交失败，错误代码："+retCode+"错误信息："+retMsg,0);
				//removeCurrentTab();
			}
		}
		function setJSONText(){
		familyRoleList = new FamRoleList();
		familyRoleList.setBegintime($("#begin_time").val());
		familyRoleList.setCompanyname($("#jtnames1").val());
		familyRoleList.setIncity($("#intocity").val());	
		var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});
			//alert(myJSONText);
			$("#myJSONText").val(myJSONText);
		}		

  document.onkeydown = function(){
        if(event.keyCode==13)
        {
           // event.keyCode=0;
        }
        }



		</script>
		<body >
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">手机号码</td>
		    <td colspan="3">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""   v_type="mobphone"  maxlength="11" size="17">
      &nbsp;&nbsp;<input type="button"  name="quchoose" class="b_text" value="查询" onclick="quechoosee()" />	
		</td>

	</tr>
</table>


	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
						
				<input name="button" onClick="doReset()" type="button" class="b_foot"  value="清除">
				&nbsp;
				<input type="button" name="closed" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
				&nbsp;
				<input type="button" name="rets" class="b_foot" value="返回" onClick="returnBefo()"/>
			</div>
			</td>
		</tr>
	</table>
		<div id="gongdans">
		</div>	  
<input type="hidden" id="myJSONText" name="myJSONText" />	    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>