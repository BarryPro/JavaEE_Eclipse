<%
  /*
   * 功能:对骚扰电话用户进行批量关闭语音功能
   * 版本: 1.0
   * 日期: 2010/07/13
   * 作者: sungq
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "g247";
	String opName = "手工充值卡配置";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - 流水："+sysAccept);
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-手工充值卡配置</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
			{
				init();
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
					var seled = $("#seled").val();
					document.form.action="g247_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&seled="+seled;
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
				  document.all.remark.value = "操作员："+document.all.loginNo.value+"进行了充值卡配置批量信息导入"; 
				}
				return true;
			}	
			
			//-->
		function returnBefo() {
		  window.location.href = "finner_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		
		function init()
		{
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>举报处理</option><option value='02'>省内监控</option>");
		}
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="g247_cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量信息导入---手工充值卡配置</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">操作类型</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="手工充值卡配置批量信息导入">
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
					  <!--
		              	 <TR id="bltys"  > 
						          <TD class="blue" align=center width="20%">数据来源</TD>
					              <TD >
					                 <select id="seled"  style="width:100px;">
														</select>
					
						          </TD>
						          </TR> 
						-->
			              <tr> 
				                <td class="blue" align=center width="20%">操作备注</td>
				                <td colspan="2"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">说明：<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造成无法充值。分隔符为"|"。</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">地市编码为region_code，即哈尔滨为01,齐齐哈尔为02，以此类推。</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地市编码|手机号码|营销活动名称|地市公司策划人|省公司审批文件编号|省公司审批文件名称|充值生效开始时间|充值生效结束时间|计划充值金额  回车<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;01|15004675829|营销活动名称|张三|审批文件编号|审批文件名称|20121001|20131001|1000<br> 
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
				                 <input type="button" name="rets" class="b_foot" value="返回" onClick="returnBefo()"/>
				                  &nbsp;			                  
				                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		  
		   <input type="hidden" name="regCode" value="01" >
		   <input type="hidden" name="sysAccept" value="1234" >  
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		   <input type="hidden" name="inputFile" value="">
		   
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

