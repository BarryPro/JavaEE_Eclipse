<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-26
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>

<%
    String opCode = "1224";
    String opName = "��������������";
%>
<%
        //ȡ֤�����͡�֤������
        //SPubCallSvrImpl impl=new SPubCallSvrImpl();
    String sql = "select id_type,id_name from sidtype";
        //ArrayList sIdTypeArr = impl.sPubSelect("2",sql);
        //String[][] sIdTypeStr = (String[][])sIdTypeArr.get(0);
%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>"  outnum="2">
        <wtc:sql><%=sql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="sIdTypeStr" scope="end"/>
<%
    //ȡsession��Ϣ
        //ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String nopass = (String)session.getAttribute("password");
        //String[][] baseInfo = (String[][])arr1.get(0);
        //String[][] info = (String[][])arr1.get(2);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");


%>

<%
    String org_codeT = (String)session.getAttribute("orgCode");
    String region_codeT = org_codeT.substring(0,2);
        /*
        System.out.println("region_codeT="+region_codeT);
        ArrayList arr = F1224Wrapper.getFuncFee(region_codeT);
        
        String[][] fee = (String[][])arr.get(0);
        */
    
    String sqlHandFee = "select to_char(hand_fee), favour_code from sNewFunctionFee where region_code = :regionCode and function_code = '1223'";
        //ArrayList arr = impl.sPubSelect("2",sqlHandFee);
    
    String [] paraIn = new String[2];
    paraIn[0] = sqlHandFee;    
    paraIn[1]="regionCode="+region_codeT;
%>
    <wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=region_codeT%>" outnum="2" >
        <wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="fee" scope="end"/>
<%

        //String[][] fee = (String[][])arr.get(0);
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
        //ArrayList countryArr = F1222Wrapper.getCountryFee(region_codeT);
        //StringBuffer sq12 = new StringBuffer();
        //    sq12.append("select country_code,country_name,phone_fee from scountrycode");
    String sql2 = "select country_code,country_name,to_char(phone_fee) from scountrycode";
        //ArrayList countryArr = impl.sPubSelect("3",sq12.toString());
%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" outnum="3">
    	<wtc:sql><%=sql2%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="country" scope="end" />
<%
        //String[][] country = (String[][])countryArr.get(0);
    
    //ȡ������η�ʽ������
        //ArrayList roamTypeArrList = F1222Wrapper.getRoamType(region_codeT);
        		//sq12 = new StringBuffer();
                //sq12.append("SELECT rent_type,rent_name");
                //sq12.append(" FROM sRentTypeName");
                //sq12.append(" order by rent_type");
    sql2 = "select rent_type,rent_name from sRentTypeName order by rent_type";
        //ArrayList roamTypeArrList = impl.sPubSelect("2",sq12.toString());
%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" outnum="2">
    	<wtc:sql><%=sql2%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="roamTypeArr" scope="end" />
<%
        //String[][] roamTypeArr = (String[][])roamTypeArrList.get(0);
    
    //��ȡ���ʽ���롢���ʽ���ƺ͵�λ���
        //ArrayList rentTypeArrList = F1222Wrapper.getRentFee(region_codeT);
        	//sq12 = new StringBuffer();
            //sq12.append("select distinct rent_code,rent_name,rent_fee");
            //sq12.append("  from srentcode order by rent_code");
    sql2 = "select distinct rent_code,rent_name,to_char(rent_fee) from srentcode order by rent_code";
        //ArrayList rentTypeArrList = impl.sPubSelect("3",sq12.toString());
%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" outnum="3">
    	<wtc:sql><%=sql2%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="rentTypeArr" scope="end" />
<%
        //String[][] rentTypeArr = (String[][])rentTypeArrList.get(0);

%>
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_codeT%>"  id="seq"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>��������������</TITLE>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
var printFlag=9;
var flag = 0;
    //core.loadUnit("debug");
    //core.loadUnit("rpccore");
onload=function(){
	self.status="";
	document.all.loginAccept.focus();
	    //core.rpc.onreceive = doProcess;
}

