<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-16 ҳ�����,�޸���ʽ
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode = "1449";	
	String opName = "ȫ��ͨǩԼ�ƻ�����";	//header.jsp��Ҫ�Ĳ���  
	String regionCode= (String)session.getAttribute("regCode");

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 

<html>
<head>
<title>ȫ��ͨǩԼ�ƻ�����</title>
<script language=javascript>
<!--
  
	var pwdFlag="false";
	onload=function()
	{
		document.all.phoneno.focus();
	}


//--------3---------��֤��ťר�ú���-------------
 
	function simChk()
	{
		var myPacket = new AJAXPacket("qryCus_back.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
		myPacket.data.add("opCode",document.all.opCode.value.trim());
		myPacket.data.add("backAccept",document.all.backAccept.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;	
	}
 
 

 //--------4---------doProcess����---------------- 
 
  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");

    if(vRetPage == "qryCus_back"){
    	var retCode = packet.data.findValueByName("retCode");      	
    	var retMsg = packet.data.findValueByName("retMsg");
    	
	    var idNo = packet.data.findValueByName("idNo");
		var smCode = packet.data.findValueByName("smCode");
		var smName = packet.data.findValueByName("smName");
		var custName = packet.data.findValueByName("custName");
		var userPassword = packet.data.findValueByName("userPassword");
		var runCode = packet.data.findValueByName("runCode");
		var runName = packet.data.findValueByName("runName");
		var ownerGrade = packet.data.findValueByName("ownerGrade");
		var gradeName = packet.data.findValueByName("gradeName");
		var ownerType = packet.data.findValueByName("ownerType");
		var ownerTypeName = packet.data.findValueByName("ownerTypeName");
		var custAddr = packet.data.findValueByName("custAddr");
		var idType = packet.data.findValueByName("idType");
		var idName = packet.data.findValueByName("idName");
		var idIccid = packet.data.findValueByName("idIccid");
		var card_name = packet.data.findValueByName("card_name");
		var totalOwe = packet.data.findValueByName("totalOwe");
		var totalPrepay = packet.data.findValueByName("totalPrepay");
		var firstOweConNo = packet.data.findValueByName("firstOweConNo");
		var firstOweFee = packet.data.findValueByName("firstOweFee");
		var loginAccept = packet.data.findValueByName("loginAccept");
		var orderCode = packet.data.findValueByName("orderCode");
		var orderName = packet.data.findValueByName("orderName");
		var baseFee = packet.data.findValueByName("baseFee");
		var freeFee = packet.data.findValueByName("freeFee");
		var mon_base_fee = packet.data.findValueByName("mon_base_fee");
		var consume_term = packet.data.findValueByName("consume_term");
		var begin_time = packet.data.findValueByName("begin_time");
		var end_time = packet.data.findValueByName("end_time");
	
		if(retCode=="000000"){
	    
		document.all.idNo.value = idNo;
		document.all.smCode.value = smCode;
		document.all.smName.value = smName;
		document.all.custName.value = custName;
		document.all.userPassword.value = userPassword;
		document.all.runCode.value = runCode;
		document.all.runName.value = runName;
		document.all.ownerGrade.value = ownerGrade;
		document.all.gradeName.value = gradeName;
		document.all.ownerType.value = ownerType;
		document.all.ownerTypeName.value = ownerTypeName;
		document.all.custAddr.value = custAddr;
		document.all.idType.value = idType;
		document.all.idName.value = idName;
		document.all.idIccid.value = idIccid;
		document.all.card_name.value = card_name;
		document.all.totalOwe.value = totalOwe;
		document.all.totalPrepay.value = totalPrepay;
		document.all.firstOweConNo.value = firstOweConNo;
		document.all.firstOweFee.value = firstOweFee;
		document.all.loginAccept.value = loginAccept;
		document.all.orderCode.value = orderCode;
		document.all.orderName.value = orderName;
		document.all.baseFee.value = baseFee;
		document.all.freeFee.value = freeFee;
		document.all.mon_base_fee.value = mon_base_fee;
		document.all.consume_term.value = consume_term;
		document.all.begin_time.value = begin_time;
		document.all.end_time.value = end_time;
		document.all.goodbz.value = packet.data.findValueByName("goodbz"	);
		document.all.modedxpay.value = packet.data.findValueByName("modedxpay"	);

		document.all.confirm.disabled=false;
		
		}else
		{
			rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
			return;
		}
    }       
    
  }

 

	//-------2---------��֤���ύ����-----------------
	
	function printCommit(){	
		getAfterPrompt();
		//У��
		//if(!check(s1449)) return false;		
		//��ӡ�������ύ��
		document.all.remark.value="�û�"  + document.all.phoneno.value + "ȫ��ͨǩԼ�ƻ�����";
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");		
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1){  
			��	s1449.submit();
			}
			
			if(ret=="remark"){
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					s1449.submit();
				}
			}
		}else{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
				s1449.submit();
			}
		}	
		return true;
	}
	
	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  
		//��ʾ��ӡ�Ի��� 		
		var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
		var sysAccept =document.all.loginAccept.value;                       // ��ˮ��
		var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
		var mode_code=null;                        //�ʷѴ���
		var fav_code=null;                         //�ط�����
		var area_code=null;                    //С������
		var opCode =   "<%=opCode%>";                         //��������
		var phoneNo = <%=activePhone%>;                           //�ͻ��绰		
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);    
	
	}

	function printInfo(printType)
	{
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var retInfo = "";  //��ӡ����
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4 
		
		cust_info+="�ͻ�������   " +document.all.custName.value+"|";
		cust_info+="�ֻ����룺   "+document.all.phoneno.value+"|";  
		cust_info+="�ͻ���ַ��   "+document.all.custAddr.value+"|";
		
		opr_info+="ҵ�����ͣ�"+'<%=opName%>'+"|";
		if(document.all.goodbz.value=="Y"){
			opr_info+="��ˮ��"+document.all.loginAccept.value+"       �������ѽ�"+document.all.modedxpay.value+"Ԫ"+"|";
		}else{
			opr_info+="��ˮ��"+document.all.loginAccept.value+"|";
		}
		opr_info+="���µ������ѣ�"+document.all.mon_base_fee.value+"|";
		opr_info+="��������ѣ�"+document.all.baseFee.value+"|";
		opr_info+="�Ԥ�棺"+document.all.freeFee.value+"|";
		opr_info+="ҵ��ִ��ʱ�䣺"+document.all.begin_time.value+"��"+document.all.end_time.value+"|";		
		opr_info+="����ޣ�"+document.all.consume_term.value+"|";
		
		note_info1+=document.all.simBell.value+"��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
		return retInfo;	
	}


	function getRemain(){	
		if(parseFloat(document.s3216.vHandFee.value) < parseFloat(document.s3216.vRealFee.value)){
			rdShowMessageDialog("�����Ѳ��ܴ���"+document.s3216.vHandFee.value);
			return;
		}	
		document.s3216.vPayChange.value=document.s3216.vHandFee.value-document.s3216.vRealFee.value;
	}

	function  modify()
	{
	
		if(document.all.aCurrentPoint.value > document.all.vCurrentPoint.value){
			rdShowMessageDialog("ת�����ֲ��ܴ��ڵ�ǰ����,�����²�����");
			document.all.aCurrentPoint.value = "";
			document.all.aCurrentPoint.focus();
			return;
		}
	
		if(document.all.aCurrentPoint.value == 0 || document.all.aCurrentPoint.value < 0)		
		{
			rdShowMessageDialog("ת�����ֲ���Ϊ�ջ�0��С��0,�����²�����");
			document.all.aCurrentPoint.value = "";
			document.all.aCurrentPoint.focus();
			return;
		}
		if(document.all.t_op_remark.value == 0)		
		{
			document.all.t_op_remark.value = "";
			document.all.t_op_remark.focus();
		}
	
		var t =  parseInt(document.s3216.aCurrentPoint.value,10) ;
		var c= parseInt(document.s3216.pCurrentPoint.value,10)  ;
		
		document.s3216.b.value =  t;
		document.s3216.d.value =  document.s3216.vCurrentPoint.value - document.s3216.aCurrentPoint.value;
		document.s3216.e.value =  t + c;
	}
	function  submitreset()
	{
		s3216.reset();	
		self.location.reload();
		return false;	
	}  
 //-->
