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
		String opCode = "g339";
		String opName = "��ʡ�����˵���ѯ";
		 
		
%>
 

<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
 {
	
	  var objSel_pay = document.getElementById("pay_id");
	  var pay_value=objSel_pay.value;	
	  //alert("document.frm.jfzq.value is "+document.frm.jfzq.value+" and document.frm.kfbm.value is "+document.frm.kfbm.value+" and pay_value is "+pay_value);
	  if( document.frm.jfzq.value=="" &&document.frm.kfbm.value=="" && pay_value=="00")
	  {
			rdShowMessageDialog("�������ѯ����!");
			 
			return false;
	  }
	  
	   document.frm.action="g339_2.jsp?jfzq="+document.frm.jfzq.value+"&kfbm="+document.frm.kfbm.value+"&pay_value="+pay_value;
 
	   document.frm.submit();
 
	 
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }

 


-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">ȫ�����ſͻ�����</td>
      <td> 
        <input type="text" name="kfbm" size="32" maxlength="32" > 
      </td>
      <td class="blue">�Ʒ�����</td>
      <td> 
        <input type="text" name="jfzq" size="14" maxlength="14" > 
      </td>
       
    </tr>
	 
	
	<tr>
	 <td class="blue">�ʵ����</td>
      <td> 
        <select id="pay_id">
			 <option value="00" selected>��ѡ��</option>
			 <option value="0" >Ӧ��</option>
			 <option value="1" >ʵ��</option>
			 
		</select>
      </td>
	</tr>


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
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