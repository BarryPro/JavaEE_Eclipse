<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "i086";
		String opName = "ר���Ŀ���ѯ";
 
	 
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }

   function docheck3()
   {
	   var s_paytype =  document.all.rpt_type[document.all.rpt_type.selectedIndex].value;
	   document.frm.action = "i086_1_qry.jsp?s_paytype="+s_paytype;
	   document.frm.submit();	
	   
   }
 
   function docheck2()
   {
	   var s_paytype =  document.all.rpt_type[document.all.rpt_type.selectedIndex].value;
	   //alert("1 is "+s_paytype);
	   //document.getElementById("Operation_Table1").style.display="block";	
	   var myPacket = new AJAXPacket("i086_1qry.jsp","���ڲ�ѯ�����Ժ�......");
	   myPacket.data.add("s_paytype",s_paytype);
	   core.ajax.sendPacket(myPacket);
	   myPacket = null;	
   }
   function doProcess(packet)
   {
	   var flag1 = packet.data.findValueByName("flag1");
	   var errCode = packet.data.findValueByName("errCode");
	   var errMsg = packet.data.findValueByName("errMsg");
	   var s_pay_name = packet.data.findValueByName("s_pay_name");
	   var s_trans_flag = packet.data.findValueByName("s_trans_flag");
	   var s_refund_flag = packet.data.findValueByName("s_refund_flag");
	   var s_show_flag = packet.data.findValueByName("s_show_flag");
	   var s_order_code = packet.data.findValueByName("s_order_code");
	   var s_show_name1 = packet.data.findValueByName("s_show_name1");
	   var s_show_name2 = packet.data.findValueByName("s_show_name2");
	   var s_show_name3 = packet.data.findValueByName("s_show_name3");
	   var s_name1_flag = packet.data.findValueByName("s_name1_flag");
	   //alert("2");
	   var cx_result_length    = packet.data.findValueByName("cx_result_length");
	   //alert("3 "+cx_result_length);
	   var cx_result_fee_code = new Array();
	   var cx_result_fee_name = new Array();
	   var cx_result_detail_code = new Array();
	   var cx_result_detail_name = new Array();
	   //alert("4");
	   for(i =0;i<cx_result_length;i++)
	   {
		  cx_result_fee_code[i]	= packet.data.findValueByName("cx_result_fee_code"+i);
		  cx_result_fee_name[i]	= packet.data.findValueByName("cx_result_fee_name"+i);
		  cx_result_detail_code[i]	= packet.data.findValueByName("cx_result_detail_code"+i);
		  cx_result_detail_name[i]	= packet.data.findValueByName("cx_result_detail_name"+i);
		 // alert(cx_result_fee_code[i]+cx_result_detail_name[i]);
		  document.getElementById("Operation_Table1").style.display="block";
		  document.getElementById("cx").innerHTML+="<tr><td>"+cx_result_fee_code[i]+"</td> <td>"+cx_result_fee_name[i]+"</td> <td>"+cx_result_detail_name[i]+"</td> <td>"+cx_result_detail_code[i]+"</td></tr><p>";
		 
	   }	
	   
	
	   if(flag1=="0")
	   {
		   document.getElementById("Operation_Table1").style.display="block";
		   document.getElementById("name1").innerHTML=s_pay_name;
		   document.getElementById("refund").innerHTML=s_refund_flag;
		   document.getElementById("s_trans_flag").innerHTML=s_trans_flag;
		   document.getElementById("s_show_flag").innerHTML=s_show_flag;
		   document.getElementById("s_order_code").innerHTML=s_order_code;
		   if(s_name1_flag=="1")
		   {
			   document.getElementById("s_show_name1").innerHTML="���տ�������ϢΪ��";
		   }
		   else
		   {
			   document.getElementById("s_show_name1").innerHTML="���տ����˵�������Ŀ�һ����Ŀ��"+'"'+s_show_name1+'"'+"�µĶ�����Ŀ��"+'"'+s_show_name2+'"'+"�µ�������Ŀ��"+'"'+s_show_name3+'"';
		   }	
		   
		 
	   }
	   else
	   {
		   rdShowMessageDialog("��ѯר����Ϣ�����������:"+errCode+",����ԭ��:"+errMsg);
		   document.getElementById("Operation_Table1").style.display="none";
	   }	
   } 
   function sel1()
   {
			window.location.href='i086_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i086_1_bill.jsp';
   }
   function sel3()
   {
		   window.location.href='i086_2_bill.jsp';
   }
   function sel4()
   {
		   window.location.href='i086_3_bill.jsp';
   }
   function inits()
   {
	   document.getElementById("Operation_Table1").style.display="none";
   }
-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" checked>ר���ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">һ����Ŀ���ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3">������Ŀ���ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4">������Ŀ���ѯ
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		<td class="blue" >
			ģ������
		</td>
		<td colspan="3">
			<input type="text" id="searchTextrpt" name="searchTextrpt" 
			 value="������ר�����ƻ�ר������" 
			 size="40"
			 style="padding-top:3px;"
			 onFocus="frm.searchTextrpt.value='';clearResults();"
			onpropertychange="blurSearchFunc('rpt_type','searchTextrpt')" />
		</td>
	</tr>
	<tr>
		<td class="blue">ר������-->ר������</td>
		<td>
			<select name=rpt_type style='width:400px'>
				<!--wanghfa 20100602 �����޸� start-->
				<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select pay_type,pay_type||'-->'||pay_name from spaytype </wtc:sql>
				</wtc:qoption>
				<!--wanghfa 20100602 �����޸� end-->
			</select>
		</td>
	</tr> 


  </table>
<div id="Operation_Table1">    
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>	 
	<table cellspacing="0">
	    <th>ר������</th>
		<th>ר���Ƿ����</th>
		<th>ר���Ƿ��ת</th>
		<th>ר��ǰ̨�Ƿ�ɼ�</th>
		<th>ר��������ȼ�</th>
		<th>ר��ڻ������˵���Ŀ��</th>
		<tr> 
			<td class="blue" id="name1"></td>
			<td class="blue" id="refund"></td>
			<td class="blue" id="s_trans_flag"></td>
			<td class="blue" id="s_show_flag"></td>
			<td class="blue" id="s_order_code"></td>
			<td class="blue" id="s_show_name1"></td>
	 
		</tr>
	 
			<th>ר��ɳ�����Ŀ��</th>
			<div id="cx"></div> 
		 
	</table>
</div>	


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck3()" >
       
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
  <%@ include file="/npage/public/pubSearchText.jsp" %>
</form>
 </BODY>
</HTML>