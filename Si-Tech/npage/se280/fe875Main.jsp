<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		String regionCode= (String)session.getAttribute("regCode");
 		String work_no = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String operPhoneNo = request.getParameter("parentPhone");
 		String familyCode = request.getParameter("familyCode");
 		String familyName = request.getParameter("familyName");
 		String backAccept = request.getParameter("backAccept");
 		String belongGroupId = request.getParameter("belongGroupId");
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
 		String printName = "";
 		System.out.println("------------liujian---------------familyCode=" + familyCode);
 		System.out.println("------------liujian---------------familyName=" + familyName);
 		System.out.println("------------liujian---------------opCode=" + opCode);
 		if("e283".equals(opCode)){
 			printName = "�Ҹ���ͥ��Աҵ���˶�";
 		}else if("e284".equals(opCode)){
 			printName = "�Ҹ���ͥҵ���˶�";
 		}else if("e285".equals(opCode)){
 			printName = "�Ҹ���ͥǩԼ�������";
 		}
 		
 		String tableTitleStr = "";
 		if("e875".equals(opCode)){
 			tableTitleStr = "��Ҫ������ѡ�ʷ�";
 		}else if("e880".equals(opCode)){
 			tableTitleStr = "��Ҫ�˶��ʷ�";
 		}else if("e881".equals(opCode)){
 			tableTitleStr = "��Ҫ�����ʷ�";
 		}
 		
 		String printAccept="";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="7">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=operPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
<%
	if(!code0.equals("000000")){
		System.out.println("----- fe280Quir.jsp ---- ��ѯ����" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code0%>" + "<%=msg0%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
	}
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	String parentPhone ="";
	String parentCustName = "";
	String parentMembRoleId = "";
	boolean selfFlag = true;
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg1" retcode="code1" outnum="15">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=operPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="3"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		System.out.println("========== ningtn ====" + code1 + " | " + result1.length);
		String mainOfferName = "";
		String mainOfferComments = "";
		for(int i = 0; i < result1.length; i++){
			if("M".equals(result1[i][1])){
				mainOfferName = result1[i][13];
				mainOfferComments = result1[i][14];
			}
		}
		if("000000".equals(code1)){
			familyMemberList = result1;
			for(int i = 0; i < familyMemberList.length; i++){
				if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
					parentPhone = familyMemberList[i][3];
					parentCustName = familyMemberList[i][9];
					parentMembRoleId = familyMemberList[i][0];
				}
			}
			if(parentPhone.equals(operPhoneNo)){
				selfFlag = true;
			}else{
				selfFlag = false;
			}
		}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
		}
