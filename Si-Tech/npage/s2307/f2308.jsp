<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �û��������޸�2308
   * �汾: 1.0
   * ����: 2009/1/15
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	String opCode = "2308";
	String opName = "�û��������޸�";
	String phoneNo = (String)request.getParameter("activePhone");		//�û�����
	String workNo = (String)session.getAttribute("workNo");				//��������
	String workName = (String)session.getAttribute("workName");			//����Ա
	String nopass = (String)session.getAttribute("password");			//��������
	String rightCode = (String)session.getAttribute("rightCode");		//
	String orgCode = (String)session.getAttribute("orgCode");			//��������
	String regionCode = (String)session.getAttribute("regCode");		//���д���
	String[][] favInfo = (String[][])session.getAttribute("favInfo");	//�Ż���Ϣ
	int favFlag = 0 ;
//begin add by diling for ������Ȩ������ @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = opCode;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======f2308.jsp==== pwrf = " + pwrf);
if(pwrf){               
    favFlag = 1;
}
//end add by diling for ������Ȩ������ @2011/11/1 

%>

<%
//	comImpl co=new comImpl();
	String sqIdtype = "select id_type,id_name from sidtype";
//	ArrayList sIdTypeArr = co.spubqry32("2",sqIdtype);
//	String[][] sIdTypeStr = (String[][])sIdTypeArr.get(0);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="sIdTypeStrCode" retmsg="sIdTypeStrMsg">
		<wtc:sql><%=sqIdtype%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="sIdTypeStr" scope="end" />
<%	
	
//	ArrayList arr = F2307Wrapper.getFuncFee(regionCode);
	
	StringBuffer sq1 = new StringBuffer();
		sq1.append("select function_code,hand_fee,favour_code");
		sq1.append("  from sNewFunctionFee ");
		sq1.append(" where region_code='");
		sq1.append(regionCode);
		sq1.append("' and function_code='2307'");
		System.out.println(sq1.toString());
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=sq1.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="fee" scope="end" />
<%		
//	String[][] fee = (String[][])arr.get(0);   
	//System.out.println(fee.length);
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
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>


<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<TITLE>�û��������޸�</TITLE>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
	var printFlag=9;
	var flag1 = 0;
	var timeFlag = 0;
	
onload=function(){
	self.status="";
	document.all.phoneNo.focus();
	alert("document.all.simBell.value=["+document.all.simBell.value+"]");
}
function doProcess(packet){
	
	
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag1");
	if(cfmFlag==99){
		if(backString==1){
			rdShowMessageDialog("��֤�ɹ���");
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
				}else{
					window.location="f2308.jsp?activePhone=<%=activePhone%>";
				}
			
			}else{
				
				rdShowMessageDialog(errCode + " : " + errMsg,0);
				window.location="f2308.jsp?activePhone=<%=phoneNo%>";
			}
			
		
		
	}
	if(cfmFlag==9){
		//rdShowMessageDialog("�ú��벻���ڣ�");
		var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog(errCode + " : " + errMsg);
		document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				document.frm.phoneNo.disabled=false;
				flag1=0;
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
	document.frm.userId.value=backString[0][0];
	document.frm.runName.value=backString[0][6];
	document.frm.cardType.value=backString[0][15];
	document.frm.gradeName.value=backString[0][8];
	document.frm.custAddress.value=backString[0][11]; //11
	document.frm.idCardNo.value=backString[0][14]; //14
	document.frm.totalPrepay.value=backString[0][17];
	document.frm.totalOwe.value=backString[0][16];
	document.frm.custName.value=backString[0][3];
	var creditI = 0;
	document.frm.expireTime.value=backString[0][22];
		document.frm.asCustPhone.value=backString[0][23];
		
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
			
			if(document.frm.asIdType.options[idI].value==backString[0][24]){
				document.frm.asIdType.options[idI].selected=true;
			}
		}
		document.frm.asIdIccid.value=backString[0][14]; //25
		document.frm.asIdAddress.value=backString[0][11];//26
		document.frm.asContractAddress.value=backString[0][27];
		document.frm.asNotes.value=backString[0][28];
		

	document.frm.qryFlag.value=backString[0][21];
	document.frm.oldCredit.value=backString[0][21];
	document.frm.qryFlagT.value=backString[0][21];
	document.frm.newCredit.value=backString[0][21];
	flag1=1;
	document.frm.handFee.disabled=false;
	document.frm.factPay.disabled=false;
	
	}
}
	
}


alert("document.all.simBell.value=["+document.all.simBell.value+"]");

