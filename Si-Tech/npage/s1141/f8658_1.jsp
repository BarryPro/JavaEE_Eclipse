 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-20 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "8658";	
	String opName = "�����޸�IMEI�󶨹�ϵ";	//header.jsp��Ҫ�Ĳ���   
	String regionCode = (String)session.getAttribute("regCode");       
	
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	//out.println(workno);
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-�����޸�IMEI�󶨹�ϵ</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
			{
				//form.sure.disabled=true;
				}
				function dosubmit() {
					getAfterPrompt();
				if(form.feefile.value.length<1)
				{
					rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
					document.form.feefile.focus();
					return false;
				}
				else 
				{
					setOpNote();
					//alert(document.all.remark.value);
					document.form.action="f8658_2.jsp?remark="+document.form.remark.value;
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
				  document.all.remark.value = "����Ա��"+document.all.loginNo.value+"�����������޸�IMEI�󶨹�ϵ����"; 
				}
				return true;
			}	
			
			//-->
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="f8658_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�����޸�IMEI�󶨹�ϵ</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">��������</td>
				                <td width="30%" colspan="2">
					                    <input type="text" class="InputGrey" readonly value="�����޸�IMEI�󶨹�ϵ">
				                </td>				               		              
			                <td class="blue" align=center width="20%">�����ļ�</td>
			                <td width="30%" colspan="2"> 
			                  <input type="file" name="feefile">
			                </td>
		              	</tr>
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">������ע</td>
				                <td colspan="2"> 
				                  	<input class="InputGrey" name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">˵����<br>
				                  &nbsp;&nbsp;&nbsp;<font color="red">1�������ļ����ļ���ʽΪ��</font><br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ˮ �ո� �������� �ո� �û�ID �ո� �ֻ����� �ո� ��ͨʱ�� �ո� Imei����<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33158139439 126h 132043222845 13766779090 20080603 354343010758855<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;42425443519 1144 12074084700 13836019169 20080602 357949004194046<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;42431931671 126i 12074082241 13895825500 20081119 351799012237584<br>
				                  &nbsp;&nbsp;&nbsp;<font color="red">2��Ŀǰ���Խ�������������Ӫ����ֻ�����¼�����</font><br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1141����Ԥ�滰���Żݹ��� <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7955�������������ѣ����·�����Ӫ���� <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8044����������ũ�������� <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8027�������ֻ��ͻ��� <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d069������Լ�ƻ�Ԥ�湺�� <br>
				                  <%/*begin add ���Ӻ�Լ�ƻ�����(e505),�Ա�����Լ�ƻ�(e528) by diling @2012/5/21*/%>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e505������Լ�ƻ����� <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e528�����Ա�����Լ�ƻ� <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e720������������-�����ƻ� <br>
				                  <%/*end add by diling @2012/5/21*/%>
				                </td>
			              </tr>
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=ȷ�� onClick="dosubmit()">
				                  &nbsp;
				                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>
