<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	//ȡsession��Ϣ
	ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String activePhone1=request.getParameter("activePhone1");
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	
	
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");	
	String org_codeT = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String region_codeT = WtcUtil.repNull((String)session.getAttribute("regCode"));

  //ȡ֤�����͡�֤������
  String[] inParamsss01 = new String[1];
	inParamsss01[0] = "select id_type,id_name from sidtype";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode01ss" retmsg="retMsg01ss" outnum="2">			
	<wtc:param value="<%=inParamsss01[0]%>"/>	
	</wtc:service>	
  <wtc:array id="sIdTypeStr" scope="end" />

<%
//ȡ���ι��Ҵ��롢�������ƺͺ����趨��
  String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select hand_fee, favour_code from sNewFunctionFee where region_code =:reg_scode and function_code = '1223'";
	inParamsss1[1] = "reg_scode="+region_codeT;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="2">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="fee" scope="end" />
<%

String tHandFee = "0";
int feeFlag = 0;

//�ж��Ƿ��б���Ż�������Ȩ��
if(fee.length==0){
	tHandFee="0";
	feeFlag = 0;
}
else{
	tHandFee=fee[0][0];
	for(int i = 0 ; i < favInfo.length ; i ++){
		if(favInfo[i][0].trim().equals(fee[0][1])){
			feeFlag = 1;
		}
	}
}

//ȡ���ι��Ҵ��롢�������ƺͺ����趨��
  String[] inParamsss2 = new String[1];
	inParamsss2[0] = "select country_code, country_name, phone_fee from scountrycode";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode2ss" retmsg="retMsg2ss" outnum="3">			
	<wtc:param value="<%=inParamsss2[0]%>"/>	
	</wtc:service>	
  <wtc:array id="country" scope="end" />
<%
//ȡ������η�ʽ������
  String[] inParamsss3 = new String[1];
	inParamsss3[0] = "SELECT rent_type,rent_name FROM sRentTypeName order by rent_type";
 %>
 	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="2">			
	<wtc:param value="<%=inParamsss3[0]%>"/>	
	</wtc:service>	
  <wtc:array id="roamTypeArr" scope="end" />
<%
//��ȡ���ʽ���롢���ʽ���ƺ͵�λ���
  String[] inParamsss4 = new String[1];
	inParamsss4[0] = "select distinct rent_code,rent_name,rent_fee from srentcode";
 %>
 	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" retcode="retCode4ss" retmsg="retMsg4ss" outnum="3">			
	<wtc:param value="<%=inParamsss4[0]%>"/>	
	</wtc:service>	
  <wtc:array id="rentTypeArr" scope="end" />
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=region_codeT%>"  id="printAccept" />
<HTML><HEAD>
<TITLE>�����������</TITLE><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
var printFlag=9;
var flag = 0;

onload=function(){
	//document.all.phoneNo.focus();

}