function submitt(){
	

		document.frm.qry.disabled=true;
		document.frm.phoneNo.disabled=true;
		var myPacket = new AJAXPacket("getUserInfo.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
    	core.ajax.sendPacket(myPacket);
    	myPacket=null;
		
}
function getRemain(){

if(flag1!=1){
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
	if(flag1==1){
		if(document.frm.remark.value.length==0){
			document.frm.remark.value="�û��������޸�";
		}	
		
	if(!forReal(document.frm.handFee)){
			return;
		}
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
			rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFeeT.value);
			return;
}
		
		var creditI = 0;
		var newCredit = "";
	for(creditI = 0 ; creditI < document.frm.qryFlag.length ; creditI ++){
		if(document.frm.qryFlag.options[creditI].selected){
			newCredit = document.frm.qryFlag.options[creditI].value;
			
		}
	}
	var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
			if(document.frm.asIdType.options[idJ].selected==true){
				inputIdType = document.frm.asIdType.options[idJ].value;
			}
		}
	var expireTimeValue = "";
	if(document.frm.chgStatus.value=="N"){
		if(!validDate(document.frm.expireTime)){
		return;
		}
		if(document.frm.nowDate.value>=document.frm.expireTime.value){
		rdShowMessageDialog("��Ч��Ӧ�ô��ڵ�ǰ����");
		return false;
		}
		expireTimeValue=document.frm.expireTime.value+" 00:00:00";
		
	}
		printCommit();
		if(printFlag==1){
			return;
		}
		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("f2308Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"�����ύ�����Ժ�......");
		
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("asIdType",inputIdType);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.userId.value);
		myPacket.data.add("oldCredit",document.frm.qryFlagT.value);
		
		myPacket.data.add("newCredit",document.all.qryFlag.value);
		//myPacket.data.add("newCredit",document.frm.chgStatus.value);
		myPacket.data.add("expireTime",expireTimeValue);
		myPacket.data.add("handFee",document.frm.handFeeT.value);
		myPacket.data.add("factPay",document.frm.handFee.value);

		//myPacket.data.add("ipAdd",document.frm.ipAdd.value);
		myPacket.data.add("chgStatus",document.frm.chgStatus.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());

    	core.ajax.sendPacket(myPacket);

    	myPacket=null;
    	}else{
    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
    	}
}

function getExpireTime(){
if(document.frm.chgStatus.value=="Y"){
	document.frm.qryFlag.disabled=false;
	document.frm.qryFlag.focus();
}else{
	document.frm.qryFlag.disabled=true;
}
if(document.frm.chgStatus.value!="Y"){
	document.frm.expireTime.disabled=false;
	document.frm.timeFlag.value=1;
}else{
	document.frm.expireTime.disabled=true;
	document.frm.timeFlag.value=0;
}

}
function resett(){
	document.frm.asCustName.value="";
	document.frm.asCustPhone.value="";
	document.frm.asIdType.options[0].selected=true;
	document.frm.asIdIccid.value="";
	document.frm.asIdAddress.value="";
	document.frm.asContractAddress.value="";
	document.frm.asNotes.value="";
	document.frm.userId.value="";
	document.frm.runName.value="";
	document.frm.gradeName.value="";
	document.frm.idCardNo.value="";				
	document.frm.totalPrepay.value="";				
	document.frm.totalOwe.value="";
	document.frm.custName.value="";
	
	document.frm.qry.disabled=false;
	document.frm.phoneNo.disabled=false;
	document.frm.submit.disabled=true;
	document.frm.custAddress.value="";
	
	document.frm.cardType.value="";
	printFlag=9;
	timeFlag=0;
	flag1=0;
}


