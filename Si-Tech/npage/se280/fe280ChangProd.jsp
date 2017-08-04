<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
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
 		String offerids="";
 		String offernames="";
 		String offercoments="";
 		String printName2 = "变更资费套餐";
 		String v_case = "2";
 		if("e855".equals(opCode)){ //产品变更
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){
 				v_case = "9";
 			}
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
	 			printName2 = "和家庭-爱家套餐变更";
 			}else if(familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 				printName2 = "和家庭-融合套餐变更";
 			}else if(familyCode.equals("ZHJT")){
 				printName2 = "和家庭-魔百和融合套餐变更";
 			}
 		}
    if("e283".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "申请退出亲情畅组";
 			}
 		  else {
 		  printName = "幸福家庭成员业务退订";
 		  }
 		}else if("e284".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组取消";
 			}
 			else {
 		  printName = "幸福家庭业务退订";
 		  }
 		}else if("e285".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组冲正";
 			}
 			else {
 		  printName = "变更资费套餐";
 		  }
 		}
 		%>
 		<script>
 			/*alert("<%=opCode%>");
 			alert("<%=familyCode%>");
 			alert("<%=familyName%>");
 			alert("<%=printName%>");
 			*/
 	</script>
 		<%
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
			<wtc:param value="<%=v_case%>"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
<%
	if(!code0.equals("000000")){
		System.out.println("----- fe280Quir.jsp ---- 查询出错" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code0%>" + "<%=msg0%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
	}
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	String parentPhone ="";
	String parentCustName = "";
	String parentMembRoleId = "";
	String v_membRoleId = "";//宽带成员号码
	boolean selfFlag = true;
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg1" retcode="code1" outnum="12">
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
		if("000000".equals(code1)){
			familyMemberList = result1;
			for(int i = 0; i < familyMemberList.length; i++){
				if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
					parentPhone = familyMemberList[i][3];
					parentCustName = familyMemberList[i][9];
					parentMembRoleId = familyMemberList[i][0];
				}else{
					if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode) || "ZHJT".equals(familyCode)) && "e855".equals(opCode)){
						if("70025".equals(familyMemberList[i][0]) || "70028".equals(familyMemberList[i][0]) || "70031".equals(familyMemberList[i][0]) || "70034".equals(familyMemberList[i][0])){ //宽带成员
							v_membRoleId = familyMemberList[i][3];
						}
					}
				}
			}
	
					if("e281".equals(opCode) || "e282".equals(opCode)){
 			       String[] inParamsss3 = new String[2];
 			        inParamsss3[0]="select a.offer_id,b.offer_name,b.offer_comments	from product_offer_instance a, product_offer b,dcustmsg c	where	a.offer_id = b.offer_id and a.serv_id=c.id_no	and sysdate between a.eff_date and a.exp_date	and b.offer_type = '10' and c.phone_no=:phone_nos";			
 			        inParamsss3[1] = "phone_nos="+operPhoneNo;
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
 			  
 			
			if(parentPhone.equals(operPhoneNo)){
				selfFlag = true;
			}else{
				selfFlag = false;
			}
		}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
		}
%>

<%
		/*20121122 gaopeng 新增服务 家庭产品变更功能查询服务 
		/************************************************************************
			*** 服务名称：sFamProdUpChk
			*** 编码时间：2012/11/21
			*** 编码人员：shiyong
			*** 功能描述：家庭产品变更功能查询服务
			*** 
			*** 输入参数：
			***          0   流水             iLoginAccept           
			***          1   渠道标识         iChnSource           
			***          2   操作代码         iOpCode          
			***          3   工号             iLoginNo           
			***          4   工号密码         iLoginPwd           
			***          5   家长号码         iPhoneNo  
			***          6   号码密码         iUserPwd       
			***          7   查询类型         iQryType   0：用于在产品变更页面向下拉菜单传值
			***          8   家庭编码         iFamCode   例 'XFJT'
			***          9   产品代码         iProdCode  例 1001 代表的是30元套餐 	
			*** 出参：
			***			 		 0	 产品总数		
			*** 	   		 1   产品代码         vProdCode	例 1001,1002	
			***			 		 2	 产品名称		 			vProdName*/	
%>

<wtc:service name="sFamProdUpChk" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode12" retmsg="errMsg12" outnum="4">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=operPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="0"/>
		<wtc:param value="<%=familyCode%>"/>
		<wtc:param value="<%=prodCode%>"/>
</wtc:service>
	<wtc:array id="result12" start="0" length="1" scope="end" />
	<wtc:array id="result23" start="1" length="3" scope="end" />
<%
	
	if(errCode12.equals("0")||errCode12.equals("000000")){
		System.out.println("调用服务sFamProdUpChk in fe280ChangProd.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");

	}else{
		System.out.println("调用服务sFamProdUpChk in fe280ChangProd.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode12%>，错误信息：<%=errMsg12%>");
	</script>
<%
	}		
%>	



