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
		String opCode = "zgbf";
		String opName = "רƱ�����ϵ����";
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
	
	var phoneNo = document.all.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("�������Ʒ����!");
		return false;
	}
	else
	{
		document.frm.action="zgbf_2.jsp?phone_no="+phoneNo;//չʾ������Ϣ ����staxtailadd�ӿڽ���¼��
		document.frm.submit();
	}
}
   


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zgbe_1.jsp';
 }

  
 
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��Ʒ����</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="24" maxlength="24"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) xnjttj();">
      </td>
      
    </tr>
	 
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��Ա��ѯ" onclick="xnjttj()" >
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