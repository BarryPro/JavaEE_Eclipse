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
String opCode = "zg11";
String opName = "GPRS����״̬��ѯ";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
//activePhone = request.getParameter("activePhone");

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var phone_no = document.all.phone_no.value;
 
	if(phone_no=="")
	{
		rdShowMessageDialog("�������ֻ�����!");
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("zg11_check.jsp","���ڽ��в�ѯ�����Ժ�......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
	
} 
function doProcess(packet)
{
	var s_flag   = packet.data.findValueByName("s_flag"); 
	var s_result   = packet.data.findValueByName("s_result"); 
	//alert("s_flag is "+s_flag+" and s_result is "+s_result);
	var s_qqw_flag = packet.data.findValueByName("s_qqw_flag"); 
	var s_qqw_result = packet.data.findValueByName("s_qqw_result");
	//alert("s_qqw_flag is "+s_qqw_flag+" and s_qqw_result is "+s_qqw_result);
	if(s_flag=="N")
	{
		rdShowMessageDialog("�ֻ����벻���ڣ�����������!");
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		return false;
	}
	else
	{
		if(s_result=="0")//��ͨ
		{
			document.getElementById("div2").style.display="block";
			document.getElementById("div1").style.display="none";
		}
		else
		{
			document.getElementById("div2").style.display="none";
			document.getElementById("div1").style.display="block";
		}
	}
	//��������¼
	//alert("s_qqw_flag is "+s_qqw_flag);
	if(s_qqw_flag=="kt")
	{
		//alert("��ͨ");
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="block";
	}
	else
	{
		//alert("�ر�");
		document.getElementById("div3").style.display="block";
		document.getElementById("div4").style.display="none";
	}
}
	
 
 

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
	 document.getElementById("div1").style.display="none";
	 document.getElementById("div2").style.display="none";
	 //xl add for lidsa
	 document.getElementById("div3").style.display="none";
	 document.getElementById("div4").style.display="none";
 }

 function doGb()
 {
	 //alert("1");
	 var phone_no = document.all.phone_no.value;
	 document.frm.action="zg11_2.jsp?phone_no="+phone_no+"&flag=1";
	 document.frm.submit();
 }
 function doKt()
 {
	// alert("3");
	 var phone_no = document.all.phone_no.value;
	 document.frm.action="zg11_2.jsp?phone_no="+phone_no+"&flag=3";
	 document.frm.submit();
 }
 function doqry()
 {
	//alert("2");
	var phone_no = document.all.phone_no.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("�������ֻ�����!");
	}
	else
	{
		document.frm.action="zg11_qry.jsp?phone_no="+phone_no;
		document.frm.submit();
	}

 }
 function qqw_Gb()
 {
	 //alert("1 �ر�");
	 var phone_no = document.all.phone_no.value;
	 var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ���ر�?");
	 if (prtFlag==1)
	 {
	 	document.frm.action="zg11_qqw.jsp?phone_no="+phone_no+"&flag=gb";
	 	document.frm.submit();
	 }
	 else
	 {
	 	return false;
	 }	
 }
 function qqw_Kt()
 {
 		//alert("0 ��ͨ");
 		var phone_no = document.all.phone_no.value;
 		var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����ͨ?");
		if (prtFlag==1)
		{
		  document.frm.action="zg11_qqw.jsp?phone_no="+phone_no+"&flag=kt";
	  	document.frm.submit();
		}
		else
		{
		 	return false;
		}	
	  
 }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20"  maxlength="12" colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>

	<tr id="div1">
		<td>�û��������Ѷ���״̬Ϊ�ر�</td>
		<td><input type="button" name="gb" class="b_foot" value="��ͨ" onclick="doKt()" ></td>
	</tr> 
	<tr id="div2">
		<td>�û��������Ѷ���״̬Ϊ��ͨ</td>
		<td><input type="button" name="gb" class="b_foot" value="�ر�" onclick="doGb()" ></td>
	</tr> 

	<!--xl add for lidsa begin-->
	<tr id="div3">
		<td>�û�������״̬Ϊ�ر�</td>
		<td><input type="button" name="kt" class="b_foot" value="��ͨ" onclick="qqw_Kt()" ></td>
		
	</tr> 
	<tr id="div4">
		<td>�û�������״̬Ϊ��ͨ</td>
		<td><input type="button" name="gb" class="b_foot" value="�ر�" onclick="qqw_Gb()" ></td>
	</tr>
	<!--xl add for lidsa end-->
	 
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="query_id" name="query" class="b_foot" value="״̬��ѯ" onclick="docheck()" >
          &nbsp;
		   <input type="button" id="query_id" name="query" class="b_foot" value="�Ż���Ϣ���ѱ����¼��ѯ" onclick="doqry()" >
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