function doProcess(packet){	
	var backString = packet.data.findValueByName("backString");	
	var cfmFlag = packet.data.findValueByName("flag");
	
	if(cfmFlag==1){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");

		var errCodeInt = parseInt(errCode,10);

		if(errCodeInt==0){
			rdShowMessageDialog("�����ɹ���",2);				
			document.frm.backLoginAccept.value=backString[0][0];
						
			if(document.frm.handFee.value!=0){
				printBill();
			}
			else{
				window.location="f1224.jsp?activePhone=<%=activePhone%>";
			}														
		}
		else{				
			rdShowMessageDialog(errCode + " : " + errMsg,0);
			window.location="f1224.jsp?activePhone=<%=activePhone%>";
			return;
		}							
	}
	
	if(cfmFlag==9){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");	  		
		rdShowMessageDialog(errCode + " : " + errMsg,0);
		document.frm.loginAccept.value="";
		document.frm.qry.disabled=false;
		document.frm.loginAccept.disabled=false;
		
		flag=0;
		return;
	}
	
	if(cfmFlag==0){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");	  		
		var moreString = packet.data.findValueByName("moreString");
		var errCodeInt = parseInt(errCode,10);
	
    	if(errCodeInt!=0){				
			rdShowMessageDialog(errCode + " : " + errMsg,0);
			document.frm.loginAccept.value="";
			document.frm.qry.disabled=false;
			document.frm.loginAccept.disabled=false;
			
			flag=0;
			return;
    	}
		if(errCodeInt==0){
			document.frm.cust_password.value=backString[0][4];
			document.frm.id_no.value=backString[0][0];
			document.frm.run_code.value=backString[0][6];
			document.frm.cust_grade.value=backString[0][8];
			document.frm.prepay_fee.value=backString[0][17];				
			document.frm.owe_fee.value=backString[0][16];
			document.frm.cust_name.value=backString[0][3];
			document.frm.custAddress.value=backString[0][11];
			document.frm.idCardNo.value=backString[0][14];
			document.frm.cardType.value=backString[0][15];
			document.frm.getRentTime.value=moreString[0][4];				
			document.frm.preBackTime.value=moreString[0][5];
			document.frm.begin_time.value=moreString[0][6];
			document.frm.end_time.value=moreString[0][7];
			document.frm.mobile_serial.value=moreString[0][9];
			document.frm.mobile_type.value=moreString[0][8];						
			
			document.frm.asCustName.value=moreString[0][24];
			document.frm.asCustPhone.value=moreString[0][25];							
			document.frm.asIdIccid.value=moreString[0][27];
			document.frm.asIdAddress.value=moreString[0][28];
			document.frm.asContractAddress.value=moreString[0][29];
			document.frm.asNotes.value=moreString[0][30];
										
			document.frm.machine_num.value=moreString[0][10];
			document.frm.perMachine_rent.value=moreString[0][11];
			document.frm.battery_num.value=moreString[0][12];
			document.frm.perBattery_rent.value=moreString[0][13];
			document.frm.charger_num.value=moreString[0][14];
			document.frm.perCharger_rent.value=moreString[0][15];
			document.frm.addition_fee.value=moreString[0][23];					
			/* ningtn 2010-11-2 10:11:41
			document.frm.travelName.value=moreString[0][3];
			document.frm.visaName.value=moreString[0][20];	
			*/
			document.frm.accountBook.value=moreString[0][16];	
			document.frm.otherComponent.value=moreString[0][17];
			/* ningtn 2010-11-2 10:05:48
			document.frm.rent_phone.value=moreString[0][2];
			*/
			document.frm.machine_rent.value=document.frm.machine_num.value*document.frm.perMachine_rent.value;
			document.frm.battery_rent.value=document.frm.battery_num.value*document.frm.perBattery_rent.value;
			document.frm.charger_rent.value=document.frm.charger_num.value*document.frm.perCharger_rent.value;
			document.frm.all_rent.value=parseFloat(document.frm.charger_rent.value)+parseFloat(document.frm.battery_rent.value)+parseFloat(document.frm.machine_rent.value)+parseFloat(document.frm.addition_fee.value);
				
			//������֤������
			var i = 0 ;
			for(i = 0 ; i < document.frm.asIdType.length ; i ++){			
				if(document.frm.asIdType.options[i].value==moreString[0][26]){
					document.frm.asIdType.options[i].selected=true;
					break;
				}
			}
							
			//���ι��Ҵ���
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
		  	for(i = 0 ; i < document.frm.custtype.length ; i ++){
		  		if(document.frm.custtype.options[i].value==moreString[0][1]){
		  			document.frm.custtype.options[i].selected=true;
		  			break;
		  		}
		  	}
		  	
		  	//�������
		  	document.frm.rent_type.disabled=true;
			for(i = 0 ; i < document.frm.rent_type.length ; i ++){
				var rentValue = document.frm.rent_type.options[i].value;
				var divFlag = rentValue.indexOf("|",0);
				var fRentCode = rentValue.substring(0,divFlag);
				var fRentFee = rentValue.substring(divFlag+1,rentValue.length);							
				
				if(fRentCode==moreString[0][18]){
					document.frm.rent_type.options[i].selected=true;
					document.frm.rent_cost.value=fRentFee;
					break;
				}
			}

			//���η�ʽ
			for(i = 0 ; i < document.frm.roam_type.length ; i ++){
				if(moreString[0][22]==document.frm.roam_type.options[i].value){
					document.frm.roam_type.options[i].selected=true;
					break;
				}
			}
							
			//������ȡ����־
			/* ningtn 2010-11-2 10:09:41
			for(i = 0 ; i < document.frm.travelFlag.length ; i ++){
				if(moreString[0][21]==document.frm.travelFlag.options[i].value){
					document.frm.travelFlag.options[i].selected=true;
					break;
				}
			}
			*/
			flag=1;
			document.frm.submit.disabled=false;
		}	
	}
}

