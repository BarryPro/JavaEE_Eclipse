<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.23
 ģ��: BOSS��V����Ա���ֻ���ɾ��
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  request.setCharacterEncoding("GBK");
%>

<head>
<title>BOSS��V����Ա���ֻ���ɾ��</title>
<%
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	String phoneNo  =request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    //document.all.phone_no.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	getAfterPrompt();	 
	/***
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    frm.action="s3609_2.jsp";
	  }else if(opFlag=="two")
	  {
	    frm.action="s3609_2.jsp";
	  }
	}
  }
  ***/
  
  frm.action="s3609_3.jsp?phoneNo="+document.frm.phone_no.value;
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" action="s3609_3.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
         <tr> 
            <td class="blue"> 
              	<div align="left">�ֻ�����</div>
            </td>
            <td> 
                <input class="InputGrey"  type="text" size="12" name="phone_no" value="<%=phoneNo%>" id="phone_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" readOnly>
            </td>
         </tr>
         <tr> 
            <td colspan="2"> 
              <div align="center" id="footer"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <!--<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">-->
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
     <%@ include file="/npage/include/footer.jsp" %>   
     <input type="hidden" name="opCode" value="<%=opCode%>">
     <input type="hidden" name="opName" value="<%=opName%>">
   </form>
</body>
</html>
