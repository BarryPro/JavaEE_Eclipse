<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
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
		String opCode = "i092";
		String opName = "ǿ��Ԥ��";
		String dateStr = new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
 
	 
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }


 
    
   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
   function sel3()
   {
		   window.location.href='i092_3.jsp';
   }
   function sel4()
   {
		   window.location.href='i092_4.jsp';
   }
   
function do_ftp()
{
	

	if(frm.file_name.value.length<1)
	{
		rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
		document.frm.file_name.focus();
		return false;
	}

	
	//document.frm.action="i092_3_1.jsp" ;

	document.frm.submit();
	
}
  
-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="i092_3_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >���ֻ������ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">�����в�ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3" checked >�ļ�����
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4" >�ļ���������ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">������Ҫ������ļ���  ����ÿ��5��֮�����,������Ч</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		<td class="blue" align="right">
			��ѡ���ļ�
		</td>
		<td >
			<input type="file" name="file_name" size="30" class="button">
		</td>
	</tr>
	
	<tr>
		<td class="blue" align="right">
			��ʽҪ��:<br>
			&nbsp;&nbsp;
		</td>
		<td>
		ע�������ļ���಻Ҫ����2000��<br><br>
		&nbsp;&nbsp;�ֻ���1<br>
		&nbsp;&nbsp;�ֻ���2<br>
		&nbsp;&nbsp;�ֻ���3<br>
		&nbsp;&nbsp;...<br>
		</td>
	</tr>
	 


  </table> 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	        <input type="button" name="query" class="b_foot" value="�ϴ�" onclick="do_ftp()" >
       
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