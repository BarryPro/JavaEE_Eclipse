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
		String opCode = "zg70";
		String opName = "ʡ�����Ź�ϵ����";
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
	var login_no = document.all.login_no.value;
	if(login_no=="")
    {
		rdShowMessageDialog("������ʡ������!");
		return false;
	}
	else
	{
		//1. չʾ��� ���δ��� ���չʾ��Ӱ�ť ����������չʾɾ����ť��
		//2. ����ǰ������ȷ���� �Ƿ�ʡ�����ŵ��˷�Ȩ�޶�����800001�� �����жϹ���Ȩ��(���������)
		document.frm.action="zg70_2.jsp?sjgh="+login_no;
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
  	
	
	<div class="title">
			<div id="title_zi">�����빤��</div>
	</div>
	

	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">ʡ������</td>
      <td> 
        <input class="button"type="text" name="login_no" size="14" maxlength="6" >
      </td>
      
    </tr>
	
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="xnjttj()" >
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