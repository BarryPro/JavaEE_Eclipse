<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �ͷ�������Ӫָ����ϵ
�� * �汾: 1.0.0
�� * ����: 2009/08/07
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%

String sceid =  request.getParameter("sceid");
HashMap hashMap =new HashMap();
hashMap.put("SERIALNO",sceid); 
String[][] dataRows = null; 
String[] xx= new String[]{}; 

List iDataList3 =(List)KFEjbClient.queryForList("k199Modifyselect",hashMap);                              
String[][] rows = getArrayFromListMap(iDataList3 ,0,1); 
 

dataRows = new String[rows.length][];
for(int i=0;i<rows.length;i++)    
   {     
           xx=rows[i][0].split(",");     
           for(int j=0;j<xx.length;j++){
           String clo = xx[j];
           if(clo.length()>0&&clo.charAt(0)=='.'){
             	xx[j]= "0"+xx[j];
           }    
           }    
           dataRows[i]  =xx ;
  }
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
function modifysceTrans(){
	 
	var xinval="";
	var yinval="";
  
	for(var i=0;i<83;i++)
	{
		   if ($("input")[i].value=="")
		   {
		   	  $("input")[i].value=" ";
		   }
			 xinval+=$("input")[i].value+",";
			 
  }
 
   
	var packet = new AJAXPacket("k199_sceTrans_rpc.jsp","...");
	packet.data.add("retType","modifysceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("sceid" ,"<%=sceid%>");
	 


	
	core.ajax.sendPacket(packet,doProcessmodsceTrans,true);
	packet=null;
}

/**
  *���ش�����
  */
function doProcessmodsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("�޸����ݳɹ���");	
		opener.document.location.replace("k199_Main.jsp");	
    closeWin();
   
	} else {
		rdShowMessageDialog("�޸�����ʧ�ܣ�");

	}
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
<form id=sitechform name=sitechform>
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
            v_must=1 type=text size=18 value="<%=dataRows[0][0] %>" >
          <!-- <input class=form1 id=btnGetNewCommonInfo type=button title="��ȡ��ǰ������Ϣ��ͬ����������Ϣ" value=ͬ��>--></TD>
        </TR>
        
        <TR class=content2>
          <td noWrap>������ʧ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text2 
            v_must=1 type=text size=18 value="<%=dataRows[0][1] %>" ></TD></TR>
            
        <TR class=content3>
          <td noWrap>������ʧ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text3 
            v_must=1 type=text size=18 value="<%=dataRows[0][2] %>" > </TD></TR>
            
        <TR class=content2>  
          <td noWrap>��Ա��Ƹ��ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text4 
            v_must=1 type=text size=18 value="<%=dataRows[0][3] %>" > </TD></TR>
            
        <TR class=content3>
          <td noWrap>���ڼ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text5 
            v_must=1 type=text size=18 value="<%=dataRows[0][4] %>" ></TD></TR>
            
        <TR class=content2>   
          <td noWrap>��Ա��ת���ʣ��ϸ��ʣ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text6 
            v_must=1 type=text size=18 value="<%=dataRows[0][5] %>" ></TD></TR>
            
        <TR class=content3>   
          <td noWrap>��ѵ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text7 
            v_must=1 type=text size=18 value="<%=dataRows[0][6] %>" ></TD></TR>
            
        <tr class=content2>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >��ѵ��ʱ�����</FONT>*</FONT> </TD>
          <td noWrap><input class=form1 id=text8 
            v_must=1 type=text size=18 value="<%=dataRows[0][7] %>" ></TD></TR>
        
        <tr class=content3>    
          <td noWrap>��ѵ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text9 
            v_must=1 type=text size=18 value="<%=dataRows[0][8] %>" > </TD></TR>
            
        <tr class=content2>    
          <td noWrap>��ѵ�ϸ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text10 
            v_must=1 type=text size=18 value="<%=dataRows[0][9] %>" > </TD></TR>
         
        <TR class=content2>
          <td noWrap rowSpan=9>��������</TD>    
          <td noWrap>�ͻ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text11 
            v_must=1 type=text size=18 value="<%=dataRows[0][10] %>" ></TD></TR>
            
        <TR class=content3>    
          <td noWrap>�һ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text12 
            v_must=1 type=text size=18 value="<%=dataRows[0][11] %>" > </TD></TR>
            
        <tr class=content2>    
          <td noWrap>�����ۺϵ÷�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text13 
            v_must=1 type=text size=18 value="<%=dataRows[0][12] %>" > </TD></TR>
            
        <tr class=content3>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >�˹���������</FONT>*</FONT></TD>
          <td noWrap><input class=form1 id=text14 
            v_must=1 type=text size=18 value="<%=dataRows[0][13] %>" ></TD></TR>
            
         <tr class=content2>   
          <td noWrap>һ�ν����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text15 
            v_must=1 type=text size=18 value="<%=dataRows[0][14] %>" > </TD></TR>
            
         <tr class=content3>   
          <td noWrap>�ʼ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text16 
            v_must=1 type=text size=18 value="<%=dataRows[0][15] %>" > </TD></TR>
            
        <tr class=content2>
          <td noWrap>������ʱ��<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text17 
            v_must=1 type=text size=18 value="<%=dataRows[0][16] %>" ></TD></TR>
            
         <tr class=content3>
          <td noWrap>����������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text18 
            v_must=1 type=text size=18 value="<%=dataRows[0][17] %>" > </TD></TR>
          
         <tr class=content2>
          <td noWrap>����Ͷ����<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text19 
            v_must=1 type=text size=18 value="<%=dataRows[0][18] %>" ></TD></TR> 
         
         <tr class=content3>
          <td noWrap rowSpan=12>�ɱ�����</td>
          <td noWrap>��Ӫ�ܳɱ�<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text20
            v_must=1 type=text size=18 value="<%=dataRows[0][19] %>" ></TD></tr>
            
         <tr class=content2>  
          <td noWrap>��Ӫ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text21 
            v_must=1 type=text size=18 value="<%=dataRows[0][20] %>" > </TD></tr> 
          
         <tr class=content3>  
          <td noWrap>����Ӫ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text22 
            v_must=1 type=text size=18 value="<%=dataRows[0][21] %>" > </TD></tr>   
         
         <tr class=content2>  
          <td noWrap>�˾�����Ӫ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text23 
            v_must=1 type=text size=18 value="<%=dataRows[0][22] %>" > </TD></tr>
            
         <tr class=content3>  
          <td noWrap>Ӫ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text24 
            v_must=1 type=text size=18 value="<%=dataRows[0][23] %>" > </TD></tr>   
         
         <tr class=content2>  
          <td noWrap>�˾�Ӫ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text25 
            v_must=1 type=text size=18 value="<%=dataRows[0][24] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>��ϯ���������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text26 
            v_must=1 type=text size=18 value="<%=dataRows[0][25] %>" > </TD></tr>
            
         <tr class=content2>  
          <td noWrap>��ϯ���ƽ��ÿ�ͻ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text27 
            v_must=1 type=text size=18 value="<%=dataRows[0][26] %>" > </TD></tr> 
         
         <tr class=content3>  
          <td noWrap>ƽ�������ɱ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text28 
            v_must=1 type=text size=18 value="<%=dataRows[0][27] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ���˹�����ɱ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text29 
            v_must=1 type=text size=18 value="<%=dataRows[0][28] %>" > </TD></tr>
            
         <tr class=content3>  
          <td noWrap>ƽ��ÿ�ͻ�����ɱ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text30 
            v_must=1 type=text size=18 value="<%=dataRows[0][29] %>" > </TD></tr>            
         
         <tr class=content2>  
          <td noWrap>���Ӫ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text31 
            v_must=1 type=text size=18 value="<%=dataRows[0][30] %>" > </TD></tr>
            
         <tr class=content2>  
          <td noWrap rowSpan=7>Ͷ�߹���</td>
          <td noWrap>Ͷ�߹����ϸ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text32 
            v_must=1 type=text size=18 value="<%=dataRows[0][31] %>" > </TD></tr>      
         
         <tr class=content3>  
          <td noWrap>Ͷ�ߴ���ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text33 
            v_must=1 type=text size=18 value="<%=dataRows[0][32] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>Ͷ���ɵ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text34 
            v_must=1 type=text size=18 value="<%=dataRows[0][33] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>Ͷ�ߵ绰��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text35 
            v_must=1 type=text size=18 value="<%=dataRows[0][34] %>" > </TD></tr>   
            
         <tr class=content2>  
          <td noWrap>�ظ�Ͷ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text36 
            v_must=1 type=text size=18 value="<%=dataRows[0][35] %>" > </TD></tr>   
            
         <tr class=content3>  
          <td noWrap>����Ͷ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text37 
            v_must=1 type=text size=18 value="<%=dataRows[0][36] %>" > </TD></tr>   
            
         <tr class=content2>  
          <td noWrap>Ͷ�ߴ���������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text38 
            v_must=1 type=text size=18 value="<%=dataRows[0][37] %>" > </TD></tr>   
         
         <tr class=content3>  
          <td noWrap rowSpan=29>�Ű����</td>
          <td noWrap>����ˮƽ��15�������ͨ�ʣ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text39 
            v_must=1 type=text size=18 value="<%=dataRows[0][38] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�˹����������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text40 
            v_must=1 type=text size=18 value="<%=dataRows[0][39] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>���з�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text41 
            v_must=1 type=text size=18 value="<%=dataRows[0][40] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ���Ŷ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text42 
            v_must=1 type=text size=18 value="<%=dataRows[0][41] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>��ͨ�Ŷ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text43 
            v_must=1 type=text size=18 value="<%=dataRows[0][42] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�����Ŷ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text44 
            v_must=1 type=text size=18 value="<%=dataRows[0][43] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>�˹�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text45 
            v_must=1 type=text size=18 value="<%=dataRows[0][44] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�˹���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text46 
            v_must=1 type=text size=18 value="<%=dataRows[0][45] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>�ŶӺ����ʣ��˹���ͨ�ʣ�<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text47 
            v_must=1 type=text size=18 value="<%=dataRows[0][46] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>VIP20���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text48 
            v_must=1 type=text size=18 value="<%=dataRows[0][47] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ȫ��ͨ20���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text49 
            v_must=1 type=text size=18 value="<%=dataRows[0][48] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>������30���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text50 
            v_must=1 type=text size=18 value="<%=dataRows[0][49] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>���еش�30���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text51 
            v_must=1 type=text size=18 value="<%=dataRows[0][50] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�������30���ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text52 
            v_must=1 type=text size=18 value="<%=dataRows[0][51] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ƽ���ӳ�ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text53 
            v_must=1 type=text size=18 value="<%=dataRows[0][52] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ������ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text54 
            v_must=1 type=text size=18 value="<%=dataRows[0][53] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ƽ����̸ʱ����ͨ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text55 
            v_must=1 type=text size=18 value="<%=dataRows[0][54] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>ƽ������ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text56 
            v_must=1 type=text size=18 value="<%=dataRows[0][55] %>" > </TD></tr>
         
         <tr class=content3>  
          <td noWrap>ƽ���º���ʱ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text57 
            v_must=1 type=text size=18 value="<%=dataRows[0][56] %>" > </TD></tr>
         
         <tr class=content2>  
          <td noWrap>�˾�ÿСʱ�绰������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text58 
            v_must=1 type=text size=18 value="<%=dataRows[0][57] %>" > </TD></tr> 
            
         <tr class=content3>  
          <td noWrap>����������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text59 
            v_must=1 type=text size=18 value="<%=dataRows[0][58] %>" > </TD></tr>    
            
         <tr class=content2>  
          <td noWrap>��ʱ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text60 
            v_must=1 type=text size=18 value="<%=dataRows[0][59] %>" > </TD></tr>    
            
         <tr class=content3>  
          <td noWrap>������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text61 
            v_must=1 type=text size=18 value="<%=dataRows[0][60] %>" > </TD></tr>   
            
          <tr class=content2>  
          <td noWrap>�˹�����ռ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text62 
            v_must=1 type=text size=18 value="<%=dataRows[0][61] %>" > </TD></tr>   
            
          <tr class=content3>  
          <td noWrap>���񲨶�ϵ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text63 
            v_must=1 type=text size=18 value="<%=dataRows[0][62] %>" > </TD></tr>  
            
          <tr class=content2>  
          <td noWrap>�˹�����Ԥ��׼ȷ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text64 
            v_must=1 type=text size=18 value="<%=dataRows[0][63] %>" > </TD></tr>   
            
          <tr class=content3>  
          <td noWrap>�Ű��Ǻ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text65 
            v_must=1 type=text size=18 value="<%=dataRows[0][64] %>" > </TD></tr>    
          
          <tr class=content2>  
          <td noWrap>����ˮƽ������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text66 
            v_must=1 type=text size=18 value="<%=dataRows[0][65] %>" > </TD></tr>   
            
          <tr class=content3>  
          <td noWrap>ÿСʱ���Ӱ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text67 
            v_must=1 type=text size=18 value="<%=dataRows[0][66] %>" > </TD></tr>  
            
          <tr class=content2>  
          <td noWrap rowSpan=9>�������</td>
          <td noWrap>��Ŀ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text68 
            v_must=1 type=text size=18 value="<%=dataRows[0][67] %>" > </TD></tr>  
            
          <tr class=content3>  
          <td noWrap>�����ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text69 
            v_must=1 type=text size=18 value="<%=dataRows[0][68] %>" > </TD></tr>  
            
         <tr class=content2>  
          <td noWrap>���Ӫ���ɹ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text70 
            v_must=1 type=text size=18 value="<%=dataRows[0][69] %>" > </TD></tr>   
           
         <tr class=content3>  
          <td noWrap>ÿСʱ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text71 
            v_must=1 type=text size=18 value="<%=dataRows[0][70] %>" > </TD></tr>
           
          <tr class=content2>  
          <td noWrap>�ƻ�������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text72 
            v_must=1 type=text size=18 value="<%=dataRows[0][71] %>" > </TD></tr> 
           
          <tr class=content3>  
          <td noWrap>�Ӵ��ɹ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text73 
            v_must=1 type=text size=18 value="<%=dataRows[0][72] %>" > </TD></tr> 
           
          <tr class=content2>  
          <td noWrap>���۳ɹ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text74 
            v_must=1 type=text size=18 value="<%=dataRows[0][73] %>" > </TD></tr> 
           
          <tr class=content3>  
          <td noWrap>�ʼ�ϸ���<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text75 
            v_must=1 type=text size=18 value="<%=dataRows[0][74] %>" > </TD></tr> 
           
          <tr class=content2>  
          <td noWrap>����Ӫ��Ͷ����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text76 
            v_must=1 type=text size=18 value="<%=dataRows[0][75] %>" > </TD></tr> 
           
          <tr class=content3>  
          <td noWrap rowSpan=2>�Զ�����</td>
          <td noWrap>�˹�ת�Զ�����<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text77 
            v_must=1 type=text size=18 value="<%=dataRows[0][76] %>" > </TD></tr> 
           
          <tr class=content2>  
          <td noWrap>IVR������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text78 
            v_must=1 type=text size=18 value="<%=dataRows[0][77] %>" > </TD></tr>  
           
          <tr class=content2> 
          <td noWrap rowSpan=4>֧��ϵͳ</td> 
          <td noWrap>֪ʶ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text79 
            v_must=1 type=text size=18 value="<%=dataRows[0][78] %>" > </TD></tr>  
           
         <tr class=content3> 
          <td noWrap>ϵͳ��ͨ��<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text80 
            v_must=1 type=text size=18 value="<%=dataRows[0][79] %>" > </TD></tr>   
          
         <tr class=content2> 
          <td noWrap>ϵͳ��������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text81 
            v_must=1 type=text size=18 value="<%=dataRows[0][80] %>" > </TD></tr> 
             
         <tr class=content3> 
          <td noWrap>������<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text82 
            v_must=1 type=text size=18 value="<%=dataRows[0][81] %>" > </TD></tr>
            
         <tr class=content2>
          <td nowrap> </td>   
          <td noWrap><font color=#00ff00>�ύ����</font><font 
            color=#ff0000>*</FONT></TD>
          <td noWrap> <input id="start_date" name ="start_date" type="text"  v_must=1 value="<%=dataRows[0][82] %>"   onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
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
   					<input name="add" type="button" class="b_text" id="add" value="����" onClick="modifysceTrans()">
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