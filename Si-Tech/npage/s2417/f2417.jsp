
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-5
********************/
%>
              
<%
  String opCode = "2417";
  String opName = "�û������޸�";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>

<%@ page import="com.sitech.boss.f2417.ejb.*"%>
<%@ page import="com.sitech.boss.f2417.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");
	String rightCode = (String)session.getAttribute("rightCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String region_codeT = (String)session.getAttribute("regCode");
	String orgCode =(String)session.getAttribute("orgCode");
	String phoneNoGp = (String)request.getParameter("activePhone");
	
	String sqIdtype = "select id_type,id_name from sidtype";
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=sqIdtype%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>
	 	
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_codeT%>"  id="seq"/>

<%

//ArrayList sIdTypeArr = co.spubqry32("2",sqIdtype);
String[][] sIdTypeStr = result_t1;

int favFlag = 0 ;
for(int i = 0 ; i < favInfo.length ; i ++){
	if(favInfo[i][0].trim().equals("a272")){
		favFlag = 1;
	}

}

%>
<%

//ArrayList arr = F2417Wrapper.getFuncFee(region_codeT);
String[][]fee = new String [][]{};
String SqlStr = "select function_code, hand_fee from sNewFunctionFee where function_code ='2417' and region_code ='" + region_codeT +"'" ;
System.out.println(SqlStr);
//ArrayList arr = co.spubqry32("2", SqlStr);

%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%
if(result_t3 != null)
{
fee = result_t3; 
}  
//System.out.println(fee.length);
String tHandFee = "0";
int feeFlag = 0;
if(fee.length==0){
tHandFee="0";
feeFlag = 0;
}else{
tHandFee=fee[0][1];
}

String[][]high = new String [][]{};
String SqlStr1 = "select count(*) from shighlogin where op_code ='2417' and login_no ='" + workNo +"'" ;
String SqlStr22 = "select add_point from spointmonthcfg where region_code='"+region_codeT+"' ";
String SqlStr221 = "select distinct sum(b.points) from  dloginmsg a, wmarktransopr b where a.login_no = b.login_no and substr(a.org_code,1,2) = '"+region_codeT+"'   and to_char(b.op_time, 'yyyymm') = to_char(sysdate, 'yyyymm') and b.op_code = '2417'";
					
					
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg31" retcode="code31" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr22%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t211" scope="end"/>
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg312" retcode="code312" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=SqlStr221%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t222" scope="end"/>

<%

String regCodegp2="0";
if(result_t222!=null && result_t222.length>0)
{
 regCodegp2 = result_t222[0][0];
}
String regCodegp3="0";
if(result_t211!=null && result_t211.length>0)
{
 regCodegp3 = result_t211[0][0];
}

System.out.println(SqlStr1);
//ArrayList arrhig = co.spubqry32("1", SqlStr1);
if(result_t2!=null)
{
high = result_t2; 
System.out.println("powerpowerpowerpowerpower="+high[0][0]);
}  


String ph_no = request.getParameter("ph_no");

String sql_select2 = "select mark_code,mark_name from dbcustadm.smarktype where mark_flag='0' order by  mark_name desc ";
boolean pwrf = false;
String pubOpCode = opCode;
%>
	<wtc:service name="TlsPubSelBoss" outnum="2">
		<wtc:param value="<%=sql_select2%>"/>
	</wtc:service>
	<wtc:array id="result_type" scope="end"/>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>		
<%
/**
		20130219gaopeng�޸ģ�������ѯ��ǰ������ֻ�����Ĺ��������뵱ǰ��¼���ŵĹ������У����������а����ҵ��(����aaa8zy����)
		start
**/
		String sqlregC= "select trim(b.region_code) from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no='"+phoneNoGp+"'";
 
%>		
<wtc:service name="TlsPubSelBoss" outnum="1">
		<wtc:param value="<%=sqlregC%>"/>
	</wtc:service>
	<wtc:array id="result_sqlregC" scope="end"/>
		

<%
String regCodegp="00";

if(result_sqlregC.length>0 )
{
		regCodegp=result_sqlregC[0][0];
}
/**
		20130219gaopeng�޸ģ�������ѯ��ǰ������ֻ�����Ĺ��������뵱ǰ��¼���ŵĹ������У����������а����ҵ��(����aaa8zy����)
		end
**/
%>


<HTML><HEAD>
<TITLE>�û������޸�
</TITLE><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
</HEAD>
<script language="javascript">
var printFlag=9;
var flag = 0;
onload=function(){
	
	self.status="";
	document.all.phoneNo.focus();
	/**
		20130219gaopeng�޸ģ�������ѯ��ǰ������ֻ�����Ĺ��������뵱ǰ��¼���ŵĹ������У����������а����ҵ��(����aaa8zy����)
		start
	**/
	/*alert("<%=regCodegp%>|haha");*/
	//alert("<%=pwrf%>");
	if("<%=region_codeT%>"!="<%=regCodegp%>" && "aaa8zy"!="<%=workNo%>"&& "200201"!="<%=workNo%>")
	{
		rdShowMessageDialog("����в�������л����޸ģ�",0);
		removeCurrentTab();
	}
	
	
	/**
		20130219gaopeng�޸ģ�������ѯ��ǰ������ֻ�����Ĺ��������뵱ǰ��¼���ŵĹ������У����������а����ҵ��(����aaa8zy����)
		end
	**/
}
function doProcess(packet){
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	/*alert(backString+"--"+cfmFlag);*/
	
		
	if(cfmFlag==99){
		if(backString==1){
			rdShowMessageDialog("��֤�ɹ���",2);
			document.frm.custName.value = document.frm.custNameHide.value;
			document.frm.submit.disabled=false;
			
		}else{
			rdShowMessageDialog("���벻��ȷ��",0);
			document.frm.submit.disabled=true;
		}
	}
	/*����s2417Cfm�ص�����*/
	if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			/*alert(errCode+"--"+errMsg);*/
			var errCodeInt = parseInt(errCode);
			if(errCodeInt==0){
				rdShowMessageDialog("�����ɹ���",2);
				document.frm.backLoginAccept.value=backString[0][0];
				
			
				if(document.frm.handFee.value!=0){
					printBill();
				}else{
					window.location="f2417.jsp?ph_no="+document.all.phoneNo.value+"&activePhone="+document.all.phoneNo.value;
				}
			}else{
				
				rdShowMessageDialog(errCode + " : " + errMsg,0);
				resett();
				return;
			}
	}
	if(cfmFlag==9){
		//rdShowMessageDialog("�ú��벻���ڣ�");
		var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog(errCode + " : " + errMsg,0);
		//document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				document.frm.phoneNo.disabled=false;
				flag=0;
				return;
	}
	if(cfmFlag==0){
	if(backString==""){
		rdShowMessageDialog("��ѯʧ�ܣ�",0);
		document.frm.qry.disabled=false;
		document.frm.phoneNo.disabled=false;
		document.frm.phoneNo.value="";
	}else{
	if(document.frm.favFlag.value==1){
		document.frm.submit.disabled=false;
	}
		document.frm.customPass.value=backString[0][4];
	
	document.frm.userId.value=backString[0][0];
	
	document.frm.runName.value=backString[0][6];
	
	document.frm.cardType.value=backString[0][15];
	
	document.frm.gradeName.value=backString[0][8];
	
	document.frm.custAddress.value=backString[0][11];
		document.frm.idCardNo.value=backString[0][14];
	
	document.frm.totalPrepay.value=backString[0][18];    //--17
		document.frm.totalOwe.value=backString[0][17]; //--16
	if("<%=pwrf%>"=="true"){
		var custNameA = backString[0][3];
		//alert(custNameA);
		var custNameCut = custNameA.substring(1,custNameA.length);
		var replaceN = "";
		if(custNameA.length - 1 == 1){
			replaceN = "*";
		}
		else if(custNameA.length - 1 == 2){
			replaceN = "**";
		}
		else if(custNameA.length - 1 == 3){
			replaceN = "***";
		}
		else{
			replaceN = "*";
		}
		//alert(replaceN+"---11");
		custNameA = custNameA.replace(custNameCut,replaceN);
		document.frm.custName.value=custNameA;
		document.frm.custNameHide.value=backString[0][3];
	}else if("<%=pwrf%>"=="false"){
			document.frm.custName.value=backString[0][3];
			document.frm.custNameHide.value=backString[0][3];
		}
	
	
	
   	document.frm.initPoint.value=backString[0][21];
   	
   	document.frm.currentPoint.value=backString[0][22];
   	
   	document.frm.yearPoint.value=backString[0][23];
   	
   	document.frm.addPoint.value=backString[0][24];
   	
   	document.frm.totalUsed.value=backString[0][25];
   	
   	document.frm.totalPrize.value=backString[0][26];
   	
   	document.frm.totalPunish.value=backString[0][27];
   	
   	document.frm.lastYearPoint.value=backString[0][28];
   	document.frm.asCustName.value=backString[0][30];
		document.frm.asCustPhone.value=backString[0][31];
		
		
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
			
			if(document.frm.asIdType.options[idI].value==backString[0][32]){
				document.frm.asIdType.options[idI].selected=true;
			}
		}
		document.frm.asIdIccid.value=backString[0][33];
		document.frm.asIdAddress.value=backString[0][34];
		document.frm.asContractAddress.value=backString[0][35];
		//alert(backString[0][36]);
		document.frm.asNotes.value=backString[0][36];
   	document.frm.basePoint.value=backString[0][29];
   	
	flag=1;
	
	document.frm.handFee.disabled=false;
	document.frm.factPay.disabled=false;
	
	}
}
	
}
function submitt(){
      if(document.frm.phoneNo.value==""){
      	rdShowMessageDialog("�������ֻ����룡",0);
      	return;
      }
      if(!checkElement(document.frm.phoneNo)){
			document.frm.phoneNo.value = "";
			return;
	}
      if(<%=high[0][0]%> ==0){
      	rdShowMessageDialog("�˹���û�в���Ȩ�ޣ�",0);
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
			myPacket= null;
			
		
}
	function getRemain()
	{

		if(flag!=1){
		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��",0);
		return;
		}
		
		
		if(parseFloat(document.frm.handFee.value) < parseFloat(document.frm.factPay.value)){
			rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFee.value,0);
			return;
		}
		
		document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
	}
