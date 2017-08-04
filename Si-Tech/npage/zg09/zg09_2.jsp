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
	String opCode = "zg09";
	String opName = "集团自由划拨文件导入";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	String contract_no = request.getParameter("contract_no");
	String sysAccept = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - 流水："+sysAccept);
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-集团自由划拨文件导入</TITLE>
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
					document.form.action="zg09_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&seled="+seled+"&contract_no="+"<%=contract_no%>";
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
				  document.all.remark.value = "操作员："+document.all.loginNo.value+"进行了集团划拨批量信息导入"; 
				}
				return true;
			}	
			
			//-->
		function returnBefo() {
		  window.location.href = "zg09_1.jsp"
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
				<div id="title_zi">批量信息导入---集团自由划拨文件导入</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" align=center width="20%">操作类型</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="集团自由划拨文件导入">
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
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造成无法充值。分隔符为"|" </font><br>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004675829|100<br> 
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

