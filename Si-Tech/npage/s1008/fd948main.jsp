<%
  /*
   * ����: �����ָ��ͻ��������� d948
   * �汾: 1.0
   * ����: 2011/06/23
   * ����: huangrong
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "d948";
	String opName = "�����ָ��ͻ���������";   
	String regionCode = (String)session.getAttribute("regCode");  //���Ź���    
	String workno=(String)session.getAttribute("workNo");         //����         
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-�����ָ��ͻ���������</TITLE>
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
				  document.all.opNote.value = "����Ա��"+document.all.loginNo.value+"�����˻ָ��ͻ��������ܵ�������Ϣ����"; 
				}
				return true;
			}	
			
			function frmCfm()
			{
				var seled = $("#seled").val();
				document.form.action="fd948Upload.jsp?remark="+document.form.opNote.value+"&regCode="+"<%=regionCode%>"+"&seled="+seled;
				document.form.submit();
				document.form.confirm.disabled=true;
				document.form.clear.disabled=true;	
				document.form.colse.disabled=true;			
			}
			
		//-->
				function returnBefo() {
		  window.location.href = "finner_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
				function init()
		{
				$("#seled").empty();
				$("#seled").append("<option value='02' selected>ʡ�ڼ��</option><option value='04'>�û�Ͷ��</option>");
		}
		onload=function()
{
	init();
}
		</script>
	</HEAD>
	<BODY>
		<FORM action="f1008cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---�����ָ��ͻ���������</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	        <tr> 
	            <td class="blue" align=center width="20%">��������</td>
	            <td width="30%" colspan="2">
	            	<input type="text" size="30" class="InputGrey" readonly value="���������������Ϣ����">
	            </td>				               		              
		          <td class="blue" align=center width="20%">�����ļ�</td>
		          <td width="30%" colspan="2"> 
	            	<input type="file" name="fileName">
	          </td>
	      	</tr>
	      </tbody> 
	    </table>
	    
     <table  cellspacing="0">
	   	<tbody> 
	   				              	 <TR id="bltys"  > 
						          <TD class="blue" align=center width="20%">������Դ</TD>
					              <TD >
					                 <select id="seled"  style="width:100px;">
														</select>
					
						          </TD>
						          </TR> 
	    	<tr> 
	      	<td class="blue" align=center width="20%">������ע</td>
	        <td colspan="2"> 
	        	<input name=opNote size=60 maxlength="60" >
	        </td>
	      </tr>
	      <tr> 
	      	<td colspan="3">˵����<br>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ��������ɴ���ָ��û�����������</font>: <br>
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
	            <input class="b_foot" name=confirm type=button value=ȷ�� onClick="dosubmit()">
	            &nbsp;	            
	            <input class="b_foot" name=clear type=reset value=���>
	            &nbsp;
				      <input type="button" name="rets" class="b_foot" value="����" onClick="returnBefo()"/>
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


