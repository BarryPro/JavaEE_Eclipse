<%
  /*
   * 功能: 批量恢复客户语音功能 d948
   * 版本: 1.0
   * 日期: 2011/06/23
   * 作者: huangrong
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "d948";
	String opName = "批量恢复客户语音功能";   
	String regionCode = (String)session.getAttribute("regCode");  //工号归属    
	String workno=(String)session.getAttribute("workNo");         //工号         
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量恢复客户语音功能</TITLE>
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
				setOpNote();
				frmCfm();
				return true;
			}
			
			function setOpNote()
			{
				if(document.all.opNote.value=="")
				{
				  document.all.opNote.value = "操作员："+document.all.loginNo.value+"进行了恢复客户语音功能的批量信息导入"; 
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
				$("#seled").append("<option value='02' selected>省内监控</option><option value='04'>用户投诉</option>");
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
				<div id="title_zi">批量信息导入---批量恢复客户语音功能</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	        <tr> 
	            <td class="blue" align=center width="20%">操作类型</td>
	            <td width="30%" colspan="2">
	            	<input type="text" size="30" class="InputGrey" readonly value="操作号码的批量信息导入">
	            </td>				               		              
		          <td class="blue" align=center width="20%">数据文件</td>
		          <td width="30%" colspan="2"> 
	            	<input type="file" name="fileName">
	          </td>
	      	</tr>
	      </tbody> 
	    </table>
	    
     <table  cellspacing="0">
	   	<tbody> 
	   				              	 <TR id="bltys"  > 
						          <TD class="blue" align=center width="20%">数据来源</TD>
					              <TD >
					                 <select id="seled"  style="width:100px;">
														</select>
					
						          </TD>
						          </TR> 
	    	<tr> 
	      	<td class="blue" align=center width="20%">操作备注</td>
	        <td colspan="2"> 
	        	<input name=opNote size=60 maxlength="60" >
	        </td>
	      </tr>
	      <tr> 
	      	<td colspan="3">说明：<br>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造成错误恢复用户的语音功能</font>: <br>
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
				      <input type="button" name="rets" class="b_foot" value="返回" onClick="returnBefo()"/>
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