function doProcess(packet){	
	var backString = packet.data.findValueByName("backString");	
	var cfmFlag = packet.data.findValueByName("flag");
	
	
	if(cfmFlag==9){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		//rdShowMessageDialog(errCode + " : " + errMsg);
		rdShowMessageDialog("������룺" + errCode + "��������Ϣ��" + errMsg,0);
		
		//document.frm.phoneNo.value="";
		document.frm.qry.disabled=false;
		// document.frm.phoneNo.disabled=false;
		
		flag=0;
		return;
	}
	
	if(cfmFlag==1){
			flag=0;
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");		
			var errCodeInt = parseInt(errCode,10);

			if(errCodeInt==0){
				rdShowMessageDialog("�����ɹ���",2);
				document.frm.backLoginAccept.value=backString[0][0];
							
				if(document.frm.handFee.value!=0){
					printBill();
				}                        	
				else
				{
					window.location="f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}else
			{				
				rdShowMessageDialog(errCode + " : " + errMsg);
				window.location="f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
				return;
			}							
	}
	
	if(cfmFlag==0){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");	  		
			var moreString = packet.data.findValueByName("moreString");
			var errCodeInt = parseInt(errCode,10);
			
			if(errCodeInt!=0){				
				rdShowMessageDialog(errCode + " : " + errMsg);
				//document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				//document.frm.phoneNo.disabled=false;
				
				flag=0;
				return;
			}
			else{

				document.frm.cust_password.value=backString[0][4];
				document.frm.id_no.value=backString[0][0];
				document.frm.run_code.value=backString[0][6];
				document.frm.cust_grade.value=backString[0][8];				
				document.frm.prepay_fee.value=backString[0][17];				
				document.frm.owe_fee.value=backString[0][16];
				document.frm.cardType.value=backString[0][15];
				document.frm.cust_name.value=backString[0][3];
				document.frm.custAddress.value=backString[0][11];
				document.frm.rent_cost.value=moreString[0][19];
				document.frm.getRentTime.value=moreString[0][4];				
				document.frm.preBackTime.value=moreString[0][5];
				document.frm.preBackTimeT.value=moreString[0][5];
				document.frm.begin_time.value=moreString[0][6];
				document.frm.end_time.value=moreString[0][7];
				document.frm.end_timeT.value=moreString[0][7];
				document.frm.mobile_serial.value=moreString[0][9];
				document.frm.mobile_type.value=moreString[0][8];						
				
				document.frm.asCustName.value=moreString[0][21];
				document.frm.asCustPhone.value=moreString[0][22];
				document.frm.asIdIccid.value=moreString[0][24];
				document.frm.asIdAddress.value=moreString[0][25];
				document.frm.asContractAddress.value=moreString[0][26];
				document.frm.asNotes.value=moreString[0][27];							
				
				document.frm.machine_num.value=moreString[0][10];
				document.frm.perMachine_rent.value=moreString[0][11];
				document.frm.battery_num.value=moreString[0][12];
				document.frm.perBattery_rent.value=moreString[0][13];
				document.frm.charger_num.value=moreString[0][14];
				document.frm.perCharger_rent.value=moreString[0][15];
				document.frm.addition_fee.value=moreString[0][23];					
				document.frm.travelName.value=moreString[0][3];
				document.frm.visaName.value=moreString[0][20];	
				document.frm.accountBook.value=moreString[0][16];	
				document.frm.otherComponent.value=moreString[0][17];
				document.frm.rent_phone.value=moreString[0][2];
				document.frm.machine_rent.value=document.frm.machine_num.value*document.frm.perMachine_rent.value;
				document.frm.battery_rent.value=document.frm.battery_num.value*document.frm.perBattery_rent.value;
				document.frm.charger_rent.value=document.frm.charger_num.value*document.frm.perCharger_rent.value;
				document.frm.all_rent.value=parseFloat(document.frm.charger_rent.value)+parseFloat(document.frm.battery_rent.value)+parseFloat(document.frm.machine_rent.value)+parseFloat(document.frm.addition_fee.value);
			
				//������֤������
				var idI = 0 ;
				for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){			
					if(document.frm.asIdType.options[idI].value==moreString[0][26]){
						document.frm.asIdType.options[idI].selected=true;
						break;
					}
				}
							
				//���ι��Ҵ���
				var i = 0 ;
				for(i = 0 ; i < document.frm.country_code.length ; i ++){
					var countryValue = document.frm.country_code.options[i].value;
					var divFlag = countryValue.indexOf("|",0);
					var fCountryCode = countryValue.substring(0,divFlag);
					var fPhoneFee = countryValue.substring(divFlag+1,countryValue.length);
					if(fCountryCode==moreString[0][0]){
						document.frm.country_code.options[i].selected=true;
						document.frm.setNo_cost.value=fPhoneFee;
						break;
					}
				}
				
				//���������
				var j = 0 ;
		  		for(j = 0 ; j < document.frm.custtype.length ; j ++){
		  			if(document.frm.custtype.options[j].value==moreString[0][1]){
		  				document.frm.custtype.options[j].selected=true;
		  				break;
		  			}
		  		}
		  		
		  		//�������
		  		document.frm.rent_type.disabled=true;
				var k = 0 ;
				for(k = 0 ; k < document.frm.rent_type.length ; k ++){
					var rentValue = document.frm.rent_type.options[k].value;
					var divFlag = rentValue.indexOf("|",0);
					var fRentCode = rentValue.substring(0,divFlag);
					var fRentFee = rentValue.substring(divFlag+1,rentValue.length);							
					
					if(fRentCode==moreString[0][18]){
						document.frm.rent_type.options[k].selected=true;
						document.frm.rent_cost.value=fRentFee;
						break;
					}
				}

				//���η�ʽ
				var l = 0;
				for(l = 0 ; l < document.frm.roam_type.length ; l ++){
					if(moreString[0][22]==document.frm.roam_type.options[l].value){
						document.frm.roam_type.options[l].selected=true;
						break;
					}
				}
								
				//������ȡ����־
				var m = 0;
				for(m = 0 ; m < document.frm.travelFlag.length ; m ++){
					if(moreString[0][21]==document.frm.travelFlag.options[m].value){
						document.frm.travelFlag.options[m].selected=true;
						break;
					}
				}
							  	
				flag=1;
				return;
			}
	}
}

//���ݷ��������ȡ�����Ϣ
function submitt(){

      
      if(!checkElement(document.frm.phoneNo)){
	    return;
      }
      
	document.frm.qry.disabled=true;
	document.frm.phoneNo.disabled=true;
	

	var myPacket = new AJAXPacket("getUserInfo.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("workNo",document.frm.workNo.value);
	myPacket.data.add("phoneNo",document.frm.phoneNo.value);
	myPacket.data.add("opCode",document.frm.opCode.value);
	myPacket.data.add("orgCode",document.frm.orgCode.value);
			core.ajax.sendPacket(myPacket);
			myPacket = null;		
}

//���������
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

//ȷ�ϴ���
function submitCfm(){
	if(flag==1){
		document.frm.systemNote.value="����"+document.frm.phoneNo.value+"����������,������:"+document.frm.handFee.value;
		if(document.frm.opNote.value.length==0){
			document.frm.opNote.value=document.frm.phoneNo.value+"��������������,���κ���Ϊ"+document.frm.rent_phone.value;
		}
			
		if(validTotalDate(document.frm.end_time)==false){
			return;
		}
		if(validTotalDate(document.frm.preBackTime)==false){
			return;
		}
		var fDate = to_date(document.frm.end_timeT);
		var bDate = to_date(document.frm.end_time);
		if(bDate<=fDate){
			rdShowMessageDialog("����ҵ��ر�ʱ��Ӧ�ó��ڳ�ʼҵ��ر�ʱ��");
			return;
		}
		var fDate1 = to_date(document.frm.preBackTimeT);
		var bDate1 = to_date(document.frm.preBackTime);
		if(bDate1<=fDate1){
			rdShowMessageDialog("���⻹��ʱ��Ӧ�ó��ڳ�ʼ����ʱ��");
			return;
		}		
						

		if(!forFloat(document.frm.handFee)){
			return;
		}

		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
			rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFeeT.value);
			return;
		}
		
		printCommit();
		if(printFlag!=1){
			return;
		}
		
		//document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("f1223Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&systemNote="+document.frm.systemNote.value+"&opNote="+document.frm.opNote.value,"�����ύ�����Ժ�......");
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("asIdType",document.frm.asIdType.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.id_no.value);
		myPacket.data.add("returnTime",document.frm.preBackTime.value);
		myPacket.data.add("closeTime",document.frm.end_time.value);
		myPacket.data.add("chandFee",document.frm.handFeeT.value);
		myPacket.data.add("handFee",document.frm.handFee.value);		
		myPacket.data.add("ipAddr",document.frm.ipAdd.value);
			core.ajax.sendPacket(myPacket);
			myPacket = null;	
    	}
    	else
    	{
    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
    	}
}

