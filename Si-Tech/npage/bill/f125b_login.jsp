<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.1.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<head>
<title>���еش��������</title>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = (String)request.getParameter("activePhone"); 
	
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
    //document.all.srv_no.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  document.frm.confirm.disabled=true;
  if(!check(frm))
  {
    document.frm.confirm.disabled=false;
	return false;
  }
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    frm.action="f125bMain.jsp";
	  }
	  else if(opFlag=="two")
	  {
	    frm.action="f125cMain.jsp";
	  }
	  else if(opFlag=="three")
	  {
	    frm.action="f7119Main.jsp";
	  }
	}
  }
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		 <TR> 
	          <TD class="blue">��������</TD>
              <TD>
			       <input type="radio" name="opFlag" value="one" checked>����&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" >����&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="three" >ȡ��&nbsp;&nbsp;
	          </TD>
         </TR>
         <tr> 
            <td class="blue"> 
              <div align="left">�ֻ�����</div>
            </td>
            <td> 
            <div align="left"> 
                <input class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
            </td>
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
      <input type="hidden" name="opCode" value="<%=opCode%>" >
      <input type="hidden" name="opName" value="<%=opName%>" >
      <input type="hidden" name="returnPage" value="f125b_login.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>">
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>