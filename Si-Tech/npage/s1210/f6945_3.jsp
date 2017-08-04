<%
  /*
   * 功能:垃圾短信与网管黑名单综合受理批量导入的功能
   * 版本: 1.0
   * 日期: 2011/05/31
   * 作者: huangrong
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "6945";
	String opName = "垃圾短信与网管黑名单综合受理";   
	String regionCode = (String)session.getAttribute("regCode");  //工号归属    
	String workno=(String)session.getAttribute("workNo");         //工号         
	String sysAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
  sysAccept = sLoginAccept;
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量添加垃圾短信与网管黑名单综合受理功能</TITLE>
		<script language="JavaScript">
			<!--
			function dosubmit() {
				getAfterPrompt();
				if(form.fileName.value.length<1)
				{
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
        //huangrong add 验证延期标志不能为空 2011-6-29
        if(document.all.delayType.value == "")
				{
					rdShowMessageDialog("请选择延期标志！");
					return false;
				}
				//end add 验证延期标志不能为空 2011-6-29
				setOpNote();
				frmCfm();
				return true;
			}
			
			function setOpNote()
			{
				if(document.all.opNote.value=="")
				{
				  document.all.opNote.value = "操作员："+document.all.loginNo.value+"进行了垃圾短信与网管黑名单综合受理信息批量导入"; 
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
				$("#seled").append("<option value='02' selected>省内监控</option><option value='04'>用户投诉</option>");
			  }
			   else if(typeflag==""){
			  $("#seled").empty();
				$("#seled").append("<option value='' selected>--请选择--</option>");
			  }
			  else {
			  $("#seled").empty();
				$("#seled").append("<option value='03' selected>举报处理</option><option value='02'>省内监控</option>");
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
				$("#seled").append("<option value='02' selected>省内监控</option><option value='04'>用户投诉</option>");
			  }
			  else if(typeflag==""){
			  $("#seled").empty();
				$("#seled").append("<option value='' selected>--请选择--</option>");
			  }
			  else {
			  $("#seled").empty();
				$("#seled").append("<option value='03' selected>举报处理</option><option value='02'>省内监控</option>");
			  }
}
		</script>
	</HEAD>
	<BODY>
		<FORM action="s6945_3Upload.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量信息导入---添加垃圾短信与网管黑名单用户</div>
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
		      	<td class="blue" align=center width="10%">延期标志</td>		        
				    <td width="40%" class="blue">
				    	<select name="delayType" id="delayType" class="button" onChange="changType()">
				    		<option value="" selected>请选择</option>
				    		<option value="Y">延期7天</option>
				    		<option value="N">关停7天</option>
				    		<option value="T">长期关停</option>
				    		<option value="F">立即恢复</option>
				    	</select>
				    	<font color="#FF0000">*</font>
				    </td>		      	
				    <!--end add 延期标志 2011-6-29-->	
			       	  <TD class="blue" align=center width="10%">数据来源</TD>
              <TD >
                 <select id="seled" style="width:100px;">
									</select>

	          </TD>     
		      </tr>	
		      	    <TR id="bltys"  > 
		      	   <td class="blue" align=center width="10%">操作备注</td>
		        <td colspan="3"> 
		        	<input name=opNote size=60 maxlength="60" width="40%">
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
	            <input class="b_foot" name=goBack type=button  value=返回 onClick="location='s6945Login.jsp'">
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


