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
		String opCode = "g444";
		String opName = "���п�ǩԼ�ͻ���������";
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
	
	//xl add ȡ��ѡ��ֵ
	var jfje = document.all.jfje.value;
	var cg_radio="";
	var temp=document.getElementsByName("utype");
	for (i=0;i<temp.length;i++)
	{
		if(temp[i].checked  )
		{
		  // alert("��ѡ����"+temp[i].value);
		  cg_radio=	temp[i].value;
		}
	}
    var cus_pass = document.all.cus_pass.value;
	var phone_no= document.all.phone_no.value;
	var phone_no2= document.all.phone_no2.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("�������ֻ�����!");
		return false;
	}
	else if(cus_pass=="")
	{
		rdShowMessageDialog("�������û�����!");
		return false;
	}
	else if(cg_radio==0 && phone_no2=="")
	{
		rdShowMessageDialog("������ɷ��ֻ�����!");
		return false;
	}
	else if(jfje=="")
	{
		rdShowMessageDialog("������ɷѽ��!");
		return false;
	}
	else
	{
	   document.frm.action="g444_2.jsp?custPass="+cus_pass+"&phone_no="+phone_no+"&phone_no2="+phone_no2+"&jfje="+jfje+"&flag="+cg_radio;
	   document.frm.query.disabled=true;
	   document.frm.submit();
	}
	//alert("cus_pass is "+cus_pass);
	   
 
	 
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }


  function inits()
  {
	  document.getElementById("div1").style.display="none";
  }
  function checks(id)
  {
	  //alert(id);
	  if(id==1)//����
	  {
		  document.getElementById("div1").style.display="none";
	  }	
	  if(id==0)//����
	  {
		  document.getElementById("div1").style.display="block";
	  }	
 	
  }

-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
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
	
	 <tr> 
		  <td class="blue" width="15%">�ɷѷ�ʽ</td>
		  <td> 
			<input class="button" type="radio" name="utype" value="1" checked onclick="checks(1)">Ϊ������ɷ�
			&nbsp;&nbsp;
			<input class="button" type="radio" name="utype" value="0" onclick="checks(0)">Ϊ��������ɷ�
		  </td>
	 </tr>	 

	<tr id="div1"> 
	  <td class="blue" width="15%">�ɷ��ֻ�����</td>
	  <td> 
		<input class="button"type="text" name="phone_no2" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
	  </td>
	</tr>
 <tr> 
      <td class="blue" width="15%">�ɷѽ��</td>
      <td> 
        <input class="button"type="text" name="jfje" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(1)" >
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