//������֤
function verifyPass(){
	if(flag==1){
		var m = document.frm.inputPass.value;
		var n = document.frm.cust_password.value;
        	
		var myPacket = new AJAXPacket("verifyPass.jsp","�����ύ�����Ժ�......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
				
			core.ajax.sendPacket(myPacket);
			myPacket = null;
		
	}
	else
	{
    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
	}
}

</script>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<FORM action="" method=post name="frm" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>  
<div class="title">

	<div id="title_zi">�û���Ϣ</div>

</div>			
   
       <table cellspacing=0>

       
              <tr > 
            <td  class="blue">�������</td>
            <td colspan="5"> 
              <input class=InputGrey readOnly
            id=Text2 type=text size=13 name=phoneNo  index="0" v_type="mobphone" value=<%=activePhone1%> v_name="�ƶ�����" maxlength=11 onKeyUp="if(event.keyCode==13)submitt()">
            <input class=b_text type=button name=qry value="��ѯ" onclick=submitt()>
            </td>
             
           
          </tr>
          <tr > 
            <td class="blue">�û�I D </td>
            <td > 
              <input class=button type="text" name="id_no" disabled >            </td>
            <td class="blue">��ǰ״̬</td>
            <td > 
              <input class=button type="text" name="run_code" disabled >            </td>
            <td  class="blue">���� </td>
            <td  > 
              <input class=button type="text" name="cust_grade" disabled >            </td>
          </tr>
          <tr > 
            <td   class="blue">��ǰԤ�� </td>
            <td  > 
              <input class=button type="text" name="prepay_fee" disabled >
            </td>
            <td   class="blue">��ǰǷ�� </td>
            <td  > 
              <input class=button type="text" name="owe_fee" disabled >
            </td>
            <td   class="blue">��ͻ���־</td>
            <td  > 
              <input class="text_redFat" type=text size=17 name=cardType readonly >
            </td>
          </tr>
          <tr > 
            <td class="blue">�ͻ����� </td>
            <td  > 
              <input class=button type="text" name="cust_name" disabled >            </td>
            <td colspan="2"  >&nbsp;</td>
            <td colspan="2" >&nbsp;</td>
          </tr>

        </table>
	</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
	  
        <TABLE  cellSpacing=0 >

          <tr > 
            <td  class="blue">���ι��� </td>
            <td > 
              <select name="country_code" onchange="getPhoneFee()" disabled >
			  	<option value="">���ѯ</option>
                <%for(int i = 0 ; i < country.length ; i ++){%>
                <option value="<%=country[i][0]%>|<%=country[i][2]%>"><%=country[i][1]%></option>
                <%}%>
              </select>
            </td>
            <td  colspan="2" class="blue">��������� </td>
            <td  colspan="3"> 
              <select name="custtype" disabled >
                <option value="0">����</option>
                <option value="1">��λ</option>
                <option value="2">ί��</option>
              </select>
            </td>
          </tr>
          <tr > 
            <td  class="blue">���η�ʽ </td>
            <td  > 
              <select name="roam_type" disabled index="3">
			  <option value="">���ѯ</option>
                <%for(int i = 0 ; i < roamTypeArr.length ; i ++){%>
                <option value="<%=roamTypeArr[i][0]%>"><%=roamTypeArr[i][1]%></option>
                <%}%>
              </select>            </td>
            <td colspan="2" class="blue">���κ��� </td>
            <td colspan="3" > 
              <div id=rentPhoneDiv> 
                <input class=button name="rent_phone" type=text disabled >
              </div>            </td>
          </tr>
          <tr  id=travelDiv style="display=''"> 
            <td  class="blue">������ȡ����־ </td>
            <td > 
            <select name=travelFlag disabled >
            <option value=0>��</option>            
            <option value=1>��</option>
            </select>            </td>
            <td colspan="2" class="blue">���������� </td>
            <td colspan="3" > 
              <input class=button type="text" name="travelName" value="����Ϣ" disabled index="7" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">            </td>
          </tr>
          <tr  style="display=''"> 
            <td class="blue">���պ��룺 </td>
            <td  colspan="6" > 
              <input class=button type="text" name="visaName" index="7" disabled onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">            </td>
          </tr> 
          <tr > 
            <td class="blue">ȡ��ʱ�� </td>
            <td > 
              <input class=button type="text" name="getRentTime" disabled >
            </td>
            <td  colspan="2" class="blue">Ԥ�ƻ���ʱ�� </td>
            <td  colspan="3"> 
              <input class=button type="text" name="preBackTime" disabled>
            </td>
          </tr>
          <tr > 
            <td  class="blue">ҵ��ͨʱ�� </td>
            <td  > 
              <input class=button type="text" name="begin_time" disabled >            </td>
            <td colspan="2" class="blue">ҵ��ر�ʱ�� </td>
            <td colspan="3" > 
              <input class=button type="text" name="end_time" disabled>            </td>
          </tr>
          <tr > 
            <td  class="blue">�ƶ��绰���к� </td>
            <td > 
              <input class=button type="text" name="mobile_serial" value="" disabled >
            </td>
            <td  colspan="2" class="blue">�ƶ��绰�ͺ� </td>
            <td  colspan="3"> 
              <input class=button type="text" name="mobile_type" value="" disabled >
            </td>
          </tr>
          <tr > 
            <td  class="blue">�������� </td>
            <td  > 
              <input class=button type="text" name="machine_num" disabled >            </td>
            <td class="blue">����Ѻ��/��λ </td>
            <td  > 
              <input class=button type="text" name="perMachine_rent" value="" disabled >            </td>
            <td  class="blue">�ܼ�
            </td>
            <td  > 
              <input class=button type="text" name="machine_rent" disabled >            </td>
          </tr>
          <tr > 
            <td  class="blue">������� </td>
            <td > 
              <input class=button type="text" name="battery_num" disabled >
            </td>
            <td  colspan="2" class="blue">���Ѻ��/��λ </td>
            <td > 
              <input class=button type="text" name="perBattery_rent" value="" disabled >
            </td>
            <td  nowrap class="blue">�ܼ� 
            </td>
            <td align=left> 
              <input class=button type="text" name="battery_rent" disabled >
            </td>
          </tr>
          <tr > 
            <td  class="blue">��������� </td>
            <td  > 
              <input class=button type="text" name="charger_num" disabled >            </td>
            <td colspan="2"  nowrap class="blue">�����Ѻ��/��λ </td>
            <td > 
              <input class=button type="text" name="perCharger_rent" value="" disabled >            </td>
            <td  nowrap class="blue">�ܼ�
            </td>
            <td>
              <input class=button type="text" name="charger_rent" disabled >            </td>
          </tr>
          <tr > 
            <td  class="blue">˵�������� </td>
            <td  > 
              <input class=button type="text" name="accountBook" disabled >            </td>
            <td  colspan="2"  nowrap class="blue">�������ø��� </td>
            <td  align=left> 
              <input class=button type="text" name="otherComponent" disabled >            </td>
            <td   class="blue">�ܼ�
            </td>          
            <td >
              <input class=button type="text" name="addition_fee" disabled >            </td>             
          </tr>
		  <tr style="display:none">
          <td   nowrap class="blue"> ����������</td>
            <td  > 
              <input class=button 
            id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
           
            <td   colspan="2" nowrap class="blue">��������ϵ�绰</td>
            <td  > 
              
              <input class=button 
            id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
            
            </td>
                 
            <td   class="blue">��ϵ��ַ</td>
            <td   colspan=2> 
              
              <input class=button 
            id=Text2 type=text size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            
            </td>
          </tr>
          <tr  style="display:none"> 
            
            <td  nowrap class="blue"> ������֤������</td>
            <td  > 
              <select size=1 name=asIdType  >
              <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
              <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
              <%}%>
              </select>
            </td>
            
            
            <td  colspan="2" nowrap class="blue">֤������</td>
            <td  > 
              
              <input class=button 
            id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
            
            </td>
           
            <td   nowrap class="blue">֤����ַ</td>
            <td  colspan=2> 
              
              <input class=button 
            id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            
            </td>
          </tr>
          
          <tr style="display:none"> 
            
            <td  class="blue"> ������ע</td>
            <td  > 
              <input class=button 
            id=Text2a type=text size=30 name=asNotes  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>

          </tr>
          <tr > 
            <td class="blue">�����趨�� </td>
            <td  > 
              <input class=button type="text" name="setNo_cost" value="<%=country[0][2]%>" disabled >            </td>
            <td colspan="2"  class="blue">Ѻ��ϼ�
            </td>
            <td colspan="3"  > 
              <input class=button type="text" name="all_rent" value=0 disabled >            </td>            
          </tr>
          <tr > 
            <td class="blue">�������� </td>
            <td > 
              <select name="rent_type"  disabled >
			  	<option value="">--���ѯ--</option>
                <%for(int i = 0 ; i < rentTypeArr.length ; i ++){%>
                <option value="<%=rentTypeArr[i][0]%>|<%=rentTypeArr[i][2]%>"><%=rentTypeArr[i][1]%></option>
                <%}%>
              </select>
            </td>
            <td align=left colspan="2" class="blue">��λ���</td>
            <td align=left colspan="3"> 
              <input class=button type="text" name="rent_cost"  value="<%=rentTypeArr[0][2]%>" disabled >
            </td>
          </tr>
          <tr style="display:none" > 
            <td  class="blue">������ </td>
            <td > 
              <input class=button type="text" index="4" name="handFee" <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type=float v_name="������">
            </td>
            <td  class="blue">ʵ��</td>
            <td > 
              <input class=button type="text" index="5" onKeyUp="if(event.keyCode==13){getRemain()}" name="factPay" size=6>
              
            </td>
            <td ><input class=button 
            id=Text2 type=button size=17 name=getUseInfo value="-->" onClick="getRemain()">&nbsp;����
              <input class=button type="text" name="remain" size=6>
            </td>
            <td  colspan="3">&nbsp;</td>
          </tr>
           <tr style="display:none"> 
            <td colspan="7" class="blue">ϵͳ��ע 
              <input class=button type="text" name="systemNote" size="60" index="23" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
		  <tr style="display:none" > 
		   <td  colspan="7" class="blue">������ע<input class=button 
            id=Text2 type=text size=60 name=opNote  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
			</tr>
		
          <TR id="footer">

        <TD colspan=6>

          
            <input class="b_foot" name=cancel  type=button value=��� id=Button2 onClick="window.location='f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>'">

            <input class="b_foot" name=back13  type=button value=�ر� id=Button2 onClick="removeCurrentTab()">

        </TD>

    </TR>
  
  </table>
  <hr size=1 width="100%">
