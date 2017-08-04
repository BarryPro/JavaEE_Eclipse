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
 		String printOpName = "";
 		String printName2 = "";
 		String v_case = "2";
 		if("e283".equals(opCode) || "e284".equals(opCode)){ //成员退出,家庭解散
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){
 				v_case = "9";
 			}
 		}
 		/*
 		if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
	 		if("e283".equals(opCode)){
	 			printName2 = "和家庭-爱家套餐成员退出";
 			}
 		}
 		if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 			if("e283".equals(opCode)){
 				printName2 = "和家庭-融合套餐成员退出";
 			}
 		}*/
 		
 		if("e283".equals(opCode)){
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
 				printName2 = "和家庭-爱家套餐成员退出";
 			}
 			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 				printName2 = "和家庭-融合套餐成员退出";
 			}
 			if(familyCode.equals("ZHJT")){
 				printName2 = "和家庭-魔百和融合套餐成员退出";
 			}
 		}
 		
 		/*gaopeng 区分宽带家庭和融合家庭的免填单打印头部展示。2014/01/15 16:46:18*/
 		if(familyCode.equals("KDJT")){
 			printOpName = "宽带家庭";
 		}else if(familyCode.equals("RHJT")){
 			printOpName = "融合家庭";
 		}
    if("e283".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "申请退出亲情畅组";
 			}
 			else if(familyCode.equals("KDJT")){
 			printName = "全球通家庭资费成员退出";
 			}
 			else if(familyCode.equals("RHJT")){
 			printName = "融合家庭资费成员退出";
 			}
 		  else {
 		  printName = "幸福家庭成员业务退订";
 		  }
 		}else if("e284".equals(opCode)){
 			
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
 				printName2 = "和家庭-爱家套餐家庭解散";
 	   	}
 	   	if(familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 				printName2 = "和家庭-融合套餐家庭解散";
 	   	}
 	   	if(familyCode.equals("ZHJT")){
 				printName2 = "和家庭-魔百和融合套餐家庭解散";
 	   	}
 			
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组取消";
 			}
 			else if(familyCode.equals("KDJT")){
 			printName = "全球通家庭资费家庭解散";
 			}
 			else if(familyCode.equals("RHJT")){
 			printName = "融合家庭资费家庭解散";
 			}
 			else {
 		  printName = "幸福家庭业务退订";
 		  }
 		}else if("i089".equals(opCode) ){
 			  printName = "幸福家庭续签冲正";
 			
 		}else if("e285".equals(opCode) ){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组冲正";
 			}
 			else if(familyCode.equals("KDJT")){
 			printName = "全球通家庭资费创建家庭冲正";
 			} 
 			else if(familyCode.equals("RHJT")){
 			printName = "融合家庭资费创建家庭冲正";
 			} 			
 			else {
 		  printName = "幸福家庭签约送礼冲正";
 		  }
 		}
 		%>
 		<script>
 			//alert("<%=opCode%>");
 			//alert("<%=familyCode%>");
 			//alert("<%=familyName%>");
 			//alert("<%=printName%>");
 	</script>
 		<%
 		String printAccept="";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
		
		System.out.println("---hejwa--------------v_case------------------->"+v_case);
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="9">
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
	String rn_flag = "";
	if ( opCode.equals("i089") )
	{
		rn_flag = result0[0][8];
	}
	
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	String parentPhone ="";
	String parentCustName = "";
	String parentMembRoleId = "";
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
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][0]="+familyMemberList[i][0]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][1]="+familyMemberList[i][1]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][2]="+familyMemberList[i][2]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][3]="+familyMemberList[i][3]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][4]="+familyMemberList[i][4]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][5]="+familyMemberList[i][5]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][6]="+familyMemberList[i][6]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][7]="+familyMemberList[i][7]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][8]="+familyMemberList[i][8]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][9]="+familyMemberList[i][9]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][10]="+familyMemberList[i][10]);
			System.out.println("gaopengSeeLog in fe280Quit.jsp====familyMemberList["+i+"][11]="+familyMemberList[i][11]);
				if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
					parentPhone = familyMemberList[i][3];
					parentCustName = familyMemberList[i][9];
					parentMembRoleId = familyMemberList[i][0];

				}
			}
			if("e285".equals(opCode) || "e283".equals(opCode) || "e284".equals(opCode)){/*冲正时查询成员资费--仅限亲情畅聊3元和5元两种资费*/
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
<html>
<head>
	<title>家庭产品变更</title>
	<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe280PubScript.js"></script>
	<script language="javascript">
		
		var familyRoleList = new FamRoleList();
	//	var famOffer = new FamOffer();
		var famBusiArray = new Array();
		var quitphoneArray = new Array();
		
		function nextStep(subButton){
			if("<%=opCode%>" == "e284"){
				<% if(familyCode.equals("QQSY") || familyCode.equals("QQWY") || familyCode.equals("KDJT")
						|| familyCode.equals("QWJT") || familyCode.equals("TXJT") || familyCode.equals("TSJT") || familyCode.equals("PYJT")
						|| familyCode.equals("ZDGX") || familyCode.equals("RHJT") || familyCode.equals("JTGX")|| familyCode.equals("JHJT")|| familyCode.equals("ZSLL")) {%>			
			  <%}else {%>
			  	if(!checkElement(document.form1.machFee)){
					return false;
				  }
			  	<%}%>
	
			}
			if("<%=opCode%>" == "e285"){
				if("<%=familyCode%>" == "RHJT"){
					/*
					if(!checkElement(document.form1.machFee)){
					return false;
					*/
				}
				
			}
			/* 按钮延迟 */
			controlButt(subButton);
			/* 事后提醒 */
			getAfterPrompt();
			
			/* 拼装报文 */
			setJSONText();
			/*begin update for 【申告】亲情网生产问题@2015/4/21 */
			if(("<%=familyCode%>" == "QWJT" || "<%=familyCode%>" == "PYJT" || "<%=familyCode%>" == "TXJT" || "<%=familyCode%>" == "TSJT") && "<%=opCode%>" == "e284"){
				if(familyRoleList.getLength() == 0){
					rdShowMessageDialog("无法获取到当前家庭成员信息，无法进行家庭解散操作！请重新操作！",0);
					removeCurrentTab();
					return false;	
				}
				if(familyRoleList.getProd_code() == ""){
					rdShowMessageDialog("无法获取到当前家庭的产品信息代码，无法进行家庭解散操作！请重新操作！",0);
					removeCurrentTab();
					return false;	
				}
			}
			/*
			alert("familyCode = <%=familyCode%>");
			*/
			/*end update for 【申告】亲情网生产问题@2015/4/21 */
			getPrintInfo();
			/* 打印免填单&提交页面 */
			<%if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {%>
			printCommit11('<%=opCode%>');
			<%}else if(familyCode.equals("KDJT") || familyCode.equals("RHJT")){%>
			printCommit22('<%=opCode%>');
			<%}else if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){%>
			printCommit33('<%=opCode%>');
			<%}else if(familyCode.equals("ZSLL")){%>
				printCommit44('<%=opCode%>');
		  <%}else {%>
			printCommit('<%=opCode%>');
			<%}%>
		}
		
		function getPrintInfo(){
				/**********
				获取免填单打印信息
				包括资费名称和资费描述
				调用服务sFamSelCheck，其中
				7   查询类型         iQryType 传 7 
				9   产品代码         iProdCode必须传
				*/
			var famProdInfoObj = $("#familyProdInfo");
			var getdataPacket = new AJAXPacket("fe280PubGetMsg.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",famProdInfoObj.val());
			getdataPacket.data.add("outNum","3");
			if("<%=familyCode%>" == "ZDGX"){
				getdataPacket.data.add("queryType","8");
			}else{
				getdataPacket.data.add("queryType","7");
			}
			
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
								function printCommit22(opCode){
			var ret = showPrtDlg22(opCode,"确实要进行电子免填单打印吗？","Yes");
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
		
				function printCommit33(opCode){
			var ret = showPrtDlg33(opCode,"确实要进行电子免填单打印吗？","Yes");
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
		
		function printCommit44(opCode){
			
			var ret = showPrtDlg44(opCode,"确实要进行电子免填单打印吗？","Yes");
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
							function showPrtDlg22(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept =$("#printAccept").val();       //流水号
			var printStr = printInfo22(opcode);			 		//调用printinfo()返回的打印内容
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
		
		function showPrtDlg33(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept =$("#printAccept").val();       //流水号
			var printStr = printInfo33(opcode);			 		//调用printinfo()返回的打印内容
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
		
		function showPrtDlg44(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept =$("#printAccept").val();       //流水号
			var printStr = printInfo44(opcode);			 		//调用printinfo()返回的打印内容
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
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
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
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：" + $("#printName").val()+"|";
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			
		 if(opcode=="e283") {
			opr_info += "退出亲情畅聊业务的组建人号码："+$("#parentPhone").val() + "|";		
			
			}	
			else if(opcode=="e284") {
			opr_info += "组建亲情畅聊人号码："+$("#operPhoneNo").val() + "|";
			}
			else if(opcode=="e285") {
			opr_info += "亲情畅聊组建人号码："+$("#operPhoneNo").val() + "|";
			}
			
			/*liujian add 对业务分情况*/
			/*
				不同业务展示的免填单的指定资费不同
				幸福家庭成员业务退订：普通成员的资费    对应的opcode=e283
				幸福家庭业务退订    ：宜居通家长的资费  对应的opcode=e284
				幸福家庭签约送礼冲正：宜居通家长的资费  对应的opcode=e285
			*/
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
					}
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					/*只有创建时展示可选成员办理资费*/
					if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
						opr_info_temp = "可选成员办理资费：" + minorOfferNameVal + "|";
						note_info1_temp = "可选成员办理的资费描述：" + minorOfferCommentVal + "|";
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
				   // opr_info += "指定资费：" + offerName + "|";				    
			} 
			opr_info += opr_info_temp;
			/************注意事项************/
			note_info1 += "备注：" + "|";
			if(offerComment.length > 0){
				//note_info1 += "指定资费描述：" + offerComment + "|";
				
					 if(opcode=="e284") {
				    note_info1 += "指定资费描述：" + minorOfferCommentVal + "|";
				   }
				   if(opcode=="e283") {
				    note_info1 += "指定资费描述：" + offerComment + "|";
				   }
				   	if(opcode=="e285") {
				    note_info1 += "指定资费描述：" + "<%=offercoments%>" + "|";
				   }
				
			}
			note_info1 += note_info1_temp;
			note_info1 += "注意事项：" + "|";
			if(opcode=="e281") {
			note_info1 += "1、客户办理业务当月生效。"+"|";
			note_info1 += "2、客户取消业务下月生效。"+"|";
			note_info1 += "3、加入亲情畅聊的费用由加入的手机号码承担。"+"|";
			note_info1 += "4、成员数量最少为2人。"+"|";
			note_info1 += "5、申请组建亲情畅聊业务时最少加入2名成员。"+"|";
			note_info1 += "6、组建人取消亲情畅聊业务后，组内亲情畅聊业务不再享受优惠。"+"|";
			}
			else if(opcode=="e282") {
			note_info1 += "1、您加入亲情畅聊套餐当月生效。"+"|";
			note_info1 += "2、成员必须归属同一地市，且必须为移动号码。"+"|";
			note_info1 += "3、成员的月功能费由成员手机号码自行支付。"+"|";
			note_info1 += "4、取消亲情畅聊业务下月生效。"+"|";
			note_info1 += "5、组建人取消亲情畅聊业务后，组内亲情畅聊业务不再享受优惠。"+"|";
			}
			else if(opcode=="e283") {
			note_info1 += "1、成功办理退订亲情畅聊套餐，自次月起将不再享受亲情畅聊套餐优惠业务。"+"|";
			note_info1 += "2、退出业务下月生效。"+"|";
			note_info1 += "3、组建人取消亲情畅聊业务后，组内亲情畅聊业务不再享受优惠。"+"|";
			}	
			else if(opcode=="e284") {
			note_info1 += "1、移动手机号码退订亲情畅聊套餐后，自次月起将按照不再享受亲情畅聊业务优惠资费。"+"|";
			note_info1 += "2、组建人取消亲情畅聊业务后，组内亲情畅聊业务不再享受优惠。"+"|";
			/*2013/12/26 16:04:23 gaopeng 关于哈分公司申请139、188融合类新套餐的请示 修改取消免填单，加入打印信息*/
			note_info1 += "温馨提示："+"|";
			note_info1 += "客户办理畅享套餐业务取消，取消时如果家长资费为包年或包半年资费，需要先补促销品款，再扣除剩余包年专款的30%作为违约金，家长和宽带转为取消后资费；"+"|";
			note_info1 += "若申请取消，按营销活动违约处理，客户需按赠送礼品原价交纳现金。"+"|";
			note_info1 += "退订时需返还元申广电高清机顶盒及高清服务卡，并停止高清服务。"+"|";
			
			}
			else if(opcode=="e285") {
				/*2013/12/26 16:04:23 gaopeng 关于哈分公司申请139、188融合类新套餐的请示 修改冲正免填单，加入打印信息*/
				note_info1 += "温馨提示："+"|";
				note_info1 += "客户办理139/188全球通畅享套餐冲正业务，客户需返还赠送礼品。如丢失请按照礼品实价缴纳费用。"+"|";
			}
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
				function printInfo22(opcode){
					
			var parent_member_Id = '70009'; //宽带家庭家长
			var normal_member_Id = '70010'; //普通成员
			var other_member_Id = '70011';  //其他成员
			var kd_member_Id = '70012';  //宽带家庭
			if("<%=familyCode%>" == "RHJT"){
				parent_member_Id = "50001";
				other_member_Id = "50003";
				kd_member_Id = "50002";
			}
			var offerName = ''; //指定资费名称
			var offerComment = '';//指定资费描述
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
			var kdMemberStr = getPhoneNoByMemberId(kd_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //系统资费名称
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //系统资费描述
			var minorOfferNameVal = $("#minorOfferName").val(); //其他成员资费名称
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//其他成员资费描述
			
						var chengyuanzifei11=$("#chengyuanzifei11").val();
			var chengyuanzifeimiaoshu11=$("#chengyuanzifeimiaoshu11").val();
			var chengyuanzifei22=$("#chengyuanzifei22").val();
			var chengyuanzifeimiaoshu22=$("#chengyuanzifeimiaoshu22").val();
			
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			
			
			
			/************客户信息************/
			cust_info += "手机号码：" + $("#operPhoneNo").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：" + $("#printName").val()+"|";
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			opr_info += getHomeEasyPrintInfo() + "|";
			opr_info += "<%=printOpName%>家长号码：" + $("#parentPhone").val() + "|";
			/*liujian add 对业务分情况*/
			/*
				不同业务展示的免填单的指定资费不同
				幸福家庭成员业务退订：普通成员的资费    对应的opcode=e283
				幸福家庭业务退订    ：宜居通家长的资费  对应的opcode=e284
				幸福家庭签约送礼冲正：宜居通家长的资费  对应的opcode=e285
			*/
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "<%=printOpName%>固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "<%=printOpName%>宽带成员号码：" + kdMemberStr + "|";
					}
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					/*只有创建时展示可选成员办理资费*/
					if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
						opr_info_temp = "可选成员办理资费：" + minorOfferNameVal + "|";
						note_info1_temp = "可选成员办理的资费描述：" + minorOfferCommentVal + "|";
					}
					break;
				case 'e282' :
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "本次加入的<%=printOpName%>固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "本次加入的<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "本次加入的<%=printOpName%>宽带成员号码：" + kdMemberStr + "|";
					}
					//opr_info += "本次加入家庭的可选成员手机号码：" + otherMemberStr + "|";
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'e283' :
						if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "本次退出的宽带家庭固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "本次退出的<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					//opr_info += "本次退出家庭的成员手机号码：" + otherMemberStr + "|";
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
						//tempMember = normalMemberStr + "," + otherMemberStr;
					}
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "宽带家庭固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "<%=printOpName%>宽带成员号码：" + kdMemberStr + "|";
					}
					//opr_info += "家庭成员手机号码：" + tempMember + "|";
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
				case 'e285' :	
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						//opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
					}
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "宽带家庭固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "<%=printOpName%>宽带成员号码：" + kdMemberStr + "|";
					}
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						//offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						//offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(opcode=="e283") {
  			if((chengyuanzifei11 == chengyuanzifei22)&&(chengyuanzifeimiaoshu11==chengyuanzifeimiaoshu22)){
          opr_info += "本次退出资费：" + chengyuanzifei11 + "|";			
          opr_info += "退出资费描述：" + chengyuanzifeimiaoshu11 + "|";		
  			}else if(chengyuanzifei22.length == 0 && chengyuanzifei22.length ==0){
  				opr_info += "本次退出资费：" + chengyuanzifei11 + "|";			
          opr_info += "退出资费描述：" + chengyuanzifeimiaoshu11 + "|";		
  			}
  			else{
  			  opr_info += "本次退出资费：" + chengyuanzifei11 + "|";			
    		  opr_info += "退出资费描述：" + chengyuanzifeimiaoshu11 + "|";			
    			opr_info += "本次退出资费：" + chengyuanzifei22 + "|";
    			opr_info += "退出资费描述：" + chengyuanzifeimiaoshu22 + "|";  
  			}
			}else if(opcode=="e284") {
			opr_info += "家庭解散后家长资费：" + mainOfferNameVal + "|";			
		  opr_info += "资费描述：" + mainOfferCommentVal + "|";	
		  
			}
			else {
			}
			opr_info += opr_info_temp;
			/************注意事项************/
			note_info1 += "备注：" + "|";
			if(opcode=="e283") {
			note_info1 += "本次成员退出资费，下月1日资费失效。" + "|";
			}
			if(opcode=="e284"){
				/*2013/12/26 16:04:23 gaopeng 关于哈分公司申请139、188融合类新套餐的请示 修改取消免填单，加入打印信息*/
			note_info1 += "温馨提示："+"|";
			note_info1 += "客户办理畅享套餐业务取消，取消时如果家长资费为包年或包半年资费，需要先补促销品款，再扣除剩余包年专款的30%作为违约金，家长和宽带转为取消后资费；"+"|";
			note_info1 += "若申请取消，按营销活动违约处理，客户需按赠送礼品原价交纳现金。"+"|";
			note_info1 += "退订时需返还元申广电高清机顶盒及高清服务卡，并停止高清服务。"+"|";
				
			}
			if(opcode=="e285"){
					/*2013/12/26 16:04:23 gaopeng 关于哈分公司申请139、188融合类新套餐的请示 修改冲正免填单，加入打印信息*/
				note_info1 += "温馨提示："+"|";
				note_info1 += "客户办理139/188全球通畅享套餐冲正业务，客户需返还赠送礼品。如丢失请按照礼品实价缴纳费用。"+"|";
			}
			note_info1 += note_info1_temp;
			//note_info1 += "注意事项：" + "|";
			//note_info1 += getNote();
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		function printInfo33(opcode){
					
			var parent_member_Id = ''; //宽带家庭家长
			var normal_member_Id = ''; //普通成员
			var kd_member_Id = '';  //宽带家庭
			var other_member_Id='';
			if("<%=familyCode%>" == "HEJT"){

				other_member_Id = "70024";
				kd_member_Id = "70025";
			}
			if("<%=familyCode%>" == "JHJT"){

				other_member_Id = "70051";
				
			}
			if("<%=familyCode%>" == "HJTA"){

				other_member_Id = "70027";
				kd_member_Id = "70028";
			}
			if("<%=familyCode%>" == "HJTB"){

				other_member_Id = "70030";
				kd_member_Id = "70031";
			}
			if("<%=familyCode%>" == "ZHJT"){

				other_member_Id = "70033"; //普通成员
				kd_member_Id = "70034"; //宽带成员
			}
			
			var offerName = ''; //指定资费名称
			var offerComment = '';//指定资费描述
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
			var kdMemberStr = getPhoneNoByMemberId(kd_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //系统资费名称
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //系统资费描述
			var minorOfferNameVal = $("#minorOfferName").val(); //其他成员资费名称
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//其他成员资费描述

			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			/************客户信息************/
			cust_info += "手机号码：" + $("#operPhoneNo").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			if("<%=familyCode%>" == "JHJT" && opcode == "e283"){
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务："+minorOfferNameVal +"-和家庭计划融合套餐成员退出|";
			}else if("<%=familyCode%>" == "JHJT" && opcode == "e284"){
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：取消和家庭计划融合套餐共享群组|";
			}else{
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：<%=printName2%>" +"|";
			}
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			<%
			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
			%>
				opr_info += "和家庭-融合套餐家长号码：" + $("#parentPhone").val() + "|";
		  <%}else if(familyCode.equals("HEJT")) {%>
				opr_info += "和家庭-爱家套餐家长号码：" + $("#parentPhone").val() + "|";
			<%}else if(familyCode.equals("JHJT")) {%>
				if(opcode == "e283" || opcode == "e284"){
					opr_info += "和家庭计划融合套餐群组主卡号码：" + $("#parentPhone").val() + "|";
					opr_info += "和家庭计划融合套餐成员号码：" + otherMemberStr + "|";
				}
			<%}else if(familyCode.equals("ZHJT")) {%>
				opr_info += "和家庭-魔百和融合套餐家长号码：" + $("#parentPhone").val() + "|";
			<%}%>

			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e283' :
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'e284' :	
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						<%
						if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
						%>
							opr_info += "和家庭-融合套餐宽带成员号码：" + kdMemberStr + "|";
					  <%}else if(familyCode.equals("HEJT") || familyCode.equals("JHJT")) {%>
							opr_info += "和家庭-爱家套餐宽带成员号码：" + kdMemberStr + "|";
						<%}else if(familyCode.equals("ZHJT")) {%>
							opr_info += "和家庭-魔百和融合套餐宽带成员号码：" + kdMemberStr + "|";
						<%}%>
					}
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(opcode=="e283"){
				if(otherMemberStr != null && otherMemberStr.length > 0){
					<%
					if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
					%>
						opr_info += "本次退出和家庭-融合套餐普通成员手机号码：" + otherMemberStr + "|";
			  <%}else if(familyCode.equals("HEJT")) {%>
						opr_info += "本次退出和家庭-爱家套餐普通成员手机号码：" + otherMemberStr + "|";
				<%}else if(familyCode.equals("JHJT")) {%>
						opr_info += "本次退出和家庭计划融合套餐成员号码：" + otherMemberStr + "|";
				<%}else if(familyCode.equals("ZHJT")) {%>
						opr_info += "本次退出和家庭-魔百和融合套餐普通成员手机号码：" + otherMemberStr + "|";
				<%}%>
				}	
			  opr_info += "本次退出资费：" + offerName + "|";			
		    //opr_info += "退出资费描述：" + offerComment + "|";	
		    if("<%=familyCode%>" == "JHJT"){
		    	opr_info += "退出资费描述：" + offerComment + "|";	
		    }
		    
			}
			if(opcode=="e284") {
			opr_info += "家庭解散后家长资费：" + mainOfferNameVal + "|";			
		  opr_info += "资费描述：" + mainOfferCommentVal + "|";	
		  
			}
			else {
			}
			opr_info += opr_info_temp;
			/************注意事项************/
			note_info1 += "备注：" + "|";
			if(opcode=="e283"){
				<%
				if(	familyCode.equals("ZHJT")){
				%>
					note_info1 += "注意事项：" + "|";
					note_info1 += "您将不再享有和家庭套餐，不再享有成员间本地互打免费时长，主叫时长、手机数据流量也不可以和家长共享。"+"|";
			  <%}%>
			  if("<%=familyCode%>" == "JHJT"){
			  	note_info1 += "月使用费0元。可以免费使用主卡套餐内流量。每月可享受群组内本地通话免费时长500分钟。" + "|";
			  	note_info1 += "注意事项：" + "|";
			  	note_info1 += "1、成功办理和家庭计划融合套餐成员退出的副卡客户，自次月起不再享受主卡客户的流量共享、群组内本地通话免费时长300分钟。" + "|";
			  	note_info1 += "2、解除业务次月生效。" + "|";
			  }
			  
			}
			if(opcode=="e284"){
				<%
				if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
				%>
					note_info1 += "注意事项：" + "|";
				  note_info1 += "1、融合套餐取消，如宽带已竣工、初装费不退还。"+"|";
					note_info1 += "2、融合套餐办理当月不能取消；如超过套餐正常计费2个月，套餐取消需收取套餐月使用费的30%作为违约金。"+"|";
					note_info1 += "3、融合套餐取消后，次月1日凌晨关停宽带功能。"+"|";
		
					note_info1 += "温馨提示："+"|";
					note_info1 += "请在您资费合约到期前，及时办理融合套餐续签业务。"+"|";
			  <%}else if(familyCode.equals("HEJT")) {%>
					note_info1 += "注意事项：" + "|";
				  note_info1 += "1、客户需到当地广电营业厅办理爱家套餐取消，并退还现有有线电视MODEM、机顶盒，或智能终端。"+"|";
					note_info1 += "2、爱家套餐取消，如宽带已竣工、初装费不退还。"+"|";
					note_info1 += "3、爱家套餐办理当月不能取消；如超过套餐正常计费2个月，套餐取消需收取套餐月使用费的30%作为违约金。"+"|";
					note_info1 += "4、爱家套餐取消后，次月1日凌晨关停宽带和有线电视功能。"+"|";
		
					note_info1 += "温馨提示："+"|";
					note_info1 += "1、请在每月20日前，确认您手机预存款金额扣除本月未出帐话费后，仍大于次月爱家套餐月使用费；否则，请及时缴费以免次月您的有线电视服务功能将可能关停。"+"|";
					note_info1 += "2、请在您资费合约到期前，及时办理爱家套餐续签业务。"+"|";
					note_info1 += "退订时需返还元申广电高清机顶盒及高清服务卡，并停止高清服务。"+"|";
				<%}else if(familyCode.equals("JHJT")) {%>
					note_info1 += "和家庭计划融合套餐，是一种基于家庭群组的流量、语音和宽带多功能共享业务。副卡客户可以共享主卡客户套餐内所有流量；主卡客户和副客户卡每月可独立享受本地主叫成员间通话时长300分钟。" + "|";
					note_info1 += "注意事项：" + "|";
					note_info1 += "1、主卡号码取消和家庭计划融合套餐群组之后，自次月起不再享受和家庭计划融合套餐优惠服务，并自动解除与所有副卡成员号码的共享关系。" + "|";
				<%}else if(familyCode.equals("ZHJT")) {%>
					note_info1 += "注意事项：" + "|";
				  note_info1 += "1、魔百和融合套餐取消，如宽带已竣工、初装费不退还。"+"|";
					note_info1 += "2、如超过套餐正常计费开始调整改为如家庭关系生效超过两个月，家庭解散需收取套餐月使用费的30%。"+"|";
					var TermFeeHidd = Number($.trim($("#TermFeeHidd").val()));
					if(TermFeeHidd == "200"){
						note_info1 += "3、由于初次办理和家庭-魔百和融合套餐家庭生效关系生效小于6个月，则需收魔百和终端费200元。"+"|";
					}else if(TermFeeHidd == "100"){
						note_info1 += "3、由于初次办理和家庭-魔百和融合套餐家庭生效关系生效超过6个月并小于12个月，则需收魔百和终端费100元。"+"|";
					}
					
					note_info1 += "4、融合套餐取消后，次月1日凌晨关停宽带功能和魔百和视频功能。"+"|";
					/*
					note_info1 += "温馨提示："+"|";
					note_info1 += "请在您资费合约到期前，及时办理爱家庭融合套餐续签业务。"+"|";
					*/
				<%}%>
			}
			note_info1 += note_info1_temp;
			//note_info1 += "注意事项：" + "|";
			//note_info1 += getNote();
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		
		/*2016/8/23 15:28:50 gaopeng 目前是专为ZSLL的免填单内容*/
		function printInfo44(opcode){
			var other_member_Id = '';  //其他成员
			var main_Id = '';  //家长
			if("<%=familyCode%>" == "ZSLL"){

				other_member_Id = "70054";
				main_Id = "70053";
			}
			
			var offerName = ''; //指定资费名称
			var offerComment = '';//指定资费描述
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);//
			var mainStr = getPhoneNoByMemberId(main_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //系统资费名称
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //系统资费描述
			var minorOfferNameVal = $("#minorOfferName").val(); //其他成员资费名称
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//其他成员资费描述
			var chengyuanzifei11=$("#chengyuanzifei11").val();
			var chengyuanzifeimiaoshu11=$("#chengyuanzifeimiaoshu11").val();
			var chengyuanzifei22=$("#chengyuanzifei22").val();
			var chengyuanzifeimiaoshu22=$("#chengyuanzifeimiaoshu22").val();
				
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			
			/************客户信息************/
			cust_info += "手机号码：" + $("#operPhoneNo").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			if("<%=familyCode%>" == "ZSLL" && opcode == "e284"){
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：终端专属流量共享套餐-家庭解散|";
			}
			
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			
			<% if(familyCode.equals("ZSLL")) {%>
			opr_info += "组建家庭号码：" + $("#parentPhone").val() + "|";
			opr_info += "加入家庭群组成员号码：" + otherMemberStr + "|";
			<%}%>
			
			
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e284' : 
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(opcode=="e284") {
				if(offerName.length > 0){
					opr_info += "解散后资费：" + offerName + "|";
				}
				if(offerComment.length > 0){
					opr_info += "解散后资费描述：" + offerComment + "|";
				}
			}
			opr_info += opr_info_temp;
			/************备注************/
			
			/************注意事项************/
			<%if("e284".equals(opCode) ) {
			
			if(	familyCode.equals("ZSLL")){
			%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "备注：" + "|";
		  			note_info1 += "取消39元终端专属流量共享套餐后，次月变更为标准套餐，套餐内流量将不再共享给副卡客户使用。"+"|";

						
		  <%}
		  }%>
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		
		function getNote(){
			var returnStr = "";
			var opCode = "<%=opCode%>";
			var roleObj;
			var familyCode = $("#familyCode").val();
			if(familyCode == "XFJT"){
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
				}else if(opCode == "i089") {
					if ( "Y" == $("#rn_flag").val() )
					{
						returnStr += "1、办理业务冲正需缴纳一个月的宜居通业务功能费。" + "|";
					}
					
				}
			}else if(familyCode == "QWJT"){
				if(opCode == "e283"){
					returnStr += "1、成功办理退订亲情网套餐，自次月起将不再享受亲情网套餐优惠业务。" + "|";
					returnStr += "2、退出业务下月生效。" + "|";
					returnStr += "3、组建人取消亲情网业务后，所有成员不再享受业务优惠。" + "|";
				}else if(opCode == "e284"){
					returnStr += "1、移动手机号码退订亲情网套餐后，自次月起将不再享受亲情网业务优惠资费。" + "|";
					returnStr += "2、组建人取消亲情网业务后，组内亲情网业务不再享受优惠。" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}
			else if(familyCode == "TXJT"){
				if(opCode == "e283"){
					returnStr += "1、成功办理退订亲情网B套餐，自次月起将不再享受亲情网B套餐优惠业务。" + "|";
					returnStr += "2、退出业务下月生效。" + "|";
					returnStr += "3、组建人取消亲情网B业务后，所有成员不再享受业务优惠。" + "|";
				}else if(opCode == "e284"){
					returnStr += "1、移动手机号码退订亲情网B套餐后，自次月起将不再享受亲情网B业务优惠资费。" + "|";
					returnStr += "2、组建人取消亲情网B业务后，组内亲情网B业务不再享受优惠。" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}
			else if(familyCode == "TSJT"){
				if(opCode == "e283"){
					returnStr += "1、成功办理退订亲情网C套餐，自次月起将不再享受亲情网C套餐优惠业务。" + "|";
					returnStr += "2、退出业务下月生效。" + "|";
					returnStr += "3、组建人取消亲情网C业务后，所有成员不再享受业务优惠。" + "|";
				}else if(opCode == "e284"){
					returnStr += "1、移动手机号码退订亲情网C套餐后，自次月起将不再享受亲情网C业务优惠资费。" + "|";
					returnStr += "2、组建人取消亲情网C业务后，组内亲情网C业务不再享受优惠。" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}	
			else if(familyCode == "PYJT"){
				if(opCode == "e283"){
					returnStr += "1、成功办理退订亲情网A套餐，自次月起将不再享受亲情网A套餐优惠业务。" + "|";
					returnStr += "2、退出业务下月生效。" + "|";
					returnStr += "3、组建人取消亲情网A业务后，所有成员不再享受业务优惠。" + "|";
				}else if(opCode == "e284"){
					returnStr += "1、移动手机号码退订亲情网A套餐后，自次月起将不再享受亲情网A业务优惠资费。" + "|";
					returnStr += "2、组建人取消亲情网A业务后，组内亲情网A业务不再享受优惠。" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}					
			else if(familyCode == "ZDGX"){
				if(opCode == "e283"){
					returnStr += "1、成功办理亲情流量共享成员退出的副卡客户，自次月起不再享受主卡客户的流量共享；" + "|";
					returnStr += "2、解除业务次月生效。" + "|";
				}else if(opCode == "e284"){
					returnStr += "1、主卡号码取消亲情流量共享组业务后，自次月起不再享受亲情流量共享优惠服务，并自动解除与所有副卡成员号码的共享关系。" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}
			/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
			else if(familyCode == "JTGX"){
				if(opCode == "e283"){
					returnStr += "1、成功办理4G家庭共享套餐成员退出的副卡客户，自次月起不再享受主卡客户的流量共享、群组内本地通话免费时长500分钟和中国内地WLAN免费流量（50G封顶）资源；" + "|";
					returnStr += "2、解除业务次月生效。" + "|";
				}else if(opCode == "e284"){
					returnStr += "1、主卡号码取消4G家庭共享套餐群组之后，自次月起不再享受4G家庭共享套餐优惠服务，并自动解除与所有副卡成员号码的共享关系。" + "|";
				}
			}
			/* end add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
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
			familyRoleList.setProd_code($("#familyProdInfo").val());
			familyRoleList.setFamily_code("<%=familyCode%>");
			if("<%=opCode%>" == "e284" || "<%=opCode%>" == "e285" || "<%=opCode%>" == "i089"){
				var spInfo = $.trim($('#familyProdInfo').find("option:selected").attr('sp_info'));
				familyRoleList.setSpInfo(spInfo);
			}
			
			if(("<%=familyCode%>"=="HEJT"  || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" ) && "<%=opCode%>"=="e284"){//和家庭，家庭解散
				familyRoleList.setFault_Fee($("#faultFeeHidd").val());//违约金
			}
			if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e284"){//组合家庭，家庭解散
				familyRoleList.setZd_Fault_Fee($("#TermFeeHidd").val());//终端违约金
				familyRoleList.setFault_Fee($("#faultFeeHidd").val());//违约金
			}
			
			var checkObj = $("input[name='delMember']");
			var famRole = new FamRole();
			var business = new Business();
			var rowNum = "";
			$.each(checkObj,function(i,n){
				if($(n).attr("checked") != undefined){
				
							<%if(familyCode.equals("KDJT") && "e284".equals(opCode)) {%>	
							    var flsgtype="0";
							    
							    rowNum = n.id.substr(10,11);									
									var memberRoleIdVal = $("#memberRoleId_"+rowNum).val();
									var phoneNoVal = $("#phoneNo_"+rowNum).val();
									var familyRoleVal = $("#familyRole_"+rowNum).val();
									var memberRoleNameVal = $("#memberRoleName_"+rowNum).val();
									var payTypeVal = $("#payType_"+rowNum).val();
									
									 if("<%=opCode%>" == "e284"){
										//if(familsyinfos=="1006") {//如果号码中有已经办理过退出的号码，则不在json串中拼此号码--wanghyd
													var sflags="0";	
												for(var is=0;is<quitphoneArray.length;is++){
								         			if(quitphoneArray[is]==(phoneNoVal+""+memberRoleIdVal)) {
								         				sflags="1";
								         				continue;
								         			}
								          }
												
												 if(sflags=="1") {
												 return true;
												 }else {
												 }
												// }
												}
									
										for(var imm = 0; imm < famBusiArray.length; imm++){
											if(famBusiArray[imm][3] == phoneNoVal){
														//alert("有号码"+phoneNoVal);
														flsgtype="1";
														break;
											}
											else {
											      //alert("没有号码");
											      flsgtype="0";
											}
											}		
							if(flsgtype=="1") {
									famRole = new FamRole();
									famRole.setPhone(phoneNoVal);
									famRole.setRoleId(familyRoleVal);
									famRole.setRoleName(memberRoleNameVal);
									famRole.setMembId(memberRoleIdVal);
									famRole.setPay_type(payTypeVal);
									/* 在这里需要拼接business对象 */
									famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
									
									familyRoleList.addFamRole(famRole);
							}
					<%}else {%>
									rowNum = n.id.substr(10,11);
									famRole = new FamRole();
									var memberRoleIdVal = $("#memberRoleId_"+rowNum).val();
									var phoneNoVal = $("#phoneNo_"+rowNum).val();
									var familyRoleVal = $("#familyRole_"+rowNum).val();
									var memberRoleNameVal = $("#memberRoleName_"+rowNum).val();
									var payTypeVal = $("#payType_"+rowNum).val();
									if("<%=opCode%>" == "e284"){
									var familsyinfos  = $("#familyProdInfo").val();
									
									//if(familsyinfos=="1006") {//如果号码中有已经办理过退出的号码，则不在json串中拼此号码--wanghyd
													var sflags="0";	
												for(var is=0;is<quitphoneArray.length;is++){
								         			if(quitphoneArray[is]==(phoneNoVal+""+memberRoleIdVal)) {
								         				sflags="1";
								         				continue;
								         			}
								          }
												
												 if(sflags=="1") {
												 return true;
												 }else {
												 }
												// }
											}	
									famRole.setPhone(phoneNoVal);
									famRole.setRoleId(familyRoleVal);
									famRole.setRoleName(memberRoleNameVal);
									famRole.setMembId(memberRoleIdVal);
									famRole.setPay_type(payTypeVal);
									/* 在这里需要拼接business对象 */
									famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
									
									/*ZSLL时，70054成员不拼json串*/
									if("<%=familyCode%>" == "ZSLL" && memberRoleIdVal=="70054" && "<%=opCode%>" == "e284"){
										
									}else{
										familyRoleList.addFamRole(famRole);
									}
									
				<%}%>
				}
			});
			<%if((familyCode.equals("KDJT") || familyCode.equals("RHJT")) && "e284".equals(opCode)) {%>	
			familyRoleList.setPay_money($("#machFee").val());
			<%}else if(familyCode.equals("XFJT") && "e285".equals(opCode)){%>
			  familyRoleList.setPay_money($("#baseFeeHidd2").val());
			<%}else if(familyCode.equals("RHJT") && "e285".equals(opCode)){%>
				familyRoleList.setPay_money($("#machFee").val());
			<%}else {%>
			familyRoleList.setPay_money($("#prepayFeeHide").val());
			<%}%>
			/* add 家庭共享 新增主卡/副卡办理业务标识 默认1 for 关于4G家庭共享套餐业务支撑系统改造的通知@2014/11/25  */
			<%if(familyCode.equals("JTGX")){ //家庭共享 %>
				<%
					if("e283".equals(opCode)){ //成员退出 
						if(selfFlag){ //家长办理业务传1 
				%>
							familyRoleList.setBusi_status("1");
				<%
						}else{  //成员办理业务传2
				%>
							familyRoleList.setBusi_status("2");
				<%	
						}				
				%>
						
				<%}else if("e284".equals(opCode)){ //家庭解散 %>
						familyRoleList.setBusi_status("1");
				<%}%>
			<%}%>
			var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});
			$("#myJSONText").val(myJSONText);
			//alert($("#myJSONText").val());
		}
		
		function createBusiness(famRole,phoneNo,memberRoleId,familyRole,payType){
			//alert("createBusiness famBusiArray.length = "+famBusiArray.length);
			var business = new Business();
			var chesdfes ="";
			
			for(var i = 0; i < famBusiArray.length; i++){
				if("<%=opCode%>" == "e283" && i == (famBusiArray.length-1)) {
					$("#minorOfferName").val(famBusiArray[i][9]);
					$("#minorOfferComment").val(famBusiArray[i][10]);
				}
				/*2016/1/20 14:23:33 gaopeng 家庭解散 获取解散后主资费名称和描述*/
				<%if((familyCode.equals("KDJT") || familyCode.equals("RHJT") || familyCode.equals("JHJT")|| familyCode.equals("ZSLL")) && opCode.equals("e284")) {%>
							if(famBusiArray[i][4] == "MO"){
							if(famBusiArray[i][0]=="70009" || famBusiArray[i][0]=="50001" || famBusiArray[i][0]=="70050"|| famBusiArray[i][0]=="70053") {
							//alert(famBusiArray[i][9]+"==="+famBusiArray[i][10]);
							$("#mainOfferName").val(famBusiArray[i][9]);
							$("#mainOfferComment").val(famBusiArray[i][10]);
							}
							}
				<%}%>
				<%if((familyCode.equals("KDJT") || familyCode.equals("RHJT")) && opCode.equals("e283")) {%>
							if(famBusiArray[i][3] == phoneNo){
								if(famBusiArray[i][0]=="70011" || famBusiArray[i][0]=="50003") {
								if(chesdfes=="") {
	
								$("#chengyuanzifeimiaoshu11").val(famBusiArray[i][10]);
								$("#chengyuanzifei11").val(famBusiArray[i][9]);
								}
								if(chesdfes!="") {
	
								$("#chengyuanzifeimiaoshu22").val(famBusiArray[i][10]);
								$("#chengyuanzifei22").val(famBusiArray[i][9]);
								}
								chesdfes =famBusiArray[i][8];
							}
							}
			   
				<%}%>
				/*
				alert("famBusiArray[i][3] = "+famBusiArray[i][3]+"\nphoneNo = "+phoneNo);
				*/
				if(famBusiArray[i][3] == phoneNo){
					business = new Business();
					business.setBusitype(famBusiArray[i][6]);
					business.setBusinessId(famBusiArray[i][5]);
					business.setOper("07");
				  <%if((familyCode.equals("KDJT") || familyCode.equals("RHJT")) && opCode.equals("e284")) {%>
				  business.setAreaCode("");
				  business.setOfferId(famBusiArray[i][8]);
				  <%}%>	
				  /*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码 start*/
				  <%if(familyCode.equals("XFJT") && opCode.equals("e284")) {%>
				  	if(famBusiArray[i][4] == "MO"){
					  	if(typeof($("#newAttrIds").val()) == "undefined"){
				  			business.setAreaCode("");
					  		business.setOfferId(famBusiArray[i][8]);
				  		}else{
				  			business.setAreaCode($("#newAttrIds").val()+"");
					  		business.setOfferId(famBusiArray[i][8]);
				  		}
				  	}else{
				  		business.setAreaCode("");
					  	business.setOfferId(famBusiArray[i][8]);
				  	}
					    
				  <%}%>	
				  /*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码 start*/
					if("<%=opCode%>" == "e284" && famBusiArray[i][0] == "70001"){
						$("#prepayFeeHide").val($("#machFee").val());
						business.setMach_fee($("#machFee").val());
 			   	}
 			   		<%
 			   	if("e284".equals(opCode)){
 			   		if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) { %>
						$("#minorOfferName").val(famBusiArray[i][9]);
						$("#minorOfferComment").val(famBusiArray[i][10]);
						<%
						/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
						}else if(familyCode.equals("JTGX")){%>
							if(famBusiArray[i][8] == "47218"){
								$("#mainOfferName").val(famBusiArray[i][9]);
								$("#mainOfferComment").val(famBusiArray[i][10]);
							}
						<%
						}
					}
					if("e283".equals(opCode)){
						if(familyCode.equals("JTGX")){%>
							var v_offerComment = famBusiArray[i][9] +"|"+ famBusiArray[i][10];
							$("#minorOfferName").val(famBusiArray[i][9]);
							$("#minorOfferComment").val(v_offerComment);
						<%
						}
					}
					%>
					/* end add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
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
					
					//alert("business = "+business);
					famRole.addBusiness(business);
				}
			}
			return famRole;
		}
		function doSetPrepayfee(packet){
			var retcode = packet.data.findValueByName("retcode");
			var prepayFee = packet.data.findValueByName("prepayFee");
			var machineFee = packet.data.findValueByName("machineFee");//购机款
			$("#homeEasyHide").val("1");
			$("#prepayFeeHide").val(prepayFee);
			$("#baseFeeHidd2").val(machineFee);
		}
		function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			var offerName = packet.data.findValueByName("offerName"); //指定资费名称
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
			core.ajax.sendPacket(msgPacket, doFamBusiMsgBack);
		}
		function doFamBusiMsgBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			//alert(result);
			
			if(retCode != "000000"){
				rdShowMessageDialog("没有查询到家庭角色业务信息" + retCode + retMsg);
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			}else{
				famBusiArray = result;
				
				//alert("result famBusiArray = "+famBusiArray);
			/*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码  循环服务返回的参数 如果是XFJT 同时是主资费 进行循环 判断是否展示小区代码下拉列表 start*/
				if("<%=familyCode%>" == "XFJT" && "<%=opCode%>"== "e284"){
					for(var i = 0; i < famBusiArray.length; i++){
						if(famBusiArray[i][4] == "MO"){
							
							var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","请稍后...");
				      packet.data.add("offerId",famBusiArray[i][8]);
				      packet.data.add("sum","2");
				      packet.data.add("phoneNo","");
				      packet.data.add("opCode","<%=opCode%>");
				      core.ajax.sendPacket(packet,doJdugeAreaHidden);
				      packet =null;	
				  			
				  	}
					}
				
				}
				/*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码  循环服务返回的参数 如果是XFJT 同时是主资费 进行循环 判断是否展示小区代码下拉列表 start*/
			}
		}
		/*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码  循环服务返回的参数 如果是XFJT 同时是主资费 进行循环 判断是否展示小区代码下拉列表 start*/
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
    		return false;
    	}
    }
    	function getOfferAttr(offer_id,sum){
      if(v_hiddenFlag=="Y"){ //当为Y时，进入新版小区代码展示页面
        var packet1 = new AJAXPacket("getOfferAttrNew.jsp","请稍后...");
        packet1.data.add("v_code" ,v_code);
        packet1.data.add("v_text" ,v_text);
        packet1.data.add("OfferId" ,offer_id);
        core.ajax.sendPacketHtml(packet1,doGetOfferAttr);
        packet1 =null;
      }
    }
    
    function doGetOfferAttr(data){
      $("#OfferAttribute").html("");
      $("#OfferAttribute").append(data);
    }
    /*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码  循环服务返回的参数 如果是XFJT 同时是主资费 进行循环 判断是否展示小区代码下拉列表 start*/
		
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
			if ( $("#opCode").val()=='i089' )
			{
				 $("#confirm").attr( "disabled" , false ) ;
			}
			var prodCode = "<%=prodCode%>";
			$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
			$("#familyProdInfo").attr("disabled","true")
			
			ctrlfamilyMemberList();
			getFamBusiMsg();
			var opCodeVal = "<%=opCode%>";
			if(opCodeVal == "e284"){
				setLastTDHide();
				<% if(familyCode.equals("QQSY") || familyCode.equals("QQWY") || familyCode.equals("KDJT")
							|| familyCode.equals("QWJT") || familyCode.equals("TXJT") || familyCode.equals("TSJT") || familyCode.equals("PYJT")
							|| familyCode.equals("ZDGX")||familyCode.equals("RHJT")||familyCode.equals("JHJT")||familyCode.equals("ZSLL")) {%>			
			  
			  <%}else {%>
			  	$("#machFeeTab").show();
			  <%}%>
			  <%if(familyCode.equals("HEJT")  || familyCode.equals("HJTA") || familyCode.equals("HJTB")){%>
			  		$("#faultFeeHiddTr").show();
			  <%}%>
			  <%if(familyCode.equals("ZHJT")){%>
			  		$("#machFee").val("0");
			  		$("#machFee").attr("class","InputGrey");
			  		$("#machFee").attr("readonly","readonly");
			  		$("#TermFeeHiddTr").show();
			  		$("#faultFeeHiddTr").show();
			  <%}%>
			  <%if(familyCode.equals("JTGX")){%>
			  	$("#machFeeTr").hide();
			  <%}%>
			}
			if(opCodeVal == "e285"){
				setLastTDHide();
				<%if(familyCode.equals("RHJT")){%>
					$("#machFeeTab").show();
			<%}%>
			}
			<%if(familyCode.equals("KDJT")) {%>	
					var familsyinfo  = $("#familyProdInfo").val();
	     		if(familsyinfo=="1022"||familsyinfo=="1023"|| familsyinfo=="1024"|| familsyinfo=="1025") {
		     		$("input[id^='memRoleId_']").each(function(i,n){
	        		/*全球通家庭资费普通成员 数量非得绑定在产品上*/
	        		if($(this).val() == "70011"){
	        			$(this).parent().parent().find("td:eq(1)").text("2");
	        		}
	        	});
	     		}
			<%}%>
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo","<%=operPhoneNo%>");
			getdataPacket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack);
			getdataPacket = null;
			
			//liuijan add 已经退出的成员不可以再次被选择
			$('.delete_memeber_70004_1').attr("disabled","true");
			
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e284"){//和家庭，家庭解散
				var msgPacket = new AJAXPacket("fe280_ajax_chkFamUpd.jsp","正在获取数据，请稍候......");
				msgPacket.data.add("printAccept","<%=printAccept%>");
				msgPacket.data.add("phoneNo","<%=parentPhone%>");
				msgPacket.data.add("opCode","<%=opCode%>");
				msgPacket.data.add("prodCode","<%=prodCode%>");
				msgPacket.data.add("prodCodeNew","");//下一档产品代码
				msgPacket.data.add("famCode","<%=familyCode%>");
				core.ajax.sendPacket(msgPacket, function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var innetFee = packet.data.findValueByName("innetFee");//初装费
					var innetrate = packet.data.findValueByName("innetrate");
					var innetRateFee = packet.data.findValueByName("innetRateFee");
					var innetFeeLeft = packet.data.findValueByName("innetFeeLeft");
					var faultFee = packet.data.findValueByName("faultFee");//违约金
					var TermFee = packet.data.findValueByName("TermFee");//终端违约金
					if(retCode != "000000"){
						rdShowMessageDialog("校验和获取家庭解散相关信息失败！<br>" + retCode+"<br>"+ retMsg,0);
						removeCurrentTab();
					}else{
						$("#innetFeeHidd").val(innetFee);
						$("#innetrateHidd").val(innetrate);
						$("#innetRateFeeHidd").val(innetRateFee);
						$("#innetFeeLeftHidd").val(innetFeeLeft);
						$("#faultFeeHidd").val(faultFee);		
						$("#TermFeeHidd").val(TermFee);				
					}
				});
				msgPacket = null;
		  }
		});
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
			<%
			if ( !"i089".equals(opCode) )
			{
			%>
				<th>操作</th>
			<%
			}
			%>
			
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
						quitphoneArray["<%=sint%>"]="<%=familyMemberList[i][3]%><%=familyMemberList[i][0]%>";
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
			System.out.println("gaopengSeeLog==========fe280Quit.jsp=======editSts="+editSts);
			if ( !"i089".equals(opCode) )
			{
			
			if(editSts != null && editSts != "" && editSts.equals("1")) {
	%>

			<td>
				<input type="checkbox" name="delMember" id="delMember_<%=i%>" class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
				  onclick="deleteMember(<%=i%>,this)" value="<%=familyMemberList[i][0]%>" disabled/>
			</td>
	<%			
			}else {
%>			<td>
				<input type="checkbox" name="delMember" id="delMember_<%=i%>" class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
				  onclick="deleteMember(<%=i%>,this)" value="<%=familyMemberList[i][0]%>" <%if(familyCode.equals("KDJT") || familyCode.equals("RHJT")) {if(familyMemberList[i][0].equals("70012") || familyMemberList[i][0].equals("50002")){out.print("disabled");}}%>/>
			</td>
			<%			
			}

		}
	else
		{
		%>
		<input type="checkbox" name="delMember" id="delMember_<%=i%>" 
	class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
	onclick="deleteMember(<%=i%>,this)" checked style = "display:none"
	value="<%=familyMemberList[i][0]%>" disabled/>	
		<%}
		%>
		</tr>
		<%
				}
			}
		%> 
	</table>
	<table id="machFeeTab" style="display:none;">
		<tr id="machFeeTr">
			<td class="blue" width="10%">补收款</td>
			<td>
				<input type="text" id="machFee" name="machFee" v_type="money" v_must="1" />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr id="faultFeeHiddTr" style="display:none;">
			<td class="blue" width="10%">违约金</td>
			<td>
				<input type="text" id="faultFeeHidd" name="faultFeeHidd" v_must="1" value="" class="InputGrey" readonly />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr id="TermFeeHiddTr" style="display:none;">
			<td class="blue" width="10%">终端违约金</td>
			<td>
				<input type="text" id="TermFeeHidd" name="TermFeeHidd" v_must="1" value="" class="InputGrey" readonly />
				<font class="orange">*</font>
			</td>
		</tr>
		<!-- /*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码  循环服务返回的参数 如果是XFJT 同时是主资费 进行循环 判断是否展示小区代码下拉列表 start*/ -->
		<tr id="OfferAttribute" ></tr><!--小区代码-->
		<!-- /*2014/02/28 16:18:49 gaopeng 幸福与家庭解散加入主资费对应的小区代码  循环服务返回的参数 如果是XFJT 同时是主资费 进行循环 判断是否展示小区代码下拉列表 end*/ -->
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
	<input type="hidden" name="minorOfferComment" id="minorOfferComment" value="" />
	<input type="hidden" name="familyName" id="familyName" value="<%=familyName%>" />
	<input type="hidden" name="smName" id="smName" />
	<input type="hidden" name="printName" id="printName" value="<%=printName%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" name="mainOfferName" id="mainOfferName" value="" />
	<input type="hidden" name="minorOfferName" id="minorOfferName" value="" />
	<input type="hidden" name="famlicodes" id="famlicodes" value="<%=familyCode%>" />
	<input type="hidden" name="familyCode" id="familyCode" value="<%=familyCode%>" />
	<input type="hidden" name="familyName" id="familyName" value="<%=familyName%>" />
	<input type="hidden" name="pubPrtOfferId" id="pubPrtOfferId" value="" />
	<input type="hidden" name="pubPrtOfferName" id="pubPrtOfferName" value="" />
	<input type="hidden" name="pubPrtOfferComments" id="pubPrtOfferComments" value="" />
	<input type="hidden" name="chengyuanzifei11" id="chengyuanzifei11"  />
	<input type="hidden" name="chengyuanzifeimiaoshu11" id="chengyuanzifeimiaoshu11"  />
	<input type="hidden" name="chengyuanzifei22" id="chengyuanzifei22"  />
	<input type="hidden" name="chengyuanzifeimiaoshu22" id="chengyuanzifeimiaoshu22"  />
	<input type="hidden" name="rn_flag" id="rn_flag" value = '<%=rn_flag%>' />
	
	<input type="hidden" name="baseFeeHidd2" id="baseFeeHidd2" value=""  />
	
	<input type="hidden" name="innetFeeHidd" id="innetFeeHidd" value="" />
	<input type="hidden" name="innetrateHidd" id="innetrateHidd" value="" />
	<input type="hidden" name="innetRateFeeHidd" id="innetRateFeeHidd" value="" />
	<input type="hidden" name="innetFeeLeftHidd" id="innetFeeLeftHidd" value="" />
	
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
