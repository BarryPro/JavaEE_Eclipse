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
		String opCode = "g429";
		String opName = "���п�ǩԼ�ͻ���Լ";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*Ĭ�ϣ�12����֮ǰ*/
    String startTime = sdf.format(today.getTime());
//����
String nopass = (String)session.getAttribute("password");
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
{
	
 
        //rdShowMessageDialog("�û���Լ�ɹ�!");
	var cus_pass = document.all.cus_pass.value;
	var phone_no= document.all.check_code.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("�������ֻ�����!");
	}
	else if(cus_pass=="")
	{
		rdShowMessageDialog("�������û�����!");
	}
	else
	{
	  // alert("custPass is "+cus_pass);
	   document.frm.action="g429_2.jsp?custPass="+cus_pass+"&phone_no="+phone_no;
	   //document.frm.query.disabled=true;
	   document.frm.submit();
	}
	//alert("cus_pass is "+cus_pass);
	   
 
	 
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
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="check_code" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
       
       
    </tr>
	
	 <tr> 
      <td class="blue"  width="15%">�û�����</td>
          <td colspan=3>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
       </td>
     
    </tr>
 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="ȷ��" onclick="docheck()" >
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