<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    //sale_type = 43
 		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		//String opCode="g782";
 		//String opName = request.getParameter("opName");
 		String familyCode = request.getParameter("familyCode");
 		String familyName = request.getParameter("familyName");
 		String belongGroupId = request.getParameter("belongGroupId");
 		String parentPhone = request.getParameter("parentPhone");
 		String regionCode= (String)session.getAttribute("regCode");
 		String work_no = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
 		System.out.println("----- fe280Main.jsp ----" + opCode + opName);
 		String printName = "";
 		 		String offerids="";
 		String offernames="";
 		String offercoments="";

 			printName = "��Ա���������֤";
 			
 		
 		%>
 		<script>
 			//alert("<%=opCode%>");
 			//alert("<%=familyCode%>");
 			//alert("<%=familyName%>");
 	</script>
 		<%
 		/* ������Ȩ�ޣ�����Ȩ���ջ�ʱ������Ҫ�޸� */
		String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr=new String[temfavStr.length];
		for(int i=0;i<favStr.length;i++){
			favStr[i]=temfavStr[i][0].trim();
		}
		boolean pwrf=false;
		if(WtcUtil.haveStr(favStr,"a272")){
			pwrf=true;
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
			<wtc:param value="<%=parentPhone%>"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
<%
	if(!code0.equals("000000")){
		System.out.println("----- fe280Main.jsp ---- ��ѯ����" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code0%>" + "<%=msg0%>");
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			</script>
<%
	}
	
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	if(opCode.equals("g782")){
		/* ��Ա���� ��Ҫ���÷����ѯ��ͥ���г�Ա��Ϣ */
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg1" retcode="code1" outnum="9">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=parentPhone%>"/>
			<wtc:param value=""/>
			<wtc:param value="3"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		System.out.println("========== ningtn ====" + code1 + " | " + result1.length);
		if("000000".equals(code1)){
			familyMemberList = result1;
			for(int i = 0; i < familyMemberList.length; i++){
				if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
				}
			}
						if("e281".equals(opCode) || "g782".equals(opCode)){/*��ѯ��Ա�ʷ�--�������鳩��3Ԫ��5Ԫ�����ʷ�*/
 			   if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			       String[] inParamsss3 = new String[2];
 			        inParamsss3[0]="SELECT a.offer_id, a.offer_name, a.offer_comments  FROM product_offer a, sfamilysaleoffer b WHERE A.OFFER_ID = B.OFFER_ID  AND B.FAMILY_CODE =:famlilycode  AND B.PROD_CODE =:prodcode";			
 			        inParamsss3[1] = "famlilycode="+familyCode.trim()+",prodcode="+prodCode.trim();
		%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="3">			
	<wtc:param value="<%=inParamsss3[0]%>"/>
	<wtc:param value="<%=inParamsss3[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust3" scope="end" />
 		<%
				 		if(retCode3ss.equals("000000")) {
				         if(dcust3.length>0) {
				           offerids=dcust3[0][0];
				 		       offernames=dcust3[0][1];
				 		       offercoments=dcust3[0][2];
				         }
				    }
 			  }
 			}
		}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			</script>
<%
		}
	}