//���ݺ�����ȡ��������Ϣ
function f1224Init(){
      if(document.frm.loginAccept.value==""){
      	rdShowMessageDialog("�����������ˮ���룡");
      	return;
      }
      
      if(!forNonNegInt(document.frm.loginAccept)){
		return;
	}
		
	document.frm.qry.disabled=true;
	document.frm.loginAccept.readOnly=true;

	var myPacket = new AJAXPacket("getUserInfo.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("workNo",document.frm.workNo.value);
	myPacket.data.add("phoneNo",document.frm.phoneNo.value);
	myPacket.data.add("opCode",document.frm.opCode.value);
	myPacket.data.add("orgCode",document.frm.orgCode.value);
		
	core.ajax.sendPacket(myPacket);

	myPacket = null;
}

//����ַ�Ӧ�˽��
function getRemain(){
	if(flag!=1){
		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
		return;
	}

	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFeeT.value);
		return;
	}
	
	document.frm.backMoney.value=parseFloat(document.frm.all_rent.value)+parseFloat(document.frm.setNo_cost.value)-parseFloat(document.frm.handFee.value);
}

//ȷ�ϴ���
function submitCfm(){
    getAfterPrompt();
	if(flag==1){
		document.frm.systemNote.value=document.frm.phoneNo.value+"��������������,������:"+document.frm.handFee.value;
		if(document.frm.opNote.value.length==0){
			/* ningtn 2010-11-2 10:06:31
			document.frm.opNote.value=document.frm.phoneNo.value+"������������������,���κ���Ϊ"+document.frm.rent_phone.value;
			*/
			document.frm.opNote.value=document.frm.phoneNo.value;
		}
		
		if(!forReal(document.frm.handFee)){
			return;
		}
		
		printCommit();
		if(printFlag!=1){
			return;
		}
		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("f1224Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&systemNote="+document.frm.systemNote.value+"&opNote="+document.frm.opNote.value,"�����ύ�����Ժ�......");
		
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("asIdType",document.frm.asIdType.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("newLoginAccept",document.frm.newLoginAccept.value);		
		myPacket.data.add("ipAddr",document.frm.ipAddr.value);
		myPacket.data.add("idNo",document.frm.id_no.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
							
		core.ajax.sendPacket(myPacket);

		myPacket = null;
    	}
    	else{
    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
    	}
}
</script>

<body>
<FORM action="" method=post name="frm" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>

<table cellspacing="0">
    <tr> 
        <td class="blue">�������</td>
        <td> 
            <input class="InputGrey" id=Text2 type=text size=20 name='phoneNo' value="<%=activePhone%>" readOnly>            
        </td>
        <td class="blue">������ˮ��</td>
        <td colspan="3"> 
            <input type="hidden" name="inputPass" size="10"  >
            <input type="text" name="loginAccept" index="0" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onKeyUp="if(event.keyCode==13)f1224Init()" size="20" v_type="0_9">
            <font class="orange">*</font>
            <input class="b_text" type=button name=qry value="��ѯ" onclick=f1224Init()>
        </td>
    </tr>
    <tr> 
        <td class="blue">�û� I D</td>
        <td> 
            <input type="text" name="id_no" class="InputGrey" readOnly >
        </td>
        <td class="blue">��ǰ״̬</td>
        <td> 
            <input type="text" name="run_code" class="InputGrey" readOnly >
        </td>
        <td class="blue">����</td>
        <td> 
            <input class="InputGrey" type="text" name="cust_grade" size="18" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">��ǰԤ��</td>
        <td> 
            <input class="InputGrey" type="text" name="prepay_fee" readOnly >
        </td>
        <td class="blue">��ǰǷ��</td>
        <td> 
            <input class="InputGrey" type="text" name="owe_fee" readOnly >
        </td>
        <td class="blue">������</td>
        <td> 
            <input class="InputGrey orange" type=text size=18 name=cardType readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">�ͻ�����</td>
        <td colspan="5"> 
            <input class="InputGrey" type="text" name="cust_name" readOnly >
        </td>
    </tr>

</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>

<TABLE cellSpacing="0" >
    <tr> 
        <td class="blue">���ι���</td>
        <td> 
            <select name="country_code" disabled >
                <option value="">--���ѯ--</option>
                <%for(int i = 0 ; i < country.length ; i ++){%>
                    <option value="<%=country[i][0]%>|<%=country[i][2]%>"><%=country[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue">���������</td>
        <td colspan="3"> 
            <select name="custtype" disabled >
                <option value="0">����</option>
                <option value="1">��λ</option>
                <option value="2">ί��</option>
            </select>
        </td>
    </tr>
    <tr> 
        <td class="blue">���η�ʽ</td>
        <td colspan="5"> 
            <select name="roam_type" disabled index="3">
            <option value="">--���ѯ--</option>
            <%for(int i = 0 ; i < roamTypeArr.length ; i ++){%>
                <option value="<%=roamTypeArr[i][0]%>"><%=roamTypeArr[i][1]%></option>
            <%}%>
            </select>
        </td>
        <!-- ningtn ������� 2010-11-2 10:05:07
        <td class="blue">���κ���</td>
        <td colspan="3"> 
            <input class="InputGrey" name="rent_phone" type=text readOnly >
        </td>
        -->
    </tr>
    <!-- ningtn 2010-11-2 10:05:21
    <tr id=travelDiv style="display=''"> 
        <td class="blue">������ȡ����־</td>
        <td> 
            <select name=travelFlag disabled >
                <option value=0>��</option>            
                <option value=1>��</option>
            </select>
        </td>
        <td class="blue">����������</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="travelName" readOnly index="7" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>
    <tr style="display=''"> 
        <td class="blue">���պ���</td>
        <td colspan="6"> 
            <input class="InputGrey" type="text" name="visaName" index="7" readOnly onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>   
    -->        
    <tr> 
        <td class="blue">ȡ��ʱ��</td>
        <td> 
            <input class="InputGrey" type="text" name="getRentTime" readOnly >
        </td>
        <td class="blue">Ԥ�ƻ���ʱ��</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="preBackTime" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">ҵ��ͨʱ��</td>
        <td> 
            <input class="InputGrey" type="text" name="begin_time" readOnly >
        </td>
        <td class="blue">ҵ��ر�ʱ��</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="end_time" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">�ƶ��绰���к�</td>
        <td> 
            <input class="InputGrey" type="text" name="mobile_serial" value="" readOnly >
        </td>
        <td class="blue">�ƶ��绰�ͺ�</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="mobile_type" value="" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue" >��������</td>
        <td> 
            <input class="InputGrey" type="text" name="machine_num" readOnly >
        </td>
        <td class="blue" nowrap>����Ѻ��/��λ</td>
        <td> 
            <input class="InputGrey" type="text" name="perMachine_rent" value="" readOnly >
        </td>
        <td class="blue" nowrap>�ܼ�</td>
        <td> 
            <input class="InputGrey" type="text" name="machine_rent" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">�������</td>
        <td> 
            <input class="InputGrey" type="text" name="battery_num" readOnly >
        </td>
        <td class="blue" nowrap>���Ѻ��/��λ</td>
        <td> 
            <input class="InputGrey" type="text" name="perBattery_rent" value="" readOnly >
        </td>
        <td class="blue" nowrap>�ܼ�</td>
        <td> 
            <input class="InputGrey" type="text" name="battery_rent" readOnly >
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">���������</td>
        <td> 
            <input class="InputGrey" type="text" name="charger_num" readOnly >
        </td>
        <td nowrap class="blue">�����Ѻ��/��λ</td>
        <td> 
            <input class="InputGrey" type="text" name="perCharger_rent" value="" readOnly >
        </td>
        <td nowrap class="blue">�ܼ�</td>
        <td>
            <input class="InputGrey" type="text" name="charger_rent" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">˵��������</td>
        <td> 
            <input class="InputGrey" type="text" name="accountBook" readOnly >
        </td>
        <td class="blue" nowrap>�������ø���</td>
        <td> 
            <input class="InputGrey" type="text" name="otherComponent" readOnly >
        </td>
        <td class="blue">�ܼ�</td>          
        <td>
            <input class="InputGrey" type="text" name="addition_fee" readOnly >
        </td>             
    </tr>
    <tr style="display:none ">
        <td nowrap class="blue"> ����������</td>
        <td > 
            <input class="InputGrey" readOnly id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
        <td nowrap class="blue">��������ϵ�绰</td>
        <td> 
            <input class="InputGrey" readOnly id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
        </td>
        <td class="blue">��ϵ��ַ</td>
        <td> 
            <input class="InputGrey" readOnly id=Text2 type=text size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr style="display:none "> 
        <td class="blue" nowrap> ������֤������</td>
        <td> 
            <select size=1 name=asIdType disabled>
                <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
                    <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue" nowrap>֤������</td>
        <td> 
            <input class="InputGrey" readOnly id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
        </td>
        <td class="blue" nowrap>֤����ַ</td>
        <td> 
            <input class="InputGrey" readOnly id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    
    <tr style="display:none"> 
        <td class="blue">������ע</td>
        <td colspan="5"> 
            <input class="InputGrey" readOnly id=Text2a type=text size=30 name=asNotes maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr> 
        <td class="blue">�����趨��</td>
        <td> 
            <input class="InputGrey" type="text" name="setNo_cost" value="<%=country[0][2]%>" readOnly >
        </td>
        <td class="blue">Ѻ��ϼ�</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="all_rent" value=0 readOnly >
        </td>            
    </tr>
    <tr> 
        <td class="blue">��������</td>
        <td> 
            <select name="rent_type"  disabled >
                <option value="">--���ѯ--</option>
                <%for(int i = 0 ; i < rentTypeArr.length ; i ++){%>
                    <option value="<%=rentTypeArr[i][0]%>|<%=rentTypeArr[i][2]%>"><%=rentTypeArr[i][1]%></option>
                <%}%>
        </select>
        </td>
        <td class="blue">��λ���</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="rent_cost"  value="<%=rentTypeArr[0][2]%>" readOnly >
        </td>
    </tr>          
    <tr> 
        <td class="blue">������</td>
        <td> 
            <input class="InputGrey" type="text" index="1" name="handFee" <%if(feeFlag==0){%>readOnly<%}%> value="<%=tHandFee%>" v_type=float v_name="������">
        </td>
        <td class="blue">�ַ�Ӧ��&nbsp;<input class="b_text" id=Text2 type=button size=17 name=getbackMoney value="-->" onClick="getRemain()"></td>
        <td colspan="3"> 
            <input type="text" name="backMoney" size=8>
        </td>
    </tr>
    <tr style="display:none"> 
        <td class="blue">�û���ע</td>
        <td colspan="5">
            <input type="text" name="systemNote" size="60" index="23" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr bgcolor="E8E8E8"> 
    <td class="blue">��ע</td>
    <td colspan="5">
    <input class="InputGrey" readOnly id=Text2 type=text size=60 name=opNote  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
    </tr>
  </table>
	<!-- ningtn 2011-8-4 16:23:20 ������ӹ��� -->
	<jsp:include page="/npage/public/hwReadCustCard.jsp">
		<jsp:param name="hwAccept" value="<%=seq%>"  />
		<jsp:param name="showBody" value="01"  />
	</jsp:include>
  <table>
    <TR id="footer">
        <TD colspan="6">
            <input class="b_foot" name=submit index="4" onKeyUp="if(event.keyCode==13){submitCfm()}" type=button value="ȷ��" onclick="submitCfm()" id=button disabled >              
            <input class="b_foot" name=cancel  type=button value=��� id=Button2 onClick="window.location='f1224.jsp?activePhone=<%=activePhone%>'">
            <input class="b_foot" name=back13  type=button value=�ر� id=Button2 onClick="removeCurrentTab()">
        </TD>
    </TR>

</TABLE>

<input type=hidden name=newLoginAccept value="<%=seq%>">
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=ipAddr value="<%=request.getRemoteAddr()%>">
<input type=hidden name=opCode value="1224">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=fRentCode value=<%=rentTypeArr[0][0]%>>
<input type=hidden name=fCountryCode value="<%=country[0][0]%>">
<input type=hidden name=fCustTypeValue value="">
<input type=hidden name=fRoamTypeValue value="">
<input type=hidden name=fRentPhoneValue value="">
<input type=hidden name=cust_password value="">
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>

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
    //var h=150;
    //var w=350;
    //var t=screen.availHeight/2-h/2;
    //var l=screen.availWidth/2-w/2;
    //
    //var printStr = printInfo(printType);
    //
    //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
    //var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
    //var path = path + "&printInfo=" + printStr + "&submitCfn=" + submitCfn;
    //var ret=window.showModalDialog(path,"",prop);
    
    var h=198;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    
    var pType="subprint";
    var billType="1";
    var sysAccept = document.frm.newLoginAccept.value;
    var mode_code = null;
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    var phoneno = "<%=activePhone%>";
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

    var retInfo = "";
    if(printType == "Detail")
    {
        //var retInfo = "";
        //retInfo+='<%=workName%>'+"|";
    	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
    	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
    	cust_info+="�ͻ���ַ��"+document.all.custAddress.value+"|";
    	cust_info+="֤�����룺"+document.all.idCardNo.value+"|";

    	opr_info+="ҵ�����ͣ�"+"��������������"+"|";
    	opr_info+="�����ѣ�"+document.frm.handFee.value+"|";
    	opr_info+="��ˮ��"+document.frm.loginAccept.value+"|";

    	note_info1+=document.all.systemNote.value+"|";
    	note_info2+=document.all.opNote.value+"|";   
    	
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
    var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=workNo%>");       //����
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005",document.frm.cust_name.value); //�ͻ�����
	$(billArgsObj).attr("10006","��������������"); //ҵ�����
	$(billArgsObj).attr("10008",document.frm.phoneNo.value); //�û�����
	$(billArgsObj).attr("10015", document.frm.handFee.value);   //���η�Ʊ���
	$(billArgsObj).attr("10016", document.frm.handFee.value);   //��д���ϼ�	
	$(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
	$(billArgsObj).attr("10021",document.frm.handFee.value); //������
	$(billArgsObj).attr("10030",document.frm.backLoginAccept.value); //��ˮ��--ҵ����ˮ
	$(billArgsObj).attr("10036","<%=opCode%>"); //��������
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��" ;
	
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��" ;
	
		
	var loginAccept = document.frm.loginAccept.value;
	var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);               
}
</script>
</BODY>
<!-- ningtn 2011-7-12 08:35:36 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>
