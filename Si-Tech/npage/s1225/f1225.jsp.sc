<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-29
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String activePhone1=request.getParameter("activePhone1");
    //ȡ֤�����͡�֤������
        //SPubCallSvrImpl impl=new SPubCallSvrImpl();
    String sql = "select id_type,id_name from sidtype";
        //ArrayList sIdTypeArr = impl.sPubSelect("2",sql);
%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone1%>"  outnum="2">
        <wtc:sql><%=sql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="sIdTypeStr" scope="end"/>
<%
        //String[][] sIdTypeStr = (String[][])sIdTypeArr.get(0);

    //ȡsession��Ϣ
    ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String nopass = (String)session.getAttribute("password");
    
        //String[][] baseInfo = (String[][])arr1.get(0);
        //String[][] info = (String[][])arr1.get(2);
    String[][] favInfo = (String[][])session.getAttribute("favInfo");


    //�ж��Ƿ������б����������Ȩ��
    int favRentFlag = 0 ;
    for(int i = 0 ; i < favInfo.length ; i ++){
    	if(favInfo[i][0].trim().equals("a277")){
    		favRentFlag = 1;
    	}
    }
    
    //ȡ����������
    String org_codeT = (String)session.getAttribute("orgCode");
    String region_codeT = org_codeT.substring(0,2);
        //ArrayList arr = F1224Wrapper.getFuncFee1225(region_codeT);

    String sqlHandFee = "select to_char(hand_fee), favour_code from sNewFunctionFee where region_code = '"+region_codeT+"' and function_code = '1225'";
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

    // ȡҵ�������ˮ
    String paraStr[]=new String[1];
%>
    <wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_codeT%>"  id="login_accept"/>
<%
    paraStr[0] = login_accept;
    System.out.println("��ˮ:  "+paraStr[0]);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�����������</TITLE>
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
	document.all.phoneNo.focus();
	//core.rpc.onreceive = doProcess;
}

function doProcess(packet){
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");


	if(document.frm.favRentFlag.value==1){
		document.frm.rent_fee.readOnly=false;
	}
	if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			var errCodeInt = parseInt(errCode,10);

			if(errCodeInt==0){
				rdShowMessageDialog("�����ɹ���",2);
				document.frm.backLoginAccept.value=backString[0][0];

				if(parseFloat(document.frm.payBroken.value) + parseFloat(document.frm.rent_fee.value) > 0.05){
					printBill();
				}
				else{
					window.location="f1225.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}
			else{

				rdShowMessageDialog(errCode + " : " + errMsg,0);
				window.locaion="f1225.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
			}
	}

	if(cfmFlag==9){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");

		rdShowMessageDialog(errCode + " : " + errMsg,0);
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
			flag=0;
			return;
		}
		else{
			document.frm.submit.disabled=false;
			document.frm.cust_password.value=backString[0][4];
			//alert("document.frm.cust_password.value======"+document.frm.cust_password.value);
			document.frm.id_no.value=backString[0][0];
			document.frm.run_code.value=backString[0][6];
			document.frm.cust_grade.value=backString[0][8];
			document.frm.prepay_fee.value=backString[0][17];
			document.frm.owe_fee.value=backString[0][16];
			document.frm.cust_name.value=backString[0][3];
			document.frm.custAddress.value=backString[0][11];
			document.frm.idCardNo.value=backString[0][14];
			document.frm.cardType.value=backString[0][15];
			document.frm.smName.value=backString[0][2];

			document.frm.getRentTime.value=moreString[0][4];
			document.frm.preBackTime.value=moreString[0][5];
			document.frm.begin_time.value=moreString[0][6];
			document.frm.end_time.value=moreString[0][7];
			document.frm.mobile_serial.value=moreString[0][9];
			document.frm.mobile_type.value=moreString[0][8];
			document.frm.rent_fee.value=moreString[0][19];

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
			/* ningtn 2010-11-2 10:57:12 
			document.frm.travelName.value=moreString[0][3];
			document.frm.visaName.value=moreString[0][20];
			*/
			document.frm.accountBook.value=moreString[0][16];
			document.frm.otherComponent.value=moreString[0][17];
			/* ningtn 2010-11-2 10:54:06
			document.frm.rent_phone.value=moreString[0][2];
			*/
			document.frm.machine_rent.value=document.frm.machine_num.value*document.frm.perMachine_rent.value;
			document.frm.battery_rent.value=document.frm.battery_num.value*document.frm.perBattery_rent.value;
			document.frm.charger_rent.value=document.frm.charger_num.value*document.frm.perCharger_rent.value;
			document.frm.all_rent.value=parseFloat(document.frm.charger_rent.value)+parseFloat(document.frm.battery_rent.value)+parseFloat(document.frm.machine_rent.value)+parseFloat(document.frm.addition_fee.value);
			/* ningtn 2010-11-3 9:43:48 ԤԼ��Чʱ��*/
			$("#bookingTime").val(moreString[0][31]);
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
			/* ningtn 2010-11-2 10:55:31
			for(i = 0 ; i < document.frm.travelFlag.length ; i ++){
				if(moreString[0][21]==document.frm.travelFlag.options[i].value){
					document.frm.travelFlag.options[i].selected=true;
					break;
				}
			}
			*/
			//����Ӧ��
			document.frm.factPay.value=parseFloat(document.frm.all_rent.value)+parseFloat(document.frm.setNo_cost.value);
			getSum();

			flag=1;
			return;
		}
	}
}