%>
<html>
<head>
	<title>��ͥ��Ʒ���</title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe280PubScript.js"></script>
	<script language="javascript">
		var kdchongfuqj=0;
		var familyRoleList = new FamRoleList();
		var memberPhoneList = new Array(); //��Ա��ɫ
		var quitphoneArray = new Array();
		var KDflag="0";
		var miantiandankuandai="";
		function nextStep(subButton){
			/* ��ť�ӳ� */
			$(subButton).attr("disabled","true");
			/* �º����� */
			
			getAfterPrompt();		
				var famRoleObj;
				var phoneStr="";
				var menmberids="";
				var prodcodes=$("#familyProdInfo").val();
				var masterphones="<%=parentPhone%>";
			for(var i = 0; i < familyRoleList.length; i++){
				famRoleObj = familyRoleList.getFamRole(i);
						phoneStr+=famRoleObj.getPhone()+"#";
						menmberids=famRoleObj.getMembId();
				
			}
	
$("#phonenostrs").val(phoneStr);
$("#menmberidss").val(menmberids);
$("#prodcodess").val(prodcodes);

				document.form1.action = "fe782Cfm.jsp";
				document.form1.submit(); 

		}
		
		
		
		function goBack(){
			location="fe280.jsp?activePhone=<%=parentPhone%>";
		}
		function changeObjSeq(familyRoleList){
			/* ��ȡ���õĽ�ɫ˳�� */
			var familyroleListObj = $("input[id^='memRoleId_']");
			var familyRoleListSmt = new FamRoleList();
			var temp;
			var loopFlag = true;
			$.each(familyroleListObj,function(i,n){
				loopFlag = true;
				while(loopFlag){
					temp = getObjByFamilyrole(n.value);
					if(temp != false){
						familyRoleListSmt.addFamRole(temp);
						loopFlag = true;
					}else{
						loopFlag = false;
					}
				}
			});
			return familyRoleListSmt;
		}
		function getObjByFamilyrole(familyRoleId){
			var famRole;
			for(var i = 0; i < familyRoleList.getLength(); i++){
				if(familyRoleList.getFamRole(i).getMembId() == familyRoleId){
					famRole = familyRoleList.getFamRole(i);
					familyRoleList.deleteFamRole(i);
					return famRole;
				}
			}
			return false;
		}
	

		function addRole(rowNum){
		
			/* ��ͥ��Ʒ��Ϣ */
			/* ���ݼ�ͥ��Ʒ����ɫ��������Ӵ˽�ɫ����ҵ�������
					���ʷѱ������ѡ�ʷѱ����Ӫ������SPҵ��  ��ϡ�
			*/
			var famProdInfoObj = $("#familyProdInfo");
			if(famProdInfoObj.val() == ""){
				rdShowMessageDialog("��ѡ���ͥ��Ʒ");
				return false;
			}
			/* ��ͥ��ɫ */
			var famRoleObj = $("#familyrole_" + rowNum);
			var famRoleNameObj = $("#familyroleName_" + rowNum);
			var famMembObj = $("#memRoleId_" + rowNum);
			var famPryTypeObj = $("#payType_"+rowNum);
			/* ��ɫ��ʶ */
			var memRoleIdObj = $("#memRoleId_" + rowNum);
			$("#operRoleId").val(famRoleObj.val());
			$("#operRoleName").val(famRoleNameObj.val());
			$("#operMemberId").val(famMembObj.val());
			$("#operPayType").val(famPryTypeObj.val());
			
			$("#busiAcceptContent").show();
		}
	

		function doGetHtml(data){
			$("#busiAccept").append(data);
      $.each($("input[id^='complex_MO']:checked"),function(i,n){
        if($(this).val()!=""||$(this).val()!=null){//���ʷ�
            changeMainOffer($(this).val(),"2");
        }
      });
			var operMemberId = $('#operMemberId').val();
			<%if(familyCode.equals("KDJT") && ("e281".equals(opCode) || "g782".equals(opCode))) {%>		
			if(operMemberId=="70012") {
			chginptype1();
			}else if(operMemberId=="70011"){
			chginptype2();
			}
			else if(operMemberId=="70010"){
			chginptype2();
			}else {
			document.all.phoneNo.maxLength=11;
			document.all.phoneNo.v_type="mobphone";
			$('#chenynames').html("��Ա�ֻ�����");
			var obj = document.getElementById("phoneNo"); 
			obj.setAttribute("readOnly",false); 
			}
			<%}%>
	
			$("#busiAcceptContent").show();
		}
		function addRoleToSelected(){		

			/* У�� */
				if(!checkElement(document.all.phoneNo)){
					return false;
				}

			var phoneNoVal = $("#phoneNo").val().trim();
			/* �жϴ��ֻ������Ƿ��Ѿ���js������ */
			if(checkPhoneInList(phoneNoVal)){
				rdShowMessageDialog("���Ѿ���ӹ��˺���");
				clearBusiContent();
				ctrlFamRoleTab();
				return false;
			}
			/* ��ӽ�ɫ����ѡ���� */
			/* newһ���µĽ�ɫ��Ϊ��ɫ���Ը�ֵ���ֻ����롢��ɫ���롢��ɫ���� */
			/* Ϊ��ɫ����ҵ��(Ŀǰֻд���ʷѱ����) */
			var famRole = new FamRole();

			famRole.setPhone(phoneNoVal);
			famRole.setRoleId($("#operRoleId").val());
			famRole.setRoleName($("#operRoleName").val());
			famRole.setMembId($("#operMemberId").val());
			famRole.setPay_type($("#operPayType").val());
			var tempOperMemberId = $("#operMemberId").val();
			//alert(tempOperMemberId);
			famRole = createBusiness(famRole);
			addSelectedList(famRole);
			ctrlFamRoleTab();
			clearBusiContent();
			
		}
		

		function checkPhoneInList(phoneNo){
			/* �ж��ֻ������Ƿ���list�� */
			var famRoleObj;
			for(var i = 0; i < familyRoleList.length; i++){
				famRoleObj = familyRoleList.getFamRole(i);
				if(phoneNo == famRoleObj.getPhone()){
					return true;
				}
			}
			return false;
		}
		function addSelectedList(famRole){
			/* Ϊ��ѡ��ɫ���������ӽ�ɫ */
			familyRoleList.addFamRole(famRole);
			
			var insertHtmlStr = "";
			insertHtmlStr += "<tr><td>";
			insertHtmlStr += famRole.getPhone();
			insertHtmlStr += "</td><td>";
			insertHtmlStr += famRole.getRoleName();
			insertHtmlStr += "</td><td><input type=\"button\" value='ɾ��' name='delRole' class='b_text' onclick='delRoleFromList(this)' /></td></tr>";
			$("#selectedRoleListTb").append(insertHtmlStr);
		}
		function delRoleFromList(obj){
			var trObj = $(obj).parents("tr");
			var phoneNo = trObj.find("td").html();
			/* ��javascript������ɾ����ʱ���� */
			var famRoleObj;
			for(var i = 0; i < familyRoleList.getLength(); i++){
				famRoleObj = familyRoleList.getFamRole(i);
				if(phoneNo == famRoleObj.getPhone()){
					/* ����˾�ͨ����Դ���ɾ������Ĺ̻���Ϣ */
					if(famRoleObj.getMembId() == "70001"){
						$("#homeEasyHide").val("0");
						$("#brandAndResHide").val("");
						$("#imeiHide").val("");
						$("#prepayFeeHide").val("");
					}
					/* �ҳ�������ɾ���ʷ� */
					if(famRoleObj.getRoleId() == "M"){
						$("#mainOfferComment").val("");
						$("#minorOfferComment").val("");
						$("#mainOfferName").val("");
						$("#minorOfferName").val("");
					}
					familyRoleList.deleteFamRole(i);
				}
			}
			/* ���б���ɾ������ */
			$(obj).parents("tr").remove();
			ctrlFamRoleTab();
			clearBusiContent();
		}
		function createBusiness(famRoleObj){
			/* Ϊ��Աƴ��ҵ�� */
			/* �������е�ҵ�񣬷ֱ�ƴ�� */
			if($("#signAOFlag").val() == "1"){
				/* ƴ���Ͽ�ѡ�ʷ�AO */
				famRoleObj = createAO(famRoleObj);
			}
			if($("#signMOFlag").val() == "1"){
				/* ƴ�������ʷ�MO */
				famRoleObj = createMO(famRoleObj);
			}

			if($("#signMarketFlag").val() == "1"){
				/* ƴ����Ӫ���� */
				famRoleObj = createMarket(famRoleObj);
			}
			if($("#signHomeEasyFlag").val() == "1"){
				/* ƴ�����˾�ͨSPҵ�� ����SPҵ�񼸺�����ͬ����ֻ�ֿܷ�д */
				famRoleObj = createHomeEasy(famRoleObj);
			}
			if($("#signKinshipFlag").val() == "1"){
				/* ƴ��������ͨSPҵ�� */
				famRoleObj = createKinShip(famRoleObj);
			}
			if($("#signKDFlag").val() == "1"){
				/* ƴ���Ͽ��ҵ�� */
				famRoleObj = createKD(famRoleObj);
			}
			
			return famRoleObj;
		}
		function createMO(famRoleObj){
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
			*/
				
			$.each($("input[id^='complex_MO']:checked"),function(i,n){
				var offerIdVal = n.value;
				var business = new Business();
				var businessIdStr = "#complex_busiid_MO_" + i;
				var businessId = $(businessIdStr).val();
				var offerComment = $("#offerComment_MO_" + i).val();
				var offerName = $("#offerName_MO_" + i).val();
				var actionFlag = $("#action_MO_" + i).val();
				<%if(familyCode.equals("KDJT")) {%>
				var memRoleIdsss = $("#memssRoleId_MO_" + i).val();
				if(actionFlag == "pubFamMainOffer" || actionFlag == "pubFamMainOfferBB" ){
					if(memRoleIdsss=='70009') {
					$("#mainOfferComment").val(offerComment);
					$("#mainOfferName").val(offerName);
					}else {
					}
				}
				
			
				else {
					$("#minorOfferComment").val(offerComment);
					$("#minorOfferName").val(offerName);
				}
				
				
			<%}else {%>	
				if(actionFlag == "pubCreateFam"){
					$("#mainOfferComment").val(offerComment);
					$("#mainOfferName").val(offerName);
				}else{
					$("#minorOfferComment").val(offerComment);
					$("#minorOfferName").val(offerName);
				}
				<%}%>
				business.setBusinessId(businessId);
				business.setBusitype("MO");
				business.setOfferId(offerIdVal);
				<%if(familyCode.equals("KDJT")) {%>
				  //business.setAreaCode("");
				<%}%>	
				if(v_hiddenFlag=="Y"){
				  business.setAreaCode($("#newAttrIds").val());
				}else{
				  business.setAreaCode("");
				}
				famRoleObj.addBusiness(business);
			});
			return famRoleObj;
		}
		function createAO(famRoleObj){
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
			*/
			var checkseles ="";
			$.each($("input[id^='complex_AO']:checked"),function(i,n){
				var offerIdVal = n.value;
				var businessIdStr = "#complex_busiid_AO_" + i;
				var businessId = $(businessIdStr).val();
				var business = new Business();
				business.setBusinessId(businessId);
				business.setBusitype("AO");
				business.setOfferId(offerIdVal);
				<%if(familyCode.equals("KDJT")) {%>
				business.setAreaCode("");
				<%}%>	
				
					
				famRoleObj.addBusiness(business);
				var offerComment = $("#offerComment_AO_" + i).val();
				var offerName = $("#offerName_AO_" + i).val();
				var actionFlag = $("#action_AO_" + i).val();
				
						<%if(familyCode.equals("KDJT")) {%>

				var memRoleIdsss = $("#memssRoleId_AO_" + i).val(); 
				if(actionFlag == "pubFamAddOfferBB" || actionFlag == "pubFamMemAdd" || actionFlag == "pubFamAddOffer"){
				if(memRoleIdsss=='70011') {
				if(actionFlag == "pubFamAddOfferBB") {
					if(checkseles =="") {
					$("#chengyuanzifeimiaoshu11").val(offerComment);
					$("#chengyuanzifei11").val(offerName);
					}
					if(checkseles !="") {
					$("#chengyuanzifeimiaoshu22").val(offerComment);
					$("#chengyuanzifei22").val(offerName);
					}
						checkseles =businessIdStr;
				 }
				 if( actionFlag == "pubFamMemAdd" ) {
					$("#chengyuanzifeimiaoshu11").val(offerComment);
					$("#chengyuanzifei11").val(offerName);
				 }
				if( actionFlag == "pubFamAddOffer" ) {
					$("#chengyuanzifeimiaoshu22").val(offerComment);
					$("#chengyuanzifei22").val(offerName);
				 }	
				}else {
				
				}
				
				}
				
			
				else {
					$("#minorOfferComment").val(offerComment);
					$("#minorOfferName").val(offerName);
				}
				
				
			<%}else {%>	
				if(actionFlag == "pubCreateFam"){
					$("#mainOfferComment").val(offerComment);
					$("#mainOfferName").val(offerName);
					$("#offeridss").val(offerIdVal);
				}else{
					$("#minorOfferComment").val(offerComment);
					$("#minorOfferName").val(offerName);
					$("#offeridss").val(offerIdVal);
				}
				<%}%>
				

			});
			return famRoleObj;
		}
				function createKD(famRoleObj){
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
			*/
			$.each($("input[id^='complex_KD']:checked"),function(i,n){
				var offerIdVal = n.value;
						 
				var businessIdStr = "#complex_busiid_KD_" + i;
				var businessId = $(businessIdStr).val();
				var business = new Business();
				business.setBusinessId(businessId);
				business.setBusitype("KD");
				business.setOfferId(offerIdVal);
				<%if(familyCode.equals("KDJT")) {%>
				business.setAreaCode("");
				<%}%>
				famRoleObj.addBusiness(business);
				var offerComment = $("#offerComment_KD_" + i).val();
				var offerName = $("#offerName_KD_" + i).val();
				var actionFlag = $("#action_KD_" + i).val();
				if(actionFlag == "pubCreateFam"){
					$("#mainOfferComment").val(offerComment);
					$("#mainOfferName").val(offerName);
					$("#offeridss").val(offerIdVal);
				}else{
					$("#minorOfferComment").val(offerComment);
					$("#minorOfferName").val(offerName);
					$("#offeridss").val(offerIdVal);
				}
			});
			return famRoleObj;
		}
		function createHomeEasy(famRoleObj){
			var business = new Business();
			business.setBusinessId($("#homeEasyBusiId").val());
			business.setBusitype("SP");
			business.setOper("06");
			famRoleObj.addBusiness(business);
			return famRoleObj;
		}
		function createKinShip(famRoleObj){
			var business = new Business();
			business.setBusinessId($("#kinShipBusiId").val());
			business.setBusitype("SP");
			business.setOper("06");
			business.setOfferId($("#propOfferId").val().trim());
			business.setBeginTime($("#kinShipBeginTime").val().trim());
			business.setEndTime($("#kinShipEndTime").val().trim());
			business.setPropName($("#propName").val().trim());
			business.setPropSex($("input[name='propSex']:checked").val().trim());
			business.setPropBirthday($("#propBirthday").val().trim());
			business.setPropCardNo($("#prodCardNo").val().trim());
			business.setPropDistrict($("#propDistrict").val().trim());
			business.setPropAddress($("#propAddress").val().trim());
			business.setPropTelephone($("#propTelephone").val().trim());
			business.setUserAccounts($("#userAccounts").val().trim());
			business.setPropCommunity($("#propCommunity").val().trim());
			famRoleObj.addBusiness(business);
			return famRoleObj;
		}
		function createMarket(famRoleObj){
			var business = new Business();
			business.setBusitype("YX");
			business.setBusinessId($("#marketingBusiId").val());
			business.setOper("06");
			business.setSale_type($("#marketSaleType").val());
			var sale_flag ;
			if($("#saleFlag").attr("checked")){
				sale_flag = "1";
			}else{
				sale_flag = "0";
			}
			business.setSale_flag(sale_flag);
			business.setSale_code($("#market").val());
			business.setImei($("#IMEINo").val());
			business.setBrand_name($("#brand").val());
			business.setRes_name($("#res").val());
			business.setPrepay_fee($("#prepayFee").val());
			business.setConsume_term($("#consumeTerm").val());
			/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� start*/
			business.setActive_term($("#active_term").val());
			business.setBase_fee($("#base_fee").val());
			business.setFree_fee($("#free_fee").val());
			/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� end*/
			business.setOfferId($("#mainOffer").val());
			if(v_hiddenFlag=="Y"){
			  business.setAreaCode($("#newAttrIds").val());
			}else{
			  business.setAreaCode("");
			}
			famRoleObj.addBusiness(business);
			/* Ӫ��������ʱ��ƴ��������ͷ�Ʊ����Ϣ */
			$("#homeEasyHide").val("1");
			$("#brandAndResHide").val($("#brand  option:selected").text() + $("#res  option:selected").text());
			$("#imeiHide").val($("#IMEINo").val());
			$("#prepayFeeHide").val($("#prepayFee").val());
			return famRoleObj;
		}
		
		function ctrlAddBtn(flag){
			/* ���Ƽ�ͥ��ɫ��Ϣ��һ����Ӱ�ť�����ò����� */
			if(flag == "d"){
				/* �ó�disabled */
				$("input[name^='addRole']").attr("disabled","true");
			}else if(flag == "u"){
				/* ȥ��disabled */
				$("input[name^='addRole']").removeAttr("disabled");
			}
		}
		function clearBusiContent(){
			/* ���ҵ�������� */
			$("#phoneNo").val("");
			$("#phoneNo").removeAttr("readonly");
			$("#pwdContent").show();
			$("input[name='phonePwd']").val("");
			$("#operRoleId").val("");
			$("#operRoleName").val("");
			$("#operMemberId").val("");
			$("#operPayType").val("");
			$("#busiAccept").html("");
			$("#busiAcceptContent").hide();
			$("input[name^='sign']").val("0");
			$("#checkAndAdd").removeAttr("disabled");
			/* �����У����ʾ��Ϣ������ */
			$.each($(":text"),function(i,n){
				hiddenTip(n);
			});
			/*begin ����˫Ѽɽ�ֹ�˾���������б��ؼ�ͥ�ʷѵ���ʾ @2013/6/17*/
			var familsyinfo  = $("#familyProdInfo").val();
      var resule0Obj = $("input[id^='memRoleId_']");
      <%if(familyCode.equals("KDJT")) {%>	
        if(familsyinfo=="1020"||familsyinfo=="1021" ||familsyinfo=="1026" ||familsyinfo=="1027"){
          $.each(resule0Obj,function(i,n){
            	if($(this).val()=="70011"){//ȫ��ͨ��ͥ�ʷ���ͨ��Ա ��Ӱ�ť�û� 
            	  var butAddRole = "#addRole"+i;
            	  $(butAddRole).attr("disabled","true");
            	}
          });	
        }	
      <%}%>		
			/*end ����˫Ѽɽ�ֹ�˾���������б��ؼ�ͥ�ʷѵ���ʾ @2013/6/17*/
		}
		function cancleAdd(){
			ctrlFamRoleTab();
			clearBusiContent();
		}
		function ctrlFamRoleTab(){
			/* ���Ƽ�ͥ��ɫ��Ϣ���� */
			/*��Ҫ�����Ѿ�������������������Ӧ�ô��ڵ��ڽ�ɫ��С������С�ڵ��ڽ�ɫ�������
			*��������������ڽ�ɫ�����ʱ����Ӱ�ť�û�
			*�����������С�ڽ�ɫ�����ʱ����Ӱ�ť����
			*��ɫ�����жϣ�Ӧд�����������ύУ��ʱҲ���á�
			*�ύʱ��У���Ա��������Ƿ��ڹ涨��Χ�ڡ�
			*/
			var resule0Obj = $("input[id^='memRoleId_']");
			/* ����ȷ����ť 1������Ե����0�����ûҲ��ɵ�� */
			var confirmBtnStr = "1";
			var confirmBtnObj = $("#confirm");
			$.each(resule0Obj,function(i,n){
				var ctrlBtnStr = "#addRole" + i;
				var selectedMemNum = getSelectedMembNum(n.value)
				var addedMemberNum = 0;
				var selectedMemStr = "#selectedMem_"+i;
				addedMemberNum = parseInt($(selectedMemStr).val()) + parseInt(selectedMemNum);
				$("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)").html("" + addedMemberNum);
				var ctrlFlag = checkMemberNo(n.value,addedMemberNum);
				if(ctrlFlag == "1"){
					/*��������ӣ���ť�û�*/
					if(i==0) {
					$(ctrlBtnStr).attr("disabled","true");
					}else {
					}
				}else if(ctrlFlag == "0"){
					/* ���Լ������ */
					$(ctrlBtnStr).removeAttr("disabled");
				}else if(ctrlFlag == "-1"){
					/* ���Լ������ */
					$(ctrlBtnStr).removeAttr("disabled");
					confirmBtnStr = "0";
				}
			});	
			if(confirmBtnStr == "1" && familyRoleList.getLength() != "0"){
				confirmBtnObj.removeAttr("disabled");
			}else {
				confirmBtnObj.attr("disabled","true");
			}
		}
	

		function checkMemberNo(memberId,selectedMemNum){
			/* 	����memberId�ж��Ѿ�ѡ���Ա���������õļ�ͥ��Ա������ϵ*/
			/* 	1 ����ӳ�Ա�������ֵ�������ɼ��������� */
			/* 	0 ����ӳ�ԱС�����ֵ���ڵ�����Сֵ�������Լ������� */
			/* 	-1 ����ӳ�ԱС����Сֵ��������������� */
			/* 	��ȡ�Ѿ�ѡ��ĳ�Ա���� */
			var resule0Obj = $("input[id^='memRoleId_']");
			var rowNum;
			$.each(resule0Obj,function(i,n){
				if(memberId == n.value){
					rowNum = i;
				}
			});			
			rowNum = rowNum + 1;
			/*	��ȡ���õļ�ͥ��Ա�������ֵ*/
			var membMaxNum = $("#familyRoleTab tr:eq("+rowNum+") td:eq(1)").html();
			/*	��ȡ���õļ�ͥ��Ա������Сֵ*/
			var membMinNum = $("#familyRoleTab tr:eq("+rowNum+") td:eq(2)").html();
			if(selectedMemNum >= membMaxNum){
				return 1;
			}
			if(selectedMemNum < membMaxNum && selectedMemNum >= membMinNum){
				return 0;
			}
			if(selectedMemNum < membMinNum){
				return -1;
			}
		}
		function getSelectedMembNum(memberId){
			/* 	��ȡ�Ѿ�ѡ��ĳ�Ա���� */
			var selectedMemNum = 0;
			var famRoleObj;
			for (var i = 0; i < familyRoleList.getLength(); i++){
				famRoleObj = familyRoleList.getFamRole(i);
				if(memberId == famRoleObj.getMembId()){
					selectedMemNum++;
				}
			}
			return selectedMemNum;
		}
		/*begin ����˫Ѽɽ�ֹ�˾���������б��ؼ�ͥ�ʷѵ���ʾ @2013/6/17*/
		function changeProd1(){
		  changeProd();
      var familsyinfo  = $("#familyProdInfo").find("option:selected").val();
      var resule0Obj = $("input[id^='memRoleId_']");
      alert(familsyinfo);
      <%if(familyCode.equals("KDJT")) {%>	
        if(familsyinfo=="1020"||familsyinfo=="1021" ||familsyinfo=="1026" || familsyinfo=="1027"){
          $.each(resule0Obj,function(i,n){
            	if($(this).val()=="70011"){//ȫ��ͨ��ͥ�ʷ���ͨ��Ա ��Ӱ�ť�û� 
            	  alert();
            	  var butAddRole = "#addRole"+i;
            	  $(butAddRole).attr("disabled","true");
            	}
          });	
        }	
      <%}%>		
		}
		/*end ����˫Ѽɽ�ֹ�˾���������б��ؼ�ͥ�ʷѵ���ʾ @2013/6/17*/
		function changeProd(){
			familyRoleList = new FamRoleList();
			$("#selectedRoleListTb").html("");
			ctrlFamRoleTab();
			clearBusiContent();
			kdchongfuqj=0; 
		}
		function changeBrand(saleType){
			/* ��������imei�벢����У��*/
			$("#IMEINo").val("").removeAttr("readonly");
			var checkAndAddObj = $("#checkAndAdd");
			checkAndAddObj.attr("disabled","true");
			
			var brandVal = $("#brand").val();
			var getdataPacket = new AJAXPacket("getRes.jsp","���Ժ�...");
			getdataPacket.data.add("brand",brandVal);
			getdataPacket.data.add("saleType",saleType);
			core.ajax.sendPacketHtml(getdataPacket,doBrandHtml);
			getdataPacket =null;
			getPhoneSale(saleType);
			//changeMarketing(saleType);
			//liujian  ���ʷ����
			mainOfferArray = [];
		}
		/* �˴�Ϊ�̻��ͺ������б������� ����������Ӫ���������б�*/
		function changeRes(saleType){
			/* ��������imei�벢����У��*/
			$("#IMEINo").val("").removeAttr("readonly");
			var checkAndAddObj = $("#checkAndAdd");
			checkAndAddObj.attr("disabled","true");
			getPhoneSale(saleType);
			changeMarketing(saleType);
		}
		/*�˴�Ϊ����Ӫ���������б���*/
		function getPhoneSale(saleType){
			var familyProdCode = $("#familyProdInfo").find("option:selected").val();
			var brandVal = $("#brand").val();
			var resVal = $("#res").val();
			var getdataPacket = new AJAXPacket("getPhoneSale.jsp","���Ժ�...");
			getdataPacket.data.add("brandCode",brandVal);
			getdataPacket.data.add("typeCode",resVal);
			getdataPacket.data.add("saleType",saleType);
			getdataPacket.data.add("familyProdCode",familyProdCode);
			core.ajax.sendPacketHtml(getdataPacket,doSaleHtml);
			getdataPacket =null;
		}
		function doSaleHtml(data){
			$("#market").html(data);
		}
		function getMainOffer(saleCode,saleType){
			//liujian  ���ʷ����
			mainOfferArray = [];
			var getdataPacket = new AJAXPacket("getMainOffer.jsp","���Ժ�...");
		//	getdataPacket.data.add("saleCode",saleCode);
		//	getdataPacket.data.add("saleType",saleType);
		//	alert('prodCode=' + $('#familyProdInfo').val());
			
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",$('#familyProdInfo').val());
			
			core.ajax.sendPacketHtml(getdataPacket,doMainOfferHtml);
			getdataPacket =null;
		}
		function doMainOfferHtml(data){
			$("#mainOffer").html(data);
		}
		/* ��Ϊ--Ӫ�����ı䷽��*/
		function changeMarketing(saleType){
			var marketObj = $("#market");
			var prepayFee = marketObj.find("option[value='" + marketObj.val() + "']").attr("prepayfee")
			var consume = marketObj.find("option[value='" + marketObj.val() + "']").attr("consume");
			/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� start*/
			
			//20121219 �ж��ǲ��Ǿɵļ�ͥ��Ʒ
			var familyProdCode = $("#familyProdInfo").find("option:selected").val();
			/*����Ԥ��*/
			var base_fee="";
			if(familyProdCode=="1001" || familyProdCode=="1002" || familyProdCode=="1006" )
			{
				base_fee=prepayFee;
			}
			else if(familyProdCode=="1015" || familyProdCode=="1016"||familyProdCode=="1017" || familyProdCode=="1018"|| familyProdCode=="1019")
			{
			 	base_fee = marketObj.find("option[value='" + marketObj.val() + "']").attr("base_fee");
			}
			/*�Ԥ��*/
			var free_fee = marketObj.find("option[value='" + marketObj.val() + "']").attr("free_fee");
			/*���������*/
			var active_term = marketObj.find("option[value='" + marketObj.val() + "']").attr("active_term");
			/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� end*/
			var saleCode = marketObj.val();
			getMainOffer(saleCode,saleType);
			if(typeof(prepayFee) == "undefined"){
				prepayFee = "";
			}
			if(typeof(consume) == "undefined"){
				consume = "";
			}
			if(typeof(base_fee) == "undefined"){
				base_fee = "";
			}
			if(typeof(free_fee) == "undefined"){
				free_fee = "";
			}
			if(typeof(active_term) == "undefined"){
				active_term = "";
			}
			$("#prepayFee").val(prepayFee);
			$("#consumeTerm").val(consume);
			$("#base_fee").val(base_fee);
			$("#free_fee").val(free_fee);
			$("#active_term").val(active_term);
			
		}
		function doBrandHtml(data){
			$("#res").html(data);
		}
		function getAccount(){
			var accountObj = $("#userAccounts");
			if(accountObj.val().trim() == ""){
				accountObj.val($("#phoneNo").val());
			}
		}

		function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			$("#custName").val(custName);
			$("#smName").val(smName);
			$("#parentCustName").val(custName);
		}
		$(document).ready(function(){
			/* ������ʽ */
			if("<%=opCode%>" == "g782"){
				$("#familyMemberList").show();
				$("#famMembListContent").show();
				var prodCode = "<%=prodCode%>";
				$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
				$("#familyProdInfo").attr("disabled","true")
			}
			<%if(familyCode.equals("KDJT") && ("e281".equals(opCode) || "g782".equals(opCode))) {%>
				 var familsyinfo  = $("#familyProdInfo").val();
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014") {
		     		$("#kdjt").show();
		     		}
			<%}%>
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			ctrlFamRoleTab();
			
			var familsyinfo  = $("#familyProdInfo").val();
      var resule0Obj = $("input[id^='memRoleId_']");
			<%if(familyCode.equals("KDJT") && "g782".equals(opCode)) {%>
			  if(familsyinfo=="1020"||familsyinfo=="1021" ||familsyinfo=="1026" ||familsyinfo=="1027"){
          $.each(resule0Obj,function(i,n){
            var butAddRole = "#addRole"+i;
            $(butAddRole).attr("disabled","true");
        });	
			  }
			<%}%>
		});
		
		function chginptype1() {
			document.all.phoneNo.maxLength=20;
			document.all.phoneNo.v_type="";
		  $("#chenynames").html("����˺�");
		}
		function chginptype2() {
			document.all.phoneNo.maxLength=11;
			document.all.phoneNo.v_type="mobphone";
			$('#chenynames').html("��Ա�ֻ�����");
			document.all.phoneNo.value="";
			var obj = document.getElementById("phoneNo"); 
			obj.setAttribute("readOnly",false); 
		}
		
		function changeMainOffer(obj,sum){//�ж��Ƿ�չʾС���ʷ�
		  var offerId = "";
		  if(sum=="1"){
        offerId = obj.value;
        if(offerId==""){
		      $("#OfferAttribute").html("");
		      $("#marketingTd").attr("rowSpan",5);
		    }
		  }else{
		    offerId = obj;
		  }
		  var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","���Ժ�...");
      packet.data.add("offerId",offerId);
      packet.data.add("sum",sum);
      packet.data.add("phoneNo","");
      packet.data.add("opCode","<%=opCode%>");
      core.ajax.sendPacket(packet,doJdugeAreaHidden);
      packet =null;	

		}
		
		var v_hiddenFlag = "";
    var v_code = new Array();
    var v_text = new Array();
    function doJdugeAreaHidden(packet){
      var retCode = packet.data.findValueByName("retCode");
      var retMsg =  packet.data.findValueByName("retMsg");
      var code =  packet.data.findValueByName("code");
      var text =  packet.data.findValueByName("text");
      var hiddenFlag =  packet.data.findValueByName("hiddenFlag");//�Ƿ���ʾС�������ʶ
      var offer_id =  packet.data.findValueByName("offerId");//�ʷѴ���
      var sum =  packet.data.findValueByName("sum");//С���ʷ�չʾ��ʽ��ʶ
      if(retCode == "000000"){
        v_hiddenFlag = hiddenFlag;
        if(code.length>0&&text.length>0){
          for(var i=0;i<code.length;i++){
            v_code[i] = code[i];
            v_text[i] = text[i];
          }
        }
        getOfferAttr(offer_id,sum);
    	}else{
    		rdShowMessageDialog(retCode + ":" + retMsg,0);
    		//getOfferAttr();
        $("#checkAndAdd").attr("disabled","true");
    		return false;
    	}
    }
    
    function getOfferAttr(offer_id,sum){
      if(v_hiddenFlag=="Y"){ //��ΪYʱ�������°�С������չʾҳ��
        $("#sumFlay").val(sum);
        var packet1 = new AJAXPacket("getOfferAttrNew.jsp","���Ժ�...");
        packet1.data.add("v_code" ,v_code);
        packet1.data.add("v_text" ,v_text);
        packet1.data.add("OfferId" ,offer_id);
        core.ajax.sendPacketHtml(packet1,doGetOfferAttr);
        packet1 =null;
      }
    }
    
    function doGetOfferAttr(data){
      $("#marketingTd").attr("rowSpan",6);
      $("#OfferAttribute").html("");
      if($("#sumFlay").val()=="1"){
        $("#OfferAttribute").append(data);
      }else{
        $("#OfferAttribute2").append(data);
      }
    }
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
		<%@ include file="/npage/common/pwd_comm.jsp" %>
	<div class="title">
		<div id="title_zi">��ͥ��Ʒ���</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">��ͥ��Ʒ��Ϣ</td>
			<td>