function submitCfm(){

	getAfterPrompt();
	if(flag==1){
		if($("#startCust").val().length == 0 || $("#endCust").val().length == 0 ){
			rdShowMessageDialog("�����뿪ʼ����ʱ�䣡",0);
			return false;
		}
		if(document.frm.remark.value.length==0){
			document.frm.remark.value="�û������޸�";
		}	
		
		if(!forReal(document.frm.handFee)){
				return;
			}
			if(!forNonNegInt(document.frm.inpPoint)){
			return false;
		}
		var inputPoint = parseInt(document.frm.inpPoint.value);
		if(document.frm.inpPoint.value.length==0){
			rdShowMessageDialog("���������ͻ���.",0);
			return false;
		}
		if(!checkElement(document.frm.inpPoint)){
			return false;
		}
		if(inputPoint == 0){
			rdShowMessageDialog("���ͻ��ֲ���Ϊ�㣡",0);
			return false;
		}
		
		/*alert("<%=regCodegp%>---"+"<%=regCodegp2%>---"+"<%=regCodegp3%>");*/
		var monthAddPoints = "<%=regCodegp2%>".length>0 ? "<%=regCodegp2%>" : "0";
		var cfgPoints = "<%=regCodegp3%>".length>0 ? "<%=regCodegp3%>" : "0";
		/*alert(monthAddPoints);*/
		/*alert(cfgPoints);*/
		/*2013/2/22 ������ 10:58:55 gaopeng �����߼��жϣ����Ź������е� �����ۼ��޸Ļ���ֵ ���� ��ǰ�޸ĵĻ���ֵ ֮�� �� ���ñ���Ļ���ֵ ���Ա�*/
		if( monthAddPoints != "0" && cfgPoints != "0")
		{
			var regpointAll = parseInt(monthAddPoints);
			var regpointcfg = parseInt(cfgPoints);
			var regpoints = regpointAll + inputPoint;
			if(regpoints-regpointcfg>0)
			{
				rdShowMessageDialog("�õ��б��������޸Ļ�������Ϊ"+regpointcfg+"���֣�Ŀǰ���޸�"+regpoints+"���֣��ѳ��������޸����޲��������!",0);
				return false;
			}
			
		}
		var idJ = 0 ;
			var inputIdType = 0;
			for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
				if(document.frm.asIdType.options[idJ].selected==true){
					inputIdType = document.frm.asIdType.options[idJ].value;
				}
			}
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
			rdShowMessageDialog("�����Ѳ��ܴ���"+document.frm.handFeeT.value,0);
			return;
		}
			printCommit();
			if(printFlag!=1){
				return;
			}
			document.frm.submit.disabled=true;
			var myPacket = new AJAXPacket("f2417Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"�����ύ�����Ժ�......");
			
			myPacket.data.add("loginAccept",document.frm.loginAccept.value);
			myPacket.data.add("opCode",document.frm.opCode.value);
			myPacket.data.add("workNo",document.frm.workNo.value);
			myPacket.data.add("noPass",document.frm.noPass.value);
			myPacket.data.add("asIdType",inputIdType);
			myPacket.data.add("orgCode",document.frm.orgCode.value);
			myPacket.data.add("phoneNo",document.frm.phoneNo.value);
			myPacket.data.add("addPoint",document.frm.inpPoint.value);
			myPacket.data.add("handFee",document.frm.handFeeT.value);
			myPacket.data.add("factPay",document.frm.handFee.value);
			myPacket.data.add("jifentype",document.frm.jifentype.value);
	
			myPacket.data.add("ipAdd",document.frm.ipAdd.value);
			
			
			myPacket.data.add("startCust",document.frm.startCust.value);
			myPacket.data.add("endCust",document.frm.endCust.value);

	    	core.ajax.sendPacket(myPacket);
	    	myPacket = null;
	    	}else{
	    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��",0);
	    	}
    	
	}
