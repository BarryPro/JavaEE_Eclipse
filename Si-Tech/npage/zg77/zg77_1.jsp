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
		String opCode = "zg77";
		String opName = "���ŷ�Ʊ��ӡȡ��";
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
 
function zg45qry(opcode)
{
	var invoice_number = document.frm.invoice_number.value;
	var invoice_code = document.frm.invoice_code.value;
	var begin_ym = document.frm.begin_ym.value;
	var end_ym = document.frm.end_ym.value; 
	if(invoice_number=="")
	{
		rdShowMessageDialog("�����뷢Ʊ����!");
		return false;
	}
	else if (invoice_code=="")
	{
		rdShowMessageDialog("�����뷢Ʊ����!");
		return false;
	}
	else if (begin_ym=="")
	{
		rdShowMessageDialog("�������ѯ��ʼ����!");
		return false;
	}
	else if (end_ym=="")
	{
		rdShowMessageDialog("�������ѯ��������!");
		return false;
	}
	else
	{
		document.frm.action="zg77_2.jsp?invoice_number="+invoice_number+"&invoice_code="+invoice_code+"&op_code="+opcode+"&begin_ym="+begin_ym+"&end_ym="+end_ym;
		//alert(document.frm.action);
		document.frm.submit();
	}	
	
	
}
 


 function doclear() {
 		frm.reset();
 }
   
  
 
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��Ʊ����</td>
      <td> 
        <input class="button"type="text" name="invoice_number" size="20" maxlength="20"  onKeyPress="return isKeyNumberdot(0)">
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��Ʊ����</td>
      <td> 
        <input class="button"type="text" name="invoice_code" size="20" maxlength="20"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
    </tr>
	<!--xl add for liugang ����ʱ�䰴ť begin-->
	<tr> 
      <td class="blue" width="15%">��ѯ��ʼʱ��</td>
      <td> 
        <input class="button"type="text" name="begin_ym" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" >(YYYYMM)
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ѯ����ʱ��</td>
      <td> 
        <input class="button"type="text" name="end_ym" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" >(YYYYMM)
      </td>
    </tr>
	<!--end of liugang ��ѯ��ť-->

  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="Ԥ����Ʊ��Ϣ��ѯ" onclick="zg45qry('zg45')" >
          &nbsp;
		  <input type="button" name="query" class="b_foot" value="���ŷ�Ʊ��ӡ��Ϣ��ѯ" onclick="zg45qry('1322')" >
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