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

<%
		String[] inParas2 = new String[2];
		String opCode = "zgbn";
		String opName = "���Ų�Ʒ����Ԥ����ֵ����";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 
%>
 
<HTML>
<HEAD>
<script language="JavaScript">
 
 
  
function add1()
{
	var account_id = document.all.account_id.value;
	var thres_value = document.all.thres_value.value;
	//var thres_valuemc = document.all.thres_valuemc.value ;
	if(account_id=="" ||thres_value=="")
	{
		rdShowMessageDialog("�����뼯�Ų�Ʒ�˺ź�Ԥ����ֵ!");
		return false;
	}
	else
	{
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("�Ƿ�ȷ����Ӳ���?");
		if (prtFlag==1)
		{
			//document.frm.action="zgbn_2.jsp?account_id="+account_id+"&thres_value="+thres_value+"&op_type=ins"+"&thres_valuemc="+thres_valuemc;
			document.frm.action="zgbn_2.jsp?account_id="+account_id+"&thres_value="+thres_value+"&op_type=ins";
			document.frm.submit();
		}
		else
		{
			return false;
		}
	}
	 
} 

 function sel1() {
 		window.location.href='zgbn_1.jsp';
 }

 function sel2(){
    window.location.href='zgbn_update.jsp';
 }

 function sel3() {
    window.location.href='zgbn_del.jsp';
 }

 function sel4() {
    window.location.href='s1300_4.jsp';
 }
 function sel5() {
    window.location.href='s1300_5.jsp';
 }

 function doclear() {
 		frm.reset();
 }
 function sel6() {
    window.location.href='s1300_v.jsp';
 }

 
function inits()
{ 
}
 
	   
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()"> 
<form action="" method="post" name="frm">
		<input type="hidden" name="busy_type"  value="1">
		 
		<input type="hidden" name="op_code"  value="1302">
		<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
		<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
		<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
		<input type="hidden" name="water_number">
		<input type="hidden" name="ispopmarket" value="0" >
		<input type="hidden" name="custPass"  value="">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ѡ�����÷�ʽ</div>
		</div>

    <table cellspacing="0">
      <tbody> 
	  <!--������tr id������
	  <tr class="blue" style="display:none" id="sptime3">
	  -->
      <tr> 
        <td class="blue" width="15%">���÷�ʽ</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked>���� 
        </q>
          
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2">�޸�
          </q>
          <q vType="setNg35Attr">
          <input name="busyType5" type="radio" onClick="sel3()" value="3">ɾ��
          </q>
          
	   </td>
     </tr>
	   
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">���Ų�Ʒ�˺�</td>
      <td> 
        <input class="button"type="text" name="account_id" size="20" maxlength="14"  onKeyPress="return isKeyNumberdot(0)">
      </td>
      
    </tr>
	<tr>
		<td class="blue" width="15%">Ԥ����ֵ</td>
		<td> 
        <input type="text" name="thres_value" size="20" maxlength="20"  >
      </td>
	</tr>
	<!--
	<tr>
	<td class="blue" width="15%">��������</td>
      <td> 
        <input type="text" name="thres_valuemc" size="60" maxlength="60"  >
      </td>
	</tr>
	 -->
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="����" onclick="add1()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
         <!--
		  <input type="button" name="reprint"  class="b_foot" value="�ش�Ʊ" onclick="doreprint()">
		  -->
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>