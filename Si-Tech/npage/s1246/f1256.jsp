<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �û������޸�1256
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="1256";
	String opName="�û������޸�";
	String phoneNo = (String)request.getParameter("activePhone");
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String org_codeT = (String)session.getAttribute("orgCode");
	String region_codeT = (String)session.getAttribute("regCode");
	String ipAdd = (String)session.getAttribute("ipAddr");
	

%>

<%
	String sqIdtype = "select id_type,id_name from sidtype";
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=region_codeT%>" outnum="2">
   		<wtc:sql><%=sqIdtype%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="sIdTypeStr" scope="end"/>
<%
	int favFlag = 0 ;
	int gradeFlag = 0;			//�û�����
	int offonFlag = 0;			//�û�ͣ��
	int qryFlag = 0;			//�û��굥��ѯ
	for(int i = 0 ; i < favInfo.length ; i ++){
		if(favInfo[i][0].trim().equals("a272")){
			favFlag = 1;
		}						//����������Ȩ��У��
		if(favInfo[i][0].trim().equals("a1256")){
			gradeFlag = 1;
		}						//���û����Բ����ж�
		if(favInfo[i][0].trim().equals("a1257")){
			offonFlag = 1;
		}						//���û�ͣ����Ȩ���ж�
		if(favInfo[i][0].trim().equals("a1258")){
			qryFlag = 1;
		}						//���굥��ѯȨ���ж�
	
	}
	offonFlag=0;
	 String printAccept="";							/****�õ���ӡ��ˮ****/
	 printAccept = getMaxAccept();
%>

<%
		String favorcode = "a1256";
		int m =0;
		for(int p = 0;p< favInfo.length;p++){//�Ż��ʷѴ���
					for(int q = 0;q< favInfo[p].length;q++)
					{
					 if(favInfo[p][q].trim().equals(favorcode))
						 {
						   ++m;
					     }
						}
		       }
%>

<%
	String sql="select function_code,hand_fee,favour_code from sNewFunctionFee where region_code=:region_code and function_code='1256'";
%>
	<wtc:service name="TlsPubSelCrm"  outnum="3" >
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=region_codeT%>"/> 
	</wtc:service>
	<wtc:array id="fee" scope="end"/>
<%
	String tHandFee = "0";
	int feeFlag = 0;
	if(fee.length==0){
		tHandFee="0";
		feeFlag = 0;
	}else{
		tHandFee=fee[0][1];
		for(int i = 0 ; i < favInfo.length ; i ++){
			if(favInfo[i][0].trim().equals(fee[0][2])){
				feeFlag = 1;
			}
		}
	}

/*�����޸� ��������X_HLJMob_CRM_PD3_2006_220*/
	String sBillCond = "select owner_code,type_name  from scustgradecode  where owner_code not in('01','02','10','11','97','99','91') and region_code = '" + region_codeT + "'";
	System.out.println(sBillCond);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=region_codeT%>" retcode="code1" retmsg="msg1" outnum="2">
   		<wtc:sql><%=sBillCond%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="gradeStr" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�û������޸�</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MShtml 5.00.3315.2870" name=GENERATOR>
</head>
<script language="javascript">
var printFlag=9;
var flag = 0;
var timeFlag = 0;

onload=function(){
	self.status="";
}

