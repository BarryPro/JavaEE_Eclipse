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
    String ip_Addr = (String)session.getAttribute("ipAddr");
		
		%>

		<script language="javascript">

		function quechoosee() {
			var phones = document.frm.kehuphone.value;			
			var kehumc =document.frm.kehuxingming.value;
			var quxiandm = document.frm.quxianid.value;
			var dishidm = document.frm.dishiid.value;   
			var kehdanwei =document.frm.kehudanwei.value;
			var kehjlphoneno = document.frm.kehujlhaom.value;
			var kehujlmingc =document.frm.kehujlxingm.value;
			
			var oButton = document.getElementById("quchoose"); 
			oButton.disabled = true;
			var getdataPacket = new AJAXPacket("fe468_1_add.jsp","正在获得操作代码路径，请稍候......");
			getdataPacket.data.add("phoneNo",phones);
			getdataPacket.data.add("kehumc",kehumc);
			getdataPacket.data.add("quxiandm",quxiandm);
			getdataPacket.data.add("dishidm",dishidm);
			getdataPacket.data.add("kehdanwei",kehdanwei);
			getdataPacket.data.add("kehjlphoneno",kehjlphoneno);
			getdataPacket.data.add("kehujlmingc",kehujlmingc);
			getdataPacket.data.add("ip_Addr","<%=ip_Addr%>");
			getdataPacket.data.add("opCode","<%=opCode%>");			
			getdataPacket.data.add("retQf","a");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;	
		}
		function queryss() {
		    var phones = document.frm.phoneNo.value;
				if(phones.trim()=="") {
					rdShowMessageDialog("手机号码不能为空!");
					return false;
				}			
			var getdataPacket = new AJAXPacket("fe468_1_qry.jsp","正在获得操作代码路径，请稍候......");
			getdataPacket.data.add("phoneNo",phones);
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("retQf","q");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;	

				
		}
			function doProcess(packet){
			
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var retQf = packet.data.findValueByName("retQf");
			if(retQf=="a") {
			var oButton = document.getElementById("quchoose"); 
			if(retCode == "000000"){
			rdShowMessageDialog("录入成功！",2);
			oButton.disabled = true;
			$("#gongdan").slideUp(400, function() {});
			document.frm.phoneNo.value="";
			doResets();
			}else{
				rdShowMessageDialog("录入失败！ 错误代码：" + retCode + "，错误信息：" + retMsg,0);
				
				oButton.disabled = true;
				$("#gongdan").slideUp(400, function() {});
				doResets();
				return false;
			}
			}else {
			
			if(retCode == "000000"){
			doResets();
			var oButton = document.getElementById("quchoose"); 
			oButton.disabled = false;	
			
			var kehuphone = packet.data.findValueByName("kehuphone");
			var guishuid = packet.data.findValueByName("guishuid");
			var quxianid = packet.data.findValueByName("quxianid");
			var dishiid = packet.data.findValueByName("dishiid");
			
			var dishi = packet.data.findValueByName("dishi");
			var quxian = packet.data.findValueByName("quxian");
			var kehuxingming = packet.data.findValueByName("kehuxingming");
			var kehudanwei = packet.data.findValueByName("kehudanwei");

			var kehujlxingm = packet.data.findValueByName("kehujlxingm");
			var kehujlhaom = packet.data.findValueByName("kehujlhaom");
		  document.frm.dishi.value=dishi;
		  document.frm.quxian.value=quxian;
		  document.frm.kehuxingming.value=kehuxingming;
		  document.frm.kehudanwei.value=kehudanwei;
		  document.frm.kehujlxingm.value=kehujlxingm;
		  document.frm.kehujlhaom.value=kehujlhaom;		 
		   
		  document.frm.kehuphone.value=kehuphone;
		  document.frm.guishuid.value=guishuid;
		  document.frm.quxianid.value=quxianid;
		  document.frm.dishiid.value=dishiid;	
		  
			$("#gongdan").slideDown(400, function() {});
			
			}else{
				rdShowMessageDialog("查询失败！ 错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
			
			}
		}
				function doResets(){
			//document.frm.phoneNo.value="";
			document.frm.dishi.value="";
		  document.frm.quxian.value="";
		  document.frm.kehuxingming.value="";
		  document.frm.kehudanwei.value="";
		  document.frm.kehujlxingm.value="";
		  document.frm.kehujlhaom.value="";
		  
		   document.frm.kehuphone.value="";
		   document.frm.guishuid.value="";
		   document.frm.quxianid.value="";
		   document.frm.dishiid.value="";


		} 
		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi">录入功能</div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">手机号码</td>
		    <td >
		  <input name="phoneNo" type="text"   id="phoneNo" value=""  v_type="mobphone" onblur="checkElement(this)" maxlength="11">
		  <font class="orange">*</font>
		  <input type="button" name="" class="b_text" value="查询" onclick="queryss()" /> 
		</td>

	</tr>
			  
					 

</table>
<div id="gongdan" name="gongdan" class="itemContent">
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">地市</td>
		    <td >
		  <input name="dishi" type="text"   id="dishi" value=""    Class="InputGrey" readonly>
		</td>
		    <td class="blue" width="15%">区县（营销部）</td>
		    <td >
		  <input name="quxian" type="text"   id="quxian" value=""    Class="InputGrey" readonly>
		</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">客户姓名</td>
		    <td >
		  <input name="kehuxingming" type="text"   id="kehuxingming" value=""    Class="InputGrey" readonly>
		</td>
		    <td class="blue" width="15%">客户单位</td>
		    <td >
		  <input name="kehudanwei" type="text"   id="kehudanwei" value=""    Class="InputGrey" readonly>
		</td>

	</tr>
				  <tr>
		    <td class="blue" width="15%">客户经理姓名</td>
		    <td >
		  <input name="kehujlxingm" type="text"   id="kehujlxingm" value=""    Class="InputGrey" readonly>
		</td>
		    <td class="blue" width="15%">客户经理号码</td>
		    <td >
		  <input name="kehujlhaom" type="text"   id="kehujlhaom" value=""    Class="InputGrey" readonly>
		</td>

	</tr>
</table>
</div> 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="确定" onclick="quechoosee()" disabled/>		
				&nbsp;
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="返回">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="kehuphone" id="kehuphone" >
	<input type="hidden" name="guishuid" id="guishuid" >
	<input type="hidden" name="quxianid" id="quxianid" >
	<input type="hidden" name="dishiid" id="dishiid" >

 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>