%>
<html>
<head>
	<title>��ͥ��Ʒ���</title>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe280PubScript.js"></script>
	<script language="javascript">
		
		var familyRoleList = new FamRoleList();
	//	var famOffer = new FamOffer();
		var famBusiArray = new Array();
		var hideArr = new Array();
		function nextStep(subButton){
			if("<%=opCode%>" == "e284"){
				if(!checkElement(document.form1.machFee)){
					return false;
				}	
			}
			/* ��ť�ӳ� */
			controlButt(subButton);
			/* �º����� */
			getAfterPrompt();
			
			/* ƴװ���� */
			setJSONText();
			getPrintInfo();
			/* ��ӡ���&�ύҳ�� */
			printCommit('<%=opCode%>');
		}
		
		function getPrintInfo(){
				/**********
				��ȡ�����ӡ��Ϣ
				�����ʷ����ƺ��ʷ�����
				���÷���sFamSelCheck������
				7   ��ѯ����         iQryType �� 7 
				9   ��Ʒ����         iProdCode���봫
				*/
			var famProdInfoObj = $("#familyProdInfo");
			var getdataPacket = new AJAXPacket("fe280PubGetMsg.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",famProdInfoObj.val());
			getdataPacket.data.add("outNum","3");
	      <%if("e875".equals(opCode) ||"e880".equals(opCode) || "e881".equals(opCode)){ %>
			getdataPacket.data.add("queryType","8");
	      <%} else {%>
	        getdataPacket.data.add("queryType","7");
	      <%}%>
			core.ajax.sendPacket(getdataPacket,doPrintInfoBack);
			getdataPacket = null;
		}
		function doPrintInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode == "000000"){
				$("#pubPrtOfferId").val(result[0][0]);
				$("#pubPrtOfferName").val(result[0][1]);
				$("#pubPrtOfferComments").val(result[0][2]);
			}
		}
		
		function getNote(){
			var returnStr = "";
			var opCode = "<%=opCode%>";
			var roleObj;
			
			if(opCode == "e875"){
				returnStr += "1���ͻ������Ȱ������������ſ��԰������޳���" + "|";
				returnStr += "2���ͻ�����ҵ������Ч��" + "|";
				returnStr += "3���ͻ�ȡ��ҵ��������Ч��" + "|";
				returnStr += "4���������޳���ķ��������޳��������˵ĳе���" + "|";
				returnStr += "5���齨��ȡ�����޳���ҵ������г�Ա��������ҵ���Żݡ�" + "|";
			}else if(opCode == "e880"){
				returnStr += "1���ƶ��ֻ������˶����޳����ײͺ��Դ����𽫲����������޳���ҵ���Ż��ʷѡ�" + "|";
				returnStr += "2���齨��ȡ�����޳���ҵ����������޳���ҵ���������Żݡ�" + "|";
			}else if(opCode == "e881") {
				returnStr += "" + "|";
			}
			
			return returnStr;
		}
		function goBack(){
			location="fe280.jsp?activePhone=<%=operPhoneNo%>";
		}
		function deleteMember(rownum,checkObj){
			/* ����Ҫ���ù���У�麯�� */
			
			
			var selectedMembRoleId = $("#memberRoleId_" + rownum).val();
			var addFlag = 0;
			if($(checkObj).attr("checked") == undefined){
				addFlag = 1;
			}else{
				addFlag = -1;
			}
			setSelectedNum(selectedMembRoleId,addFlag);
			ctrlfamilyMemberList();
			ctrlConfirmBtn();
		}
		
		function ctrlfamilyMemberList(){
			/* ��ĳ����Ա������������ڽ�ɫ��С��ʱ��ɾ��ѡ���û� */
			var resule0Obj = $("input[id^='memRoleId_']");
			$.each(resule0Obj,function(i,n){
				//var unselectedNum = getunselectedMemNum(n.value);
				//var rownum = n.id.substr(10,11);
				//$("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)").html();
				/*��ȡ���õļ�ͥ��Ա������Сֵ*/
				var membMinNum = $("#familyRoleTab tr:eq("+(i + 1)+") td:eq(2)").html().trim();
				/* ��ȡ��ͥ��Ա���� */
				var membNum = $("#familyRoleTab tr:eq("+(i + 1)+") td:eq(3)").html().trim();
				if(membMinNum == membNum){
					setDisableByMembId(n.value,0);
				}else{
					setDisableByMembId(n.value,1);
				}
			});
		}
		function ctrlConfirmBtn(){
			var checkObj = $("input[name='delMember']");
			/* ���ñ�ʶ false������    true���� */
			var availableFlag = false;
			$.each(checkObj,function(i,n){
				if($(n).attr("checked") != undefined){
					availableFlag = true;
				}
			});
			if(availableFlag){
				$("#confirm").removeAttr("disabled");
			}else{
				$("#confirm").attr("disabled","true");
			}
		}
		function getunselectedMemNum(memberRoleId){
			/* ����memberRoleId��ȡû��ѡ�еĳ�Ա����������ͥ�д��ڳ�Ա���� */
			var returnNum = 0;
			var memberListObj = $("input[id^='memberRoleId_'][value='" + memberRoleId + "']");
			$.each(memberListObj,function(i,n){
				var rownum = n.name.substr(13,14);
				var delmemberStr = "#delMember_" + rownum;
				if($(delmemberStr).attr("checked") == undefined){
					returnNum++;
				}
			});
			return returnNum;
		}
		function setDisableByMembId(memberRoleId , styleFlag){
			/* ����memberRoleId��δѡ�����óɿ��ò�����
					styleFlag 1 ����   0 ������
			*/
			var delMemberObj = $("input[name='delMember'][value='" + memberRoleId + "']");
			$.each(delMemberObj,function(i,n){
				if($(n).attr("checked") == undefined){
					if(styleFlag == "0"){
						$(n).attr("disabled","true");
					}else if(styleFlag == "1"){
						$(n).removeAttr("disabled");
					}
				}
			});
		}
		function setSelectedNum(memberRoleId,addFlag){
			/* ����memberRoleId �������������
					addFlag  1 ��1	-1  ��1
			 */
			/* ��ȡ�����к� */
			var resule0Obj = $("input[id^='memRoleId_']");
			var rowNum = 0;
			$.each(resule0Obj,function(i,n){
				if(n.value == memberRoleId){
					rowNum = n.id.substr(10,11);
					var tdObj = $("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)");
					var nowNum = tdObj.html();
					var resultNum = parseInt(nowNum) + parseInt(addFlag);
					tdObj.html("" + resultNum);
				}
			});
		}
		function setJSONText(){
			
			familyRoleList = new FamRoleList();
			
			familyRoleList.setCreate_accept("<%=printAccept%>");
			familyRoleList.setBack_accept("<%=backAccept%>");
			familyRoleList.setChnsource("01");
			familyRoleList.setopCode("<%=opCode%>");
			familyRoleList.setLoginNo("<%=work_no%>");
			familyRoleList.setPassword("<%=password%>");
			familyRoleList.setPhone_no_master("<%=parentPhone%>")
			familyRoleList.setOp_note("<%=work_no%>" + "��" + "<%=opName%>" + "����");
			familyRoleList.setProd_code($("#familyProdInfo").val());
			familyRoleList.setFamily_code("<%=familyCode%>");
			
			var checkObj = $("input[name='delMember']");
			var famRole = new FamRole();
			var business = new Business();
			var rowNum = "";
			$.each(checkObj,function(i,n){
				if($(n).attr("checked") != undefined){
					rowNum = n.id.substr(10,11);
					var memberRoleIdVal = $("#memberRoleId_"+rowNum).val();
					var phoneNoVal = $("#phoneNo_"+rowNum).val();
					var familyRoleVal = $("#familyRole_"+rowNum).val();
					var memberRoleNameVal = $("#memberRoleName_"+rowNum).val();
					var payTypeVal = $("#payType_"+rowNum).val();
					
					if(!strInArr(phoneNoVal,hideArr)){
						famRole = new FamRole();
						famRole.setPhone(phoneNoVal);
						famRole.setRoleId(familyRoleVal);
						famRole.setRoleName(memberRoleNameVal);
						famRole.setMembId(memberRoleIdVal);
						famRole.setPay_type(payTypeVal);
						/* ��������Ҫƴ��business���� */
						famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
						
						familyRoleList.addFamRole(famRole);
					}
				}
			});
			familyRoleList.setPay_money($("#prepayFeeHide").val());
			var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});
			//alert(myJSONText);
			$("#myJSONText").val(myJSONText);
		}
		
		function createBusiness(famRole,phoneNo,memberRoleId,familyRole,payType){
			var business = new Business();
			for(var i = 0; i < famBusiArray.length; i++){
				if("<%=opCode%>" == "e283" && i == (famBusiArray.length-1)) {
					$("#minorOfferName").val(famBusiArray[i][9]);
					$("#minorOfferComment").val(famBusiArray[i][10]);
				}
				if(famBusiArray[i][3] == phoneNo){
					business = new Business();
					business.setBusitype(famBusiArray[i][6]);
					business.setBusinessId(famBusiArray[i][5]);
					business.setOper("07");
					if("<%=opCode%>" == "e284" && famBusiArray[i][0] == "70001"){
						$("#prepayFeeHide").val($("#machFee").val());
						business.setMach_fee($("#machFee").val());
					}
					/*liujian add*/
				
					
					/*liujian ע�ͽ���*/
					if("<%=opCode%>" == "e285" && memberRoleId == "70001"){
						/* ��ѯһ��Ԥ��������ʱ��ӡ��Ʊ�� */
						var msgPacket = new AJAXPacket("getPrepayFee.jsp","���ڻ�ȡ���ݣ����Ժ�......");
						msgPacket.data.add("phoneNo","<%=operPhoneNo%>");
						msgPacket.data.add("opCode","<%=opCode%>");
						msgPacket.data.add("backAccept","<%=backAccept%>");
						msgPacket.data.add("famCode",familyRole);
						msgPacket.data.add("memRoleId",memberRoleId);
						core.ajax.sendPacket(msgPacket, doSetPrepayfee);
					}
					famRole.addBusiness(business);
				}
			}
			return famRole;
		}
		function doSetPrepayfee(packet){
			var retcode = packet.data.findValueByName("retcode");
			var prepayFee = packet.data.findValueByName("prepayFee");
			$("#homeEasyHide").val("1");
			$("#prepayFeeHide").val(prepayFee);
		}
		function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			var offerName = packet.data.findValueByName("offerName"); //ָ���ʷ�����
			var offerComment = packet.data.findValueByName("offerComment"); //ָ���ʷ�����
			
			$("#smName").val(smName);
			$("#custName").val(custName);
			/*liujian  ע�Ϳ�ʼ*/
			/*
			if("<%=opCode%>" != "e283"){
				$("#mainOfferComment").val(offerComment);
			}*/
			/*liujian  ע�ͽ���*/
		}
		function getFamBusiMsg(){
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","���ڻ�ȡ���ݣ����Ժ�......");
			msgPacket.data.add("phoneNo","<%=parentPhone%>");
			msgPacket.data.add("opCode","<%=opCode%>");
			msgPacket.data.add("prodCode","<%=prodCode%>");
			msgPacket.data.add("memRoleId","<%=parentMembRoleId%>");
			msgPacket.data.add("queryType","5");
			msgPacket.data.add("famCode","<%=familyCode%>");
			msgPacket.data.add("outNum","11");
			core.ajax.sendPacket(msgPacket, doFamBusiMsgBack);
		}
		function doFamBusiMsgBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode != "000000"){
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫҵ����Ϣ" + retCode + retMsg);
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			}else{
				famBusiArray = result;
			}
		}
		function setLastTDHide(){
			/* ������һ�� */
			$("#familyMemberList tr").each(function(){
				$(this).find("th:eq(6)").hide();
				$(this).find("td:eq(6)").hide();
			});
			var checkObj = $("input[name='delMember']");
			$.each(checkObj,function(i,n){
				$(n).attr("checked","true");
			});
			$("#confirm").removeAttr("disabled");
		}
		$(document).ready(function(){
			
			var prodCode = "<%=prodCode%>";
			$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
			$("#familyProdInfo").attr("disabled","true")
			
			ctrlfamilyMemberList();
			getFamBusiMsg();
			var opCodeVal = "<%=opCode%>";
			if(opCodeVal == "e284"){
				setLastTDHide();
				$("#machFeeTab").show();
			}
			if(opCodeVal == "e875" || opCodeVal == "e880" || opCodeVal == "e881"){
				setLastTDHide();
			}
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","<%=operPhoneNo%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			
			//liuijan add �Ѿ��Ƴ��ĳ�Ա�������ٴα�ѡ��
			$('.delete_memeber_70004_1').attr("disabled","true");
			setExpMemberHide();
		});
		
		function setExpMemberHide(){
			/***��ʧЧʱ�䲻���ڼҳ�ʧЧʱ��ĳ�Ա�ʷѴ��롢�ʷ���������*/
			var parentExpDate = "";
			var parentRowNum = 0;
			$.each($("input[id^='familyRole_']"),function(i,n){
				if($(this).val() == "M"){
					parentRowNum = i;
				}
			});
			parentExpDate = $("#expDate_"+parentRowNum).text();
			$.each($("#familyMemberList tr:gt(0)"),function(i,n){
				if($(this).find("td:eq(5)").text() != parentExpDate){
					$(this).find("td:gt(6)").empty();
					hideArr[hideArr.length] = $(this).find("td:eq(2)").text();
				}
			});
		}
		
		function strInArr(str,arr){
			var inFlag = false;
			$.each(arr,function(i,n){
				if(str == n){
					inFlag = true;
				}
			});
			return inFlag;
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ͥ��Ʒ���</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">��ͥ��Ʒ��Ϣ</td>
			<td>
				<select id="familyProdInfo" name="familyProdInfo" onchange="changeProd()">
					<option value ="">--��ѡ��--</option>
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
						<wtc:sql>
							SELECT prod_code, prod_name
							  FROM sfamilyprodinfo
							 WHERE family_code = '?' AND GROUP_ID = '?'
						</wtc:sql>
						<wtc:param value="<%=familyCode%>"/>
						<wtc:param value="<%=belongGroupId%>"/>
					</wtc:qoption>
				</select>
			</td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi">��ͥ���г�Ա�б�</div>
	</div>
	<table cellspacing="0" id="familyRoleTab">
		<tr>
			<th>��ɫ����</th>
			<th>��ɫ�������</th>
			<th>��ɫ��С����</th>
			<th>���������</th>
			<th>���ѷ�ʽ</th>
		</tr>
		<%
			for(int i = 0; i < result0.length; i++){
		%>
		<tr>
			<input type="hidden" id="memRoleId_<%=i%>" value="<%=result0[i][0]%>" />
			<td><%=result0[i][2]%></td>
			<td><%=result0[i][3]%></td>
			<td><%=result0[i][4]%></td>
			<td>
				<%=result0[i][6]%>
			</td>
			<td><%=result0[i][5]%></td>
		</tr>
		<%
			}
		%>
	</table>
	<div class="title">
		<div id="title_zi">��ͥ���г�Ա�б�</div>
	</div>
	<table id="familyMemberList">
		<tr>
			<th>��ͥ����</th>
			<th>��ͥ����</th>
			<th>�ֻ�����</th>
			<th>��ɫ����</th>
			<th>��Чʱ��</th>
			<th>ʧЧʱ��</th>
			<th>����</th>
			<th><%=tableTitleStr%></th>
		</tr>
		<%
			for(int i = 0; i < familyMemberList.length; i++){
				if(selfFlag || familyMemberList[i][3].equals(operPhoneNo)){
		%>
		<tr id="row_0">
			<input type="hidden" name="memberRoleId_<%=i%>" id="memberRoleId_<%=i%>" value="<%=familyMemberList[i][0]%>"/>
			<input type="hidden" name="phoneNo_<%=i%>" id="phoneNo_<%=i%>" value="<%=familyMemberList[i][3]%>"/>
			<input type="hidden" id="familyRole_<%=i%>" name="familyRole_<%=i%>" value="<%=familyMemberList[i][1]%>" />
			<input type="hidden" id="memberRoleName_<%=i%>" name="memberRoleName_<%=i%>" value="<%=familyMemberList[i][2]%>" />
			<input type="hidden" id="payType_<%=i%>" name="payType_<%=i%>" value="<%=familyMemberList[i][6]%>" />
			<td width="10%"><%=familyCode%></td>
			<td><%=familyName%></td>
			<td><%=familyMemberList[i][3]%></td>
			<td><%=familyMemberList[i][2]%></td>
			<td><%=familyMemberList[i][4]%></td>
			<td><span id="expDate_<%=i%>"><%=familyMemberList[i][5]%></span></td>
			<td>
				<input type="checkbox" name="delMember" id="delMember_<%=i%>" class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
				  onclick="deleteMember(<%=i%>,this)" value="<%=familyMemberList[i][0]%>" />
			</td>
			<td>
				<input type="checkbox" checked="checked" disabled />
				<span id="memberRoleOfferId_<%=i%>"><%=familyMemberList[i][12]%><span>
					-
				<%=familyMemberList[i][13]%>
				<input type="hidden" value="<%=familyMemberList[i][14]%>" />
			</td>
		</tr>
		<%
				}
			}
		%>
	</table>
	<table id="machFeeTab" style="display:none;">
		<tr>
			<td class="blue" width="10%">���տ�</td>
			<td>
				<input type="text" id="machFee" name="machFee" v_type="money" v_must="1" />
				<font class="orange">*</font>
			</td>
		</tr>
	</table>
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<input type="hidden" id="myJSONText" name="myJSONText" />
	<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
	<input type="hidden" id="parentPhone" name="parentPhone" value="<%=parentPhone%>" />
	<input type="hidden" id="parentCustName" name="parentCustName" value="<%=parentCustName%>" />
	<input type="hidden" id="operPhoneNo" name="operPhoneNo" value="<%=operPhoneNo%>" />
	<input type="hidden" name="checkFlag" id="checkFlag" />
	<input type="hidden" name="custName" id="custName" />
	<input type="hidden" name="homeEasyHide" id="homeEasyHide" value="0" />
	<input type="hidden" name="brandAndResHide" id="brandAndResHide" />
	<input type="hidden" name="homeEasyPhoneHide" id="homeEasyPhoneHide" />
	<input type="hidden" name="imeiHide" id="imeiHide" />
	<input type="hidden" name="prepayFeeHide" id="prepayFeeHide" />
	<input type="hidden" name="reqContextPath" id="reqContextPath" value="<%=request.getContextPath()%>" />
	<input type="hidden" name="mainOfferComment" id="mainOfferComment" value="<%=mainOfferComments%>" />
	<input type="hidden" name="minorOfferComment" id="minorOfferComment" value="" />
	<input type="hidden" name="familyName" id="familyName" value="<%=familyName%>" />
	<input type="hidden" name="smName" id="smName" />
	<input type="hidden" name="printName" id="printName" value="<%=printName%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" name="mainOfferName" id="mainOfferName" value="<%=mainOfferName%>" />
	<input type="hidden" name="minorOfferName" id="minorOfferName" value="" />
	<input type="hidden" name="pubPrtOfferId" id="pubPrtOfferId" value="" />
	<input type="hidden" name="pubPrtOfferName" id="pubPrtOfferName" value="" />
	<input type="hidden" name="pubPrtOfferComments" id="pubPrtOfferComments" value="" />
	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="ȷ��" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="���" />
			&nbsp; 
			<input name="reset" type="button" class="b_foot" value="����" onclick="goBack()" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>