function verifyPass(){
	if(flag==1){
		var m = document.frm.inputPass.value;
		var n = document.frm.customPass.value;
        	var myPacket = new AJAXPacket("verifyPass.jsp","�����ύ�����Ժ�......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
		
		
    	core.ajax.sendPacket(myPacket);

    	myPacket = null;
		
		
	}else{
    		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��",0);
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
document.frm.customPass.value="";
document.frm.inputPass.value="";
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
   	document.frm.initPoint.value="";
   	document.frm.currentPoint.value="";
   	document.frm.yearPoint.value="";
   	document.frm.addPoint.value="";
   	document.frm.totalUsed.value="";
   	document.frm.totalPrize.value="";
   	document.frm.totalPunish.value="";
   	document.frm.lastYearPoint.value="";
   	document.frm.basePoint.value="";

document.frm.cardType.value="";
printFlag=9;

flag=0;
}
</script>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<FORM action="" method=post name="frm"  onKeyUp="chgFocus(frm)">

<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">�û������޸�</div>
	</div>

     
        <table  cellspacing="0">
        <tbody>
              <tr> 
            <td class="blue" width="10%" > �û����� </td>
            <td class="blue" width="23%"  align=left>
              <input 
            id=Text2 type=text  name=phoneNo v_type="mobphone" v_name="�ƶ�����" maxlength=11 index="0"  onKeyUp="if(event.keyCode==13)submitt()" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly  Class="InputGrey">
            <input 
            id=Text2 type=button  name=qry value="��ѯ" onclick="submitt()" class="b_text">
            </td>
            <td class="blue" width="10%">�û����� </td>
            <td class="blue" colspan="3"> 
            <jsp:include page="/npage/common/pwd_one.jsp">
	      <jsp:param name="width1" value="16%"  />
	      <jsp:param name="width2" value="34%"  />
	      <jsp:param name="pname" value="inputPass"  />
	      <jsp:param name="pwd" value="12345"  />
 	      </jsp:include>
 	   
 	   
 	   
 	   <%if(favFlag==0){%>
            
            <input id=Text2 type=button  name=verifyPass1 value="��֤����" onclick="verifyPass()" class="b_text">
            
            <%}else{%>
            <input id=Text2 type=button  name=verifyPass1 value="��֤����" onclick="verifyPass()" disabled class="b_text">
            
            <%}%>
 	   
              </td>
            
            
          </tr>
          <tr> 
            <td class="blue" width="10%" >�û�I D</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2 type=text  name=userId   readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">��ǰ״̬</td>
            <td class="blue"  width="19%"> 
              <input  type=text  name=runName  readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">����</td>
            <td class="blue"  width="28%"> 
              <input  type=text  name=gradeName   readOnly  Class="InputGrey">
            </td>
          </tr>
              <tr> 
            <td class="blue" width="10%" > ��ǰԤ��</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2 type=text  name=totalPrepay  readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">��ǰǷ��</td>
            <td class="blue"  width="19%"> 
              <input 
            id=Text2 type=text  name=totalOwe  readOnly  Class="InputGrey">
            </td>
            <td class="blue"  width="10%">��ͻ���־</td>
            <td class="blue"  width="28%"> 
              <input  type=text  name=cardType readonly  Class="InputGrey" style="color:red">
            </td>
          </tr>
          <tr> 
            <td class="blue" width="10%" > �ͻ�����</td>
            <td class="blue" align=left width="23%" > 
              <input  id=Text2 type=text  name=custName   readOnly  Class="InputGrey">
               <input  id="Text222" type="hidden"  name="custNameHide"   readOnly  Class="InputGrey" >
            </td>
            <td class="blue"  width="10%">��ʹ�û���</td>
            <td class="blue"  width="19%"> 
              <input   id=Text2   name=initPoint   type="hidden"  >
			  <input  type=text  name=totalUsed  readOnly  Class="InputGrey">
            </td>
            <td class="blue"  width="10%">��ǰ����</td>
            <td class="blue"  width="28%"> 
              <input  type=text  name=currentPoint  readOnly  Class="InputGrey" >
            </td>
            
          </tr>
              <input   id=Text2  name=yearPoint   type="hidden">
              <input id=Text2   name=addPoint   type="hidden">
              <input  id=Text2  name=totalPunish   type="hidden">
              <input    name=lastYearPoint   type="hidden">
  
          <tr> 
            <td class="blue" width="14%" > �������ɻ���</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2 type=text  name=basePoint  readOnly  Class="InputGrey" >
            </td>
          
	        <td class="blue" width="14%" style="display:none"> �ܽ�������</td>
            <td class="blue" align=left width="23%" style="display:none"> 
              <input  id=Text2 type=text  name=totalPrize  >
            </td>	
            </div>	
            <td class="blue"  width="10%">���ͻ���</td>
            <td class="blue"  width="19%" > 
              <input id=Text2 type="text"  name="inpPoint" v_type="0_9"  v_name="���ͻ���" onblur='checkElement(this)' maxlength=9 index="2">
            </td>
            <td class="blue"  width="10%">��������</td>
              <td class="blue"  width="19%" > 
              	<select id=jifentype name=jifentype  >
              	
		  <option value="04">04-��������</option>
		  </select>
            </td>
          </tr>
      <tr>
      	<td class="blue">��ʼʱ��</td>
				<td>
						<input type="text" id="startCust" v_must="1"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" id="endCust" v_must="1"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
	
      </tr>
 		  <tr>
            <td class="blue" >ϵͳ��ע</td>
            <td>
 			<input id=Text2 type="text" size=40 name="asNotes"  maxlength=128 index="5" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');"></td>
 			<td colspan="4">
 				<font color="red">������볤��128</font>
 			</td>
          </tr>
           <tr style="display:none"> 
            
            <td class="blue" width="10%" > ����������</td>
            <td class="blue" align=left width="23%" > 
              <input id=Text2 type=text  name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            <td class="blue"  width="10%">��������ϵ�绰</td>
            <td class="blue"  width="19%"> 
              <input id=Text2 type=text  name=asCustPhone maxlength=20  >
            </td>
            <td class="blue"  width="14%">��ϵ��ַ</td>
            <td class="blue"  width="21%" colspan=2> 
              <input id=Text2 type=text  name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr style="display:none"> 
            <td class="blue" width="20%" > ������֤������</td>
            <td class="blue" align=left width="23%" > 
              <select size=1 name=asIdType  >
              <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
              <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
              <%}%>
              </select>
            </td>
            <td class="blue"  width="20%">֤������</td>
            <td class="blue"  width="19%"> 
              <input id=Text2 type=text  name=asIdIccid  maxlength=20>
            </td>
            <td class="blue"  width="24%">֤����ַ</td>
            <td class="blue"  width="19%" colspan=2> 
              <input id=Text2 type=text  name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr style="display:none"> 
            
            <td class="blue" width="10%" > ������ע</td>
            <td class="blue" align=left width="23%" > 
              <input 
            id=Text2a type=text size=30 name=asNotes1  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          </TBODY> 
        </TABLE>
        <TABLE cellSpacing="0"  style="display:none" >
          <TBODY> 
          <tr > 
            <td class="blue" width="10%" >������</td>
            <td class="blue" align=left width="23%" > 
              <input id=Text2 type=text  index="3" name=handFee <%if(feeFlag==0){%><%}%> value="<%=tHandFee%>" v_type=float v_name="������">
            </td>
            <td class="blue"  width="10%">ʵ��</td>
            <td class="blue"  width="19%" > 
              <input id=Text2 type=text  index="4" name=factPay  onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;
              <input id=Text2 type=button  name=getUseInfo value="-->" onclick="getRemain()" class="b_text">
            </td>
            <td class="blue"  width="13%">����</td>
            <td class="blue"  width="28%">
              <input id=Text2 type=text  name=remain  >
            </td>
          </tr>
		  <tr>
            <td class="blue" >ϵͳ��ע</td>
            <td>
 			<input id="Text3"	 type="text" size="60"  name="remark" value=""  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');"  readonly  Class="InputGrey">
 						
 						
          </tr>
          </TBODY> 
        </TABLE>

        <TABLE  cellSpacing="0">
          <TBODY>
            <TR >
              <td class="blue" align=middle id="footer">
              	<input name=submit  type=button value="ȷ��" onclick="submitCfm()" index="6" onKeyUp="if(event.keyCode==13){submitCfm()}" class="b_foot">
               &nbsp;&nbsp; 
              <input  name=back  type=button value="���" onclick="resett()" class="b_foot">
              &nbsp;&nbsp; 
              <input  name=back  type=button value="�ر�" onclick="removeCurrentTab()" class="b_foot">
            </TD>
            </TR>
          </TBODY>
        </TABLE>
<input type=hidden name=loginAccept value="<%=seq%>">
<input type=hidden name=opCode value="2417">


<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=sysRemark value="�û������޸�">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=favFlag value="<%=favFlag%>">
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
   document.all.sysRemark.value="�û�"+document.all.phoneNo.value+"�����޸�";
   if((document.all.asNotes.value).trim().length==0)
   {
	  document.all.asNotes.value="����Ա<%=workName%>"+"���û�"+document.all.phoneNo.value+"���л����޸�"
   }
   //��ʾ��ӡ�Ի��� 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =document.frm.loginAccept.value;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
     
   	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	//	alert(path);
	//	return false;
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
	
  	var retInfo = "";
	var note_info1 = "";
	var note_info2 = "";
	var note_info3 = "";
	var note_info4 = "";
	var opr_info = "";
	var cust_info = "";
		
    if(printType == "Detail")
    {
      cust_info+="�ͻ�������" +document.all.custNameHide.value+"|";
      cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.custAddress.value+"|";
      cust_info+="֤�����룺"+document.all.idCardNo.value+"|";

      opr_info+="��ǰ���֣�"+document.frm.currentPoint.value+"|";
      opr_info+="�û������޸ġ�*�����ѣ�"+document.frm.handFee.value+"|";

      note_info1+="��ע��"+document.all.remark.value+"|";
      note_info1+=""+document.all.asNotes.value+"|"; 

    }  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
    }
    
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
}
</script>
<script>
function printBill(){
	  var infoStr="";  
	  var retInfo = "";
	  retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.custNameHide.value+"|";
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
      retInfo+="�û������޸ġ�*�����ѣ�"+document.frm.handFee.value+"*��ˮ�ţ�"+document.frm.backLoginAccept.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=document.all.remark.value+"|";
      retInfo+=document.all.asNotes.value+"|"; 
      location="<%=request.getContextPath()%>/npage/innet/chkPrintNew.jsp?retInfo="+retInfo+"&dirtPage=<%=request.getContextPath()%>/npage/s2417/f2417.jsp?activePhone=<%=activePhone%>";
}
</script>
</BODY></HTML>