function  modify()
{
    var a = parseInt(document.frm.rightCode.value,10) ;
    var b = parseInt(document.frm.qryFlag.value,10) ;
    if(a == "0" && b > "0")
	{
		rdShowMessageDialog("�Բ�����ֻ���޸ĳɸ�ֵ,�����²�����");
		document.frm.qryFlag.value= "0";
		document.frm.qryFlag.focus();
		return false;
	}
}
</script>
<body>
<FORM action="" method=post name="frm"  onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û��������޸�</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue"> �û����� </td>
		<td colspan="5">
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name="phoneNo" value="<%=phoneNo%>" v_type="mobphone" maxlength=11 index="0" onKeyUp="if(event.keyCode==13)submitt()">
			<input class="b_text" id=Text2 type=button size=17 name=qry value="��ѯ" onclick="submitt()">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">�û�I D</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=userId>
		</td>
		<td  class="blue">��ǰ״̬</td>
		<td> 
			<input class="InputGrey" readOnly type=text size=17 name=runName>
		</td>
		<td class="blue">����</td>
		<td> 
			<input class="InputGrey" readOnly type=text size=17 name=gradeName>
		</td>
	</tr>
	
	<tr> 
		<td class="blue"> ��ǰԤ��</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=totalPrepay >
		</td>
		<td class="blue">��ǰǷ��</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=totalOwe>
		</td>
		<td class="blue">��ͻ���־</td>
		<td> 
			<input class="InputGrey orange" readOnly type=text size=17 name=cardType>
		</td>
	</tr>
	
	<tr> 
		<td class="blue"> �ͻ�����</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=custName>
		</td>
		<td class="blue">��ǰ������</td>
		<td> 
			<input class="button" type=text size=17 name="qryFlag" v_must=1 v_type="int" onBlur="if(this.value!=''){if(checkElement(qryFlag)==false){return false;}};" onchange="modify()" >
		</td>
		<td class="blue">ҵ������</td>
		<td> 
			<input class="InputGrey orange" type=text size=17 name=chgStatusValue value="�������޸�" readonly >
			<input type=hidden name=chgStatus value="Y">
		</td>
	</tr>
	
	 <tr style="display:none"> 
            <td width="10%" style="display='none'"> ���������ƣ�</td>
            <td align=left width="23%" style="display='none'"> 
              <input class=button id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            <td  width="10%" style="display='none'">��������ϵ�绰��</td>
            <td  width="19%" style="display='none'"> 
              <input class=button id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
            </td>
            <td  width="14%"></td>
            <td  width="21%" colspan=5> 
              <input class="button" type=hidden size=17 name=expireTime index="3">
              <input class=button id=Text2 type=hidden size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
      </tr>
      <tr bgcolor="e8e8e8" style="display:none"> 
            <td width="20%" > ������֤�����ͣ�</td>
            <td align=left width="23%" > 
              <select size=1 name=asIdType  >
              <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
              <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
              <%}%>
              </select>
            </td>
            <td  width="20%">֤�����룺</td>
            <td  width="19%"> 
              <input class=button id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
            </td>
            <td  width="24%">֤����ַ��</td>
            <td  width="19%" colspan=2> 
              <input class=button id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr bgcolor="f5f5f5" style="display:none"> 
            <td width="10%" > ������ע��</td>
            <td align=left width="23%" > 
              <input class=button id=Text2a type=text size=30 name=asNotes1  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
         
	<tr style="display:none"> 
		<td class="blue">������</td>
		<td> 
			<input class=button id=Text2 type=text size=17 index="4" name=handFee <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type=float>
		</td>
		<td class="blue">ʵ��</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=factPay index="5" onKeyUp="if(event.keyCode==13){getRemain()}" disabled >&nbsp;
			<input class=button id=Text2 type=button size=17 name=getUseInfo value="-->" onclick="getRemain()">
		</td>
		<td class="blue">����</td>
		<td>
			<input class=button id=Text2 type=text size=17 name=remain disabled >
		</td>
	</tr>
	
	<tr style="display:none">
	<td>�û���ע</td>
	<td>
		<input class=button id=Text3 type=text size=60 name=remark value=""  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');"></td>
	</tr>
	
	<tr> 
		<td class="blue">�û���ע</td>
		<td colspan="5">
			<input class="InputGrey" readOnly id=Text2 type=text size=60 name=asNotes  maxlength=30 index="5" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
		</td>
	</tr>
        
	<TR>
		<TD align="center" id="footer" colspan="6">
			<input class="b_foot" name=submit  index="7" type=button value="ȷ��" onclick="submitCfm()" onKeyUp="if(event.keyCode==13){submitCfm()}">
			&nbsp;&nbsp; 
			<input class="b_foot" name=back  type=button value="���" onclick="resett()">
			&nbsp;&nbsp; 
			<input class="b_foot" name=back  type=button value="�ر�" onclick="removeCurrentTab()">
		</TD>
	</TR>
</table>

<input type=hidden name=opCode value="2308">
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=rightCode value=<%=rightCode%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=sysRemark value="�û��������޸�">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=qryFlagT value="">
<input type=hidden name=newCredit value="">
<input type=hidden name=oldCredit value="">
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=timeFlag value="0">
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>">
<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<%@ include file="/include/remark.htm" %>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>

<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  
   document.all.sysRemark.value="�û�"+document.all.phoneNo.value+"�������޸�";
   if((document.all.asNotes.value).trim().length==0)
   {
	  document.all.asNotes.value="����Ա<%=workName%>"+"���û�"+document.all.phoneNo.value+"�����������޸�"
   }	
	
   //��ʾ��ӡ�Ի��� 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=loginAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="2308" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfn+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
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
	  var retInfo = "";
      note_info2+='<%=workName%>'+"|";
      note_info3+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="�ͻ�������" +document.all.custName.value+"|";
      cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.custAddress.value+"|";
      cust_info+="֤�����룺"+document.all.idCardNo.value+"|";


      opr_info+="ҵ�����ͣ�"+"�û��������޸�"+"|";

	  
      opr_info+="ҵ�����ǰ�����ȣ�"+document.all.oldCredit.value+"|";
	  opr_info+="ҵ�����������ȣ�"+document.all.qryFlag.value+"|";
      opr_info+="��ˮ��"+document.all.loginAccept.value+"|";

      note_info4+=document.all.remark.value+"|";
      
      
      note_info4+=document.all.asNotes.value+" "+document.all.simBell.value+"|"; 
     
    }  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}
</script>
<script>
function printBill(){
	  var infoStr="";  
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.custName.value+"|";
      retInfo+="�ֻ����룺"+document.all.phoneNo.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.custAddress.value+"|";
      retInfo+="�ֽ�"+document.all.handFee.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="�û��������޸ġ�*�����ѣ�"+document.frm.handFee.value+"*��ˮ�ţ�"+document.frm.backLoginAccept.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=document.all.sysRemark.value+"|";
      retInfo+=document.all.remark.value+"|"; 

	location.href="<%=request.getContextPath()%>/page/innet/hljPrint.jsp?retInfo="+infoStr+"&dirtPage=f2308.jsp";  
                  
}
</script>
</BODY></HTML>
