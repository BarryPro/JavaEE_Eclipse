<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��վԤԼ�����ѯ
   * �汾: 1.0
   * ����: 2011-11-8 8:15:06
   * ����: zhangyan
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//����
	String opCode="e407";
	String opName="��վԤԼ�����ѯ";
	String phoneNo = (String)request.getParameter("activePhone");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ҵ���ѯ-��վԤԼ�����ѯ</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<form action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��վԤԼ�����ѯ</div>
</div>
<div>
	<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
		<td  class="blue">
			<input type = "text" name = "phone_no" id = "phone_no" value = "">
		</td>
		<td class="blue">ԤԼID</td>
		<td  class="blue">
			<input type = "text" name = "booking_id" id = "booking_id" value = "">
		</td>
	</tr>
	
	<tr>
		<td align=center colspan="4"> 
			<input class="b_foot" name=sure  type=button value="��ѯ" onClick="pageSubmit()" >
			<input class="b_foot" name=reset onClick="" type="reset" value="����">
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</div>
<div style="height:380px;overflow: auto" id="divBodyOne">
 	<IFRAME frameBorder=0 id="e407_list" name="e407_list" scrolling="yes"  
 		style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX:1">
	</IFRAME>
</div>	
</form>
</body>
</html>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
	
	function checkform()
	{
		var 	obj_phone_no = document.getElementById("phone_no");
		var 	obj_booking_id = document.getElementById("booking_id");
		
		if (""==obj_phone_no.value &&  ""==obj_booking_id.value)
		{
			rdShowMessageDialog("�ֻ������ԤԼID���ܶ�Ϊ�գ�", 0);
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function pageSubmit()
	{
		var 	obj_phone_no = document.getElementById("phone_no");
		var 	obj_booking_id = document.getElementById("booking_id");
		var 	obj_e407_list = document.e407_list;

		if ( !checkform ())
		{
			return false;
		}

		obj_e407_list.location="fe407_2.jsp?phone_no="+obj_phone_no.value
			+"&booking_id="+obj_booking_id.value;
	}
</script>