<%
			//		System.out.println("zhouby: " + familyCode + "  " + belongGroupId);
			String familyInfoSql = " SELECT prod_code, prod_name, sp_info " +
							  						 " FROM sfamilyprodinfo " +
							               " WHERE family_code = '" + familyCode + "' AND GROUP_ID = '" + belongGroupId + "'";
%>
				<select id="familyProdInfo" name="familyProdInfo" onchange="changeProd1()">
					<option value ="" sp_info="">--��ѡ��--</option>
					
					<wtc:service name="TlsPubSelCrm" retcode="familyInfoCode" retmsg="familyInfoMsg" outnum="3" >
						  <wtc:param value="<%=familyInfoSql%>"/>
					</wtc:service>
					<wtc:array id="sfamilyInfo" scope="end"/>
<%
					if ("000000".equals(familyInfoCode)){
							if (sfamilyInfo.length > 0){
									for(int i = 0; i < sfamilyInfo.length; i++ ){
									  	out.write("<option value='" + sfamilyInfo[i][0] + "' sp_info='" + sfamilyInfo[i][2] +"' >" + sfamilyInfo[i][1] + "</option>");
									}
							}
					} else {
							//System.out.println("zhouby: ����TlsPubSelCrmʧ��" );
					}
%>
				</select>
			</td>

		</tr>
					<%if(familyCode.equals("KDJT") && ("e281".equals(opCode) || "g782".equals(opCode))) {%>
			<tr id="kdjt" style="display:block">
        <td class="blue"  >����˺�</td>
				<td >
					<input type="text" id="kuandai" name="kuandai" maxlength="20"  />

			</tr>
			<%}%>
			
	</table>
	<div class="title" id="famMembListContent" style="display:none;">
		<div id="title_zi">��ͥ���г�Ա�б�</div>
	</div>
	<table id="familyMemberList" style="display:none;">
		<tr>
			<th>��ͥ����</th>
			<th>��ͥ����</th>
			<th>�ֻ�����</th>
			<th>��ɫ����</th>
			<th>��Чʱ��</th>
			<th>ʧЧʱ��</th>
		</tr>
		<%
						String squittype="";
		  int sint=0;
			if("g782".equals(opCode)){
				for(int i = 0; i < familyMemberList.length; i++){
					System.out.println("---------------liujian---------------familyMemberList=" + familyMemberList.length);
					if(familyMemberList[i][0].equals("70012")) {
				%>
							<script language="javascript">
						//alert("<%=squittype%>")							
						quitphoneArray["<%=sint%>"]="<%=familyMemberList[i][3]%>";
							</script>
							
					<%	
	         sint++;
					}
		%>
		<tr id="row_0">
			<input type="hidden" name="memberRoleId_<%=i%>" id="memberRoleId_<%=i%>" value="<%=familyMemberList[i][0]%>"/>
			<input type="hidden" name="phoneNo_<%=i%>" id="phoneNo_<%=i%>" value="<%=familyMemberList[i][3]%>"/>
			<input type="hidden" id="showfamilyRole_<%=i%>" name="showfamilyRole_<%=i%>" value="<%=familyMemberList[i][1]%>" />
			<input type="hidden" id="memberRoleName_<%=i%>" name="memberRoleName_<%=i%>" value="<%=familyMemberList[i][2]%>" />
			<input type="hidden" id="showpayType_<%=i%>" name="showpayType_<%=i%>" value="<%=familyMemberList[i][6]%>" />
			<script>
				/*
				//liujian g782��������ֻҪ��ǰ��ӵĺ���
				var memeberRoleId = "<%=familyMemberList[i][0]%>";
				if(memeberRoleId == '70002' || memeberRoleId == '70004') {
					memberPhoneList.push("<%=familyMemberList[i][3]%>");
				}
				*/
			</script>
			<td><%=familyCode%></td>
			<td><%=familyName%></td>
			<td><%=familyMemberList[i][3]%></td>
			<td><%=familyMemberList[i][2]%></td>
			<td><%=familyMemberList[i][4]%></td>
			<td><%=familyMemberList[i][5]%></td>
		</tr>
		<%
				}
			}
		%>
	</table>
	<div id="items">
		<div class="item-col2 col-1">
			<div class="title" >
				<div id="title_zi">��ͥ��ɫ��Ϣ</div>
			</div>	
			<table cellspacing="0" id="familyRoleTab">
				<tr>
					<th>��ɫ����</th>
					<th>��ɫ�������</th>
					<th>��ɫ��С����</th>
					<th>���������</th>
					<th>���ѷ�ʽ</th>
					<th>����</th>
				</tr>
				<%
				for(int i = 0; i < result0.length; i++){
				%>
				<tr>
					<input type="hidden" id="rolerow_<%=i%>" value="<%=i%>" />
					<input type="hidden" id="familyrole_<%=i%>" value="<%=result0[i][1]%>" />
					<input type="hidden" id="familyroleName_<%=i%>" value="<%=result0[i][2]%>" />
					<input type="hidden" id="memRoleId_<%=i%>" value="<%=result0[i][0]%>" />
					<input type="hidden" id="payType_<%=i%>" value="<%=result0[i][5]%>" />
					<input type="hidden" id="selectedMem_<%=i%>" value="<%=result0[i][6]%>" />
					<td><%=result0[i][2]%></td>
					<td><%=result0[i][3]%></td>
					<td><%=result0[i][4]%></td>
					<td>
						<%=result0[i][6]%>
					</td>
					<td><%=result0[i][5]%></td>
					<td>
						<input type="button" name="addRole<%=i%>" id="addRole<%=i%>" 
						 value="���" class="b_text" onclick="addRole(<%=i%>)" />
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		
		<div class="item-row2 col-2">
			<div class="title" >
				<div id="title_zi">��ѡ��ɫ��</div>
			</div>	
			<table cellspacing="0" id="addRoleTab">
				<tr>
					<th width="25%">�ֻ�����</th>
					<th>��ɫ����</th>
					<th>����</th>
				</tr>
				<tbody id="selectedRoleListTb">
				</tbody>
			</table>
		</div>
	</div>
	<!-- ҵ�������� -->
	<div id="busiAcceptContent" style="display:none;"> 
		<div class="title" >
			<div id="title_zi">ҵ��������</div>
		</div>	
		<table>
			<tr>
				<td class="blue" width="15%" id="chenynames">��Ա�ֻ�����</td>
				<td colspan="4">
					<input type="text" id="phoneNo" name="phoneNo" maxlength="11" v_type="mobphone" v_must="1" />
					<font class="orange">*</font>
					<input type="hidden" id="operRoleId" name="operRoleId" />
					<input type="hidden" id="operRoleName" name="operRoleName" />
					<input type="hidden" id="operMemberId" name="operMemberId" />
					<input type="hidden" id="operPayType" name="operPayType" />
				</td>

			</tr>
			<tbody id="busiAccept">
			</tbody>
			<tr>
				<td colspan="5">
					<div align="center"> 
						<input type="button" class="b_foot_long" value="��ӳ�Ա" 
						 onclick="addRoleToSelected()" id="checkAndAdd" name="checkAndAdd" />
						<input type="button" name="cancle" class="b_foot" value="ȡ��" onclick="cancleAdd()" />
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- ҵ�������� end -->
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<input type="hidden" id="menmberidss" name="menmberidss" value="" />
	<input type="hidden" id="parentPhone" name="parentPhone" value="<%=parentPhone%>" />
	<input type="hidden" id="phonenostrs" name="phonenostrs" value="" />
	<input type="hidden" id="prodcodess" name="prodcodess" value="" />
	<input type="hidden" id="familyCodes" name="familyCodes" value="<%=familyCode%>" />


	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="ȷ��" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="���" onclick="changeProd1()" />
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
