<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �ͷ�������Ӫָ����ϵ
�� * �汾: 1.0.0
�� * ����: 2009/08/09
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String boss_login_no =  request.getParameter("boss_login_no");
%>
<html>
<head>
<title>�ͷ�������Ӫָ����ϵ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  * 
  */
function addsceTrans(){
	 
	if(!check(sitechform))
	{
		return false;
	}
	
	var xinval="";
	var yinval="";
  
	for(var i=0;i<83;i++)
	{
			 xinval+=$("input")[i].value+",";
  }
  
  
	var packet = new AJAXPacket("k199_sceTrans_rpc.jsp","...");
	packet.data.add("retType","addsceTrans");
	packet.data.add("addvalxin" ,xinval);
 
  
	
	core.ajax.sendPacket(packet,doProcessaddsceTrans,true);
	packet=null;
}

/**
  *���ش�����
  */
function doProcessaddsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("�������ݳɹ���");		
    closeWin();
	} else {
		rdShowMessageDialog("��������ʧ�ܣ�");

	}
}

// �������¼
function genid(){
		var ACCESSCODE = document.getElementById("ACCESSCODE").value;
  	var city_code = document.getElementById("city_code").value;
  	var user_class = document.getElementById("user_class").value;
  	var DIGITCODE = document.getElementById("DIGITCODE").value;
  	
  		document.sitechform.ID.value = ACCESSCODE + city_code+user_class+DIGITCODE;
  		document.sitechform.SUPERID.value = document.sitechform.ID.value.substr( 0,document.sitechform.ID.value.length -1);

}

// �������¼
function cleanValue(){
			var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			}   
}

function closeWin(){
	window.close();
}

function initValue(){

}

</script>
</head>

