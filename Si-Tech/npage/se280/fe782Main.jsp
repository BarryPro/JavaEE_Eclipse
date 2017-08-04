<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
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

 			printName = "成员加入短信验证";
 			
 		
 		%>
 		<script>
 			//alert("<%=opCode%>");
 			//alert("<%=familyCode%>");
 			//alert("<%=familyName%>");
 	</script>
 		<%
 		/* 免密码权限，后期权限收回时，还需要修改 */
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
		System.out.println("----- fe280Main.jsp ---- 查询出错" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code0%>" + "<%=msg0%>");
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			</script>
<%
	}
	
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	if(opCode.equals("g782")){
		/* 成员加入 需要调用服务查询家庭已有成员信息 */
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
						if("e281".equals(opCode) || "g782".equals(opCode)){/*查询成员资费--仅限亲情畅聊3元和5元两种资费*/
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
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			</script>
<%
		}
	}
%>
<html>
<head>
	<title>家庭产品变更</title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe280PubScript.js"></script>
	<script language="javascript">
		var kdchongfuqj=0;
		var familyRoleList = new FamRoleList();
		var memberPhoneList = new Array(); //成员角色
		var quitphoneArray = new Array();
		var KDflag="0";
		var miantiandankuandai="";
		function nextStep(subButton){
			/* 按钮延迟 */
			$(subButton).attr("disabled","true");
			/* 事后提醒 */
			
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
			/* 获取配置的角色顺序 */
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
		
			/* 家庭产品信息 */
			/* 根据家庭产品，角色，获得增加此角色所需业务操作。
					主资费变更、可选资费变更、营销案、SP业务  组合。
			*/
			var famProdInfoObj = $("#familyProdInfo");
			if(famProdInfoObj.val() == ""){
				rdShowMessageDialog("请选择家庭产品");
				return false;
			}
			/* 家庭角色 */
			var famRoleObj = $("#familyrole_" + rowNum);
			var famRoleNameObj = $("#familyroleName_" + rowNum);
			var famMembObj = $("#memRoleId_" + rowNum);
			var famPryTypeObj = $("#payType_"+rowNum);
			/* 角色标识 */
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
        if($(this).val()!=""||$(this).val()!=null){//主资费
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
			$('#chenynames').html("成员手机号码");
			var obj = document.getElementById("phoneNo"); 
			obj.setAttribute("readOnly",false); 
			}
			<%}%>
	
			$("#busiAcceptContent").show();
		}
		function addRoleToSelected(){		

			/* 校验 */
				if(!checkElement(document.all.phoneNo)){
					return false;
				}

			var phoneNoVal = $("#phoneNo").val().trim();
			/* 判断此手机号码是否已经在js中增加 */
			if(checkPhoneInList(phoneNoVal)){
				rdShowMessageDialog("您已经添加过此号码");
				clearBusiContent();
				ctrlFamRoleTab();
				return false;
			}
			/* 添加角色到已选区域 */
			/* new一个新的角色，为角色属性赋值，手机号码、角色代码、角色名称 */
			/* 为角色增加业务(目前只写了资费变更类) */
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
			/* 判断手机号码是否在list中 */
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
			/* 为已选角色对象区增加角色 */
			familyRoleList.addFamRole(famRole);
			
			var insertHtmlStr = "";
			insertHtmlStr += "<tr><td>";
			insertHtmlStr += famRole.getPhone();
			insertHtmlStr += "</td><td>";
			insertHtmlStr += famRole.getRoleName();
			insertHtmlStr += "</td><td><input type=\"button\" value='删除' name='delRole' class='b_text' onclick='delRoleFromList(this)' /></td></tr>";
			$("#selectedRoleListTb").append(insertHtmlStr);
		}
		function delRoleFromList(obj){
			var trObj = $(obj).parents("tr");
			var phoneNo = trObj.find("td").html();
			/* 从javascript对象中删除临时数据 */
			var famRoleObj;
			for(var i = 0; i < familyRoleList.getLength(); i++){
				famRoleObj = familyRoleList.getFamRole(i);
				if(phoneNo == famRoleObj.getPhone()){
					/* 针对宜居通特殊对待，删除保存的固话信息 */
					if(famRoleObj.getMembId() == "70001"){
						$("#homeEasyHide").val("0");
						$("#brandAndResHide").val("");
						$("#imeiHide").val("");
						$("#prepayFeeHide").val("");
					}
					/* 家长，还得删除资费 */
					if(famRoleObj.getRoleId() == "M"){
						$("#mainOfferComment").val("");
						$("#minorOfferComment").val("");
						$("#mainOfferName").val("");
						$("#minorOfferName").val("");
					}
					familyRoleList.deleteFamRole(i);
				}
			}
			/* 从列表中删除号码 */
			$(obj).parents("tr").remove();
			ctrlFamRoleTab();
			clearBusiContent();
		}
		function createBusiness(famRoleObj){
			/* 为成员拼接业务 */
			/* 根据已有的业务，分别拼接 */
			if($("#signAOFlag").val() == "1"){
				/* 拼接上可选资费AO */
				famRoleObj = createAO(famRoleObj);
			}
			if($("#signMOFlag").val() == "1"){
				/* 拼接上主资费MO */
				famRoleObj = createMO(famRoleObj);
			}

			if($("#signMarketFlag").val() == "1"){
				/* 拼接上营销案 */
				famRoleObj = createMarket(famRoleObj);
			}
			if($("#signHomeEasyFlag").val() == "1"){
				/* 拼接上宜居通SP业务 由于SP业务几乎都不同所以只能分开写 */
				famRoleObj = createHomeEasy(famRoleObj);
			}
			if($("#signKinshipFlag").val() == "1"){
				/* 拼接上亲情通SP业务 */
				famRoleObj = createKinShip(famRoleObj);
			}
			if($("#signKDFlag").val() == "1"){
				/* 拼接上宽带业务 */
				famRoleObj = createKD(famRoleObj);
			}
			
			return famRoleObj;
		}
		function createMO(famRoleObj){
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
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
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
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
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
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
			/*gaopeng 20121126 关于协助配置宜居通资费方案的函 start*/
			business.setActive_term($("#active_term").val());
			business.setBase_fee($("#base_fee").val());
			business.setFree_fee($("#free_fee").val());
			/*gaopeng 20121126 关于协助配置宜居通资费方案的函 end*/
			business.setOfferId($("#mainOffer").val());
			if(v_hiddenFlag=="Y"){
			  business.setAreaCode($("#newAttrIds").val());
			}else{
			  business.setAreaCode("");
			}
			famRoleObj.addBusiness(business);
			/* 营销案创建时，拼接上免填单和发票的信息 */
			$("#homeEasyHide").val("1");
			$("#brandAndResHide").val($("#brand  option:selected").text() + $("#res  option:selected").text());
			$("#imeiHide").val($("#IMEINo").val());
			$("#prepayFeeHide").val($("#prepayFee").val());
			return famRoleObj;
		}
		
		function ctrlAddBtn(flag){
			/* 控制家庭角色信息区一堆添加按钮，可用不可用 */
			if(flag == "d"){
				/* 置成disabled */
				$("input[name^='addRole']").attr("disabled","true");
			}else if(flag == "u"){
				/* 去掉disabled */
				$("input[name^='addRole']").removeAttr("disabled");
			}
		}
		function clearBusiContent(){
			/* 清空业务受理区 */
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
			/* 如果有校验提示信息，隐藏 */
			$.each($(":text"),function(i,n){
				hiddenTip(n);
			});
			/*begin 关于双鸭山分公司申请神州行本地家庭资费的请示 @2013/6/17*/
			var familsyinfo  = $("#familyProdInfo").val();
      var resule0Obj = $("input[id^='memRoleId_']");
      <%if(familyCode.equals("KDJT")) {%>	
        if(familsyinfo=="1020"||familsyinfo=="1021" ||familsyinfo=="1026" ||familsyinfo=="1027"){
          $.each(resule0Obj,function(i,n){
            	if($(this).val()=="70011"){//全球通家庭资费普通成员 添加按钮置灰 
            	  var butAddRole = "#addRole"+i;
            	  $(butAddRole).attr("disabled","true");
            	}
          });	
        }	
      <%}%>		
			/*end 关于双鸭山分公司申请神州行本地家庭资费的请示 @2013/6/17*/
		}
		function cancleAdd(){
			ctrlFamRoleTab();
			clearBusiContent();
		}
		function ctrlFamRoleTab(){
			/* 控制家庭角色信息部分 */
			/*需要控制已经添加数量，已添加数量应该大于等于角色最小数量，小于等于角色最大数量
			*当已添加数量等于角色最大数时，添加按钮置灰
			*当已添加数量小于角色最大数时，添加按钮可用
			*角色数量判断，应写单独函数，提交校验时也可用。
			*提交时会校验成员添加数量是否在规定范围内。
			*/
			var resule0Obj = $("input[id^='memRoleId_']");
			/* 控制确定按钮 1代表可以点击，0代表置灰不可点击 */
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
					/*不可以添加，按钮置灰*/
					if(i==0) {
					$(ctrlBtnStr).attr("disabled","true");
					}else {
					}
				}else if(ctrlFlag == "0"){
					/* 可以继续添加 */
					$(ctrlBtnStr).removeAttr("disabled");
				}else if(ctrlFlag == "-1"){
					/* 可以继续添加 */
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
			/* 	根据memberId判断已经选择成员数量与配置的家庭成员数量关系*/
			/* 	1 已添加成员等于最大值，即不可继续增加了 */
			/* 	0 已添加成员小于最大值大于等于最小值，即可以继续增加 */
			/* 	-1 已添加成员小于最小值，即必须继续增加 */
			/* 	获取已经选择的成员数量 */
			var resule0Obj = $("input[id^='memRoleId_']");
			var rowNum;
			$.each(resule0Obj,function(i,n){
				if(memberId == n.value){
					rowNum = i;
				}
			});			
			rowNum = rowNum + 1;
			/*	获取配置的家庭成员数量最大值*/
			var membMaxNum = $("#familyRoleTab tr:eq("+rowNum+") td:eq(1)").html();
			/*	获取配置的家庭成员数量最小值*/
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
			/* 	获取已经选择的成员数量 */
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
		/*begin 关于双鸭山分公司申请神州行本地家庭资费的请示 @2013/6/17*/
		function changeProd1(){
		  changeProd();
      var familsyinfo  = $("#familyProdInfo").find("option:selected").val();
      var resule0Obj = $("input[id^='memRoleId_']");
      alert(familsyinfo);
      <%if(familyCode.equals("KDJT")) {%>	
        if(familsyinfo=="1020"||familsyinfo=="1021" ||familsyinfo=="1026" || familsyinfo=="1027"){
          $.each(resule0Obj,function(i,n){
            	if($(this).val()=="70011"){//全球通家庭资费普通成员 添加按钮置灰 
            	  alert();
            	  var butAddRole = "#addRole"+i;
            	  $(butAddRole).attr("disabled","true");
            	}
          });	
        }	
      <%}%>		
		}
		/*end 关于双鸭山分公司申请神州行本地家庭资费的请示 @2013/6/17*/
		function changeProd(){
			familyRoleList = new FamRoleList();
			$("#selectedRoleListTb").html("");
			ctrlFamRoleTab();
			clearBusiContent();
			kdchongfuqj=0; 
		}
		function changeBrand(saleType){
			/* 重新输入imei码并且做校验*/
			$("#IMEINo").val("").removeAttr("readonly");
			var checkAndAddObj = $("#checkAndAdd");
			checkAndAddObj.attr("disabled","true");
			
			var brandVal = $("#brand").val();
			var getdataPacket = new AJAXPacket("getRes.jsp","请稍后...");
			getdataPacket.data.add("brand",brandVal);
			getdataPacket.data.add("saleType",saleType);
			core.ajax.sendPacketHtml(getdataPacket,doBrandHtml);
			getdataPacket =null;
			getPhoneSale(saleType);
			//changeMarketing(saleType);
			//liujian  主资费清空
			mainOfferArray = [];
		}
		/* 此处为固话型号下拉列表变更方法 ，用来加载营销案下拉列表*/
		function changeRes(saleType){
			/* 重新输入imei码并且做校验*/
			$("#IMEINo").val("").removeAttr("readonly");
			var checkAndAddObj = $("#checkAndAdd");
			checkAndAddObj.attr("disabled","true");
			getPhoneSale(saleType);
			changeMarketing(saleType);
		}
		/*此处为加载营销案下拉列表方法*/
		function getPhoneSale(saleType){
			var familyProdCode = $("#familyProdInfo").find("option:selected").val();
			var brandVal = $("#brand").val();
			var resVal = $("#res").val();
			var getdataPacket = new AJAXPacket("getPhoneSale.jsp","请稍后...");
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
			//liujian  主资费清空
			mainOfferArray = [];
			var getdataPacket = new AJAXPacket("getMainOffer.jsp","请稍后...");
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
		/* 此为--营销案改变方法*/
		function changeMarketing(saleType){
			var marketObj = $("#market");
			var prepayFee = marketObj.find("option[value='" + marketObj.val() + "']").attr("prepayfee")
			var consume = marketObj.find("option[value='" + marketObj.val() + "']").attr("consume");
			/*gaopeng 20121126 关于协助配置宜居通资费方案的函 start*/
			
			//20121219 判断是不是旧的家庭产品
			var familyProdCode = $("#familyProdInfo").find("option:selected").val();
			/*底线预存*/
			var base_fee="";
			if(familyProdCode=="1001" || familyProdCode=="1002" || familyProdCode=="1006" )
			{
				base_fee=prepayFee;
			}
			else if(familyProdCode=="1015" || familyProdCode=="1016"||familyProdCode=="1017" || familyProdCode=="1018"|| familyProdCode=="1019")
			{
			 	base_fee = marketObj.find("option[value='" + marketObj.val() + "']").attr("base_fee");
			}
			/*活动预存*/
			var free_fee = marketObj.find("option[value='" + marketObj.val() + "']").attr("free_fee");
			/*活动消费期限*/
			var active_term = marketObj.find("option[value='" + marketObj.val() + "']").attr("active_term");
			/*gaopeng 20121126 关于协助配置宜居通资费方案的函 end*/
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
			/* 设置样式 */
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
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","正在获得数据，请稍候......");
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
		  $("#chenynames").html("宽带账号");
		}
		function chginptype2() {
			document.all.phoneNo.maxLength=11;
			document.all.phoneNo.v_type="mobphone";
			$('#chenynames').html("成员手机号码");
			document.all.phoneNo.value="";
			var obj = document.getElementById("phoneNo"); 
			obj.setAttribute("readOnly",false); 
		}
		
		function changeMainOffer(obj,sum){//判断是否展示小区资费
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
		  var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","请稍后...");
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
      var hiddenFlag =  packet.data.findValueByName("hiddenFlag");//是否显示小区代码标识
      var offer_id =  packet.data.findValueByName("offerId");//资费代码
      var sum =  packet.data.findValueByName("sum");//小区资费展示形式标识
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
      if(v_hiddenFlag=="Y"){ //当为Y时，进入新版小区代码展示页面
        $("#sumFlay").val(sum);
        var packet1 = new AJAXPacket("getOfferAttrNew.jsp","请稍后...");
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
		<div id="title_zi">家庭产品变更</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">家庭产品信息</td>
			<td>
<%
			//		System.out.println("zhouby: " + familyCode + "  " + belongGroupId);
			String familyInfoSql = " SELECT prod_code, prod_name, sp_info " +
							  						 " FROM sfamilyprodinfo " +
							               " WHERE family_code = '" + familyCode + "' AND GROUP_ID = '" + belongGroupId + "'";
%>
				<select id="familyProdInfo" name="familyProdInfo" onchange="changeProd1()">
					<option value ="" sp_info="">--请选择--</option>
					
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
							//System.out.println("zhouby: 调用TlsPubSelCrm失败" );
					}
%>
				</select>
			</td>

		</tr>
					<%if(familyCode.equals("KDJT") && ("e281".equals(opCode) || "g782".equals(opCode))) {%>
			<tr id="kdjt" style="display:block">
        <td class="blue"  >宽带账号</td>
				<td >
					<input type="text" id="kuandai" name="kuandai" maxlength="20"  />

			</tr>
			<%}%>
			
	</table>
	<div class="title" id="famMembListContent" style="display:none;">
		<div id="title_zi">家庭现有成员列表</div>
	</div>
	<table id="familyMemberList" style="display:none;">
		<tr>
			<th>家庭代码</th>
			<th>家庭名称</th>
			<th>手机号码</th>
			<th>角色名称</th>
			<th>生效时间</th>
			<th>失效时间</th>
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
				//liujian g782需求变更，只要当前添加的号码
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
				<div id="title_zi">家庭角色信息</div>
			</div>	
			<table cellspacing="0" id="familyRoleTab">
				<tr>
					<th>角色名称</th>
					<th>角色最大数量</th>
					<th>角色最小数量</th>
					<th>已添加数量</th>
					<th>付费方式</th>
					<th>操作</th>
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
						 value="添加" class="b_text" onclick="addRole(<%=i%>)" />
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		
		<div class="item-row2 col-2">
			<div class="title" >
				<div id="title_zi">已选角色区</div>
			</div>	
			<table cellspacing="0" id="addRoleTab">
				<tr>
					<th width="25%">手机号码</th>
					<th>角色名称</th>
					<th>操作</th>
				</tr>
				<tbody id="selectedRoleListTb">
				</tbody>
			</table>
		</div>
	</div>
	<!-- 业务受理区 -->
	<div id="busiAcceptContent" style="display:none;"> 
		<div class="title" >
			<div id="title_zi">业务受理区</div>
		</div>	
		<table>
			<tr>
				<td class="blue" width="15%" id="chenynames">成员手机号码</td>
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
						<input type="button" class="b_foot_long" value="添加成员" 
						 onclick="addRoleToSelected()" id="checkAndAdd" name="checkAndAdd" />
						<input type="button" name="cancle" class="b_foot" value="取消" onclick="cancleAdd()" />
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 业务受理区 end -->
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
			 value="确认" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" onclick="changeProd1()" />
			&nbsp; 
			<input name="reset" type="button" class="b_foot" value="返回" onclick="goBack()" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>
