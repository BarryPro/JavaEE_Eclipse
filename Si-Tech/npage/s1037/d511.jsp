<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<%
String querysql = "select to_char(rate_id),rate_name,to_char(rate_num) from saccounts_rate ";
%>
<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode3" retmsg="retMsg3" outnum="3">
	<wtc:sql><%=querysql%></wtc:sql>
	</wtc:pubselect>
		
	<wtc:array id="result0" start="0" length="3" scope="end" />
<%	
	
	if(result0==null||result0.length==0){
		System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			 
			rdShowMessageDialog("����δ�ܳɹ�,������Ϣ����ѯ�����������ϢΪ��!");
			history.go(-1); 
		</script>
	<%}
 
	// System.out.println("qweqwe1111111111111111111111111111111111111111111");
 

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-IP PBXҵ��¼��</title>
<%
    //String opCode="8379";
	//String opName="����Ԥ���";
	
    String opCode="d511";
	String opName="IP PBX������Ϣ�޸�";
	 
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
   
%>

 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
 function getData(){
	alert("��ȡ�ϸ��¼�¼");
 }
 
  //����ȫ�ֱ���
  var project_code = new Array();
  var transin_fee = new Array();//where����  
  var transin_fee1 = new Array();//
	 
<%
	//System.out.println("qweqwe1888888888888888888888888888881111111111111lengt is "+result0.length+" and result0  is "+result0[0][0]);
	if(result0.length >0){
		for(int m=0;m<result0.length;m++)
		  {
			out.println("project_code["+m+"]='"+result0[m][0]+"';\n");
			out.println("transin_fee["+m+" ]='"+result0[m][1]+"';\n");
			out.println("transin_fee1["+m+"]='"+result0[m][2]+"';\n");
		  }
	}
	else{
	//System.out.println("qweqwe9888800000000000000000111");
	}
	


%> 
 
/* xl ��̨�Ӻ��Ļ��� selectid projeccode trans_Fee*/
 function chkType(choose,ItemArray,GroupArray,GroupArray1)
 {
 	document.getElementById("cz").value ="";
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	   {
		/*  alert(ItemArray[x]);
		  alert(choose.value);
		  alert(GroupArray[x]);*/
		  if ( ItemArray[x] == choose.value )
		  {
		  //  alert('111 -> '+GroupArray1[x]);
		   document.getElementById("cz").value = GroupArray1[x];
		  }
	   }
  } 
