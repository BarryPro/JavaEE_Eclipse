<%
  /*
   * 功能:6995个人任务批量订购
   * 版本: 1.0
   * 日期: 2015/06/18
   * 作者: wangwg
   * 版权: si-tech
  */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "J102";
	String opName = "6995个人任务批量订购";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	String sysAccept = "";
%>

<HTML>
	<HEAD>
		<TITLE>6995个人任务批量订购</TITLE>
		<script language="JavaScript">
		function dosubmit() {
			if(form.feefile.value.length<1)
			{
				rdShowMessageDialog("数据文件错误，请重新选择数据文件！",0);
				document.form.feefile.focus();
				return false;
			}
			else 
			{
				setOpNote();
				document.form.action="fj102_2.jsp?remark="+document.form.remark.value;
				document.form.submit();
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
				return true;
			}
		}
		function setOpNote()
		{
			if(document.all.remark.value=="")
			{
			  document.all.remark.value = "操作员："+"<%=workno%>"+"进行了批量6995业务订购"; 
			}
			return true;
		}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fj102_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
                                <div id="title_zi">6995个人任务批量订购</div>
			</div>
			<table  cellspacing="0">
				<tbody> 
					<tr> 
						<td class="blue" align=center width="20%">数据文件</td>
						<td width="30%" colspan="2"> 
							<input type="file" name="feefile">
						</td>
					</tr>
					<tr> 
						<td class="blue" align=center width="20%">操作备注</td>
						<td colspan="2"> 
							<input name=remark size=60 maxlength="60" >
						</td>
					</tr>
					<tr> 
						<td colspan="3">说明：<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>：<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造成错误订购6995个人业务</font>:<br>
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
							<input class="b_foot" name=sure type=button value=确认 onClick="dosubmit()">
							<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
		</FORM>
	</BODY>
</HTML>
