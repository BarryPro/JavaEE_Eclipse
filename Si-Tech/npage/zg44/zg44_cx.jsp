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
		String opCode = "zg44";
		String opName = "���⼯�Ź�ϵ����";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*Ĭ�ϣ�12����֮ǰ*/
    String startTime = sdf.format(today.getTime());
	activePhone = request.getParameter("activePhone");	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjttj()
{
	//alert("1");
	var select_id = document.all.user_check[document.all.user_check.selectedIndex].value;
    //alert(select_id);
	var unit_id = document.frm.phoneNo.value;
	var cxhm = document.frm.cxhm.value;
 
	if(unit_id=="" &&select_id=="1")
	{
		rdShowMessageDialog("���������⼯�ű��!");
		return false;
	}
	else if(cxhm=="" && select_id=="2")
	{
		rdShowMessageDialog("�����������Ա����!");
		return false;
	}
	else
	{
		document.frm.action="zg44_qry.jsp?unit_id="+unit_id+"&select_id="+select_id+"&cxhm="+cxhm;
		//alert(document.frm.action);
		document.frm.submit();
	}
	
	
}
 


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zg44_1.jsp';
 }

 function sel2(){
    window.location.href='zg44_3.jsp';
 }
 function sel3(){
    window.location.href='zg44_cx.jsp';
 }
 function sel4(){
    window.location.href='zg44_del.jsp';
 }

 function check_user()
 {
	var user_check = document.all.user_check[document.all.user_check.selectedIndex].value;
	if(user_check=="1")
	{
		//alert("����У��");
		document.getElementById("userpasswd").style.display="block";
		document.getElementById("userid").style.display="none";
	}
	else
	{
		//alert("���֤����");
		document.getElementById("userpasswd").style.display="none";
		document.getElementById("userid").style.display="block";
	}	
 }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">��ѡ�����÷�ʽ</div>
	</div>
	
	<table cellspacing="0">
      <tbody> 
	 
      <tr> 
        <td class="blue" width="15%">���÷�ʽ</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >���⼯����� 
        </q>
 
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2"> ���ų�Ա���
          </q>
         
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> ���⼯�Ų�ѯ��ɾ��
          </q>
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel3()" value="3" checked> ���ų�Ա��ϵ��ѯ
          </q>
		   <!--
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> ���ų�Ա��ϵɾ��
          </q>
			-->
     </tr>
	   
    </tbody>
  </table>
	
  <table cellspacing="0">
    <tr> 
	   <td class="blue"  colspan="3">	
			<select name="user_check"  class="button" onChange="check_user()">��ѯ��ʽ
				<option value="1" selected>����������ѯ</option>
				<option value="2">�������Ա�����ѯ</option>
			</select> 
	   </td>	
	  
    </tr>
    
	<tr id="userpasswd" style="display:block">	
       <td class="blue" width="15%">���⼯���˺�</td>
       <td> 
         <input class="button"type="text" name="phoneNo" size="14" maxlength="14"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
       </td>
    </tr>

	<tr id="userid" style="display:none">
      <td class="blue" width="15%">�����Ա����</td>
      <td> 
        <input class="button"type="text" name="cxhm" size="14" maxlength="14"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
    </tr>

  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="���⼯�ų�Ա��ѯ" onclick="xnjttj()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
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