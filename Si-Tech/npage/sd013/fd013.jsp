<%
  /*
   * ����: ����һ��
   * �汾: 2.0
   * ����: 2010/12/22
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
<title>����һ��/�ǳ�����</title>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = "";
	if(opCode.equals("d908") || opCode.equals("d909") || opCode.equals("d910")){
	    opName = "������ڳ�;";
	}else{
	    opName = "����һ��/�ǳ�����";
	}
	String phoneNo = request.getParameter("activePhone");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginPwd    = (String)session.getAttribute("password"); //��������
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regionCode"));
	String custName = "";
	//String getCustInfo = "select cust_name from dcustdoc where cust_id = (select cust_id from dcustmsg where phone_no = :phoneNo)";
	//lj. �󶨲���
	String sql_select1 = "select cust_name from dcustdoc where cust_id = (select cust_id from dcustmsg where phone_no = :phoneNo)";
	String srv_params1 = "phoneNo=" + phoneNo;
	System.out.println("��������һ��/�ǳ�����");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<wtc:service name="sCustNameQry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value=" "/>
		<wtc:param value=" "/>
			<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=loginPwd%>"/>
						<wtc:param value="<%=phoneNo%>"/>
							<wtc:param value=" "/>
</wtc:service>
<wtc:array id="result" scope="end" />
	<%
	if(!result[0][0].equals("0")&&!result[0][0].equals("000000")){
%>
<script type="text/javascript">
		rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
</script>
<%
}else {

	custName = result[0][2];
	System.out.println("wsdf"+custName);
	System.out.println(result.length);
	}
	String iChnSource = "01";
	String iQrytype = "0";
	String iSaleType = "";
	if(opCode.equals("d908") || opCode.equals("d909") || opCode.equals("d910")){
	   iSaleType = "2";
	}
	String iOfferType = "";
	String userPwd = "";
	System.out.println("-----"+loginAccept+"-----");
	System.out.println("-----"+iChnSource+"-----");
	System.out.println("-----"+opCode+"-----");
	System.out.println("-----"+workNo+"-----");
	System.out.println("-----"+loginPwd+"-----");
	System.out.println("-----"+phoneNo+"-----");
	System.out.println("-----"+userPwd+"-----");
	System.out.println("-----"+iQrytype+"-----");
	System.out.println("-----"+iSaleType+"-----");
	System.out.println("-----"+iOfferType+"-----");
	//String getBandNameSql = "select band_name from band where sm_code = (select sm_code from dcustmsg where phone_no = '"+phoneNo+"')";
		//lj. �󶨲���
	String sql_select2 = "select band_name from band where sm_code = (select sm_code from dcustmsg where phone_no = :phoneNo)";
	String srv_params2 = "phoneNo=" + phoneNo;
	String bandName = "";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:param value="<%=sql_select2%>"/>
	<wtc:param value="<%=srv_params2%>"/>
</wtc:service>
<wtc:array id="result2" scope="end" />
<%

	bandName = result2[0][0];
%>
<wtc:service name="sB997Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=loginAccept%>"/>
  <wtc:param value="<%=iChnSource%>"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginPwd%>"/>
  <wtc:param value="<%=phoneNo%>"/>
  <wtc:param value="<%=userPwd%>"/>
  <wtc:param value="<%=iQrytype%>"/>
  <wtc:param value="<%=iSaleType%>"/>
  <wtc:param value="<%=iOfferType%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
	if(!retCode1.equals("0")&&!retCode1.equals("000000")){
%>
<script type="text/javascript">
		rdShowMessageDialog("������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>",0);
</script>
<%
	}
%>
<script type="text/javascript">
	var offer = new Array();
	var effDate = new Array();
	var expDate = new Array();
	var comments;
	
<%
	for(int i=0 ;i<result1.length;i++){
%>
		offer[<%=i%>] = "<%=result1[i][0]+ '-' + result1[i][1]%>";
		effDate[<%=i%>] = "<%=result1[i][2]%>";
		expDate[<%=i%>] = "<%=result1[i][3]%>";
<%
	}
%>

	$(document).ready(function(){
		
		//opCode��Ӧչʾ
		if("<%=opCode%>" == "b997"){
			$("input[@name=opType][@value=0]").attr("checked",true);
			//$("input[@name=opFlag][@value=1]").attr("checked",true);
		}
		if("<%=opCode%>" == "b998"){
			$("input[@name=opType][@value=0]").attr("checked",true);
			//$("input[@name=opFlag][@value=2]").attr("checked",true);
		}
		if("<%=opCode%>" == "b999"){
			$("input[@name=opType][@value=0]").attr("checked",true);
			//$("input[@name=opFlag][@value=3]").attr("checked",true);
		}
		if("<%=opCode%>" == "d014"){
			$("input[@name=opType][@value=1]").attr("checked",true);
			//$("input[@name=opFlag][@value=2]").attr("checked",true);
		}
		if("<%=opCode%>" == "d013"){
			$("input[@name=opType][@value=1]").attr("checked",true);
			//$("input[@name=opFlag][@value=1]").attr("checked",true);
		}
		if("<%=opCode%>" == "d046"){
			$("input[@name=opType][@value=1]").attr("checked",true);
			//$("input[@name=opFlag][@value=3]").attr("checked",true);
		}
		//add by wanglma 20110610 ���Ӷ�����ڳ�;�ʷ����õĺ�����
		if("<%=opCode%>" == "d908"){
			$("input[@name=opType][@value=2]").attr("checked",true);
			$("#offerType").val("YnDa");
		}
		if("<%=opCode%>" == "d909"){
			$("input[@name=opType][@value=2]").attr("checked",true);
			$("#offerType").val("YnDa");
		}
		if("<%=opCode%>" == "d910"){
			$("input[@name=opType][@value=2]").attr("checked",true);
			$("#offerType").val("YnDa");
		}
		
		
		if("<%=opCode%>" == "b997" || "<%=opCode%>" == "b998" || "<%=opCode%>" == "b999"){
			$("#opType1").hide();
			$("#opType2").hide();
		}
		if("<%=opCode%>" == "d014" || "<%=opCode%>" == "d046" || "<%=opCode%>" == "d013"){
			$("#opType0").hide();
			$("#opType2").hide();
		}
		if("<%=opCode%>" == "d908" || "<%=opCode%>" == "d909" || "<%=opCode%>" == "d910"){
			$("#opType1").hide();
			$("#opType0").hide();
		}
		//add by wanglma 20110610 ���Ӷ�����ڳ�;�ʷ����õĺ�����
		/*
		//�����ȡ��ҵ���ײͲ�����
		if($("input[@name=opFlag][@value=2]").attr("checked")){
			$("#offerType").attr("disabled",true);
		}
		//������Ǳ��ҵ��  ����Ų��ɼ�
		if($("input[@name=opFlag][@value=3]").attr("checked")){
			$("#newTig").css("display","block");
			$("#newOfferCode").css("display","block");
			
		}else{
			$("#newTig").css("display","none");	
			$("#newOfferCode").css("display","none");
		}
		*/
		$("input[@name=opType]").click(function(){
			$("input[@name=opFlag]")[0].checked = false;
			$("input[@name=opFlag]")[1].checked = false;
			$("input[@name=opFlag]")[2].checked = false;
		});
		//ȡ��ҵ�����ײ����Ͳ�����
		$("input[@name=opFlag]").click(function(){
  		$("#oldOfferCode").empty();
  		$("#oldOfferCodeMulti").empty();
			if($("input[@name=opType]:checked").val() == "2"){
				if($("#offerType option[value='YnDa']").val() == undefined){
					$("#offerType").append("<option value='YnDa'>������ڳ�;</option>");
				}
			   	$("#offerType").val("YnDa");
			   	var iQrytype = $("input[@name=opFlag]:checked").val();
				var iSaleType = $("input[@name=opType]:checked").val();
				var iOfferType = $("#offerType").val();
				if(iOfferType != "0" && iQrytype != "2"){
					getOfferType(iQrytype,iSaleType,iOfferType);
				}
				$("#offerType").attr("disabled",true);
		    }else{
			    $("#offerType")[0].options(0).selected = true;//ѡ����ѡ��
			    $("#offerType").attr("disabled",false);
			    $("#offerType option[value='YnDa']").remove();
		    }
			$("#oldOfferCode").empty();//ѡ����ѡ��;
			$("#oldOfferCode").append("<option value=''>��ѡ��</option>");
			$("#newOfferCode").empty();
			$("#newOfferCode").append("<option value=''>��ѡ��</option>");
			//�����ȡ��ҵ���ײͲ�����
			if($(this).val() == "2"){
				$("#offerType")[0].options(0).selected = true;//ѡ����ѡ��
				$("#offerType").attr("disabled",true);	
				var iSaleType = $("input[@name=opType]:checked").val();
				getOfferType("2",iSaleType,"");
			}else{
				if($("input[@name=opType]:checked").val() == "2"){
					//$("#offerType").attr("disabled",true);
				}else{
					$("#offerType").attr("disabled",false);	
				}
			}
			//������Ǳ��ҵ��  ����Ų��ɼ�
			if($(this).val() == "3"){
				$("#newTig").css("display","block");	
				$("#newOfferCode").css("display","block");	
			}else{
				$("#newTig").css("display","none");	
				$("#newOfferCode").css("display","none");
			}
		});
		
		//���ύ
		$("#submitB").click(function(){
			/*
				1.��̬����opCode
				b997    ����һ�� ����
				b998	����һ�� ȡ��
				b999	����һ�� ���
				d013	�ǳ����� ����
				d014	�ǳ����� ȡ��
				d046	�ǳ����� ���
				d908	������ڳ�; ����
				d909	������ڳ�; ȡ��
				d910	������ڳ�; ���
			*/
			var flag1 = $("input[@name=opType]:checked").val();//opType
			var flag2 = $("input[@name=opFlag]:checked").val();//opFlag
			if(flag1 == 0 && flag2 == 1){
				$("#opCode").val("b997");
				$("#opName").val("����һ�� ����");
			}else if(flag1 == 0 && flag2 == 2){
				$("#opCode").val("b998");
				$("#opName").val("����һ�� ȡ��");
			}else if(flag1 == 0 && flag2 == 3){
				$("#opCode").val("b999");
				$("#opName").val("����һ�� ���");
			}else if(flag1 == 1 && flag2 == 1){
				$("#opCode").val("d013");
				$("#opName").val("�ǳ����� ����");
			}else if(flag1 == 1 && flag2 == 2){
				$("#opCode").val("d014");
				$("#opName").val("�ǳ����� ȡ��");
			}else if(flag1 == 1 && flag2 == 3){
				$("#opCode").val("d046");
				$("#opName").val("�ǳ����� ���");
			}else if(flag1 == 2 && flag2 == 1){
				$("#opCode").val("d908");
				$("#opName").val("������ڳ�; ����");
			}else if(flag1 == 2 && flag2 == 2){
				$("#opCode").val("d909");
				$("#opName").val("������ڳ�; ȡ��");
			}else if(flag1 == 2 && flag2 == 3){
				$("#opCode").val("d910");
				$("#opName").val("������ڳ�; ���");
			}
			//2.�������ͱ�ѡ
			var item = $("input[@name=opFlag]:checked");
			var len=item.length;
			if((len<=0) ){
				rdShowMessageDialog("�������ͱ�ѡ��",1);
				return ;
			}
			//3.�ײ����ͱ�ѡ
			if(flag2 != 2){
				if($("#offerType").val() == "0"){
					rdShowMessageDialog("�ײ����ͱ�ѡ��",1);
					return ;
				}
			}
			//4.�ʷѴ����ѡ
			if (item.val() == "1" && $("#offerType").val() == "YnDz" && ($("input[@name=oldOfferCodeMulti]:checked").length < 1 || $("input[@name=oldOfferCodeMulti]:checked").length > (2 - parseInt(document.getElementById("offerNum").value)))) {
				var tip = "���Ѿ�������" + parseInt(document.getElementById("offerNum").value) + "��ʡ���ײͣ�";
				if (parseInt(document.getElementById("offerNum").value) >= 2) {
					tip += "�����ٰ���";
				} else {
					tip += "�������ٰ���1����������"+(2 - parseInt(document.getElementById("offerNum").value))+"����";
				}
				rdShowMessageDialog(tip, 1);
				return ;
			}	else if (item.val() == "1" && $("#offerType").val() == "YnDy" && ($("input[@name=oldOfferCodeMulti]:checked").length < 1 || $("input[@name=oldOfferCodeMulti]:checked").length > (3 - parseInt(document.getElementById("offerNum").value)))) {
				var tip = "���Ѿ�������" + parseInt(document.getElementById("offerNum").value) + "��ʡ���ײͣ�";
				if (parseInt(document.getElementById("offerNum").value) >= 3) {
					tip += "�����ٰ���";
				} else {
					tip += "�������ٰ���1����������"+(3 - parseInt(document.getElementById("offerNum").value))+"����";
				}
				rdShowMessageDialog(tip, 1);
				return ;
			} else if(item.val() == "3" && ("0" == $("#oldOfferCode").val() || $("#oldOfferCode").val() == "" | $("#oldOfferCode").val() == null)){
				rdShowMessageDialog("��ѡ���ʷѴ��룡",1);
				return ;
			}
			//д������־ xxxxΪxxxx����xxxxҵ��
			var note = "<%=workNo%>Ϊ<%=phoneNo%>����"+$("#opName").val();
			$("#iOpNOte").val(note);
			//��ӡ���

			var productIdObj = document.getElementById("productId");
			var getOfferCmtsPacket = new AJAXPacket("fb013_ajaxGetOfferCmts.jsp", "���ڻ�ȡ�����ʷ����������Ժ�......");
			if ($("input[@name=opFlag]:checked").val() == "3") {
				getOfferCmtsPacket.data.add("offerId", document.getElementById("newOfferCode").value.split("-")[0]);
			} else if ($("input[@name=opFlag]:checked").val() == "1") {
				var offerId;
				if ($("#offerType").val() == "YnDa") {
					offerId = document.getElementById("oldOfferCode").value.split("-")[0];
				} else {
					$("input[@name=oldOfferCodeMulti]:checked").each(function() {
						offerId = this.value;
					});
				}
				getOfferCmtsPacket.data.add("offerId", offerId);
			} else {
				var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	
				if(typeof(ret) != "undefined"){
					if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
						frm.submit();
					}
				} else {
					if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
						frm.submit();
					}
				}
				return;
			}
			
			core.ajax.sendPacket(getOfferCmtsPacket, doGetCmts);
		});
		//������ѯ
		$("#offerType").change(function(){
			//����ѡ���������
			var flag1 = $("input[@name=opType]:checked").val();//opType
			var item = $("input[@name=opFlag]:checked");
			var len=item.length;
			if(len<=0 && flag1!=2){
				$("#offerType")[0].options(0).selected = true;//ѡ����ѡ��
				rdShowMessageDialog("�������ͱ�ѡ��",1);
				return ;
			}
			var iQrytype = $("input[@name=opFlag]:checked").val();
			var iSaleType = $("input[@name=opType]:checked").val();
			var iOfferType = $(this).val();
			if($(this).val() != "0"){
				getOfferType(iQrytype,iSaleType,iOfferType);
			}
		});
	});	
	

	
	function doGetCmts(packet) {
		var retResult = packet.data.findValueByName("retResult");
		if (retResult == "000000") {
			comments = packet.data.findValueByName("comments");
		} else {
			comments = "ȡ�ʷ�����ʧ�ܡ�";
		}

		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.submit();
			}
		} else {
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.submit();
			}
		}
	}
	
	function getOfferType(iQrytype,iSaleType,iOfferType){
		var packet = new AJAXPacket("ajaxGetOfferType.jsp");
		packet.data.add("loginAccept", "<%=loginAccept%>");
	    packet.data.add("iChnSource", "<%=iChnSource%>");
	    packet.data.add("opCode", "<%=opCode%>");
	    packet.data.add("workNo", "<%=workNo%>");
	    packet.data.add("loginPwd", "<%=loginPwd%>");
	    packet.data.add("phoneNo", "<%=phoneNo%>");
	    packet.data.add("userPwd", "<%=userPwd%>");
	    packet.data.add("iQrytype", iQrytype);
	    packet.data.add("iSaleType", iSaleType);
	    packet.data.add("iOfferType", iOfferType);
	    core.ajax.sendPacket(packet, doShowOffer, true);
	    packet = null;
	}
	
	function doShowOffer(packet){
		var retCode = packet.data.findValueByName("retCode"); 
  	var retMsg = packet.data.findValueByName("retMsg"); 
  	var flag = packet.data.findValueByName("flag");
  	var offerData = packet.data.findValueByName("offerData");
  	var offerNum = packet.data.findValueByName("offerNum");
  	var offerExpDate = packet.data.findValueByName("offerExpDate");
  	var iOfferType = packet.data.findValueByName("iOfferType");
  	document.getElementById("offerNum").value = offerNum;
  	document.getElementById("offerExpDate").value = offerExpDate.substr(0,8);
  	var offerObj = eval("("+offerData+")");//json
  	
  	if(((iOfferType == "YnDz" || iOfferType == "YnDy") && flag == "new") || (flag == "cancel" && "<%=opCode%>" != "d908" && "<%=opCode%>" != "d909" && "<%=opCode%>" != "d910")){	//2011/11/21 wanghfa�޸�
  	//if(((iOfferType == "YnDz" || iOfferType == "YnDy") && (flag == "new" || flag == "cancel"))){	//2011/11/21 wanghfa�޸�
  		$("#oldOfferCode").empty();
  		$("#oldOfferCodeMulti").empty();
			$("#oldOfferCode").hide();
  		$("#oldOfferCodeMulti").show();
  		if(offerObj.offerArr.length <= 0){
  			rdShowMessageDialog("û����Ӧ�ʷѣ�",1);
  		}
			for(var i =0;i<offerObj.offerArr.length;i++){
				$("#oldOfferCodeMulti").append("<input type='checkbox' name='oldOfferCodeMulti' value="+offerObj.offerArr[i].offerId+" v_name='"+offerObj.offerArr[i].offerName+"'>"+offerObj.offerArr[i].offerId+"-"+offerObj.offerArr[i].offerName+"&nbsp;");
			}
  	} else if (iOfferType != "YnDz" && iOfferType != "YnDy") {
			if(flag == "new" || flag == "cancel"){
				$("#oldOfferCode").empty();
	  		$("#oldOfferCodeMulti").empty();
				$("#oldOfferCode").show();
	  		$("#oldOfferCodeMulti").hide();
				if(offerObj.offerArr.length <= 0){
					rdShowMessageDialog("û����Ӧ�ʷѣ�",1);
				}
				for(var i =0;i<offerObj.offerArr.length;i++){
					$("#oldOfferCode").append("<option value="+offerObj.offerArr[i].offerId+">"+offerObj.offerArr[i].offerId+"-"+offerObj.offerArr[i].offerName+"</option>");
				}
			}else if(flag == "change"){
	  		$("#oldOfferCodeMulti").empty();
	  		$("#oldOfferCodeMulti").hide();
				var newOfferData = packet.data.findValueByName("newOfferData");
				var newOfferObj = eval("("+newOfferData+")");//json
				$("#oldOfferCode").empty();
				if(offerObj.offerArr.length <= 0){
					rdShowMessageDialog("û����Ӧ�ʷѣ�",1); 
					$("#oldOfferCode").append("<option value='0'>��ѡ��</option>");
					return;
				}
				for(var i =0;i<offerObj.offerArr.length;i++){
					$("#oldOfferCode").append("<option value="+offerObj.offerArr[i].oldOfferId+">"+offerObj.offerArr[i].oldOfferId+"-"+offerObj.offerArr[i].oldOfferName+"</option>");
				}
				$("#newOfferCode").empty();
				for(var i =0;i<newOfferObj.newOfferArr.length;i++){
					$("#newOfferCode").append("<option value="+newOfferObj.newOfferArr[i].newOfferId+">"+newOfferObj.newOfferArr[i].newOfferId+"-"+newOfferObj.newOfferArr[i].newOfferName+"</option>");
				}
			}
  	} else {
  		$("#oldOfferCode").empty();
  		$("#oldOfferCodeMulti").empty();
			$("#oldOfferCode").show();
  		$("#oldOfferCodeMulti").hide();
  		var newOfferData = packet.data.findValueByName("newOfferData");
  		var newOfferObj = eval("("+newOfferData+")");//json
  		if(offerObj.offerArr.length <= 0){
  			rdShowMessageDialog("û����Ӧ�ʷѣ�",1); 
  			$("#oldOfferCode").append("<option value='0'>��ѡ��</option>");
  			return;
  		}
			for(var i =0;i<offerObj.offerArr.length;i++){
				$("#oldOfferCode").append("<option value="+offerObj.offerArr[i].oldOfferId+">"+offerObj.offerArr[i].oldOfferId+"-"+offerObj.offerArr[i].oldOfferName+"</option>");
			}
			$("#newOfferCode").empty();
			for(var i =0;i<newOfferObj.newOfferArr.length;i++){
				$("#newOfferCode").append("<option value="+newOfferObj.newOfferArr[i].newOfferId+">"+newOfferObj.newOfferArr[i].newOfferId+"-"+newOfferObj.newOfferArr[i].newOfferName+"</option>");
			}
  	}
	}
	
	function showPrtDlg(printType, DlgMessage, submitCfm){  //��ʾ��ӡ�Ի���
		var h = 210;
		var w = 400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		
		var pType = "subprint";
		var billType = "1";
		var sysAccept = "<%=loginAccept%>";
		var printStr  =  printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var phoneNo = $("#userPhone").val();
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType){
		
		
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="�ֻ����룺" + $("#userPhone").val() + "|";
		cust_info+="�ͻ�������" + $("#custName").val() + "|";
		
		opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +"�û�Ʒ�� ��"+"<%=bandName%>"+ "|";
		opr_info += "����ҵ��"+$("#opName").val()+"  ������ˮ��"+"<%=loginAccept%>"+"|";
		
		opr_info += "|";
		if ($("input[@name=opFlag]:checked").val() == "1") { //����
			
			if (document.getElementById("offerType").value == "YnDz") {
				opr_info += "ҵ����Чʱ�䣺24Сʱ֮��      ʧЧʱ�䣺"+document.getElementById("offerExpDate").value+"|";
				opr_info += "�ײ����" + $("#offerType").find("option:selected").text() + "|";
				//2011/11/22 wanghfa�޸�
				var oldOfferCode = "";
				$("input[@name=oldOfferCodeMulti]:checked").each(function() {
					oldOfferCode += this.value + "-" + this.v_name + "  ";
				});
				opr_info += "�����ʷѣ�" + oldOfferCode + "|";
				//opr_info += "�����ʷѣ�" + $("#oldOfferCode").find("option:selected").text() + "|";
			} else if (document.getElementById("offerType").value == "YnDy") {
				opr_info += "ҵ����Чʱ�䣺24Сʱ֮��      ʧЧʱ�䣺"+document.getElementById("offerExpDate").value+"|";
				opr_info += "�ײ����" + $("#offerType").find("option:selected").text() + "|";
				//2011/11/22 wanghfa�޸�
				var oldOfferCode = "";
				$("input[@name=oldOfferCodeMulti]:checked").each(function() {
					oldOfferCode += this.value + "-" + this.v_name + "  ";
				});
				opr_info += "�����ʷѣ�" + oldOfferCode + "|";
				//opr_info += "�����ʷѣ�" + $("#oldOfferCode").find("option:selected").text() + "|";
			}else if (document.getElementById("offerType").value == "YnDa") {
				opr_info += "�����ʷѣ�" + $("#oldOfferCode").find("option:selected").text() + "|";
				opr_info += "��ʹ�÷ѣ�3Ԫ "+"|";
				opr_info += "ҵ����Чʱ�䣺24Сʱ֮��      ʧЧʱ�䣺"+document.getElementById("offerExpDate").value+"|";
			}
			if(document.getElementById("offerType").value == "YnDa"){
				note_info1 += "�ʷ�������"+"|";
				note_info1 += comments + "|";
				//note_info1 += "�ײ���ʹ�÷�3Ԫ/ʡ���ں��������ֱ��ָ��ʡ��0.19Ԫ/���ӡ�"+ "|";
				//note_info1 += "˵����ָ����������Ϊ������ڳ�;ָ��ʡ��ʱ���ײ���ʹ�÷�3Ԫ���ں��������ֱ��������������еĺ�����ʡ�ڳ���0.19Ԫ/���ӡ�"+"|";
			}else{
			note_info1 += "�ʷ�������"+"|";
			note_info1 += comments + "|";
			note_info1 += "˵������������V���ڲ�ͨ�����ʷѰ�����V���ʷѱ�׼��ȡ��"+"|";
			}
			
		} else if ($("input[@name=opFlag]:checked").val() == "2"){ //ȡ��
			//2011/11/22 wanghfa�޸�
			if ("<%=opCode%>" != "d908" && "<%=opCode%>" != "d909" && "<%=opCode%>" != "d910") {
				var oldOfferCode = "";
				$("input[@name=oldOfferCodeMulti]:checked").each(function() {
					oldOfferCode += this.value + "  ";
				});
				opr_info += "ȡ���ʷѣ�" + oldOfferCode + "|";
			} else {
				opr_info += "ȡ���ʷѣ�" + $("#oldOfferCode").val() + "|";
			}
			
			if($("input[@name=opType]:checked").val() == "2"){
				opr_info += "�ʷ�ʧЧʱ�䣺����ʧЧ|";
	    }else{
				for (var a = 0; a < <%=result1.length%>; a  ++) {
					if (offer[a] == $("#oldOfferCode").find("option:selected").text()) {
						if (effDate[a].substring(0,8) == '<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>') {
							opr_info += "�ʷ�ʧЧʱ�䣺24Сʱ֮��|";
							break;
						} else {
							var eff = '<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>';
							if (eff.substring(4,6) == "12") {
								eff = (parseInt(eff.substring(0,4)) + 1) + "0101";
							} else {
								eff = (parseInt(eff) + 1) + "01";
							}
							opr_info += "�ʷ�ʧЧʱ�䣺"+eff+"|";
							break;
						}
					}
				}
			}
		} else { //���
			
			if($("input[@name=opType]:checked").val() == "2"){
				opr_info += "ԭ�ײʹ��룺" + $("#oldOfferCode").find("option:selected").text() + "    ���Ϊ��"+ $("#newOfferCode").find("option:selected").text() + "|";	
				opr_info += "ҵ����Чʱ�䣺������Ч|";
		    }else{
		    	opr_info += "�ײ����" + $("#offerType").find("option:selected").text() + "|";
			opr_info += "ԭ�ײʹ��룺" + $("#oldOfferCode").find("option:selected").text() + "    ���Ϊ��"+ $("#newOfferCode").find("option:selected").text() + "|";	
			for (var a = 0; a < <%=result1.length%>; a  ++) {
				if (offer[a] == $("#oldOfferCode").find("option:selected").text()) {
					if (effDate[a].substring(0,8) == '<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>') {
						opr_info += "ҵ����Чʱ�䣺24Сʱ֮��|";
						break;
					} else {
						var eff = '<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>';
						if (eff.substring(4,6) == "12") {
							eff = (parseInt(eff.substring(0,4)) + 1) + "0101";
						} else {
							eff = (parseInt(eff) + 1) + "01";
						}
						opr_info += "ҵ����Чʱ�䣺"+eff+"|";
						break;
					}
				}
			}
		}
			note_info1 += "�ʷ�������"+"|";
			note_info1 += comments + "|";
			if($("input[@name=opType]:checked").val() == "2"){
				//note_info1 += "�ײ���ʹ�÷�3Ԫ/ʡ���ں��������ֱ��ָ��ʡ��0.19Ԫ/���ӡ�" + "|";
				//note_info1 += "˵����ָ����������Ϊ������ڳ�;ָ��ʡ��ʱ���ײ���ʹ�÷�3Ԫ���ں��������ֱ��������������еĺ�����ʡ�ڳ���0.19Ԫ/���ӡ�"+"|";
		    }else{
		    	//note_info1 += comments + "|";
		    	note_info1 += "˵������������V���ڲ�ͨ�����ʷѰ�����V���ʷѱ�׼��ȡ��"+"|";
		    }
			
		}
		if (($("input[@name=opType]:checked").val() == "2") && ($("input[@name=opFlag]:checked").val() != "2")) {
			
		}else{
			/* add ����һ��+���롢�����ȡ��+ʡ�ʣ���չʾ��仰 for ���ڳ�;�����ʷ���������ĺ�@2014/12/18 */
			if(($("input[@name=opType]:checked").val() == "0") && ($("#offerType").val() == "YnDz")){ 
				if ("<%=opCode%>" == "b997" || "<%=opCode%>" == "b998" || "<%=opCode%>" == "b999") {
				
				}else{
					note_info1 += "�ʷ�ʧЧ���Ż��Զ�ȡ����"+"|";	
				}
			}else{
				note_info1 += "�ʷ�ʧЧ���Ż��Զ�ȡ����"+"|";
			}
		}
		
		if (($("input[@name=opFlag]:checked").val() == "1" || $("input[@name=opFlag]:checked").val() == "2") && "<%=opCode%>" != "d908" && "<%=opCode%>" != "d909" && "<%=opCode%>" != "d910") {
			var oldOfferCode = "";
			$("input[@name=oldOfferCodeMulti]:checked").each(function() {
				oldOfferCode += this.value + "  ";
			});
			note_info1 += '��ע��'+$("#opName").val()+'       �ʷѴ��룺'+ oldOfferCode + "|";
		} else {
			note_info1 += '��ע��'+$("#opName").val()+'       �ʷѴ��룺'+$("#oldOfferCode").val()+ "|";
		}

		if ("<%=opCode%>" == "b997" || "<%=opCode%>" == "b998" || "<%=opCode%>" == "b999") {
			
			/* add ����һ������+���+ȡ���У�ʡ�� ��ע��Ϣ�е��� for ���ڳ�;�����ʷ���������ĺ�@2014/12/18  */
			if($("input[@name=opType]:checked").val() == "0"){ //����һ��
				
				if($("#offerType").val() == "YnDz"){ //ʡ��
					note_info2 += "����һ����Ϊ����ͻ�����ͨ����Ҫ���ṩ�Ķ��������Żݷ�����ָ���������α���ͨ����ѣ�����ͨ�������Żݣ�������γ��к�ȡ���ײ;�Ϊ����1����Ч����ӭ���μӻ��" + "|";
				/* add ����һ������+���+ȡ���У�ʡ�� ��ע��Ϣ�е��� for ʡ������һ�ҳ�̬���Ż�����@2014/12/29  */
				}else if($("#offerType").val() == "YnDy"){ //ʡ��
					note_info2 += "����һ����Ϊ����ͻ��´��ڼ�����ͨ����Ҫ���ṩ�Ķ��������Żݷ�����ָ���������α���ͨ����ѣ�����ͨ�������Żݡ�������γ��к�ȡ���ײ;�Ϊ����1����Ч��ҵ����Ч��36���¡�" + "|";
				}else{
					
					if($("input[@name=opFlag]:checked").val() == "2") {
						
						 note_info2 += "����һ����Ϊ����ͻ�����ͨ����Ҫ���ṩ�Ķ��������Żݷ�����ָ���������α���ͨ����ѣ�����ͨ�������Żݣ�ȡ���ײ�����1����Ч����ӭ���μӻ��"+"|";
					}else {
						
						var dayintime="";
					  if($("#offerType").val() == "YnDz") {
					  			dayintime="2014��7��1��-2014��8��31��";
					  }else {
					  			dayintime="2014��1��1����ʱ��2014��12��31��24ʱ";
					  }
						note_info2 += "����һ����Ϊ����ͻ��´��ڼ�����ͨ����Ҫ���ṩ�Ķ��������Żݷ�����ָ���������α���ͨ����ѣ�����ͨ�������Żݣ����ɻ��������غ����������ֱ��12582�������ͨ����������30���Ӻ��������Ϣ���񣬻�ȡ���������ߡ���Ƹ����й���λ��Ϣ��������γ��к�ȡ���ײ;�Ϊ����1����Ч���ʱ��Ϊ"+dayintime+"��ȡ�����Ϳɻظ���QXWGYT������ӭ���μӻ��"+"|";
				  }
				}
				
			}else{
				
				if($("input[@name=opFlag]:checked").val() == "2") {
					 note_info2 += "����һ����Ϊ����ͻ��´��ڼ�����ͨ����Ҫ���ṩ�Ķ��������Żݷ�����ָ���������α���ͨ����ѣ�����ͨ�������Żݣ����ɻ��������غ����������ֱ��12582�������ͨ����������30���Ӻ��������Ϣ���񣬻�ȡ���������ߡ���Ƹ����й���λ��Ϣ��������γ��к�ȡ���ײ;�Ϊ����1����Ч���ʱ��Ϊ:ʡ��2014��1��1����ʱ��2014��12��31��24ʱ��ʡ��2014��7��1��-2014��8��31�գ�ȡ�����Ϳɻظ���QXWGYT������ӭ���μӻ��"+"|";
				}else {
					var dayintime="";
				  if($("#offerType").val() == "YnDz") {
				  			dayintime="2014��7��1��-2014��8��31��";
				  }else {
				  			dayintime="2014��1��1����ʱ��2014��12��31��24ʱ";
				  }
					note_info2 += "����һ����Ϊ����ͻ��´��ڼ�����ͨ����Ҫ���ṩ�Ķ��������Żݷ�����ָ���������α���ͨ����ѣ�����ͨ�������Żݣ����ɻ��������غ����������ֱ��12582�������ͨ����������30���Ӻ��������Ϣ���񣬻�ȡ���������ߡ���Ƹ����й���λ��Ϣ��������γ��к�ȡ���ײ;�Ϊ����1����Ч���ʱ��Ϊ"+dayintime+"��ȡ�����Ϳɻظ���QXWGYT������ӭ���μӻ��"+"|";
			  }
			}
		}

		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}
	
	
	
	
