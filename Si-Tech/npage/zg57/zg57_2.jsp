
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "zg57";
	String opName = "������ϢͶ�߹ػ�";   
	String regionCode = (String)session.getAttribute("regCode");  //���Ź���    
	String workno=(String)session.getAttribute("workNo");         //����         
	String sysAccept = getMaxAccept();
%>
<HTML>
	<HEAD>
		<TITLE>������BOSS-������ϢͶ�߹ػ�</TITLE>
		<script language="JavaScript">
			<!--
			function dosubmit() {
				getAfterPrompt();
				if(form.fileName.value.length<1){
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
        if(document.all.shandlingtype.value == "")
				{
					rdShowMessageDialog("����ԭ�򲻿�Ϊ�գ�");
					return false;
				}
				if(document.all.sSourceData.value == "")
				{
					rdShowMessageDialog("�Ӻ����Ͳ���Ϊ�գ�");
					return -2;
				}
				if(document.all.sSourceType.value == "")
				{
					rdShowMessageDialog("������Դ����Ϊ�գ�");
					return -3;
				}

				setOpNote();
				frmCfm();
				return true;
			}
			
			function setOpNote()
			{
				if(document.all.opNote.value=="")
				{
				  document.all.opNote.value = "����Ա��"+document.all.loginNo.value+"�����˲�����ϢͶ�߹ػ���Ϣ��������"; 
				}
				return true;
			}	
			
			function frmCfm()
			{
				document.form.action="zg57_2_upload.jsp?remark="+document.form.opNote.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>" ; 
				document.form.action+="&shandlingtype="+document.form.shandlingtype.value ; 
				document.form.action+="&sSourceData="+document.form.sSourceData.value ;
				document.form.action+="&sSourceType="+document.form.sSourceType.value ;
				document.form.action+="&blackReason="+document.form.opNote.value ;

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
		<FORM action="zg57_2_upload.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---������ϢͶ�߹ػ��������û�</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	        <tr> 
	            <td class="blue" align=center width="10%">��������</td>
	            <td width="40%">
	            	<input type="text" size="30" class="InputGrey" readonly value="���������������Ϣ����">
	            </td>				               		              
		          <td class="blue" align=center width="10%">�����ļ�</td>
		          <td width="40%"> 
	            	<input type="file" name="fileName">
	            	<font color="#FF0000">*</font>
	            </td>
	      	</tr>
	      	<!--huangrong add ���ڱ�־ ����ҳ����ʽ�޸� 2011-6-29-->
		    	<tr> 
		      	<td class="blue" align=center width="10%">����ԭ��</td>		        
				    <td class="blue" width="20%">
				    	<select name="shandlingtype" id="shandlingtype" class="button" >
				    		<option value="0101">���ι���Υ��</option>
				    		<option value="0102">�˹����Υ��</option>
				    		<option value="0103" selected >Ͷ��</option>
				    		<option value="0104">�˹�����</option>
				    		<option value="0105">����</option>
				    	</select>
				    </td>	      	
				    <!--end add ���ڱ�־ 2011-6-29-->	
			       	  <TD class="blue" align=center width="10%">�Ӻ�����</TD>
					    <td class="blue" width="20%">
					    	<select name="sSourceData" id="sSourceData" class="button" >
					    		<!--<option value="" selected>��ѡ��</option>   huangrong ��ע 2011-6-21 -->
					    		<option value="01">��������</option>
					    		<option value="02" selected>ɧ�ŵ绰</option>
					    		<option value="03" >��������</option>
					    	</select>
					    </td>    
		      </tr>	

	           <TR id="bltys"  > 
	          <TD width="10%" class="blue" align=center >������Դ</TD>
              <TD colspan="5">
                 <select id="sSourceType" name="sSourceType" style="width:100px;">
	    		<option value="01">ȫ�����ƽ̨</option>
	    		<option value="02" >ʡ�ڼ��</option>
	    		<option value="03" >�ٱ�����</option>
	    		<option value="04" selected>�û�Ͷ��</option>
									</select>

	          </TD>
	          </TR> 
		      	    <TR id="bltys"  > 
		      	   <td class="blue" align=center width="10%">������ע</td>
	    <td width="90%" class="blue" colspan="5">
	    	<input class="button" type="text" name="opNote" id="opNote" value="" size="140" maxlength="70">
	    	<!--huangrong add �޸�ҳ��չʾ��ʽ������ԭ�������70������ 2011-6-21 -->
	    </td>

	          </TR>       	
	      </tbody> 
	    </table>
	    
     <table  cellspacing="0">
	   	<tbody> 
	      <tr> 
	      	<td colspan="3">˵����<br>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�˴���������ʱ�����/�޸ı�־���̶������</font>��<br><!--huangrong update ��ע��Ϣ��ɾ���������ڱ�־���̶��ǳ��ڹ�ͣ������ 2011-6-29-->
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ�������������������������ܺ����û�����ʧ��</font>:<br>
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
	            <input class="b_foot" name=goBack type=button  value=���� onClick="location='zg57.jsp'">
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