function doProcess(packet){
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag    = packet.data.findValueByName("flag");
	if(cfmFlag==99){
		if(backString=="1"){
			rdShowMessageDialog("��֤�ɹ���",2);
			document.frm.submit.disabled=false;
		}else{
			rdShowMessageDialog("���벻��ȷ��");
			document.frm.submit.disabled=true;
		}
	}
	if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
		
			var errCodeInt = parseInt(errCode);

			if(errCodeInt==0){
				rdShowMessageDialog("�����ɹ���",2);
				document.frm.backLoginAccept.value=backString[0][0];
				
			
			if(document.frm.handFee.value!=0){
				printBill();
			}
			

			flag=0;
			resett();
			}else{
				
				rdShowMessageDialog(errCode + " : " + errMsg);
				resett();
				return;
			}
	}
	if(cfmFlag==9){
		rdShowMessageDialog("�ú��벻���ڣ�");
		document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				document.frm.phoneNo.disabled=false;
				flag=0;
				return;
	}
	if(cfmFlag==0){
	if(backString==""){
		rdShowMessageDialog("��ѯʧ�ܣ�");
		document.frm.qry.disabled=false;
		document.frm.phoneNo.disabled=false;
		document.frm.phoneNo.value="";
	}else{
	if(document.frm.favFlag.value==1){
		document.frm.submit.disabled=false;
	}
	document.frm.customPass.value=backString[0][4];
	document.frm.userId.value=backString[0][0];
	document.frm.smName.value=backString[0][2];
	document.frm.runName.value=backString[0][6];
	document.frm.cardType.value=backString[0][15];
	document.frm.custAddress.value=backString[0][11];
	document.frm.asCustName.value=backString[0][23];
	document.frm.asCustPhone.value=backString[0][24];
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
			
			if(document.frm.asIdType.options[idI].value==backString[0][25]){
				document.frm.asIdType.options[idI].selected=true;
				break;
			}
		}
	document.frm.asIdIccid.value=backString[0][26];
	document.frm.asIdAddress.value=backString[0][27];
	document.frm.asContractAddress.value=backString[0][28];
	document.frm.asNotes.value=backString[0][29];
	document.frm.idCardNo.value=backString[0][14];
	document.frm.totalPrepay.value=backString[0][17];
	document.frm.totalOwe.value=backString[0][16];
	document.frm.custName.value=backString[0][3];
	
	var creditI = 0;
	if(document.frm.gradeCode.length>1){
		for(creditI = 0 ; creditI < document.frm.gradeCode.length ; creditI ++){

			if(document.frm.gradeCode.options[creditI].value==backString[0][21]){
				document.frm.gradeCode.options[creditI].selected=true;
				document.frm.oldGradeName.value=document.frm.gradeCode.options[creditI].text;
				creditI = 99;
				break;
			}
		}
	}
	if(document.frm.openType.length>1){
		if(backString[0][22]=="N"){
			document.frm.openType.options[1].selected=true;
		}
		else{
			document.frm.openType.options[0].selected=true;
		}
	}
	if(document.frm.ifDetail.length>1){
		if(backString[0][30]=="N"){
			document.frm.ifDetail.options[1].selected=true;
		}
		else{
			document.frm.ifDetail.options[0].selected=true;
		}
	}
	flag=1;
	document.frm.handFee.disabled=false;
	document.frm.factPay.disabled=false;
	
	}
	document.frm.submit.disabled=false;
}
	
}
function submitt(){
      if(document.frm.phoneNo.value==""){
      	rdShowMessageDialog("�������ֻ����룡");
      	return;
      }
      if(!checkElement(document.all.phoneNo)){
			document.frm.phoneNo.value = "";
			return;
		}
		document.frm.qry.disabled=true;
		document.frm.phoneNo.disabled=true;
		var myPacket = new AJAXPacket("getUserInfo.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
    	core.ajax.sendPacket(myPacket);
    	myPacket=null;
}
function getRemain(){

	if(flag!=1){
		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
		return;
	}
	
	
	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFeeT.value);
		return;
	}

	document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
}

