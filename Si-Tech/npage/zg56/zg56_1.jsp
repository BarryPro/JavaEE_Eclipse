   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-25
********************/
%>
              
<%
  String opCode = "zg56";
  String opName = "�û���Ʊ����ѯ";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.util.DateTrans"%>
<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
		activePhone = request.getParameter("activePhone");
 
%>
<HTML>
<HEAD>

<script language="JavaScript">
<!--
 

function docheck()
{ 
	document.frm.action="zg56_2.jsp";
	document.frm.submit();
}


function doclear() {
	frm.reset();
}

function load_t()
{
document.frm.phoneNo.focus();
-->
}

 </script>

<title>������BOSS-�ʵ���ӡ </title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onload="load_t()">
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">�ɷѹ���</div>
	</div>

 
 
		<table cellspacing="0">
			 

			<tr id="tb1" style="display:"> 
				<td class="blue">������� </td>
				<td > 
					<input type="text" value="<%=activePhone%>" name="phoneNo"  readonly>
				</td>
				  
			 
			</tr>

			 

			 
 

		</table>
 
        <TABLE  cellSpacing="0">
          <TR >
            <TD noWrap    align="center">
                 <input type="button" name="query" class="b_foot"  value="��ѯ" onclick="docheck()" index="9">
                &nbsp;
                <input type="button" name="return1" class="b_foot"   value="���" onclick="doclear()" index="10">
                &nbsp;
                <input type="button" name="return2"  value="�ر�"  class="b_foot" onClick="removeCurrentTab()" index="13">
             </TD>
          </TR>
        </TABLE>
 
<%@ include file="/npage/include/footer.jsp" %>
</form>


</BODY>
</HTML>