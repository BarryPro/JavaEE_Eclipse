<%
  /*
   * ����:�������������ܺ������ۺ�������������Ĺ���
   * �汾: 1.0
   * ����: 2011/05/31
   * ����: huangrong
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "6945";
	String opName = "�������������ܺ������ۺ�����";   
	String regionCode = (String)session.getAttribute("regCode");  //���Ź���    
	String workno=(String)session.getAttribute("workNo");         //����         
	String sysAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
  sysAccept = sLoginAccept;
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-��������������������ܺ������ۺ�������</TITLE>
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
        //huangrong add ��֤���ڱ�־����Ϊ�� 2011-6-29
        if(document.all.delayType.value == "")
				{
					rdShowMessageDialog("��ѡ�����ڱ�־��");
					return false;
				}
				//end add ��֤���ڱ�־����Ϊ�� 2011-6-29
				setOpNote();
				frmCfm();
				return true;
			}
			
			function setOpNote()
			{
				if(document.all.opNote.value=="")
				{
				  document.all.opNote.value = "����Ա��"+document.all.loginNo.value+"�������������������ܺ������ۺ�������Ϣ��������"; 
				}
				return true;
			}	
			
			function frmCfm()
			{
				var seled =$("#seled").val()
				document.form.action="s6945_3Upload.jsp?remark="+document.form.opNote.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&delayType="+document.form.delayType.value+"&seled="+seled;
				document.form.submit();
				document.form.confirm.disabled=true;
				document.form.clear.disabled=true;	
				document.form.goBack.disabled=true;	
				document.form.colse.disabled=true;			
			}
			
		//-->
		function changType()
{
				var typeflag =$("#delayType").val()
				if(typeflag=="F") {
				$("#seled").empty();
				$("#seled").append("<option value='02' selected>ʡ�ڼ��</option><option value='04'>�û�Ͷ��</option>");
			  }
			   else if(typeflag==""){
			  $("#seled").empty();
				$("#seled").append("<option value='' selected>--��ѡ��--</option>");
			  }
			  else {
			  $("#seled").empty();
				$("#seled").append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
			  }
}
onload=function()
{
	init();
}

function init()
{
				var typeflag =$("#delayType").val()
				if(typeflag=="F") {
				$("#seled").empty();
				$("#seled").append("<option value='02' selected>ʡ�ڼ��</option><option value='04'>�û�Ͷ��</option>");
			  }
			  else if(typeflag==""){
			  $("#seled").empty();
				$("#seled").append("<option value='' selected>--��ѡ��--</option>");
			  }
			  else {
			  $("#seled").empty();
				$("#seled").append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
			  }
}
		</script>
	</HEAD>
	<BODY>
		<FORM action="s6945_3Upload.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---����������������ܺ������û�</div>
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
		      	<td class="blue" align=center width="10%">���ڱ�־</td>		        
				    <td width="40%" class="blue">
				    	<select name="delayType" id="delayType" class="button" onChange="changType()">
				    		<option value="" selected>��ѡ��</option>
				    		<option value="Y">����7��</option>
				    		<option value="N">��ͣ7��</option>
				    		<option value="T">���ڹ�ͣ</option>
				    		<option value="F">�����ָ�</option>
				    	</select>
				    	<font color="#FF0000">*</font>
				    </td>		      	
				    <!--end add ���ڱ�־ 2011-6-29-->	
			       	  <TD class="blue" align=center width="10%">������Դ</TD>
              <TD >
                 <select id="seled" style="width:100px;">
									</select>

	          </TD>     
		      </tr>	
		      	    <TR id="bltys"  > 
		      	   <td class="blue" align=center width="10%">������ע</td>
		        <td colspan="3"> 
		        	<input name=opNote size=60 maxlength="60" width="40%">
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
	            <input class="b_foot" name=goBack type=button  value=���� onClick="location='s6945Login.jsp'">
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


