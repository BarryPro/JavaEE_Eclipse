<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.15
 ģ��:Ԥ�滰�������-����
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ԥ�滰�������-����</title>
<%
	
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("activePhone");

%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
 
  onload=function()
  {
 	self.status="";
  }

//----------------��֤���ύ����-----------------
function doCfm()
{
  if(check(frm))
  {
    frm.action="f1292Main.jsp";
    frm.submit();	
  }
}
</script>
</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>   
  	
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0">
    <tr> 
        <td class="blue"> 
          <div align="left">�������</div>
        </td>
      <td> 
        <div align="left"> 
                <input class="InputGrey"  type="text" size="12" value="<%=phoneNo%>" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" readOnly index="0">
      </td>
    </tr>       
	<tr> 
		<td colspan="4" id="footer"> 
			<div align="center"> 
			<input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
			</div>
		</td>
    </tr>
</table>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
   <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>