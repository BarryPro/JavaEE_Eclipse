<%
  /*
   * ����:Ӫҵ����mac��ַ������--�ļ���������
   * �汾: 1.0
   * ����: 2009/12/21
   * ����: gaolw
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "8363";
	String opName = "Ӫҵ����mac��ַ������";   
	String regionCode = (String)session.getAttribute("regCode");  //���Ź���    
	String workno=(String)session.getAttribute("workNo");         //����         
	String sysAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
  sysAccept = sLoginAccept;
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-Ӫҵ����mac��ַ������</TITLE>
		<script language="JavaScript">
			<!--
			function dosubmit() {
				getAfterPrompt();
				if(form.fileName.value.length<1)
				{
					rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
					document.form.fileName.focus();
					return false;
				}
				
				var formFile=form.fileName.value.lastIndexOf(".");
				var beginNum=Number(formFile)+1;
				var endNum=form.fileName.value.length;
				formFile=form.fileName.value.substring(beginNum,endNum);
				formFile=formFile.toLowerCase(); 
                if(formFile!="txt")
                {
                	rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ�������ļ���");
        					document.form.fileName.focus();
        					return false;
                }

				setOpNote();
				frmCfm();
				return true;
			}
			
			function setOpNote()
			{
				if(document.all.opNote.value=="")
				{
				  document.all.opNote.value = "����Ա��"+document.all.loginNo.value+"��������������Ӫҵ����mac��ַ�󶨹�ϵ"; 
				}
				return true;
			}	
			
			function frmCfm()
			{
				document.form.action="f8363_import1.jsp?remark="+document.form.opNote.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>";
				document.form.submit();
				document.form.confirm.disabled=true;
				document.form.clear.disabled=true;	
				document.form.goBack.disabled=true;	
				document.form.colse.disabled=true;			
			}
			
		//-->
		</script>
	</HEAD>
	<BODY>
		<FORM action="f8363_import1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">��������Ӫҵ����mac��ַ�󶨹�ϵ</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	        <tr> 
	            <td class="blue" align=center width="10%">��������</td>
	            <td width="40%">
	            	<input type="text" size="30" class="InputGrey" readonly value="��������Ӫҵ����mac��ַ�󶨹�ϵ">
	            </td>				               		              
		          <td class="blue" align=center width="10%">�����ļ�</td>
		          <td width="40%"> 
	            	<input type="file" name="fileName">
	            	<font color="#FF0000">*</font>
	            </td>
	      	</tr>
		    	<tr> 
		      	<td class="blue" align=center width="10%">������ע</td>
		        <td> 
		        	<input name=opNote size=60 maxlength="60" width="90%">
		        </td>				            
		      </tr>	      	
	      </tbody> 
	    </table>
	    
     <table  cellspacing="0">
	   	<tbody> 
	      <tr> 
	      	<td colspan="3">˵����<br>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ��������������������Ӫҵ����mac��ַ�󶨹�ϵ����ʧ��</font>:<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ӫҵ������ �ո� mac��ַ �ո� IP��ַ �ո� ���䷽ʽ<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;326467 00FF43EFAC7A 10.0.0.1 ����<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;326467 00FF43EFAC7B 10.0.0.2 ����<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;326467 00FF43EFAC7C 10.0.0.3 ����
	        </td>
	      </tr>
	    </tbody> 
    </table>
    
    <table  cellspacing="0">
	    <tbody> 
	      <tr> 
	          <td id="footer" > 
	            <input class="b_foot" name=confirm type=button value=ȷ�� onClick="dosubmit()">
	            &nbsp;	            
	            <input class="b_foot" name=clear type=reset value=���>
	            &nbsp;	
	            <input class="b_foot" name=goBack type=button  value=���� onClick="location='f8363_1.jsp'">
	            &nbsp; 	            	                  
	            <input class="b_foot" name=colse type=reset value=�ر� onClick="removeCurrentTab()">
	            &nbsp; 
	           </td>
	      </tr>
	    </tbody> 	            
  </table>	
		  
 <input type="hidden" name="regCode" value="01" >
 <input type="hidden" name="loginNo" value="<%=workno%>">
 <input type="hidden" name="op_code" value="<%=opCode%>">
 <input type="hidden" name="inputFile" value="">
 <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>