//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����
//	if(!check(frm)) return false; 
	//alert('11111 '+document.frm.opcode.value);
	if(document.all.opcode.value=="b894"){
		frm.action="fb894_1.jsp";
	}
	if(document.all.opcode.value=="b941"){
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			frm.action="fb941_1.jsp";
		}
	}
	
	
 
			
		
  
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange()
{
	 
	 if(document.all.opFlag[0].checked==true) 
	{
	   
		document.frm.opcode.value = "d510";
		window.location.href='d510.jsp';

	}else {
		 
	  	document.frm.opcode.value = "d511";
		window.location.href='d511.jsp';
	}
}
function init(){
//1.ÿ��1-5�� ��¼�롢�޸��������룻 ��ʱ��ֻ�ܲ鿴
//�����ж�ʱ�� ͨ�������document.all.zjxts.readOnly  = true;
var date = new Date();
var day = date.getDate();
if(day > 5){
//document.all.query_do.disabled   = true;
}
//alert(day);
 document.frm.custid.focus();
}
//
function calRate(){
	 
	var zsr = document.frm.zsr.value;
	 
	var rates = document.getElementById("cz").value;
	var   select_rate   =   document.getElementById("rateid") ;
	
    var   index   =   select_rate.selectedIndex; 
	//alert(index);
 var   select_value   =   select_rate.options[index].value;   
  var   select_text     =   select_rate.options[index].text;
  if(select_value=="0"){
	  rdShowMessageDialog("��ȷ�Ͻ������!");
	  document.getElementById("rateid").focus();
  }
  else if(zsr ==""){
	  rdShowMessageDialog("������������!");
	  document.frm.zsr.focus();
  }
  else{
	   var jssr = parseFloat(zsr)*parseFloat(rates);
	 // alert("jssr is "+jssr.toFixed(2));
	   
	  document.frm.jssr.value = jssr.toFixed(2);
	  var new_jfje = parseFloat(zsr);
	  document.frm.zsr.value = new_jfje.toFixed(2);
  }
	
	//alert("jssr is "+jssr);
    
}
//commit�ύ
function commit()
{
	var custid = document.frm.custid.value;
	var custname = document.frm.custname.value;
	var zjxts = document.frm.zjxts.value;
	//var custid = document.frm.custid.value;//���������ô�㣿
    var   select_rate   =   document.getElementById("rateid") ;
	
    var   index   =   select_rate.selectedIndex; 
	//alert(index);
 var   select_value   =   select_rate.options[index].value;   
  var   select_text     =   select_rate.options[index].text;
//alert("select_value is "+select_value+" and select_text is "+select_text);
	var local = document.frm.local.value;
	var longs = document.frm.longs.value;
	var jfje = document.frm.jfje.value;
	var zsr = document.frm.zsr.value;
	var jssr = document.frm.jssr.value;
	var pbx_num = document.frm.pbx_num.value;
	var real_num = document.frm.real_num.value;
	var total_mins = document.frm.total_mins.value;
	var rentfee = document.frm.rentfee.value;
	var funcfee = document.frm.funcfee.value;
	var localincome = document.frm.localincome.value;
	var longincome = document.frm.longincome.value; 
//���ƣ�1.ÿ��1-5�� ��¼�롢�޸��������룻 ��ʱ��ֻ�ܲ鿴 ok
//2.��Ϣ�޸� ֻ���Ըñ��µ�
//3.����������¼��
//���� ��������
	
	if(custid == ""){
		rdShowMessageDialog("������ͻ�id!");
		document.frm.custid.focus();
	}
	else if(custname == ""){
		rdShowMessageDialog("����ݿͻ�idѡ���ſͻ�����!");
		document.frm.custname.focus();
	}
	else if(zjxts == ""){
		rdShowMessageDialog("�������м�������!");
		document.frm.zjxts.focus();
	}
	else if(select_value == "0"){
		rdShowMessageDialog("��ѡ��������!");
		 document.getElementById("rateid").focus();
	}
	else if((local == "" ||local == "0") && (longs == "" ||longs == "0")  ){
		rdShowMessageDialog("�����뱾��ͨ����;ͨ��������!");
		document.frm.local.focus();
	}
	 
 
	else if(jfje == ""){
		rdShowMessageDialog("������ɷѽ��!");
		document.frm.jfje.focus();
	}
    else if(zsr == ""){
		rdShowMessageDialog("������������!");
		document.frm.zsr.focus();
	}
	else if(jssr == ""){
		rdShowMessageDialog("��ȷ����������!");
		document.frm.jssr.focus();
	}
	//new ��������ʼ
	else if(pbx_num == ""){
		rdShowMessageDialog("������IP_PBX����!");
		document.frm.pbx_num.focus();
	}
	else if(real_num == ""){
		rdShowMessageDialog("������ʵ�ʿ�ͨ����!");
		document.frm.real_num.focus();
	}
	else if(parseInt(real_num) > parseInt(pbx_num) ){
		rdShowMessageDialog("ʵ�ʿ�ͨ�������ܴ���IP_PBX����!");
		document.frm.real_num.focus();
	}
	else if(total_mins == ""){
		rdShowMessageDialog("��ȷ����ͨ��������!");
		document.frm.total_mins.focus();
	}
	else if(rentfee == ""){
		rdShowMessageDialog("�������м������!");
		document.frm.rentfee.focus();
	}
	else if(funcfee == ""){
		rdShowMessageDialog("�����빦�ܷ�!");
		document.frm.funcfee.focus();
	}
	else if(localincome == ""){
		rdShowMessageDialog("�����뱾������!");
		document.frm.localincome.focus();
	}
	else if(longincome == ""){
		rdShowMessageDialog("�����볤;����!");
		document.frm.longincome.focus();
	}
	//end ��������
	else
    {
	//	alert("���÷��񣬲����SPBX_GROUPINFO~");
		document.frm.jfje.value =  parseFloat(jfje).toFixed(2);
		if(rdShowConfirmDialog('ȷ��Ҫ�޸ĸ���Ϣ��')==1)
		{
			document.frm.action="supdate_d511.jsp?rateId="+select_value;
			document.frm.submit();
		}
		
	}
	
}
function doclear(){
	 document.frm.custid.value= "";
	 document.frm.custname.value= "";
	 document.frm.zjxts.value= "";
	 document.frm.local.value= "";
	 document.frm.longs.value= "";
     document.frm.jfje.value= "";
	 document.frm.zsr.value= "";
	 document.frm.jssr.value= "";
	 //add new
	 document.frm.pbx_num.value= "";
	 document.frm.real_num.value= "";
	 document.frm.funcfee.value= "";
	 document.frm.rentfee.value= "";
	 //end new
	 document.getElementById("rateid").options[0].selected = true;
	 document.frm.total_mins.value= "";
	 document.frm.localincome.value= "";
	 document.frm.longincome.value= "";

}
function selectCust(){
	var custid = document.frm.custid.value;
	var  returnValue =""; 
	if(custid == ""){
		rdShowMessageDialog("������ͻ�id!");
	}
	else
	{
		
		returnValue=window.showModalDialog('getCustName.jsp?custid='+custid);
		//alert("1111111returnValue is "+returnValue);
		if( returnValue == null )
		{
			rdShowMessageDialog("û���ҵ���Ӧ�ļ������ƣ�",0);
			document.frm.custid.focus();
			return false;
		}
		document.frm.custname.value = returnValue;
		
	}

    
}
 
