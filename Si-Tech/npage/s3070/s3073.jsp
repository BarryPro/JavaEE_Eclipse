<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.10
 ģ�飺���ڿ�����
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String op_code = "1373";
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-���ڿ������ֵ</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>

<script language="JavaScript">
<!--
function isKeyNumberdot(ifdot) 
{
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else 
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('���������븺ֵ,����������!');
		    return false;
		}
		else
			  return false;
    }
}
function form_load()
{
	//document.form.sure.disabled=true;
	document.form.cardno.focus();
	document.all.sure.disabled=true;	
}

function isNumberString (InString,RefString)
{
	if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf (TempChar, 0)==-1)  
		return (false);
	}
	return (true);
}

function docheck()
{
	if(form.passwd.value.length<5 &&(form.cardno.value.length<11 || isNumberString(form.cardno.value,"1234567890")!=1)) {
		rdShowMessageDialog("������������,����Ϊ11λ����,��ֱ�������ʺ� !!")
		document.form.cardno.focus();
		return false;
	}
	else {
		document.form.action="s1373_select.jsp";
		form.submit();
		return true;
	}
}

function getcount()
{	
	if(isNumberString(form.cardno.value,"1234567890")!=1 ) {
		rdShowMessageDialog("��������ȷ�Ŀ���!!")
		document.form.cardno.focus();
		return false;
	}	
	else {
		document.form.action="s1373_select.jsp";
		form.submit();
		return true;
	}
}
function sel1()
 {
	document.all.cardno.focus();
	document.all.busy_type.value = "1";
 }
function sel2()
 {
	document.all.cardno.focus();
	document.all.busy_type.value = "2";
 }
//-->
</script>
</HEAD>

<BODY onLoad="form_load();">
<FORM action="s1373_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<input type="hidden" name="busy_type"  value="1">
<input type="hidden" name="op_code"  value="<%=opCode%>">
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="opName"  value="<%=opName%>">

              <table cellspacing="0">
                <tr> 
                  <td class="blue">���ڿ���</td>
                  <td> 
                    <input type="text" name="cardno" maxlength="20" onkeydown="if(event.keyCode==13)document.form.passwd.focus()" onKeyPress="return isKeyNumberdot(0)">
                    <input class="b_text" name=sure22 type=button value=��֤���� onClick="getcount();">
                  </td>
                  <td class="blue">����</td>
                  <td> 
                    <input type="text" maxlength="20" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)getcount()" name="passwd">                    
                  </td>
                </tr>                
              </table>
           <table cellspacing="0">
              <tbody> 
              <tr> 
                <td id="footer"> 
                  <input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck()">
				  <input class="b_foot" name=clear type=reset value=��� >
                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
                </td>
              </tr>
              </tbody> 
            </table>
     <%@ include file="/npage/include/footer_simple.jsp" %>   
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>
</BODY>

