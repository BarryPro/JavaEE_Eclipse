<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �˻�ת��1364
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
	String opCode="g377";
	String opName="���г�ֵ����˻����ת��";
	String phoneno = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	 boolean pwrf = false;
  //2011/9/2  diling ��� ������Ȩ������ start
  	String pubOpCode = opCode;
  %>
  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
  <%
  	System.out.println("==�ڶ���======s1364.jsp==== pwrf = " + pwrf);
  //2011/9/2  diling ��� ������Ȩ������ end
	  
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-�ʻ�ת��</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->
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
	if(form.phoneno.value==""){
		rdShowMessageDialog("�������ֻ����� !!")
		document.form.phoneno.focus();
		return false;
	}else if(form.contractno.value=="") {
		rdShowMessageDialog("�������ʺ� !!")
		document.form.contractno.focus();
		return false;
	}		/*HARVEST  wangmei xiugai ���ж��û������û�н��д�����˽����޸� 20060829*/

	/*20090422 liyan modify �Ŷθ���
	else if (form.contractno.value.length<5||parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>139&&parseInt(form.phoneno.value.substring(0,2),10) !=15)){
		rdShowMessageDialog("������134-139��15��ͷ�ķ������,��ֱ�������ʺ� !!")
		document.form.phoneno.focus();
		return false;
	} */
	else if (!checkPhone(form.phoneno.value) && form.contractno.value.length<5)
	{
		rdShowMessageDialog("<%=PhoneHeadErrMsg%>,��ֱ�������ʺ� !");
		return false;
	}
	else if (!form.accountpassword.disabled) {
	   if( form.accountpassword.value.length<1 || isNumberString(form.accountpassword.value,"1234567890")!=1 ) {
			rdShowMessageDialog("�������ʻ�����!!")
			document.form.accountpassword.focus();
			return false;
	   }else{
			document.form.action="g377_select.jsp";
			form.submit();
			return true;
	   }
	} else {
		  document.form.action="g377_select.jsp";
		  form.submit();
		  return true;
	 }
}
function getcount()
{

	if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 ) {
		rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		document.form.phoneno.focus();
		return false;
	}
	else if (parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>139&&parseInt(form.phoneno.value.substring(0,2),10)!=15&&parseInt(form.phoneno.value.substring(0,2),10)!=18&&parseInt(form.phoneno.value.substring(0,2),10)!=14)){
		rdShowMessageDialog("������134-139����15��ͷ�ķ������ !!")
		document.form.phoneno.focus();
		return false;
	}
	else {
		var h=480;
		var w=850;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var str=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value,"",prop);
		

		if( typeof(str) != "undefined" ){
			if (parseInt(str)==0){
		   		rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
		   		document.form.phoneno.focus();
		   		return false;
			} else {
				document.form.contractno.value=str;
				if (!document.form.accountpassword.disabled) {
				   document.form.accountpassword.focus();
				}

		   		return true;
			}
			return true;
		}
	}
}
 
	
	//  end 
//-->
 
</script>
</HEAD>

<BODY >
<FORM action="g377_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="busy_type"  value="1">
<!--xl add ������ ת�˺���-->
<input type="hidden" name="phone2">
<table cellspacing="0">
  
	<tr>
		<td class="blue">�������</td>
		<td>
			<input type="text" name="phoneno" maxlength="11" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)">
			<input class="b_text" name=sure22 type=button value=��ѯ�ʺ� onClick="getcount();">
		</td>
		<td class="blue">�ʻ�����</td>
		<td>
			<input type="text" class="button" maxlength="20" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.accountpassword.focus()" name="contractno">
		</td>
	</tr>
	
	<tr>
		<td class="blue">�ʻ�����</td>
		<td colspan="3">
			<%if(pwrf) {%>
			<input type="password" class="button" name="accountpassword" size="20" maxlength="8" disabled>
			<% } else { %>
			<jsp:include page="/npage/common/pwd_1.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="accountpassword" />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			<%}%>
		</td>
	</tr>
 
	<tr>
		<td align=center id="footer" colspan="4">
			<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=���>
			&nbsp;
			<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
			&nbsp;
		</td>
	</tr>
</table>

	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>

</HTML>