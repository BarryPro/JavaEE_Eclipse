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
		String opCode = "zgb9";
		String opName = "Ƿ�ѷ�Ʊ����";
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
	var tax_no = document.frm.tax_no.value;
	var tax_code = document.frm.tax_code.value;
	if(tax_no=="")
	{
		rdShowMessageDialog("������רƱ����!");
		return false;
	}
	else if (tax_code=="")
	{
		rdShowMessageDialog("������רƱ����!");
		return false;
	}
	else
	{
	}
	document.frm.action="zgb9_qry.jsp?tax_no="+tax_no+"&tax_code="+tax_code;
		//alert(document.frm.action);
	document.frm.submit();
	
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
      <td class="blue" width="15%">��ֵ˰רƱ����</td>
      <td> 
        <input class="button"type="text" name="tax_no" size="20"   onKeyPress="return isKeyNumberdot(0)">
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ֵ˰רƱ����</td>
      <td> 
        <input class="button"type="text" name="tax_code" size="20"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
    </tr>
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="רƱ��Ϣ��ѯ" onclick="xnjttj()" >
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