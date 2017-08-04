 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "8658";	
	String opName = "批量修改IMEI绑定关系";	//header.jsp需要的参数   
	String regionCode = (String)session.getAttribute("regCode");       
	
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	//out.println(workno);
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量修改IMEI绑定关系</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
			{
				//form.sure.disabled=true;
				}
				function dosubmit() {
					getAfterPrompt();
				if(form.feefile.value.length<1)
				{
					rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
					document.form.feefile.focus();
					return false;
				}
				else 
				{
					setOpNote();
					//alert(document.all.remark.value);
					document.form.action="f8658_2.jsp?remark="+document.form.remark.value;
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
				  document.all.remark.value = "操作员："+document.all.loginNo.value+"进行了批量修改IMEI绑定关系操作"; 
				}
				return true;
			}	
			
			//-->
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="f8658_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量修改IMEI绑定关系</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">操作类型</td>
				                <td width="30%" colspan="2">
					                    <input type="text" class="InputGrey" readonly value="批量修改IMEI绑定关系">
				                </td>				               		              
			                <td class="blue" align=center width="20%">数据文件</td>
			                <td width="30%" colspan="2"> 
			                  <input type="file" name="feefile">
			                </td>
		              	</tr>
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">操作备注</td>
				                <td colspan="2"> 
				                  	<input class="InputGrey" name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">说明：<br>
				                  &nbsp;&nbsp;&nbsp;<font color="red">1、数据文件的文件格式为：</font><br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办理流水 空格 操作代码 空格 用户ID 空格 手机号码 空格 开通时间 空格 Imei号码<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33158139439 126h 132043222845 13766779090 20080603 354343010758855<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;42425443519 1144 12074084700 13836019169 20080602 357949004194046<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;42431931671 126i 12074082241 13895825500 20081119 351799012237584<br>
				                  &nbsp;&nbsp;&nbsp;<font color="red">2、目前可以进行批量操作的营销案只有以下几个：</font><br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1141——预存话费优惠购机 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7955——购机赠话费（分月返还）营销案 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8044——欢乐新农村神州行 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8027——买手机送话费 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d069——合约计划预存购机 <br>
				                  <%/*begin add 增加合约计划购机(e505),自备机合约计划(e528) by diling @2012/5/21*/%>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e505——合约计划购机 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e528——自备机合约计划 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e720——购机入网-让利计划 <br>
				                  <%/*end add by diling @2012/5/21*/%>
				                </td>
			              </tr>
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=确认 onClick="dosubmit()">
				                  &nbsp;
				                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>
