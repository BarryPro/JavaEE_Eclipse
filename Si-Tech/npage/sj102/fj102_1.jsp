<%
  /*
   * ����:6995����������������
   * �汾: 1.0
   * ����: 2015/06/18
   * ����: wangwg
   * ��Ȩ: si-tech
  */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "J102";
	String opName = "6995����������������";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	String sysAccept = "";
%>

<HTML>
	<HEAD>
		<TITLE>6995����������������</TITLE>
		<script language="JavaScript">
		function dosubmit() {
			if(form.feefile.value.length<1)
			{
				rdShowMessageDialog("�����ļ�����������ѡ�������ļ���",0);
				document.form.feefile.focus();
				return false;
			}
			else 
			{
				setOpNote();
				document.form.action="fj102_2.jsp?remark="+document.form.remark.value;
				document.form.submit();
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
				return true;
			}
		}
		function setOpNote()
		{
			if(document.all.remark.value=="")
			{
			  document.all.remark.value = "����Ա��"+"<%=workno%>"+"����������6995ҵ�񶩹�"; 
			}
			return true;
		}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fj102_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
                                <div id="title_zi">6995����������������</div>
			</div>
			<table  cellspacing="0">
				<tbody> 
					<tr> 
						<td class="blue" align=center width="20%">�����ļ�</td>
						<td width="30%" colspan="2"> 
							<input type="file" name="feefile">
						</td>
					</tr>
					<tr> 
						<td class="blue" align=center width="20%">������ע</td>
						<td colspan="2"> 
							<input name=remark size=60 maxlength="60" >
						</td>
					</tr>
					<tr> 
						<td colspan="3">˵����<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ��������ɴ��󶩹�6995����ҵ��</font>:<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ֻ�����  �س�<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13604511111 <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13704511111 <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13804511111 <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13904511111 
						</td>
					</tr>
				</tbody> 
			</table>
			<table  cellspacing="0">
				<tbody> 
					<tr> 
						<td id="footer" > 
							<input class="b_foot" name=sure type=button value=ȷ�� onClick="dosubmit()">
							<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
		</FORM>
	</BODY>
</HTML>
