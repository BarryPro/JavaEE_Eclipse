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
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String sopcode = request.getParameter("opcodes")==null ? "":request.getParameter("opcodes");
	String name = request.getParameter("name")==null ? "":request.getParameter("name");
	String code = request.getParameter("code")==null ? "":request.getParameter("code");
	String IDaddress = request.getParameter("IDaddress")==null ? "":request.getParameter("IDaddress");
	String bir_day = request.getParameter("bir_day")==null ? "":request.getParameter("bir_day");
	String sex = request.getParameter("sex")==null ? "":request.getParameter("sex");
	String idValidDate_obj = request.getParameter("idValidDate_obj")==null ? "":request.getParameter("idValidDate_obj");
	String picpath_n = request.getParameter("picpath_n")==null ? "":request.getParameter("picpath_n");
	String v_custId = request.getParameter("v_custId")==null ? "":request.getParameter("v_custId");
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-�����ָ��ͻ���������</TITLE>
		<script language="JavaScript">

			function dosubmit() {

				if(form.fileName.value.length<1)
				{
					rdShowMessageDialog("�ϴ���ͼƬ����Ϊ��������ѡ��");
					document.form.fileName.focus();
					return false;
				}
        if(form.fileName.value!=$("#tdval").html().trim())
        {
        	rdShowMessageDialog("�ϴ���ͼƬ�Ͷ�����ͼƬ����������ѡ��");
					document.form.fileName.focus();
					return false;
        }
				frmCfm();
				return true;
			}
			

			
			function frmCfm()
			{
				document.form.action="/npage/public/upLoadidCardPic.jsp?op_code=<%=sopcode%>&name=<%=name%>&code=<%=code%>&IDaddress=<%=IDaddress%>&bir_day=<%=bir_day%>&sex=<%=sex%>&idValidDate_obj=<%=idValidDate_obj%>&v_custId=<%=v_custId%>";
				document.form.submit();
		
			}
			
	

		</script>
	</HEAD>
	<BODY>
		<FORM action="" method=post name=form ENCTYPE="multipart/form-data">
   	
			<div class="title">
				<div id="title_zi">�ϴ����֤��Ϣ</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	      		 <tr> 			               		              
		          <td class="blue" align=center width="20%">�������ͼƬ·��Ϊ��</td>
		          <td width="30%" id="tdval"> 
	            	<%=picpath_n%>
	          </td>
	      	</tr>
	        <tr> 			               		              
		          <td class="blue" align=center width="20%">���֤ͷ��ͼƬ�ļ�</td>
		          <td width="30%" colspan="2"> 
	            	<input type="file" name="fileName">
	          </td>
	      	</tr>
	      </tbody> 
	    </table>

    
    <table  cellspacing="0" align="center">
	 
	      <tr> 
	          <td id="footer" > 
	            <input class="b_foot" name=confirm type=button value=�ϴ� onClick="dosubmit()">
	            &nbsp;	            
	            <input class="b_foot" name=clear type=reset value=���>
	            &nbsp;	            	                  
	            <input class="b_foot" name=colse type=reset value=�ر� onClick="window.close();">
	            &nbsp; 
	           </td>
	      </tr>
	            
  </table>	
		  
 <input type="hidden" name="picpath_n" value="<%=picpath_n%>">
  
	</FORM>
	</BODY>
</HTML>


