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
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
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


%>
<%

    String org_codeT = (String)session.getAttribute("orgCode");
    String region_codeT = org_codeT.substring(0,2);
    
    String sqlHandFee = "select to_char(hand_fee), favour_code from sNewFunctionFee where region_code = :regionCode and function_code = '1223'";
    System.out.println("sqlHandFee = " + sqlHandFee );
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
    StringBuffer sq12 = new StringBuffer();
    sq12.append("select country_code, country_name, to_char(phone_fee) from scountrycode");
        //ArrayList countryArr = impl.sPubSelect("3",sq12.toString());

%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" outnum="3">
    	<wtc:sql><%=sq12.toString()%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="country" scope="end" />
<%

        //String[][] country = (String[][])countryArr.get(0);
    
    //ȡ������η�ʽ������
        //ArrayList roamTypeArrList = F1222Wrapper.getRoamType(region_codeT);
    sq12 = new StringBuffer();
    sq12.append("SELECT rent_type,rent_name");
    sq12.append(" FROM sRentTypeName");
    sq12.append(" order by rent_type");
        //ArrayList roamTypeArrList = impl.sPubSelect("2",sq12.toString());

%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" outnum="2">
    	<wtc:sql><%=sq12.toString()%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="roamTypeArr" scope="end" />
<%

        //String[][] roamTypeArr = (String[][])roamTypeArrList.get(0);
    
    //��ȡ���ʽ���롢���ʽ���ƺ͵�λ���
        //ArrayList rentTypeArrList = F1222Wrapper.getRentFee(region_codeT);
    sq12 = new StringBuffer();
    sq12.append("select distinct rent_code,rent_name,to_char(rent_fee) from srentcode");
        //ArrayList rentTypeArrList = impl.sPubSelect("3",sq12.toString());

%>
    <wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>" outnum="3">
    	<wtc:sql><%=sq12.toString()%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="rentTypeArr" scope="end" />
<%

        //String[][] rentTypeArr = (String[][])rentTypeArrList.get(0);
    //������ˮ
    String paraStr[]=new String[1];
        //comImpl co1=new comImpl();
        //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
        //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();

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
	//document.all.phoneNo.focus();
	//core.rpc.onreceive = doProcess;
}

