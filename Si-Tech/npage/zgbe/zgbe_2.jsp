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
		String opCode = "zgbe";
		String opName = "רƱ�����ϵ����";
 		String cphm = request.getParameter("phone_no");

%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjtcx()
{
	var phoneNo = document.frm.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("�����뼯�������˺�!");
		return false;
	}
	else
	{
		//alert(phoneNo);
		var myPacket = new AJAXPacket("zg44_check.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(myPacket,doPosSubInfo3);
		myPacket=null;
	}
}
 

 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zgbe_1.jsp';
 }
 

 function cyzhtj()//��Ա���
 {
	 //�ǿռ���
	 var cphm = document.all.cphm.value;
	 var s_tax_no = document.all.s_tax_no.value;
	 var s_tax_name = document.all.s_tax_name.value;
	 var s_tax_address = document.all.s_tax_address.value;
	 var s_tax_phone = document.all.s_tax_phone.value;
	 var zh = document.all.zh.value;
	 var bz = document.all.bz.value;
	 var khh = document.all.khh.value;
	 if(s_tax_no=="" ||s_tax_name=="" ||s_tax_address=="" ||s_tax_phone=="" ||zh=="" ||khh=="")
	 {
		rdShowMessageDialog("��������˰��ʶ����롢��ַ���绰�������С��˺ŵ���Ϣ!");
		return false;
	 }	
	 else
	 {
		//����ȷ��
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("�Ƿ�ȷ���������⼯����Ӳ���?");
		if (prtFlag==1)
		{
			document.frm.action="zgbe_add.jsp?cphm="+cphm+"&s_tax_no="+s_tax_no+"&s_tax_name="+s_tax_name+"&s_tax_address="+s_tax_address+"&s_tax_phone="+s_tax_phone+"&zh="+zh+"&bz="+bz+"&khh="+khh;//չʾ������Ϣ ����staxtailadd�ӿڽ���¼��
			document.frm.submit();
		}
		else
		{
			return false;
		}
	 }	
	 //���ýӿ�
	
 }
 
 
 

  
 </script> 
 
<title>��Ա��Ϣ���</title>
</head>
<BODY >
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
  <table cellspacing="0">
    <tr>
		<td class="blue" width="15%">��Ʒ����</td>
		<td> 
			<input type="text"  name="cphm" value="<%=cphm%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">��˰��ʶ�����</td>
		<td> 
			<input type="text"  name="s_tax_no" size="24" maxlength="24"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">��˰������</td>
		<td> 
			<input type="text"  name="s_tax_name" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">��ַ</td>
		<td> 
			<input type="text"  name="s_tax_address" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">�绰</td>
		<td> 
			<input type="text"  name="s_tax_phone" size="24" maxlength="24"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">������</td>
		<td> 
			<input type="text"  name="khh" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">�˺�</td>
		<td> 
			<input type="text"  name="zh" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">��ע</td>
		<td> 
			<input type="text"  name="bz" size="134" maxlength="134"  >
		</td>
	</tr> 

 
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="tj" name="query" class="b_foot" value="��Ա���"   onclick="cyzhtj()" >
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