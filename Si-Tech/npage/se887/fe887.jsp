<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>��������·����ѯ</title>
	<%
		String opCode = "e887";
		String opName = "IMS�̻�������centrexҵ��";
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
		//���ù������棬���м��ſͻ�ѡ��
		function getInfo_Cust(){
			var pageTitle = "���ſͻ�ѡ��";
			var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|������֯|";
			var sqlStr = "";
			var selType = "S";    //'S'��ѡ��'M'��ѡ
			var retQuence = "7|0|1|2|3|4|5|6|";
			var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
			/**add by liwd 20081127,group_id����dcustDoc��group_id end **/
			var cust_id = document.frm.cust_id.value;
			if(document.frm.iccid.value == "" &&
			document.frm.cust_id.value == "" &&
			document.frm.unit_id.value == "")
			{
				rdShowMessageDialog("������֤�����롢�ͻ�ID����ID���в�ѯ��");
				document.frm.iccid.focus();
				return false;
			}
			
			if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
			{
				frm.cust_id.value = "";
				rdShowMessageDialog("���������֣�");
				return false;
			}
			
			if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
			{
				frm.unit_id.value = "";
				rdShowMessageDialog("���������֣�");
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
			/*add by liwd 20081127,group_id����dcustDoc��group_id
			**var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|";;
			**/
			var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
			/**add by liwd 20081127,group_id����dcustDoc��group_id end **/
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
			
			var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3690/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
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
				rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
				frm.custPwd.value = "";
				frm.custPwd.focus();
				return false;
			} else {
				rdShowMessageDialog("�ͻ�����У��ɹ���",2);
				document.frm.next.disabled = false;
			}
		}
		else{
			rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
			return false;
		}
	}
		function doProcess(packet)
		{
	    var retType = packet.data.findValueByName("retType");
	    var retCode = packet.data.findValueByName("retCode");
	    var retMessage=packet.data.findValueByName("retMessage");
	    self.status="";
			if(retType == "checkPwd") //���ſͻ�����У��
			{
				if(retCode == "000000"){
					var retResult = packet.data.findValueByName("retResult");
					if (retResult == "false") {
						rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
						frm.custPwd.value = "";
						frm.custPwd.focus();
						return false;	        	
					} else {
					    rdShowMessageDialog("�ͻ�����У��ɹ���",2);
					}
				}
				else{
					rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
					return false;
				}
			}	
		}
		function qryProductOffer(){
	    var pageName = "/npage/portal/shoppingCar/qryProductOfferComplex.jsp?opCode="+initOpCode;
	   	window.open(pageName,'����Ʒѡ��','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		}
		function resultProcess(resultList){
			 if (resultList != null){
			 	//alert(resultList);
        var result1 = resultList.split("|");
        for (var n = 0; n < result1.length; n++){
        	var result2 = result1[n].split(",");
        	var offerId = result2[0];					//����Ʒ��ʶ
          var offerName = result2[1];				//����Ʒ����
          var offerType = result2[7];	      //����Ʒ���� 30��� 10����
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
	    var agent_name = $("#cust_name").val(); 									//����������
	    var agent_idType = "2"; 							//֤������
	    var agent_idNo = $("#iccid").val(); 									//֤������
	    var agent_phone = " ";//��ϵ�绰
	    var ContactMobile = " ";//�ֻ�
	    var zipcode = " ";//��������
	    var ContactUserAddr = " ";//��ַ
	    var ContactEmailAddress = " ";//����
	    var optorData = agent_name + "," + agent_idType + "," + agent_idNo + "," + agent_phone + "," + ContactMobile + "," + zipcode + "," + ContactUserAddr + "," + ContactEmailAddress;
	    return optorData;
		}
		function custOrderC(){
			if($("#cust_id").val() == ""){
				rdShowMessageDialog("���ѯ���ſͻ���Ϣ");
        return false;
			}
			if($("#offerId").val() == ""){
				rdShowMessageDialog("��ѡ������Ʒ");
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
				rdShowMessageDialog("�����ͻ�����ʧ��!����ϵϵͳ����Ա!");
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
				/*��ֵ*/
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
		  		  rdShowMessageDialog("��������ʧ��!");
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
		<div id="title_zi">������֤</div>
	</div>
	<table cellspacing="0">
    <tr>
      <td class=blue>֤������</td>
      <td>
        <input name="iccid" id="iccid" size="24" maxlength="20" v_type="string" v_must=1>
        <input name="custQuery" type="button" id="custQuery" 
         class="b_text" onClick="getInfo_Cust();" 
          onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ />
        <font class="orange">*</font>
      </td>
      <td class=blue>���ſͻ�ID</TD>
      <td>
        <input type="text" name="cust_id" id="cust_id" size="20" maxlength="12" v_type="0_9" v_must=1 index="2">
        <font class="orange">*</font>
      </td>
    </tr>
    <tr>
      <td class=blue>���ű��</td>
      <td>
          <input name="unit_id" id="unit_id" size="24" maxlength="11" v_type="0_9" v_must=1 index="3" value="4510976840" />
          <font class="orange">*</font>
      </td>
      <td class=blue>���ſͻ�����</td>
      <td>
          <input name="cust_name" id="cust_name" size="20" readonly v_must=1 v_type=string index="4">
          <font class="orange">*</font>
      </td>
    </tr>
    <tr>
      <td class=blue>���ſͻ�����</td>
      <td colspan="3">
        <jsp:include page="/npage/common/pwd_1.jsp">
        <jsp:param name="width1" value="16%"  />
        <jsp:param name="width2" value="34%"  />
        <jsp:param name="pname" value="custPwd"  />
        <jsp:param name="pwd" value="<%=123%>"  />
        </jsp:include>
        <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
        <font class="orange">*</font>
      </td>
    </tr>
    <tr>
    	<td class="blue">����Ʒѡ��</td>
    	<td colspan="3">
    		<input type="text" id="offerName" name="offerName" 
    		 readonly="readonly" class="InputGrey"/>
    		<input type="button" id="chooseProdBtn" value="ѡ��" 
    		 class="b_text" onclick="qryProductOffer()"/>
    	</td>
    </tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="next" class="b_foot" value="��һ��" onclick="custOrderC()" disabled />
				&nbsp;
				<input type="reset" name="query" class="b_foot" value="���" onclick="initPage()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
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