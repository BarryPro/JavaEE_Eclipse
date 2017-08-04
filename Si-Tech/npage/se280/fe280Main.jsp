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
 		String printName2 = "";
 		String offerids="";
 		String offernames="";
 		String offercoments="";
 		String printOpName = "";
 		String v_membRoleId = ""; //宽带成员号码
 		if(familyCode.equals("HEJT") ){
 			if("e281".equals(opCode)){
 				printName2 = "和家庭-爱家套餐创建家庭";
 			}else if("e282".equals(opCode)){
 				printName2 = "和家庭-爱家套餐成员加入";
 			}else if("i088".equals(opCode)){
 				printName2 = "和家庭-爱家套餐家庭续签";
 			}
 		}
 		if( familyCode.equals("JHJT")){
 			if("e281".equals(opCode)){
 				printName2 = "和家庭计划(MoneyFee)--和家庭计划融合套餐共享群组创建";
 			}else if("e282".equals(opCode)){
 				printName2 = "和家庭-计划融合套餐成员加入";
 			}else if("i088".equals(opCode)){
 				printName2 = "和家庭-计划融合套餐家庭续签";
 			}
 		}
 		if(familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 			if("e281".equals(opCode)){
 				printName2 = "和家庭-融合套餐创建家庭";
 			}else if("e282".equals(opCode)){
 				printName2 = "和家庭-融合套餐成员加入";
 			}else if("i088".equals(opCode)){
 				printName2 = "和家庭-融合套餐家庭续签";
 			}
 		}
 		
 		if(familyCode.equals("ZHJT")){
 			if("e281".equals(opCode)){
 				printName2 = "和家庭-魔百和融合套餐创建";
 			}else if("e282".equals(opCode)){
 				printName2 = "和家庭-组合套餐成员加入";
 			}else if("i088".equals(opCode)){
 				printName2 = "和家庭-组合套餐家庭续签";
 			}
 		}
 		
 		String TVCardNo = request.getParameter("TVCardNo");//广电电视卡号：HEJT+家庭创建e281时，传入并拼接到json中
 		
		String v_case = "2";
 		if("i088".equals(opCode)){ //家庭续签
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){
 				v_case = "9";
 			}
 		} 		

 		/*gaopeng 区分宽带家庭和融合家庭的免填单打印头部展示。2014/01/15 16:46:18*/
 		if(familyCode.equals("KDJT")){
 			printOpName = "宽带家庭";
 		}else if(familyCode.equals("RHJT")){
 			printOpName = "融合家庭";
 		}
 		if("e281".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组申请";
 			}
 			else if(familyCode.equals("KDJT") ){
 			printName = "全球通家庭资费创建家庭";
 			}
 			else if("RHJT".equals(familyCode)){
 			printName = "融合家庭资费创建家庭";
 			}
 		  else {
 			printName = "幸福家庭签约送礼";
 			}
 		}else if("e282".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "申请加入亲情畅聊组";
 			}
 			else if(familyCode.equals("KDJT") ){
 			printName = "全球通家庭资费成员加入";
 			}
 			else if("RHJT".equals(familyCode)){
 			printName = "融合家庭资费成员加入";
 			}
 			else {
 			printName = "幸福家庭成员业务订购";
 			}
 		}else if("e283".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "申请退出亲情畅组";
 			}
 		}else if("i088".equals(opCode)){
 			printName = "幸福家庭续签";
 		
 		}else if("e284".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组取消";
 			}
 		}else if("e285".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "亲情畅聊组冲正";
 			}
 		}
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
	String renewType = "";		
%>
	<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
		retmsg="msg0" retcode="code0" outnum="9">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=parentPhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=v_case%>"/>
		<wtc:param value="<%=familyCode%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
