<%
  /*
   * 功能:营业厅与mac地址绑定配置--文件批量导入
   * 版本: 1.0
   * 日期: 2009/12/21
   * 作者: gaolw
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "8363";
	String opName = "营业厅与mac地址绑定配置";   
	String regionCode = (String)session.getAttribute("regCode");  //工号归属    
	String workno=(String)session.getAttribute("workNo");         //工号         
	String sysAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
  sysAccept = sLoginAccept;
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-营业厅与mac地址绑定配置</TITLE>
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
				  document.all.opNote.value = "操作员："+document.all.loginNo.value+"进行了批量导入营业厅与mac地址绑定关系"; 
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
				<div id="title_zi">批量导入营业厅与mac地址绑定关系</div>
			</div> 
			<table cellspacing="0">
	      <tbody> 
	        <tr> 
	            <td class="blue" align=center width="10%">操作类型</td>
	            <td width="40%">
	            	<input type="text" size="30" class="InputGrey" readonly value="批量导入营业厅与mac地址绑定关系">
	            </td>				               		              
		          <td class="blue" align=center width="10%">数据文件</td>
		          <td width="40%"> 
	            	<input type="file" name="fileName">
	            	<font color="#FF0000">*</font>
	            </td>
	      	</tr>
		    	<tr> 
		      	<td class="blue" align=center width="10%">操作备注</td>
		        <td> 
		        	<input name=opNote size=60 maxlength="60" width="90%">
		        </td>				            
		      </tr>	      	
	      </tbody> 
	    </table>
	    
     <table  cellspacing="0">
	   	<tbody> 
	      <tr> 
	      	<td colspan="3">说明：<br>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造增加批量导入营业厅与mac地址绑定关系操作失败</font>:<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;营业厅代码 空格 mac地址 空格 IP地址 空格 传输方式<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;326467 00FF43EFAC7A 10.0.0.1 电脑<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;326467 00FF43EFAC7B 10.0.0.2 电脑<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;326467 00FF43EFAC7C 10.0.0.3 电脑
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
	            <input class="b_foot" name=goBack type=button  value=返回 onClick="location='f8363_1.jsp'">
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


