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
<%@ include file="/npage/common/popup_window.jsp" %>
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
	
    String opCode="d510";
	String opName="IP PBXҵ��¼��";
	 
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
function init()
{
  document.frm.custid.focus();
}
//
function calRate(){
	 
	var zsr = document.frm.zsr.value;
	 
	var rates = document.getElementById("cz").value;
	var   select_rate   =   document.getElementById("rateid") ;
	
    var   index   =   select_rate.selectedIndex; 
	//alert('index is '+index);
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
	  //alert('rates is  '+rates);	
	  //document.frm.zsr.value = zsr.toFixed(2) 
	  document.frm.jssr.value = jssr.toFixed(2);
	  var new_jfje = parseFloat(zsr);
	  document.frm.zsr.value = new_jfje.toFixed(2);
  }
	
	//alert("jssr is "+jssr);
    
}
//���� ��ͨ����������
function calMins()
{
	var localMins = document.frm.local.value;
	var longMins =  document.frm.longs.value;
	var totalMins = document.frm.total_mins.value;
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
	totalMins = parseInt(localMins)+parseInt(longMins);
	document.frm.total_mins.value = totalMins;

}
//commit�ύ
function commit()
{
	//getAfterPrompt();
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
	//�������� begin
	var pbx_num = document.frm.pbx_num.value;
	var real_num = document.frm.real_num.value;
	var total_mins = document.frm.total_mins.value;
	var rentfee = document.frm.rentfee.value;
	var funcfee = document.frm.funcfee.value;
	var localincome = document.frm.localincome.value;
	var longincome = document.frm.longincome.value;
 
	//�������� end
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
	else
    {
	//	alert("���÷��񣬲����SPBX_GROUPINFO~");
		document.frm.jfje.value =  parseFloat(jfje).toFixed(2);

		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			document.frm.action="sinsert_d510.jsp?rateId="+select_value;
			document.frm.submit();
		}
		
	}
	
}
function doCheck()
{
	var paymoney;
	var temp ;
	with(document.frm)
	{
		paymoney = payMoney.value;
		if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length> 2 )
				{
					rdShowMessageDialog("�ɷѽ��С�����ֻ������2λ��");
					payMoney.focus();
					return false;
				}
			}
	}
}
function selectCust(){
	var custid = document.frm.custid.value;
	var  returnValue =""; 
	if(custid == ""){
		rdShowMessageDialog("������ͻ�id!");
		document.frm.custid.focus();
	}
	else
	{
		
		returnValue=window.showModalDialog('getCustName.jsp?custid='+custid);
		//alert("1111111returnValue is "+returnValue);
		if( returnValue == null )
		{
			rdShowMessageDialog("û���ҵ���Ӧ�ļ������ƣ�",0);
			document.frm.custname.value="";
			document.frm.custid.value="";
			document.frm.custid.focus();
			return false;
		}
		document.frm.custname.value = returnValue;
		//ʹ��ajaxȡ����ֵ ֮ǰ��getSel2();
		getInfo();
		
	}

    
}
function getInfo(){
	var custid = document.frm.custid.value;
	 
	var myPacket = new AJAXPacket("getSel.jsp?custid="+custid,"���ڲ�ѯ�����Ժ�......");
	 
	core.ajax.sendPacket(myPacket);
	 
	myPacket = null;
}
function doProcess(packet){
	//alert("r11111111ok");
	var zjxts = packet.data.findValueByName("zjx_num");
	var pbx_line_num = packet.data.findValueByName("pbx_line_num");
	var pbx_real_num = packet.data.findValueByName("pbx_real_num");

	var rate_id = packet.data.findValueByName("rate_id");
	 
	var   select_rate   =   document.getElementById("rateid") ;
	var   index   =   "";
	if(rate_id == ""){
		index = 0;
	}
	else{
		index   = rate_id;
	}
	
	select_rate.options[index].selected  = true;
	var retCode1 = packet.data.findValueByName("retCode1");
	var rate_num = packet.data.findValueByName("rate_num");
	var date1 = packet.data.findValueByName("date1");
	 
	 
	//
	//  alert('date is '+date1);
	//document.frm.custname.value = CUST_NAME;
	document.frm.zjxts.value = zjxts;
	 
	 document.getElementById("cz").value=rate_num;
	 //xl add ��������
	 var rent_fee = packet.data.findValueByName("rent_fee");
	 document.frm.rentfee.value = rent_fee;
	 var func_fee = packet.data.findValueByName("func_fee");
	 document.frm.funcfee.value = func_fee;
	 var pbx_line_num = packet.data.findValueByName("pbx_line_num");
	 document.frm.pbx_num.value = pbx_line_num;
	 var pbx_real_num = packet.data.findValueByName("pbx_real_num");
	 document.frm.real_num.value = pbx_real_num;
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
	 document.getElementById("rateid").options[0].selected = true;
	 //add new
	 document.frm.pbx_num.value= "";
	 document.frm.real_num.value= "";
	 document.frm.funcfee.value= "";
	 document.frm.rentfee.value= "";
	 document.frm.total_mins.value= "";
	 document.frm.localincome.value= "";
	 document.frm.longincome.value= "";
	 //end new

}
function getNums(){
	var custid = document.frm.custid.value;
	var  returnValue =""; 
	 
	if(custid == ""){
		rdShowMessageDialog("������ͻ�id!");
	}
	else
	{
		
		returnValue=window.showModalDialog('getInfo.jsp?custid='+custid);
		
		if( returnValue != null )
		{
			document.frm.zjxts.value = returnValue;
			
		}
		//alert("1111111returnValue is "+returnValue);
		//document.frm.custname.value = returnValue;
		
	}
}
function getSel2(){
	var custid = document.frm.custid.value;
	var  returnValue =""; 
	var   select_rate   =   document.getElementById("rateid") ;
	var   index   =   select_rate.selectedIndex; 
	if(custid == ""){
		rdShowMessageDialog("������ͻ�id!");
	}
	else
	{
		
		returnValue=window.showModalDialog('getSel.jsp?custid='+custid);
		
		if( returnValue != null )
		{
			index = returnValue;
			select_rate.options[index].selected  = true;
			getNums();

		}
		 
		
	}
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
<!--
//�ж� v �Ƿ�������
function IsInt(v)
{
    var vArr = v.match(/^[0-9]+$/);
    if (vArr == null)
    {
        return false;//��������
    }
    else
    {
        return true; //������
    }
}

-->
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
			<input type="radio" name="opFlag" id="type1" value="one"   onclick = "opchange()" checked = "checked" >IP PBXҵ��¼��&nbsp;&nbsp;
			<!--xl �¼ӳ���--> 
			<input type="radio" name="opFlag" id="type2" value="two"   onclick = "opchange()">IP PBX�����޸�
		</td>
	</tr>    
	 <tr colspan = 2>
    	<td align="left" class="blue"  >�ͻ�����:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="custid" id = "custid1" size="20"  onKeyPress="return isKeyNumberdot(0)">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="query" class="b_text" value="��ѯ" onclick="selectCust()" ></td>
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
              <input type="button" name="query_do" class="b_foot" value="��Ϣ¼��" onclick="commit()" >
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