<%
	for ( int i = 0 ; i < result0.length ; i++ )
	{
		for ( int j= 0 ; j< result0[i].length; j++ )
		{
			System.out.println("zhangyan~1~~~~~~~~~~~~~~~~~result["+i+"]["+j+"]"+result0[i][j]);
		}
	}

	if(!code0.equals("000000")){
	
		System.out.println("----- fe280Main.jsp ---- 查询出错" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code0%>" + "<%=msg0%>");
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			</script>
<%
	}else{
		if(result0.length > 0){
			renewType = result0[0][7];
		}
	}
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	String exp_time = ""; 
	if(opCode.equals("e282") || opCode.equals( "i088" ) ){
		/* 成员加入 需要调用服务查询家庭已有成员信息 */
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg1" retcode="code1" outnum="30">
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

	System.out.println( "result1.length====" + result1.length );
	for ( int i = 0 ; i < result1.length ; i++ )
	{
		for ( int j= 0 ; j< result1[i].length; j++ )
		{
			System.out.println("zhangyan~~~~~~~~~~~~~~~~~~result["+i+"]["+j+"]"+result1[i][j]);
		}
	}

		System.out.println("========== ningtn ====" + code1 + " | " + result1.length);
		if("000000".equals(code1)){
			
			familyMemberList = result1;
			
			for(int i = 0; i < familyMemberList.length; i++){
				if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
					exp_time = familyMemberList[i][5];
					
					exp_time= exp_time.substring(0,4) +"年"
						+ exp_time.substring(5,6)+"月"
						+ exp_time.substring(7,8)+"日";
				}else{
					if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode)) && "i088".equals(opCode)){
						if("70025".equals(familyMemberList[i][0]) || "70028".equals(familyMemberList[i][0]) || "70031".equals(familyMemberList[i][0]) || "70052".equals(familyMemberList[i][0])){
							v_membRoleId = familyMemberList[i][3];
						}
					}
				}
			}
						if("e281".equals(opCode) || "e282".equals(opCode)){/*查询成员资费--仅限亲情畅聊3元和5元两种资费*/
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
			/*alert("<%=opCode%>");*/
			if ( $("#opCode").val()=="i088" )
			{
				if ( "N" == $("#renewType").val() )
				{
					if ( <%=familyMemberList.length%>!=familyRoleList.length )
					{
						rdShowMessageDialog( "必须续签全部家庭成员！",0 );
						return false;
					}						
				}
				if($("#familyProdInfo").val() == ""){
					rdShowMessageDialog( "请选择家庭产品信息!",0 );
					return false;
				}
			}	
      <%if( (familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e281".equals(opCode)) {%>			
          var familsyinfo  = $("#familyProdInfo").val();
          var kuandai  = $("#kuandai").val();

          if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"
          	||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {		     											
            var kdchecknum = $("#smzvalue").val();
            if(kdchecknum=="0") {
              rdShowMessageDialog("请添加“<%=printOpName%>宽带成员”！");
              return false;
            }
          }
          if(familsyinfo=="1020"||familsyinfo=="1021"||familsyinfo=="1026"||familsyinfo=="1027"){
            if($("#miantiandankuandai").val()==""){
              rdShowMessageDialog("请添加“<%=printOpName%>宽带成员”！");
              return false;
            }
          }
			<%}%>
			/* 按钮延迟 */
			$(subButton).attr("disabled","true");
			/* 事后提醒 */
			getAfterPrompt();		
			familyRoleList = changeObjSeq(familyRoleList);
			familyRoleList.setCreate_accept("<%=printAccept%>");
			familyRoleList.setChnsource("01");
			familyRoleList.setopCode("<%=opCode%>");
			familyRoleList.setLoginNo("<%=work_no%>");
			familyRoleList.setPassword("<%=password%>");
			familyRoleList.setPhone_no_master("<%=parentPhone%>")
			familyRoleList.setOp_note("<%=work_no%>" + "做" + "<%=opName%>" + "操作");
			familyRoleList.setProd_code($("#familyProdInfo").val());
			
			familyRoleList.setFamily_code("<%=familyCode%>");
			<%if("XFJT".equals(familyCode)&&"e281".equals(opCode)) {%>
			  familyRoleList.setPay_money($("#baseFeeHidd2").val());
		  <%}else{%>
		    familyRoleList.setPay_money($("#prepayFeeHide").val());
		  <%}%>
			var spInfo = $.trim($('#familyProdInfo').find("option:selected").attr('sp_info'));
			familyRoleList.setSpInfo(spInfo);
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="i088"){//和家庭，家庭续签
				familyRoleList.setInnet_Fee($("#innetFeeHidd").val());//初装费
			}
			if(("<%=familyCode%>"=="ZSLL" ) && "<%=opCode%>"=="e281"){//ZSLL
				familyRoleList.setImei_code($.trim($("#ZSLLImei").val()));//IMEI号码
			}
			/* add 新增广电电视卡号 for 关于协助实现BOSS与龙江广电计费对接方案的需求@2014/11/25  */
			if(("<%=familyCode%>"=="HEJT" ) && "<%=opCode%>"=="e281"){
				familyRoleList.setTv_no($("#TVCardNoHidd").val());//广电电视卡号
			}
			/* add 家庭共享 新增主卡/副卡办理业务标识 默认1 for 关于4G家庭共享套餐业务支撑系统改造的通知@2014/11/25  */
			if("<%=familyCode%>"=="JTGX" && ("<%=opCode%>"=="e281" || "<%=opCode%>"=="e282")){
				familyRoleList.setBusi_status("1");
			}
			if("<%=familyCode%>"=="ZHJT"  && "<%=opCode%>"=="i088"){//组合家庭,家庭续签 
				familyRoleList.setAutoCancel($("#autoCancel2").val());//到期是否自动取消
			}
			
			var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});

	
				//alert("以下是json串：---------"+myJSONText);
			//var submitstr = myJSONText.replace(/\"/g,"");
			$("#myJSONText").val(myJSONText);
			getPrintInfo();
			<%if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {%>
			printCommit11('<%=opCode%>');
			<%}else if(familyCode.equals("KDJT") || "RHJT".equals(familyCode) ){%>
			printCommit22('<%=opCode%>');
			<%}else if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){%>
			printCommit33('<%=opCode%>');
		  <%}else if(familyCode.equals("ZSLL")){
		  	%>
		  printCommit44('<%=opCode%>');
		  	<%
		  }else {%>
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
			getdataPacket.data.add("queryType","7");
			
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
		function printInfo11(opcode){
			/*liujian  区别各个角色的成员Id*/
			var parent_member_Id = '70001'; //宜居通家长
			var normal_member_Id = '70002'; //普通成员
			var other_member_Id = '70004';  //其他成员
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
			var parentphonenum="";
			
			
			/************客户信息************/
			cust_info += "手机号码：" + $("#operPhoneNo").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：" + $("#printName").val()+"|";
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			
			if(opcode=="e281") {
			opr_info += "申请亲情畅聊的手机号码："+$("#operPhoneNo").val() + "|";

			  var table1=document.getElementById('addRoleTab');
        var rows=table1.rows;
        //alert(rows.length);
        for(var i=1;i<rows.length;i++){
        	if(rows[i].cells[1].innerHTML.indexOf("成员") !=-1 ) {
                teamPhonenum+= rows[i].cells[0].innerHTML+"，";
                }
           }
			opr_info += "加入亲情畅聊号码：" + teamPhonenum +"|";
			}
			else if(opcode=="e282") {
				var table1=document.getElementById('addRoleTab');
        var rows=table1.rows;
        //alert(rows.length);
        for(var i=1;i<rows.length;i++){
        	if(rows[i].cells[1].innerHTML.indexOf("成员") !=-1 ) {
                parentphonenum+= rows[i].cells[0].innerHTML+"，";
                }
           }
      opr_info += "组建亲情畅聊人号码："+ $("#operPhoneNo").val() + "|";
      opr_info += "本次加入家庭的可选成员手机号码：" + parentphonenum + "|";
			}
			else if(opcode=="e283") {
			opr_info += "退出亲情畅聊业务的组建人号码："+$("#operPhoneNo").val() + "|";
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
					//opr_info += "本次加入家庭的可选成员手机号码：" + otherMemberStr + "|";
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
						tempMember = normalMemberStr + "," + otherMemberStr;
					}
					opr_info += "家庭成员手机号码：" + tempMember + "|";
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
						opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
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
				  //opr_info += "指定资费：" + $("#familyProdInfo").val()+" "+$("#familyProdInfo").find("option:selected").text() + "|";
				  if(opcode=="e281") {

				    opr_info += "指定资费：" + $("#offeridss").val()+""+minorOfferNameVal + "|";
				   }
				  if(opcode=="e282") {
				    opr_info += "指定资费：" + "<%=offerids%>"+offerName + "|";
				   }

			}
			opr_info += opr_info_temp;
			/************注意事项************/
			note_info1 += "备注：" + "|";
			if(offerComment.length > 0){
				//note_info1 += "指定资费描述：" + minorOfferCommentVal + "|";
				
					if(opcode=="e281") {
				    note_info1 += "指定资费描述：" + minorOfferCommentVal + "|";
				   }
				  if(opcode=="e282") {
				    note_info1 += "指定资费描述：" + offerComment + "|";
				   }
			}
			//alert("1"+note_info1);
			note_info1 += note_info1_temp;
			//alert("2"+note_info1);
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
			//alert(note_info1);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		function printInfo33(opcode){
			var other_member_Id = '';  //其他成员
			var kd_member_Id = '';  //宽带家庭
			if("<%=familyCode%>" == "HEJT"){

				other_member_Id = "70024";
				kd_member_Id = "70025";
			}
			if("<%=familyCode%>" == "JHJT"){
				/*计划家庭 成员加入时 没有宽带家庭 不能加宽带家庭*/
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
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);//
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
			if("<%=familyCode%>" == "JHJT" && opcode == "e281"){
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务："+mainOfferNameVal+"-和家庭计划融合套餐共享群组创建|";
			}else if("<%=familyCode%>" == "JHJT" && opcode == "e282"){
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务："+minorOfferNameVal+"-增加和家庭计划融合套餐成员|";
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
			opr_info += "和家庭计划融合套餐群组主卡号码：" + $("#parentPhone").val() + "|";
			opr_info += "本次增加和家庭计划融合套餐成员号码：" + otherMemberStr + "|";
			<%}else if(familyCode.equals("ZHJT")) {%>
			opr_info += "和家庭-魔百和融合套餐家长号码：" + $("#parentPhone").val() + "|";
			<%}%>
			
			
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
				case 'e282' :
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'i088' : 
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(opcode=="e281" || opcode=="i088") {
				if(offerName.length > 0){
					opr_info += "指定资费：" + offerName + "|";
				}
				if(offerComment.length > 0){
					opr_info += "指定资费描述：" + offerComment + "|";
				}
			}else if(opcode=="e282"){
				if(otherMemberStr != null && otherMemberStr.length > 0){
			<%
			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
			%>
			opr_info += "本次加入和家庭-融合套餐普通成员手机号码：" + otherMemberStr + "|";
		  <%}else if(familyCode.equals("HEJT") ) {%>
			opr_info += "本次加入和家庭-爱家套餐普通成员手机号码：" + otherMemberStr + "|";
			<%}else if(familyCode.equals("JHJT")) {%>
			//opr_info += "本次增加和家庭计划融合套餐成员号码：" + otherMemberStr + "|";
			<%}else if(familyCode.equals("ZHJT")) {%>
			opr_info += "本次加入和家庭-组合套餐普通成员手机号码：" + otherMemberStr + "|";
			<%}%>
						
				}	
			  opr_info += "指定资费：" + offerName + "|";			
		    opr_info += "指定资费描述：" + offerComment + "|";	
			
			}
			opr_info += opr_info_temp;
			/************备注************/
			
			/*2016/1/19 18:56:10 gaopeng e282成员添加时 打印免填单*/
			if("<%=opCode%>" == "e282"){
				if("<%=familyCode%>" == "JHJT"){
					note_info1 += note_info1_temp;
		  		note_info1 += "备注：" + "|";
		  		note_info1 += "月使用费0元。可以免费使用主卡套餐内流量。每月可享受群组内本地通话免费时长300分钟。" + "|";
		  		note_info1 += "注意事项：" + "|";	
		  		note_info1 += "1、当天入网立即生效，非当天入网，预约生效。" + "|";	
		  		note_info1 += "2、参与共享的副卡客户与主卡客户必须归属于相同地市。" + "|";	
		  		note_info1 += "3、主卡取消和家庭计划融合套餐后，次月起所有副卡客户不再享受业务优惠。" + "|";	
		  		note_info1 += "4、如果副卡套餐包含流量，副卡在使用上网流量时，优先使用副卡套餐内的流量，当副卡套餐内流量用完后再使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。如果副卡套餐不含流量，直接使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。" + "|";	
				
				}
				
			}
			/************注意事项************/
			<%if("e281".equals(opCode) || "i088".equals(opCode)) {
			
			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
			%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "注意事项：" + "|";
		  			note_info1 += "1、如成员套餐内有免费通话时长（或数据流量），首先使用成员套餐内免费通话时长（或数据流量），用完后再使用主卡家庭套餐内的共享通话时长（或流量）。共享通话时长（或流量）使用完后，主卡、成员用户分别执行各自所选套餐的超出后资费标准。"+"|";
						note_info1 += "2、融合套餐的主卡和成员号码必须归属同一个地市，主卡用户不能办理报停和预销。"+"|";
						note_info1 += "3、在合约期内，融合套餐用户不可变更为非融合套餐，或取消融合套餐。"+"|";
						note_info1 += "4、手机主卡欠费，当日关停宽带上网功能 ；用户缴费后恢复宽带功能。"+"|";
						note_info1 += "5、手机新入网用户资费立即生效，宽带以安装竣工时间为准生效，套餐按整月收取使用费；在网用户融合资费预约生效，宽带如当月竣工免费体验，手机和宽带业务次月1日生效并开始计费。"+"|";
						note_info1 += "6、融合套餐用户只能通过手机账户代缴宽带费，不能通过宽带账户单独缴费。"+"|";
						note_info1 += "7、融合套餐月使用费，按整月收取，不区分上下半月。"+"|";

						
		  <%}else if(familyCode.equals("HEJT")) {%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "注意事项：" + "|";
		  			note_info1 += "1、如成员套餐内有免费通话时长（或数据流量），首先使用成员套餐内免费通话时长（或数据流量），用完后再使用主卡家庭套餐内的共享通话时长（或流量）。共享通话时长（或流量）使用完后，主卡、成员用户分别执行各自所选套餐的超出后资费标准。"+"|";
						note_info1 += "2、爱家套餐的主卡和成员号码必须归属同一个地市，主卡用户不能办理报停和预销。"+"|";
						note_info1 += "3、在合约期内，88元套餐用户可变更到118元及以上套餐，需补交100元智能终端初装费，龙江网络公司提供多功能智能终端，原MODEM和机顶盒需返还给有线电视安装人员；118元及以上套餐用户可变更为非88元套餐。爱家套餐用户不可变更为非爱家套餐、或取消套餐。"+"|";
						note_info1 += "4、手机主卡欠费，当日关停宽带上网功能及有线电视服务（如原有线电视账户没有费用）；用户缴费后恢复宽带和有线电视功能。"+"|";
						note_info1 += "5、客户原有线电视账户费用不退，如手机主卡欠费或合约期结束后，可继续使用原有线电视账户费用支付有线电视基础收视费及增值业务费用。"+"|";
						note_info1 += "6、手机新入网用户资费立即生效，套餐内手机和有线电视服务功能同步生效、宽带以安装竣工时间为准生效，套餐按整月收取使用费；在网用户爱家资费预约生效，宽带如当月竣工免费体验，手机、宽带和有线电视业务次月1日生效并开始计费。"+"|";
						note_info1 += "7、爱家套餐用户只能通过手机账户代缴宽带费，不能通过宽带账户单独缴费。"+"|";
						note_info1 += "8、爱家套餐月使用费，按整月收取，不区分上下半月。"+"|";
			<%}else if(familyCode.equals("JHJT") && "e281".equals(opCode)) {%>
					  note_info1 += note_info1_temp;
					  note_info1 += "备注：" + "|";
					  note_info1 += "和家庭计划融合套餐，是一种基于家庭群组的流量、语音和宽带多功能共享业务。副卡客户可以共享主卡客户套餐内所有流量；主卡客户和副客户卡每月可独立享受本地主叫成员间通话时长300分钟。" + "|";
		  			note_info1 += "注意事项：" + "|";
		  			note_info1 += "1、当天入网立即生效，非当天入网，预约生效。"+"|";
						note_info1 += "2、参与共享的副卡客户与主卡客户必须归属于相同地市。"+"|";
						note_info1 += "3、主卡取消和家庭计划融合套餐后，次月起所有副卡客户不再享受业务优惠。"+"|";
						note_info1 += "4、如果副卡套餐包含流量，副卡在使用上网流量时，优先使用副卡套餐内的流量，当副卡套餐内流量用完后再使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。如果副卡套餐不含流量，直接使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。"+"|";
			
			<%}else if(familyCode.equals("ZHJT") && "e281".equals(opCode)) {%>
						var autoCancelHidd = $("#autoCancelHidd").val(); //到期是否自动取消
					  note_info1 += note_info1_temp;
		  			note_info1 += "注意事项：" + "|";
		  			note_info1 += "1、如成员套餐内有免费通话时长（或数据流量），首先使用成员套餐内免费通话时长（或数据流量），用完后再使用主卡家庭套餐内的共享通话时长（或流量）。共享通话时长（或流量）使用完后，主卡、成员用户分别执行各自所选套餐的超出后资费标准。"+"|";
						note_info1 += "2、和家庭-魔百和融合套餐的主卡和成员号码必须归属同一个地市，主卡用户不能办理报停和预销。"+"|";
						note_info1 += "3、在合约期内，魔百和融合套餐用户可以在不同价格的魔百和融合套餐内变更套餐，但不可变更为非魔百和融合套餐，或取消魔百和融合套餐。"+"|";
						note_info1 += "4、手机主卡欠费，当日关停宽带上网功能 ；用户缴费后恢复宽带功能。"+"|";
						note_info1 += "5、手机新入网用户资费立即生效，魔百和视频业务立即生效，宽带以安装竣工时间为准生效，套餐按整月收取使用费；在网用户魔百和融合资费预约生效，宽带如当月竣工免费体验，手机和宽带业务、魔百盒视频业务次月1日生效并开始计费。"+"|";
						note_info1 += "6、魔百和融合套餐用户只能通过手机账户代缴宽带费，不能通过宽带账户单独缴费。"+"|";
						note_info1 += "7、魔百和融合套餐月使用费，按整月收取，不区分上下半月。"+"|";
						if(autoCancelHidd == "0"){
							note_info1 += "8、和家庭-魔百和融合套餐到期后，互联网电视自动延续，每个月20元钱。"+"|";
						}else if(autoCancelHidd == "1"){
							note_info1 += "8、和家庭-魔百和融合套餐到期后，互联网电视自动取消。"+"|";
						}
			<%}else if(familyCode.equals("ZHJT") && "i088".equals(opCode)){%>
					var autoCancel2 = $("#autoCancel2").val(); //到期是否自动取消
					note_info1 += note_info1_temp;
					note_info1 += "注意事项：" + "|";
					if(autoCancel2 == "0"){
						note_info1 += "1、和家庭-魔百和融合套餐到期后，互联网电视自动延续，每个月20元钱。"+"|";
					}else if(autoCancel2 == "1"){
						note_info1 += "1、和家庭-魔百和融合套餐到期后，互联网电视自动取消。"+"|";
					}
			<%}
			}%>
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
			if("<%=familyCode%>" == "ZSLL" && opcode == "e281"){
				opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：终端专属流量共享套餐-家庭创建|";
			}
			
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			
			<% if(familyCode.equals("ZSLL")) {%>
			opr_info += "组建家庭号码：" + $("#parentPhone").val() + "|";
			opr_info += "加入家庭群组成员号码：" + otherMemberStr + "|";
			<%}%>
			
			
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					/*设定指定资费*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(opcode=="e281") {
				if(offerName.length > 0){
					opr_info += "指定资费：" + offerName + "|";
				}
				if(offerComment.length > 0){
					opr_info += "指定资费描述：" + offerComment + "|";
				}
			}
			opr_info += opr_info_temp;
			/************备注************/
			
			/************注意事项************/
			<%if("e281".equals(opCode) ) {
			
			if(	familyCode.equals("ZSLL")){
			%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "备注：" + "|";
		  			note_info1 += "0元月租，赠来电显示，月使用费39元，含本地主叫国内通话时长200分钟，省内移动数据流量3GB，超出后省内主叫长市漫合一0.15元/分钟，国内漫游主叫0.3元/分钟，全国接听免费，以上描述国内定价不含港澳台，其他按照标准资费执行。可免费添加一名副卡客户，将套餐内流量共享给副卡客户使用。套餐有效期12个月，到期后如无特殊调整将转为本套餐。"+"|";

						
		  <%}
		  }%>
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		
		

		
		/*2013/12/23 10:09:14 gaopeng 关于哈分公司申请139、188融合类新套餐的请示 这里是打印家庭创建RHJT的打印免填单位置*/
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
						//opr_info += "宽带家庭固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						//opr_info += "宽带家庭宽带成员号码：" + kdMemberStr + "|";
						
						opr_info += "<%=printOpName%>宽带成员号码：" + $("#miantiandankuandai").val() + "|";
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
						//opr_info_temp = "可选成员办理资费：" + minorOfferNameVal + "|";
						//note_info1_temp = "可选成员办理的资费描述：" + minorOfferCommentVal + "|";
					}
					break;
				case 'e282' :
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "本次加入的宽带家庭固话成员手机号码：" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "本次加入的<%=printOpName%>普通成员手机号码：" + otherMemberStr + "|";
					}
					
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						//opr_info += "本次加入的宽带家庭宽带成员号码：" + kdMemberStr + "|";
							opr_info += "本次加入的<%=printOpName%>宽带成员号码：" + $("#miantiandankuandai").val() + "|";
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
						tempMember = normalMemberStr + "," + otherMemberStr;
					}
					opr_info += "家庭成员手机号码：" + tempMember + "|";
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
						opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
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
			if(opcode=="e281") {
			if(offerName.length > 0){
				opr_info += "指定资费：" + offerName + "|";
			}
			if(offerComment.length > 0){
				opr_info += "指定资费描述：" + offerComment + "|";
			}
			}else if(opcode=="e282"){
			  opr_info += "指定资费：" + chengyuanzifei11 + "|";			
        opr_info += "指定资费描述：" + chengyuanzifeimiaoshu11 + "|";	
        if(chengyuanzifei22!=""&&chengyuanzifeimiaoshu22!=""){
          opr_info += "指定资费：" + chengyuanzifei22 + "|";
          opr_info += "指定资费描述：" + chengyuanzifeimiaoshu22 + "|";
        }		
			}
			else {
					
		 opr_info += "指定资费：" + chengyuanzifei11 + "|";			
		 opr_info += "指定资费描述：" + chengyuanzifeimiaoshu11 + "|";			
			opr_info += "指定资费：" + chengyuanzifei22 + "|";
			opr_info += "指定资费描述：" + chengyuanzifeimiaoshu22 + "|";

			}
			opr_info += opr_info_temp;
			/************注意事项************/
			/*  关于双鸭山分公司申请神州行本地家庭资费的请示 @2013/6/17 */
			var familsyinfo  = $("#familyProdInfo").val();
			
			<%if( (familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e281".equals(opCode)) {%>
          if(familsyinfo!="1020"&&familsyinfo!="1021"&&familsyinfo!="1026"&&familsyinfo!="1027"){ //家庭产品信息为1020,1021时，不打印注意事项
            note_info1 += "备注：" + "|";
      			note_info1 += note_info1_temp;
      			note_info1 += "注意事项：" + "|";
      			//note_info1 += getNote();
      			note_info1 += "a、主卡用户可以直接选择家庭市场资费套餐，套餐内包含的通话分钟数可以与副卡的家庭成员共享，且赠送一定时长的家庭成员之间通话（家庭成员间通话时长不计入主卡用户家庭套餐包含的共享时长），主卡用户计入全球通品牌。" + "|";
      			note_info1 += "b、副卡用户可选择任何品牌的基础套餐资费，如果副卡套餐内有免费通话时长，首先使用副卡套餐内免费通话时长，免费通话时长用完后再使用主卡家庭套餐内的共享通话时长。" + "|";
      			note_info1 += "c、共享通话时长使用完之后，主、副卡用户分别执行各自所选套餐的超出后资费标准。" + "|";
      			note_info1 += "d、集团统付客户可以办理全球通家庭资费，但收费按照集团账户优先原则处理。" + "|";
      			note_info1 += "e、公免、公务、测试卡、数据卡、IP超市和传真卡不能办理。" + "|";
      			note_info1 += "f、所有状态正常的在网客户可以办理。" + "|";
      			note_info1 += "g、办理全球通家庭资费的成员号码必须归属同一地市。" + "|";
      			note_info1 += "h、该套餐不能办理停机保号；如果办理停机保号，需变更其他套餐后办理停机保号;手机账户欠费，手机按照现有停机规则处理；宽带停止服务；副卡成员加入家庭立即生效，退出次月生效；家庭解散次月生效；家庭解散时，宽带停止服务立即生效；"+ "|";
      			note_info1 += "i、如果是存量宽带客户，家庭计划资费预约生效；如果是新开宽带客户，家庭计划资费以宽带生效的下个月1日生效；" + "|";
      			note_info1 += "j、主卡办理全球通家庭资费,家长凭个人密码、提供加入的副卡号码、同时提供副卡密码,即可以向家庭内增加成员。变更成员，每月仅允许变更一次，每次一个号码，当月办理下月生效；" + "|";
          }	
          if(familsyinfo=="1022"||familsyinfo=="1023"||familsyinfo=="1024"||familsyinfo=="1025"
          			||familsyinfo=="1038"||familsyinfo=="1039"||familsyinfo=="1040"||familsyinfo=="1041"||familsyinfo=="1042"
          			||familsyinfo=="1043"||familsyinfo=="1044"||familsyinfo=="1045"||familsyinfo=="1046"||familsyinfo=="1047"
          			||familsyinfo=="1048"||familsyinfo=="1049"){ //关于哈分公司申请139及138畅享套餐的请示
            note_info1 += "说明：" + "|";
      			note_info1 += "温馨提示：" + "|";
      			note_info1 += "1.赠送礼品使用有效期详见礼品说明；" + "|";
      			note_info1 += "2.本业务到期前不允许办理销号；若申请取消，按营销活动违约处理，客户需按赠送礼品原价交纳现金，系统将收取您剩余预存款金额的30%作为违约金；" + "|";
      			note_info1 += "3.活动期间，仅可参与一次，不可以重复办理；" + "|";
      			note_info1 += "4.客户需确保套餐专款之外，尚存充足预存话费，可冲销客户新资费生效前未出帐话费，避免专款账户余额不足以冲销套餐费用。" + "|";
      			note_info1 += "广电高清机顶盒为客户换购（用户返还原高清机顶盒），如用户停止使用该套餐，退订时需返还元申广电高清机顶盒及高清服务卡并停止高清服务，详询86240000。" + "|";
          }	
		  <%}%>
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}	
		
		
		function goBack(){
			location="fe280.jsp?activePhone=<%=parentPhone%>";
		}
		function changeObjSeq(familyRoleList){
			/* 获取配置的角色顺序 */
			var familyroleListObj = $("input[id^='memRoleId_']");
			if ( $("#opCode").val() == "i088" )
			{
				if ( "N" == $("#renewType").val() )/**/
				{
					familyroleListObj = $("input[id^='memberRoleId_']");
				}
			}
			
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
		function getNote(){
			var returnStr = "";
			var opCode = "<%=opCode%>";
			var roleObj;
			var familyCode = $("#familyCode").val();
			if(opCode == "e281" ){
				if(familyCode == "XFJT"){
					returnStr += "1、业务当月生效；话费未返还完前不能办理预销业务；2、活动有效期内退订业务需补交话机款，另收取活动剩余预存款的30%作为违约金；3、固话拆包使用时将自动变更为30元月租TD资费套餐，可到营业厅还原资费，当月办理次月生效。4、必选成员退出家庭仅由家长办理，按照营销活动违约收取费用；5、风险免责及固话注册优惠区方法详见网站公告；6、返还活动预存、底线预存仅支付除代收费和手机支付业务之外的通信业务。" + "|";
					for(var i = 0; i < familyRoleList.getLength(); i++){
						roleObj = familyRoleList.getFamRole(i);
						if(roleObj.getMembId() == "70001"){
							$("#homeEasyPhoneHide").val(roleObj.getPhone());
						}
					}
					returnStr += "特别提示：集团客户VPMN网内资费的优先级高于您将办理的幸福家庭资费" + "|";
				}else if(familyCode == "QWJT"){
					returnStr += "1、客户办理业务当月生效。" + "|";
					returnStr += "2、客户取消业务下月生效。" + "|";
					returnStr += "3、加入亲情网的费用由亲情网组建人的手机号码承担。" + "|";
					returnStr += "4、成员数量最少为1人，最多19人。" + "|";
					returnStr += "5、申请组建亲情网业务时最少加入1名成员（含亲情网组建人）。" + "|";
					returnStr += "6、组建人取消亲情网业务后，所有成员不再享受业务优惠。" + "|";
				}
				else if(familyCode == "TXJT"){
					returnStr += "1、客户办理业务当月生效。" + "|";
					returnStr += "2、客户取消业务下月生效。" + "|";
					returnStr += "3、加入亲情网B的费用由亲情网B组建人的手机号码承担。" + "|";
					returnStr += "4、成员数量最少为1人，最多19人。" + "|";
					returnStr += "5、申请组建亲情网B业务时最少加入1名成员（含亲情网B组建人）。" + "|";
					returnStr += "6、组建人取消亲情网B业务后，所有成员不再享受业务优惠。" + "|";
				}
				else if(familyCode == "TSJT"){
					returnStr += "1、客户办理业务当月生效。" + "|";
					returnStr += "2、客户取消业务下月生效。" + "|";
					returnStr += "3、加入亲情网C的费用由亲情网C组建人的手机号码承担。" + "|";
					returnStr += "4、成员数量最少为1人，最多19人。" + "|";
					returnStr += "5、申请组建亲情网C业务时最少加入1名成员（含亲情网C组建人）。" + "|";
					returnStr += "6、组建人取消亲情网C业务后，所有成员不再享受业务优惠。" + "|";
				}
				else if(familyCode == "PYJT"){
					returnStr += "1、客户办理业务当月生效。" + "|";
					returnStr += "2、客户取消业务下月生效。" + "|";
					returnStr += "3、加入亲情网A的费用由亲情网A组建人的手机号码承担。" + "|";
					returnStr += "4、成员数量最少为1人，最多19人。" + "|";
					returnStr += "5、申请组建亲情网A业务时最少加入1名成员（含亲情网A组建人）。" + "|";
					returnStr += "6、组建人取消亲情网A业务后，所有成员不再享受业务优惠。" + "|";
				}				
				else if(familyCode == "ZDGX"){
					returnStr += "1、亲情流量共享内容只限于主卡客户套餐内流量，话音通信不在共享范围内；" + "|";
					/*2014/08/19 16:37:26 gaopeng 关于调整加油包、4G体验套餐优先级及封顶限制的需求
						修改2 内容 次月生效改为立即生效
					*/
					returnStr += "2、客户办理业务立即生效，取消业务次月生效；" + "|";
					returnStr += "3、参与共享的副卡客户与主卡客户必须归属于相同地市；" + "|";
					returnStr += "4、申请创建亲情流量共享组时最少加入1个副卡共享客户；" + "|";
					returnStr += "5、每增加一个共享副卡号码，加收10元功能费，由主卡用户支付，允许增加的共享号码不超过4个；" + "|";
					returnStr += "6、主卡取消亲情流量共享组后，所有副卡客户不再享受业务优惠；" + "|";
					returnStr += "7、如果副卡套餐包含流量，副卡在使用上网流量时，优先使用副卡套餐内的流量，当副卡套餐内流量用完后再使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。如果副卡套餐不含流量，直接使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费；" + "|";
					returnStr += "8、主卡客户套餐内所有流量都可以共享，包含主卡客户基础套餐、流量可选包、加油包、营销活动赠送的流量。" + "|";
					returnStr += "9、流量共享业务的主卡客户不允许办理报停、强关、预销、挂失等业务。如情况特殊，可以在取消流量共享业务的当月办理报停、强关，预销，挂失业务。" + "|";
				}
				/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
				else if(familyCode == "JTGX"){
					returnStr += "1、4G家庭共享套餐业务仅限4G套餐客户办理，当4G套餐取消后，4G家庭共享套餐业务同步结束。"+ "|";
					returnStr += "2、客户办理业务立即生效，取消业务次月生效；" + "|";
					returnStr += "3、参与共享的副卡客户与主卡客户必须归属于相同地市；" + "|";
					returnStr += "4、副卡客户可通过使用主卡客户的WLAN账号（最多支持五人同时登陆）的方式共享主卡客户中国内地WLAN免费流量（不包括EDU节点，每月50G封顶）；" + "|";
					returnStr += "5、当副卡客户小于等于两人时，每月收取主卡客户20元月功能使用费，当副卡客户大于等于三人（最多四人）时，每月收取主卡客户30元月功能使用费；" + "|";
					returnStr += "6、主卡取消4G家庭共享套餐后，次月起所有副卡客户不再享受业务优惠；" + "|";
					returnStr += "7、如果副卡套餐包含流量，副卡在使用上网流量时，优先使用副卡套餐内的流量，当副卡套餐内流量用完后再使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。如果副卡套餐不含流量，直接使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费；" + "|";
					returnStr += "8、主卡客户套餐内所有流量都可以共享，包含主卡客户基础套餐、流量可选包、加油包、营销活动赠送的流量。" + "|";
					returnStr += "9、流量共享业务的主卡客户不允许办理报停、强关、预销、挂失等业务。如情况特殊，可以在取消流量共享业务的当月办理报停、强关，预销，挂失业务。" + "|";
					
				}
				/* end add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
			}else if(opCode == "i088"){

				if ( "N" == $("#renewType").val() )
				{
					returnStr += "1、固话拆包使用时将自动变更为30元月租TD资费套餐，可到营业厅还原资费，当月办理次月生效。" + "|";
					returnStr += "2、必选成员退出家庭仅由家长办理；" + "|";
					returnStr += "3、风险免责及固话注册优惠区方法详见网站公告；" + "|";
					returnStr += "4、如果办理了未到期前的续签，未生效之前不能再办理现有资费的成员加入、成员退出、成员变更、产品变更、家庭解散等操作，如要办理，必须先做续签冲正！"+ "|";
				}
				else
				{
					returnStr += "1、业务当月生效" + "|";
					returnStr += "2、固话拆包使用时将自动变更为30元月租TD资费套餐，可到营业厅还原资费，当月办理次月生效。" + "|";
					returnStr += "3、必选成员退出家庭仅由家长办理；" + "|";
					returnStr += "4、风险免责及固话注册优惠区方法详见网站公告；" + "|";
				}
				
			}else if(opCode == "e282"){
				if(familyCode == "XFJT"){
					var familsyinfos  = $("#familyProdInfo").val();
					returnStr += "1、您加入幸福家庭套餐当月生效。" + "|";
					returnStr += "2、家庭成员必须归属同一地市。" + "|";
									if(familsyinfos=="1006") {}
					else {
					returnStr += "3、家庭成员的月功能费由家庭成员手机号码自行支付。" + "|";
					}
				}else if(familyCode == "QWJT"){
					returnStr += "1、您加入亲情网套餐当月生效。" + "|";
					returnStr += "2、成员必须归属黑龙江省，且必须为移动号码。" + "|";
					returnStr += "3、您只能归属于一个亲情网。" + "|";
					returnStr += "4、成员的月功能费由亲情网组建人手机号码支付。" + "|";
					returnStr += "5、取消亲情网业务下月生效。" + "|";
					returnStr += "6、组建人取消亲情网业务后，所有成员不再享受业务优惠。" + "|";
				}
				else if(familyCode == "TXJT"){
					returnStr += "1、您加入亲情网B套餐当月生效。" + "|";
					returnStr += "2、成员必须归属黑龙江省，且必须为移动号码。" + "|";
					returnStr += "3、您只能归属于一个亲情网B。" + "|";
					returnStr += "4、成员的月功能费由亲情网B组建人手机号码支付。" + "|";
					returnStr += "5、取消亲情网B业务下月生效。" + "|";
					returnStr += "6、组建人取消亲情网B业务后，所有成员不再享受业务优惠。" + "|";
				}
				else if(familyCode == "TSJT"){
					returnStr += "1、您加入亲情网C套餐当月生效。" + "|";
					returnStr += "2、成员必须归属黑龙江省，且必须为移动号码。" + "|";
					returnStr += "3、您只能归属于一个亲情网C。" + "|";
					returnStr += "4、成员的月功能费由亲情网C组建人手机号码支付。" + "|";
					returnStr += "5、取消亲情网C业务下月生效。" + "|";
					returnStr += "6、组建人取消亲情网C业务后，所有成员不再享受业务优惠。" + "|";
				}	
				else if(familyCode == "PYJT"){
					returnStr += "1、您加入亲情网A套餐当月生效。" + "|";
					returnStr += "2、成员必须归属黑龙江省，且必须为移动号码。" + "|";
					returnStr += "3、您只能归属于一个亲情网A。" + "|";
					returnStr += "4、成员的月功能费由亲情网A组建人手机号码支付。" + "|";
					returnStr += "5、取消亲情网A业务下月生效。" + "|";
					returnStr += "6、组建人取消亲情网A业务后，所有成员不再享受业务优惠。" + "|";
				}							
				else if(familyCode == "ZDGX"){
					returnStr += "1、亲情流量共享内容只限于主卡客户套餐内流量，话音通信不在共享范围内；" + "|";
					/*2014/08/19 16:37:26 gaopeng 关于调整加油包、4G体验套餐优先级及封顶限制的需求
						修改2 内容 次月生效改为立即生效
					*/
					returnStr += "2、增加的流量共享功能立即生效，解除共享关系次月生效；" + "|";
					returnStr += "3、参与共享的号码与主卡号码必须归属于相同地市；" + "|";
					returnStr += "4、每增加一个共享成员，加收10元功能费，由主卡用户支付，允许增加的共享终端不超过4个；" + "|";
					returnStr += "5、如果副卡套餐包含流量，副卡在使用上网流量时，优先使用副卡套餐内的流量，当副卡套餐内流量用完后再使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。如果副卡套餐不含流量，直接使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费；" + "|";
					returnStr += "6、主卡客户套餐内所有流量都可以共享，包含主卡客户基础套餐、流量可选包、加油包、营销活动赠送的流量。" + "|";
				}
				/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
				else if(familyCode == "JTGX"){
					returnStr += "1、客户办理业务立即生效，取消业务次月生效；" + "|";
					returnStr += "2、参与共享的副卡客户与主卡客户必须归属于相同地市；" + "|";
					returnStr += "3、当副卡客户小于等于两人时，每月收取主卡客户20元月功能使用费，当副卡客户大于等于三人（最多四人）时，每月收取主卡客户30元月功能使用费；" + "|";
					returnStr += "4、主卡取消4G家庭共享套餐后，次月起所有副卡客户不再享受业务优惠；" + "|";
					returnStr += "5、如果副卡套餐包含流量，副卡在使用上网流量时，优先使用副卡套餐内的流量，当副卡套餐内流量用完后再使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费。如果副卡套餐不含流量，直接使用共享流量；当共享流量用完后，副卡客户产生的流量按照主卡和副卡客户套餐外最优资费标准计费；" + "|";
					returnStr += "6、主卡客户套餐内所有流量都可以共享，包含主卡客户基础套餐、流量可选包、加油包、营销活动赠送的流量。" + "|";
					returnStr += "7、主卡4G套餐取消后，家庭群组同步取消。" + "|";
				}
				/* end add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
			}
		
			return returnStr;
		}
		
		  function checkSMZValue(packet) {
		      document.all.smzvalue.value="";
					var smzvalue = packet.data.findValueByName("smzvalue");
		      document.all.smzvalue.value=smzvalue;
		      
		      KDflag="";
		}
				  function checkSMZValue1(packet) {
		      document.all.kdphone.value="";
					var smzvalue = packet.data.findValueByName("smzvalue");
		      document.all.kdphone.value=smzvalue;
		      
		      KDflag="";
		}
						  function checkKDchongfu(packet) {
					var  kdcfshul = packet.data.findValueByName("smzvalue");
					if(kdcfshul=="1") {
					kdchongfuqj++;
					}
					//alert(kdcfshul);
					//alert(kdchongfuqj);
		      
		}
				 function checkKDchongfu2(packet) {
					var  kdcfshul = packet.data.findValueByName("smzvalue");
					if(kdcfshul=="1") {
					kdchongfuqj--;
					}
					//alert(kdcfshul);
					//alert(kdchongfuqj);
		      
		}
		
		function checkPhoneNo(obj){
			<%if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode) || "ZHJT".equals(familyCode)) && "e281".equals(opCode)) {%>	
					var v_operMemberId = $('#operMemberId').val();
					if(v_operMemberId == "70025" || v_operMemberId == "70028" || v_operMemberId == "70031" || v_operMemberId == "70034" || v_operMemberId == "70052"){
						$(obj).attr("maxlength","25");
						$(obj).attr("v_type","string");
					}else{
						$(obj).attr("maxlength","11");
						$(obj).attr("v_type","mobphone");
					}
			<%}else{%>
						$(obj).attr("maxlength","11");
						$(obj).attr("v_type","mobphone");
			<%}%>
		}
		/*2015/05/19 16:48:04 gaopeng 添加按钮方法*/
		function addRole(rowNum){
			
			if ( "i088" == $("#opCode").val() )
			{
				if ( "none"!= document.all.busiAcceptContent.style.display  )
				{
					rdShowMessageDialog( "当前还有成员在受理中,不能添加新成员!" , 0 );
					$("#rn_meb_add"+rowNum).attr("disabled" , false);
					return false;
				}
				
				if ( "N" == $("#renewType").val() )
				{
					document.all.phoneNo.value
						= document.getElementById("rn_meb_add"+rowNum).v_pho ;						
				}
				
				$("#opMebIdx").val(rowNum);
				$("#rn_meb_add"+rowNum).attr("disabled" , "true");
			}

			/*增加宽带校验*/
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e281".equals(opCode)) {%>			
				var familsyinfo  = $("#familyProdInfo").val();
				var kuandai  = $("#kuandai").val();
				if(familsyinfo==""){
					rdShowMessageDialog("请选择家庭产品信息！");
					return false;
				}
		     if(kuandai.trim()=="") {
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"|| familsyinfo=="1021" || familsyinfo=="1027" ||familsyinfo=="1023"||familsyinfo=="1025"
		     		||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {
		     			rdShowMessageDialog("宽带账号为空，请选择“新建宽带”选项！");
		          return false;
		     		}
		     }else {
		     		if(familsyinfo=="1005"||familsyinfo=="1009"|| familsyinfo=="1011"|| familsyinfo=="1013"|| familsyinfo=="1020" || familsyinfo=="1026"||familsyinfo=="1022"||familsyinfo=="1024"
		     				||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {
						    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","正在提交中，请稍候......");
						    
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								
								 if(kdchecknum=="1") {
								 				rdShowMessageDialog("此宽带账号为已竣工宽带，请选择“已有宽带”选项！");
						          return false;
								 }
								 else {
								 			chginptype1();
											document.all.phoneNo.value=kuandai;
											var obj = document.getElementById("phoneNo"); 
											obj.setAttribute("readOnly",true); 
                 } 
		     		}
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"|| familsyinfo=="1021" ||familsyinfo=="1027"||familsyinfo=="1023"||familsyinfo=="1025"
		     					||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {
		     				var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","正在提交中，请稍候......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								 if(kdchecknum=="0") {
								 				rdShowMessageDialog("此宽带账号为未竣工宽带，请选择“新建宽带”选项！");
						          return false;
								 }
								  else {
								 			chginptype1();
											document.all.phoneNo.value=kuandai;
											var obj = document.getElementById("phoneNo"); 
											obj.setAttribute("readOnly",true); 
                 }
		     		}
		     }
		   

			<%}%>
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e282".equals(opCode)) {%>			
	     var familsyinfo  = $("#familyProdInfo").val();
	     var kuandai  = $("#kuandai").val();
		     if(familsyinfo==""){
		     rdShowMessageDialog("请选择家庭产品信息！");
		     return false;
		     }
		     if(kuandai.trim()=="") {
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"
		     		||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {
		     			//rdShowMessageDialog("宽带账号为空，请输入一个已竣工的宽带账号！");
		          //return false;
		     		}
		     }else {
		     		if(familsyinfo=="1005"||familsyinfo=="1009"|| familsyinfo=="1011"|| familsyinfo=="1013"
		     		||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {		     			
						    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","正在提交中，请稍候......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								 if(kdchecknum=="1") {
								 				rdShowMessageDialog("此宽带账号为已竣工宽带，请输入一个未竣工宽带账号！");
						          return false;
								 }
								 else {
								 			chginptype1();
											document.all.phoneNo.value=kuandai;
											//alert(kuandai)
											var obj = document.getElementById("phoneNo"); 
											obj.setAttribute("readOnly",true); 
                 } 
		     		}

		     }
		   

			<%}%>
		
		
			
			/* 家庭产品信息 */
			/* 根据家庭产品，角色，获得增加此角色所需业务操作。
					主资费变更、可选资费变更、营销案、SP业务  组合。
			*/
			var famProdInfoObj = $("#familyProdInfo");
			if(famProdInfoObj.val() == ""){
				rdShowMessageDialog("请选择家庭产品！");
				if ( "i088" == $("#opCode").val() )
				{
					if ( "N" == $("#renewType").val() )
					{
						$("#rn_meb_add"+rowNum).attr("disabled" , false);
					}
				}
				return false;
			}
			/* 家庭角色 */
		
			
			var famRoleObj = $("#familyrole_" + rowNum);
			var famRoleNameObj = $("#familyroleName_" + rowNum);
			var famMembObj = $("#memRoleId_" + rowNum);
			var famPryTypeObj = $("#payType_"+rowNum);
			var memRoleIdObj = $("#memRoleId_" + rowNum);
			
			if ( $("#opCode").val() == "i088" )
			{
				if ( "N" == $("#renewType").val() )
				{
					famRoleObj = $("#showfamilyRole_" + rowNum); 
					famRoleNameObj = $("#memberRoleName_" + rowNum);
					famPryTypeObj = $("#showpayType_" + rowNum);
					memRoleIdObj = $("#memberRoleId_" + rowNum);
					famMembObj = $("#memberRoleId_" + rowNum);	
				}
			}
			
			/* 角色标识 */

			
			
			$("#operRoleId").val(famRoleObj.val());
			$("#operRoleName").val(famRoleNameObj.val());
			$("#operMemberId").val(famMembObj.val());
			$("#operPayType").val(famPryTypeObj.val());
			
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e282".equals(opCode)) {%>
			   var familsyinfo  = $("#familyProdInfo").val();
						if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"
								||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {
						 		var skdphonenum = quitphoneArray.length;
								if(famMembObj.val()=="70012" || famMembObj.val()== "50002") {
							 		if(skdphonenum>0) {//如果是宽带家庭，并且已经加入过宽带账号了
							 			 return false;
							 		}
						 		}

		     		}
			<%}%>
			/* 查询该角色需要的业务类别及执行顺序 */
			var getdataPacket = new AJAXPacket("getBusi.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",famProdInfoObj.val());
			getdataPacket.data.add("famRole",famRoleObj.val());
			getdataPacket.data.add("memRoleId",memRoleIdObj.val());
			core.ajax.sendPacket(getdataPacket,doAddRoleBack);
			getdataPacket = null;
		}
		var imeiChkFlag = true;
		function doAddRoleBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			//alert(result);
			if(retCode != "000000"){
				
				rdShowMessageDialog("查询业务类别错误" + retCode + ":" + retMsg);
				clearBusiContent();
				return false;
			}else{
				var famRole = packet.data.findValueByName("famRole");
				
				var memRoleId = packet.data.findValueByName("memRoleId");
				var prodCode = packet.data.findValueByName("prodCode");
				$("#signFamRoleFlag").val(famRole);
				if ( "i088" == $("#opCode").val() )
				{
					if ( "N" == $("#renewType").val() )
					{
						var phoneNoObj = $("#phoneNo");
						phoneNoObj.attr("readonly","readonly");
						if(famRole == "M")
						{
							$("#pwdContent").hide();
						}
					}
					else
					{
						if(famRole == "M")
						{
							var phoneNoObj = $("#phoneNo");
							phoneNoObj.val("<%=parentPhone%>");
							phoneNoObj.attr("readonly","readonly");
							$("#pwdContent").hide();
						}						
					}
				}
				else
				{
					
					if(famRole == "M"){
						/*如果是家长的话，就不用手动填写操作手机号码和密码*/
						
						var phoneNoObj = $("#phoneNo");
						phoneNoObj.val("<%=parentPhone%>");
						phoneNoObj.attr("readonly","readonly");
						$("#pwdContent").hide();
					}
					/*ZSLL 39元终端专属流量共享套餐 添加成员时，展示IMEI码信息*/
					if(famRole == "O" && "<%=familyCode%>" == "ZSLL"){
						imeiChkFlag = false;
						$("#ZSLLImeiShow").show();
					}else{
						$("#ZSLLImeiShow").hide();
					}
				}
				$("#signMembRoleId").val(memRoleId);
				$.each(result,function(i,n){
					ctrlAddBtn('d');
					//alert(n[0]);

					if(n[0] == "MO"){
						/* MO 代表	主资费变更 */
						//alert(1273);
						$("#signMOFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"MO");
						/*** 针对e28066这个报错信息，进行提示@2014/10/23 ***/
						var retCode_getOfferCon = $("#retCode_getOfferCon").val();
						var retMsg_getOfferCon = $("#retMsg_getOfferCon").val();
						<%if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode) || "ZHJT".equals(familyCode)) && "e281".equals(opCode) ) {%>		
								if(retCode_getOfferCon != "000000"){
									rdShowMessageDialog("当前工号权限不足！错误代码："+retCode_getOfferCon+"<br>错误信息："+retMsg_getOfferCon);
									window.location.href="fe280.jsp?activePhone=<%=parentPhone%>";
								}
						<%}%>
						/*** 针对e28066这个报错信息，进行提示@2014/10/23 ***/
					}else if(n[0] == "AO"){
				
						/* AO 代表	可选资费变更 */
						$("#signAOFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"AO");
					}else if(n[0] == "SP"){
				
						/* SP 代表	数据业务 */
						getSP(memRoleId,prodCode,famRole,"SP")
					}
					/*gaopeng 20140108 */
					else if(n[0] == "YX"){
						/* YX 代表	营销案 */
					
						$("#signMarketFlag").val("1");
						getYX(memRoleId,prodCode,famRole,"YX")
					}
					else if(n[0] == "KD"){
					
						/* YX 代表	营销案 */
						$("#signKDFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"KD");						
					}
					/*gaopeng 2013/12/23 14:25:53 关于哈分公司申请139、188融合类新套餐的请示 判断CX的时候，返回促销品业务受理区 start*/
					else if(n[0] == "CX"){
						$("#signCXFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"CX");
					}else if(n[0] == "WL"){
						$("#signWLFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"WL");
					}else if(n[0] == "ZK"){
						$("#signZKFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"ZK");
					}else if(n[0] == "WT" && "<%=opCode%>" == "e281"){ /* add for 关于开发互联网电视版融合套餐的需求@2014/12/29 */
						
						$("#signWTFlag").val("1");
						getWT(memRoleId,prodCode,famRole,"WT");
					}
					/*gaopeng 2013/12/23 14:25:53 关于哈分公司申请139、188融合类新套餐的请示 判断CX的时候，返回促销品业务受理区 end*/
				});
				<%if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode) || "ZHJT".equals(familyCode)) && "e281".equals(opCode) ) {%>	
						var checkedLength = $("input[type='checkbox'][id^='complex_MO'][checked]").length;
						if(memRoleId == "70023" || memRoleId == "70026" || memRoleId == "70029" || memRoleId == "70032"){
							if(checkedLength == 0){
								rdShowMessageDialog("当前工号权限不足！无法进行创建操作！");
								window.location.href="fe280.jsp?activePhone=<%=parentPhone%>";
							}
						}
				<%}%>
			}
		}
		function getSP(memRoleId,prodCode,famRole,busiType){
			if("70001" == memRoleId){
				/* 宜居通 */
				$("#signHomeEasyFlag").val("1");
				var getdataPacket = new AJAXPacket("getHomeEasy.jsp","请稍后...");
				getdataPacket.data.add("opCode","<%=opCode%>");
				getdataPacket.data.add("parentPhone","<%=parentPhone%>");
				getdataPacket.data.add("famCode","<%=familyCode%>");
				getdataPacket.data.add("prodCode",prodCode);
				getdataPacket.data.add("famRole",famRole);
				getdataPacket.data.add("memRoleId",memRoleId);
				getdataPacket.data.add("busiType",busiType);
				core.ajax.sendPacketHtml(getdataPacket,doGetSpHtml);
				getdataPacket =null;
			}else if("70002" == memRoleId){
				/* 亲情通 */
				$("#signKinshipFlag").val("1");
				var getdataPacket = new AJAXPacket("getKinship.jsp","请稍后...");
				getdataPacket.data.add("opCode","<%=opCode%>");
				getdataPacket.data.add("parentPhone","<%=parentPhone%>");
				getdataPacket.data.add("famCode","<%=familyCode%>");
				getdataPacket.data.add("prodCode",prodCode);
				getdataPacket.data.add("famRole",famRole);
				getdataPacket.data.add("memRoleId",memRoleId);
				getdataPacket.data.add("busiType",busiType);
				core.ajax.sendPacketHtml(getdataPacket,doGetHtml);
				getdataPacket =null;
			}
		}
		
		function getWT(memRoleId,prodCode,famRole,busiType){
			//var checkAndAddObj = $("#checkAndAdd");
			//checkAndAddObj.attr("disabled","true");
			var getdataPacket = new AJAXPacket("getWT.jsp","请稍后...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",prodCode);
			getdataPacket.data.add("famRole",famRole);
			getdataPacket.data.add("memRoleId",memRoleId);
			getdataPacket.data.add("busiType",busiType);
			core.ajax.sendPacketHtml(getdataPacket,doGetWTHtml);
			getdataPacket =null;
		}
		
		function doGetWTHtml(data)
		{
			$("#busiAccept").append(data);
			var operMemberId = $('#operMemberId').val();
			<%if((familyCode.equals("ZHJT")) && ("e281".equals(opCode))) {%>		
					if(operMemberId=="70034"){ //宽带
						chginptype1();
						//$("#zhjt1").css("display","");
						//$("#zhjt2").css("display","");
						//$("#zhjt3").css("display","");
					}else if(operMemberId=="70032") { //家长
					}
					else {
					  chginptype2();
					}
			<%}%>
			
			$("#busiAcceptContent").show();			
		}
		
		/*gaopeng 20121123 关于协助配置宜居通资费方案的函
		以下为获取营销案内容的ajax方法
		*/
		function getYX(memRoleId,prodCode,famRole,busiType){
			/* 营销案需要校验IMEI码，添加按钮置灰 */
			var checkAndAddObj = $("#checkAndAdd");
			checkAndAddObj.attr("disabled","true");
			var getdataPacket = new AJAXPacket("getMarketing.jsp","请稍后...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",prodCode);
			getdataPacket.data.add("famRole",famRole);
			getdataPacket.data.add("memRoleId",memRoleId);
			getdataPacket.data.add("busiType",busiType);
			core.ajax.sendPacketHtml(getdataPacket,doGetHtml);
			getdataPacket =null;
		}
		function getOffer(memRoleId,prodCode,famRole,busiType){
			/* 资费变更类，创建业务受理信息 */
			
			var getdataPacket = new AJAXPacket("getOfferContent.jsp","请稍后...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",prodCode);
			getdataPacket.data.add("famRole",famRole);
			getdataPacket.data.add("memRoleId",memRoleId);
			getdataPacket.data.add("busiType",busiType);
			core.ajax.sendPacketHtml(getdataPacket,doGetHtml);
			getdataPacket =null;
		}
		
		function doGetSpHtml(data)
		{
			$("#busiAccept").append(data);
			var operMemberId = $('#operMemberId').val();
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode) ) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>		
			if(operMemberId=="70012" || operMemberId=="50002") {
			chginptype1();
			}else if(operMemberId=="70011"){
			chginptype2();
			}else if(operMemberId=="50003"){
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
		
		function doGetHtml(data){
			//alert(data);
			
			$("#busiAccept").append(data);
			/*gaopeng 2014/01/09 10:56:53 优化小区代码的展示内容，防止二次展示。*/
			
				var nowStatusUse = $("#nowStatusUse").val();
				if(nowStatusUse == "MO"){
						$.each($("input[id^='complex_MO']:checked"),function(i,n){
			        if($(this).val()!=""||$(this).val()!=null){//主资费
			            changeMainOffer($(this).val(),"2");
			        }
		      	});
		      	$("#nowStatusUse").val("");
				}
			
			var operMemberId = $('#operMemberId').val();
			//alert(operMemberId);
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB")) && ("e281".equals(opCode) || "e282".equals(opCode))){%>
				if(operMemberId=="70025" || operMemberId=="70028" || operMemberId=="70031" || operMemberId=="70052") {
					chginptype1();
				}
				/*2015/10/22 10:06:21 gaopeng 关于开发“和家庭计划”融合套餐需求的函
					JHJT 70050什么也不
				*/
				else if(operMemberId=="70023" || operMemberId=="70026" || operMemberId=="70029" || operMemberId=="70050" ) {
				}
				else {
					
				  chginptype2();
				}
			<%}%>
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>		
			
			if(operMemberId=="70012" || operMemberId=="50002") {
			chginptype1();
			}else if(operMemberId=="70011"){
			chginptype2();
			}else if(operMemberId=="50003"){
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
		/*2015/05/19 16:36:10 gaopeng 校验&添加成员按钮*/
		function addRoleToSelected(){		
			var phoneNoVal = "";
			var chkHEJTFlag = "Y";
			
			
			
			<%if((familyCode.equals("ZHJT")) && ("e281".equals(opCode))){%>
					var spEnterpriCode = $("#spEnterpriCode").val(); //SP企业代码
					var spBusiCode = $("#spBusiCode").val(); //SP业务代码
					var STBId = $("#STBId").val(); //机顶盒id
					var postalCode = $.trim($("#postalCode").val()); //邮政编码
					
					var installAddr = $("#installAddr").val(); //装机地址
					
					var v_operMemberId = $('#operMemberId').val();
					if(v_operMemberId == "70034"){ //宽带成员
						if(spEnterpriCode == ""){
							rdShowMessageDialog("请输入SP企业代码！");
							return false;
						}
						if(spBusiCode == ""){
							rdShowMessageDialog("请输入SP业务代码！");
							return false;
						}
						if(STBId == ""){
							rdShowMessageDialog("请输入机顶盒id！");
							return false;
						}
						if(STBId.length < 32){
							rdShowMessageDialog("机顶盒id内容为32位！请填写完整！");
							return false;
						}
						
						if(!checkElement(document.all.postalCode)) return false;
						if(postalCode.length != 6){
							rdShowMessageDialog("邮编必须为6位！");
							return false;
						}
						if(installAddr == ""){
							rdShowMessageDialog("请输入装机地址！");
							return false;
						}
					}
			<%}%>
			
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)){%>
					var v_operMemberId = $('#operMemberId').val();
					if(v_operMemberId == "70025" || v_operMemberId == "70028" || v_operMemberId == "70031" || v_operMemberId == "70034" || v_operMemberId == "70052"){
						var checkPwd_Packet = new AJAXPacket("fe280_ajax_getPhoneNo.jsp","正在进行密码校验，请稍候......");
						checkPwd_Packet.data.add("kuandai",$("#phoneNo").val().trim());				
						core.ajax.sendPacket(checkPwd_Packet, function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							var phoneNo = packet.data.findValueByName("phoneNo");//宽带对应的手机号码
							if(retCode == "000000"){
								if(phoneNo == ""){
									rdShowMessageDialog("输入的宽带账号不存在，或者录入的宽带账号不正确，请重新输入！");
									chkHEJTFlag = "N";
								}else{
									phoneNoVal = phoneNo;
									$("#phoneNoHidden").val(phoneNoVal);
								}
							}else{
								rdShowMessageDialog("获取手机号码失败！错误代码："+retCode+"<br>错误信息："+retMsg);
								chkHEJTFlag = "N";
							}
						});
						checkPwd_Packet=null;		
					}else{
						phoneNoVal = $("#phoneNo").val().trim();	
					}
			<%}else{%>
					phoneNoVal = $("#phoneNo").val().trim();
			<%}%>
			
			if(chkHEJTFlag == "N"){
				return false;
			}
			
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)) {%>			
					var v_operMemberId = $('#operMemberId').val();
					//var kuandai = $("#phoneNo").val().trim();
					if(v_operMemberId == "70025" || v_operMemberId == "70028" || v_operMemberId == "70031" || v_operMemberId == "70034" || v_operMemberId == "70052"){ //家庭角色70025是家庭宽带成员,需 验证和家庭，营业员选择的家庭产品是否正确
						var getdataPacket = new AJAXPacket("chkHEJTProd.jsp","请稍后...");
						getdataPacket.data.add("opCode","<%=opCode%>");
						getdataPacket.data.add("parentPhone","<%=parentPhone%>");
						getdataPacket.data.add("familyCode","<%=familyCode%>");
						getdataPacket.data.add("familyProdInfo",$("#familyProdInfo").val());
						getdataPacket.data.add("phoneNoVal",phoneNoVal);
						core.ajax.sendPacket(getdataPacket,function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							if(retCode != "000000"){
								rdShowMessageDialog("校验不通过！" + retCode + "：" + retMsg);
								chkHEJTFlag = "N";
							}else{
								chkHEJTFlag = "Y";
							}
						});
						getdataPacket =null;
					}
		  <%}%>
		  if(chkHEJTFlag == "N"){
		  	return false;
		  }
		  
		<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e281".equals(opCode)) {%>		
			var familsyinfo  = $("#familyProdInfo").val();
	     var kuandai  = $("#phoneNo").val();

		if(familsyinfo=="1005"||familsyinfo=="1009"
			|| familsyinfo=="1011"|| familsyinfo=="1013"
			||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {		     			
			    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","正在提交中，请稍候......");
					getdataPacket.data.add("iCfmLogin",kuandai);	
					core.ajax.sendPacket(getdataPacket,checkSMZValue);
					
					 var kdchecknum = $("#smzvalue").val();
					 if(kdchecknum=="1") {
					 				rdShowMessageDialog("此宽带账号为已竣工宽带，请输入一个未竣工宽带账号！");
			          return false;
					 }
			 }
					 
		<%}%>
				<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e282".equals(opCode)) {%>		
			var familsyinfo  = $("#familyProdInfo").val();
	     var kuandai  = $("#phoneNo").val();

		     		if(familsyinfo=="1005"||familsyinfo=="1009"|| familsyinfo=="1011"|| familsyinfo=="1013"
		     		||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {		     			
						    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","正在提交中，请稍候......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								 if(kdchecknum=="1") {
								 				rdShowMessageDialog("此宽带账号为未竣工宽带，请输入一个已竣工宽带账号！");
						          return false;
								 }
						 }
						 

					 
		<%}%>
			var tempOfferCode = $('#mainOffer').val();
			/*校验IMEI是否验证 39元套餐*/
			if("<%=familyCode%>" == "ZSLL" && "<%=opCode%>" == "e281"){
						var v_operMemberId = $('#operMemberId').val();
						
						if(v_operMemberId == "70054"){
							if(!imeiChkFlag){
								rdShowMessageDialog("请验证IMEI码！");
								return false;
							}
						}
				
				}
				
			/* 校验 */
			if(!checkBusiness()){
				return false;
			}
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
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>	
				var getdataPacket = new AJAXPacket("fe280_qryKDPhone.jsp","正在提交中，请稍候......");
				getdataPacket.data.add("iCfmLogin",kuandai);	
				core.ajax.sendPacket(getdataPacket,checkSMZValue1);								
				var kdchecknums = $("#kdphone").val();
				if($("#operMemberId").val()=="70012"  || $("#operMemberId").val()=="50002") {
				phoneNoVal = kdchecknums;
				miantiandankuandai = kuandai;
				document.all.miantiandankuandai.value=miantiandankuandai;
				}
			<%}%>
			
				<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>	
				var getdataPacket = new AJAXPacket("fe280_checkKDDuplicate.jsp","正在提交中，请稍候......");
				getdataPacket.data.add("Phone_NO",phoneNoVal);	
				core.ajax.sendPacket(getdataPacket,checkKDchongfu);								
				if(kdchongfuqj>1) {
				rdShowMessageDialog("只能加入一个TD固话成员，请确认后再添加！");
				kdchongfuqj=1;
				return false;
				}
				<%}%>
				
				
			famRole.setPhone(phoneNoVal);
			famRole.setRoleId($("#operRoleId").val());
			famRole.setRoleName($("#operRoleName").val());
			famRole.setMembId($("#operMemberId").val());
			famRole.setPay_type($("#operPayType").val());
			var tempOperMemberId = $("#operMemberId").val();
			famRole = createBusiness(famRole);
			//alert(1510+"=="+famRole);
			addSelectedList(famRole);
			ctrlFamRoleTab();
			/*
			for(var i = 0; i < famRole.getLength(); i++){
				alert(famRole.getBusiness(i));
				alert(famRole.getBusiness(i).getBusinessId());
				alert(famRole.getBusiness(i).getOfferId());
			}
			*/
			/* 清业务受理区 */
			clearBusiContent();
			/*liujian add */
			if(tempOperMemberId == '70001') {
					setOffer(tempOfferCode);
			}
		}
		
		function doGetSystemFeeInfo(packet){
		  var monBaseFee = packet.data.findValueByName("monBaseFee");  //赠送系统充值底线金额 
		  var freeFee = packet.data.findValueByName("freeFee");        //赠送系统充值活动金额
		  var baseFee = packet.data.findValueByName("baseFee");        //购机款  
		  var activeTerme = packet.data.findValueByName("activeTerme");//赠送系统充值月份
		  $("#monBaseFeeHidd").val(monBaseFee);
		  $("#freeFeeHidd").val(freeFee);
		  $("#baseFeeHidd").val(baseFee);
		  $("#baseFeeHidd2").val(baseFee);
		  $("#activeTermeHidd").val(activeTerme);
		  
		}
		
		/*liujian 设置免填单中打印的资费,只在增加宜居通家长时调用*/
		function setOffer(code) {
			//alert(2150);
			for(var i=0,len =mainOfferArray.length;i<len;i++) {
				var obj = mainOfferArray[i];
				if(obj.code && obj.code == code) {
					$("#mainOfferName").val(obj.name);
					$("#mainOfferComment").val(obj.comment);
				}
			} 
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
			var delRoleObj; 
			for(var i = 0; i < familyRoleList.getLength(); i++){
				famRoleObj = familyRoleList.getFamRole(i);
				if(phoneNo == famRoleObj.getPhone()){
				delRoleObj = famRoleObj;
				<%if(familyCode.equals("KDJT") && ("e281".equals(opCode) || "e282".equals(opCode))) {%>	
				var getdataPacket = new AJAXPacket("fe280_checkKDDuplicate.jsp","正在提交中，请稍候......");
				getdataPacket.data.add("Phone_NO",phoneNo);	
				core.ajax.sendPacket(getdataPacket,checkKDchongfu2);								
				<%}%>
				
				
				
				
				
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
			
			if ( "i088" == $("#opCode").val() )
			{
				obj.disabled = true ;
			}			
			/*4G  ZDGX删除家长，移除所有成员*/
			if("<%=familyCode%>" == "ZDGX"){
				if(delRoleObj.getMembId() == "40001"){
					$("input[name='delRole']").click();
				}
			}
			/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
			if("<%=familyCode%>" == "JTGX"){
				if(delRoleObj.getMembId() == "40003"){
					$("input[name='delRole']").click();
				}
			}
			/* end add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
		}
		function createBusiness(famRoleObj){
			/* 为成员拼接业务 */
			/* 根据已有的业务，分别拼接 */
			if($("#signAOFlag").val() == "1"){
				/* 拼接上可选资费AO */
				famRoleObj = createAO(famRoleObj);
			}
			/*gaopeng 2013/12/23 14:00:44 139 188融合新套餐的请示 拼接上促销品CX start*/
			if($("#signCXFlag").val() == "1"){
				famRoleObj = createCX(famRoleObj);
			}
			/*gaopeng 2013/12/23 14:00:44 139 188融合新套餐的请示 拼接上促销品CX end*/
			if($("#signMOFlag").val() == "1"){
				/* 拼接上主资费MO */
				famRoleObj = createMO(famRoleObj);
			}
			if($("#signWLFlag").val() == "1"){
				/* 拼接上主资费MO */
				famRoleObj = createWL(famRoleObj);
			}
			if($("#signZKFlag").val() == "1"){
				/* 拼接上主资费MO */
				famRoleObj = createZK(famRoleObj);
			}
			
			if($("#signWTFlag").val() == "1"){
				famRoleObj = createWT(famRoleObj);
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

				<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)) {%>
				var memRoleIdnew = $("#memssRoleId_MO_" + i).val();
				  if(memRoleIdnew=="70023" || memRoleIdnew=="70026" || memRoleIdnew=="70029" || memRoleIdnew=="70032"|| memRoleIdnew=="70050") { //家长
				  						//alert("资费描述"+offerComment);
				  						//alert("资费名称"+offerName);
				  						$("#mainOfferComment").val(offerComment);
					            $("#mainOfferName").val(offerName);
				  }

				<%}%>
				
				<%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode) ) {%>
				var memRoleIdsss = $("#memssRoleId_MO_" + i).val();
				if(actionFlag == "pubFamMainOffer" || actionFlag == "pubFamMainOfferBB" ){
					if(memRoleIdsss=='70009' || memRoleIdsss=='50001') {
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
					//alert(2338);
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
				<%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode) ) {%>
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
		
		function createWL(famRoleObj){
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
			*/
				
			$.each($("input[id^='complex_WL']:checked"),function(i,n){
				var offerIdVal = n.value;
				var business = new Business();
				var businessIdStr = "#complex_busiid_WL_" + i;
				var businessId = $(businessIdStr).val();
				var offerComment = $("#offerComment_WL_" + i).val();
				var offerName = $("#offerName_WL_" + i).val();
				var actionFlag = $("#action_WL_" + i).val();

				business.setBusinessId(businessId);
				business.setBusitype("WL");



				famRoleObj.addBusiness(business);
			});
			return famRoleObj;
		}
		
		function createZK(famRoleObj){
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
			*/
				
			$.each($("input[id^='complex_ZK']:checked"),function(i,n){
				var offerIdVal = n.value;
				var business = new Business();
				var businessIdStr = "#complex_busiid_ZK_" + i;
				var businessId = $(businessIdStr).val();
				var offerComment = $("#offerComment_ZK_" + i).val();
				var offerName = $("#offerName_ZK_" + i).val();
				var actionFlag = $("#action_ZK_" + i).val();

				business.setBusinessId(businessId);
				business.setBusitype("ZK");



				famRoleObj.addBusiness(business);
			});
			return famRoleObj;
		}
		
		function createWT(famRoleObj){
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
			*/
			var spEnterpriCode = $("#spEnterpriCode").val(); //SP企业代码
			var spBusiCode = $("#spBusiCode").val(); //SP业务代码
			var STBId = $("#STBId").val(); //机顶盒id
			var postalCode = $("#postalCode").val(); //邮政编码
			var autoCancel = $("#autoCancel").val(); //到期是否自动取消
			$("#autoCancelHidd").val(autoCancel);
			var installAddr = $("#installAddr").val(); //装机地址
			var phoneNo = $("#phoneNo").val(); //宽带账号 
			var sp_busiId_hidden = $("#sp_busiId_hidden").val();
			
			var business = new Business();
			business.setBusinessId(sp_busiId_hidden);
			business.setBusitype("WT");
			business.setSpEnter_id(spEnterpriCode);
			business.setBizBuss_code(spBusiCode);
			business.setStb_id(STBId);
			business.setPostalCode(postalCode);
			business.setAutoCancel(autoCancel);
			business.setAddress_name(installAddr);
			business.setBroadband_id(phoneNo);
			famRoleObj.addBusiness(business);
			
			return famRoleObj;
		}
		
		function createAO(famRoleObj){
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
			*/
			var checkseles ="";
			var offerNames = "";
			var offerComments = "";
			$.each($("input[id^='complex_AO']:checked"),function(i,n){
				var offerIdVal = n.value;
				var businessIdStr = "#complex_busiid_AO_" + i;
				var businessId = $(businessIdStr).val();
				var business = new Business();
				business.setBusinessId(businessId);
				business.setBusitype("AO");
				business.setOfferId(offerIdVal);
				<%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>
				business.setAreaCode("");
				<%}%>	
				
					
				famRoleObj.addBusiness(business);
				var offerComment = $("#offerComment_AO_" + i).val();
				var offerName = $("#offerName_AO_" + i).val();
				var actionFlag = $("#action_AO_" + i).val();
				//alert(offerComment);
				//alert(offerName);
				//alert(actionFlag);
				<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)) {%>
				var memRoleIdnew = $("#memssRoleId_MO_" + i).val();
				  if(memRoleIdnew=="70024" || memRoleIdnew=="70027" || memRoleIdnew=="70030" || memRoleIdnew=="70033" || memRoleIdnew=="70051") { //普通成员
							$("#minorOfferComment").val(offerComment);
					    $("#minorOfferName").val(offerName);
				  }

				<%}%>
				
				
						<%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>

				var memRoleIdsss = $("#memssRoleId_AO_" + i).val(); 
				//alert("actionFlag="+actionFlag+",memRoleIdsss="+memRoleIdsss);
				//alert("offerName="+offerName);
				if(actionFlag == "pubFamAddOfferBB" || actionFlag == "pubFamMemAdd" || actionFlag == "pubFamAddOffer"){
				if(memRoleIdsss=='70011' || memRoleIdsss=='50003') {
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
				
			/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
			<%}else if(familyCode.equals("JTGX")){
					if("e281".equals(opCode)){%>
						if(offerIdVal == "47217" || offerIdVal == "47218"){
							offerNames = offerNames + "," + offerName;
							if(offerIdVal == "47218"){
								offerNames = offerNames.substr(1,offerNames.length);
								$("#mainOfferComment").val(offerComment);
							}
							$("#mainOfferName").val(offerNames);
							$("#offeridss").val(offerIdVal);
						}
				<%}else if("e282".equals(opCode)){%>
						var v_offerComment = offerName +"|"+ offerComment;
						$("#minorOfferComment").val(v_offerComment);
						$("#minorOfferName").val(offerName);
				<%}%>
			/* end add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
			<%}else {%>	
				if(actionFlag == "pubCreateFam"){
					//alert(2542);
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
		/*gaopeng 2013/12/23 14:24:05 关于哈分公司申请139、188融合类新套餐的请示 添加新的json串拼接 start*/
		function createCX(famRoleObj){
			/* 	为角色创建属性 
					主资费变更和可选资费变更可用，因为比较固定
					businessId 标识是 主资费(MO) 还是 可选资费(AO)
					offerId 标识资费代码
			*/
			var checkseles ="";
			$.each($("input[id^='complex_CX']:checked"),function(i,n){
				var offerIdVal = n.value;
				var businessIdStr = "#complex_busiid_CX_" + i;
				var businessId = $(businessIdStr).val();
				var business = new Business();
				business.setBusinessId(businessId);
				business.setBusitype("CX");
				business.setOfferId(offerIdVal);
				<%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>
				business.setAreaCode("");
				<%}%>	
				famRoleObj.addBusiness(business);
			});
			return famRoleObj;
		}
		/*gaopeng 2013/12/23 14:24:05 关于哈分公司申请139、188融合类新套餐的请示 添加新的json串拼接 end*/
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
				<%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>
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
			/* begin  关于协助配置家庭终端产品营销方案及统计报表的函 @2013/8/8*/
			/* 
			    幸福家庭、家庭创建时，
			    json中新增五个参数：购机款、赠送系统充值底线金、赠送系统充值活动金额、系统充值活动专款返还期限、系统充值底线专款返还期限
			  */
			<%if("XFJT".equals(familyCode)&&"e281".equals(opCode)) {%>
			  business.setCash_pay($("#baseFeeHidd").val());
			  business.setInnet_fee($("#monBaseFeeHidd").val());
			  business.setChoice_fee($("#freeFeeHidd").val());
			  business.setOther_fee($("#activeTermeHidd").val());
			  business.setHand_fee($("#activeTermeHidd").val());
		  <%}%>
		  /* end  关于协助配置家庭终端产品营销方案及统计报表的函 @2013/8/8*/
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
      <%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>	
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
			
			var rowNum = $("#opMebIdx").val();
			if ( "i088" == $("#opCode").val() )
			{
				$("#rn_meb_add"+rowNum).attr("disabled" , false);
			}

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
			var zdgxNum = getSelectedMembNum("40001");
			$.each(resule0Obj,function(i,n){
				var ctrlBtnStr = "#addRole" + i;
				var selectedMemNum = getSelectedMembNum(n.value);
				var addedMemberNum = 0;
				var selectedMemStr = "#selectedMem_"+i;
				addedMemberNum = parseInt($(selectedMemStr).val()) + parseInt(selectedMemNum);
				$("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)").html("" + addedMemberNum);
				var ctrlFlag = checkMemberNo(n.value,addedMemberNum);
				/*4G项目，ZDGX家庭，家庭创建，必须先添加家长*/
				if("<%=familyCode%>" == "ZDGX" && "<%=opCode%>"=="e281" && ctrlFlag != "-1"){
					var memRoleIdVal = $(this).parent().parent().find("input[id^='memRoleId_']").val();
					/*如果“终端共享家长  40001” 添加数为0 ，只有家长的添加按钮可点*/
					if(zdgxNum == 0){
						if(memRoleIdVal == "40001"){
							ctrlFlag = "0";
						}else{
							ctrlFlag = "1";
						}
					}
				}
				if(ctrlFlag == "1"){
					/*不可以添加，按钮置灰*/
					$(ctrlBtnStr).attr("disabled","true");
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
		function checkBusiness(){
			var phoneNoVal = "";
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)){%>
					var v_operMemberId = $('#operMemberId').val();
					if(v_operMemberId == "70025" || v_operMemberId == "70028" || v_operMemberId == "70031" || v_operMemberId == "70034" || v_operMemberId == "70052"){ //70034
						phoneNoVal = $("#phoneNoHidden").val();
					}else{
						phoneNoVal = $("#phoneNo").val().trim();
					}
			<%}else{%>
					phoneNoVal = $("#phoneNo").val().trim();
			<%}%>
			if(phoneNoVal == ""){
				rdShowMessageDialog("请输入操作号码！");
				return false;
			}
			
			var busiAcceptContentObjs = $("#busiAcceptContent :text");
			var acceptCheckFlag = true;
			$.each(busiAcceptContentObjs,function(i,n){
				if(!checkElement(n)){
					acceptCheckFlag = false;
					return false;
				}
			});
			var busiAcceptSelectObjs = $("#busiAcceptContent select");
			$.each(busiAcceptSelectObjs,function(i,n){
				if($(n).val() == ""){
					rdShowMessageDialog("请选择" + $(n).attr("v_name"));
					acceptCheckFlag = false;
					return false;
				}
			});
			if(!acceptCheckFlag){
				return acceptCheckFlag;
			}
		<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>		
			var familsyinfo  = $("#familyProdInfo").val();
	    var kuandai  = $("#phoneNo").val();
			var kdphroid = $("#signMembRoleId").val();
		     		 if(kdphroid=="70012" || kdphroid == "50002") 	{		
						    var getdataPacket = new AJAXPacket("fe280_qryKDPhone.jsp","正在提交中，请稍候......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue1);
								
								 var kdchecknums = $("#kdphone").val();
						 phoneNoVal =kdchecknums;
						}
		<%}%>
			/* 做密码校验  */
			/* 和家庭，家庭创建，成员加入，和家庭计划-融合套餐（JHJT）都不校验密码*/
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>		
			<%}else{%>
					if("<%=pwrf%>" == "false" && "M" != $("#signFamRoleFlag").val()){
						/*如果没有免密码权限，并且不是家长，必须输入密码并且校验密码*/
						var userPsw = $("input[name='phonePwd']").val();
						if(userPsw == ""){
							rdShowMessageDialog("请输入操作手机密码");
							return false;
						}
		
						var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
						checkPwd_Packet.data.add("custType","01");				//01:手机号码 02 客户密码校验 03帐户密码校验
						checkPwd_Packet.data.add("phoneNo",phoneNoVal);	//移动号码,客户id,帐户id
						checkPwd_Packet.data.add("custPaswd",userPsw);//用户/客户/帐户密码
						checkPwd_Packet.data.add("idType","");				//en 密码为密文，其它情况 密码为明文
						checkPwd_Packet.data.add("idNum","");					//传空
						checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//工号
						core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
						checkPwd_Packet=null;
						if($("#signPswFlag").val() == "0"){
							return false;
						}
					}
			<%}%>
			
			getPubCheck(phoneNoVal,"<%=opCode%>","<%=familyCode%>",$("#signMembRoleId").val());
			var checkObj = $("#checkFlag");
			if(checkObj.val() == "0"){
				/* 不允许继续执行 */
				return false;
			}
			return true;
		}
		function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					/* 密码校验标识 0失败   1成功 */
					$("#signPswFlag").val("0");
					rdShowMessageDialog(msg);
				}else{
					$("#signPswFlag").val("1");
				}
		}
		function getPubCheck(phoneNo,opcode,famCode,memberRoleId){
		
		  if((famCode=="KDJT" || famCode == "RHJT") && (memberRoleId=="70012" || memberRoleId=="50002")) 	{	
		    var familsyinfo  = $("#familyProdInfo").val();
  	    var getdataPacket = new AJAXPacket("fe280_checkKDMessage.jsp","正在提交中，请稍候......");
  			getdataPacket.data.add("iCfmLogin",$("#phoneNo").val());	
  			getdataPacket.data.add("familsyinfo",familsyinfo);	
  			core.ajax.sendPacket(getdataPacket,doPubCheckBack);
								
			}
			else {
			var getdataPacket = new AJAXPacket("fe280PubCheck.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("parentPhone",phoneNo);
			getdataPacket.data.add("opCode",opcode);
			getdataPacket.data.add("famCode",famCode);
			getdataPacket.data.add("memberRoleId",memberRoleId);
			getdataPacket.data.add("checkType","0");
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e282".equals(opCode)) {
					String groupsssd ="";
					for(int i = 0; i < familyMemberList.length; i++){
								if(!familyMemberList[i][7].equals("")) {
											groupsssd	=familyMemberList[i][7];
								}
						
					}
					%>
					getdataPacket.data.add("sgroupgs","<%=groupsssd%>");
				<%	
			}%>
			getdataPacket.data.add("parentPhoneNo","<%=parentPhone%>");
			core.ajax.sendPacket(getdataPacket,doPubCheckBack);
			getdataPacket = null;
			}
		}
		function doPubCheckBack(packet){
			retCode = packet.data.findValueByName("retcode");
			retMsg = packet.data.findValueByName("retmsg");
			var checkObj = $("#checkFlag");
			if(retCode != "000000"){
				checkObj.val("0");
				rdShowMessageDialog(retMsg,0);
		  	return false;
			}else{
				checkObj.val("1");
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
		function changeProd1(){ //家庭产品信息 onchange
			
			if ( "i088" == $("#opCode").val() ) //家庭续签
			{
				var chkFamUpd = "Y";
				if ( "N" == $("#renewType").val() )/*未到期续签*/
				{
					$("input[name^='rn_meb_add']").attr("disabled",false);
				}
				<%if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") ) { //和家庭 %>
						var msgPacket = new AJAXPacket("fe280_ajax_chkFamUpd.jsp","正在获取数据，请稍候......");
						msgPacket.data.add("printAccept","<%=printAccept%>");
						msgPacket.data.add("phoneNo","<%=parentPhone%>");
						msgPacket.data.add("opCode","<%=opCode%>");
						msgPacket.data.add("prodCode","<%=prodCode%>");
						msgPacket.data.add("prodCodeNew",$("#familyProdInfo").val());//下一档产品代码
						msgPacket.data.add("famCode","<%=familyCode%>");
						core.ajax.sendPacket(msgPacket, function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							var innetFee = packet.data.findValueByName("innetFee");//初装费
							var innetrate = packet.data.findValueByName("innetrate");
							var innetRateFee = packet.data.findValueByName("innetRateFee");
							var innetFeeLeft = packet.data.findValueByName("innetFeeLeft");
							
							//innetFee = "23443221";//ceshi
							//$("#innetFeeHidd").val(innetFee);//ceshi
							if(retCode != "000000"){
								rdShowMessageDialog("查询续签相关信息失败！<br>" + retCode+"<br>"+ retMsg,0);
								chkFamUpd = "N";
								$("select[name='familyProdInfo']").val("");
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
						if(chkFamUpd == "N"){
					  	return false;
					  }
					  
					  var chkHEJTFlag_one = "Y";
						var getdataPacket = new AJAXPacket("chkHEJTProd.jsp","请稍后...");
						getdataPacket.data.add("opCode","<%=opCode%>");
						getdataPacket.data.add("parentPhone","<%=parentPhone%>");
						getdataPacket.data.add("familyCode","<%=familyCode%>");
						getdataPacket.data.add("familyProdInfo",$("#familyProdInfo").val());
						getdataPacket.data.add("phoneNoVal","");
						core.ajax.sendPacket(getdataPacket,function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							if(retCode != "000000"){
								rdShowMessageDialog("校验不通过！" + retCode + "：" + retMsg,0);
								$("#familyProdInfo").val("");
								chkHEJTFlag_one = "N";
							}else{
								chkHEJTFlag_one = "Y";
							}
						});
						getdataPacket =null;
						if(chkHEJTFlag_one == "N"){
					  	return false;
					  }
						
      	<%}%>	    	
			}
      var familsyinfo  = $("#familyProdInfo").val();
      var resule0Obj = $("input[id^='memRoleId_']");
      
      <%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>	
        if(familsyinfo=="1020"||familsyinfo=="1021" ||familsyinfo=="1026" || familsyinfo=="1027"){
          $.each(resule0Obj,function(i,n){
            	if($(this).val()=="70011"){//全球通家庭资费普通成员 添加按钮置灰 
            	  var butAddRole = "#addRole"+i;
            	  $(butAddRole).attr("disabled","true");
            	}
          });	
          /*全球通家庭资费普通成员 别的产品成员数量还得改回去*/
          $("input[id^='memRoleId_']").each(function(i,n){
        		/*全球通家庭资费普通成员 数量非得绑定在产品上*/
        		if($(this).val() == "70011"){
        			$(this).parent().parent().find("td:eq(1)").text($("#memMaxNum_"+i).val());
        		}
        	});
        }	else if(familsyinfo=="1022"||familsyinfo=="1023" ||familsyinfo=="1024" || familsyinfo=="1025"){
        	$("input[id^='memRoleId_']").each(function(i,n){
        		/*全球通家庭资费普通成员 数量非得绑定在产品上*/
        		if($(this).val() == "70011"){
        			$(this).parent().parent().find("td:eq(1)").text("2");
        		}
        	});
        }else{
        	/*全球通家庭资费普通成员 别的产品成员数量还得改回去*/
          $("input[id^='memRoleId_']").each(function(i,n){
        		/*全球通家庭资费普通成员 数量非得绑定在产品上*/
        		if($(this).val() == "70011"){
        			$(this).parent().parent().find("td:eq(1)").text($("#memMaxNum_"+i).val());
        		}
        	});
        }
      <%}%>		
      <%if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) { //和家庭 %>
					updateFamilyRoleTrs();
      <%}%>		
      changeProd();
		}
		
		function updateFamilyRoleTrs(){
			var getdataPacket = new AJAXPacket("updateFamilyRoles.jsp","请稍后...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("familyCode","<%=familyCode%>");
			getdataPacket.data.add("familyProdInfo",$("#familyProdInfo").val());
			core.ajax.sendPacketHtml(getdataPacket,doUpdFamRolesHtml);
			getdataPacket =null;
		}
		
		function doUpdFamRolesHtml(data){
			$("#familyRoleTr").html(data);	
			var retCode_updFaml = $("#retCode_updFaml").val();
			var retMsg1_updFaml = $("#retMsg1_updFaml").val();
			if(retCode_updFaml != "000000"){
				rdShowMessageDialog("没有查询到家庭角色信息!<br>错误代码：" + retCode_updFaml +"<br>错误信息："+ retMsg1_updFaml);
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			}
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
			
							/* 获取 赠送系统充值底线金、赠送系统充值活动金额、购机款、赠送系统充值月份@2013/8/8  */
		<%if(familyCode.equals("XFJT") && "e281".equals(opCode)){%>	  
  		  var v_market = $("#market").val();
  		  if(typeof($("#market").val()) != "undefined"){ //创建家长时，营销案代码存在
  		    var getdataPacket = new AJAXPacket("fe280_ajax_getSystemFeeInfo.jsp","正在提交中，请稍候......");
  				getdataPacket.data.add("opCode","<%=opCode%>");	
  				getdataPacket.data.add("saleCode",v_market);	
  				core.ajax.sendPacket(getdataPacket,doGetSystemFeeInfo);
  		  }else{
  		    
  		  }
		<%}%> 
			
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
		function checkimeino(){
			var imeiNoObj = $("#IMEINo");
			var checkAndAddObj = $("#checkAndAdd");
			if (imeiNoObj.val().length == 0) {
				rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
				imeiNoObj[0].focus();
				checkAndAddObj.attr("disabled","true");
				return false;
			} 
		     
			var IMEINo = imeiNoObj.val();
			var agent_code = $("#brand").val();
			var phone_type = $("#res").val();
			var opcode = "<%=opCode%>";
			
			var myPacket = new AJAXPacket("../s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
			myPacket.data.add("imei_no",IMEINo);
			myPacket.data.add("brand_code",agent_code);
			myPacket.data.add("style_code",phone_type);
			myPacket.data.add("retType","0");
			myPacket.data.add("opcode",opcode);
			core.ajax.sendPacket(myPacket,doCheckImeiBack);
			myPacket =null; 
		    
		}
		function doCheckImeiBack(packet){
			errorCode = packet.data.findValueByName("errorCode");
			errorMsg =  packet.data.findValueByName("errorMsg");
			retType = packet.data.findValueByName("retType");
			var retResult=packet.data.findValueByName("retResult");
			var imeiNoObj = $("#IMEINo");
			var checkAndAddObj = $("#checkAndAdd");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！");
					imeiNoObj.attr("readonly","true");
					checkAndAddObj.removeAttr("disabled");
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！");
					imeiNoObj.attr("readonly","true");
					checkAndAddObj.removeAttr("disabled");
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
					checkAndAddObj.attr("disabled","true");
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！");
					checkAndAddObj.attr("disabled","true");
					return false;
			}
		}
		function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode != "000000"){
					rdShowMessageDialog("错误编码："+retCode+",错误信息："+retMsg);
					removeCurrentTab();
			}
			else{
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			$("#custName").val(custName);
			$("#smName").val(smName);
			$("#parentCustName").val(custName);
			}
		}

		$(document).ready(function(){
			
			/* 设置样式 */
			var prodCode = "<%=prodCode%>";
			if ("<%=opCode%>" == "i088")
			{				
				/*
				$("#familyProdInfo option[value='" + prodCode + "']")
					.attr("selected","selected");
				$("#familyProdInfo").attr("disabled","true");
				*/
				//$("#renew_tr").show( 800 );
				//$("#famMembListContent").show( 800 );
				if ( "Y" == $("#renewType").val() )/*已到期续签*/
				{
					$( "#items" ).show( 800 );
					$( "#mebList" ).hide();
					$( "#familyMemberList" ).hide();
				}
				else if ( "N" == $("#renewType").val()  )/*未到期续签*/
				{
					$( "#items" ).hide();
					$( "#mebList" ).show( 800 );
					$( "#familyMemberList" ).show( 800 );
				}						
			}
			
			if("<%=opCode%>" == "e282"){
				$("#familyMemberList").show();
				$("#famMembListContent").show();
				$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
				$("#familyProdInfo").attr("disabled","true")
			}
			
			//和家庭，成员加入时，需更新家庭角色信息
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e282".equals(opCode)) {%>
				updateFamilyRoleTrs();
			<%}%>
			//和家庭，家庭续签时，重置家庭产品信息
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "i088".equals(opCode)) {%>
					$("#familyProdInfo").empty();		
					var getdataPacket = new AJAXPacket("fe280_ajax_getFamilyProdInfos.jsp","请稍后...");
					getdataPacket.data.add("opCode","<%=opCode%>");
					getdataPacket.data.add("operPhoneNo","<%=parentPhone%>");
					getdataPacket.data.add("familyCode","<%=familyCode%>");
					getdataPacket.data.add("familyProdInfo",$("#familyProdInfo").val());
					core.ajax.sendPacket(getdataPacket,function(packet){
						var retCode = packet.data.findValueByName("retCode");
						var retMsg = packet.data.findValueByName("retMsg");
						//alert(retCode);
						var _code = packet.data.findValueByName("_code");
						var _text = packet.data.findValueByName("_text");
						var _sp_info = packet.data.findValueByName("_sp_info");
						if(retCode == "000000"){
							$("#familyProdInfo").append("<option value='' sp_info=''>--请选择--</option>");
							for(var i=0;i<_code.length;i++){
								$("#familyProdInfo").append("<option value='"+_code[i]+"' sp_info='"+_sp_info[i]+"' >"+_text[i]+"</option>");
							}
						}else{
							rdShowMessageDialog("错误代码："+retCode+"，错误信息："+retMsg);
							window.location="fe280.jsp?activePhone=<%=parentPhone%>";
						}
					});
					getdataPacket =null;
					
					$("#autoCancelTab2").css("display","none");
			<%}%>
			
			/*alert("<%=familyCode%>"+"---"+"<%=opCode%>"); 这里特殊处理了一下,融合家庭同时为e282的情况下不展示宽带账号输入框*/
			<%if( (familyCode.equals("KDJT") && ("e281".equals(opCode) || "e282".equals(opCode))) ||  ("RHJT".equals(familyCode) && "e281".equals(opCode))) {%>
				if("<%=familyCode%>" == "RHJT" || "<%=familyCode%>" == "KDJT"){
					$("#kdjt").show();
				}
				 var familsyinfo  = $("#familyProdInfo").val();
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014") {
		     			$("#kdjt").show();
		     		}
			<%}
			if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>
				 var familsyinfo  = $("#familyProdInfo").val();
		     		if(familsyinfo=="1022"||familsyinfo=="1023"|| familsyinfo=="1024"|| familsyinfo=="1025") {
			     		$("input[id^='memRoleId_']").each(function(i,n){
		        		/*全球通家庭资费普通成员 数量非得绑定在产品上*/
		        		if($(this).val() == "70011"){
		        			$(this).parent().parent().find("td:eq(1)").text("2");
		        		}
		        	});
		     		}
			<%}
			%>
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","正在获得数据，请稍候......");

			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			ctrlFamRoleTab();
			
			var familsyinfo  = $("#familyProdInfo").val();
      var resule0Obj = $("input[id^='memRoleId_']");
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e282".equals(opCode)) {%>
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
    
    function getSpBusiCode(obj){
    	$("#spBusiCode").empty();
    	$("#spBusiCode").append("<option value ='' >--请选择--</option>");
    	if(obj.value == "699212"){
    		$("#spBusiCode").append("<option value ='20830000'>20830000</option>");
    	}else if(obj.value == "699213"){
    		$("#spBusiCode").append("<option value ='20830000'>20830000</option>");
    	}else{
    		$("#STBId").val("");
    	}
    }
    
    //在企业代码和业务代码选择完后，机顶盒id输入框自动展示前28位，营业员自行输入最后4位，前28位允许修改。
    function getSTBId(obj){
    	if(obj.value == ""){
    		$("#STBId").val("");
    	}else{
    		if($("#spEnterpriCode").val() == "699212"){
	    		$("#STBId").val("003901FF0018201000010019F0BD");
	    	}else if($("#spEnterpriCode").val() == "699213"){
	    		$("#STBId").val("003901FF0018301000010019F0BD");
	    	}
    	}
    }
    
    function ZSLLImeiCheck(){
    	/*家长号码*/
    	var parentPhone = $.trim($("#parentPhone").val());
    	/*成员号码,这时候还没添加 所以使用方法getPhoneNoByMemberId("70054"); 取不到*/
    	var memberPhone = $.trim($("#phoneNo").val());
    	if(memberPhone.length == 0){
    		rdShowMessageDialog("请输入成员号码！");
    		return false;
    	}
    	/**
    	var otherMemberStr = getPhoneNoByMemberId("70054");
    	var otherMemberStr2 = getPhoneNoByMemberId("70053");
    	**/
    	var imeiNo = $.trim($("#ZSLLImei").val());
    	if(imeiNo.length == 0){
    		rdShowMessageDialog("请输入IMEI码！");
    		return false;
    	}
    
    	/*调用服务进行IMEI码验证*/
    	
    	/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/se280/fm280CheckImei.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=work_no%>";
			var iLoginPwd = "<%=password%>";
			var iPhoneNo = parentPhone;
			var iUserPwd = "";
			
			var iQryType = "0";
			var iFamImei = imeiNo;
			var iPhoneNoMem = memberPhone;
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iQryType",iQryType);
			getdataPacket.data.add("iFamImei",iFamImei);
			getdataPacket.data.add("iPhoneNoMem",iPhoneNoMem);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
    }
    
    function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			
			if(retCode == "000000"){
				imeiChkFlag = true;
				rdShowMessageDialog("验证成功！",2);
			}else{
				imeiChkFlag = false;
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
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
				" WHERE family_code = '" + familyCode + "' "
				+" AND GROUP_ID = '" + belongGroupId + "'";
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
				<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT")) && "i088".equals(opCode)){%>
			 		&nbsp; &nbsp; 
			 		<font class='red'> (请注意：从88元变更为其他档位，需缴纳智能终端费用100元。) </font> 
			 	<%}%>				
			</td>

		</tr>
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>
			<tr id="kdjt" style="display:none">
        <td class="blue"  >宽带账号</td>
				<td >
					<input type="text" id="kuandai" name="kuandai" maxlength="20"  />

			</tr>
			<%}%>
	</table>
	<div id = 'mebList'>
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
			<%
			if ( "i088".equals(opCode) )
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
			if("e282".equals(opCode) || "i088".equals(opCode) ){
				for(int i = 0; i < familyMemberList.length; i++){
					System.out.println("---------------liujian---------------familyMemberList=" + familyMemberList.length);
					if(familyMemberList[i][0].equals("70012") || familyMemberList[i][0].equals("50002")) {
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
			<input type="hidden" name="memberRoleId_<%=i%>" id="memberRoleId_<%=i%>" 
				value="<%=familyMemberList[i][0]%>"/>
			<input type="hidden" name="phoneNo_<%=i%>" id="phoneNo_<%=i%>" 
				value="<%=familyMemberList[i][3]%>"/>
			<input type="hidden" id="showfamilyRole_<%=i%>" name="showfamilyRole_<%=i%>" 
				value="<%=familyMemberList[i][1]%>" />
			<input type="hidden" id="memberRoleName_<%=i%>" name="memberRoleName_<%=i%>" 
				value="<%=familyMemberList[i][2]%>" />
			<input type="hidden" id="showpayType_<%=i%>" name="showpayType_<%=i%>" 
				value="<%=familyMemberList[i][6]%>" />
			<script>
				/*
				//liujian e282需求变更，只要当前添加的号码
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
			<%
			if ( "i088".equals(opCode) )
			{
			%>
				<td align = 'center'>
					<input id = 'rn_meb_add<%=i%>' name = 'rn_meb_add' type = 'button'
						class = 'b_text' value = '添加' 
						v_pho = "<%=familyMemberList[i][3]%>"
						 onclick = 'addRole(<%=i%>)'>
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
	</div>
	<div id="autoCancelTab2" style="display:none;">
		<table>
			<tr>
				<td class="blue" width="10%">到期是否自动取消</td>
				<td colspan="3">
					<select id="autoCancel2" name="autoCancel2" >
						<option value ="1" >是</option>
						<option value ="0" >否</option>
					</select>
					<font class="orange">*</font>
				</td>
			</tr>
		</table>
	</div>
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
				<tbody id="familyRoleTr">
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
					<input type="hidden" id="memMaxNum_<%=i%>" value="<%=result0[i][3]%>" />
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
				</tbody>
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
				<td width="15%">
					<input type="text" id="phoneNo" name="phoneNo" maxlength="11" 
						v_type="mobphone" v_must="1" onblur = "checkElement(this)" onfocus="checkPhoneNo(this)" />
					<font class="orange">*</font>
					<input type="hidden" id="operRoleId" name="operRoleId" />
					<input type="hidden" id="operRoleName" name="operRoleName" />
					<input type="hidden" id="operMemberId" name="operMemberId" />
					<input type="hidden" id="operPayType" name="operPayType" />
				</td>
				<td class="blue" width="20%">密码</td>
				<td colspan="2" >
					<span id="pwdContent">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="phonePwd"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</span>
				</td>
			</tr>
			<tr id="ZSLLImeiShow" style="display:none">
				<td class="blue" width="15%">
					IMEI码
				</td>	
				<td colspan="3">
					<input type="text" name="ZSLLImei" id="ZSLLImei" value=""/>
					&nbsp;&nbsp;
					<input type="button" class="b_text" name="ZSLLImeiCheckBtn" id="ZSLLImeiCheckBtn" onclick="ZSLLImeiCheck();" value="验证" />
				</td>
			</tr>
			<tbody id="busiAccept">
			</tbody>
			<tr>
				<td colspan="5">
					<div align="center"> 
						<input type="button" class="b_foot_long" value="校验&添加成员" 
						 onclick="addRoleToSelected()" id="checkAndAdd" name="checkAndAdd" />
						<input type="button" name="cancle" class="b_foot" value="取消" onclick="cancleAdd()" />
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<input type="hidden" id="signFamRoleFlag" name="signFamRoleFlag" />
	<input type="hidden" id="signPswFlag" name="signPswFlag" />
	<input type="hidden" id="signMOFlag" name="signMOFlag" />
	<input type="hidden" id="signWLFlag" name="signWLFlag" />
	<input type="hidden" id="signZKFlag" name="signWLFlag" />
	<input type="hidden" id="signWTFlag" name="signWTFlag" />
	<input type="hidden" id="signAOFlag" name="signAOFlag" />
	<input type="hidden" id="signCXFlag" name="signCXFlag" />
	<input type="hidden" id="signHomeEasyFlag" name="signHomeEasyFlag" />
	<input type="hidden" id="signKinshipFlag" name="signKinshipFlag" />
	<input type="hidden" id="signMarketFlag" name="signMarketFlag" />
	<input type="hidden" id="signMembRoleId" name="signMembRoleId" />
	<input type="hidden" id="signKDFlag" name="signKDFlag" />
	<input type="hidden" id="exp_time" name="exp_time" value = "<%=exp_time%>"/>
	<input type="hidden" id="phoneNoHidden" name="phoneNoHidden" value = ""/>
	

	
	<!-- 业务受理区 end -->
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
	<input type="hidden" id="parentPhone" name="parentPhone" value="<%=parentPhone%>" />
	<input type="hidden" id="parentCustName" name="parentCustName" value="" />
	<input type="hidden" id="operPhoneNo" name="operPhoneNo" value="<%=parentPhone%>" />
	<input type="hidden" id="myJSONText" name="myJSONText" />
	<input type="hidden" name="checkFlag" id="checkFlag" />
	<input type="hidden" name="custName" id="custName" />
	<input type="hidden" name="smName" id="smName" /> 
	<input type="hidden" name="homeEasyHide" id="homeEasyHide" value="0" />
	<input type="hidden" name="brandAndResHide" id="brandAndResHide" />
	<input type="hidden" name="homeEasyPhoneHide" id="homeEasyPhoneHide" />
	<input type="hidden" name="imeiHide" id="imeiHide" />
	<input type="hidden" name="prepayFeeHide" id="prepayFeeHide" />
	<input type="hidden" name="reqContextPath" id="reqContextPath" value="<%=request.getContextPath()%>" />
	<input type="hidden" name="mainOfferName" id="mainOfferName" value="" />
	<input type="hidden" name="minorOfferName" id="minorOfferName" value="" />
	<input type="hidden" name="mainOfferComment" id="mainOfferComment" value="" />
	<input type="hidden" name="minorOfferComment" id="minorOfferComment" value="" />
	<input type="hidden" name="offeridss" id="offeridss" value="" />
	<input type="hidden" name="familyCode" id="familyCode" value="<%=familyCode%>" />
	<input type="hidden" name="famlicodes" id="famlicodes" value="<%=familyCode%>" />
	<input type="hidden" name="familyName" id="familyName" value="<%=familyName%>" />
	<input type="hidden" name="printName" id="printName" value="<%=printName%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" name="pubPrtOfferId" id="pubPrtOfferId" value="" />
	<input type="hidden" name="pubPrtOfferName" id="pubPrtOfferName" value="" />
	<input type="hidden" name="pubPrtOfferComments" id="pubPrtOfferComments" value="" />
	<input type="hidden" name="smzvalue" id="smzvalue"  />
	<input type="hidden" name="kdphone" id="kdphone"  />
	<input type="hidden" name="miantiandankuandai" id="miantiandankuandai"  />
	
	<input type="hidden" name="chengyuanzifei11" id="chengyuanzifei11"  />
	<input type="hidden" name="chengyuanzifeimiaoshu11" id="chengyuanzifeimiaoshu11"  />
	<input type="hidden" name="chengyuanzifei22" id="chengyuanzifei22"  />
	<input type="hidden" name="chengyuanzifeimiaoshu22" id="chengyuanzifeimiaoshu22"  />
	
	<input type="hidden" name="sumFlay" id="sumFlay" value=""  />

	<input type="hidden" name="baseFeeHidd2" id="baseFeeHidd2" value=""  />
	<input type="hidden" name="renewType" id="renewType" value="<%=renewType%>"  />
	<input type="hidden" name="opMebIdx" id="opMebIdx" value=""  />
	
	<input type="hidden" name="innetFeeHidd" id="innetFeeHidd" value="" />
	<input type="hidden" name="innetrateHidd" id="innetrateHidd" value="" />
	<input type="hidden" name="innetRateFeeHidd" id="innetRateFeeHidd" value="" />
	<input type="hidden" name="innetFeeLeftHidd" id="innetFeeLeftHidd" value="" />
	
	<input type="hidden" name="TVCardNoHidd" id="TVCardNoHidd" value="<%=TVCardNo%>" />
	
	<input type="hidden" name="v_membRoleId" id="v_membRoleId" value="<%=v_membRoleId%>" />
	<input type="hidden" name="autoCancelHidd" id="autoCancelHidd" value="" />
	
	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="确认" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" onclick="changeProd()" />
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