<html>
<head>
	<title>家庭产品变更</title>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe280PubScript.js"></script>
	<script language="javascript">
		
		var familyRoleList = new FamRoleList();
	//	var famOffer = new FamOffer();
		var famBusiArray = new Array();
		var famBusiArray2 = new Array();
		var quitphoneArray = new Array();
		function nextStep(subButton){

			/* 按钮延迟 */
			controlButt(subButton);
			/* 事后提醒 */
			getAfterPrompt();
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e855"){//和家庭，产品变更
				var selChgval = $("select[name='selChg']").find("option:selected").val();
				if(selChgval == ""){
					rdShowMessageDialog("请选择变更的产品！");
					return false;
				}
			}
			
			/* 拼装报文 */
			setJSONText();
			/* 拼装报文 */
			/* 打印免填单&提交页面 */
			printCommit11('<%=opCode%>');

		}
		
		function printCommit11(opCode){
			var ret = showPrtDlg11(opCode,"确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('确认电子免填单吗？')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('确认要提交信息吗？')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
					frmCfm();
				}
			}
			return true;
		}
		function frmCfm(){
			showLightBox();
			form1.action="fe280Cfm.jsp";
			form1.submit();
		}
		function showPrtDlg11(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept =$("#printAccept").val();       //流水号
			var printStr = printInfo11(opcode);			 		//调用printinfo()返回的打印内容
			var mode_code=null;           							  //资费代码
			var fav_code=null;                				 		//特服代码
			var area_code=null;             				 		  //小区代码
			var opCode=$("#opCode").val();                   	//操作代码
			var phoneNo = $("#parentPhone").val();         //客户电话
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = $("#reqContextPath").val() + "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage ;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opCode+"&sysAccept="+sysAccept+
				"&phoneNo="+phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}
		function printInfo11(opcode){
			/*liujian  区别各个角色的成员Id*/
			var parent_member_Id = '70001'; //宜居通家长
			var normal_member_Id = '70002'; //普通成员
			var other_member_Id ="";  //其他成员
		<%
 			if(familyCode.equals("QQSY") ) {
 		%>
 		  other_member_Id ="70006";
 		<%			
 		  }	  		
 			if(familyCode.equals("QQWY")) {
 		%>
			other_member_Id ="70008";
		<%}%>
			var offerName = ''; //指定资费名称
			var offerComment = '';//指定资费描述
			var normalMemberStr = getPhoneNoByMemberId("70002");
			var otherMemberStr = getPhoneNoByMemberId("70004");
			var mainOfferNameVal = $("#mainOfferName").val(); //系统资费名称
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //系统资费描述
			var minorOfferNameVal = $("#minorOfferName").val(); //其他成员资费名称
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//其他成员资费描述
			//alert(normalMemberStr);
			//alert(otherMemberStr);
			//alert("系统资费名称"+mainOfferCommentVal);
			//alert("其他成员资费名称"+minorOfferNameVal);
			//alert("其他成员资费描述"+minorOfferCommentVal);

			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			var teamPhonenum="";
			
			
			/************客户信息************/
			cust_info += "手机号码：" + $("#operPhoneNo").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：<%=printName2%>" +"|";
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT")&&"<%=opCode%>"=="e855"){//和家庭，产品变更

				opr_info += "和家庭-爱家套餐主卡号码："+$("#operPhoneNo").val() + "|";
			}else if(("<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="e855"){//和家庭，产品变更

				opr_info += "和家庭-融合套餐主卡号码："+$("#operPhoneNo").val() + "|";
			}else if("<%=familyCode%>"=="ZHJT"  && "<%=opCode%>"=="e855"){//组合家庭，产品变更
				opr_info += "和家庭-魔百和融合套餐家长号码："+$("#operPhoneNo").val() + "|";
			}
			else{
				opr_info += "家庭宜居通固话号码：" + $("#parentPhone").val() + "|";
			}
		 if(opcode=="e283") {
			opr_info += "退出亲情畅聊业务的组建人号码："+$("#operPhoneNo").val() + "|";		
			
			}	
			else if(opcode=="e284") {
			opr_info += "组建亲情畅聊人号码："+$("#operPhoneNo").val() + "|";
			}
			else if(opcode=="e285") {
			opr_info += "亲情畅聊组建人号码："+$("#operPhoneNo").val() + "|";
			}
			

			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e855' : 
					if("<%=familyCode%>"!="HEJT" && "<%=familyCode%>"!="JHJT" && "<%=familyCode%>"!="HJTA" && "<%=familyCode%>"!="HJTB" && "<%=familyCode%>"!="ZHJT"){//和家庭，产品变更
			
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
						}
					}
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}

					break;
				case 'e282' :
					/*
					//需求变化，只要新添加的号码
					//融合所有的成员号码
					if(memberPhoneList.length > 0) {
						otherMemberStr = memberPhoneList.join(',') + "," + otherMemberStr;
					}
					*/
					opr_info += "本次加入家庭的可选成员手机号码：" + otherMemberStr + "|";
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'e283' :
					opr_info += "本次退出家庭的成员手机号码：" + otherMemberStr + "|";
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'e284' :	
					var tempMember = normalMemberStr;
					if(otherMemberStr.length >0) {
						tempMember = otherMemberStr;
					}
					opr_info += "亲情畅聊成员手机号码：" + tempMember + "|";
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
				case 'e285' :	
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "亲情畅聊成员手机号码：" + otherMemberStr + "|";
					}
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(offerName.length > 0){
					 if(opcode=="e284") {
				    opr_info += "指定资费：" + "<%=offerids%>"+minorOfferNameVal + "|";
				   }
				  if(opcode=="e283") {
				    opr_info += "指定资费：" + "<%=offerids%>"+offerName + "|";
				   }
				   	if(opcode=="e285") {				          
				    opr_info += "指定资费：" +"<%=offerids%><%=offernames%>"+ "|";
				   }
					 if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e855"){//和家庭，产品变更
	
					 	 /*var selChgval = $("select[name='selChg']").find("option:selected").val();
					 	 var selChgText = $("select[name='selChg']").find("option:selected").text().split("--");*/
					 	 opr_info += "原资费名称：" + offerName +"   资费代码：" + $("#v_offerId").val()+ "|";	
					 	 /*opr_info += "资费代码：" + "<%=prodCode%>" + "|";	*/
					 	 opr_info += "申请资费名称：" + $("#newmainOfferName").val() +"   资费代码：" + $("#newmainOfferId").val() + "|";
					 	 //opr_info += "资费代码：" + $("#newmainOfferId").val() + "|";	
					 }else{
					 	 /* opr_info += "原幸福家庭主资费：" +"<%=offerids%><%=offernames%>"+ "|";
				     opr_info += "变更后的新幸福家庭主资费：" + offerName + "|";	*/
				     opr_info += "原幸福家庭主资费：" + offerName + "|";	
				     opr_info += "变更后的新幸福家庭主资费：" + $("#newmainOfferName").val() + "|";		
					 }				   
			} 
			opr_info += opr_info_temp;
			/************注意事项************/
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="e855"){//和家庭，产品变更

				note_info1 += "申请资费描述：" + "|";
				note_info1 += $("#newmainorOffercomment").val() + "|";
			}else if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e855"){//组合家庭，产品变更

			}else{
				note_info1 += "备注：" + "|";
				if(offerComment.length > 0){
					note_info1 += "变更后新资费描述：" + $("#newmainorOffercomment").val() + "|";
				}
			}
			
			note_info1 += note_info1_temp;
			note_info1 += "注意事项：" + "|";
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT")&&"<%=opCode%>"=="e855"){//和家庭，产品变更

		  			note_info1 += "1、如成员套餐内有免费通话时长（或数据流量），首先使用成员套餐内免费通话时长（或数据流量），用完后再使用主卡家庭套餐内的共享通话时长（或流量）。共享通话时长（或流量）使用完后，主卡、成员用户分别执行各自所选套餐的超出后资费标准。"+"|";
						note_info1 += "2、爱家套餐的主卡和成员号码必须归属同一个地市，主卡用户不能办理报停和预销。"+"|";
						note_info1 += "3、在合约期内，88元套餐用户可变更到118元及以上套餐，需补交100元智能终端初装费，龙江网络公司提供多功能智能终端，原MODEM和机顶盒需返还给有线电视安装人员；118元及以上套餐用户可变更为非88元套餐。爱家套餐用户不可变更为非爱家套餐、或取消套餐。"+"|";
						note_info1 += "4、手机主卡欠费，当日关停宽带上网功能及有线电视服务（如原有线电视账户没有费用）；用户缴费后恢复宽带和有线电视功能。"+"|";
						note_info1 += "5、客户原有线电视账户费用不退，如手机主卡欠费或合约期结束后，可继续使用原有线电视账户费用支付有线电视基础收视费及增值业务费用。"+"|";
						note_info1 += "6、手机新入网用户资费立即生效，套餐内手机和有线电视服务功能同步生效、宽带以安装竣工时间为准生效，套餐按整月收取使用费；在网用户爱家资费预约生效，宽带如当月竣工免费体验，手机、宽带和有线电视业务次月1日生效并开始计费。"+"|";
						note_info1 += "7、爱家套餐用户只能通过手机账户代缴宽带费，不能通过宽带账户单独缴费。"+"|";
						note_info1 += "8、爱家套餐月使用费，按整月收取，不区分上下半月。"+"|";
						
			}else if(("<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="e855"){//和家庭，产品变更


		  			note_info1 += "1、如成员套餐内有免费通话时长（或数据流量），首先使用成员套餐内免费通话时长（或数据流量），用完后再使用主卡家庭套餐内的共享通话时长（或流量）。共享通话时长（或流量）使用完后，主卡、成员用户分别执行各自所选套餐的超出后资费标准。"+"|";
						note_info1 += "2、融合套餐的主卡和成员号码必须归属同一个地市，主卡用户不能办理报停和预销。"+"|";
						note_info1 += "3、在合约期内，融合套餐用户不可变更为非融合套餐，或取消融合套餐。"+"|";
						note_info1 += "4、手机主卡欠费，当日关停宽带上网功能 ；用户缴费后恢复宽带功能。"+"|";
						note_info1 += "5、手机新入网用户资费立即生效，宽带以安装竣工时间为准生效，套餐按整月收取使用费；在网用户融合资费预约生效，宽带如当月竣工免费体验，手机和宽带业务次月1日生效并开始计费。"+"|";
						note_info1 += "6、融合套餐用户只能通过手机账户代缴宽带费，不能通过宽带账户单独缴费。"+"|";
						note_info1 += "7、融合套餐月使用费，按整月收取，不区分上下半月。"+"|";
			
			}else if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e855"){//组合家庭，产品变更
						var autoCancel = $("#autoCancel").val();
		  			note_info1 += "1、如成员套餐内有免费通话时长（或数据流量），首先使用成员套餐内免费通话时长（或数据流量），用完后再使用主卡家庭套餐内的共享通话时长（或流量）。共享通话时长（或流量）使用完后，主卡、成员用户分别执行各自所选套餐的超出后资费标准。"+"|";
						note_info1 += "2、魔百和融合套餐的主卡和成员号码必须归属同一个地市，主卡用户不能办理报停和预销。"+"|";
						note_info1 += "3、在合约期内，魔百和融合套餐用户可以在不同价格的魔百和融合套餐内变更套餐，但不可变更为非魔百和融合套餐，或取消魔百和融合套餐。"+"|";
						note_info1 += "4、手机主卡欠费，当日关停宽带上网功能 ；用户缴费后恢复宽带功能。"+"|";
						note_info1 += "5、手机新入网用户资费立即生效，宽带以安装竣工时间为准生效，套餐按整月收取使用费；在网用户融合资费预约生效，宽带如当月竣工免费体验，手机和宽带业务次月1日生效并开始计费。"+"|";
						note_info1 += "6、魔百和融合套餐用户只能通过手机账户代缴宽带费，不能通过宽带账户单独缴费。"+"|";
						note_info1 += "7、魔百和融合套餐月使用费，按整月收取，不区分上下半月。"+"|";
						if(autoCancel == "0"){
							note_info1 += "8、和家庭-魔百和融合套餐到期后，互联网电视自动延续，每个月20元钱。"+"|";
						}else if(autoCancel == "1"){
							note_info1 += "8、和家庭-魔百和融合套餐到期后，互联网电视自动取消。"+"|";
						}
			}else{
				note_info1 += "1、原资费有效期至本月底。"+"|";
				note_info1 += "2、新资费优惠在下月1日零时生效。"+"|";
			}
			

		
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		function getNote(){
			var returnStr = "";
			var opCode = "<%=opCode%>";
			var roleObj;
			for(var i = 0; i < familyRoleList.getLength(); i++){
				roleObj = familyRoleList.getFamRole(i);
				if(roleObj.getMembId() == "70001"){
					$("#homeEasyPhoneHide").val(roleObj.getPhone());
				}
			}
			if(opCode == "e283"){
				returnStr += "1、成功办理退订幸福家庭套餐，自次月起将不再享受幸福家庭套餐优惠业务。" + "|";
			}else if(opCode == "e284"){
				returnStr += "1、移动手机号码退订幸福家庭套餐后，自次月起将按照不再享受家庭内业务优惠资费。" + "|";
				returnStr += "2、如您的固话因质量问题不能继续使用，请到营业厅重新购机或办理重新捆绑业务。若话费未返还客户解散家庭则话费不再返还，客户需要补交购买话机金额，同时移动公司收取活动剩余预存话费的30%作为违约金。" + "|";
			}else if(opCode == "e285") {
				returnStr += "1、办理业务冲正需缴纳宜居通业务功能费15元/次。" + "|";
			}
			
			return returnStr;
		}
		function goBack(){
			location="fe280.jsp?activePhone=<%=operPhoneNo%>";
		}
		function deleteMember(rownum,checkObj){
			/* 这里要调用公共校验函数 */
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
			/* 当某个成员已添加数量等于角色最小数时，删除选项置灰 */
			var resule0Obj = $("input[id^='memRoleId_']");
			$.each(resule0Obj,function(i,n){
				//var unselectedNum = getunselectedMemNum(n.value);
				//var rownum = n.id.substr(10,11);
				//$("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)").html();
				/*获取配置的家庭成员数量最小值*/
				var membMinNum = $("#familyRoleTab tr:eq("+(i + 1)+") td:eq(2)").html().trim();
				/* 获取家庭成员数量 */
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
			/* 可用标识 false不可用    true可用 */
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
			/* 根据memberRoleId获取没有选中的成员数量，即家庭中存在成员数量 */
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
			/* 根据memberRoleId把未选中行置成可用不可用
					styleFlag 1 可用   0 不可用
			*/
			var delMemberObj = $("input[name='delMember'][value='" + memberRoleId + "']");
			$.each(delMemberObj,function(i,n){
				if($(n).attr("checked") == undefined){
					if(styleFlag == "0"){
						$(n).attr("disabled","true");
					}else if(styleFlag == "1"){
						//liujian 变更的可选成员不可以退出
						//checkbox的逻辑是：必选和家长不能退，通过最小个数确定；可选变更的不能退
						//$(n).removeAttr("disabled");
					}
				}
			});
		}
		function setSelectedNum(memberRoleId,addFlag){
			/* 根据memberRoleId 调整已添加数量
					addFlag  1 加1	-1  减1
			 */
			/* 获取所在行号 */
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
			familyRoleList.setOp_note("<%=work_no%>" + "做" + "<%=opName%>" + "操作");
			
			var $target = $('select[name="selChg"]').find("option:selected");
			if ($target.length > 0){
					var spInfo = $.trim($target.attr('sp_info'));
					familyRoleList.setSpInfo(spInfo);
			}
			
			var selChgval = $("select[name='selChg']").find("option:selected").val();
			if(selChgval.length==0)
			{
				familyRoleList.setProd_code("1006");
			}
			else
				{
					familyRoleList.setProd_code(selChgval);
				}
			familyRoleList.setFamily_code("<%=familyCode%>");
			
			var checkObj = $("input[name='delMember']");
			var famRole = new FamRole();
			var business = new Business();
			var rowNum = "";
			
			$.each(checkObj,function(i,n){
				if($(n).attr("checked") != undefined){
					rowNum = n.id.substr(10,11);
					famRole = new FamRole();
					var memberRoleIdVal = $("#memberRoleId_"+rowNum).val();
					var phoneNoVal = $("#phoneNo_"+rowNum).val();
					var familyRoleVal = $("#familyRole_"+rowNum).val();
					var memberRoleNameVal = $("#memberRoleName_"+rowNum).val();
					var payTypeVal = $("#payType_"+rowNum).val();
				var sflags="0";	
				for(var is=0;is<quitphoneArray.length;is++){
         			if(quitphoneArray[is]==phoneNoVal) {
         				sflags="1";
         				continue;
         			}
          }
				
				 if(sflags=="1") {
				 return true;
				 }else {
				 }

					famRole.setPhone(phoneNoVal);
					famRole.setRoleId(familyRoleVal);
					famRole.setRoleName(memberRoleNameVal);
					famRole.setMembId(memberRoleIdVal);
					famRole.setPay_type(payTypeVal);
					/* 在这里需要拼接business对象 */
					famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
					famRole = createBusiness1(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
					
					familyRoleList.addFamRole(famRole);
				}
			});
			familyRoleList.setPay_money($("#prepayFeeHide").val());
      if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB")  && "<%=opCode%>"=="e855"){//和家庭，产品变更
				familyRoleList.setInnet_Fee($("#innetFeeHidd").val());//初装费
			}
			if("<%=familyCode%>"=="ZHJT"  && "<%=opCode%>"=="e855"){//组合家庭，产品变更
				familyRoleList.setAutoCancel($("#autoCancel").val());//到期是否自动取消
			}
			var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});
			//alert(myJSONText);
			$("#myJSONText").val(myJSONText);
		}
		
		function createBusiness(famRole,phoneNo,memberRoleId,familyRole,payType){
			var business = new Business();
			var sflags="0";
			for(var i = 0; i < famBusiArray.length; i++){
				if("<%=opCode%>" == "e283" && i == (famBusiArray.length-1)) {
					$("#minorOfferName").val(famBusiArray[i][9]);
					$("#minorOfferComment").val(famBusiArray[i][10]);
				}
				if(famBusiArray[i][3] == phoneNo){
				
			/*
				for(var is=0;is<quitphoneArray.length;is++){
         			if(quitphoneArray[is]==phoneNo) {
         				sflags="1";
         				continue;
         			}
          }
				
				 if(sflags=="1") {
				 continue;
				 }else {
				 }
				 
				*/
				
					business = new Business();
					business.setBusitype(famBusiArray[i][6]);
					business.setBusinessId(famBusiArray[i][5]);
					business.setOper("07");
					if("<%=opCode%>" == "e855" && famBusiArray[i][0] == "70001"){
						$("#prepayFeeHide").val("0");
						business.setMach_fee($("#machFee").val());
 			   	}
 			   		<%
 			   	if("e855".equals(opCode)){
 			   		if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) { %>
						$("#minorOfferName").val(famBusiArray[i][9]);
						$("#minorOfferComment").val(famBusiArray[i][10]);
						<%
					  }
					}
					%>
					
					/*liujian add*/
					/*
					if(familyRole == "M"){
						if($("#mainOfferName").val() == ""){
							$("#mainOfferName").val(famBusiArray[i][9]);
						}
					}else{
						$("#minorOfferName").val(famBusiArray[i][9]);
						$("#minorOfferComment").val(famBusiArray[i][10]);
					}
					*/
				
					
					/*liujian 注释结束*/
					if("<%=opCode%>" == "e285" && memberRoleId == "70001"){
						/* 查询一下预存款金额，冲正时打印发票用 */
						var msgPacket = new AJAXPacket("getPrepayFee.jsp","正在获取数据，请稍候......");
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
		
				function createBusiness1(famRole,phoneNo,memberRoleId,familyRole,payType){
			var business = new Business();
			var sflags="0";
			for(var i = 0; i < famBusiArray2.length; i++){
				if("<%=opCode%>" == "e283" && i == (famBusiArray2.length-1)) {
					$("#minorOfferName").val(famBusiArray2[i][9]);
					$("#minorOfferComment").val(famBusiArray2[i][10]);
				}
				
				if(famBusiArray2[i][3] == phoneNo){
				
				/*
								for(var is=0;is<quitphoneArray.length;is++){
         			if(quitphoneArray[is]==phoneNo) {
         				sflags="1";
         				continue;
         			}
          }
				
				 if(sflags=="1") {
				 continue;
				 }else {
				 }
				 
				 */
				 
					business = new Business();
					business.setBusitype(famBusiArray2[i][4]);
					business.setBusinessId(famBusiArray2[i][5]);
					if ("<%=opCode%>" == "e855"){
							business.setOper("08");
					} else {
							business.setOper("06");
					}
					business.setOfferId(famBusiArray2[i][8]);
					if("<%=familyCode%>"=="XFJT"&&"<%=opCode%>"=="e855"){//幸福家庭，产品变更
					  if(famBusiArray2[i][4]=="MO"){//主资费
					    business.setAreaCode($("#newAttrIds").val());
					  }else{
					    business.setAreaCode("");
					  }
					}else{
					  business.setAreaCode("");
					}
					
					if("<%=opCode%>" == "e855" && famBusiArray2[i][0] == "70001"){
						$("#prepayFeeHide").val("0");
						//business.setMach_fee($("#machFee").val());
 			   	}
 			   		<%
 			   	if("e855".equals(opCode)){
 			   		if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) { %>
						$("#minorOfferName").val(famBusiArray2[i][9]);
						$("#minorOfferComment").val(famBusiArray2[i][10]);
						<%
					  }
					}
					%>
					
					/*liujian add*/
					/*
					if(familyRole == "M"){
						if($("#mainOfferName").val() == ""){
							$("#mainOfferName").val(famBusiArray2[i][9]);
						}
					}else{
						$("#minorOfferName").val(famBusiArray2[i][9]);
						$("#minorOfferComment").val(famBusiArray2[i][10]);
					}
					*/
				
					
					/*liujian 注释结束*/
					if("<%=opCode%>" == "e285" && memberRoleId == "70001"){
						/* 查询一下预存款金额，冲正时打印发票用 */
						var msgPacket = new AJAXPacket("getPrepayFee.jsp","正在获取数据，请稍候......");
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
		function getmainoffers () {
		
		
		}
		
		function appendOffers() {//拼接已经办理的资费和可选资费，根据办理的是本地计划和省内计划。
		var stingstr="";
		var arrayObj = new Array();
		var newarrayObj =new Array();
		var sprodid="";
					for(var i = 0; i < famBusiArray.length; i++){						

					          arrayObj[i]=famBusiArray[i][8]+"-"+famBusiArray[i][9];
					            					
					}
					newarrayObj= array_unique4(arrayObj);
					
					for(var i=0;i<newarrayObj.length;i++){
          stingstr+=newarrayObj[i]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
          }
					
					$("#zhq").append(stingstr);
					
					
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","正在获取数据，请稍候......");
			msgPacket.data.add("phoneNo","<%=parentPhone%>");
			msgPacket.data.add("opCode","<%=opCode%>");
			if("<%=opCode%>" == "e855"){
				if("<%=familyCode%>" == "HEJT" || "<%=familyCode%>" == "HJTA" || "<%=familyCode%>" == "HJTB" || "<%=familyCode%>" == "ZHJT"){
	 				msgPacket.data.add("prodCode","<%=prodCode%>");
	 			}else{
	 				msgPacket.data.add("prodCode","1006");
	 			}
			}else{
				msgPacket.data.add("prodCode","1006");
			}
			msgPacket.data.add("memRoleId","<%=parentMembRoleId%>");
			msgPacket.data.add("queryType","5");
			msgPacket.data.add("famCode","<%=familyCode%>");
			msgPacket.data.add("outNum","11");
			if("<%=opCode%>" == "e855")
			{
				msgPacket.data.add("vOrderFlag","1");
			}
			core.ajax.sendPacket(msgPacket, doFamBusiMsgBack2);
		}
				function doFamBusiMsgBack2(packet){
					var retCode = packet.data.findValueByName("retcode");
					var retMsg = packet.data.findValueByName("retmsg");
					var result = packet.data.findValueByName("result");
					if(retCode != "000000"){
						rdShowMessageDialog("没有查询到要转换的资费信息" + retCode + retMsg);
						window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
					}else{
						famBusiArray2 = result;
								var stingstr="";
								var arrayObj = new Array();
								var newarrayObj =new Array();
						
						for(var i = 0; i < famBusiArray2.length; i++){						

  					  arrayObj[i]=famBusiArray2[i][8]+"-"+famBusiArray2[i][9];
  					  
  					  if(famBusiArray2[i][1]=="M" &&
  					   (famBusiArray2[i][5]=="110024"||
  					   famBusiArray2[i][5]=="100123"||
  					   famBusiArray2[i][5]=="100223"||
  					   famBusiArray2[i][5]=="100302"||
  					   
  					   famBusiArray2[i][5]=="100423"||
  					   famBusiArray2[i][5]=="100523"||
  					   famBusiArray2[i][5]=="130056"||
  					   famBusiArray2[i][5]=="100306"||
  					   famBusiArray2[i][5]=="400122")) {		
  							$("#newmainOfferName").val(famBusiArray2[i][9]);
  							$("#newmainOfferId").val(famBusiArray2[i][8]);//主资费id
  							$("#newmainorOffercomment").val(famBusiArray2[i][10]);
  					   }       					
					  }
					  newarrayObj= array_unique4(arrayObj);
					
  					for(var i=0;i<newarrayObj.length;i++){
              stingstr+=newarrayObj[i]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            }
  					$("#zhh").html("");
  					$("#zhh").append(stingstr);
  					//判断是否展示小区资费
  					if($("#newmainOfferId").val() != ""){
  						//if(famBusiArray2[i][8]!=""&&famBusiArray2[i][8]!=null){
	  					  if(("<%=familyCode%>"=="XFJT" || "<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT")&&"<%=opCode%>"=="e855"){//幸福家庭，产品变更 + 和家庭，产品变更
	  					    changeMainOffer($("#newmainOfferId").val());
	  					  }
	  					//}
  					}
					}
		}
		
		function changeMainOffer(offerId){
		  var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","请稍后...");
      packet.data.add("offerId",offerId);
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
      if(retCode == "000000"){
        v_hiddenFlag = hiddenFlag;
        //alert(v_hiddenFlag);
        if(code.length>0&&text.length>0){
          for(var i=0;i<code.length;i++){
            v_code[i] = code[i];
            v_text[i] = text[i];
          }
        }
        $("#confirm").removeAttr("disabled");
        getOfferAttr(offer_id,code,v_text);
    	}else{
    		rdShowMessageDialog(retCode + ":" + retMsg,0);
        $("#confirm").attr("disabled","true");
    		return false;
    	}
    }
    
    function getOfferAttr(offer_id,code,text){
      if(v_hiddenFlag=="Y"){ //当为Y时，进入小区代码展示页面
        for(var i=0;i<code.length;i++){
          //alert(text[i]);
        }
        var packet1 = new AJAXPacket("getOfferAttrNew.jsp","请稍后...");
        packet1.data.add("v_code" ,code);
        packet1.data.add("v_text" ,text);
        packet1.data.add("OfferId" ,offer_id);
        core.ajax.sendPacketHtml(packet1,doGetOfferAttr);
        packet1 =null;
      }else{
        $("#changeOfferAttribute").html("");
        $("#changeOfferAttribute").css("display","none");
      }
    }
    
    function doGetOfferAttr(data){
      $("#changeOfferAttribute").html("");
      $("#changeOfferAttribute").append(data);
    }
		
		function array_unique4(arrayObj) {     
		  var res = [], hash = {};    
			 for(var i=0, elem; 
			 (elem = arrayObj[i]) != null; i++)  {        
					  if (!hash[elem])         
					  {            
					   res.push(elem);            
					    hash[elem] = true;        
					  }    
			  }    
		       return res; 
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
			var offerName = packet.data.findValueByName("offerName"); //指定资费名称
			var v_offerId = packet.data.findValueByName("v_offerId"); //指定资费代码
			var offerComment = packet.data.findValueByName("offerComment"); //指定资费描述
			$("#smName").val(smName);
			$("#custName").val(custName);
			/*liujian  注释开始*/
			/*
			if("<%=opCode%>" != "e283"){
				$("#mainOfferComment").val(offerComment);
			}*/
			/*liujian  注释结束*/
			
			$("#mainOfferName").val(offerName);
			$("#mainOfferComment").val(offerComment);
			$("#v_offerId").val(v_offerId);
		//	famOffer.setMainOfferName(offerName);
		//	famOffer.setMainOfferCmt(offerComment);
		}
		function getFamBusiMsg(){
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","正在获取数据，请稍候......");
			msgPacket.data.add("phoneNo","<%=parentPhone%>");
			msgPacket.data.add("opCode","<%=opCode%>");
			msgPacket.data.add("prodCode","<%=prodCode%>");
			msgPacket.data.add("memRoleId","<%=parentMembRoleId%>");
			msgPacket.data.add("queryType","5");
			msgPacket.data.add("famCode","<%=familyCode%>");
			msgPacket.data.add("outNum","11");
			if("<%=opCode%>" == "e855")
			{
				msgPacket.data.add("vOrderFlag","3");
			}
			core.ajax.sendPacket(msgPacket, doFamBusiMsgBack);
		}
		function doFamBusiMsgBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode != "000000"){
				rdShowMessageDialog("没有查询到家庭角色业务信息" + retCode + retMsg);
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			}else{
				famBusiArray = result;
			}
		}
		function setLastTDHide(){
			/* 藏起来一列 */
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
			getmainoffers();
			appendOffers();
			var opCodeVal = "<%=opCode%>";
			if(opCodeVal == "e855"){
				setLastTDHide();
			}
			if(opCodeVal == "e285"){
				setLastTDHide();
			}
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo","<%=operPhoneNo%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			
			//liuijan add 已经退出的成员不可以再次被选择
			$('.delete_memeber_70004_1').attr("disabled","true");
			
			if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e855"){
				$("#autoCancelTab").css("display","none");
			}
			
		});
		/* */
		function selChang(temp)
		{
			var chkFamUpd = "Y";
     if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e855"){//和家庭，产品变更
				var msgPacket = new AJAXPacket("fe280_ajax_chkFamUpd.jsp","正在获取数据，请稍候......");
				msgPacket.data.add("printAccept","<%=printAccept%>");
				msgPacket.data.add("phoneNo","<%=parentPhone%>");
				msgPacket.data.add("opCode","<%=opCode%>");
				msgPacket.data.add("prodCode","<%=prodCode%>");
				msgPacket.data.add("prodCodeNew",temp);//下一档产品代码
				msgPacket.data.add("famCode","<%=familyCode%>");
				core.ajax.sendPacket(msgPacket, function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var innetFee = packet.data.findValueByName("innetFee");//初装费
					var innetrate = packet.data.findValueByName("innetrate");
					var innetRateFee = packet.data.findValueByName("innetRateFee");
					var innetFeeLeft = packet.data.findValueByName("innetFeeLeft");
					if(retCode != "000000"){
						rdShowMessageDialog("校验和获取家庭产品变更相关信息失败！<br>" + retCode+"<br>"+ retMsg,0);
						chkFamUpd = "N";
						$("select[name='selChg']").val("");
						return false;
					}else{
						chkFamUpd = "Y";
						$("#innetFeeHidd").val(innetFee);
						$("#innetrateHidd").val(innetrate);
						$("#innetRateFeeHidd").val(innetRateFee);
						$("#innetFeeLeftHidd").val(innetFeeLeft);
					}
				});
				msgPacket = null;
		  }
		  //alert(chkFamUpd);
		  if(chkFamUpd == "N"){
		  	return false;
		  }
		  
		  var chkHEJTFlag_one = "Y";
			var getdataPacket = new AJAXPacket("chkHEJTProd.jsp","请稍后...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("familyCode","<%=familyCode%>");
			getdataPacket.data.add("familyProdInfo",temp);
			getdataPacket.data.add("phoneNoVal","");
			core.ajax.sendPacket(getdataPacket,function(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				if(retCode != "000000"){
					rdShowMessageDialog("校验不通过！" + retCode + "：" + retMsg,0);
					$("select[name='selChg']").val("");
					chkHEJTFlag_one = "N";
				}else{
					chkHEJTFlag_one = "Y";
				}
			});
			getdataPacket =null;
			if(chkHEJTFlag_one == "N"){
		  	return false;
		  }
		  
			if(temp.length!=0){
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","正在获取数据，请稍候......");
			msgPacket.data.add("phoneNo","<%=parentPhone%>");
			msgPacket.data.add("opCode","<%=opCode%>");
			msgPacket.data.add("prodCode",temp);
			msgPacket.data.add("memRoleId","<%=parentMembRoleId%>");
			msgPacket.data.add("queryType","5");
			msgPacket.data.add("famCode","<%=familyCode%>");
			msgPacket.data.add("outNum","11");
			if("<%=opCode%>" == "e855")
			{
				msgPacket.data.add("vOrderFlag","1");
			}
			core.ajax.sendPacket(msgPacket, doFamBusiMsgBack2);
		}
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">家庭产品变更</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">家庭产品信息</td>
			<td>
				<select id="familyProdInfo" name="familyProdInfo" onchange="changeProd()">
					<option value ="">--请选择--</option>

<%
			//		System.out.println("zhouby: " + familyCode + "  " + belongGroupId);
			String familyInfoSql = " SELECT prod_code, prod_name, sp_info " +
							  						 " FROM sfamilyprodinfo " +
							               " WHERE family_code = '" + familyCode + "' AND GROUP_ID = '" + belongGroupId + "'";
%>
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
	</table>
	<div class="title">
		<div id="title_zi">家庭现有成员列表</div>
	</div>
	<table cellspacing="0" id="familyRoleTab">
		<tr>
			<th>角色名称</th>
			<th>角色最大数量</th>
			<th>角色最小数量</th>
			<th>已添加数量</th>
			<th>付费方式</th>
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
		<div id="title_zi">家庭现有成员列表</div>
	</div>
	<table id="familyMemberList">
		<tr>
			<th>家庭代码</th>
			<th>家庭名称</th>
			<th>手机号码</th>
			<th>角色名称</th>
			<th>生效时间</th>
			<th>失效时间</th>
			<th>操作</th>
		</tr>
		<%
		String squittype="";
		int sint=0;
			for(int i = 0; i < familyMemberList.length; i++){
				if(selfFlag || familyMemberList[i][3].equals(operPhoneNo)){
					System.out.println("----------liujian--------------selfFlag=" + selfFlag);
					System.out.println("----------liujian--------------operPhoneNo=" + operPhoneNo);
					
					squittype=familyMemberList[0][5];
					if(!squittype.equals(familyMemberList[i][5])) {//找出已经办理退出的成员号码放入数组
					
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
			<input type="hidden" id="familyRole_<%=i%>" name="familyRole_<%=i%>" value="<%=familyMemberList[i][1]%>" />
			<input type="hidden" id="memberRoleName_<%=i%>" name="memberRoleName_<%=i%>" value="<%=familyMemberList[i][2]%>" />
			<input type="hidden" id="payType_<%=i%>" name="payType_<%=i%>" value="<%=familyMemberList[i][6]%>" />
			<td width="10%"><%=familyCode%></td>
			<td><%=familyName%></td>
			<td><%=familyMemberList[i][3]%></td>
			<td><%=familyMemberList[i][2]%></td>
			<td><%=familyMemberList[i][4]%></td>
			<td><%=familyMemberList[i][5]%></td>
<%
			//liujian 变更的可选成员不可以退出
			String editSts = familyMemberList[i][11];
			if(editSts != null && editSts != "" && editSts.equals("1")) {
	%>
			<td>
				<input type="checkbox" name="delMember" id="delMember_<%=i%>" class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
				  onclick="deleteMember(<%=i%>,this)" value="<%=familyMemberList[i][0]%>" disabled/>
			</td>
	<%			
			}else {
	%>
			<td>
				<input type="checkbox" name="delMember" id="delMember_<%=i%>" class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
				  onclick="deleteMember(<%=i%>,this)" value="<%=familyMemberList[i][0]%>" />
			</td>
	<%			
			}
	%>
		</tr>
		<%
				}
			}
		%>
	</table>
	<table id="zfzh">
		<tr >
			<td class="blue" width="10%">当前资费
			</td>
			<td id="zhq">
			</td>
		</tr>
		<%
		if(result23.length>0)
		{
		%>
		<tr>
			<td class="blue" width="10%">产品变更
			</td>
			<td>
				<select name="selChg" style="width:250px" onchange="selChang(this.value);">
					<option value="" selected>----请选择----</option>
					<%
						for(int i=0;i<result23.length;i++)
						{
					%>
					<option value="<%=result23[i][0]%>" sp_info="<%=result23[i][2]%>"><%=result23[i][0]%>--<%=result23[i][1]%></option>
					<%	
						}
					%>
				</select>
				<%if((familyCode.equals("HEJT")) && "e855".equals(opCode)){%>
		 				 <font class='red'> (请注意：从88元变更为其他档位，需缴纳智能终端费用100元。) </font> 
		 		<%}%>				
			</td>
		</tr>
		<%
		}
		%>
				<tr >
			<td class="blue" width="10%">转换后资费
			</td>
			<td id="zhh">
			</td>
		</tr>
		<tr id="changeOfferAttribute" ></tr><!--小区代码-->
	</table>
	<table id="machFeeTab" style="display:none;">
		<tr>
			<td class="blue" width="10%">补收款</td>
			<td>
				<input type="text" id="machFee" name="machFee" v_type="money" v_must="1" />
				<font class="orange">*</font>
			</td>
		</tr>
	</table>
	<table id="autoCancelTab" style="display:none;">
		<tr>
			<td class="blue" width="10%">到期是否自动取消</td>
			<td colspan="3">
				<select id="autoCancel" name="autoCancel" >
					<option value ="1" >是</option>
					<option value ="0" >否</option>
				</select>
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
	<input type="hidden" name="mainOfferComment" id="mainOfferComment" value="" />
	<input type="hidden" name="v_offerId" id="v_offerId" value="" />
	<input type="hidden" name="minorOfferComment" id="minorOfferComment" value="" />
	<input type="hidden" name="familyName" id="familyName" value="<%=familyName%>" />
	<input type="hidden" name="smName" id="smName" />
	<input type="hidden" name="printName" id="printName" value="<%=printName%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" name="mainOfferName" id="mainOfferName" value="" />
	<input type="hidden" name="minorOfferName" id="minorOfferName" value="" />
	<input type="hidden" name="famlicodes" id="famlicodes" value="<%=familyCode%>" />
  <input type="hidden" name="newmainOfferName" id="newmainOfferName" value="" />
  <input type="hidden" name="newmainOfferId" id="newmainOfferId" value="" />
	<input type="hidden" name="newmainorOffercomment" id="newmainorOffercomment" value="" />
	<input type="hidden" name="innetFeeHidd" id="innetFeeHidd" value="" />
	<input type="hidden" name="innetrateHidd" id="innetrateHidd" value="" />
	<input type="hidden" name="innetRateFeeHidd" id="innetRateFeeHidd" value="" />
	<input type="hidden" name="innetFeeLeftHidd" id="innetFeeLeftHidd" value="" />
	<input type="hidden" name="v_membRoleId" id="v_membRoleId" value="<%=v_membRoleId%>" />
	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="确认" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" />
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
