<%
  /*
   * ����:��ɧ�ŵ绰�û����������ر���������
   * �汾: 1.0
   * ����: 2010/07/13
   * ����: sungq
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "g247";
	String opName = "�ֹ���ֵ������";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - ��ˮ��"+sysAccept);
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-�ֹ���ֵ������</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
			{
				init();
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
					var seled = $("#seled").val();
					document.form.action="g247_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&seled="+seled;
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
				  document.all.remark.value = "����Ա��"+document.all.loginNo.value+"�����˳�ֵ������������Ϣ����"; 
				}
				return true;
			}	
			
			//-->
		function returnBefo() {
		  window.location.href = "finner_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		
		function init()
		{
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
		}
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="g247_cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---�ֹ���ֵ������</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">��������</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="�ֹ���ֵ������������Ϣ����">
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
					  <!--
		              	 <TR id="bltys"  > 
						          <TD class="blue" align=center width="20%">������Դ</TD>
					              <TD >
					                 <select id="seled"  style="width:100px;">
														</select>
					
						          </TD>
						          </TR> 
						-->
			              <tr> 
				                <td class="blue" align=center width="20%">������ע</td>
				                <td colspan="2"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">˵����<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ����������޷���ֵ���ָ���Ϊ"|"��</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">���б���Ϊregion_code����������Ϊ01,�������Ϊ02���Դ����ơ�</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���б���|�ֻ�����|Ӫ�������|���й�˾�߻���|ʡ��˾�����ļ����|ʡ��˾�����ļ�����|��ֵ��Ч��ʼʱ��|��ֵ��Ч����ʱ��|�ƻ���ֵ���  �س�<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;01|15004675829|Ӫ�������|����|�����ļ����|�����ļ�����|20121001|20131001|1000<br> 
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
				                 <input type="button" name="rets" class="b_foot" value="����" onClick="returnBefo()"/>
				                  &nbsp;			                  
				                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		  
		   <input type="hidden" name="regCode" value="01" >
		   <input type="hidden" name="sysAccept" value="1234" >  
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		   <input type="hidden" name="inputFile" value="">
		   
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