function submitCfm(){
	getAfterPrompt();
	if(flag==1){
		if(document.frm.remark.value.length==0){
			document.frm.remark.value="�û������޸�";
		}	
		
		if(!forReal(document.frm.handFee)){
				return;
			}
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFeeT.value);
		return;
	}
		printCommit();
		//update by qiansheng 20091026  ԭ��������д��뱻ע�ͣ�ȥ��ע�͡�
		if(printFlag!=1){
			return;
		//update end	
		}
		var creditI = 0;
		var newCredit = "";
	for(creditI = 0 ; creditI < document.frm.gradeCode.length ; creditI ++){
		if(document.frm.gradeCode.options[creditI].selected){
			newCredit = document.frm.gradeCode.options[creditI].value;
			
		}
	}
	var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
			if(document.frm.asIdType.options[idJ].selected==true){
				inputIdType = document.frm.asIdType.options[idJ].value;
			}
		}
	var stopI = 0 ; 
	var newStopFlag = 0;
	for(stopI = 0 ; stopI < document.frm.openType.length ; stopI ++){
		if(document.frm.openType.options[stopI].selected){
			newStopFlag = document.frm.openType.options[stopI].value;
		}
	}
	
	var detailI = 0 ; 
	var newDetailFlag = 0;
	for(detailI = 0 ; detailI < document.frm.ifDetail.length ; detailI ++){
		if(document.frm.ifDetail.options[detailI].selected){
			newDetailFlag = document.frm.ifDetail.options[detailI].value;
		}
	}
	
		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("fa256Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"�����ύ�����Ժ�......");
		
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("asIdType",inputIdType);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("ownerCode",newCredit);
		myPacket.data.add("stopFlag",newStopFlag);
		myPacket.data.add("ifDetail",newDetailFlag);
		
		myPacket.data.add("handFee",document.frm.handFeeT.value);
		myPacket.data.add("factPay",document.frm.handFee.value);

		myPacket.data.add("ipAdd",document.frm.ipAdd.value);

		
    	core.ajax.sendPacket(myPacket);

    	myPacket=null;
    	}else{
    	rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
    	}
}
function verifyPass(){
	if(flag==1){
		var n = document.frm.customPass.value;
		var myPacket = new AJAXPacket("verifyPass.jsp","�����ύ�����Ժ�......");
		
		myPacket.data.add("customPass",n);
		
		
    	core.ajax.sendPacket(myPacket);

    	myPacket=null;
		
		
	}else{
    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
	}

}
function resett(){
	document.frm.customPass.value="";
	document.frm.userId.value="";
	document.frm.runName.value="";
	
	document.frm.idCardNo.value="";				
	document.frm.totalPrepay.value="";				
	document.frm.totalOwe.value="";
	document.frm.custName.value="";
	document.frm.phoneNo.value="";
	
	document.frm.qry.disabled=false;
	document.frm.phoneNo.disabled=false;
	document.frm.submit.disabled=true;
	document.frm.custAddress.value="";
	document.frm.asCustName.value="";
	document.frm.asCustPhone.value="";
	document.frm.asIdType.options[0].selected=true;
	document.frm.asIdIccid.value="";
	document.frm.asIdAddress.value="";
	document.frm.asContractAddress.value="";
	document.frm.asNotes.value="";
	document.frm.cardType.value="";
	printFlag=9;
	timeFlag=0;
	flag=0;
	window.location="fa256.jsp?activePhone=<%=activePhone%>";
}
</script>
<body>
<form action="" method=post name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û��̶���Ϣ</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue"> ������� </td>
		<td colspan="5">
			<input  id=Text2 type=text size=17 name=phoneNo value=<%=phoneNo%>  v_type="mobphone"  maxlength=11 index="0" class="InputGrey" readonly>
			<input class="b_text" id=Text22 type=button  size=17  name=qry  value="��ѯ" onClick="submitt()">
		</td>
	</tr>
	<tr> 
		<td class="blue">�û�I D</td>
		<td> 
			<input id=Text2 type=text size=17 name=userId class="InputGrey" readonly >
		</td>
		<td class="blue">��ǰ״̬</td>
		<td> 
			<input type=text size=17 name=runName class="InputGrey" readonly >
		</td>
		<td class="blue"> �ͻ�����</td>
		<td> 
			<input id=Text2 type=text size=17 name=custName class="InputGrey" readonly >
		</td>
	</tr>
	<tr> 
		<td class="blue"> ��ǰԤ��</td>
		<td> 
			<input id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly >
		</td>
		<td class="blue">��ǰǷ��</td>
		<td> 
			<input id=Text2 type=text size=17 name=totalOwe class="InputGrey" readonly >
		</td>
		<td class="blue">��ͻ���־</td>
		<td> 
			<input type=text size=17 name=cardType class="InputGrey" readonly >
		</td>
	</tr>