<body >
<form id="sitechform" name="sitechform">
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">�ͷ�������Ӫָ����ϵ</div></div>
		<table>
	 <TR class=content2>
          <TD></TD>
          <TD noWrap>����ָ��</TD>
          <TD noWrap>���</TD>
        </TR>
        
        <TR class=content3>
          <td noWrap rowSpan=10>��Ա����</TD>
          <td noWrap>Ա�������<font color=#ff0000 
            >*</FONT></TD></TD>
          <td><input class=form1 id=text1 
            v_must=1 type=text size=18 value = 0 >
          <!-- <input class=form1 id=btnGetNewCommonInfo type=button title="��ȡ��ǰ������Ϣ��ͬ����������Ϣ" value=ͬ��>--></TD>
        </TR>
        
        <TR class=content2>
          <td noWrap>������ʧ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text2 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
        <TR class=content3>
          <td noWrap>������ʧ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text3 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
        <TR class=content2>  
          <td noWrap>��Ա��Ƹ��ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text4 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
        <TR class=content3>
          <td noWrap>���ڼ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text5 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
        <TR class=content2>   
          <td noWrap>��Ա��ת���ʣ��ϸ��ʣ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text6 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
        <TR class=content3>   
          <td noWrap>��ѵ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text7 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
        <tr class=content2>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >��ѵ��ʱ�����</FONT>*</FONT> </TD>
          <td noWrap><input class=form1 id=text8 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
        
        <tr class=content3>    
          <td noWrap>��ѵ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text9 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
        <tr class=content2>    
          <td noWrap>��ѵ�ϸ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text10 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
         
        <TR class=content2>
          <td noWrap rowSpan=9>��������</TD>    
          <td noWrap>�ͻ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text11 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
        <TR class=content3>    
          <td noWrap>�һ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text12 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
        <tr class=content2>    
          <td noWrap>�����ۺϵ÷�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text13 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
        <tr class=content3>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >�˹���������</FONT>*</FONT></TD>
          <td noWrap><input class=form1 id=text14 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
         <tr class=content2>   
          <td noWrap>һ�ν����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text15 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
         <tr class=content3>   
          <td noWrap>�ʼ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text16 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
            
        <tr class=content2>
          <td noWrap>������ʱ��<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text17 
            v_must=1 type=text size=18 value = 0 ></TD></TR>
            
         <tr class=content3>
          <td noWrap>����������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text18 
            v_must=1 type=text size=18 value = 0 > </TD></TR>
          
         <tr class=content2>
          <td noWrap>����Ͷ����<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text19 
            v_must=1 type=text size=18 value = 0 ></TD></TR> 
         
         <tr class=content3>
          <td noWrap rowSpan=12>�ɱ�����</td>
          <td noWrap>��Ӫ�ܳɱ�<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text20
            v_must=1 type=text size=18 value = 0 ></TD></tr>
            
         <tr class=content2>  
          <td noWrap>��Ӫ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text21 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
          
         <tr class=content3>  
          <td noWrap>����Ӫ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text22 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
         
         <tr class=content2>  
          <td noWrap>�˾�����Ӫ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text23 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
            
         <tr class=content3>  
          <td noWrap>Ӫ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text24 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
         
         <tr class=content2>  
          <td noWrap>�˾�Ӫ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text25 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>��ϯ���������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text26 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
            
         <tr class=content2>  
          <td noWrap>��ϯ���ƽ��ÿ�ͻ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text27 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
         
         <tr class=content3>  
          <td noWrap>ƽ�������ɱ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text28 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ���˹�����ɱ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text29 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
            
         <tr class=content3>  
          <td noWrap>ƽ��ÿ�ͻ�����ɱ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text30 
            v_must=1 type=text size=18 value = 0 > </TD></tr>            
         
         <tr class=content2>  
          <td noWrap>���Ӫ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text31 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
            
         <tr class=content2>  
          <td noWrap rowSpan=7>Ͷ�߹���</td>
          <td noWrap>Ͷ�߹����ϸ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text32 
            v_must=1 type=text size=18 value = 0 > </TD></tr>      
         
         <tr class=content3>  
          <td noWrap>Ͷ�ߴ���ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text33 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>Ͷ���ɵ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text34 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>Ͷ�ߵ绰��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text35 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
         <tr class=content2>  
          <td noWrap>�ظ�Ͷ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text36 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
         <tr class=content3>  
          <td noWrap>����Ͷ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text37 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
         <tr class=content2>  
          <td noWrap>Ͷ�ߴ���������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text38 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
         
         <tr class=content3>  
          <td noWrap rowSpan=29>�Ű����</td>
          <td noWrap>����ˮƽ��15�������ͨ�ʣ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text39 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�˹����������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text40 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>���з�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text41 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ���Ŷ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text42 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>��ͨ�Ŷ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text43 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�����Ŷ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text44 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>�˹�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text45 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�˹���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text46 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>�ŶӺ����ʣ��˹���ͨ�ʣ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text47 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>VIP20���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text48 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ȫ��ͨ20���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text49 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>������30���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text50 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>���еش�30���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text51 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�������30���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text52 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ƽ���ӳ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text53 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ������ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text54 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ƽ����̸ʱ����ͨ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text55 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ������ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text56 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ƽ���º���ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text57 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�˾�ÿСʱ�绰������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text58 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
            
         <tr class=content3>  
          <td noWrap>����������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text59 
            v_must=1 type=text size=18 value = 0 > </TD></tr>    
            
         <tr class=content2>  
          <td noWrap>��ʱ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text60 
            v_must=1 type=text size=18 value = 0 > </TD></tr>    
            
         <tr class=content3>  
          <td noWrap>������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text61 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
          <tr class=content2>  
          <td noWrap>�˹�����ռ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text62 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
          <tr class=content3>  
          <td noWrap>���񲨶�ϵ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text63 
            v_must=1 type=text size=18 value = 0 > </TD></tr>  
            
          <tr class=content2>  
          <td noWrap>�˹�����Ԥ��׼ȷ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text64 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
          <tr class=content3>  
          <td noWrap>�Ű��Ǻ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text65 
            v_must=1 type=text size=18 value = 0 > </TD></tr>    
          
          <tr class=content2>  
          <td noWrap>����ˮƽ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text66 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
            
          <tr class=content3>  
          <td noWrap>ÿСʱ���Ӱ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text67 
            v_must=1 type=text size=18 value = 0 > </TD></tr>  
            
          <tr class=content2>  
          <td noWrap rowSpan=9>�������</td>
          <td noWrap>��Ŀ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text68 
            v_must=1 type=text size=18 value = 0 > </TD></tr>  
            
          <tr class=content3>  
          <td noWrap>�����ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text69 
            v_must=1 type=text size=18 value = 0 > </TD></tr>  
            
         <tr class=content2>  
          <td noWrap>���Ӫ���ɹ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text70 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
           
         <tr class=content3>  
          <td noWrap>ÿСʱ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text71 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
           
          <tr class=content2>  
          <td noWrap>�ƻ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text72 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
           
          <tr class=content3>  
          <td noWrap>�Ӵ��ɹ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text73 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
           
          <tr class=content2>  
          <td noWrap>���۳ɹ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text74 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
           
          <tr class=content3>  
          <td noWrap>�ʼ�ϸ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text75 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
           
          <tr class=content2>  
          <td noWrap>����Ӫ��Ͷ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text76 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
           
          <tr class=content3>  
          <td noWrap rowSpan=2>�Զ�����</td>
          <td noWrap>�˹�ת�Զ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text77 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
           
          <tr class=content2>  
          <td noWrap>IVR������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text78 
            v_must=1 type=text size=18 value = 0 > </TD></tr>  
           
          <tr class=content2> 
          <td noWrap rowSpan=4>֧��ϵͳ</td> 
          <td noWrap>֪ʶ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text79 
            v_must=1 type=text size=18 value = 0 > </TD></tr>  
           
         <tr class=content3> 
          <td noWrap>ϵͳ��ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text80 
            v_must=1 type=text size=18 value = 0 > </TD></tr>   
          
         <tr class=content2> 
          <td noWrap>ϵͳ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text81 
            v_must=1 type=text size=18 value = 0 > </TD></tr> 
             
         <tr class=content3> 
          <td noWrap>������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text82 
            v_must=1 type=text size=18 value = 0 > </TD></tr>
            
         <tr class=content2>
          <td nowrap> </td>   
          <td noWrap><font color=#00ff00>�ύ����</font><font 
            color=#ff0000>*</FONT></TD>
          <td noWrap> <input id="start_date" name ="start_date" type="text"  v_must=1 value="" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
          </TD></TR>
          
        <tr class=content3>
          <td noWrap colSpan=6>
            <p><font color=#ff0000><strong>ע���������ݾ�Ϊ�����ͣ�����ʱ��ע�⣡��Ϊ�ٷ���������ʱ�뽫��ת��ΪС���ͣ�����23.58%ת����Ϊ0.2358��</strong></font></p>
            <p><strong><font color=#ff0000>&nbsp;&nbsp;&nbsp; <font 
            color=#00ff00>�ύ����</font>�ڲ�������ʱ����Ϊ�գ��Է�������޸�����ʱ���ύ���ڲ�ѯ�����á�</font></strong></p></TD></TR>
			<tr >
  				<td colspan="6" align="center" id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="���" onClick="addsceTrans()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="�ر�" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
</script>