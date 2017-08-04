<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>操作代码路径查询</title>
	<%
		String opCode = "e887";
		String opName = "IMS固话开户（centrex业务）";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<script language="javascript">
		var initOpCode = "<%=opCode%>";
		$(document).ready(function(){
			initPage();
		});
		function initPage(){
		}
		function nextStep(){
		}
		//调用公共界面，进行集团客户选择
		function getInfo_Cust(){
			var pageTitle = "集团客户选择";
			var fieldName = "证件号码|客户ID|客户名称|集团ID|集团名称|归属地|归属组织|";
			var sqlStr = "";
			var selType = "S";    //'S'单选；'M'多选
			var retQuence = "7|0|1|2|3|4|5|6|";
			var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
			/**add by liwd 20081127,group_id来自dcustDoc的group_id end **/
			var cust_id = document.frm.cust_id.value;
			if(document.frm.iccid.value == "" &&
			document.frm.cust_id.value == "" &&
			document.frm.unit_id.value == "")
			{
				rdShowMessageDialog("请输入证件号码、客户ID或集团ID进行查询！");
				document.frm.iccid.focus();
				return false;
			}
			
			if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
			{
				frm.cust_id.value = "";
				rdShowMessageDialog("必须是数字！");
				return false;
			}
			
			if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
			{
				frm.unit_id.value = "";
				rdShowMessageDialog("必须是数字！");
				return false;
			}
			
			if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		}
		
		function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
		{
			var path = "<%=request.getContextPath()%>/npage/s3690/fpubcust_sel.jsp";
			path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
			path = path + "&cust_id=" + document.all.cust_id.value;
			path = path + "&unit_id=" + document.all.unit_id.value;
			path = path + "&regionCode=" + "<%=regionCode%>";
			path = path + "&rOpCode=" + "<%=opCode%>";
			
			retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
			
			return true;
		}
		function getvaluecust(retInfo){
			/*add by liwd 20081127,group_id来自dcustDoc的group_id
			**var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|";;
			**/
			var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
			/**add by liwd 20081127,group_id来自dcustDoc的group_id end **/
			if(retInfo ==undefined)      
			{   return false;   }
			
			var chPos_field = retToField.indexOf("|");
			var chPos_retStr;
			var valueStr;
			var obj;
			while(chPos_field > -1)
			{
				obj = retToField.substring(0,chPos_field);
				chPos_retInfo = retInfo.indexOf("|");
				valueStr = retInfo.substring(0,chPos_retInfo);
				document.all(obj).value = valueStr;
				retToField = retToField.substring(chPos_field + 1);
				retInfo = retInfo.substring(chPos_retInfo + 1);
				chPos_field = retToField.indexOf("|");
			}
			document.all.grp_name.value = document.all.unit_name.value;
		}
		function check_HidPwd()
		{
			var cust_id = document.all.cust_id.value;
			var Pwd1 = document.all.custPwd.value;
			
			var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3690/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("retType","checkPwd");
			checkPwd_Packet.data.add("cust_id",cust_id);
			checkPwd_Packet.data.add("Pwd1",Pwd1);
			core.ajax.sendPacket(checkPwd_Packet,doCheckPwdBack);
			checkPwd_Packet = null;
		}
	function doCheckPwdBack(packet){
		var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
		if(retCode == "000000"){
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false") {
				rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
				frm.custPwd.value = "";
				frm.custPwd.focus();
				return false;
			} else {
				rdShowMessageDialog("客户密码校验成功！",2);
				document.frm.next.disabled = false;
			}
		}
		else{
			rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
			return false;
		}
	}
		function doProcess(packet)
		{
	    var retType = packet.data.findValueByName("retType");
	    var retCode = packet.data.findValueByName("retCode");
	    var retMessage=packet.data.findValueByName("retMessage");
	    self.status="";
			if(retType == "checkPwd") //集团客户密码校验
			{
				if(retCode == "000000"){
					var retResult = packet.data.findValueByName("retResult");
					if (retResult == "false") {
						rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
						frm.custPwd.value = "";
						frm.custPwd.focus();
						return false;	        	
					} else {
					    rdShowMessageDialog("客户密码校验成功！",2);
					}
				}
				else{
					rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
					return false;
				}
			}	
		}
		function qryProductOffer(){
	    var pageName = "/npage/portal/shoppingCar/qryProductOfferComplex.jsp?opCode="+initOpCode;
	   	window.open(pageName,'销售品选择','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		}
		function resultProcess(resultList){
			 if (resultList != null){
			 	//alert(resultList);
        var result1 = resultList.split("|");
        for (var n = 0; n < result1.length; n++){
        	var result2 = result1[n].split(",");
        	var offerId = result2[0];					//销售品标识
          var offerName = result2[1];				//销售品名称
          var offerType = result2[7];	      //销售品类型 30组合 10单个
          var servBusiId = result2[9];
          var offerInfoCode = result2[10];
          var offerInfoValue = result2[11];
					$("#offerId").val(offerId);
          $("#offerName").val(offerName);
          $("#offerType").val(offerType);
          $("#servBusiId").val(servBusiId);
          $("#offerInfoCode").val(offerInfoCode);
          $("#offerInfoValue").val(offerInfoValue);
        }
      }
		}
		function getOptorMsg() {
	    var agent_name = $("#cust_name").val(); 									//经办人名称
	    var agent_idType = "2"; 							//证件类型
	    var agent_idNo = $("#iccid").val(); 									//证件号码
	    var agent_phone = " ";//联系电话
	    var ContactMobile = " ";//手机
	    var zipcode = " ";//邮政编码
	    var ContactUserAddr = " ";//地址
	    var ContactEmailAddress = " ";//邮箱
	    var optorData = agent_name + "," + agent_idType + "," + agent_idNo + "," + agent_phone + "," + ContactMobile + "," + zipcode + "," + ContactUserAddr + "," + ContactEmailAddress;
	    return optorData;
		}
		function custOrderC(){
			if($("#cust_id").val() == ""){
				rdShowMessageDialog("请查询集团客户信息");
        return false;
			}
			if($("#offerId").val() == ""){
				rdShowMessageDialog("请选择销售品");
        return false;
			}
			var arrData = new Array();
			arrData.push("");
			arrData.push($("#offerName").val());
			arrData.push("1");
			arrData.push("N");
			arrData.push("");
			arrData.push($("#offerId").val());
			arrData.push("e887");
			arrData.push($("#servBusiId").val());
			arrData.push($("#offerInfoCode").val());
			arrData.push($("#offerInfoValue").val());
			sData = "" + arrData;
			var optorMsg = getOptorMsg();
			var prtFlagValue = "Y";
			var packet = new AJAXPacket("/npage/portal/shoppingCar/sCustOrderC.jsp");
			packet.data.add("sData", sData);
			packet.data.add("optorMsg", optorMsg);
			packet.data.add("custId", $("#cust_id").val());
			packet.data.add("prtFlagValue", prtFlagValue);
			core.ajax.sendPacket(packet, doCustOrderC);
		}
		function doCustOrderC(packet){
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
	    if (retCode == "0"){
				var prtFlag = "Y";
				var custOrderId = packet.data.findValueByName("custOrderId");
				var custOrderNo = packet.data.findValueByName("custOrderNo");
				goNext(custOrderId, custOrderNo, prtFlag);
				//detBut();
	    }else{
				rdShowMessageDialog("创建客户订单失败!请联系系统管理员!");
	    }
	  }
	  function goNext(custOrderId,custOrderNo,prtFlag){
			var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
			packet.data.add("custOrderId" ,custOrderId);
			packet.data.add("custOrderNo" ,custOrderNo);
			packet.data.add("prtFlag" ,prtFlag);
			core.ajax.sendPacket(packet,doNext);
			packet =null;
		}
		function doNext(packet){
	    var retCode = packet.data.findValueByName("retCode"); 
		  var retMsg = packet.data.findValueByName("retMsg");
		  if(retCode=="0")
		  {
		  	var sData = packet.data.findValueByName("sData"); 
		  	parent.parent.$("#carNavigate").html(sData);
		  	var custOrderId = packet.data.findValueByName("custOrderId"); 
		  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
		  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
		  	var servOrderId = packet.data.findValueByName("servOrderId"); 
		  	var status = packet.data.findValueByName("status"); 
		  	var funciton_code = packet.data.findValueByName("funciton_code"); 
		  	var funciton_name = packet.data.findValueByName("funciton_name"); 
		  	var pageUrl = packet.data.findValueByName("pageUrl"); 
		  	var offerSrvId = packet.data.findValueByName("offerSrvId"); 
		  	var num = packet.data.findValueByName("num"); 
		  	var offerId = packet.data.findValueByName("offerId"); 
		  	var offerName = packet.data.findValueByName("offerName"); 
		  	var phoneNo = packet.data.findValueByName("phoneNo"); 
		  	var sitechPhoneNo = packet.data.findValueByName("sitechPhoneNo"); 
		  	var prtFlag = packet.data.findValueByName("prtFlag"); 
		  	var servBusiId = packet.data.findValueByName("servBusiId"); 
		  	var validVal = packet.data.findValueByName("validVal"); 
		  	var openWay = packet.data.findValueByName("openWay"); 
		  	var closeId=orderArrayId+servOrderId;
		  	if(closeId=="")
		  	{
		  		closeId= funciton_code;
		  	}
				/*赋值*/
				$("#gCustId").val($("#cust_id").val());
				$("#opCode").val(funciton_code);
				$("#opName").val(funciton_name);
				$("#offerSrvId").val(offerSrvId);
				$("#num").val(num);
				$("#phoneNo").val(phoneNo);
				$("#sitechPhoneNo").val(sitechPhoneNo);
				$("#orderArrayId").val(orderArrayId);
				$("#custOrderId").val(custOrderId);
				$("#custOrderNo").val(custOrderNo);
				$("#servOrderId").val(servOrderId);
				$("#closeId").val(funciton_code);
				$("#prtFlag").val(prtFlag);
				frm.action="fe887Main.jsp";
				frm.submit();
		 			
		  }else
		  {
		  		  rdShowMessageDialog("操作导航失败!");
		  }
		}
	</script>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="grp_name" id="grp_name" />
	<input type="hidden" name="unit_name" id="unit_name" />
	<input type="hidden" name="belong_code" id="belong_code" />
	<input type="hidden" name="group_id" id="group_id" />
	<input type="hidden" name="offerId" id="offerId" />
	<input type="hidden" name="offerType" id="offerType" />
	<input type="hidden" name="servBusiId" id="servBusiId" />
	<input type="hidden" name="offerInfoCode" id="offerInfoCode" />
	<input type="hidden" name="offerInfoValue" id="offerInfoValue" />
	<div class="title">
		<div id="title_zi">集团验证</div>
	</div>
	<table cellspacing="0">
    <tr>
      <td class=blue>证件号码</td>
      <td>
        <input name="iccid" id="iccid" size="24" maxlength="20" v_type="string" v_must=1>
        <input name="custQuery" type="button" id="custQuery" 
         class="b_text" onClick="getInfo_Cust();" 
          onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=查询 />
        <font class="orange">*</font>
      </td>
      <td class=blue>集团客户ID</TD>
      <td>
        <input type="text" name="cust_id" id="cust_id" size="20" maxlength="12" v_type="0_9" v_must=1 index="2">
        <font class="orange">*</font>
      </td>
    </tr>
    <tr>
      <td class=blue>集团编号</td>
      <td>
          <input name="unit_id" id="unit_id" size="24" maxlength="11" v_type="0_9" v_must=1 index="3" value="4510976840" />
          <font class="orange">*</font>
      </td>
      <td class=blue>集团客户名称</td>
      <td>
          <input name="cust_name" id="cust_name" size="20" readonly v_must=1 v_type=string index="4">
          <font class="orange">*</font>
      </td>
    </tr>
    <tr>
      <td class=blue>集团客户密码</td>
      <td colspan="3">
        <jsp:include page="/npage/common/pwd_1.jsp">
        <jsp:param name="width1" value="16%"  />
        <jsp:param name="width2" value="34%"  />
        <jsp:param name="pname" value="custPwd"  />
        <jsp:param name="pwd" value="<%=123%>"  />
        </jsp:include>
        <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=校验>
        <font class="orange">*</font>
      </td>
    </tr>
    <tr>
    	<td class="blue">销售品选择</td>
    	<td colspan="3">
    		<input type="text" id="offerName" name="offerName" 
    		 readonly="readonly" class="InputGrey"/>
    		<input type="button" id="chooseProdBtn" value="选择" 
    		 class="b_text" onclick="qryProductOffer()"/>
    	</td>
    </tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="next" class="b_foot" value="下一步" onclick="custOrderC()" disabled />
				&nbsp;
				<input type="reset" name="query" class="b_foot" value="清除" onclick="initPage()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="gCustId" id="gCustId" />
	<input type="hidden" name="opCode" id="opCode" />
	<input type="hidden" name="opName" id="opName" />
	<input type="hidden" name="offerSrvId" id="offerSrvId" />
	<input type="hidden" name="num" id="num" />
	<input type="hidden" name="phoneNo" id="phoneNo" />
	<input type="hidden" name="sitechPhoneNo" id="sitechPhoneNo" />
	<input type="hidden" name="orderArrayId" id="orderArrayId" />
	<input type="hidden" name="custOrderId" id="custOrderId" />
	<input type="hidden" name="custOrderNo" id="custOrderNo" />
	<input type="hidden" name="servOrderId" id="servOrderId" />
	<input type="hidden" name="closeId" id="closeId" />
	<input type="hidden" name="prtFlag" id="prtFlag" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>