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
	String sopcode = request.getParameter("sopcode")==null ? "":request.getParameter("sopcode");
	String legalPerson = request.getParameter("legalPerson")==null ? "":request.getParameter("legalPerson");
	String foundDate = request.getParameter("foundDate")==null ? "":request.getParameter("foundDate");
	String startDate = request.getParameter("startDate")==null ? "":request.getParameter("startDate");
	String endDate = request.getParameter("endDate")==null ? "":request.getParameter("endDate"); 
	
	System.out.println("chenlei-----sopcode----------"+sopcode);
	System.out.println("chenlei-----regionCode----------"+regionCode);
	System.out.println("chenlei-----路径----------"+picpath_n);
	System.out.println("chenlei-----workno----------"+workno);
	System.out.println("chenlei-----idType----------"+idType);
	System.out.println("chenlei-----legalPerson----------"+legalPerson);
	System.out.println("chenlei-----foundDate----------"+foundDate);
	System.out.println("chenlei-----startDate----------"+startDate);
	System.out.println("chenlei-----endDate----------"+endDate);

%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量恢复客户语音功能</TITLE>
		<script language="JavaScript">

			function dosubmitAA() {

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
		        	<%--rdShowMessageDialog("上传的图片和读卡的图片不符请重新选择！");
							document.form.fileName.focus();
							return false;--%>
		        }
				frmCfm();
				return true;
			}
			

			
			function frmCfm()
			{
				document.form.action="/npage/public/uploadSfzImgCode.jsp?legalPerson=<%=legalPerson%>&idType=<%=idType%>&regionCode=<%=regionCode%>&workno=<%=workno%>&filep_j=<%=picpath_n%>&op_code=<%=sopcode%>&foundDate=<%=foundDate%>&startDate=<%=startDate%>&endDate=<%=endDate%>";
				document.form.submit();
		
			}
			
	

		</script>
	</HEAD>
	<BODY>
		<FORM action="" method=post name=form ENCTYPE="multipart/form-data">
			<div class="title">
				<div id="title_zi">上传证件信息</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	      		 <tr> 			               		              
		          <td class="blue" align=center width="20%">证件图片路径为：</td>
		          <td width="30%" id="tdval"> 
	            	<%=picpath_n%>
	          </td>
	      	</tr>
	        <tr> 			               		              
		          <td class="blue" align=center width="20%">证件图片文件</td>
		          <td width="30%" colspan="2"> 
	            	<input type="file" name="fileName">
	          </td>
	      	</tr>
	      </tbody> 
	    </table>

    
    <table  cellspacing="0" align="center">
	 
	      <tr> 
	          <td id="footer" > 
	            <input class="b_foot" name=confirm type=button value=上传 onClick="dosubmitAA()">
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