function FixWidth(selectObj)
{
	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
	    absTop += e.offsetTop;
	    absLeft += e.offsetLeft;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft + "px";
	    width = "auto";
	}
   
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}
</script>
</head>
<body>

<form name="frm" method="POST" action="fd013Cfm.jsp">

<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="custName" id="custName" value="<%=custName%>">
<input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>">
<input type="hidden" name="offerNum" id="offerNum" value="">
<input type="hidden" name="offerExpDate" id="offerExpDate" value="">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=request.getParameter("opName")%></div>
</div>
<table cellspacing="0">
	<tr>
		<td width="20%" class="blue">Ӫ������</td>	
		<td width="80%" class="blue" colspan="3">
			<div id="opType0"><input type="radio" name="opType" value="0"  />����һ��</div>
			<div id="opType1"><input type="radio" name="opType" value="1"  />�ǳ�����</div>	
			<div id="opType2"><input type="radio" name="opType" value="2"  />������ڳ�;</div>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">��������</td>	
		<td width="80%" class="blue" colspan="3">
			<input type="radio" name="opFlag" value="1" />����
			<input type="radio" name="opFlag" value="2" />ȡ��
			<input type="radio" name="opFlag" value="3" />���
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">�û�����</td>		
		<td width="80%" class="blue" colspan="3">
			<input type="text" name="userPhone" id="userPhone" Class="InputGrey" value="<%=phoneNo%>" readonly/>	
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">�ͻ�����</td>		
		<td width="80%" class="blue" colspan="3">
			<input type="text" name="kehuname" id="kehuname" Class="InputGrey" value="<%=custName%>" readonly/>	
		</td>
	</tr>	
	<tr>
		<td width="20%" class="blue">�ײ�����</td>
		<td width="80%" class="blue" colspan="3">
			<select name="offerType" id="offerType">
				<option value="0">��ѡ��</option>
				<option value="YnDz">ʡ��</option>	
				<option value="YnDy">ʡ��</option>	
				<option value="YnDa">������ڳ�;</option>
			</select>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">�ײʹ���</td>
		<td width="80%" class="blue">
			<select name="oldOfferCode" id="oldOfferCode" style="width:400px">
				<option>��ѡ��</option>
			</select>
			<div name="oldOfferCodeMulti" id="oldOfferCodeMulti"></div>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue"><span id="newTig" style="display:none">���Ϊ</span></td>
		<td width="80%" class="blue">
			<select name="newOfferCode" id="newOfferCode" style="display:none" style="width:400px">
				<option>��ѡ��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">��ע</td>	
		<td width="80%" class="blue" colspan="3">
			<input name="iOpNOte" id="iOpNOte" class="button" size="60" maxlength="60" index="38"  v_must="0" v_maxlength="60" readonly/>
		</td>
	</tr>
</table>
<div class="title">
	<div name="title_zi" id="title_zi">�û���ǰ������Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">�û�����</td>
		<td class="blue">�ײ�����</td>
		<td class="blue">�ײ�����</td>
		<td class="blue">��Чʱ��</td>
		<td class="blue">ʧЧʱ��</td>
	</tr>
<%
	for(int i=0 ;i<result1.length;i++){
%>
	<tr>
		<td class="blue"><%=phoneNo%></td>
		<td class="blue"><%=result1[i][4]%></td>
		<td class="blue"><%=result1[i][0]+ '-' + result1[i][1]%></td>
		<td class="blue"><%=result1[i][2]%></td>
		<td class="blue"><%=result1[i][3]%></td>	
	</tr>
<%
	}
%>
</table>
<table cellspacing="0">
	<tr>
	    <td colspan="2" id="footer">
	      <input class="b_foot" type=button name="submitB" id="submitB" value="ȷ��">
	      <input class="b_foot" type=button name="closeTab" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
	    </td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>