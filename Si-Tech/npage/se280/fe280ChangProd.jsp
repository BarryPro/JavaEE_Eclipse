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
 		String printName2 = "����ʷ��ײ�";
 		String v_case = "2";
 		if("e855".equals(opCode)){ //��Ʒ���
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT") || familyCode.equals("HJTA") || familyCode.equals("HJTB") || familyCode.equals("ZHJT")){
 				v_case = "9";
 			}
 			if(familyCode.equals("HEJT") || familyCode.equals("JHJT")){
	 			printName2 = "�ͼ�ͥ-�����ײͱ��";
 			}else if(familyCode.equals("HJTA") || familyCode.equals("HJTB")){
 				printName2 = "�ͼ�ͥ-�ں��ײͱ��";
 			}else if(familyCode.equals("ZHJT")){
 				printName2 = "�ͼ�ͥ-ħ�ٺ��ں��ײͱ��";
 			}
 		}
    if("e283".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "�����˳����鳩��";
 			}
 		  else {
 		  printName = "�Ҹ���ͥ��Աҵ���˶�";
 		  }
 		}else if("e284".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩����ȡ��";
 			}
 			else {
 		  printName = "�Ҹ���ͥҵ���˶�";
 		  }
 		}else if("e285".equals(opCode)){
 			if(familyCode.equals("QQSY") || familyCode.equals("QQWY")) {
 			printName = "���鳩�������";
 			}
 			else {
 		  printName = "����ʷ��ײ�";
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
	String v_membRoleId = "";//�����Ա����
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
						if("70025".equals(familyMemberList[i][0]) || "70028".equals(familyMemberList[i][0]) || "70031".equals(familyMemberList[i][0]) || "70034".equals(familyMemberList[i][0])){ //�����Ա
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
				rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
		}
%>

<%
		/*20121122 gaopeng �������� ��ͥ��Ʒ������ܲ�ѯ���� 
		/************************************************************************
			*** �������ƣ�sFamProdUpChk
			*** ����ʱ�䣺2012/11/21
			*** ������Ա��shiyong
			*** ������������ͥ��Ʒ������ܲ�ѯ����
			*** 
			*** ���������
			***          0   ��ˮ             iLoginAccept           
			***          1   ������ʶ         iChnSource           
			***          2   ��������         iOpCode          
			***          3   ����             iLoginNo           
			***          4   ��������         iLoginPwd           
			***          5   �ҳ�����         iPhoneNo  
			***          6   ��������         iUserPwd       
			***          7   ��ѯ����         iQryType   0�������ڲ�Ʒ���ҳ���������˵���ֵ
			***          8   ��ͥ����         iFamCode   �� 'XFJT'
			***          9   ��Ʒ����         iProdCode  �� 1001 �������30Ԫ�ײ� 	
			*** ���Σ�
			***			 		 0	 ��Ʒ����		
			*** 	   		 1   ��Ʒ����         vProdCode	�� 1001,1002	
			***			 		 2	 ��Ʒ����		 			vProdName*/	
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
		System.out.println("���÷���sFamProdUpChk in fe280ChangProd.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

	}else{
		System.out.println("���÷���sFamProdUpChk in fe280ChangProd.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode12%>��������Ϣ��<%=errMsg12%>");
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
		var famBusiArray2 = new Array();
		var quitphoneArray = new Array();
		function nextStep(subButton){

			/* ��ť�ӳ� */
			controlButt(subButton);
			/* �º����� */
			getAfterPrompt();
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���
				var selChgval = $("select[name='selChg']").find("option:selected").val();
				if(selChgval == ""){
					rdShowMessageDialog("��ѡ�����Ĳ�Ʒ��");
					return false;
				}
			}
			
			/* ƴװ���� */
			setJSONText();
			/* ƴװ���� */
			/* ��ӡ���&�ύҳ�� */
			printCommit11('<%=opCode%>');

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
			var normalMemberStr = getPhoneNoByMemberId("70002");
			var otherMemberStr = getPhoneNoByMemberId("70004");
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
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��<%=printName2%>" +"|";
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT")&&"<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���

				opr_info += "�ͼ�ͥ-�����ײ��������룺"+$("#operPhoneNo").val() + "|";
			}else if(("<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���

				opr_info += "�ͼ�ͥ-�ں��ײ��������룺"+$("#operPhoneNo").val() + "|";
			}else if("<%=familyCode%>"=="ZHJT"  && "<%=opCode%>"=="e855"){//��ϼ�ͥ����Ʒ���
				opr_info += "�ͼ�ͥ-ħ�ٺ��ں��ײͼҳ����룺"+$("#operPhoneNo").val() + "|";
			}
			else{
				opr_info += "��ͥ�˾�ͨ�̻����룺" + $("#parentPhone").val() + "|";
			}
		 if(opcode=="e283") {
			opr_info += "�˳����鳩��ҵ����齨�˺��룺"+$("#operPhoneNo").val() + "|";		
			
			}	
			else if(opcode=="e284") {
			opr_info += "�齨���鳩���˺��룺"+$("#operPhoneNo").val() + "|";
			}
			else if(opcode=="e285") {
			opr_info += "���鳩���齨�˺��룺"+$("#operPhoneNo").val() + "|";
			}
			

			var opr_info_temp = '';
			var note_info1_temp = '';
			switch(opcode) {
				case 'e855' : 
					if("<%=familyCode%>"!="HEJT" && "<%=familyCode%>"!="JHJT" && "<%=familyCode%>"!="HJTA" && "<%=familyCode%>"!="HJTB" && "<%=familyCode%>"!="ZHJT"){//�ͼ�ͥ����Ʒ���
			
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
						}
					}
					/*�趨ָ���ʷ�*/
					if(mainOfferNameVal.length > 0){
						offerName = mainOfferNameVal;
					}
					if(mainOfferCommentVal.length > 0){
						offerComment = mainOfferCommentVal;
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
					 if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���
	
					 	 /*var selChgval = $("select[name='selChg']").find("option:selected").val();
					 	 var selChgText = $("select[name='selChg']").find("option:selected").text().split("--");*/
					 	 opr_info += "ԭ�ʷ����ƣ�" + offerName +"   �ʷѴ��룺" + $("#v_offerId").val()+ "|";	
					 	 /*opr_info += "�ʷѴ��룺" + "<%=prodCode%>" + "|";	*/
					 	 opr_info += "�����ʷ����ƣ�" + $("#newmainOfferName").val() +"   �ʷѴ��룺" + $("#newmainOfferId").val() + "|";
					 	 //opr_info += "�ʷѴ��룺" + $("#newmainOfferId").val() + "|";	
					 }else{
					 	 /* opr_info += "ԭ�Ҹ���ͥ���ʷѣ�" +"<%=offerids%><%=offernames%>"+ "|";
				     opr_info += "���������Ҹ���ͥ���ʷѣ�" + offerName + "|";	*/
				     opr_info += "ԭ�Ҹ���ͥ���ʷѣ�" + offerName + "|";	
				     opr_info += "���������Ҹ���ͥ���ʷѣ�" + $("#newmainOfferName").val() + "|";		
					 }				   
			} 
			opr_info += opr_info_temp;
			/************ע������************/
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���

				note_info1 += "�����ʷ�������" + "|";
				note_info1 += $("#newmainorOffercomment").val() + "|";
			}else if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e855"){//��ϼ�ͥ����Ʒ���

			}else{
				note_info1 += "��ע��" + "|";
				if(offerComment.length > 0){
					note_info1 += "��������ʷ�������" + $("#newmainorOffercomment").val() + "|";
				}
			}
			
			note_info1 += note_info1_temp;
			note_info1 += "ע�����" + "|";
			if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT")&&"<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���

		  			note_info1 += "1�����Ա�ײ��������ͨ��ʱ����������������������ʹ�ó�Ա�ײ������ͨ��ʱ�������������������������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ������������������ͨ��ʱ������������ʹ�������������Ա�û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��"+"|";
						note_info1 += "2�������ײ͵������ͳ�Ա����������ͬһ�����У������û����ܰ���ͣ��Ԥ����"+"|";
						note_info1 += "3���ں�Լ���ڣ�88Ԫ�ײ��û��ɱ����118Ԫ�������ײͣ��貹��100Ԫ�����ն˳�װ�ѣ��������繫˾�ṩ�๦�������նˣ�ԭMODEM�ͻ������践�������ߵ��Ӱ�װ��Ա��118Ԫ�������ײ��û��ɱ��Ϊ��88Ԫ�ײ͡������ײ��û����ɱ��Ϊ�ǰ����ײ͡���ȡ���ײ͡�"+"|";
						note_info1 += "4���ֻ�����Ƿ�ѣ����չ�ͣ����������ܼ����ߵ��ӷ�����ԭ���ߵ����˻�û�з��ã����û��ɷѺ�ָ���������ߵ��ӹ��ܡ�"+"|";
						note_info1 += "5���ͻ�ԭ���ߵ����˻����ò��ˣ����ֻ�����Ƿ�ѻ��Լ�ڽ����󣬿ɼ���ʹ��ԭ���ߵ����˻�����֧�����ߵ��ӻ������ӷѼ���ֵҵ����á�"+"|";
						note_info1 += "6���ֻ��������û��ʷ�������Ч���ײ����ֻ������ߵ��ӷ�����ͬ����Ч������԰�װ����ʱ��Ϊ׼��Ч���ײͰ�������ȡʹ�÷ѣ������û������ʷ�ԤԼ��Ч������統�¿���������飬�ֻ�����������ߵ���ҵ�����1����Ч����ʼ�Ʒѡ�"+"|";
						note_info1 += "7�������ײ��û�ֻ��ͨ���ֻ��˻����ɿ���ѣ�����ͨ������˻������ɷѡ�"+"|";
						note_info1 += "8�������ײ���ʹ�÷ѣ���������ȡ�����������°��¡�"+"|";
						
			}else if(("<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB") && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���


		  			note_info1 += "1�����Ա�ײ��������ͨ��ʱ����������������������ʹ�ó�Ա�ײ������ͨ��ʱ�������������������������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ������������������ͨ��ʱ������������ʹ�������������Ա�û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��"+"|";
						note_info1 += "2���ں��ײ͵������ͳ�Ա����������ͬһ�����У������û����ܰ���ͣ��Ԥ����"+"|";
						note_info1 += "3���ں�Լ���ڣ��ں��ײ��û����ɱ��Ϊ���ں��ײͣ���ȡ���ں��ײ͡�"+"|";
						note_info1 += "4���ֻ�����Ƿ�ѣ����չ�ͣ����������� ���û��ɷѺ�ָ�������ܡ�"+"|";
						note_info1 += "5���ֻ��������û��ʷ�������Ч������԰�װ����ʱ��Ϊ׼��Ч���ײͰ�������ȡʹ�÷ѣ������û��ں��ʷ�ԤԼ��Ч������統�¿���������飬�ֻ��Ϳ��ҵ�����1����Ч����ʼ�Ʒѡ�"+"|";
						note_info1 += "6���ں��ײ��û�ֻ��ͨ���ֻ��˻����ɿ���ѣ�����ͨ������˻������ɷѡ�"+"|";
						note_info1 += "7���ں��ײ���ʹ�÷ѣ���������ȡ�����������°��¡�"+"|";
			
			}else if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e855"){//��ϼ�ͥ����Ʒ���
						var autoCancel = $("#autoCancel").val();
		  			note_info1 += "1�����Ա�ײ��������ͨ��ʱ����������������������ʹ�ó�Ա�ײ������ͨ��ʱ�������������������������ʹ��������ͥ�ײ��ڵĹ���ͨ��ʱ������������������ͨ��ʱ������������ʹ�������������Ա�û��ֱ�ִ�и�����ѡ�ײ͵ĳ������ʷѱ�׼��"+"|";
						note_info1 += "2��ħ�ٺ��ں��ײ͵������ͳ�Ա����������ͬһ�����У������û����ܰ���ͣ��Ԥ����"+"|";
						note_info1 += "3���ں�Լ���ڣ�ħ�ٺ��ں��ײ��û������ڲ�ͬ�۸��ħ�ٺ��ں��ײ��ڱ���ײͣ������ɱ��Ϊ��ħ�ٺ��ں��ײͣ���ȡ��ħ�ٺ��ں��ײ͡�"+"|";
						note_info1 += "4���ֻ�����Ƿ�ѣ����չ�ͣ����������� ���û��ɷѺ�ָ�������ܡ�"+"|";
						note_info1 += "5���ֻ��������û��ʷ�������Ч������԰�װ����ʱ��Ϊ׼��Ч���ײͰ�������ȡʹ�÷ѣ������û��ں��ʷ�ԤԼ��Ч������統�¿���������飬�ֻ��Ϳ��ҵ�����1����Ч����ʼ�Ʒѡ�"+"|";
						note_info1 += "6��ħ�ٺ��ں��ײ��û�ֻ��ͨ���ֻ��˻����ɿ���ѣ�����ͨ������˻������ɷѡ�"+"|";
						note_info1 += "7��ħ�ٺ��ں��ײ���ʹ�÷ѣ���������ȡ�����������°��¡�"+"|";
						if(autoCancel == "0"){
							note_info1 += "8���ͼ�ͥ-ħ�ٺ��ں��ײ͵��ں󣬻����������Զ�������ÿ����20ԪǮ��"+"|";
						}else if(autoCancel == "1"){
							note_info1 += "8���ͼ�ͥ-ħ�ٺ��ں��ײ͵��ں󣬻����������Զ�ȡ����"+"|";
						}
			}else{
				note_info1 += "1��ԭ�ʷ���Ч�������µס�"+"|";
				note_info1 += "2�����ʷ��Ż�������1����ʱ��Ч��"+"|";
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
				returnStr += "1���ɹ������˶��Ҹ���ͥ�ײͣ��Դ����𽫲��������Ҹ���ͥ�ײ��Ż�ҵ��" + "|";
			}else if(opCode == "e284"){
				returnStr += "1���ƶ��ֻ������˶��Ҹ���ͥ�ײͺ��Դ����𽫰��ղ������ܼ�ͥ��ҵ���Ż��ʷѡ�" + "|";
				returnStr += "2�������Ĺ̻����������ⲻ�ܼ���ʹ�ã��뵽Ӫҵ�����¹����������������ҵ��������δ�����ͻ���ɢ��ͥ�򻰷Ѳ��ٷ������ͻ���Ҫ�������򻰻���ͬʱ�ƶ���˾��ȡ�ʣ��Ԥ�滰�ѵ�30%��ΪΥԼ��" + "|";
			}else if(opCode == "e285") {
				returnStr += "1������ҵ�����������˾�ͨҵ���ܷ�15Ԫ/�Ρ�" + "|";
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
					/* ��������Ҫƴ��business���� */
					famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
					famRole = createBusiness1(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
					
					familyRoleList.addFamRole(famRole);
				}
			});
			familyRoleList.setPay_money($("#prepayFeeHide").val());
      if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB")  && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���
				familyRoleList.setInnet_Fee($("#innetFeeHidd").val());//��װ��
			}
			if("<%=familyCode%>"=="ZHJT"  && "<%=opCode%>"=="e855"){//��ϼ�ͥ����Ʒ���
				familyRoleList.setAutoCancel($("#autoCancel").val());//�����Ƿ��Զ�ȡ��
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
					if("<%=familyCode%>"=="XFJT"&&"<%=opCode%>"=="e855"){//�Ҹ���ͥ����Ʒ���
					  if(famBusiArray2[i][4]=="MO"){//���ʷ�
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
		function getmainoffers () {
		
		
		}
		
		function appendOffers() {//ƴ���Ѿ�������ʷѺͿ�ѡ�ʷѣ����ݰ�����Ǳ��ؼƻ���ʡ�ڼƻ���
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
					
					
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","���ڻ�ȡ���ݣ����Ժ�......");
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
						rdShowMessageDialog("û�в�ѯ��Ҫת�����ʷ���Ϣ" + retCode + retMsg);
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
  							$("#newmainOfferId").val(famBusiArray2[i][8]);//���ʷ�id
  							$("#newmainorOffercomment").val(famBusiArray2[i][10]);
  					   }       					
					  }
					  newarrayObj= array_unique4(arrayObj);
					
  					for(var i=0;i<newarrayObj.length;i++){
              stingstr+=newarrayObj[i]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            }
  					$("#zhh").html("");
  					$("#zhh").append(stingstr);
  					//�ж��Ƿ�չʾС���ʷ�
  					if($("#newmainOfferId").val() != ""){
  						//if(famBusiArray2[i][8]!=""&&famBusiArray2[i][8]!=null){
	  					  if(("<%=familyCode%>"=="XFJT" || "<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT")&&"<%=opCode%>"=="e855"){//�Ҹ���ͥ����Ʒ��� + �ͼ�ͥ����Ʒ���
	  					    changeMainOffer($("#newmainOfferId").val());
	  					  }
	  					//}
  					}
					}
		}
		
		function changeMainOffer(offerId){
		  var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","���Ժ�...");
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
      var hiddenFlag =  packet.data.findValueByName("hiddenFlag");//�Ƿ���ʾС�������ʶ
      var offer_id =  packet.data.findValueByName("offerId");//�ʷѴ���
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
      if(v_hiddenFlag=="Y"){ //��ΪYʱ������С������չʾҳ��
        for(var i=0;i<code.length;i++){
          //alert(text[i]);
        }
        var packet1 = new AJAXPacket("getOfferAttrNew.jsp","���Ժ�...");
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
			var offerName = packet.data.findValueByName("offerName"); //ָ���ʷ�����
			var v_offerId = packet.data.findValueByName("v_offerId"); //ָ���ʷѴ���
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
			$("#v_offerId").val(v_offerId);
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
			getmainoffers();
			appendOffers();
			var opCodeVal = "<%=opCode%>";
			if(opCodeVal == "e855"){
				setLastTDHide();
			}
			if(opCodeVal == "e285"){
				setLastTDHide();
			}
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","<%=operPhoneNo%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			
			//liuijan add �Ѿ��˳��ĳ�Ա�������ٴα�ѡ��
			$('.delete_memeber_70004_1').attr("disabled","true");
			
			if("<%=familyCode%>"=="ZHJT" && "<%=opCode%>"=="e855"){
				$("#autoCancelTab").css("display","none");
			}
			
		});
		/* */
		function selChang(temp)
		{
			var chkFamUpd = "Y";
     if(("<%=familyCode%>"=="HEJT" || "<%=familyCode%>"=="JHJT" || "<%=familyCode%>"=="HJTA" || "<%=familyCode%>"=="HJTB" || "<%=familyCode%>"=="ZHJT") && "<%=opCode%>"=="e855"){//�ͼ�ͥ����Ʒ���
				var msgPacket = new AJAXPacket("fe280_ajax_chkFamUpd.jsp","���ڻ�ȡ���ݣ����Ժ�......");
				msgPacket.data.add("printAccept","<%=printAccept%>");
				msgPacket.data.add("phoneNo","<%=parentPhone%>");
				msgPacket.data.add("opCode","<%=opCode%>");
				msgPacket.data.add("prodCode","<%=prodCode%>");
				msgPacket.data.add("prodCodeNew",temp);//��һ����Ʒ����
				msgPacket.data.add("famCode","<%=familyCode%>");
				core.ajax.sendPacket(msgPacket, function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var innetFee = packet.data.findValueByName("innetFee");//��װ��
					var innetrate = packet.data.findValueByName("innetrate");
					var innetRateFee = packet.data.findValueByName("innetRateFee");
					var innetFeeLeft = packet.data.findValueByName("innetFeeLeft");
					if(retCode != "000000"){
						rdShowMessageDialog("У��ͻ�ȡ��ͥ��Ʒ��������Ϣʧ�ܣ�<br>" + retCode+"<br>"+ retMsg,0);
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
			var getdataPacket = new AJAXPacket("chkHEJTProd.jsp","���Ժ�...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("parentPhone","<%=parentPhone%>");
			getdataPacket.data.add("familyCode","<%=familyCode%>");
			getdataPacket.data.add("familyProdInfo",temp);
			getdataPacket.data.add("phoneNoVal","");
			core.ajax.sendPacket(getdataPacket,function(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				if(retCode != "000000"){
					rdShowMessageDialog("У�鲻ͨ����" + retCode + "��" + retMsg,0);
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
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","���ڻ�ȡ���ݣ����Ժ�......");
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
			<th>����</th>
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
			//liujian ����Ŀ�ѡ��Ա�������˳�
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
			<td class="blue" width="10%">��ǰ�ʷ�
			</td>
			<td id="zhq">
			</td>
		</tr>
		<%
		if(result23.length>0)
		{
		%>
		<tr>
			<td class="blue" width="10%">��Ʒ���
			</td>
			<td>
				<select name="selChg" style="width:250px" onchange="selChang(this.value);">
					<option value="" selected>----��ѡ��----</option>
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
		 				 <font class='red'> (��ע�⣺��88Ԫ���Ϊ������λ������������ն˷���100Ԫ��) </font> 
		 		<%}%>				
			</td>
		</tr>
		<%
		}
		%>
				<tr >
			<td class="blue" width="10%">ת�����ʷ�
			</td>
			<td id="zhh">
			</td>
		</tr>
		<tr id="changeOfferAttribute" ></tr><!--С������-->
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
	<table id="autoCancelTab" style="display:none;">
		<tr>
			<td class="blue" width="10%">�����Ƿ��Զ�ȡ��</td>
			<td colspan="3">
				<select id="autoCancel" name="autoCancel" >
					<option value ="1" >��</option>
					<option value ="0" >��</option>
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
