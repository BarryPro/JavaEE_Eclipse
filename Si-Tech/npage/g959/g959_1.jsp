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
	String opCode = "g959";
	String opName = "空中充值批量转账前台导入";   
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
		<TITLE>黑龙江BOSS-空中充值批量转账前台导入</TITLE>
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
					document.form.action="g959_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&seled="+seled+"&agt_phone="+document.all.agt_phone.value;
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
				  document.all.remark.value = "操作员："+document.all.loginNo.value+"进行了空中充值信息批量导入"; 
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
				document.getElementById("do_check").disabled=true;
				document.getElementById("dcon_pre").style.display="none";
		}
		function do_checks()
		{
			 
			var agt_phone= document.all.agt_phone.value;
			if(agt_phone=="")
			{
				rdShowMessageDialog("请输入空中充值代理商手机号码！");
				document.all.agt_phone.focus();
				return false;
			}
			else
			{
				var myPacket = new AJAXPacket("g959_check.jsp","正在查询客户，请稍候......");
				myPacket.data.add("agt_phone",(document.all.agt_phone.value).trim());
				core.ajax.sendPacket(myPacket,doCheckAgt);
				myPacket=null;
			}
		}
		function doCheckAgt(packet)
		{
			var retResult=packet.data.findValueByName("retResult");
			var retResult1=packet.data.findValueByName("retResult1");
			//alert("retResult is "+retResult+" retResult1 is "+retResult1);
			if(retResult!="0")
            {
				if(retResult=="1")
				{
					rdShowMessageDialog("该号码不是空中充值代理商号码，请重新输入!");
					return false;
				}
				else if(retResult=="2")
				{
					rdShowMessageDialog("该号码不存在，请重新输入!");
					return false;
				}
				else
                {
					rdShowMessageDialog("用户信息不存在!");
					return false;
				}
			}
			else
			{
				document.getElementById("do_check").disabled=false;
				document.all.agt_phone.readOnly = true;;
			}
		}
		function do_querys()
		{
			//alert("2");
			var agt_phone= document.all.agt_phone.value;
			if(agt_phone=="")
			{
				rdShowMessageDialog("请输入空中充值代理商手机号码！");
				document.all.agt_phone.focus();
				return false;
			}
			else
			{
				//alert("3");
				var myPacket1 = new AJAXPacket("g959_query.jsp","正在查询客户，请稍候......");
				//alert("4");
				myPacket1.data.add("agt_phone",(document.all.agt_phone.value).trim());
				//alert("5");
				core.ajax.sendPacket(myPacket1,doGetQuery);
				//alert("6");
				myPacket1 =null;
			}
		}
		function doGetQuery(packet2)
		{
			//alert("3");
			var retResult=packet2.data.findValueByName("retResult");
			//alert("1："+retResult);
			var s_sum = packet2.data.findValueByName("s_sum");
			//alert("2");
			var ret_msg=packet2.data.findValueByName("ret_msg");
			//alert("retResult is "+retResult+" and ret_msg is "+ret_msg);
			if(retResult==0)
			{
				document.getElementById("dcon_pre").style.display="block";
				document.getElementById("pre").value=s_sum;
			}	
			else
			{
				rdShowMessageDialog("号码不是空中充值代理商号码，请核对后重新输入!");
			}
		}
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="g959_cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量信息导入---空中充值批量转账前台导入</div>
			</div> 
			
			<table cellspacing="0">
			  <tr>
				<td class="blue" align=center width="20%">空中充值代理商号码&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="agt_phone" maxlength="11"></td>
				<td class="blue" align=left width="20%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_foot" name="check" value="校验" onclick="do_checks()">
				
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_foot" name="do_query" value="账户可转金额查询" onclick="do_querys()"></td>
			  </tr>
            </table>
			<div id="dcon_pre">
				<table cellspacing="0">
					<td class="blue" align=center width="20%">空中充值代理商帐号可转余额</td>
					<td class="blue" align=center width="20%"><input type="text" id="pre" readonly>(元)</td>
				</table>
			</div>
			<table cellspacing="0">
		              
					  
					  <tbody> 
			              
						  <tr> 
				                <td class="blue" align=center width="20%">操作类型</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="空中充值批量转账前台批量导入">
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
					 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;被充值手机号码|充值金额  回车<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004675829|1<br> 
				                </td>
			              </tr>   
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=确认 id="do_check" onClick="dosubmit()">
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

