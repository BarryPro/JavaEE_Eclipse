<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
    String opCode = (String)request.getParameter("opCode");
   	String opName = (String)request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	


<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*"%>
<%  request.setCharacterEncoding("GBK"); %>


<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<HTML>
<HEAD>

<script language="JavaScript">
<!--	
	
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
		{
			rdShowMessageDialog("������������!");
	 	    document.frm.phoneNo.focus();
	 	    return false;
	    }	  
    if(document.frm.phoneNo.value.length != 11 )
		{
	        rdShowMessageDialog("�������ֻ����11λ!");
	 	    document.frm.phoneNo.value = "";
	 	    document.frm.phoneNo.focus();
	 	    return false;
	    }
		document.frm.action="s2287_1.jsp";
		document.frm.submit();
}
function doclear()
{
	frm.reset();
}
-->
 </script> 
 
<title>������BOSS-���еش����̻��ջ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���еش����ջ���</div>
	</div>
<input type="hidden" name="opCode" value="">


		     <table cellspacing="0">
		       <tr > 
                 <td class="blue">��������</td>
                 <td class="blue"> 
                 <input name="busyType" type="radio"  value="2287" checked  >
                  ��������
                 <input name="busyType" type="radio"  value="2288"  >
				  �������� 
				</td>

			   </tr>

                <tr > 
                  <td width="13%" nowrap  class="blue">�������</td>
                  <td width="35%"> 
                    <input type="text" name="phoneNo" size="20" maxlength="11"  value =<%=activePhone%>  Class="InputGrey" readOnly >	
                  </td>


                </tr>
              </table>

        <table cellspacing="0">
          <TR > 
            <TD noWrap align="center" id="footer"> 
                <input type="button" name="query" value="��ѯ" onclick="check_HidPwd()" class="b_foot">
                &nbsp;
                <input type="button" name="return1" value="���" onclick="doclear()" class="b_foot">
                &nbsp;
				<input type="button" name="return2" value="�ر�" onClick="removeCurrentTab()" class="b_foot">
             </TD>
          </TR>
        </TABLE>


<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
</HTML>