</table>
</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">�ɱ���Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<%if(gradeFlag>0) {				%>
		<td class="blue"> �û�����</td>
		<td> 
			<select name=gradeCode index="2">
				<%for(int i = 0 ; i < gradeStr.length ; i ++){%>
				<option value="<%=gradeStr[i][0]%>"><%=gradeStr[i][1]%></option>
				<%}%>
			</select>
		</td>
			<%}else{%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
			<%}if(offonFlag>0){				%>
		<td class="blue">ͣ������־</td>
		<td colspan="3"> 
			<select name=openType index="3">
				<option value="Y">ͣ�� </option>
				<option value="N">��ͣ�� </option>
			</select>
		</td>
			<%}else{%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
			<%}if(qryFlag>0){			%>
		<td class="blue" style="display:none ">�굥�����־</td>
		<td style="display:none "> 
			<select name=ifDetail index="4">
				<option value="Y">����</option>
				<!--option value="N">������</option-->
			</select>
		</td>
			<%}else{%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
			<%}%>
	</tr>
	<tr> 
		<td class="blue"> ����������</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=asCustName maxlength=20 >
		</td>
		<td class="blue">��������ϵ�绰</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
		</td>
		<td class="blue">��ϵ��ַ</td>
		<td colspan="2"> 
			<input class=button id=Text2 type=text size=17 name=asContractAddress  maxlength=20>
		</td>
	</tr>
	<tr> 
		<td class="blue"> ������֤������</td>
		<td> 
			<select size=1 name=asIdType  >
				<%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
				<option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
				<%}%>
			</select>
		</td>
		<td class="blue">֤������</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
		</td>
		<td class="blue">֤����ַ</td>
		<td colspan="2"> 
			<input class=button id=Text2 type=text size=17 name=asIdAddress  maxlength=20>
		</td>
	</tr>
	<tr> 
		<td class="blue"> ������ע</td>
		<td colspan="5"> 
			<input class=button id=Text2 type=text size=30 name=asNotes  maxlength=30>
		</td>
	</tr>
	<tr> 
		<td class="blue">������</td>
		<td> 
			<input class=button id=Text2 type=text size=17 index="5" name=handFee <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type="float">
		</td>
		<td  class="blue">ʵ��</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=factPay index="6" disabled onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;
			<input class="b_text" id=Text2 type=button size=17 name=getUseInfo value="-->" onclick="getRemain()">
		</td>
		<td  class="blue">����</td>
		<td>
			<input id=Text2 type=text size=17 name=remain class="InputGrey" readonly >
		</td>
	</tr>
	<tr>
		<td class="blue">�û���ע</td>
		<td colspan="5">
			<input class="InputGrey" readOnly id=Text3 type=text size=60 name=remark value="" index="7">
		</td>
	</tr>
		<%if(gradeFlag<=0){%>
        <tr  style="display:none">
        	<td colspan="6">
				<select name=gradeCode index="2">
					<option value="N_N">N_N</option>
				</select>
			</td>
		</tr>
		<%}%>
		<%if(offonFlag<=0){%>
        <tr  style="display:none">
        	<td colspan="6">
				<select name=openType index="2">
					<option value="N_N">N_N</option>
				</select>
			</td>
		</tr>
		<%}%>
		<%if(qryFlag<=0){%>
        <tr  style="display:none">
        	<td colspan="6">
				<select name=ifDetail index="2">
					<option value="N_N">N_N</option>
				</select>
			</td>
		</tr>
		<%}%>
	<tr align="center" id="footer">
		<td colspan="6">
			<input class="b_foot" name=submit type=button index="8" value="ȷ��" onclick="submitCfm()" disabled onKeyUp="if(event.keyCode==13){submitCfm()}">
			<input class="b_foot" name=back type=button value="���" onclick="window.location='fa256.jsp?activePhone=<%=activePhone%>'">
			<input class="b_foot" name=back type=button value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
</table>
<input type=hidden name=loginAccept value="<%=printAccept%>">
<input type=hidden name=opCode value="1256">


<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=sysRemark value="�û������޸�">
<input type=hidden name=ipAdd value="<%=ipAdd%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">   
<input type=hidden name=qryFlagT value="">
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>    
<input type=hidden name=backLoginAccept>
<input type=hidden name=timeFlag value="0">
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>">
<input type=hidden name=oldGradeName value="">
<input type=hidden name=smName value="">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //��ʾ��ӡ�Ի��� 
	var h=180;
	var w=380;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

    var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="1256" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰


    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfn+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
			
     var ret=window.showModalDialog(path,printStr,prop);
     
   if(typeof(ret)!="undefined")
   {
	ret="confirm";
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {

       if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
       {
       	printFlag=1;
       }
     }
   }
}

function printInfo(printType)
{
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
    if(printType == "Detail")
    {
		  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		  cust_info+="�ͻ�������"+document.frm.custName.value+"|";
		  cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
		  cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
		  cust_info+="֤�����룺"+document.frm.idCardNo.value+"|"; 
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  opr_info+="�û�Ʒ�ƣ�"+document.frm.smName.value+"|";
		  opr_info+="����ҵ���û������޸ġ�"+"|";
		  opr_info+="������ˮ��"+document.frm.loginAccept.value+"|";
		  opr_info+="�û�ԭ���ԣ�"+document.frm.oldGradeName.value+"|";
		  opr_info+="�û������ԣ�"+document.frm.gradeCode.options[document.frm.gradeCode.selectedIndex].text+"|";
    }  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
    }
	    retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	    return retInfo;	
}
</script>
<script>
function printBill(){
	 var infoStr="";                                                                         
	     infoStr+=" "+"|";                                                                        
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+=document.frm.phoneNo.value+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+=document.frm.custName.value+"|";//�û�����                                                
	 infoStr+=document.frm.custAddress.value+"|";//�û���ַ     
	 infoStr+="�ֽ�"+"|";
	 infoStr+=document.frm.handFee.value+"|";                                            
	 infoStr+="�굥�������롣*�����ѣ�"+document.frm.handFee.value+"*��ˮ�ţ�"+document.frm.backLoginAccept.value+"|";
	 location.href="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=fa256.jsp";                    
}
</script>
</BODY></html>
