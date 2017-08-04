<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/03/01 liangyl 关于实现入网人证一致性查验及调整微信补登记规则的函
* 作者: liangyl
* 版权: si-tech
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	
	
	
//	String IDaddress = request.getParameter("IDaddress")==null ? "":request.getParameter("IDaddress");
//	String bir_day = request.getParameter("bir_day")==null ? "":request.getParameter("bir_day");
//	String sex = request.getParameter("sex")==null ? "":request.getParameter("sex");
//	String idValidDate_obj = request.getParameter("idValidDate_obj")==null ? "":request.getParameter("idValidDate_obj");
//	String campicname = request.getParameter("campicname")==null ? "":request.getParameter("campicname");
//	String v_custId = request.getParameter("v_custId")==null ? "":request.getParameter("v_custId");
	
	
	String idType = request.getParameter("idType");
	String regionCode = request.getParameter("regionCode");
	String workno = request.getParameter("workno");
	String picpath_n = request.getParameter("picpath_n")==null ? "":request.getParameter("picpath_n");
	String sopcode = request.getParameter("opcodes")==null ? "":request.getParameter("opcodes");
	String name = request.getParameter("name")==null ? "":request.getParameter("name");
//	String code = request.getParameter("opcodes")==null ? "":request.getParameter("opcodes");
	String idIccid = request.getParameter("idIccid")==null ? "":request.getParameter("idIccid");
	String labelName = request.getParameter("labelName")==null ? "":request.getParameter("labelName"); 
	
	System.out.println("liangyl-----camcardinfosave----------"+sopcode);
	System.out.println("liangyl-----camcardinfosave----------"+name);
	System.out.println("liangyl-----camcardinfosave----------"+picpath_n);
	System.out.println("liangyl-----camcardinfosave----------"+idIccid);
	System.out.println("liangyl-----workno----------"+workno);
	System.out.println("liangyl-----regionCode----------"+regionCode);
	System.out.println("liangyl-----labelName----------"+labelName);

%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量恢复客户语音功能</TITLE>
		<script language="JavaScript">

			function dosubmit() {

				if(form.fileName.value.length<1)
				{
					rdShowMessageDialog("上传的图片不能为空请重新选择！");
					document.form.fileName.focus();
					return false;
				}
				var str1=$("#tdval").html().trim().replace(/\//g,"").replace(/\\/g,"");
				var str2 = form.fileName.value.replace(/\//g,"").replace(/\\/g,"");
				
				
        if(str1!=str2)
        {
        	rdShowMessageDialog("上传的图片和读卡的图片不符请重新选择！");
					document.form.fileName.focus();
					return false;
        }
				frmCfm();
				return true;
			}
			

			
			function frmCfm()
			{
				document.form.action="/npage/public/uploadSfzImg.jsp?labelName=<%=labelName%>&idType=<%=idType%>&regionCode=<%=regionCode%>&workno=<%=workno%>&filep_j=<%=picpath_n%>&op_code=<%=sopcode%>&custName=<%=name%>&code=<%=sopcode%>&idIccid=<%=idIccid%>";
				document.form.submit();
		
			}
			
	

		</script>
	</HEAD>
	<BODY>
		<FORM action="" method=post name=form ENCTYPE="multipart/form-data">
			<div class="title">
				<div id="title_zi">上传身份证信息</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	      		 <tr> 			               		              
		          <td class="blue" align=center width="20%">读卡后的图片路径为：</td>
		          <td width="30%" id="tdval"> 
	            	<%=picpath_n%>
	          </td>
	      	</tr>
	        <tr> 			               		              
		          <td class="blue" align=center width="20%">身份证头像图片文件</td>
		          <td width="30%" colspan="2"> 
	            	<input type="file" name="fileName">
	          </td>
	      	</tr>
	      </tbody> 
	    </table>

    
    <table  cellspacing="0" align="center">
	 
	      <tr> 
	          <td id="footer" > 
	            <input class="b_foot" name=confirm type=button value=上传 onClick="dosubmit()">
	            &nbsp;	            
	            <input class="b_foot" name=clear type=reset value=清除>
	            &nbsp;	            	                  
	            <input class="b_foot" name=colse type=reset value=关闭 onClick="window.close();">
	            &nbsp; 
	           </td>
	      </tr>
	            
  </table>	
		  
 <input type="text" name="picpath_n" value="<%=picpath_n%>">
  
	</FORM>
	</BODY>
</HTML>