//��ȡ���������Ϣ
function f1225Init(){
      if(document.frm.phoneNo.value.length==0){
      		rdShowMessageDialog("�������ֻ����룡");
      		return;
      }

      if(!checkElement(document.frm.phoneNo)){
		document.frm.phoneNo.value = "<%=activePhone1%>";
		return;
      }
	document.frm.qry.disabled=true;
	var myPacket = new AJAXPacket("getUserInfo.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("workNo",document.frm.workNo.value);
	myPacket.data.add("phoneNo",document.frm.phoneNo.value);
	myPacket.data.add("opCode",document.frm.opCode.value);
	myPacket.data.add("orgCode",document.frm.orgCode.value);

    	core.ajax.sendPacket(myPacket);
    	myPacket = null;
}

//���������
function getSum(){
	document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value-document.frm.payBroken.value-document.frm.rent_fee.value;
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

	document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value-document.frm.payBroken.value-document.frm.rent_fee.value;
}

//ȷ�ϴ���
function submitCfm(){
    getAfterPrompt();
	if(flag==1){
		document.frm.systemNote.value=document.frm.phoneNo.value+"��������,���:"+document.frm.rent_fee.value+",������:"+document.frm.handFee.value+",�۾�:"+document.frm.payBroken.value

		if(document.frm.opNote.value.length==0){
			/* ningtn 2010-11-2 10:54:20
			document.frm.opNote.value=document.frm.phoneNo.value+"������������ҵ��,���κ���Ϊ"+document.frm.rent_phone.value;
			*/
			document.frm.opNote.value=document.frm.phoneNo.value;
		}

		if(!forReal(document.frm.handFee)){
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

		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("f1225Cfm.jsp?systemNote="+document.frm.systemNote.value+"&opNote="+document.frm.opNote.value,"�����ύ�����Ժ�......");

		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.id_no.value);
		myPacket.data.add("chandFee",document.frm.handFeeT.value);
		myPacket.data.add("handFee",document.frm.handFee.value);
		myPacket.data.add("ipAddr",document.frm.ipAdd.value);
		myPacket.data.add("payBroken",document.frm.payBroken.value);
		myPacket.data.add("phoneFee",document.frm.setNo_cost.value);
		myPacket.data.add("rentFee",document.frm.rent_fee.value);
		myPacket.data.add("deposit",document.frm.all_rent.value);

		myPacket.data.add("asCustName",document.frm.asCustName.value);
		myPacket.data.add("asCustPhone",document.frm.asCustPhone.value);
		myPacket.data.add("asIdType",document.frm.asIdType.value);
		myPacket.data.add("asIdIccid",document.frm.asIdIccid.value);
		myPacket.data.add("asIdAddress",document.frm.asIdAddress.value);
		myPacket.data.add("asContractAddress",document.frm.asContractAddress.value);
		myPacket.data.add("asNotes",document.frm.asNotes.value);
		myPacket.data.add("rent_indemnity",document.frm.rent_indemnity.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
    		core.ajax.sendPacket(myPacket);

	    	myPacket = null;
    	}
    	else{
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

<table id=tbs9 cellspacing=0>
    <tr>
        <td class="blue">�������</td>
        <td>
            <input class=InputGrey readOnly id=Text2 type=text size=13 name=phoneNo value="<%=activePhone1%>" index="0" maxlength=11 v_type="mobphone" onKeyUp="if(event.keyCode==13)f1225Init()">
            <input class=b_text type=button name=qry value="��ѯ" onclick="f1225Init()">
        </td>
        
        <td class="blue">�ͻ�����</td>
        <td colspan=3>
            <input class=InputGrey  type="text" name="cust_name" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">�û� I D</td>
        <td>
            <input class=InputGrey type="text" name="id_no" readOnly >
        </td>
        <td class="blue">��ǰ״̬</td>
        <td>
            <input class=InputGrey type="text" name="run_code" readOnly >
        </td>
        <td class="blue">����</td>
        <td>
            <input class=InputGrey type="text" name="cust_grade" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">��ǰԤ��</td>
        <td>
            <input class=InputGrey type="text" name="prepay_fee" readOnly >
        </td>
        <td class="blue">��ǰǷ��</td>
        <td>
            <input class=InputGrey type="text" name="owe_fee" readOnly >
        </td>
        <td class="blue">��ͻ���־</td>
        <td>
            <input class="InputGrey orange" type=text name=cardType readonly >
        </td>
    </tr>
</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
<TABLE cellSpacing=0 >
    <tr>
        <td class="blue">���ι���</td>
        <td> 
            <select name="country_code" disabled >
                <%for(int i = 0 ; i < country.length ; i ++){%>
                    <option value="<%=country[i][0]%>|<%=country[i][2]%>"><%=country[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue">���������</td>
        <td colspan=3>
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
                <%for(int i = 0 ; i < roamTypeArr.length ; i ++){%>
                    <option value="<%=roamTypeArr[i][0]%>"><%=roamTypeArr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <!-- ningtn 2010-11-2 10:53:27
        <td class="blue">���κ���</td>
        <td colspan=3>
            <input class=InputGrey name="rent_phone" type=text readOnly >
        </td>
        -->
    </tr>
    <!-- ningtn 2010-11-2 10:53:44
    <tr id=travelDiv style="display=''">
        <td class="blue">������ȡ����־</td>
        <td>
            <select name=travelFlag disabled >
                <option value=0>��</option>
                <option value=1>��</option>
            </select>            </td>
        <td class="blue">����������</td>
        <td colspan=3>
            <input class=InputGrey type="text" name="travelName" readOnly index="7" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>
    <tr style="display=''">
        <td class="blue">���պ���</td>
        <td colspan=5>
            <input class=InputGrey type="text" name="visaName" index="7" readOnly onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>
    -->
    <tr>
        <td class="blue">ȡ��ʱ��</td>
        <td>
            <input class=InputGrey type="text" name="getRentTime" readOnly >
        </td>
        <td class="blue">Ԥ�ƻ���ʱ��</td>
        <td colspan=3>
            <input class=InputGrey type="text" name="preBackTime" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">ҵ��ͨʱ��</td>
        <td>
            <input class=InputGrey type="text" name="begin_time" readOnly >
        </td>
        <td class="blue">ҵ��ر�ʱ��</td>
        <td colspan=3>
            <input class=InputGrey type="text" name="end_time" readOnly >
        </td>
    </tr>
    <!-- ningtn 2010-11-3 9:45:30 -->
    <tr>
    	<td class="blue">ԤԼ��Чʱ��</td>
    	<td colspan="6">
    		<input type="text" name="bookingTime" id="bookingTime" class=InputGrey readOnly />
    	</td>
    </tr>
    <tr>
        <td class="blue">�ƶ��绰���к�</td>
        <td>
            <input class=InputGrey type="text" name="mobile_serial" value="" readOnly >
        </td>
        <td class="blue">�ƶ��绰�ͺ�</td>
        <td colspan=3>
            <input class=InputGrey type="text" name="mobile_type" value="" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">��������</td>
        <td>
            <input class=InputGrey type="text" name="machine_num" readOnly >
        </td>
        <td class="blue">����Ѻ��/��λ</td>
        <td>
            <input class=InputGrey type="text" name="perMachine_rent" value="" readOnly >
        </td>
        <td class="blue">�ܼ�</td>
        <td>
            <input class=InputGrey type="text" name="machine_rent" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">�������</td>
        <td>
            <input class=InputGrey type="text" name="battery_num" readOnly >
        </td>
        <td class="blue">���Ѻ��/��λ</td>
        <td>
            <input class=InputGrey type="text" name="perBattery_rent" value="" readOnly >
        </td>
        <td class="blue">�ܼ�</td>
        <td>
            <input class=InputGrey type="text" name="battery_rent" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">���������</td>
        <td>
            <input class=InputGrey type="text" name="charger_num" readOnly >
        </td>
        <td class="blue">�����Ѻ��/��λ</td>
        <td>
            <input class=InputGrey type="text" name="perCharger_rent" value="" readOnly >
        </td>
        <td class="blue">�ܼ�</td>
        <td>
            <input class=InputGrey type="text" name="charger_rent" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">˵��������</td>
        <td>
            <input class=InputGrey type="text" name="accountBook" readOnly >
        </td>
        <td class="blue" nowrap>�������ø���</td>
        <td>
            <input class=InputGrey type="text" name="otherComponent" readOnly >
        </td>
        <td class="blue">�ܼ�
        </td>
        <td>
            <input class=InputGrey type="text" name="addition_fee" readOnly >
        </td>
    </tr>
    <tr style="display:none ">
        <td nowrap class="blue">����������</td>
        <td>
            <input class=InputGrey id=Text2 type=text size=17 name=asCustName readOnly maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
        <td class="blue" nowrap>��������ϵ�绰��</td>
        <td>
            <input class=InputGrey id=Text2 type=text size=17 name=asCustPhone maxlength=20  readOnly>
        </td>
        <td class="blue">��ϵ��ַ</td>
        <td>
            <input class=InputGrey id=Text2 type=text size=17 name=asContractAddress  readOnly maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr  style="display:none ">
        <td class="blue" nowrap>������֤������</td>
        <td>
            <select size=1 name=asIdType  >
                <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
                    <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue" nowrap>֤������</td>
        <td>
            <input class=InputGrey id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
        </td>
        <td class="blue" nowrap>֤����ַ</td>
        <td>
            <input class=InputGrey id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr style="display:none">
        <td class="blue">������ע</td>
        <td colspan=5>
            <input class=InputGrey readOnly id=Text2a type=text size=30 name=asNotes maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr>
        <td class="blue">�����趨��</td>
        <td>
            <input class=InputGrey type="text" name="setNo_cost" value="<%=country[0][2]%>" readOnly >
        </td>
        <td class="blue">Ѻ��ϼ�</td>
        <td colspan=3>
            <input class=InputGrey type="text" name="all_rent" value=0 readOnly  >
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
        <td colspan=3>
            <input class=InputGrey type="text" name="rent_cost"  value="<%=rentTypeArr[0][2]%>" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">�����/����</td>
        <td>
            <input class=InputGrey type="text" name="rent_day" value=0 readOnly >
        </td>
        <td class="blue">Ӧ�����</td>
        <td colspan=3>
            <input  type="text" name="rent_fee" onChange="getSum()" value=0 readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">������</td>
        <td>
            <input class=InputGrey type="text" index="2" name="handFee" <%if(feeFlag==0){%>readOnly<%}%> value="<%=tHandFee%>" v_type=float v_name="������">
        </td>
        <td class="blue">�۾�</td>
        <td>
            <input type="text" name="payBroken" onChange="getSum()"  value=0 onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
        <td class="blue">�豸�⳥��</td>
        <td>
            <input type="text" name="rent_indemnity"  value=0 onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>
    <tr>
        <td class="blue">ʵ��</td>
        <td>
            <input class=InputGrey type="text" index="3" onKeyUp="if(event.keyCode==13){getRemain()}" name="factPay" size=14 readonly>
        </td>
        <td class="blue">����&nbsp;
            <input class=b_text id=getUseInfo type=button size=17 name=getUseInfo value="-->" onClick="getRemain()"></td>
        <td colspan=3>
            <input class=InputGrey type="text" name="remain" size=14 readonly>
        </td>
    </tr>
    <tr style="display:none">
        <td class="blue">ϵͳ��ע</td>
        <td colspan=5>
            <input class=InputGrey type="text" name="systemNote" size="60" index="23" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr>
        <td class="blue">��ע</td>
        <td colspan=5>
            <input class=InputGrey readOnly id=Text2 type=text size=60 name=opNote  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
  </table>
  <!-- ningtn 2011-8-4 16:30:15 ������ӹ��� -->
	<jsp:include page="/npage/public/hwReadCustCard.jsp">
		<jsp:param name="hwAccept" value="<%=paraStr[0]%>"  />
		<jsp:param name="showBody" value="01"  />
	</jsp:include>
  <table>
    <TR id="footer">
        <TD colspan=6>
            <input class="b_foot" name=submit  index="5" onKeyUp="if(event.keyCode==13){submitCfm()}" type=button value="ȷ��" onclick="submitCfm()" id=button disabled>
            <input class="b_foot" name=cancel  type=button value=��� id=Button2 onClick="window.location='f1225.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>'">
            <input class="b_foot" name=back13  type=button value=�ر� id=Button2 onClick="removeCurrentTab()">
        </TD>
    </TR>

</table>
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=opCode value="1225">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=fRentCode value=<%=rentTypeArr[0][0]%>>
<input type=hidden name=fCountryCode value="<%=country[0][0]%>">
<input type=hidden name=cust_password value="">
<input type=hidden name=loginAccept value="<%=paraStr[0]%>">
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=favRentFlag value="<%=favRentFlag%>">
<input type=hidden name=smName value="">

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
   //var h=150;
   //var w=350;
   //var t=screen.availHeight/2-h/2;
   //var l=screen.availWidth/2-w/2;
   //
   //var printStr = printInfo(printType);
   //
   //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   //  var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   //  var path = path + "&printInfo=" + printStr + "&submitCfn=" + submitCfn;
   //  var ret=window.showModalDialog(path,"",prop);
     
    var h=198;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    
    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=paraStr[0]%>";
    var mode_code = null;
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    var phoneno = "<%=activePhone1%>";
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
       if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
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
       //retInfo+='<%=workNo%>   <%=workName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.custAddress.value+"|";
	cust_info+="֤�����룺"+document.all.idCardNo.value+"|";
	
	opr_info+="�û�Ʒ�ƣ�"+document.all.smName.value+"  ҵ�����ͣ� �������������"+"  ������ˮ��"+document.frm.loginAccept.value+"|";
	opr_info+="�ֻ����кţ�"+document.all.mobile_serial.value+"  �ֻ��ͺţ�"+document.all.mobile_type.value+"  �����ʽ��"+document.all.roam_type.options[document.all.roam_type.selectedIndex].text+"|";
	opr_info+="���Ѻ��ϼƣ�"+document.all.all_rent.value+"  �۾ɽ�"+document.all.payBroken.value+"  �����"+document.all.rent_fee.value +"   �˻���"+document.frm.remain.value+"|";

	note_info1+="��ע"+"|";
	
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
	var totalFee = parseFloat(document.frm.payBroken.value) + parseFloat(document.frm.rent_fee.value);
 	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=workNo%>");       //����
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005",document.frm.cust_name.value); //�ͻ�����
	$(billArgsObj).attr("10006","�����������"); //ҵ�����
	$(billArgsObj).attr("10008",document.frm.phoneNo.value); //�û�����
	$(billArgsObj).attr("10015", "-"+document.frm.remain.value);   //���η�Ʊ���
	$(billArgsObj).attr("10016", "-"+document.frm.remain.value);   //��д���ϼ�	
	$(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
	$(billArgsObj).attr("10021",document.frm.handFee.value); //������

	$(billArgsObj).attr("10030",document.frm.backLoginAccept.value); //��ˮ��--ҵ����ˮ
	$(billArgsObj).attr("10036","<%=opCode%>"); //��������	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��" ;
	var loginAccept = document.frm.backLoginAccept.value;
	var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);      
}
</script>
</BODY>
<!-- ningtn 2011-7-12 08:35:36 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>
