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
 		String v_membRoleId = ""; //�����Ա����
 		if(familyCode.equals("HEJT") ){
 			if("e281".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�����ײʹ�����ͥ";
 			}else if("e282".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�����ײͳ�Ա����";
 			}else if("i088".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�����ײͼ�ͥ��ǩ";
 			}
 		}
 		if( familyCode.equals("JHJT")){
 			if("e281".equals(opCode)){
 				printName2 = "�ͼ�ͥ�ƻ�(MoneyFee)--�ͼ�ͥ�ƻ��ں��ײ͹���Ⱥ�鴴��";
 			}else if("e282".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�ƻ��ں��ײͳ�Ա����";
 			}else if("i088".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�ƻ��ں��ײͼ�ͥ��ǩ";
 			}
 		}
 		if(familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 			if("e281".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�ں��ײʹ�����ͥ";
 			}else if("e282".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�ں��ײͳ�Ա����";
 			}else if("i088".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�ں��ײͼ�ͥ��ǩ";
 			}
 		}
 		
 		if(familyCode.equals("ZHJT")){
 			if("e281".equals(opCode)){
 				printName2 = "�ͼ�ͥ-ħ�ٺ��ں��ײʹ���";
 			}else if("e282".equals(opCode)){
 				printName2 = "�ͼ�ͥ-����ײͳ�Ա����";
 			}else if("i088".equals(opCode)){
 				printName2 = "�ͼ�ͥ-����ײͼ�ͥ��ǩ";
 			}
 		}
 		
 		String TVCardNo = request.getParameter("TVCardNo");//�����ӿ��ţ�HEJT+��ͥ����e281ʱ�����벢ƴ�ӵ�json��
 		
		String v_case = "2";
 		if("i088".equals(opCode)){ //��ͥ��ǩ
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){
 				v_case = "9";
 			}
 		} 		

 		/*gaopeng ���ֿ����ͥ���ںϼ�ͥ�������ӡͷ��չʾ��2014/01/15 16:46:18*/
 		if(familyCode.equals("KDJT")){
 			printOpName = "�����ͥ";
 		}else if(familyCode.equals("RHJT")){
 			printOpName = "�ںϼ�ͥ";
 		}
 		if("e281".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩��������";
 			}
 			else if(familyCode.equals("KDJT") ){
 			printName = "ȫ��ͨ��ͥ�ʷѴ�����ͥ";
 			}
 			else if("RHJT".equals(familyCode)){
 			printName = "�ںϼ�ͥ�ʷѴ�����ͥ";
 			}
 		  else {
 			printName = "�Ҹ���ͥǩԼ����";
 			}
 		}else if("e282".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "����������鳩����";
 			}
 			else if(familyCode.equals("KDJT") ){
 			printName = "ȫ��ͨ��ͥ�ʷѳ�Ա����";
 			}
 			else if("RHJT".equals(familyCode)){
 			printName = "�ںϼ�ͥ�ʷѳ�Ա����";
 			}
 			else {
 			printName = "�Ҹ���ͥ��Աҵ�񶩹�";
 			}
 		}else if("e283".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "�����˳����鳩��";
 			}
 		}else if("i088".equals(opCode)){
 			printName = "�Ҹ���ͥ��ǩ";
 		
 		}else if("e284".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩����ȡ��";
 			}
 		}else if("e285".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩�������";
 			}
 		}
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
	
		System.out.println("----- fe280Main.jsp ---- ��ѯ����" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code0%>" + "<%=msg0%>");
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
		/* ��Ա���� ��Ҫ���÷����ѯ��ͥ���г�Ա��Ϣ */
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
					
					exp_time= exp_time.substring(0,4) +"��"
						+ exp_time.substring(5,6)+"��"
						+ exp_time.substring(7,8)+"��";
				}else{
					if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode)) && "i088".equals(opCode)){
						if("70025".equals(familyMemberList[i][0]) || "70028".equals(familyMemberList[i][0]) || "70031".equals(familyMemberList[i][0]) || "70052".equals(familyMemberList[i][0])){
							v_membRoleId = familyMemberList[i][3];
						}
					}
				}
			}
						if("e281".equals(opCode) || "e282".equals(opCode)){/*��ѯ��Ա�ʷ�--�������鳩��3Ԫ��5Ԫ�����ʷ�*/
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
			/*alert("<%=opCode%>");*/
			if ( $("#opCode").val()=="i088" )
			{
				if ( "N" == $("#renewType").val() )
				{
					if ( <%=familyMemberList.length%>!=familyRoleList.length )
					{
						rdShowMessageDialog( "������ǩȫ����ͥ��Ա��",0 );
						return false;
					}						
				}
				if($("#familyProdInfo").val() == ""){
					rdShowMessageDialog( "��ѡ���ͥ��Ʒ��Ϣ!",0 );
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
              rdShowMessageDialog("����ӡ�<%=printOpName%>�����Ա����");
              return false;
            }
          }
          if(familsyinfo=="1020"||familsyinfo=="1021"||familsyinfo=="1026"||familsyinfo=="1027"){
            if($("#miantiandankuandai").val()==""){
              rdShowMessageDialog("����ӡ�<%=printOpName%>�����Ա����");
              return false;
            }
          }
			<%}%>
			/* ��ť�ӳ� */
			$(subButton).attr("disabled","true");
			/* �º����� */
			getAfterPrompt();		
			familyRoleList = changeObjSeq(familyRoleList);
			familyRoleList.setCreate_accept("<%=printAccept%>");
			familyRoleList.setChnsource("01");
			familyRoleList.setopCode("<%=opCode%>");
			familyRoleList.setLoginNo("<%=work_no%>");
			familyRoleList.setPassword("<%=password%>");
			familyRoleList.setPhone_no_master("<%=parentPhone%>")
			familyRoleList.setOp_note("<%=work_no%>" + "��" + "<%=opName%>" + "����");
			familyRoleList.setProd_code($("#familyProdInfo").val());
			
			familyRoleList.setFamily_code("<%=familyCode%>");
			<%if("XFJT".equals(familyCode)&&"e281".equals(opCode)) {%>
			  familyRoleList.setPay_money($("#baseFeeHidd2").val());
		  <%}else{%>
		    familyRoleList.setPay_money($("#prepayFeeHide").val());
		  <%}%>
			var spInfo = $.trim($('#familyProdInfo').find("option:selected").attr('sp_info'));
			familyRoleList.setSpInfo(spInfo);
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="i088"){//�ͼ�ͥ����ͥ��ǩ
				familyRoleList.setInnet_Fee($("#innetFeeHidd").val());//��װ��
			}
			if(("<%=familyCode%>"=="ZSLL" ) && "<%=opCode%>"=="e281"){//ZSLL
				familyRoleList.setImei_code($.trim($("#ZSLLImei").val()));//IMEI����
			}
			/* add ���������ӿ��� for ����Э��ʵ��BOSS���������ƷѶԽӷ���������@2014/11/25  */
			if(("<%=familyCode%>"=="HEJT" ) && "<%=opCode%>"=="e281"){
				familyRoleList.setTv_no($("#TVCardNoHidd").val());//�����ӿ���
			}
			/* add ��ͥ���� ��������/��������ҵ���ʶ Ĭ��1 for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2014/11/25  */
			if("<%=familyCode%>"=="JTGX" && ("<%=opCode%>"=="e281" || "<%=opCode%>"=="e282")){
				familyRoleList.setBusi_status("1");
			}
			if("<%=familyCode%>"=="ZHJT"  && "<%=opCode%>"=="i088"){//��ϼ�ͥ,��ͥ��ǩ 
				familyRoleList.setAutoCancel($("#autoCancel2").val());//�����Ƿ��Զ�ȡ��
			}
			
			var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});

	
				//alert("������json����---------"+myJSONText);
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
			var ret = showPrtDlg11(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					frmCfm();
				}
			}
			return true;
		}
		
		function printCommit33(opCode){
			var ret = showPrtDlg33(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					frmCfm();
				}
			}
			return true;
		}
		
		function printCommit44(opCode){
			
			var ret = showPrtDlg44(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					frmCfm();
				}
			}
			return true;
		}
		
		function printCommit22(opCode){
			var ret = showPrtDlg22(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
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
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept =$("#printAccept").val();       //��ˮ��
			var printStr = printInfo11(opcode);			 		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           							  //�ʷѴ���
			var fav_code=null;                				 		//�ط�����
			var area_code=null;             				 		  //С������
			var opCode=$("#opCode").val();                   	//��������
			var phoneNo = $("#parentPhone").val();         //�ͻ��绰
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
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept =$("#printAccept").val();       //��ˮ��
			var printStr = printInfo33(opcode);			 		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           							  //�ʷѴ���
			var fav_code=null;                				 		//�ط�����
			var area_code=null;             				 		  //С������
			var opCode=$("#opCode").val();                   	//��������
			var phoneNo = $("#parentPhone").val();         //�ͻ��绰
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
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept =$("#printAccept").val();       //��ˮ��
			var printStr = printInfo44(opcode);			 		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           							  //�ʷѴ���
			var fav_code=null;                				 		//�ط�����
			var area_code=null;             				 		  //С������
			var opCode=$("#opCode").val();                   	//��������
			var phoneNo = $("#parentPhone").val();         //�ͻ��绰
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
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept =$("#printAccept").val();       //��ˮ��
			var printStr = printInfo22(opcode);			 		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           							  //�ʷѴ���
			var fav_code=null;                				 		//�ط�����
			var area_code=null;             				 		  //С������
			var opCode=$("#opCode").val();                   	//��������
			var phoneNo = $("#parentPhone").val();         //�ͻ��绰
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
			/*liujian  ���������ɫ�ĳ�ԱId*/
			var parent_member_Id = '70001'; //�˾�ͨ�ҳ�
			var normal_member_Id = '70002'; //��ͨ��Ա
			var other_member_Id = '70004';  //������Ա
			var offerName = ''; //ָ���ʷ�����
			var offerComment = '';//ָ���ʷ�����
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //ϵͳ�ʷ�����
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //ϵͳ�ʷ�����
			var minorOfferNameVal = $("#minorOfferName").val(); //������Ա�ʷ�����
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//������Ա�ʷ�����
			//alert(normalMemberStr);
			//alert(otherMemberStr);
			//alert("ϵͳ�ʷ�����"+mainOfferCommentVal);
			//alert("������Ա�ʷ�����"+minorOfferNameVal);
			//alert("������Ա�ʷ�����"+minorOfferCommentVal);

			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			var teamPhonenum="";
			var parentphonenum="";
			
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#operPhoneNo").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��" + $("#printName").val()+"|";
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			
			if(opcode=="e281") {
			opr_info += "�������鳩�ĵ��ֻ����룺"+$("#operPhoneNo").val() + "|";

			  var table1=document.getElementById('addRoleTab');
        var rows=table1.rows;
        //alert(rows.length);
        for(var i=1;i<rows.length;i++){
        	if(rows[i].cells[1].innerHTML.indexOf("��Ա") !=-1 ) {
                teamPhonenum+= rows[i].cells[0].innerHTML+"��";
                }
           }
			opr_info += "�������鳩�ĺ��룺" + teamPhonenum +"|";
			}
			else if(opcode=="e282") {
				var table1=document.getElementById('addRoleTab');
        var rows=table1.rows;
        //alert(rows.length);
        for(var i=1;i<rows.length;i++){
        	if(rows[i].cells[1].innerHTML.indexOf("��Ա") !=-1 ) {
                parentphonenum+= rows[i].cells[0].innerHTML+"��";
                }
           }
      opr_info += "�齨���鳩���˺��룺"+ $("#operPhoneNo").val() + "|";
      opr_info += "���μ����ͥ�Ŀ�ѡ��Ա�ֻ����룺" + parentphonenum + "|";
			}
			else if(opcode=="e283") {
			opr_info += "�˳����鳩��ҵ����齨�˺��룺"+$("#operPhoneNo").val() + "|";
			}	
			else if(opcode=="e284") {
			opr_info += "�齨���鳩���˺��룺"+$("#operPhoneNo").val() + "|";
			}
			else if(opcode=="e285") {
			opr_info += "���鳩���齨�˺��룺"+$("#operPhoneNo").val() + "|";
			}
			
			/*liujian add ��ҵ������*/
			/*
				��ͬҵ��չʾ�������ָ���ʷѲ�ͬ
				�Ҹ���ͥ��Աҵ���˶�����ͨ��Ա���ʷ�    ��Ӧ��opcode=e283
				�Ҹ���ͥҵ���˶�    ���˾�ͨ�ҳ����ʷ�  ��Ӧ��opcode=e284
				�Ҹ���ͥǩԼ����������˾�ͨ�ҳ����ʷ�  ��Ӧ��opcode=e285
			*/
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					/*�趨ָ���ʷ�*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					/*ֻ�д���ʱչʾ��ѡ��Ա�����ʷ�*/
					if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
						opr_info_temp = "��ѡ��Ա�����ʷѣ�" + minorOfferNameVal + "|";
						note_info1_temp = "��ѡ��Ա������ʷ�������" + minorOfferCommentVal + "|";
					}
					break;
				case 'e282' :
					/*
					//����仯��ֻҪ����ӵĺ���
					//�ں����еĳ�Ա����
					if(memberPhoneList.length > 0) {
						otherMemberStr = memberPhoneList.join(',') + "," + otherMemberStr;
					}
					*/
					//opr_info += "���μ����ͥ�Ŀ�ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'e283' :
					opr_info += "�����˳���ͥ�ĳ�Ա�ֻ����룺" + otherMemberStr + "|";
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
					opr_info += "��ͥ��Ա�ֻ����룺" + tempMember + "|";
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
				case 'e285' :	
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					/*�趨ָ���ʷ�*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
			}
			if(offerName.length > 0){			
				  //opr_info += "ָ���ʷѣ�" + $("#familyProdInfo").val()+" "+$("#familyProdInfo").find("option:selected").text() + "|";
				  if(opcode=="e281") {

				    opr_info += "ָ���ʷѣ�" + $("#offeridss").val()+""+minorOfferNameVal + "|";
				   }
				  if(opcode=="e282") {
				    opr_info += "ָ���ʷѣ�" + "<%=offerids%>"+offerName + "|";
				   }

			}
			opr_info += opr_info_temp;
			/************ע������************/
			note_info1 += "��ע��" + "|";
			if(offerComment.length > 0){
				//note_info1 += "ָ���ʷ�������" + minorOfferCommentVal + "|";
				
					if(opcode=="e281") {
				    note_info1 += "ָ���ʷ�������" + minorOfferCommentVal + "|";
				   }
				  if(opcode=="e282") {
				    note_info1 += "ָ���ʷ�������" + offerComment + "|";
				   }
			}
			//alert("1"+note_info1);
			note_info1 += note_info1_temp;
			//alert("2"+note_info1);
			note_info1 += "ע�����" + "|";
			if(opcode=="e281") {
			note_info1 += "1���ͻ�����ҵ������Ч��"+"|";
			note_info1 += "2���ͻ�ȡ��ҵ��������Ч��"+"|";
			note_info1 += "3���������鳩�ĵķ����ɼ�����ֻ�����е���"+"|";
			note_info1 += "4����Ա��������Ϊ2�ˡ�"+"|";
			note_info1 += "5�������齨���鳩��ҵ��ʱ���ټ���2����Ա��"+"|";
			note_info1 += "6���齨��ȡ�����鳩��ҵ����������鳩��ҵ���������Żݡ�"+"|";
			}
			else if(opcode=="e282") {
			note_info1 += "1�����������鳩���ײ͵�����Ч��"+"|";
			note_info1 += "2����Ա�������ͬһ���У��ұ���Ϊ�ƶ����롣"+"|";
			note_info1 += "3����Ա���¹��ܷ��ɳ�Ա�ֻ���������֧����"+"|";
			note_info1 += "4��ȡ�����鳩��ҵ��������Ч��"+"|";
			note_info1 += "5���齨��ȡ�����鳩��ҵ����������鳩��ҵ���������Żݡ�"+"|";
			}
			else if(opcode=="e283") {
			note_info1 += "1���ɹ������˶����鳩���ײͣ��Դ����𽫲����������鳩���ײ��Ż�ҵ��"+"|";
			note_info1 += "2���˳�ҵ��������Ч��"+"|";
			note_info1 += "3���齨��ȡ�����鳩��ҵ����������鳩��ҵ���������Żݡ�"+"|";
			
			}	
			else if(opcode=="e284") {
			note_info1 += "1���ƶ��ֻ������˶����鳩���ײͺ��Դ����𽫰��ղ����������鳩��ҵ���Ż��ʷѡ�"+"|";
			note_info1 += "2���齨��ȡ�����鳩��ҵ����������鳩��ҵ���������Żݡ�"+"|";
			/*2013/12/26 16:04:23 gaopeng ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �޸�ȡ������������ӡ��Ϣ*/
			note_info1 += "��ܰ��ʾ��"+"|";
			note_info1 += "�ͻ��������ײ�ҵ��ȡ����ȡ��ʱ����ҳ��ʷ�Ϊ�����������ʷѣ���Ҫ�Ȳ�����Ʒ��ٿ۳�ʣ�����ר���30%��ΪΥԼ�𣬼ҳ��Ϳ��תΪȡ�����ʷѣ�"+"|";
			note_info1 += "������ȡ������Ӫ���ΥԼ�����ͻ��谴������Ʒԭ�۽����ֽ�"+"|";
			note_info1 += "�˶�ʱ�践��Ԫ�����������м�������񿨣���ֹͣ�������"+"|";
			}
			else if(opcode=="e285") {
				/*2013/12/26 16:04:23 gaopeng ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �޸ĳ�������������ӡ��Ϣ*/
				note_info1 += "��ܰ��ʾ��"+"|";
				note_info1 += "�ͻ�����139/188ȫ��ͨ�����ײͳ���ҵ�񣬿ͻ��践��������Ʒ���綪ʧ�밴����Ʒʵ�۽��ɷ��á�"+"|";
			}
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			//alert(note_info1);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		function printInfo33(opcode){
			var other_member_Id = '';  //������Ա
			var kd_member_Id = '';  //�����ͥ
			if("<%=familyCode%>" == "HEJT"){

				other_member_Id = "70024";
				kd_member_Id = "70025";
			}
			if("<%=familyCode%>" == "JHJT"){
				/*�ƻ���ͥ ��Ա����ʱ û�п����ͥ ���ܼӿ����ͥ*/
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
				other_member_Id = "70033"; //��ͨ��Ա
				kd_member_Id = "70034"; //�����Ա
			}
			
			var offerName = ''; //ָ���ʷ�����
			var offerComment = '';//ָ���ʷ�����
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);//
			var kdMemberStr = getPhoneNoByMemberId(kd_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //ϵͳ�ʷ�����
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //ϵͳ�ʷ�����
			var minorOfferNameVal = $("#minorOfferName").val(); //������Ա�ʷ�����
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//������Ա�ʷ�����
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
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#operPhoneNo").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			if("<%=familyCode%>" == "JHJT" && opcode == "e281"){
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��"+mainOfferNameVal+"-�ͼ�ͥ�ƻ��ں��ײ͹���Ⱥ�鴴��|";
			}else if("<%=familyCode%>" == "JHJT" && opcode == "e282"){
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��"+minorOfferNameVal+"-���Ӻͼ�ͥ�ƻ��ں��ײͳ�Ա|";
			}else{
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��<%=printName2%>" +"|";
			}
			
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			<%
			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
			%>
			opr_info += "�ͼ�ͥ-�ں��ײͼҳ����룺" + $("#parentPhone").val() + "|";
		  <%}else if(familyCode.equals("HEJT")) {%>
			opr_info += "�ͼ�ͥ-�����ײͼҳ����룺" + $("#parentPhone").val() + "|";
			<%}else if(familyCode.equals("JHJT")) {%>
			opr_info += "�ͼ�ͥ�ƻ��ں��ײ�Ⱥ���������룺" + $("#parentPhone").val() + "|";
			opr_info += "�������Ӻͼ�ͥ�ƻ��ں��ײͳ�Ա���룺" + otherMemberStr + "|";
			<%}else if(familyCode.equals("ZHJT")) {%>
			opr_info += "�ͼ�ͥ-ħ�ٺ��ں��ײͼҳ����룺" + $("#parentPhone").val() + "|";
			<%}%>
			
			
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					/*�趨ָ���ʷ�*/
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
					/*�趨ָ���ʷ�*/
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
					opr_info += "ָ���ʷѣ�" + offerName + "|";
				}
				if(offerComment.length > 0){
					opr_info += "ָ���ʷ�������" + offerComment + "|";
				}
			}else if(opcode=="e282"){
				if(otherMemberStr != null && otherMemberStr.length > 0){
			<%
			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
			%>
			opr_info += "���μ���ͼ�ͥ-�ں��ײ���ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
		  <%}else if(familyCode.equals("HEJT") ) {%>
			opr_info += "���μ���ͼ�ͥ-�����ײ���ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
			<%}else if(familyCode.equals("JHJT")) {%>
			//opr_info += "�������Ӻͼ�ͥ�ƻ��ں��ײͳ�Ա���룺" + otherMemberStr + "|";
			<%}else if(familyCode.equals("ZHJT")) {%>
			opr_info += "���μ���ͼ�ͥ-����ײ���ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
			<%}%>
						
				}	
			  opr_info += "ָ���ʷѣ�" + offerName + "|";			
		    opr_info += "ָ���ʷ�������" + offerComment + "|";	
			
			}
			opr_info += opr_info_temp;
			/************��ע************/
			
			/*2016/1/19 18:56:10 gaopeng e282��Ա���ʱ ��ӡ���*/
			if("<%=opCode%>" == "e282"){
				if("<%=familyCode%>" == "JHJT"){
					note_info1 += note_info1_temp;
		  		note_info1 += "��ע��" + "|";
		  		note_info1 += "��ʹ�÷�0Ԫ���������ʹ�������ײ���������ÿ�¿�����Ⱥ���ڱ���ͨ�����ʱ��300���ӡ�" + "|";
		  		note_info1 += "ע�����" + "|";	
		  		note_info1 += "1����������������Ч���ǵ���������ԤԼ��Ч��" + "|";	
		  		note_info1 += "2�����빲��ĸ����ͻ��������ͻ������������ͬ���С�" + "|";	
		  		note_info1 += "3������ȡ���ͼ�ͥ�ƻ��ں��ײͺ󣬴��������и����ͻ���������ҵ���Żݡ�" + "|";	
		  		note_info1 += "4����������ײͰ���������������ʹ����������ʱ������ʹ�ø����ײ��ڵ��������������ײ��������������ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ���������ײͲ���������ֱ��ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ�" + "|";	
				
				}
				
			}
			/************ע������************/
			<%if("e281".equals(opCode) || "i088".equals(opCode)) {
			
			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
			%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "ע�����" + "|";
		  			note_info1 += "1�����Ա�ײ��������ͨ��ʱ����������������������ʹ�ó�Ա�ײ������ͨ��ʱ�������������������������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ������������������ͨ��ʱ������������ʹ�������������Ա�û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��"+"|";
						note_info1 += "2���ں��ײ͵������ͳ�Ա����������ͬһ�����У������û����ܰ���ͣ��Ԥ����"+"|";
						note_info1 += "3���ں�Լ���ڣ��ں��ײ��û����ɱ��Ϊ���ں��ײͣ���ȡ���ں��ײ͡�"+"|";
						note_info1 += "4���ֻ�����Ƿ�ѣ����չ�ͣ����������� ���û��ɷѺ�ָ�������ܡ�"+"|";
						note_info1 += "5���ֻ��������û��ʷ�������Ч������԰�װ����ʱ��Ϊ׼��Ч���ײͰ�������ȡʹ�÷ѣ������û��ں��ʷ�ԤԼ��Ч������統�¿���������飬�ֻ��Ϳ��ҵ�����1����Ч����ʼ�Ʒѡ�"+"|";
						note_info1 += "6���ں��ײ��û�ֻ��ͨ���ֻ��˻����ɿ���ѣ�����ͨ������˻������ɷѡ�"+"|";
						note_info1 += "7���ں��ײ���ʹ�÷ѣ���������ȡ�����������°��¡�"+"|";

						
		  <%}else if(familyCode.equals("HEJT")) {%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "ע�����" + "|";
		  			note_info1 += "1�����Ա�ײ��������ͨ��ʱ����������������������ʹ�ó�Ա�ײ������ͨ��ʱ�������������������������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ������������������ͨ��ʱ������������ʹ�������������Ա�û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��"+"|";
						note_info1 += "2�������ײ͵������ͳ�Ա����������ͬһ�����У������û����ܰ���ͣ��Ԥ����"+"|";
						note_info1 += "3���ں�Լ���ڣ�88Ԫ�ײ��û��ɱ����118Ԫ�������ײͣ��貹��100Ԫ�����ն˳�װ�ѣ��������繫˾�ṩ�๦�������նˣ�ԭMODEM�ͻ������践�������ߵ��Ӱ�װ��Ա��118Ԫ�������ײ��û��ɱ��Ϊ��88Ԫ�ײ͡������ײ��û����ɱ��Ϊ�ǰ����ײ͡���ȡ���ײ͡�"+"|";
						note_info1 += "4���ֻ�����Ƿ�ѣ����չ�ͣ����������ܼ����ߵ��ӷ�����ԭ���ߵ����˻�û�з��ã����û��ɷѺ�ָ���������ߵ��ӹ��ܡ�"+"|";
						note_info1 += "5���ͻ�ԭ���ߵ����˻����ò��ˣ����ֻ�����Ƿ�ѻ��Լ�ڽ����󣬿ɼ���ʹ��ԭ���ߵ����˻�����֧�����ߵ��ӻ������ӷѼ���ֵҵ����á�"+"|";
						note_info1 += "6���ֻ��������û��ʷ�������Ч���ײ����ֻ������ߵ��ӷ�����ͬ����Ч������԰�װ����ʱ��Ϊ׼��Ч���ײͰ�������ȡʹ�÷ѣ������û������ʷ�ԤԼ��Ч������統�¿���������飬�ֻ�����������ߵ���ҵ�����1����Ч����ʼ�Ʒѡ�"+"|";
						note_info1 += "7�������ײ��û�ֻ��ͨ���ֻ��˻����ɿ���ѣ�����ͨ������˻������ɷѡ�"+"|";
						note_info1 += "8�������ײ���ʹ�÷ѣ���������ȡ�����������°��¡�"+"|";
			<%}else if(familyCode.equals("JHJT") && "e281".equals(opCode)) {%>
					  note_info1 += note_info1_temp;
					  note_info1 += "��ע��" + "|";
					  note_info1 += "�ͼ�ͥ�ƻ��ں��ײͣ���һ�ֻ��ڼ�ͥȺ��������������Ϳ���๦�ܹ���ҵ�񡣸����ͻ����Թ��������ͻ��ײ������������������ͻ��͸��ͻ���ÿ�¿ɶ������ܱ������г�Ա��ͨ��ʱ��300���ӡ�" + "|";
		  			note_info1 += "ע�����" + "|";
		  			note_info1 += "1����������������Ч���ǵ���������ԤԼ��Ч��"+"|";
						note_info1 += "2�����빲��ĸ����ͻ��������ͻ������������ͬ���С�"+"|";
						note_info1 += "3������ȡ���ͼ�ͥ�ƻ��ں��ײͺ󣬴��������и����ͻ���������ҵ���Żݡ�"+"|";
						note_info1 += "4����������ײͰ���������������ʹ����������ʱ������ʹ�ø����ײ��ڵ��������������ײ��������������ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ���������ײͲ���������ֱ��ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ�"+"|";
			
			<%}else if(familyCode.equals("ZHJT") && "e281".equals(opCode)) {%>
						var autoCancelHidd = $("#autoCancelHidd").val(); //�����Ƿ��Զ�ȡ��
					  note_info1 += note_info1_temp;
		  			note_info1 += "ע�����" + "|";
		  			note_info1 += "1�����Ա�ײ��������ͨ��ʱ����������������������ʹ�ó�Ա�ײ������ͨ��ʱ�������������������������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ������������������ͨ��ʱ������������ʹ�������������Ա�û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��"+"|";
						note_info1 += "2���ͼ�ͥ-ħ�ٺ��ں��ײ͵������ͳ�Ա����������ͬһ�����У������û����ܰ���ͣ��Ԥ����"+"|";
						note_info1 += "3���ں�Լ���ڣ�ħ�ٺ��ں��ײ��û������ڲ�ͬ�۸��ħ�ٺ��ں��ײ��ڱ���ײͣ������ɱ��Ϊ��ħ�ٺ��ں��ײͣ���ȡ��ħ�ٺ��ں��ײ͡�"+"|";
						note_info1 += "4���ֻ�����Ƿ�ѣ����չ�ͣ����������� ���û��ɷѺ�ָ�������ܡ�"+"|";
						note_info1 += "5���ֻ��������û��ʷ�������Ч��ħ�ٺ���Ƶҵ��������Ч������԰�װ����ʱ��Ϊ׼��Ч���ײͰ�������ȡʹ�÷ѣ������û�ħ�ٺ��ں��ʷ�ԤԼ��Ч������統�¿���������飬�ֻ��Ϳ��ҵ��ħ�ٺ���Ƶҵ�����1����Ч����ʼ�Ʒѡ�"+"|";
						note_info1 += "6��ħ�ٺ��ں��ײ��û�ֻ��ͨ���ֻ��˻����ɿ���ѣ�����ͨ������˻������ɷѡ�"+"|";
						note_info1 += "7��ħ�ٺ��ں��ײ���ʹ�÷ѣ���������ȡ�����������°��¡�"+"|";
						if(autoCancelHidd == "0"){
							note_info1 += "8���ͼ�ͥ-ħ�ٺ��ں��ײ͵��ں󣬻����������Զ�������ÿ����20ԪǮ��"+"|";
						}else if(autoCancelHidd == "1"){
							note_info1 += "8���ͼ�ͥ-ħ�ٺ��ں��ײ͵��ں󣬻����������Զ�ȡ����"+"|";
						}
			<%}else if(familyCode.equals("ZHJT") && "i088".equals(opCode)){%>
					var autoCancel2 = $("#autoCancel2").val(); //�����Ƿ��Զ�ȡ��
					note_info1 += note_info1_temp;
					note_info1 += "ע�����" + "|";
					if(autoCancel2 == "0"){
						note_info1 += "1���ͼ�ͥ-ħ�ٺ��ں��ײ͵��ں󣬻����������Զ�������ÿ����20ԪǮ��"+"|";
					}else if(autoCancel2 == "1"){
						note_info1 += "1���ͼ�ͥ-ħ�ٺ��ں��ײ͵��ں󣬻����������Զ�ȡ����"+"|";
					}
			<%}
			}%>
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		/*2016/8/23 15:28:50 gaopeng Ŀǰ��רΪZSLL���������*/
		function printInfo44(opcode){
			var other_member_Id = '';  //������Ա
			var main_Id = '';  //�ҳ�
			if("<%=familyCode%>" == "ZSLL"){

				other_member_Id = "70054";
				main_Id = "70053";
			}
			
			var offerName = ''; //ָ���ʷ�����
			var offerComment = '';//ָ���ʷ�����
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);//
			var mainStr = getPhoneNoByMemberId(main_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //ϵͳ�ʷ�����
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //ϵͳ�ʷ�����
			var minorOfferNameVal = $("#minorOfferName").val(); //������Ա�ʷ�����
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//������Ա�ʷ�����
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
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#operPhoneNo").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			if("<%=familyCode%>" == "ZSLL" && opcode == "e281"){
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ���ն�ר�����������ײ�-��ͥ����|";
			}
			
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			
			<% if(familyCode.equals("ZSLL")) {%>
			opr_info += "�齨��ͥ���룺" + $("#parentPhone").val() + "|";
			opr_info += "�����ͥȺ���Ա���룺" + otherMemberStr + "|";
			<%}%>
			
			
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					/*�趨ָ���ʷ�*/
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
					opr_info += "ָ���ʷѣ�" + offerName + "|";
				}
				if(offerComment.length > 0){
					opr_info += "ָ���ʷ�������" + offerComment + "|";
				}
			}
			opr_info += opr_info_temp;
			/************��ע************/
			
			/************ע������************/
			<%if("e281".equals(opCode) ) {
			
			if(	familyCode.equals("ZSLL")){
			%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "��ע��" + "|";
		  			note_info1 += "0Ԫ���⣬��������ʾ����ʹ�÷�39Ԫ�����������й���ͨ��ʱ��200���ӣ�ʡ���ƶ���������3GB��������ʡ�����г�������һ0.15Ԫ/���ӣ�������������0.3Ԫ/���ӣ�ȫ��������ѣ������������ڶ��۲����۰�̨���������ձ�׼�ʷ�ִ�С���������һ�������ͻ������ײ�����������������ͻ�ʹ�á��ײ���Ч��12���£����ں��������������תΪ���ײ͡�"+"|";

						
		  <%}
		  }%>
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		
		

		
		/*2013/12/23 10:09:14 gaopeng ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �����Ǵ�ӡ��ͥ����RHJT�Ĵ�ӡ���λ��*/
		function printInfo22(opcode){
			var parent_member_Id = '70009'; //�����ͥ�ҳ�
			var normal_member_Id = '70010'; //��ͨ��Ա
			var other_member_Id = '70011';  //������Ա
			var kd_member_Id = '70012';  //�����ͥ
			if("<%=familyCode%>" == "RHJT"){
				parent_member_Id = "50001";
				other_member_Id = "50003";
				kd_member_Id = "50002";
			}
			var offerName = ''; //ָ���ʷ�����
			var offerComment = '';//ָ���ʷ�����
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
			var kdMemberStr = getPhoneNoByMemberId(kd_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //ϵͳ�ʷ�����
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //ϵͳ�ʷ�����
			var minorOfferNameVal = $("#minorOfferName").val(); //������Ա�ʷ�����
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//������Ա�ʷ�����
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
			
			
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#operPhoneNo").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��" + $("#printName").val()+"|";
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			opr_info += getHomeEasyPrintInfo() + "|";
			opr_info += "<%=printOpName%>�ҳ����룺" + $("#parentPhone").val() + "|";
			
			/*liujian add ��ҵ������*/
			/*
				��ͬҵ��չʾ�������ָ���ʷѲ�ͬ
				�Ҹ���ͥ��Աҵ���˶�����ͨ��Ա���ʷ�    ��Ӧ��opcode=e283
				�Ҹ���ͥҵ���˶�    ���˾�ͨ�ҳ����ʷ�  ��Ӧ��opcode=e284
				�Ҹ���ͥǩԼ����������˾�ͨ�ҳ����ʷ�  ��Ӧ��opcode=e285
			*/
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e281' : 
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "�����ͥ�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						//opr_info += "�����ͥ�����Ա���룺" + kdMemberStr + "|";
						
						opr_info += "<%=printOpName%>�����Ա���룺" + $("#miantiandankuandai").val() + "|";
					}

					
					/*�趨ָ���ʷ�*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					/*ֻ�д���ʱչʾ��ѡ��Ա�����ʷ�*/
					if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
						//opr_info_temp = "��ѡ��Ա�����ʷѣ�" + minorOfferNameVal + "|";
						//note_info1_temp = "��ѡ��Ա������ʷ�������" + minorOfferCommentVal + "|";
					}
					break;
				case 'e282' :
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "���μ���Ŀ����ͥ�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "���μ����<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						//opr_info += "���μ���Ŀ����ͥ�����Ա���룺" + kdMemberStr + "|";
							opr_info += "���μ����<%=printOpName%>�����Ա���룺" + $("#miantiandankuandai").val() + "|";
					}
					
					//opr_info += "���μ����ͥ�Ŀ�ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
					if(minorOfferNameVal.length > 0){
						offerName = minorOfferNameVal;
					}
					
					if(minorOfferCommentVal.length > 0){
						offerComment = minorOfferCommentVal;
					}
					break;
				case 'e283' :
					opr_info += "�����˳���ͥ�ĳ�Ա�ֻ����룺" + otherMemberStr + "|";
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
					opr_info += "��ͥ��Ա�ֻ����룺" + tempMember + "|";
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
				case 'e285' :	
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					/*�趨ָ���ʷ�*/
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
				opr_info += "ָ���ʷѣ�" + offerName + "|";
			}
			if(offerComment.length > 0){
				opr_info += "ָ���ʷ�������" + offerComment + "|";
			}
			}else if(opcode=="e282"){
			  opr_info += "ָ���ʷѣ�" + chengyuanzifei11 + "|";			
        opr_info += "ָ���ʷ�������" + chengyuanzifeimiaoshu11 + "|";	
        if(chengyuanzifei22!=""&&chengyuanzifeimiaoshu22!=""){
          opr_info += "ָ���ʷѣ�" + chengyuanzifei22 + "|";
          opr_info += "ָ���ʷ�������" + chengyuanzifeimiaoshu22 + "|";
        }		
			}
			else {
					
		 opr_info += "ָ���ʷѣ�" + chengyuanzifei11 + "|";			
		 opr_info += "ָ���ʷ�������" + chengyuanzifeimiaoshu11 + "|";			
			opr_info += "ָ���ʷѣ�" + chengyuanzifei22 + "|";
			opr_info += "ָ���ʷ�������" + chengyuanzifeimiaoshu22 + "|";

			}
			opr_info += opr_info_temp;
			/************ע������************/
			/*  ����˫Ѽɽ�ֹ�˾���������б��ؼ�ͥ�ʷѵ���ʾ @2013/6/17 */
			var familsyinfo  = $("#familyProdInfo").val();
			
			<%if( (familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e281".equals(opCode)) {%>
          if(familsyinfo!="1020"&&familsyinfo!="1021"&&familsyinfo!="1026"&&familsyinfo!="1027"){ //��ͥ��Ʒ��ϢΪ1020,1021ʱ������ӡע������
            note_info1 += "��ע��" + "|";
      			note_info1 += note_info1_temp;
      			note_info1 += "ע�����" + "|";
      			//note_info1 += getNote();
      			note_info1 += "a�������û�����ֱ��ѡ���ͥ�г��ʷ��ײͣ��ײ��ڰ�����ͨ�������������븱���ļ�ͥ��Ա����������һ��ʱ���ļ�ͥ��Ա֮��ͨ������ͥ��Ա��ͨ��ʱ�������������û���ͥ�ײͰ����Ĺ���ʱ�����������û�����ȫ��ͨƷ�ơ�" + "|";
      			note_info1 += "b�������û���ѡ���κ�Ʒ�ƵĻ����ײ��ʷѣ���������ײ��������ͨ��ʱ��������ʹ�ø����ײ������ͨ��ʱ�������ͨ��ʱ���������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ����" + "|";
      			note_info1 += "c������ͨ��ʱ��ʹ����֮�����������û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��" + "|";
      			note_info1 += "d������ͳ���ͻ����԰���ȫ��ͨ��ͥ�ʷѣ����շѰ��ռ����˻�����ԭ����" + "|";
      			note_info1 += "e�����⡢���񡢲��Կ������ݿ���IP���кʹ��濨���ܰ���" + "|";
      			note_info1 += "f������״̬�����������ͻ����԰���" + "|";
      			note_info1 += "g������ȫ��ͨ��ͥ�ʷѵĳ�Ա����������ͬһ���С�" + "|";
      			note_info1 += "h�����ײͲ��ܰ���ͣ�����ţ��������ͣ�����ţ����������ײͺ����ͣ������;�ֻ��˻�Ƿ�ѣ��ֻ���������ͣ�����������ֹͣ���񣻸�����Ա�����ͥ������Ч���˳�������Ч����ͥ��ɢ������Ч����ͥ��ɢʱ�����ֹͣ����������Ч��"+ "|";
      			note_info1 += "i������Ǵ�������ͻ�����ͥ�ƻ��ʷ�ԤԼ��Ч��������¿�����ͻ�����ͥ�ƻ��ʷ��Կ����Ч���¸���1����Ч��" + "|";
      			note_info1 += "j����������ȫ��ͨ��ͥ�ʷ�,�ҳ�ƾ�������롢�ṩ����ĸ������롢ͬʱ�ṩ��������,���������ͥ�����ӳ�Ա�������Ա��ÿ�½�������һ�Σ�ÿ��һ�����룬���°���������Ч��" + "|";
          }	
          if(familsyinfo=="1022"||familsyinfo=="1023"||familsyinfo=="1024"||familsyinfo=="1025"
          			||familsyinfo=="1038"||familsyinfo=="1039"||familsyinfo=="1040"||familsyinfo=="1041"||familsyinfo=="1042"
          			||familsyinfo=="1043"||familsyinfo=="1044"||familsyinfo=="1045"||familsyinfo=="1046"||familsyinfo=="1047"
          			||familsyinfo=="1048"||familsyinfo=="1049"){ //���ڹ��ֹ�˾����139��138�����ײ͵���ʾ
            note_info1 += "˵����" + "|";
      			note_info1 += "��ܰ��ʾ��" + "|";
      			note_info1 += "1.������Ʒʹ����Ч�������Ʒ˵����" + "|";
      			note_info1 += "2.��ҵ����ǰ������������ţ�������ȡ������Ӫ���ΥԼ�����ͻ��谴������Ʒԭ�۽����ֽ�ϵͳ����ȡ��ʣ��Ԥ������30%��ΪΥԼ��" + "|";
      			note_info1 += "3.��ڼ䣬���ɲ���һ�Σ��������ظ�����" + "|";
      			note_info1 += "4.�ͻ���ȷ���ײ�ר��֮�⣬�д����Ԥ�滰�ѣ��ɳ����ͻ����ʷ���Чǰδ���ʻ��ѣ�����ר���˻������Գ����ײͷ��á�" + "|";
      			note_info1 += "�����������Ϊ�ͻ��������û�����ԭ��������У������û�ֹͣʹ�ø��ײͣ��˶�ʱ�践��Ԫ�����������м�������񿨲�ֹͣ���������ѯ86240000��" + "|";
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
			/* ��ȡ���õĽ�ɫ˳�� */
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
					returnStr += "1��ҵ������Ч������δ������ǰ���ܰ���Ԥ��ҵ��2�����Ч�����˶�ҵ���貹�����������ȡ�ʣ��Ԥ����30%��ΪΥԼ��3���̻����ʹ��ʱ���Զ����Ϊ30Ԫ����TD�ʷ��ײͣ��ɵ�Ӫҵ����ԭ�ʷѣ����°��������Ч��4����ѡ��Ա�˳���ͥ���ɼҳ���������Ӫ���ΥԼ��ȡ���ã�5���������𼰹̻�ע���Ż������������վ���棻6�������Ԥ�桢����Ԥ���֧�������շѺ��ֻ�֧��ҵ��֮���ͨ��ҵ��" + "|";
					for(var i = 0; i < familyRoleList.getLength(); i++){
						roleObj = familyRoleList.getFamRole(i);
						if(roleObj.getMembId() == "70001"){
							$("#homeEasyPhoneHide").val(roleObj.getPhone());
						}
					}
					returnStr += "�ر���ʾ�����ſͻ�VPMN�����ʷѵ����ȼ���������������Ҹ���ͥ�ʷ�" + "|";
				}else if(familyCode == "QWJT"){
					returnStr += "1���ͻ�����ҵ������Ч��" + "|";
					returnStr += "2���ͻ�ȡ��ҵ��������Ч��" + "|";
					returnStr += "3�������������ķ������������齨�˵��ֻ�����е���" + "|";
					returnStr += "4����Ա��������Ϊ1�ˣ����19�ˡ�" + "|";
					returnStr += "5�������齨������ҵ��ʱ���ټ���1����Ա�����������齨�ˣ���" + "|";
					returnStr += "6���齨��ȡ��������ҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}
				else if(familyCode == "TXJT"){
					returnStr += "1���ͻ�����ҵ������Ч��" + "|";
					returnStr += "2���ͻ�ȡ��ҵ��������Ч��" + "|";
					returnStr += "3������������B�ķ�����������B�齨�˵��ֻ�����е���" + "|";
					returnStr += "4����Ա��������Ϊ1�ˣ����19�ˡ�" + "|";
					returnStr += "5�������齨������Bҵ��ʱ���ټ���1����Ա����������B�齨�ˣ���" + "|";
					returnStr += "6���齨��ȡ��������Bҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}
				else if(familyCode == "TSJT"){
					returnStr += "1���ͻ�����ҵ������Ч��" + "|";
					returnStr += "2���ͻ�ȡ��ҵ��������Ч��" + "|";
					returnStr += "3������������C�ķ�����������C�齨�˵��ֻ�����е���" + "|";
					returnStr += "4����Ա��������Ϊ1�ˣ����19�ˡ�" + "|";
					returnStr += "5�������齨������Cҵ��ʱ���ټ���1����Ա����������C�齨�ˣ���" + "|";
					returnStr += "6���齨��ȡ��������Cҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}
				else if(familyCode == "PYJT"){
					returnStr += "1���ͻ�����ҵ������Ч��" + "|";
					returnStr += "2���ͻ�ȡ��ҵ��������Ч��" + "|";
					returnStr += "3������������A�ķ�����������A�齨�˵��ֻ�����е���" + "|";
					returnStr += "4����Ա��������Ϊ1�ˣ����19�ˡ�" + "|";
					returnStr += "5�������齨������Aҵ��ʱ���ټ���1����Ա����������A�齨�ˣ���" + "|";
					returnStr += "6���齨��ȡ��������Aҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}				
				else if(familyCode == "ZDGX"){
					returnStr += "1������������������ֻ���������ͻ��ײ�������������ͨ�Ų��ڹ���Χ�ڣ�" + "|";
					/*2014/08/19 16:37:26 gaopeng ���ڵ������Ͱ���4G�����ײ����ȼ����ⶥ���Ƶ�����
						�޸�2 ���� ������Ч��Ϊ������Ч
					*/
					returnStr += "2���ͻ�����ҵ��������Ч��ȡ��ҵ�������Ч��" + "|";
					returnStr += "3�����빲��ĸ����ͻ��������ͻ������������ͬ���У�" + "|";
					returnStr += "4�����봴����������������ʱ���ټ���1����������ͻ���" + "|";
					returnStr += "5��ÿ����һ�����������룬����10Ԫ���ܷѣ��������û�֧�����������ӵĹ�����벻����4����" + "|";
					returnStr += "6������ȡ��������������������и����ͻ���������ҵ���Żݣ�" + "|";
					returnStr += "7����������ײͰ���������������ʹ����������ʱ������ʹ�ø����ײ��ڵ��������������ײ��������������ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ���������ײͲ���������ֱ��ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѣ�" + "|";
					returnStr += "8�������ͻ��ײ����������������Թ������������ͻ������ײ͡�������ѡ�������Ͱ���Ӫ������͵�������" + "|";
					returnStr += "9����������ҵ��������ͻ����������ͣ��ǿ�ء�Ԥ������ʧ��ҵ����������⣬������ȡ����������ҵ��ĵ��°���ͣ��ǿ�أ�Ԥ������ʧҵ��" + "|";
				}
				/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
				else if(familyCode == "JTGX"){
					returnStr += "1��4G��ͥ�����ײ�ҵ�����4G�ײͿͻ�������4G�ײ�ȡ����4G��ͥ�����ײ�ҵ��ͬ��������"+ "|";
					returnStr += "2���ͻ�����ҵ��������Ч��ȡ��ҵ�������Ч��" + "|";
					returnStr += "3�����빲��ĸ����ͻ��������ͻ������������ͬ���У�" + "|";
					returnStr += "4�������ͻ���ͨ��ʹ�������ͻ���WLAN�˺ţ����֧������ͬʱ��½���ķ�ʽ���������ͻ��й��ڵ�WLAN���������������EDU�ڵ㣬ÿ��50G�ⶥ����" + "|";
					returnStr += "5���������ͻ�С�ڵ�������ʱ��ÿ����ȡ�����ͻ�20Ԫ�¹���ʹ�÷ѣ��������ͻ����ڵ������ˣ�������ˣ�ʱ��ÿ����ȡ�����ͻ�30Ԫ�¹���ʹ�÷ѣ�" + "|";
					returnStr += "6������ȡ��4G��ͥ�����ײͺ󣬴��������и����ͻ���������ҵ���Żݣ�" + "|";
					returnStr += "7����������ײͰ���������������ʹ����������ʱ������ʹ�ø����ײ��ڵ��������������ײ��������������ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ���������ײͲ���������ֱ��ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѣ�" + "|";
					returnStr += "8�������ͻ��ײ����������������Թ������������ͻ������ײ͡�������ѡ�������Ͱ���Ӫ������͵�������" + "|";
					returnStr += "9����������ҵ��������ͻ����������ͣ��ǿ�ء�Ԥ������ʧ��ҵ����������⣬������ȡ����������ҵ��ĵ��°���ͣ��ǿ�أ�Ԥ������ʧҵ��" + "|";
					
				}
				/* end add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
			}else if(opCode == "i088"){

				if ( "N" == $("#renewType").val() )
				{
					returnStr += "1���̻����ʹ��ʱ���Զ����Ϊ30Ԫ����TD�ʷ��ײͣ��ɵ�Ӫҵ����ԭ�ʷѣ����°��������Ч��" + "|";
					returnStr += "2����ѡ��Ա�˳���ͥ���ɼҳ�����" + "|";
					returnStr += "3���������𼰹̻�ע���Ż������������վ���棻" + "|";
					returnStr += "4�����������δ����ǰ����ǩ��δ��Ч֮ǰ�����ٰ��������ʷѵĳ�Ա���롢��Ա�˳�����Ա�������Ʒ�������ͥ��ɢ�Ȳ�������Ҫ��������������ǩ������"+ "|";
				}
				else
				{
					returnStr += "1��ҵ������Ч" + "|";
					returnStr += "2���̻����ʹ��ʱ���Զ����Ϊ30Ԫ����TD�ʷ��ײͣ��ɵ�Ӫҵ����ԭ�ʷѣ����°��������Ч��" + "|";
					returnStr += "3����ѡ��Ա�˳���ͥ���ɼҳ�����" + "|";
					returnStr += "4���������𼰹̻�ע���Ż������������վ���棻" + "|";
				}
				
			}else if(opCode == "e282"){
				if(familyCode == "XFJT"){
					var familsyinfos  = $("#familyProdInfo").val();
					returnStr += "1���������Ҹ���ͥ�ײ͵�����Ч��" + "|";
					returnStr += "2����ͥ��Ա�������ͬһ���С�" + "|";
									if(familsyinfos=="1006") {}
					else {
					returnStr += "3����ͥ��Ա���¹��ܷ��ɼ�ͥ��Ա�ֻ���������֧����" + "|";
					}
				}else if(familyCode == "QWJT"){
					returnStr += "1���������������ײ͵�����Ч��" + "|";
					returnStr += "2����Ա�������������ʡ���ұ���Ϊ�ƶ����롣" + "|";
					returnStr += "3����ֻ�ܹ�����һ����������" + "|";
					returnStr += "4����Ա���¹��ܷ����������齨���ֻ�����֧����" + "|";
					returnStr += "5��ȡ��������ҵ��������Ч��" + "|";
					returnStr += "6���齨��ȡ��������ҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}
				else if(familyCode == "TXJT"){
					returnStr += "1��������������B�ײ͵�����Ч��" + "|";
					returnStr += "2����Ա�������������ʡ���ұ���Ϊ�ƶ����롣" + "|";
					returnStr += "3����ֻ�ܹ�����һ��������B��" + "|";
					returnStr += "4����Ա���¹��ܷ���������B�齨���ֻ�����֧����" + "|";
					returnStr += "5��ȡ��������Bҵ��������Ч��" + "|";
					returnStr += "6���齨��ȡ��������Bҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}
				else if(familyCode == "TSJT"){
					returnStr += "1��������������C�ײ͵�����Ч��" + "|";
					returnStr += "2����Ա�������������ʡ���ұ���Ϊ�ƶ����롣" + "|";
					returnStr += "3����ֻ�ܹ�����һ��������C��" + "|";
					returnStr += "4����Ա���¹��ܷ���������C�齨���ֻ�����֧����" + "|";
					returnStr += "5��ȡ��������Cҵ��������Ч��" + "|";
					returnStr += "6���齨��ȡ��������Cҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}	
				else if(familyCode == "PYJT"){
					returnStr += "1��������������A�ײ͵�����Ч��" + "|";
					returnStr += "2����Ա�������������ʡ���ұ���Ϊ�ƶ����롣" + "|";
					returnStr += "3����ֻ�ܹ�����һ��������A��" + "|";
					returnStr += "4����Ա���¹��ܷ���������A�齨���ֻ�����֧����" + "|";
					returnStr += "5��ȡ��������Aҵ��������Ч��" + "|";
					returnStr += "6���齨��ȡ��������Aҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}							
				else if(familyCode == "ZDGX"){
					returnStr += "1������������������ֻ���������ͻ��ײ�������������ͨ�Ų��ڹ���Χ�ڣ�" + "|";
					/*2014/08/19 16:37:26 gaopeng ���ڵ������Ͱ���4G�����ײ����ȼ����ⶥ���Ƶ�����
						�޸�2 ���� ������Ч��Ϊ������Ч
					*/
					returnStr += "2�����ӵ�����������������Ч����������ϵ������Ч��" + "|";
					returnStr += "3�����빲��ĺ�����������������������ͬ���У�" + "|";
					returnStr += "4��ÿ����һ�������Ա������10Ԫ���ܷѣ��������û�֧�����������ӵĹ����ն˲�����4����" + "|";
					returnStr += "5����������ײͰ���������������ʹ����������ʱ������ʹ�ø����ײ��ڵ��������������ײ��������������ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ���������ײͲ���������ֱ��ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѣ�" + "|";
					returnStr += "6�������ͻ��ײ����������������Թ������������ͻ������ײ͡�������ѡ�������Ͱ���Ӫ������͵�������" + "|";
				}
				/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
				else if(familyCode == "JTGX"){
					returnStr += "1���ͻ�����ҵ��������Ч��ȡ��ҵ�������Ч��" + "|";
					returnStr += "2�����빲��ĸ����ͻ��������ͻ������������ͬ���У�" + "|";
					returnStr += "3���������ͻ�С�ڵ�������ʱ��ÿ����ȡ�����ͻ�20Ԫ�¹���ʹ�÷ѣ��������ͻ����ڵ������ˣ�������ˣ�ʱ��ÿ����ȡ�����ͻ�30Ԫ�¹���ʹ�÷ѣ�" + "|";
					returnStr += "4������ȡ��4G��ͥ�����ײͺ󣬴��������и����ͻ���������ҵ���Żݣ�" + "|";
					returnStr += "5����������ײͰ���������������ʹ����������ʱ������ʹ�ø����ײ��ڵ��������������ײ��������������ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѡ���������ײͲ���������ֱ��ʹ�ù�����������������������󣬸����ͻ��������������������͸����ͻ��ײ��������ʷѱ�׼�Ʒѣ�" + "|";
					returnStr += "6�������ͻ��ײ����������������Թ������������ͻ������ײ͡�������ѡ�������Ͱ���Ӫ������͵�������" + "|";
					returnStr += "7������4G�ײ�ȡ���󣬼�ͥȺ��ͬ��ȡ����" + "|";
				}
				/* end add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
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
		/*2015/05/19 16:48:04 gaopeng ��Ӱ�ť����*/
		function addRole(rowNum){
			
			if ( "i088" == $("#opCode").val() )
			{
				if ( "none"!= document.all.busiAcceptContent.style.display  )
				{
					rdShowMessageDialog( "��ǰ���г�Ա��������,��������³�Ա!" , 0 );
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

			/*���ӿ��У��*/
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e281".equals(opCode)) {%>			
				var familsyinfo  = $("#familyProdInfo").val();
				var kuandai  = $("#kuandai").val();
				if(familsyinfo==""){
					rdShowMessageDialog("��ѡ���ͥ��Ʒ��Ϣ��");
					return false;
				}
		     if(kuandai.trim()=="") {
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"|| familsyinfo=="1021" || familsyinfo=="1027" ||familsyinfo=="1023"||familsyinfo=="1025"
		     		||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {
		     			rdShowMessageDialog("����˺�Ϊ�գ���ѡ���½������ѡ�");
		          return false;
		     		}
		     }else {
		     		if(familsyinfo=="1005"||familsyinfo=="1009"|| familsyinfo=="1011"|| familsyinfo=="1013"|| familsyinfo=="1020" || familsyinfo=="1026"||familsyinfo=="1022"||familsyinfo=="1024"
		     				||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {
						    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","�����ύ�У����Ժ�......");
						    
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								
								 if(kdchecknum=="1") {
								 				rdShowMessageDialog("�˿���˺�Ϊ�ѿ����������ѡ�����п����ѡ�");
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
		     				var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","�����ύ�У����Ժ�......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								 if(kdchecknum=="0") {
								 				rdShowMessageDialog("�˿���˺�Ϊδ�����������ѡ���½������ѡ�");
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
		     rdShowMessageDialog("��ѡ���ͥ��Ʒ��Ϣ��");
		     return false;
		     }
		     if(kuandai.trim()=="") {
		     		if(familsyinfo=="1007"||familsyinfo=="1010"|| familsyinfo=="1012"|| familsyinfo=="1014"
		     		||familsyinfo=="1038"||familsyinfo=="1040"||familsyinfo=="1042"||familsyinfo=="1044"||familsyinfo=="1046"||familsyinfo=="1048") {
		     			//rdShowMessageDialog("����˺�Ϊ�գ�������һ���ѿ����Ŀ���˺ţ�");
		          //return false;
		     		}
		     }else {
		     		if(familsyinfo=="1005"||familsyinfo=="1009"|| familsyinfo=="1011"|| familsyinfo=="1013"
		     		||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {		     			
						    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","�����ύ�У����Ժ�......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								 if(kdchecknum=="1") {
								 				rdShowMessageDialog("�˿���˺�Ϊ�ѿ��������������һ��δ��������˺ţ�");
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
		
		
			
			/* ��ͥ��Ʒ��Ϣ */
			/* ���ݼ�ͥ��Ʒ����ɫ��������Ӵ˽�ɫ����ҵ�������
					���ʷѱ������ѡ�ʷѱ����Ӫ������SPҵ��  ��ϡ�
			*/
			var famProdInfoObj = $("#familyProdInfo");
			if(famProdInfoObj.val() == ""){
				rdShowMessageDialog("��ѡ���ͥ��Ʒ��");
				if ( "i088" == $("#opCode").val() )
				{
					if ( "N" == $("#renewType").val() )
					{
						$("#rn_meb_add"+rowNum).attr("disabled" , false);
					}
				}
				return false;
			}
			/* ��ͥ��ɫ */
		
			
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
			
			/* ��ɫ��ʶ */

			
			
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
							 		if(skdphonenum>0) {//����ǿ����ͥ�������Ѿ����������˺���
							 			 return false;
							 		}
						 		}

		     		}
			<%}%>
			/* ��ѯ�ý�ɫ��Ҫ��ҵ�����ִ��˳�� */
			var getdataPacket = new AJAXPacket("getBusi.jsp","���ڻ�����ݣ����Ժ�......");
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
				
				rdShowMessageDialog("��ѯҵ��������" + retCode + ":" + retMsg);
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
						/*����Ǽҳ��Ļ����Ͳ����ֶ���д�����ֻ����������*/
						
						var phoneNoObj = $("#phoneNo");
						phoneNoObj.val("<%=parentPhone%>");
						phoneNoObj.attr("readonly","readonly");
						$("#pwdContent").hide();
					}
					/*ZSLL 39Ԫ�ն�ר�����������ײ� ��ӳ�Աʱ��չʾIMEI����Ϣ*/
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
						/* MO ����	���ʷѱ�� */
						//alert(1273);
						$("#signMOFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"MO");
						/*** ���e28066���������Ϣ��������ʾ@2014/10/23 ***/
						var retCode_getOfferCon = $("#retCode_getOfferCon").val();
						var retMsg_getOfferCon = $("#retMsg_getOfferCon").val();
						<%if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode) || "ZHJT".equals(familyCode)) && "e281".equals(opCode) ) {%>		
								if(retCode_getOfferCon != "000000"){
									rdShowMessageDialog("��ǰ����Ȩ�޲��㣡������룺"+retCode_getOfferCon+"<br>������Ϣ��"+retMsg_getOfferCon);
									window.location.href="fe280.jsp?activePhone=<%=parentPhone%>";
								}
						<%}%>
						/*** ���e28066���������Ϣ��������ʾ@2014/10/23 ***/
					}else if(n[0] == "AO"){
				
						/* AO ����	��ѡ�ʷѱ�� */
						$("#signAOFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"AO");
					}else if(n[0] == "SP"){
				
						/* SP ����	����ҵ�� */
						getSP(memRoleId,prodCode,famRole,"SP")
					}
					/*gaopeng 20140108 */
					else if(n[0] == "YX"){
						/* YX ����	Ӫ���� */
					
						$("#signMarketFlag").val("1");
						getYX(memRoleId,prodCode,famRole,"YX")
					}
					else if(n[0] == "KD"){
					
						/* YX ����	Ӫ���� */
						$("#signKDFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"KD");						
					}
					/*gaopeng 2013/12/23 14:25:53 ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �ж�CX��ʱ�򣬷��ش���Ʒҵ�������� start*/
					else if(n[0] == "CX"){
						$("#signCXFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"CX");
					}else if(n[0] == "WL"){
						$("#signWLFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"WL");
					}else if(n[0] == "ZK"){
						$("#signZKFlag").val("1");
						getOffer(memRoleId,prodCode,famRole,"ZK");
					}else if(n[0] == "WT" && "<%=opCode%>" == "e281"){ /* add for ���ڿ������������Ӱ��ں��ײ͵�����@2014/12/29 */
						
						$("#signWTFlag").val("1");
						getWT(memRoleId,prodCode,famRole,"WT");
					}
					/*gaopeng 2013/12/23 14:25:53 ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �ж�CX��ʱ�򣬷��ش���Ʒҵ�������� end*/
				});
				<%if(("HEJT".equals(familyCode) || "JHJT".equals(familyCode) || "HJTA".equals(familyCode) || "HJTB".equals(familyCode) || "ZHJT".equals(familyCode)) && "e281".equals(opCode) ) {%>	
						var checkedLength = $("input[type='checkbox'][id^='complex_MO'][checked]").length;
						if(memRoleId == "70023" || memRoleId == "70026" || memRoleId == "70029" || memRoleId == "70032"){
							if(checkedLength == 0){
								rdShowMessageDialog("��ǰ����Ȩ�޲��㣡�޷����д���������");
								window.location.href="fe280.jsp?activePhone=<%=parentPhone%>";
							}
						}
				<%}%>
			}
		}
		function getSP(memRoleId,prodCode,famRole,busiType){
			if("70001" == memRoleId){
				/* �˾�ͨ */
				$("#signHomeEasyFlag").val("1");
				var getdataPacket = new AJAXPacket("getHomeEasy.jsp","���Ժ�...");
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
				/* ����ͨ */
				$("#signKinshipFlag").val("1");
				var getdataPacket = new AJAXPacket("getKinship.jsp","���Ժ�...");
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
			var getdataPacket = new AJAXPacket("getWT.jsp","���Ժ�...");
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
					if(operMemberId=="70034"){ //���
						chginptype1();
						//$("#zhjt1").css("display","");
						//$("#zhjt2").css("display","");
						//$("#zhjt3").css("display","");
					}else if(operMemberId=="70032") { //�ҳ�
					}
					else {
					  chginptype2();
					}
			<%}%>
			
			$("#busiAcceptContent").show();			
		}
		
		/*gaopeng 20121123 ����Э�������˾�ͨ�ʷѷ����ĺ�
		����Ϊ��ȡӪ�������ݵ�ajax����
		*/
		function getYX(memRoleId,prodCode,famRole,busiType){
			/* Ӫ������ҪУ��IMEI�룬��Ӱ�ť�û� */
			var checkAndAddObj = $("#checkAndAdd");
			checkAndAddObj.attr("disabled","true");
			var getdataPacket = new AJAXPacket("getMarketing.jsp","���Ժ�...");
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
			/* �ʷѱ���࣬����ҵ��������Ϣ */
			
			var getdataPacket = new AJAXPacket("getOfferContent.jsp","���Ժ�...");
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
			$('#chenynames').html("��Ա�ֻ�����");
			var obj = document.getElementById("phoneNo"); 
			obj.setAttribute("readOnly",false); 
			}
			<%}%>
			
			$("#busiAcceptContent").show();			
		}
		
		function doGetHtml(data){
			//alert(data);
			
			$("#busiAccept").append(data);
			/*gaopeng 2014/01/09 10:56:53 �Ż�С�������չʾ���ݣ���ֹ����չʾ��*/
			
				var nowStatusUse = $("#nowStatusUse").val();
				if(nowStatusUse == "MO"){
						$.each($("input[id^='complex_MO']:checked"),function(i,n){
			        if($(this).val()!=""||$(this).val()!=null){//���ʷ�
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
				/*2015/10/22 10:06:21 gaopeng ���ڿ������ͼ�ͥ�ƻ����ں��ײ�����ĺ�
					JHJT 70050ʲôҲ��
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
			$('#chenynames').html("��Ա�ֻ�����");
			var obj = document.getElementById("phoneNo"); 
			obj.setAttribute("readOnly",false); 
			}
			<%}%>
	
			$("#busiAcceptContent").show();
		}
		/*2015/05/19 16:36:10 gaopeng У��&��ӳ�Ա��ť*/
		function addRoleToSelected(){		
			var phoneNoVal = "";
			var chkHEJTFlag = "Y";
			
			
			
			<%if((familyCode.equals("ZHJT")) && ("e281".equals(opCode))){%>
					var spEnterpriCode = $("#spEnterpriCode").val(); //SP��ҵ����
					var spBusiCode = $("#spBusiCode").val(); //SPҵ�����
					var STBId = $("#STBId").val(); //������id
					var postalCode = $.trim($("#postalCode").val()); //��������
					
					var installAddr = $("#installAddr").val(); //װ����ַ
					
					var v_operMemberId = $('#operMemberId').val();
					if(v_operMemberId == "70034"){ //�����Ա
						if(spEnterpriCode == ""){
							rdShowMessageDialog("������SP��ҵ���룡");
							return false;
						}
						if(spBusiCode == ""){
							rdShowMessageDialog("������SPҵ����룡");
							return false;
						}
						if(STBId == ""){
							rdShowMessageDialog("�����������id��");
							return false;
						}
						if(STBId.length < 32){
							rdShowMessageDialog("������id����Ϊ32λ������д������");
							return false;
						}
						
						if(!checkElement(document.all.postalCode)) return false;
						if(postalCode.length != 6){
							rdShowMessageDialog("�ʱ����Ϊ6λ��");
							return false;
						}
						if(installAddr == ""){
							rdShowMessageDialog("������װ����ַ��");
							return false;
						}
					}
			<%}%>
			
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)){%>
					var v_operMemberId = $('#operMemberId').val();
					if(v_operMemberId == "70025" || v_operMemberId == "70028" || v_operMemberId == "70031" || v_operMemberId == "70034" || v_operMemberId == "70052"){
						var checkPwd_Packet = new AJAXPacket("fe280_ajax_getPhoneNo.jsp","���ڽ�������У�飬���Ժ�......");
						checkPwd_Packet.data.add("kuandai",$("#phoneNo").val().trim());				
						core.ajax.sendPacket(checkPwd_Packet, function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							var phoneNo = packet.data.findValueByName("phoneNo");//�����Ӧ���ֻ�����
							if(retCode == "000000"){
								if(phoneNo == ""){
									rdShowMessageDialog("����Ŀ���˺Ų����ڣ�����¼��Ŀ���˺Ų���ȷ�����������룡");
									chkHEJTFlag = "N";
								}else{
									phoneNoVal = phoneNo;
									$("#phoneNoHidden").val(phoneNoVal);
								}
							}else{
								rdShowMessageDialog("��ȡ�ֻ�����ʧ�ܣ�������룺"+retCode+"<br>������Ϣ��"+retMsg);
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
					if(v_operMemberId == "70025" || v_operMemberId == "70028" || v_operMemberId == "70031" || v_operMemberId == "70034" || v_operMemberId == "70052"){ //��ͥ��ɫ70025�Ǽ�ͥ�����Ա,�� ��֤�ͼ�ͥ��ӪҵԱѡ��ļ�ͥ��Ʒ�Ƿ���ȷ
						var getdataPacket = new AJAXPacket("chkHEJTProd.jsp","���Ժ�...");
						getdataPacket.data.add("opCode","<%=opCode%>");
						getdataPacket.data.add("parentPhone","<%=parentPhone%>");
						getdataPacket.data.add("familyCode","<%=familyCode%>");
						getdataPacket.data.add("familyProdInfo",$("#familyProdInfo").val());
						getdataPacket.data.add("phoneNoVal",phoneNoVal);
						core.ajax.sendPacket(getdataPacket,function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							if(retCode != "000000"){
								rdShowMessageDialog("У�鲻ͨ����" + retCode + "��" + retMsg);
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
			    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","�����ύ�У����Ժ�......");
					getdataPacket.data.add("iCfmLogin",kuandai);	
					core.ajax.sendPacket(getdataPacket,checkSMZValue);
					
					 var kdchecknum = $("#smzvalue").val();
					 if(kdchecknum=="1") {
					 				rdShowMessageDialog("�˿���˺�Ϊ�ѿ��������������һ��δ��������˺ţ�");
			          return false;
					 }
			 }
					 
		<%}%>
				<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && "e282".equals(opCode)) {%>		
			var familsyinfo  = $("#familyProdInfo").val();
	     var kuandai  = $("#phoneNo").val();

		     		if(familsyinfo=="1005"||familsyinfo=="1009"|| familsyinfo=="1011"|| familsyinfo=="1013"
		     		||familsyinfo=="1039"||familsyinfo=="1041"||familsyinfo=="1043"||familsyinfo=="1045"||familsyinfo=="1047"||familsyinfo=="1049") {		     			
						    var getdataPacket = new AJAXPacket("fe280_checkKD.jsp","�����ύ�У����Ժ�......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue);
								
								 var kdchecknum = $("#smzvalue").val();
								 if(kdchecknum=="1") {
								 				rdShowMessageDialog("�˿���˺�Ϊδ���������������һ���ѿ�������˺ţ�");
						          return false;
								 }
						 }
						 

					 
		<%}%>
			var tempOfferCode = $('#mainOffer').val();
			/*У��IMEI�Ƿ���֤ 39Ԫ�ײ�*/
			if("<%=familyCode%>" == "ZSLL" && "<%=opCode%>" == "e281"){
						var v_operMemberId = $('#operMemberId').val();
						
						if(v_operMemberId == "70054"){
							if(!imeiChkFlag){
								rdShowMessageDialog("����֤IMEI�룡");
								return false;
							}
						}
				
				}
				
			/* У�� */
			if(!checkBusiness()){
				return false;
			}
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
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>	
				var getdataPacket = new AJAXPacket("fe280_qryKDPhone.jsp","�����ύ�У����Ժ�......");
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
				var getdataPacket = new AJAXPacket("fe280_checkKDDuplicate.jsp","�����ύ�У����Ժ�......");
				getdataPacket.data.add("Phone_NO",phoneNoVal);	
				core.ajax.sendPacket(getdataPacket,checkKDchongfu);								
				if(kdchongfuqj>1) {
				rdShowMessageDialog("ֻ�ܼ���һ��TD�̻���Ա����ȷ�Ϻ�����ӣ�");
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
			/* ��ҵ�������� */
			clearBusiContent();
			/*liujian add */
			if(tempOperMemberId == '70001') {
					setOffer(tempOfferCode);
			}
		}
		
		function doGetSystemFeeInfo(packet){
		  var monBaseFee = packet.data.findValueByName("monBaseFee");  //����ϵͳ��ֵ���߽�� 
		  var freeFee = packet.data.findValueByName("freeFee");        //����ϵͳ��ֵ����
		  var baseFee = packet.data.findValueByName("baseFee");        //������  
		  var activeTerme = packet.data.findValueByName("activeTerme");//����ϵͳ��ֵ�·�
		  $("#monBaseFeeHidd").val(monBaseFee);
		  $("#freeFeeHidd").val(freeFee);
		  $("#baseFeeHidd").val(baseFee);
		  $("#baseFeeHidd2").val(baseFee);
		  $("#activeTermeHidd").val(activeTerme);
		  
		}
		
		/*liujian ��������д�ӡ���ʷ�,ֻ�������˾�ͨ�ҳ�ʱ����*/
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
			var delRoleObj; 
			for(var i = 0; i < familyRoleList.getLength(); i++){
				famRoleObj = familyRoleList.getFamRole(i);
				if(phoneNo == famRoleObj.getPhone()){
				delRoleObj = famRoleObj;
				<%if(familyCode.equals("KDJT") && ("e281".equals(opCode) || "e282".equals(opCode))) {%>	
				var getdataPacket = new AJAXPacket("fe280_checkKDDuplicate.jsp","�����ύ�У����Ժ�......");
				getdataPacket.data.add("Phone_NO",phoneNo);	
				core.ajax.sendPacket(getdataPacket,checkKDchongfu2);								
				<%}%>
				
				
				
				
				
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
			
			if ( "i088" == $("#opCode").val() )
			{
				obj.disabled = true ;
			}			
			/*4G  ZDGXɾ���ҳ����Ƴ����г�Ա*/
			if("<%=familyCode%>" == "ZDGX"){
				if(delRoleObj.getMembId() == "40001"){
					$("input[name='delRole']").click();
				}
			}
			/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
			if("<%=familyCode%>" == "JTGX"){
				if(delRoleObj.getMembId() == "40003"){
					$("input[name='delRole']").click();
				}
			}
			/* end add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
		}
		function createBusiness(famRoleObj){
			/* Ϊ��Աƴ��ҵ�� */
			/* �������е�ҵ�񣬷ֱ�ƴ�� */
			if($("#signAOFlag").val() == "1"){
				/* ƴ���Ͽ�ѡ�ʷ�AO */
				famRoleObj = createAO(famRoleObj);
			}
			/*gaopeng 2013/12/23 14:00:44 139 188�ں����ײ͵���ʾ ƴ���ϴ���ƷCX start*/
			if($("#signCXFlag").val() == "1"){
				famRoleObj = createCX(famRoleObj);
			}
			/*gaopeng 2013/12/23 14:00:44 139 188�ں����ײ͵���ʾ ƴ���ϴ���ƷCX end*/
			if($("#signMOFlag").val() == "1"){
				/* ƴ�������ʷ�MO */
				famRoleObj = createMO(famRoleObj);
			}
			if($("#signWLFlag").val() == "1"){
				/* ƴ�������ʷ�MO */
				famRoleObj = createWL(famRoleObj);
			}
			if($("#signZKFlag").val() == "1"){
				/* ƴ�������ʷ�MO */
				famRoleObj = createZK(famRoleObj);
			}
			
			if($("#signWTFlag").val() == "1"){
				famRoleObj = createWT(famRoleObj);
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

				<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e281".equals(opCode)) {%>
				var memRoleIdnew = $("#memssRoleId_MO_" + i).val();
				  if(memRoleIdnew=="70023" || memRoleIdnew=="70026" || memRoleIdnew=="70029" || memRoleIdnew=="70032"|| memRoleIdnew=="70050") { //�ҳ�
				  						//alert("�ʷ�����"+offerComment);
				  						//alert("�ʷ�����"+offerName);
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
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
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
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
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
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
			*/
			var spEnterpriCode = $("#spEnterpriCode").val(); //SP��ҵ����
			var spBusiCode = $("#spBusiCode").val(); //SPҵ�����
			var STBId = $("#STBId").val(); //������id
			var postalCode = $("#postalCode").val(); //��������
			var autoCancel = $("#autoCancel").val(); //�����Ƿ��Զ�ȡ��
			$("#autoCancelHidd").val(autoCancel);
			var installAddr = $("#installAddr").val(); //װ����ַ
			var phoneNo = $("#phoneNo").val(); //����˺� 
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
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
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
				  if(memRoleIdnew=="70024" || memRoleIdnew=="70027" || memRoleIdnew=="70030" || memRoleIdnew=="70033" || memRoleIdnew=="70051") { //��ͨ��Ա
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
				
			/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
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
			/* end add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
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
		/*gaopeng 2013/12/23 14:24:05 ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ ����µ�json��ƴ�� start*/
		function createCX(famRoleObj){
			/* 	Ϊ��ɫ�������� 
					���ʷѱ���Ϳ�ѡ�ʷѱ�����ã���Ϊ�ȽϹ̶�
					businessId ��ʶ�� ���ʷ�(MO) ���� ��ѡ�ʷ�(AO)
					offerId ��ʶ�ʷѴ���
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
		/*gaopeng 2013/12/23 14:24:05 ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ ����µ�json��ƴ�� end*/
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
			/* begin  ����Э�����ü�ͥ�ն˲�ƷӪ��������ͳ�Ʊ���ĺ� @2013/8/8*/
			/* 
			    �Ҹ���ͥ����ͥ����ʱ��
			    json������������������������ϵͳ��ֵ���߽�����ϵͳ��ֵ���ϵͳ��ֵ�ר������ޡ�ϵͳ��ֵ����ר�������
			  */
			<%if("XFJT".equals(familyCode)&&"e281".equals(opCode)) {%>
			  business.setCash_pay($("#baseFeeHidd").val());
			  business.setInnet_fee($("#monBaseFeeHidd").val());
			  business.setChoice_fee($("#freeFeeHidd").val());
			  business.setOther_fee($("#activeTermeHidd").val());
			  business.setHand_fee($("#activeTermeHidd").val());
		  <%}%>
		  /* end  ����Э�����ü�ͥ�ն˲�ƷӪ��������ͳ�Ʊ���ĺ� @2013/8/8*/
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
      <%if(familyCode.equals("KDJT") || "RHJT".equals(familyCode)) {%>	
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
			
			var rowNum = $("#opMebIdx").val();
			if ( "i088" == $("#opCode").val() )
			{
				$("#rn_meb_add"+rowNum).attr("disabled" , false);
			}

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
			var zdgxNum = getSelectedMembNum("40001");
			$.each(resule0Obj,function(i,n){
				var ctrlBtnStr = "#addRole" + i;
				var selectedMemNum = getSelectedMembNum(n.value);
				var addedMemberNum = 0;
				var selectedMemStr = "#selectedMem_"+i;
				addedMemberNum = parseInt($(selectedMemStr).val()) + parseInt(selectedMemNum);
				$("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)").html("" + addedMemberNum);
				var ctrlFlag = checkMemberNo(n.value,addedMemberNum);
				/*4G��Ŀ��ZDGX��ͥ����ͥ��������������Ӽҳ�*/
				if("<%=familyCode%>" == "ZDGX" && "<%=opCode%>"=="e281" && ctrlFlag != "-1"){
					var memRoleIdVal = $(this).parent().parent().find("input[id^='memRoleId_']").val();
					/*������ն˹���ҳ�  40001�� �����Ϊ0 ��ֻ�мҳ�����Ӱ�ť�ɵ�*/
					if(zdgxNum == 0){
						if(memRoleIdVal == "40001"){
							ctrlFlag = "0";
						}else{
							ctrlFlag = "1";
						}
					}
				}
				if(ctrlFlag == "1"){
					/*��������ӣ���ť�û�*/
					$(ctrlBtnStr).attr("disabled","true");
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
				rdShowMessageDialog("������������룡");
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
					rdShowMessageDialog("��ѡ��" + $(n).attr("v_name"));
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
						    var getdataPacket = new AJAXPacket("fe280_qryKDPhone.jsp","�����ύ�У����Ժ�......");
								getdataPacket.data.add("iCfmLogin",kuandai);	
								core.ajax.sendPacket(getdataPacket,checkSMZValue1);
								
								 var kdchecknums = $("#kdphone").val();
						 phoneNoVal =kdchecknums;
						}
		<%}%>
			/* ������У��  */
			/* �ͼ�ͥ����ͥ��������Ա���룬�ͼ�ͥ�ƻ�-�ں��ײͣ�JHJT������У������*/
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>		
			<%}else{%>
					if("<%=pwrf%>" == "false" && "M" != $("#signFamRoleFlag").val()){
						/*���û��������Ȩ�ޣ����Ҳ��Ǽҳ��������������벢��У������*/
						var userPsw = $("input[name='phonePwd']").val();
						if(userPsw == ""){
							rdShowMessageDialog("����������ֻ�����");
							return false;
						}
		
						var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
						checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
						checkPwd_Packet.data.add("phoneNo",phoneNoVal);	//�ƶ�����,�ͻ�id,�ʻ�id
						checkPwd_Packet.data.add("custPaswd",userPsw);//�û�/�ͻ�/�ʻ�����
						checkPwd_Packet.data.add("idType","");				//en ����Ϊ���ģ�������� ����Ϊ����
						checkPwd_Packet.data.add("idNum","");					//����
						checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//����
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
				/* ���������ִ�� */
				return false;
			}
			return true;
		}
		function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					/* ����У���ʶ 0ʧ��   1�ɹ� */
					$("#signPswFlag").val("0");
					rdShowMessageDialog(msg);
				}else{
					$("#signPswFlag").val("1");
				}
		}
		function getPubCheck(phoneNo,opcode,famCode,memberRoleId){
		
		  if((famCode=="KDJT" || famCode == "RHJT") && (memberRoleId=="70012" || memberRoleId=="50002")) 	{	
		    var familsyinfo  = $("#familyProdInfo").val();
  	    var getdataPacket = new AJAXPacket("fe280_checkKDMessage.jsp","�����ύ�У����Ժ�......");
  			getdataPacket.data.add("iCfmLogin",$("#phoneNo").val());	
  			getdataPacket.data.add("familsyinfo",familsyinfo);	
  			core.ajax.sendPacket(getdataPacket,doPubCheckBack);
								
			}
			else {
			var getdataPacket = new AJAXPacket("fe280PubCheck.jsp","���ڻ�����ݣ����Ժ�......");
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
		function changeProd1(){ //��ͥ��Ʒ��Ϣ onchange
			
			if ( "i088" == $("#opCode").val() ) //��ͥ��ǩ
			{
				var chkFamUpd = "Y";
				if ( "N" == $("#renewType").val() )/*δ������ǩ*/
				{
					$("input[name^='rn_meb_add']").attr("disabled",false);
				}
				<%if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") ) { //�ͼ�ͥ %>
						var msgPacket = new AJAXPacket("fe280_ajax_chkFamUpd.jsp","���ڻ�ȡ���ݣ����Ժ�......");
						msgPacket.data.add("printAccept","<%=printAccept%>");
						msgPacket.data.add("phoneNo","<%=parentPhone%>");
						msgPacket.data.add("opCode","<%=opCode%>");
						msgPacket.data.add("prodCode","<%=prodCode%>");
						msgPacket.data.add("prodCodeNew",$("#familyProdInfo").val());//��һ����Ʒ����
						msgPacket.data.add("famCode","<%=familyCode%>");
						core.ajax.sendPacket(msgPacket, function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							var innetFee = packet.data.findValueByName("innetFee");//��װ��
							var innetrate = packet.data.findValueByName("innetrate");
							var innetRateFee = packet.data.findValueByName("innetRateFee");
							var innetFeeLeft = packet.data.findValueByName("innetFeeLeft");
							
							//innetFee = "23443221";//ceshi
							//$("#innetFeeHidd").val(innetFee);//ceshi
							if(retCode != "000000"){
								rdShowMessageDialog("��ѯ��ǩ�����Ϣʧ�ܣ�<br>" + retCode+"<br>"+ retMsg,0);
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
						var getdataPacket = new AJAXPacket("chkHEJTProd.jsp","���Ժ�...");
						getdataPacket.data.add("opCode","<%=opCode%>");
						getdataPacket.data.add("parentPhone","<%=parentPhone%>");
						getdataPacket.data.add("familyCode","<%=familyCode%>");
						getdataPacket.data.add("familyProdInfo",$("#familyProdInfo").val());
						getdataPacket.data.add("phoneNoVal","");
						core.ajax.sendPacket(getdataPacket,function(packet){
							var retCode = packet.data.findValueByName("retCode");
							var retMsg = packet.data.findValueByName("retMsg");
							if(retCode != "000000"){
								rdShowMessageDialog("У�鲻ͨ����" + retCode + "��" + retMsg,0);
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
            	if($(this).val()=="70011"){//ȫ��ͨ��ͥ�ʷ���ͨ��Ա ��Ӱ�ť�û� 
            	  var butAddRole = "#addRole"+i;
            	  $(butAddRole).attr("disabled","true");
            	}
          });	
          /*ȫ��ͨ��ͥ�ʷ���ͨ��Ա ��Ĳ�Ʒ��Ա�������øĻ�ȥ*/
          $("input[id^='memRoleId_']").each(function(i,n){
        		/*ȫ��ͨ��ͥ�ʷ���ͨ��Ա �����ǵð��ڲ�Ʒ��*/
        		if($(this).val() == "70011"){
        			$(this).parent().parent().find("td:eq(1)").text($("#memMaxNum_"+i).val());
        		}
        	});
        }	else if(familsyinfo=="1022"||familsyinfo=="1023" ||familsyinfo=="1024" || familsyinfo=="1025"){
        	$("input[id^='memRoleId_']").each(function(i,n){
        		/*ȫ��ͨ��ͥ�ʷ���ͨ��Ա �����ǵð��ڲ�Ʒ��*/
        		if($(this).val() == "70011"){
        			$(this).parent().parent().find("td:eq(1)").text("2");
        		}
        	});
        }else{
        	/*ȫ��ͨ��ͥ�ʷ���ͨ��Ա ��Ĳ�Ʒ��Ա�������øĻ�ȥ*/
          $("input[id^='memRoleId_']").each(function(i,n){
        		/*ȫ��ͨ��ͥ�ʷ���ͨ��Ա �����ǵð��ڲ�Ʒ��*/
        		if($(this).val() == "70011"){
        			$(this).parent().parent().find("td:eq(1)").text($("#memMaxNum_"+i).val());
        		}
        	});
        }
      <%}%>		
      <%if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) { //�ͼ�ͥ %>
					updateFamilyRoleTrs();
      <%}%>		
      changeProd();
		}
		
		function updateFamilyRoleTrs(){
			var getdataPacket = new AJAXPacket("updateFamilyRoles.jsp","���Ժ�...");
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
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ!<br>������룺" + retCode_updFaml +"<br>������Ϣ��"+ retMsg1_updFaml);
				window.location="fe280.jsp?activePhone=<%=parentPhone%>";
			}
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
			
							/* ��ȡ ����ϵͳ��ֵ���߽�����ϵͳ��ֵ������������ϵͳ��ֵ�·�@2013/8/8  */
		<%if(familyCode.equals("XFJT") && "e281".equals(opCode)){%>	  
  		  var v_market = $("#market").val();
  		  if(typeof($("#market").val()) != "undefined"){ //�����ҳ�ʱ��Ӫ�����������
  		    var getdataPacket = new AJAXPacket("fe280_ajax_getSystemFeeInfo.jsp","�����ύ�У����Ժ�......");
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
				rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
				imeiNoObj[0].focus();
				checkAndAddObj.attr("disabled","true");
				return false;
			} 
		     
			var IMEINo = imeiNoObj.val();
			var agent_code = $("#brand").val();
			var phone_type = $("#res").val();
			var opcode = "<%=opCode%>";
			
			var myPacket = new AJAXPacket("../s1141/queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
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
					rdShowMessageDialog("IMEI��У��ɹ�1��");
					imeiNoObj.attr("readonly","true");
					checkAndAddObj.removeAttr("disabled");
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��");
					imeiNoObj.attr("readonly","true");
					checkAndAddObj.removeAttr("disabled");
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
					checkAndAddObj.attr("disabled","true");
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
					checkAndAddObj.attr("disabled","true");
					return false;
			}
		}
		function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode != "000000"){
					rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg);
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
			
			/* ������ʽ */
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
				if ( "Y" == $("#renewType").val() )/*�ѵ�����ǩ*/
				{
					$( "#items" ).show( 800 );
					$( "#mebList" ).hide();
					$( "#familyMemberList" ).hide();
				}
				else if ( "N" == $("#renewType").val()  )/*δ������ǩ*/
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
			
			//�ͼ�ͥ����Ա����ʱ������¼�ͥ��ɫ��Ϣ
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "e282".equals(opCode)) {%>
				updateFamilyRoleTrs();
			<%}%>
			//�ͼ�ͥ����ͥ��ǩʱ�����ü�ͥ��Ʒ��Ϣ
			<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")) && "i088".equals(opCode)) {%>
					$("#familyProdInfo").empty();		
					var getdataPacket = new AJAXPacket("fe280_ajax_getFamilyProdInfos.jsp","���Ժ�...");
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
							$("#familyProdInfo").append("<option value='' sp_info=''>--��ѡ��--</option>");
							for(var i=0;i<_code.length;i++){
								$("#familyProdInfo").append("<option value='"+_code[i]+"' sp_info='"+_sp_info[i]+"' >"+_text[i]+"</option>");
							}
						}else{
							rdShowMessageDialog("������룺"+retCode+"��������Ϣ��"+retMsg);
							window.location="fe280.jsp?activePhone=<%=parentPhone%>";
						}
					});
					getdataPacket =null;
					
					$("#autoCancelTab2").css("display","none");
			<%}%>
			
			/*alert("<%=familyCode%>"+"---"+"<%=opCode%>"); �������⴦����һ��,�ںϼ�ͥͬʱΪe282������²�չʾ����˺������*/
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
		        		/*ȫ��ͨ��ͥ�ʷ���ͨ��Ա �����ǵð��ڲ�Ʒ��*/
		        		if($(this).val() == "70011"){
		        			$(this).parent().parent().find("td:eq(1)").text("2");
		        		}
		        	});
		     		}
			<%}
			%>
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","���ڻ�����ݣ����Ժ�......");

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
    
    function getSpBusiCode(obj){
    	$("#spBusiCode").empty();
    	$("#spBusiCode").append("<option value ='' >--��ѡ��--</option>");
    	if(obj.value == "699212"){
    		$("#spBusiCode").append("<option value ='20830000'>20830000</option>");
    	}else if(obj.value == "699213"){
    		$("#spBusiCode").append("<option value ='20830000'>20830000</option>");
    	}else{
    		$("#STBId").val("");
    	}
    }
    
    //����ҵ�����ҵ�����ѡ����󣬻�����id������Զ�չʾǰ28λ��ӪҵԱ�����������4λ��ǰ28λ�����޸ġ�
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
    	/*�ҳ�����*/
    	var parentPhone = $.trim($("#parentPhone").val());
    	/*��Ա����,��ʱ��û��� ����ʹ�÷���getPhoneNoByMemberId("70054"); ȡ����*/
    	var memberPhone = $.trim($("#phoneNo").val());
    	if(memberPhone.length == 0){
    		rdShowMessageDialog("�������Ա���룡");
    		return false;
    	}
    	/**
    	var otherMemberStr = getPhoneNoByMemberId("70054");
    	var otherMemberStr2 = getPhoneNoByMemberId("70053");
    	**/
    	var imeiNo = $.trim($("#ZSLLImei").val());
    	if(imeiNo.length == 0){
    		rdShowMessageDialog("������IMEI�룡");
    		return false;
    	}
    
    	/*���÷������IMEI����֤*/
    	
    	/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/se280/fm280CheckImei.jsp","���ڻ�����ݣ����Ժ�......");
			
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
				rdShowMessageDialog("��֤�ɹ���",2);
			}else{
				imeiChkFlag = false;
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
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
				" WHERE family_code = '" + familyCode + "' "
				+" AND GROUP_ID = '" + belongGroupId + "'";
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
				<%if((familyCode.equals("HEJT") || familyCode.equals("JHJT")) && "i088".equals(opCode)){%>
			 		&nbsp; &nbsp; 
			 		<font class='red'> (��ע�⣺��88Ԫ���Ϊ������λ������������ն˷���100Ԫ��) </font> 
			 	<%}%>				
			</td>

		</tr>
			<%if((familyCode.equals("KDJT") || "RHJT".equals(familyCode)) && ("e281".equals(opCode) || "e282".equals(opCode))) {%>
			<tr id="kdjt" style="display:none">
        <td class="blue"  >����˺�</td>
				<td >
					<input type="text" id="kuandai" name="kuandai" maxlength="20"  />

			</tr>
			<%}%>
	</table>
	<div id = 'mebList'>
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
			<%
			if ( "i088".equals(opCode) )
			{
			%>
			<th>����</th>
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
				//liujian e282��������ֻҪ��ǰ��ӵĺ���
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
						class = 'b_text' value = '���' 
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
				<td class="blue" width="10%">�����Ƿ��Զ�ȡ��</td>
				<td colspan="3">
					<select id="autoCancel2" name="autoCancel2" >
						<option value ="1" >��</option>
						<option value ="0" >��</option>
					</select>
					<font class="orange">*</font>
				</td>
			</tr>
		</table>
	</div>
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
						 value="���" class="b_text" onclick="addRole(<%=i%>)" />
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
				<td width="15%">
					<input type="text" id="phoneNo" name="phoneNo" maxlength="11" 
						v_type="mobphone" v_must="1" onblur = "checkElement(this)" onfocus="checkPhoneNo(this)" />
					<font class="orange">*</font>
					<input type="hidden" id="operRoleId" name="operRoleId" />
					<input type="hidden" id="operRoleName" name="operRoleName" />
					<input type="hidden" id="operMemberId" name="operMemberId" />
					<input type="hidden" id="operPayType" name="operPayType" />
				</td>
				<td class="blue" width="20%">����</td>
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
					IMEI��
				</td>	
				<td colspan="3">
					<input type="text" name="ZSLLImei" id="ZSLLImei" value=""/>
					&nbsp;&nbsp;
					<input type="button" class="b_text" name="ZSLLImeiCheckBtn" id="ZSLLImeiCheckBtn" onclick="ZSLLImeiCheck();" value="��֤" />
				</td>
			</tr>
			<tbody id="busiAccept">
			</tbody>
			<tr>
				<td colspan="5">
					<div align="center"> 
						<input type="button" class="b_foot_long" value="У��&��ӳ�Ա" 
						 onclick="addRoleToSelected()" id="checkAndAdd" name="checkAndAdd" />
						<input type="button" name="cancle" class="b_foot" value="ȡ��" onclick="cancleAdd()" />
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
	

	
	<!-- ҵ�������� end -->
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
			 value="ȷ��" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="���" onclick="changeProd()" />
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