</script>

</head>
<body>  
<form action="1449BackCfm.jsp" method="POST" name="s1449"  onKeyUp="chgFocus(s1449)">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">ȫ��ͨǩԼ�ƻ�����</div>
	</div>	
	<input type=hidden name=simBell value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
	<input type=hidden name=worldSimBell value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">
	<input type="hidden" name="opCode" size="16" value="<%=opCode%>" >
	<input type="hidden" name="idNo" value="">
	<input type="hidden" name="smCode" value="">
	<input type="hidden" name="smName" value="">
	<input type="hidden" name="userPassword" value="">
	<input type="hidden" name="runCode" value="">
	<input type="hidden" name="runName" value="">
	<input type="hidden" name="ownerGrade" value="">
	<input type="hidden" name="gradeName" value="">
	<input type="hidden" name="ownerType" value="">
	<input type="hidden" name="custAddr" value="">
	<input type="hidden" name="idType" value="">
	<input type="hidden" name="idName" value="">
	<input type="hidden" name="card_name" value="">
	<input type="hidden" name="totalOwe" value="">
	<input type="hidden" name="firstOweConNo" value="">
	<input type="hidden" name="firstOweFee" value="">
	<input type="hidden" name="ownerTypeName" value="">
	<input type="hidden" name="idIccid" value="">
	<input type="hidden" name="loginAccept" value="">
	<input type="hidden" name="orderName" value="">
	<input type="hidden" name="begin_time" value="">
	<input type="hidden" name="end_time" value="">
	<input type="hidden" name="goodbz" value="">
	<input type="hidden" name="modedxpay" value="">
	
        <table  cellspacing="0">          
		<tr> 
			<td  nowrap width="16%" class="blue"> �û�����</td>
			<td nowrap  > 
				<input  type="text" size="16" name="phoneno"  v_must=1  v_type="mobphone"  maxlength=11  index="6" value =<%=activePhone%>  readonly class="InputGrey">
			</td>
			<td   nowrap width="16%" class="blue">ҵ����ˮ</td>
			<td nowrap >
				<input  type="text" size="16" name="backAccept"  v_must="1" v_type = "0_9"   maxlength=14 onBlur="if(this.value!=''){if(checkElement(document.s1449.backAccept)==false){return false;}}" index="8" >
				<input type="button"  class="b_text" value="��ѯ" onClick="simChk()">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">�û�����</td>
			<td  nowrap  width="28%"> 
				<input  type="text" size="16" name="custName"  index="8" readonly class="InputGrey">
			</td>
			<td  nowrap  width="16%" class="blue">��������</td>
			<td  nowrap  width="40%"> 
				<input type="text"  name="orderCode" size="16" readonly class="InputGrey">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">Ԥ �� ��</td>
			<td  nowrap  width="28%"> 
				<input type="text" name="totalPrepay" size="16" readonly tabindex="0" class="InputGrey">		
			</td>
			<td  nowrap  width="16%" class="blue">����Ԥ��</td>
			<td  nowrap  width="40%"> 
				<input type="text" name="baseFee" size="16" readonly class="InputGrey">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">�Ԥ��</td>
			<td  nowrap  width="28%">  
				<input type="text"  name="freeFee" size="16" readonly class="InputGrey"tabindex="0">
			</td>
			<td  nowrap  width="16%" class="blue">��������</td>
			<td  nowrap  width="40%"> 
				<input type="text"  name="consume_term" size="16" readonly class="InputGrey" tabindex="0">
			</td>
		</tr>
		<tr> 
			<td   nowrap width="16%" class="blue">�� �� ��</td>
			<td  nowrap  width="28%"> 
				<input type="text"  name="mon_base_fee" size="16" readonly class="InputGrey" tabindex="0">
			</td>
			<td  nowrap  width="16%"> 
				&nbsp;			
			</td>
			<td  nowrap  width="40%"> 	
				&nbsp;			
			</td>
		</tr>          
		<tr> 
			<td valign="top" class="blue"> 
				ϵͳ��ע
			</td>
			<td colspan="4" valign="top"> 
				<input type="text" name="remark" id="remark" size="60" readonly class="InputGrey"  maxlength=30>
			</td>
		</tr>
  	</table>
  	
	<table  cellspacing="0">   
		<tr> 			
			<td id="footer"> 
				<input type="button" class="b_foot_long" name="confirm" value="��ӡ&ȷ��" onClick="printCommit()" index="26" disabled >
				<input type=reset class="b_foot" name=back value="���" onClick="document.all.confirm.disabled=true;" >
				<input type="button" class="b_foot" name="b_back" value="�ر�" onClick="removeCurrentTab();" index="28">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
