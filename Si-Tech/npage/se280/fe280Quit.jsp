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
 		String offerids="";
 		String offernames="";
 		String offercoments="";
 		String printOpName = "";
 		String printName2 = "";
 		String v_case = "2";
 		if("e283".equals(opCode) || "e284".equals(opCode)){ //��Ա�˳�,��ͥ��ɢ
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){
 				v_case = "9";
 			}
 		}
 		/*
 		if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
	 		if("e283".equals(opCode)){
	 			printName2 = "�ͼ�ͥ-�����ײͳ�Ա�˳�";
 			}
 		}
 		if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 			if("e283".equals(opCode)){
 				printName2 = "�ͼ�ͥ-�ں��ײͳ�Ա�˳�";
 			}
 		}*/
 		
 		if("e283".equals(opCode)){
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
 				printName2 = "�ͼ�ͥ-�����ײͳ�Ա�˳�";
 			}
 			if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 				printName2 = "�ͼ�ͥ-�ں��ײͳ�Ա�˳�";
 			}
 			if(familyCode.equals("ZHJT")){
 				printName2 = "�ͼ�ͥ-ħ�ٺ��ں��ײͳ�Ա�˳�";
 			}
 		}
 		
 		/*gaopeng ���ֿ����ͥ���ںϼ�ͥ�������ӡͷ��չʾ��2014/01/15 16:46:18*/
 		if(familyCode.equals("KDJT")){
 			printOpName = "�����ͥ";
 		}else if(familyCode.equals("RHJT")){
 			printOpName = "�ںϼ�ͥ";
 		}
    if("e283".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "�����˳����鳩��";
 			}
 			else if(familyCode.equals("KDJT")){
 			printName = "ȫ��ͨ��ͥ�ʷѳ�Ա�˳�";
 			}
 			else if(familyCode.equals("RHJT")){
 			printName = "�ںϼ�ͥ�ʷѳ�Ա�˳�";
 			}
 		  else {
 		  printName = "�Ҹ���ͥ��Աҵ���˶�";
 		  }
 		}else if("e284".equals(opCode)){
 			
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
 				printName2 = "�ͼ�ͥ-�����ײͼ�ͥ��ɢ";
 	   	}
 	   	if(familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 				printName2 = "�ͼ�ͥ-�ں��ײͼ�ͥ��ɢ";
 	   	}
 	   	if(familyCode.equals("ZHJT")){
 				printName2 = "�ͼ�ͥ-ħ�ٺ��ں��ײͼ�ͥ��ɢ";
 	   	}
 			
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩����ȡ��";
 			}
 			else if(familyCode.equals("KDJT")){
 			printName = "ȫ��ͨ��ͥ�ʷѼ�ͥ��ɢ";
 			}
 			else if(familyCode.equals("RHJT")){
 			printName = "�ںϼ�ͥ�ʷѼ�ͥ��ɢ";
 			}
 			else {
 		  printName = "�Ҹ���ͥҵ���˶�";
 		  }
 		}else if("i089".equals(opCode) ){
 			  printName = "�Ҹ���ͥ��ǩ����";
 			
 		}else if("e285".equals(opCode) ){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩�������";
 			}
 			else if(familyCode.equals("KDJT")){
 			printName = "ȫ��ͨ��ͥ�ʷѴ�����ͥ����";
 			} 
 			else if(familyCode.equals("RHJT")){
 			printName = "�ںϼ�ͥ�ʷѴ�����ͥ����";
 			} 			
 			else {
 		  printName = "�Ҹ���ͥǩԼ�������";
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
		System.out.println("----- fe280Quir.jsp ---- ��ѯ����" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code0%>" + "<%=msg0%>");
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
			if("e285".equals(opCode) || "e283".equals(opCode) || "e284".equals(opCode)){/*����ʱ��ѯ��Ա�ʷ�--�������鳩��3Ԫ��5Ԫ�����ʷ�*/
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
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
		}
%>
<html>
<head>
	<title>��ͥ��Ʒ���</title>
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
			/* ��ť�ӳ� */
			controlButt(subButton);
			/* �º����� */
			getAfterPrompt();
			
			/* ƴװ���� */
			setJSONText();
			/*begin update for ����桿��������������@2015/4/21 */
			if(("<%=familyCode%>" == "QWJT" || "<%=familyCode%>" == "PYJT" || "<%=familyCode%>" == "TXJT" || "<%=familyCode%>" == "TSJT") && "<%=opCode%>" == "e284"){
				if(familyRoleList.getLength() == 0){
					rdShowMessageDialog("�޷���ȡ����ǰ��ͥ��Ա��Ϣ���޷����м�ͥ��ɢ�����������²�����",0);
					removeCurrentTab();
					return false;	
				}
				if(familyRoleList.getProd_code() == ""){
					rdShowMessageDialog("�޷���ȡ����ǰ��ͥ�Ĳ�Ʒ��Ϣ���룬�޷����м�ͥ��ɢ�����������²�����",0);
					removeCurrentTab();
					return false;	
				}
			}
			/*
			alert("familyCode = <%=familyCode%>");
			*/
			/*end update for ����桿��������������@2015/4/21 */
			getPrintInfo();
			/* ��ӡ���&�ύҳ�� */
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
		
		function printInfo11(opcode){
			/*liujian  ���������ɫ�ĳ�ԱId*/
			var parent_member_Id = '70001'; //�˾�ͨ�ҳ�
			var normal_member_Id = '70002'; //��ͨ��Ա
			var other_member_Id ="";  //������Ա
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
			
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#operPhoneNo").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��" + $("#printName").val()+"|";
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			
		 if(opcode=="e283") {
			opr_info += "�˳����鳩��ҵ����齨�˺��룺"+$("#parentPhone").val() + "|";		
			
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
					opr_info += "���μ����ͥ�Ŀ�ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
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
						tempMember = otherMemberStr;
					}
					opr_info += "���鳩�ĳ�Ա�ֻ����룺" + tempMember + "|";
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
						opr_info += "���鳩�ĳ�Ա�ֻ����룺" + otherMemberStr + "|";
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
					 if(opcode=="e284") {
				    opr_info += "ָ���ʷѣ�" + "<%=offerids%>"+minorOfferNameVal + "|";
				   }
				  if(opcode=="e283") {
				    opr_info += "ָ���ʷѣ�" + "<%=offerids%>"+offerName + "|";
				   }
				   	if(opcode=="e285") {				          
				    opr_info += "ָ���ʷѣ�" +"<%=offerids%><%=offernames%>"+ "|";
				   }
				   // opr_info += "ָ���ʷѣ�" + offerName + "|";				    
			} 
			opr_info += opr_info_temp;
			/************ע������************/
			note_info1 += "��ע��" + "|";
			if(offerComment.length > 0){
				//note_info1 += "ָ���ʷ�������" + offerComment + "|";
				
					 if(opcode=="e284") {
				    note_info1 += "ָ���ʷ�������" + minorOfferCommentVal + "|";
				   }
				   if(opcode=="e283") {
				    note_info1 += "ָ���ʷ�������" + offerComment + "|";
				   }
				   	if(opcode=="e285") {
				    note_info1 += "ָ���ʷ�������" + "<%=offercoments%>" + "|";
				   }
				
			}
			note_info1 += note_info1_temp;
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
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
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
						opr_info += "<%=printOpName%>�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "<%=printOpName%>�����Ա���룺" + kdMemberStr + "|";
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
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						opr_info += "���μ����<%=printOpName%>�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "���μ����<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "���μ����<%=printOpName%>�����Ա���룺" + kdMemberStr + "|";
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
						if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "�����˳��Ŀ����ͥ�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "�����˳���<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					//opr_info += "�����˳���ͥ�ĳ�Ա�ֻ����룺" + otherMemberStr + "|";
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
						//opr_info += "�����ͥ�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "<%=printOpName%>�����Ա���룺" + kdMemberStr + "|";
					}
					//opr_info += "��ͥ��Ա�ֻ����룺" + tempMember + "|";
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
					}
					break;
				case 'e285' :	
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						//opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					if(normalMemberStr != null && normalMemberStr.length > 0) {
						//opr_info += "�����ͥ�̻���Ա�ֻ����룺" + normalMemberStr + "|";
					}
					if(otherMemberStr != null && otherMemberStr.length > 0) {
						opr_info += "<%=printOpName%>��ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
					}
					if(kdMemberStr != null && kdMemberStr.length > 0) {
						opr_info += "<%=printOpName%>�����Ա���룺" + kdMemberStr + "|";
					}
					/*�趨ָ���ʷ�*/
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
          opr_info += "�����˳��ʷѣ�" + chengyuanzifei11 + "|";			
          opr_info += "�˳��ʷ�������" + chengyuanzifeimiaoshu11 + "|";		
  			}else if(chengyuanzifei22.length == 0 && chengyuanzifei22.length ==0){
  				opr_info += "�����˳��ʷѣ�" + chengyuanzifei11 + "|";			
          opr_info += "�˳��ʷ�������" + chengyuanzifeimiaoshu11 + "|";		
  			}
  			else{
  			  opr_info += "�����˳��ʷѣ�" + chengyuanzifei11 + "|";			
    		  opr_info += "�˳��ʷ�������" + chengyuanzifeimiaoshu11 + "|";			
    			opr_info += "�����˳��ʷѣ�" + chengyuanzifei22 + "|";
    			opr_info += "�˳��ʷ�������" + chengyuanzifeimiaoshu22 + "|";  
  			}
			}else if(opcode=="e284") {
			opr_info += "��ͥ��ɢ��ҳ��ʷѣ�" + mainOfferNameVal + "|";			
		  opr_info += "�ʷ�������" + mainOfferCommentVal + "|";	
		  
			}
			else {
			}
			opr_info += opr_info_temp;
			/************ע������************/
			note_info1 += "��ע��" + "|";
			if(opcode=="e283") {
			note_info1 += "���γ�Ա�˳��ʷѣ�����1���ʷ�ʧЧ��" + "|";
			}
			if(opcode=="e284"){
				/*2013/12/26 16:04:23 gaopeng ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �޸�ȡ������������ӡ��Ϣ*/
			note_info1 += "��ܰ��ʾ��"+"|";
			note_info1 += "�ͻ��������ײ�ҵ��ȡ����ȡ��ʱ����ҳ��ʷ�Ϊ�����������ʷѣ���Ҫ�Ȳ�����Ʒ��ٿ۳�ʣ�����ר���30%��ΪΥԼ�𣬼ҳ��Ϳ��תΪȡ�����ʷѣ�"+"|";
			note_info1 += "������ȡ������Ӫ���ΥԼ�����ͻ��谴������Ʒԭ�۽����ֽ�"+"|";
			note_info1 += "�˶�ʱ�践��Ԫ�����������м�������񿨣���ֹͣ�������"+"|";
				
			}
			if(opcode=="e285"){
					/*2013/12/26 16:04:23 gaopeng ���ڹ��ֹ�˾����139��188�ں������ײ͵���ʾ �޸ĳ�������������ӡ��Ϣ*/
				note_info1 += "��ܰ��ʾ��"+"|";
				note_info1 += "�ͻ�����139/188ȫ��ͨ�����ײͳ���ҵ�񣬿ͻ��践��������Ʒ���綪ʧ�밴����Ʒʵ�۽��ɷ��á�"+"|";
			}
			note_info1 += note_info1_temp;
			//note_info1 += "ע�����" + "|";
			//note_info1 += getNote();
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		function printInfo33(opcode){
					
			var parent_member_Id = ''; //�����ͥ�ҳ�
			var normal_member_Id = ''; //��ͨ��Ա
			var kd_member_Id = '';  //�����ͥ
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

				other_member_Id = "70033"; //��ͨ��Ա
				kd_member_Id = "70034"; //�����Ա
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
			if("<%=familyCode%>" == "JHJT" && opcode == "e283"){
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��"+minorOfferNameVal +"-�ͼ�ͥ�ƻ��ں��ײͳ�Ա�˳�|";
			}else if("<%=familyCode%>" == "JHJT" && opcode == "e284"){
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��ȡ���ͼ�ͥ�ƻ��ں��ײ͹���Ⱥ��|";
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
				if(opcode == "e283" || opcode == "e284"){
					opr_info += "�ͼ�ͥ�ƻ��ں��ײ�Ⱥ���������룺" + $("#parentPhone").val() + "|";
					opr_info += "�ͼ�ͥ�ƻ��ں��ײͳ�Ա���룺" + otherMemberStr + "|";
				}
			<%}else if(familyCode.equals("ZHJT")) {%>
				opr_info += "�ͼ�ͥ-ħ�ٺ��ں��ײͼҳ����룺" + $("#parentPhone").val() + "|";
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
							opr_info += "�ͼ�ͥ-�ں��ײͿ����Ա���룺" + kdMemberStr + "|";
					  <%}else if(familyCode.equals("HEJT") || familyCode.equals("JHJT")) {%>
							opr_info += "�ͼ�ͥ-�����ײͿ����Ա���룺" + kdMemberStr + "|";
						<%}else if(familyCode.equals("ZHJT")) {%>
							opr_info += "�ͼ�ͥ-ħ�ٺ��ں��ײͿ����Ա���룺" + kdMemberStr + "|";
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
						opr_info += "�����˳��ͼ�ͥ-�ں��ײ���ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
			  <%}else if(familyCode.equals("HEJT")) {%>
						opr_info += "�����˳��ͼ�ͥ-�����ײ���ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
				<%}else if(familyCode.equals("JHJT")) {%>
						opr_info += "�����˳��ͼ�ͥ�ƻ��ں��ײͳ�Ա���룺" + otherMemberStr + "|";
				<%}else if(familyCode.equals("ZHJT")) {%>
						opr_info += "�����˳��ͼ�ͥ-ħ�ٺ��ں��ײ���ͨ��Ա�ֻ����룺" + otherMemberStr + "|";
				<%}%>
				}	
			  opr_info += "�����˳��ʷѣ�" + offerName + "|";			
		    //opr_info += "�˳��ʷ�������" + offerComment + "|";	
		    if("<%=familyCode%>" == "JHJT"){
		    	opr_info += "�˳��ʷ�������" + offerComment + "|";	
		    }
		    
			}
			if(opcode=="e284") {
			opr_info += "��ͥ��ɢ��ҳ��ʷѣ�" + mainOfferNameVal + "|";			
		  opr_info += "�ʷ�������" + mainOfferCommentVal + "|";	
		  
			}
			else {
			}
			opr_info += opr_info_temp;
			/************ע������************/
			note_info1 += "��ע��" + "|";
			if(opcode=="e283"){
				<%
				if(	familyCode.equals("ZHJT")){
				%>
					note_info1 += "ע�����" + "|";
					note_info1 += "�����������кͼ�ͥ�ײͣ��������г�Ա�䱾�ػ������ʱ��������ʱ�����ֻ���������Ҳ�����Ժͼҳ�����"+"|";
			  <%}%>
			  if("<%=familyCode%>" == "JHJT"){
			  	note_info1 += "��ʹ�÷�0Ԫ���������ʹ�������ײ���������ÿ�¿�����Ⱥ���ڱ���ͨ�����ʱ��500���ӡ�" + "|";
			  	note_info1 += "ע�����" + "|";
			  	note_info1 += "1���ɹ�����ͼ�ͥ�ƻ��ں��ײͳ�Ա�˳��ĸ����ͻ����Դ����������������ͻ�����������Ⱥ���ڱ���ͨ�����ʱ��300���ӡ�" + "|";
			  	note_info1 += "2�����ҵ�������Ч��" + "|";
			  }
			  
			}
			if(opcode=="e284"){
				<%
				if(	familyCode.equals("HJTA") || familyCode.equals("HJTB")){
				%>
					note_info1 += "ע�����" + "|";
				  note_info1 += "1���ں��ײ�ȡ���������ѿ�������װ�Ѳ��˻���"+"|";
					note_info1 += "2���ں��ײͰ����²���ȡ�����糬���ײ������Ʒ�2���£��ײ�ȡ������ȡ�ײ���ʹ�÷ѵ�30%��ΪΥԼ��"+"|";
					note_info1 += "3���ں��ײ�ȡ���󣬴���1���賿��ͣ������ܡ�"+"|";
		
					note_info1 += "��ܰ��ʾ��"+"|";
					note_info1 += "�������ʷѺ�Լ����ǰ����ʱ�����ں��ײ���ǩҵ��"+"|";
			  <%}else if(familyCode.equals("HEJT")) {%>
					note_info1 += "ע�����" + "|";
				  note_info1 += "1���ͻ��赽���ع��Ӫҵ���������ײ�ȡ�������˻��������ߵ���MODEM�������У��������նˡ�"+"|";
					note_info1 += "2�������ײ�ȡ���������ѿ�������װ�Ѳ��˻���"+"|";
					note_info1 += "3�������ײͰ����²���ȡ�����糬���ײ������Ʒ�2���£��ײ�ȡ������ȡ�ײ���ʹ�÷ѵ�30%��ΪΥԼ��"+"|";
					note_info1 += "4�������ײ�ȡ���󣬴���1���賿��ͣ��������ߵ��ӹ��ܡ�"+"|";
		
					note_info1 += "��ܰ��ʾ��"+"|";
					note_info1 += "1������ÿ��20��ǰ��ȷ�����ֻ�Ԥ�����۳�����δ���ʻ��Ѻ��Դ��ڴ��°����ײ���ʹ�÷ѣ������뼰ʱ�ɷ���������������ߵ��ӷ����ܽ����ܹ�ͣ��"+"|";
					note_info1 += "2���������ʷѺ�Լ����ǰ����ʱ�������ײ���ǩҵ��"+"|";
					note_info1 += "�˶�ʱ�践��Ԫ�����������м�������񿨣���ֹͣ�������"+"|";
				<%}else if(familyCode.equals("JHJT")) {%>
					note_info1 += "�ͼ�ͥ�ƻ��ں��ײͣ���һ�ֻ��ڼ�ͥȺ��������������Ϳ���๦�ܹ���ҵ�񡣸����ͻ����Թ��������ͻ��ײ������������������ͻ��͸��ͻ���ÿ�¿ɶ������ܱ������г�Ա��ͨ��ʱ��300���ӡ�" + "|";
					note_info1 += "ע�����" + "|";
					note_info1 += "1����������ȡ���ͼ�ͥ�ƻ��ں��ײ�Ⱥ��֮���Դ����������ܺͼ�ͥ�ƻ��ں��ײ��Żݷ��񣬲��Զ���������и�����Ա����Ĺ����ϵ��" + "|";
				<%}else if(familyCode.equals("ZHJT")) {%>
					note_info1 += "ע�����" + "|";
				  note_info1 += "1��ħ�ٺ��ں��ײ�ȡ���������ѿ�������װ�Ѳ��˻���"+"|";
					note_info1 += "2���糬���ײ������Ʒѿ�ʼ������Ϊ���ͥ��ϵ��Ч���������£���ͥ��ɢ����ȡ�ײ���ʹ�÷ѵ�30%��"+"|";
					var TermFeeHidd = Number($.trim($("#TermFeeHidd").val()));
					if(TermFeeHidd == "200"){
						note_info1 += "3�����ڳ��ΰ���ͼ�ͥ-ħ�ٺ��ں��ײͼ�ͥ��Ч��ϵ��ЧС��6���£�������ħ�ٺ��ն˷�200Ԫ��"+"|";
					}else if(TermFeeHidd == "100"){
						note_info1 += "3�����ڳ��ΰ���ͼ�ͥ-ħ�ٺ��ں��ײͼ�ͥ��Ч��ϵ��Ч����6���²�С��12���£�������ħ�ٺ��ն˷�100Ԫ��"+"|";
					}
					
					note_info1 += "4���ں��ײ�ȡ���󣬴���1���賿��ͣ������ܺ�ħ�ٺ���Ƶ���ܡ�"+"|";
					/*
					note_info1 += "��ܰ��ʾ��"+"|";
					note_info1 += "�������ʷѺ�Լ����ǰ����ʱ������ͥ�ں��ײ���ǩҵ��"+"|";
					*/
				<%}%>
			}
			note_info1 += note_info1_temp;
			//note_info1 += "ע�����" + "|";
			//note_info1 += getNote();
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
			if("<%=familyCode%>" == "ZSLL" && opcode == "e284"){
				opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ���ն�ר�����������ײ�-��ͥ��ɢ|";
			}
			
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			
			<% if(familyCode.equals("ZSLL")) {%>
			opr_info += "�齨��ͥ���룺" + $("#parentPhone").val() + "|";
			opr_info += "�����ͥȺ���Ա���룺" + otherMemberStr + "|";
			<%}%>
			
			
			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e284' : 
					/*�趨ָ���ʷ�*/
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
					opr_info += "��ɢ���ʷѣ�" + offerName + "|";
				}
				if(offerComment.length > 0){
					opr_info += "��ɢ���ʷ�������" + offerComment + "|";
				}
			}
			opr_info += opr_info_temp;
			/************��ע************/
			
			/************ע������************/
			<%if("e284".equals(opCode) ) {
			
			if(	familyCode.equals("ZSLL")){
			%>
					  note_info1 += note_info1_temp;
		  			note_info1 += "��ע��" + "|";
		  			note_info1 += "ȡ��39Ԫ�ն�ר�����������ײͺ󣬴��±��Ϊ��׼�ײͣ��ײ������������ٹ���������ͻ�ʹ�á�"+"|";

						
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
					returnStr += "1���ɹ������˶��Ҹ���ͥ�ײͣ��Դ����𽫲��������Ҹ���ͥ�ײ��Ż�ҵ��" + "|";
				}else if(opCode == "e284"){
					returnStr += "1���ƶ��ֻ������˶��Ҹ���ͥ�ײͺ��Դ����𽫰��ղ������ܼ�ͥ��ҵ���Ż��ʷѡ�" + "|";
					returnStr += "2�������Ĺ̻����������ⲻ�ܼ���ʹ�ã��뵽Ӫҵ�����¹����������������ҵ��������δ�����ͻ���ɢ��ͥ�򻰷Ѳ��ٷ������ͻ���Ҫ�������򻰻���ͬʱ�ƶ���˾��ȡ�ʣ��Ԥ�滰�ѵ�30%��ΪΥԼ��" + "|";
				}else if(opCode == "e285") {
					returnStr += "1������ҵ�����������˾�ͨҵ���ܷ�15Ԫ/�Ρ�" + "|";
				}else if(opCode == "i089") {
					if ( "Y" == $("#rn_flag").val() )
					{
						returnStr += "1������ҵ����������һ���µ��˾�ͨҵ���ܷѡ�" + "|";
					}
					
				}
			}else if(familyCode == "QWJT"){
				if(opCode == "e283"){
					returnStr += "1���ɹ������˶��������ײͣ��Դ����𽫲��������������ײ��Ż�ҵ��" + "|";
					returnStr += "2���˳�ҵ��������Ч��" + "|";
					returnStr += "3���齨��ȡ��������ҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}else if(opCode == "e284"){
					returnStr += "1���ƶ��ֻ������˶��������ײͺ��Դ����𽫲�������������ҵ���Ż��ʷѡ�" + "|";
					returnStr += "2���齨��ȡ��������ҵ�������������ҵ���������Żݡ�" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}
			else if(familyCode == "TXJT"){
				if(opCode == "e283"){
					returnStr += "1���ɹ������˶�������B�ײͣ��Դ����𽫲�������������B�ײ��Ż�ҵ��" + "|";
					returnStr += "2���˳�ҵ��������Ч��" + "|";
					returnStr += "3���齨��ȡ��������Bҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}else if(opCode == "e284"){
					returnStr += "1���ƶ��ֻ������˶�������B�ײͺ��Դ����𽫲�������������Bҵ���Ż��ʷѡ�" + "|";
					returnStr += "2���齨��ȡ��������Bҵ�������������Bҵ���������Żݡ�" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}
			else if(familyCode == "TSJT"){
				if(opCode == "e283"){
					returnStr += "1���ɹ������˶�������C�ײͣ��Դ����𽫲�������������C�ײ��Ż�ҵ��" + "|";
					returnStr += "2���˳�ҵ��������Ч��" + "|";
					returnStr += "3���齨��ȡ��������Cҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}else if(opCode == "e284"){
					returnStr += "1���ƶ��ֻ������˶�������C�ײͺ��Դ����𽫲�������������Cҵ���Ż��ʷѡ�" + "|";
					returnStr += "2���齨��ȡ��������Cҵ�������������Cҵ���������Żݡ�" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}	
			else if(familyCode == "PYJT"){
				if(opCode == "e283"){
					returnStr += "1���ɹ������˶�������A�ײͣ��Դ����𽫲�������������A�ײ��Ż�ҵ��" + "|";
					returnStr += "2���˳�ҵ��������Ч��" + "|";
					returnStr += "3���齨��ȡ��������Aҵ������г�Ա��������ҵ���Żݡ�" + "|";
				}else if(opCode == "e284"){
					returnStr += "1���ƶ��ֻ������˶�������A�ײͺ��Դ����𽫲�������������Aҵ���Ż��ʷѡ�" + "|";
					returnStr += "2���齨��ȡ��������Aҵ�������������Aҵ���������Żݡ�" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}					
			else if(familyCode == "ZDGX"){
				if(opCode == "e283"){
					returnStr += "1���ɹ������������������Ա�˳��ĸ����ͻ����Դ����������������ͻ�����������" + "|";
					returnStr += "2�����ҵ�������Ч��" + "|";
				}else if(opCode == "e284"){
					returnStr += "1����������ȡ����������������ҵ����Դ������������������������Żݷ��񣬲��Զ���������и�����Ա����Ĺ����ϵ��" + "|";
				}else if(opCode == "e285") {
					returnStr += "" + "|";
				}
			}
			/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
			else if(familyCode == "JTGX"){
				if(opCode == "e283"){
					returnStr += "1���ɹ�����4G��ͥ�����ײͳ�Ա�˳��ĸ����ͻ����Դ����������������ͻ�����������Ⱥ���ڱ���ͨ�����ʱ��500���Ӻ��й��ڵ�WLAN���������50G�ⶥ����Դ��" + "|";
					returnStr += "2�����ҵ�������Ч��" + "|";
				}else if(opCode == "e284"){
					returnStr += "1����������ȡ��4G��ͥ�����ײ�Ⱥ��֮���Դ�����������4G��ͥ�����ײ��Żݷ��񣬲��Զ���������и�����Ա����Ĺ����ϵ��" + "|";
				}
			}
			/* end add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
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
						//liujian ����Ŀ�ѡ��Ա�������˳�
						//checkbox���߼��ǣ���ѡ�ͼҳ������ˣ�ͨ����С����ȷ������ѡ����Ĳ�����
						//$(n).removeAttr("disabled");
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
			if("<%=opCode%>" == "e284" || "<%=opCode%>" == "e285" || "<%=opCode%>" == "i089"){
				var spInfo = $.trim($('#familyProdInfo').find("option:selected").attr('sp_info'));
				familyRoleList.setSpInfo(spInfo);
			}
			
			if(("<%=familyCode%>"=="HEJT"  || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" ) && "<%=opCode%>"=="e284"){//�ͼ�ͥ����ͥ��ɢ
				familyRoleList.setFault_Fee($("#faultFeeHidd").val());//ΥԼ��
			}
			if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e284"){//��ϼ�ͥ����ͥ��ɢ
				familyRoleList.setZd_Fault_Fee($("#TermFeeHidd").val());//�ն�ΥԼ��
				familyRoleList.setFault_Fee($("#faultFeeHidd").val());//ΥԼ��
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
										//if(familsyinfos=="1006") {//������������Ѿ�������˳��ĺ��룬����json����ƴ�˺���--wanghyd
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
														//alert("�к���"+phoneNoVal);
														flsgtype="1";
														break;
											}
											else {
											      //alert("û�к���");
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
									/* ��������Ҫƴ��business���� */
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
									
									//if(familsyinfos=="1006") {//������������Ѿ�������˳��ĺ��룬����json����ƴ�˺���--wanghyd
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
									/* ��������Ҫƴ��business���� */
									famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
									
									/*ZSLLʱ��70054��Ա��ƴjson��*/
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
			/* add ��ͥ���� ��������/��������ҵ���ʶ Ĭ��1 for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2014/11/25  */
			<%if(familyCode.equals("JTGX")){ //��ͥ���� %>
				<%
					if("e283".equals(opCode)){ //��Ա�˳� 
						if(selfFlag){ //�ҳ�����ҵ��1 
				%>
							familyRoleList.setBusi_status("1");
				<%
						}else{  //��Ա����ҵ��2
				%>
							familyRoleList.setBusi_status("2");
				<%	
						}				
				%>
						
				<%}else if("e284".equals(opCode)){ //��ͥ��ɢ %>
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
				/*2016/1/20 14:23:33 gaopeng ��ͥ��ɢ ��ȡ��ɢ�����ʷ����ƺ�����*/
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
				  /*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������ start*/
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
				  /*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������ start*/
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
						/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
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
					/* end add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
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
					
					//alert("business = "+business);
					famRole.addBusiness(business);
				}
			}
			return famRole;
		}
		function doSetPrepayfee(packet){
			var retcode = packet.data.findValueByName("retcode");
			var prepayFee = packet.data.findValueByName("prepayFee");
			var machineFee = packet.data.findValueByName("machineFee");//������
			$("#homeEasyHide").val("1");
			$("#prepayFeeHide").val(prepayFee);
			$("#baseFeeHidd2").val(machineFee);
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
			$("#mainOfferName").val(offerName);
			$("#mainOfferComment").val(offerComment);
			
		//	famOffer.setMainOfferName(offerName);
		//	famOffer.setMainOfferCmt(offerComment);
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
			//alert(result);
			
			if(retCode != "000000"){
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫҵ����Ϣ" + retCode + retMsg);
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			}else{
				famBusiArray = result;
				
				//alert("result famBusiArray = "+famBusiArray);
			/*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������  ѭ�����񷵻صĲ��� �����XFJT ͬʱ�����ʷ� ����ѭ�� �ж��Ƿ�չʾС�����������б� start*/
				if("<%=familyCode%>" == "XFJT" && "<%=opCode%>"== "e284"){
					for(var i = 0; i < famBusiArray.length; i++){
						if(famBusiArray[i][4] == "MO"){
							
							var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","���Ժ�...");
				      packet.data.add("offerId",famBusiArray[i][8]);
				      packet.data.add("sum","2");
				      packet.data.add("phoneNo","");
				      packet.data.add("opCode","<%=opCode%>");
				      core.ajax.sendPacket(packet,doJdugeAreaHidden);
				      packet =null;	
				  			
				  	}
					}
				
				}
				/*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������  ѭ�����񷵻صĲ��� �����XFJT ͬʱ�����ʷ� ����ѭ�� �ж��Ƿ�չʾС�����������б� start*/
			}
		}
		/*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������  ѭ�����񷵻صĲ��� �����XFJT ͬʱ�����ʷ� ����ѭ�� �ж��Ƿ�չʾС�����������б� start*/
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
    		return false;
    	}
    }
    	function getOfferAttr(offer_id,sum){
      if(v_hiddenFlag=="Y"){ //��ΪYʱ�������°�С������չʾҳ��
        var packet1 = new AJAXPacket("getOfferAttrNew.jsp","���Ժ�...");
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
    /*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������  ѭ�����񷵻صĲ��� �����XFJT ͬʱ�����ʷ� ����ѭ�� �ж��Ƿ�չʾС�����������б� start*/
		
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
	        		/*ȫ��ͨ��ͥ�ʷ���ͨ��Ա �����ǵð��ڲ�Ʒ��*/
	        		if($(this).val() == "70011"){
	        			$(this).parent().parent().find("td:eq(1)").text("2");
	        		}
	        	});
	     		}
			<%}%>
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","<%=operPhoneNo%>");
			getdataPacket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack);
			getdataPacket = null;
			
			//liuijan add �Ѿ��˳��ĳ�Ա�������ٴα�ѡ��
			$('.delete_memeber_70004_1').attr("disabled","true");
			
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e284"){//�ͼ�ͥ����ͥ��ɢ
				var msgPacket = new AJAXPacket("fe280_ajax_chkFamUpd.jsp","���ڻ�ȡ���ݣ����Ժ�......");
				msgPacket.data.add("printAccept","<%=printAccept%>");
				msgPacket.data.add("phoneNo","<%=parentPhone%>");
				msgPacket.data.add("opCode","<%=opCode%>");
				msgPacket.data.add("prodCode","<%=prodCode%>");
				msgPacket.data.add("prodCodeNew","");//��һ����Ʒ����
				msgPacket.data.add("famCode","<%=familyCode%>");
				core.ajax.sendPacket(msgPacket, function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var innetFee = packet.data.findValueByName("innetFee");//��װ��
					var innetrate = packet.data.findValueByName("innetrate");
					var innetRateFee = packet.data.findValueByName("innetRateFee");
					var innetFeeLeft = packet.data.findValueByName("innetFeeLeft");
					var faultFee = packet.data.findValueByName("faultFee");//ΥԼ��
					var TermFee = packet.data.findValueByName("TermFee");//�ն�ΥԼ��
					if(retCode != "000000"){
						rdShowMessageDialog("У��ͻ�ȡ��ͥ��ɢ�����Ϣʧ�ܣ�<br>" + retCode+"<br>"+ retMsg,0);
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
		<div id="title_zi">��ͥ��Ʒ���</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">��ͥ��Ʒ��Ϣ</td>
			<td>
				<select id="familyProdInfo" name="familyProdInfo" onchange="changeProd()">
					<option value ="">--��ѡ��--</option>
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
							//System.out.println("zhouby: ����TlsPubSelCrmʧ��" );
					}
%>
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
			<%
			if ( !"i089".equals(opCode) )
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
			for(int i = 0; i < familyMemberList.length; i++){
				if(selfFlag || familyMemberList[i][3].equals(operPhoneNo)){
					System.out.println("----------liujian--------------selfFlag=" + selfFlag);
					System.out.println("----------liujian--------------operPhoneNo=" + operPhoneNo);
										squittype=familyMemberList[0][5];
					if(!squittype.equals(familyMemberList[i][5])) {//�ҳ��Ѿ������˳��ĳ�Ա�����������
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
			//liujian ����Ŀ�ѡ��Ա�������˳�
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
			<td class="blue" width="10%">���տ�</td>
			<td>
				<input type="text" id="machFee" name="machFee" v_type="money" v_must="1" />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr id="faultFeeHiddTr" style="display:none;">
			<td class="blue" width="10%">ΥԼ��</td>
			<td>
				<input type="text" id="faultFeeHidd" name="faultFeeHidd" v_must="1" value="" class="InputGrey" readonly />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr id="TermFeeHiddTr" style="display:none;">
			<td class="blue" width="10%">�ն�ΥԼ��</td>
			<td>
				<input type="text" id="TermFeeHidd" name="TermFeeHidd" v_must="1" value="" class="InputGrey" readonly />
				<font class="orange">*</font>
			</td>
		</tr>
		<!-- /*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������  ѭ�����񷵻صĲ��� �����XFJT ͬʱ�����ʷ� ����ѭ�� �ж��Ƿ�չʾС�����������б� start*/ -->
		<tr id="OfferAttribute" ></tr><!--С������-->
		<!-- /*2014/02/28 16:18:49 gaopeng �Ҹ����ͥ��ɢ�������ʷѶ�Ӧ��С������  ѭ�����񷵻صĲ��� �����XFJT ͬʱ�����ʷ� ����ѭ�� �ж��Ƿ�չʾС�����������б� end*/ -->
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
