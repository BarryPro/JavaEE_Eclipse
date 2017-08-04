
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "zg57";
	String opName = "不良信息投诉关机";   
	String regionCode = (String)session.getAttribute("regCode");  //工号归属    
	String workno=(String)session.getAttribute("workNo");         //工号         
	String sysAccept = getMaxAccept();
%>
<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-不良信息投诉关机</TITLE>
		<script language="JavaScript">
			<!--
			function dosubmit() {
				getAfterPrompt();
				if(form.fileName.value.length<1){
					rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
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
        	rdShowMessageDialog("上传文件格式只能是txt，请重新选择数据文件！");
					document.form.fileName.focus();
					return false;
        }
        if(document.all.shandlingtype.value == "")
				{
					rdShowMessageDialog("操作原因不可为空！");
					return false;
				}
				if(document.all.sSourceData.value == "")
				{
					rdShowMessageDialog("加黑类型不可为空！");
					return -2;
				}
				if(document.all.sSourceType.value == "")
				{
					rdShowMessageDialog("数据来源不可为空！");
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
				  document.all.opNote.value = "操作员："+document.all.loginNo.value+"进行了不良信息投诉关机信息批量导入"; 
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
				<div id="title_zi">批量信息导入---不良信息投诉关机黑名单用户</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	        <tr> 
	            <td class="blue" align=center width="10%">操作类型</td>
	            <td width="40%">
	            	<input type="text" size="30" class="InputGrey" readonly value="操作号码的批量信息导入">
	            </td>				               		              
		          <td class="blue" align=center width="10%">数据文件</td>
		          <td width="40%"> 
	            	<input type="file" name="fileName">
	            	<font color="#FF0000">*</font>
	            </td>
	      	</tr>
	      	<!--huangrong add 延期标志 并对页面样式修改 2011-6-29-->
		    	<tr> 
		      	<td class="blue" align=center width="10%">操作原因</td>		        
				    <td class="blue" width="20%">
				    	<select name="shandlingtype" id="shandlingtype" class="button" >
				    		<option value="0101">二次过滤违规</option>
				    		<option value="0102">人工审核违规</option>
				    		<option value="0103" selected >投诉</option>
				    		<option value="0104">人工导入</option>
				    		<option value="0105">其他</option>
				    	</select>
				    </td>	      	
				    <!--end add 延期标志 2011-6-29-->	
			       	  <TD class="blue" align=center width="10%">加黑类型</TD>
					    <td class="blue" width="20%">
					    	<select name="sSourceData" id="sSourceData" class="button" >
					    		<!--<option value="" selected>请选择</option>   huangrong 备注 2011-6-21 -->
					    		<option value="01">垃圾短信</option>
					    		<option value="02" selected>骚扰电话</option>
					    		<option value="03" >垃圾彩信</option>
					    	</select>
					    </td>    
		      </tr>	

	           <TR id="bltys"  > 
	          <TD width="10%" class="blue" align=center >数据来源</TD>
              <TD colspan="5">
                 <select id="sSourceType" name="sSourceType" style="width:100px;">
	    		<option value="01">全网监控平台</option>
	    		<option value="02" >省内监控</option>
	    		<option value="03" >举报处理</option>
	    		<option value="04" selected>用户投诉</option>
									</select>

	          </TD>
	          </TR> 
		      	    <TR id="bltys"  > 
		      	   <td class="blue" align=center width="10%">操作备注</td>
	    <td width="90%" class="blue" colspan="5">
	    	<input class="button" type="text" name="opNote" id="opNote" value="" size="140" maxlength="70">
	    	<!--huangrong add 修改页面展示样式，操作原因可输入70个汉字 2011-6-21 -->
	    </td>

	          </TR>       	
	      </tbody> 
	    </table>
	    
     <table  cellspacing="0">
	   	<tbody> 
	      <tr> 
	      	<td colspan="3">说明：<br>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">此次批量导入时“添加/修改标志”固定是添加</font>：<br><!--huangrong update 备注信息，删除，“延期标志”固定是长期关停的字样 2011-6-29-->
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造增加垃圾短信与网管黑名用户操作失败</font>:<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机号码  回车<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
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
	            <input class="b_foot" name=confirm type=button value=确认 onClick="dosubmit()">
	            &nbsp;	            
	            <input class="b_foot" name=clear type=reset value=清除>
	            &nbsp;	
	            <input class="b_foot" name=goBack type=button  value=返回 onClick="location='zg57.jsp'">
	            &nbsp; 	            	                  
	            <input class="b_foot" name=colse type=reset value=关闭 onClick="removeCurrentTab()">
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