<input type=hidden name=workNo value=<%=loginNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=loginAccept value="0">
<input type=hidden name=opCode value="<%=opCode%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=fRentCode value=<%=rentTypeArr[0][0]%>>
<input type=hidden name=fCountryCode value="<%=country[0][0]%>">
<input type=hidden name=fCustTypeValue value="">
<input type=hidden name=fRoamTypeValue value="">
<input type=hidden name=fRentPhoneValue value="">
<input type=hidden name=cust_password value="">
<input type=hidden name=preBackTimeT value="">
<input type=hidden name=end_timeT value="">
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<%@ include file="../../include/remark.htm" %>

<%@ include file="/npage/include/footer.jsp" %>


</FORM>

<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);
/*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfn=" + submitCfn;
     var ret=window.showModalDialog(path,"",prop);
   */  
       var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             	//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							  //�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		  //С������
	var opCode="<%=opCode%>" ;                   			 	//��������
	var phoneNo=document.all.phoneNo.value;        //�ͻ��绰
	
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);

	ret="confirm";
   if(typeof(ret)!="undefined")
   {
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {
       if(rdShowConfirmDialog('ȷ��Ҫ���д����������')==1)
       {
       	printFlag=1;
       }
     }
   }
}




function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {
    	var cust_info="";  				//�ͻ���Ϣ
		var opr_info="";   				//������Ϣ
		var note_info1=""; 				//��ע1
		var note_info2=""; 				//��ע2
		var note_info3=""; 				//��ע3
		var note_info4=""; 				//��ע4
		 retInfo = "";  				//��ӡ����
  

//	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
//	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.custAddress.value+"|";
	cust_info+="֤�����룺"+document.all.idCardNo.value+"|";

		opr_info+="ҵ�����ͣ�"+"�����������"+"|";
	opr_info+="�����ѣ�"+document.frm.handFee.value+"|";
	opr_info+="��ˮ��"+document.frm.backLoginAccept.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	note_info1+=document.all.systemNote.value+"|";
	note_info1+=document.all.opNote.value+"|";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	

    }  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
    }
    return retInfo;	
}
</script>
<script>
function printBill(){
	 var infoStr="";
	 var phondes=document.frm.phoneNo.value;
   var loginaccd =document.frm.backLoginAccept.value;
     
     			var infoStr="";
			 infoStr+='<%=loginNo%>'+"  "+document.frm.backLoginAccept.value+"  "+"�����������"+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+=document.frm.cust_name.value+"|";//�û�����
			infoStr+=""+"|";//��ͬ����
			infoStr+=document.frm.phoneNo.value+"|";//�ƶ�����
			infoStr+="document.frm.handFee.value"+"|";
			infoStr+="����������⡣�����ѣ�"+document.frm.handFee.value+"|";
			
			infoStr+="��ע��"+"�û� "+document.frm.phoneNo.value+" ��ӡ��Ʊ"+"|";
			infoStr+=" "+"|";//Сд 
			infoStr+=" "+"|";//�տ���  
			infoStr+="<%=loginName%>"+"|";//��Ʊ��
			location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept="+loginaccd+"&dirtPage=<%=request.getContextPath()%>/npage/s1226/f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";              
}
</script>
</BODY></HTML>