function doProcess(packet){
	//alert("r11111111ok");
	var zjxts = packet.data.findValueByName("zjx_num");
	var pay_money = packet.data.findValueByName("pay_money");
	var count_money = packet.data.findValueByName("count_money");
	var total_money = packet.data.findValueByName("total_money");
	var CUST_NAME = packet.data.findValueByName("CUST_NAME");
	var LOCAL_TIMES = packet.data.findValueByName("LOCAL_TIMES");
	var LOCALLONG = packet.data.findValueByName("LOCALLONG");
	var retCode1 = packet.data.findValueByName("retCode1");
	var rate_num = packet.data.findValueByName("rate_num");
	var date1 = packet.data.findValueByName("date1");
	//xl ��������
	var pbx_num = packet.data.findValueByName("pbx_num");
	var real_num = packet.data.findValueByName("real_num");
	var rent_fee = packet.data.findValueByName("rent_fee");
	var func_fee = packet.data.findValueByName("func_fee");
	var total_mins = packet.data.findValueByName("total_mins");
	var local_income = packet.data.findValueByName("local_income");
	var long_income = packet.data.findValueByName("long_income");
	//end ��������
	//var date1 = "5";
	if(date1 > 5){
		//alert("����5�ţ������޸ģ�Ϊ���Կ��ã���ʽ���߻���ϡ�");
		//document.all.query_do.disabled   = true;
	}
	//
	//  alert('date is '+date1);
	//begin ��������
	document.frm.pbx_num.value = pbx_num;
	document.frm.real_num.value = real_num;
	document.frm.rentfee.value = rent_fee;
	document.frm.funcfee.value = func_fee;
	//end ��������
	document.frm.custname.value = CUST_NAME;
	document.frm.zjxts.value = zjxts;
	document.frm.local.value =LOCAL_TIMES ;
	 document.frm.longs.value = LOCALLONG;
	 document.frm.jfje.value = pay_money;
	 document.frm.zsr.value =total_money ;
	 document.frm.jssr.value = count_money;
	 document.getElementById("cz").value=rate_num;
	 document.frm.total_mins.value = total_mins;
	 document.frm.localincome.value = local_income;
	 document.frm.longincome.value = long_income;
	 
	 
}
function getInfo(){
	var custid = document.frm.custid.value;
	 
	var myPacket = new AJAXPacket("getInfoForUpdate.jsp?custid="+custid,"���ڲ�ѯ�����Ժ�......");
	 
	core.ajax.sendPacket(myPacket);
	 
	myPacket = null;
}
function getdates(){
	var custid = document.frm.custid.value;
	 
	var myPacket = new AJAXPacket("getInfoForUpdate.jsp?custid="+custid,"���ڲ�ѯ�����Ժ�......");
	 
	core.ajax.sendPacket(myPacket);
	 
	myPacket = null;
}
function getSel2(){
	var custid = document.frm.custid.value;
	var  returnValue =""; 
	var   select_rate   =   document.getElementById("rateid") ;
	var   index   =   select_rate.selectedIndex; 
	if(custid == ""){
		rdShowMessageDialog("������ͻ�id!");
		document.frm.custid.focus();
	}
	else
	{
		
		returnValue=window.showModalDialog('getSelForUpdate.jsp?custid='+custid);
		
		if( returnValue != null )
		{
			index = returnValue;
			select_rate.options[index].selected  = true;
			//alert("1111111sindex is "+index);
			getInfo();
		}
		else
		{
			rdShowMessageDialog("δ�ҵ��ü��ű���¼����Ϣ!");
			document.frm.custid.value= "";
			document.frm.custid.focus();
			doclear();
			return false;
		}
		 
		
	}
}
//���� ��ͨ����������
function calMins()
{
	var localMins = document.frm.local.value;
	var longMins =  document.frm.longs.value;
	var totalMins = document.frm.total_mins.value;
	//alert("localMins is "+localMins+" and longMins is "+longMins);
	if((localMins == "") && (longMins == "") )
	{
		rdShowMessageDialog("�����뱾��ͨ����;ͨ��������!");
		return false;
	}
	if(localMins == ""  )
	{
		localMins = "0.00";
	}
	if(longMins == ""  )
	{
		longMins = "0.00";
	}
	//alert("test localMins is "+parseInt(localMins)+" and longMins is "+parseInt(longMins));
	totalMins = parseInt(localMins)+parseInt(longMins);
	document.frm.total_mins.value = totalMins;

}
//�Զ�����
function fix_localincome()
{
	if(document.frm.localincome.value!="")
	{
		var num_fix = parseFloat(document.frm.localincome.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.localincome.value = num_fix.toFixed(2);
	}
	
}
function fix_longincome()
{
	if(document.frm.longincome.value!="")
	{
		var num_fix = parseFloat(document.frm.longincome.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.longincome.value = num_fix.toFixed(2);
	}
	
}
function fix_zsr()
{
	if(document.frm.zsr.value!="")
	{
		var num_fix = parseFloat(document.frm.zsr.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.zsr.value = num_fix.toFixed(2);
	}
	
}
function fix_rentfee()
{
	if(document.frm.rentfee.value!="")
	{
		var num_fix = parseFloat(document.frm.rentfee.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.rentfee.value = num_fix.toFixed(2);
	}
	
}
function fix_funcfee()
{
	if(document.frm.funcfee.value!="")
	{
		var num_fix = parseFloat(document.frm.funcfee.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.funcfee.value = num_fix.toFixed(2);
	}
	
}
function fix_jfje()
{
	if(document.frm.jfje.value!="")
	{
		var num_fix = parseFloat(document.frm.jfje.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.jfje.value = num_fix.toFixed(2);
	}
	
}
function fix_jssr()
{
	//��Ϊ1.123 ����ʾ
	var paymoney=document.frm.jssr.value;
	var temp = "";
	if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length> 2 )
				{
					rdShowMessageDialog("��������С�����ֻ������2λ��");
					document.frm.jssr.focus();
					return false;
				}
			}
	//var vArr = document.frm.jssr.value.match(/^[0-9]+$/); 
	//��Ϊ���� ���� ֻ����һλ����ô����?
	//if(vArr!=null)
	if(document.frm.jssr.value!="")
	{
		var num_fix = parseFloat(document.frm.jssr.value);
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
		document.frm.jssr.value = num_fix.toFixed(2);
	}
	
	
}
function CalZero()
{
	document.frm.total_mins.value = "";
}
</script>

<%
//���ݽ������ �����������
String querysql_rate = "select rate_num from saccounts_rate ";

%>
</head>
<body onload ="init()">
<form name="frm" method="POST" onKeyUp="chgFocus(frm)" >
 	<input type="hidden" name="opcode" value = "d510" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr colspan = 2>
		<td class="blue" colspan = 2  >�������� &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="one"   onclick = "opchange()"  >IP PBXҵ��¼��&nbsp;&nbsp;
			<!--xl �¼ӳ���--> 
			<input type="radio" name="opFlag" value="two"   onclick = "opchange()" checked = "checked">IP PBX�����޸�
		</td>
	</tr>    
	 <tr colspan = 2>
    	<td align="left" class="blue"  >�ͻ�����:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="custid" id = "custid1" size="20"  onKeyPress="return isKeyNumberdot(0)">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="query" class="b_text" value="��ѯ" onclick="getSel2()" ></td>
	<td align="left" class="blue"  >���ſͻ�����:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="custname" maxsize="200" readonly  >
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
   <tr colspan = 2>
    	<td align="left" class="blue"  >�м�������: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="zjxts" size="20"   onKeyPress="return isKeyNumberdot(0)">
        &nbsp;&nbsp;&nbsp;
		</td>
	<td align="left" class="blue"  >�������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <select id=rateid name=rate  style="width:150px;" onChange="chkType(this,project_code,transin_fee,transin_fee1)"  >
				<option value = "0" selected>��ѡ�������� </option>
				<%
					if(result0.length > 0){
				 	 
						for(int k =0;k<result0.length;k++)
						{%>
							<option value="<%=result0[k][0]%>"><%=result0[k][1]%></option>
							 
						<%}
					}
					else{
						 %><script language= "javascript">alert("����Ϣ");</script><%
						
					}	
						%>
			</select>
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
    <tr colspan = 2>
    	<td align="left" class="blue"  >IP PBX����:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="pbx_num" size="20" onKeyPress="return isKeyNumberdot(0)"   >
        &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
		</td>
	<td align="left" class="blue"  >ʵ�ʿ�ͨ����:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="real_num" size="20" onKeyPress="return isKeyNumberdot(0)"   >
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
  
    <tr colspan = 2>
    	<td align="left" class="blue"  >����ͨ��������:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="local" size="20" onKeyPress="return isKeyNumberdot(0)" onblur=CalZero()  >
        &nbsp;&nbsp;&nbsp;
		</td>
	<td align="left" class="blue"  >��;ͨ��������:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="longs" size="20" onKeyPress="return isKeyNumberdot(0)" onblur=CalZero()  >
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
    <tr colspan = 2>
    	<td align="left" class="blue"  >��ͨ��������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" readonly type="text" name="total_mins" size="20" onKeyPress="return isKeyNumberdot(0)"   >
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="queryrate" class="b_text" value="����" onclick="calMins()" >
		</td>
	<td align="left" class="blue"  >�ɷѽ��:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="jfje" size="20"   onKeyPress="return isKeyNumberdot(1)" onblur = fix_jfje() >
        &nbsp;&nbsp;&nbsp;
		</td>
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
   <tr colspan = 2>
    	<td align="left" class="blue"  >�м������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="rentfee" size="20" onKeyPress="return isKeyNumberdot(1)" onblur = fix_rentfee()   >
        &nbsp;&nbsp;&nbsp;
		</td>
	<td align="left" class="blue"  >���ܷ�:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="funcfee" size="20" onKeyPress="return isKeyNumberdot(1)" onblur=fix_funcfee()   >
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
   <tr colspan = 2>
    	<td align="left" class="blue"  >��������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="localincome" size="20" onKeyPress="return isKeyNumberdot(1)" onblur="fix_localincome()"  >
        &nbsp;&nbsp;&nbsp;
		</td>
	<td align="left" class="blue"  >��;����:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="longincome" size="20" onKeyPress="return isKeyNumberdot(1)" onblur=fix_longincome()  >
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
   <tr colspan = 2>
		<td align="left" class="blue"  >��������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="button" type="text" name="zsr" size="20" onKeyPress="return isKeyNumberdot(1)" onblur=fix_zsr() >
			&nbsp;&nbsp;&nbsp;
		</td>
    	<td align="left" class="blue"  >��������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="jssr" size="20"   onKeyPress="return isKeyNumberdot(1)" onblur=fix_jssr()>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="queryrate" class="b_text" value="����" onclick="calRate()" >
        &nbsp;&nbsp;&nbsp;
		</td>
		 	 
   </tr><input type="hidden" name="cz1" id="cz" size="20"  > 
   
</table>
<table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query_do" class="b_foot" value="��Ϣ�޸�" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		   
       </td>
    </tr>
  </table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