function doProcess(packet){	
	var backString = packet.data.findValueByName("backString");	
	var cfmFlag = packet.data.findValueByName("flag");
	if(cfmFlag==9){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog(errCode + " : " + errMsg,0);
		
		document.frm.qry.disabled=false;
		
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
				rdShowMessageDialog(errCode + " : " + errMsg,0);
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
				rdShowMessageDialog(errCode + " : " + errMsg,0);

				document.frm.qry.disabled=false;
				
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
				document.frm.smName.value=backString[0][2];
				document.frm.idCardNo.value=backString[0][14];

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
				/* ningtn 2010-11-1 17:22:47
				document.frm.travelName.value=moreString[0][3];
				document.frm.visaName.value=moreString[0][20];	
				*/
				document.frm.accountBook.value=moreString[0][16];	
				document.frm.otherComponent.value=moreString[0][17];
				//document.frm.rent_phone.value=moreString[0][2]; ningtn 2010-11-1 17:11:14
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
				/* ningtn 2010-11-1 17:12:25
				for(m = 0 ; m < document.frm.travelFlag.length ; m ++){
					if(moreString[0][21]==document.frm.travelFlag.options[m].value){
						document.frm.travelFlag.options[m].selected=true;
						break;
					}
				}
				*/		  	
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
    getAfterPrompt();
	if(flag==1){
		document.frm.systemNote.value="����"+document.frm.phoneNo.value+"����������,������:"+document.frm.handFee.value;
		if(document.frm.opNote.value.length==0){
			/* ningtn 2010-11-1 17:11:02
			document.frm.opNote.value=document.frm.phoneNo.value+"��������������,���κ���Ϊ"+document.frm.rent_phone.value;
			*/
			document.frm.opNote.value=document.frm.phoneNo.value;
		}
			
		if(forDate(document.frm.end_time)==false){
			return;
		}
		if(forDate(document.frm.preBackTime)==false){
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
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
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
<body>
<FORM action="" method=post name="frm" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div> 
<table cellspacing=0>
    <tr> 
        <td class="blue">�������</td>
        <td> 
            <input class=InputGrey readOnly id=Text2 type=text size=13 name=phoneNo value=<%=activePhone1%> index="0" v_type="mobphone" maxlength=11 onKeyUp="if(event.keyCode==13)submitt()">
            <input class=b_text type=button name=qry value="��ѯ" onclick=submitt()>
        </td>
        <td class="blue">�ͻ�����</td>
        <td colspan=3> 
            <input class=InputGrey type="text" name="cust_name" readOnly >
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
            <select name="country_code" onchange="getPhoneFee()" disabled >
                <option value="">���ѯ</option>
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
                <option value="">���ѯ</option>
                <%for(int i = 0 ; i < roamTypeArr.length ; i ++){%>
                    <option value="<%=roamTypeArr[i][0]%>"><%=roamTypeArr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <!-- ningt 2010-11-1 17:08:57
        <td class="blue">���κ���</td>
        <td colspan="3"> 
            <div id=rentPhoneDiv> 
                <input class=InputGrey name="rent_phone" type=text readOnly >
            </div>
        </td>
        -->
    </tr>
    <!-- ningtn 2010-11-1 17:10:03
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
            <input class=InputGrey type="text" name="travelName" readOnly index="7" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>
    <tr style="display=''"> 
        <td class="blue">���պ���</td>
        <td colspan="6"> 
            <input class=InputGrey type="text" name="visaName" index="7" readOnly onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr> 
    -->
    <tr> 
        <td class="blue">ȡ��ʱ��</td>
        <td> 
            <input class=InputGrey type="text" v_format="yyyyMMdd ss:ss:ss" name="getRentTime" readOnly >
        </td>
        <td class="blue">Ԥ�ƻ���ʱ��</td>
        <td colspan="3"> 
            <input type="text" v_format="yyyyMMdd ss:ss:ss" name="preBackTime" index="2">
        </td>
    </tr>
    <tr> 
        <td class="blue">ҵ��ͨʱ��</td>
        <td> 
            <input class=InputGrey type="text" v_format="yyyyMMdd ss:ss:ss" name="begin_time" readOnly >
        </td>
        <td class="blue">ҵ��ر�ʱ��</td>
        <td colspan="3"> 
            <input type="text" v_format="yyyyMMdd ss:ss:ss" name="end_time" index="3">
        </td>
    </tr>
    <tr> 
        <td class="blue">�ƶ��绰���к�</td>
        <td> 
            <input class=InputGrey type="text" name="mobile_serial" value="" readOnly >
        </td>
        <td class="blue">�ƶ��绰�ͺ�</td>
        <td colspan="3"> 
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
        <td nowrap class="blue">�ܼ�</td>
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
        <td class="blue" nowrap>�ܼ�
        </td>
        <td> 
            <input class=InputGrey type="text" name="battery_rent" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">���������</td>
        <td> 
            <input class=InputGrey type="text" name="charger_num" readOnly >
        </td>
        <td nowrap class="blue">�����Ѻ��/��λ</td>
        <td> 
            <input class=InputGrey type="text" name="perCharger_rent" value="" readOnly >
        </td>
        <td nowrap class="blue">�ܼ�</td>
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
        <td class="blue">�ܼ�</td>          
        <td>
            <input class=InputGrey type="text" name="addition_fee" readOnly >
        </td>             
    </tr>
    <tr style="display:none">
        <td class="blue"  nowrap> ����������</td>
        <td> 
            <input class=InputGrey readOnly id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
        
        <td  class="blue" nowrap>��������ϵ�绰</td>
        <td> 
        
            <input class=InputGrey readOnly id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
        
        </td>
        
        <td class="blue">��ϵ��ַ</td>
        <td colspan=2> 
            <input class=InputGrey readOnly id=Text2 type=text size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr style="display:none"> 
    
        <td class="blue" nowrap>������֤������</td>
        <td > 
            <select size=1 name=asIdType  >
                <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
                    <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue" nowrap>֤������</td>
        <td> 
            <input class=InputGrey readOnly id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
        </td>
        
        <td class="blue" nowrap>֤����ַ</td>
        <td colspan=2> 
            <input class=InputGrey readOnly id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr style="display:none"> 
    
        <td class="blue">������ע</td>
        <td colspan=5> 
            <input class=InputGrey readOnly id=Text2a type=text size=30 name=asNotes  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>  
    </tr>
    <tr> 
        <td class="blue">�����趨��</td>
        <td> 
            <input class=InputGrey type="text" name="setNo_cost" value="<%=country[0][2]%>" readOnly >
        </td>
        <td class="blue">Ѻ��ϼ�</td>
        <td colspan="3"> 
            <input class=InputGrey type="text" name="all_rent" value=0 readOnly >
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
            <input class=InputGrey type="text" name="rent_cost"  value="<%=rentTypeArr[0][2]%>" readOnly >
        </td>
    </tr>
    <tr> 
        <td class="blue">������</td>
        <td> 
            <input class=InputGrey type="text" index="4" name="handFee" <%if(feeFlag==0){%>readOnly<%}%> value="<%=tHandFee%>" v_type=float v_name="������">
        </td>
        <td class="blue">ʵ��</td>
        <td> 
            <input type="text" index="5" onKeyUp="if(event.keyCode==13){getRemain()}" name="factPay" size=6>
        </td>
        <td class="blue" nowrap><input class=b_text id=Text2 type=button size=17 name=getUseInfo value="-->" onClick="getRemain()">&nbsp;����</td>
        <td>
            <input class=InputGrey readOnly type="text" name="remain" size=6>
        </td>
    </tr>
    <tr style="display:none"> 
        <td class="blue">ϵͳ��ע</td>
        <td colspan=5>
            <input class=InputGrey readOnly type="text" name="systemNote" size="60" index="23" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr> 
        <td class="blue">��ע</td>
        <td colspan="5">
            <input class=InputGrey readOnly id=Text2 type=text size=60 name=opNote  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    
    <TR id="footer">
        <TD colspan=6>
            <input class="b_foot" name=submit  index="7" onKeyUp="if(event.keyCode==13){submitCfm()}" type=button value="ȷ��" onclick="submitCfm()" id=button >
            <input class="b_foot" name=cancel  type=button value=��� id=Button2 onClick="window.location='f1223.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>'">
            <input class="b_foot" name=back13  type=button value=�ر� id=Button2 onClick="removeCurrentTab()">
        </TD>
    </TR>

</table>
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=loginAccept value="<%=paraStr[0]%>">
<input type=hidden name=opCode value="1223">
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
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
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
    //retInfo+='<%=workNo%>  <%=workName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.custAddress.value+"|";
	cust_info+="֤�����룺"+document.all.idCardNo.value+"|";

	opr_info+="�û�Ʒ�ƣ�"+document.all.smName.value+"  ҵ�����ͣ� �������������"+"  ������ˮ��"+document.frm.loginAccept.value+"|";
	opr_info+="Ѻ��ϼƣ�"+document.frm.all_rent.value+"  �������ޣ�"+document.frm.preBackTime.value+"|";            

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
        var  billArgsObj = new Object();
 		$(billArgsObj).attr("10001","<%=workNo%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm.cust_name.value); //�ͻ�����
 		$(billArgsObj).attr("10006","�������������"); //ҵ�����
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



		var loginAccept = document.frm.backLoginAccept.value;
		var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
}
</script>
</BODY></HTML>
