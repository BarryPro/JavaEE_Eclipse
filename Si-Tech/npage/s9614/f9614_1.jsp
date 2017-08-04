<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9614";
 		String opName = "注意事项库审批";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
%>
<html>
	<head>
	<title>黑龙江BOSS-注意事项库审批</title>
	<script language="javascript">
		<!--
			/**显示"根据界面审批"**/
			function showOprInfo(){
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
				document.all.confirmButton.disabled = true;
			}

			/**显示"根据业务审批"**/
			function showFieldInfo(){
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
				document.all.confirmButton.disabled = true;
				
				document.getElementById("showFieldAccInfoFrame2").style.display = "block";
				document.showFieldAccInfoFrame2.location.href = "f9614_getFieldCreateAcceptInfo.jsp";
			}
	
				/**点击切换标签调用事件**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//根据界面增加
					showOprInfo();
				}else if(flag==2){
					//根据业务增加
					showFieldInfo();
				}
			}		

			window.onload=function(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					document.getElementById("showOprAccInfoFrame").style.display = "block";
					document.showOprAccInfoFrame.location.href = "f9614_getOprCreateAcceptInfo.jsp";
				}	
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					document.getElementById("showFieldAccInfoFrame2").style.display = "block";
					document.showFieldAccInfoFrame2.location.href = "f9614_getFieldCreateAcceptInfo.jsp";
				}	
			}
			
			/**选择"审核是否通过"select时产生的事件**/
			function doCheckAcc(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					if(document.all.sAuditAccept.value==""){
						rdShowMessageDialog("操作批次流水不能为空!");
						document.all.sIsAuditPass.value="none";
						return false;
					}	
					if(document.all.sIsAuditPass.value!="none"){
						document.all.confirmButton.disabled = false;
					}else{
						document.all.confirmButton.disabled = true;	
					}
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					if(document.all.sAuditAccept2.value==""){
						rdShowMessageDialog("操作批次流水不能为空!");
						document.all.sIsAuditPass2.value="none";
						return false;
					}	
					if(document.all.sIsAuditPass2.value!="none"){
						document.all.confirmButton.disabled = false;
					}else{
						document.all.confirmButton.disabled = true;	
					}
				}				
			}
			
			
			/**提交页面**/
			function doConfirm(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
				}
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
				}
				
				var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
				if(confirmFlag!=1){
					return false;
				}
				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					if(document.getElementById("sAuditSuggestion").value=="")
					{
							rdShowMessageDialog("请输入审批意见");
							document.getElementById("sAuditSuggestion").focus();
							return false;
					}
					
					document.frm.action = "f9614_oprCfm.jsp";
					document.frm.submit();					
				}else if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					if(document.getElementById("sAuditSuggestion2").value=="")
					{
							rdShowMessageDialog("请输入审批意见");
							document.getElementById("sAuditSuggestion2").focus();
							return false;
					}
					
					document.frm.action = "f9614_fieldCfm.jsp";
					document.frm.submit();
				}
			}
						
			/**重置页面**/
			function doReset(){
				document.frm.reset();
			}
			
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			
			/**过滤字符左右的空格**/
			function jtrim(str){
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}
			//-->
	</script>
	
	<!--这段css样式是用来设置切换标签的样式,,,如果有更好的切换标签来替换,,,请删除这段样式,不影响页面其他内容-->
	<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>
</head>

<body>
	<form action="" method="post" name="frm">
		
	<%@ include file="/npage/include/header.jsp" %>
	
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">


		<div class="title">
			<div id="title_zi">请选择操作类型</div>
		</div>
		
		<!--切换标签,如果有更合适的标签,,可以替换-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据界面审批</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>根据业务审批</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
		    
		<!--	
		/*@service information
		 *@name						s9614Cfm1
		 *@description				审核的是操作代码 
		 *@author					lugz
		 *@created	2008-10-8 13:01:58
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
		 *@inparam	opCode			功能代码	
		 *@inparam	loginNo			操作工号
		 *@inparam	loginPasswd		经过加密的工号密码
		 *@inparam	systemNote		系统备注
		 *@inparam	opNote			操作备注
		 *@inparam	ipAddr			IP地址
		 
		 *@inparam	sAuditAccept	审批流水
		 *@inparam	sIsAuditPass 	Y/N
		 *@inparam	sAuditSuggestion 审批意见
		 *@inparam	sIsAudit	是否已经审核 Y/N
		 
		 *@output parameter information
		 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO 
		 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0">
				<tr>
					<td colspan="4">
						<iframe frameBorder="0" id="showOprAccInfoFrame" align="center" name="showOprAccInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showOprAccInfoFrame').style.height=showOprAccInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<iframe frameBorder="0" id="showMainOprInfoFrame" align="center" name="showMainOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showMainOprInfoFrame').style.height=showMainOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
			<table id="oprAuditTable" style="display:none" cellspacing="0">
				 <tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;选择的批次流水</td>
					<td>
						<input type="text" name="sAuditAccept" value="" readonly>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审核是否通过</td>
					<td>
						<select name="sIsAuditPass" onchange="doCheckAcc()">
							<option value="none">请选择</option>
							<option value="Y">是</option>
							<option value="N">否</option>
						</select>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审批意见</td>
					<td>
						<input type="text" name="sAuditSuggestion" value="" size="80" maxlength="60">					
					</td>
				</tr>
					<input type="hidden" name="systemNote" value="" size="80" maxlength="60" readonly>
				<tr>
					<td class="blue" nowrap>&nbsp;&nbsp;操作备注</td>
					<td><input type="text" name="opNote" value="" size="80" maxlength="60"></td>
				</tr>
			</table>	
		</div>
		
		<!--
			/*@service information
			 *@name						s9614Cfm2
			 *@description				注意实现库审核
			 *@author					lugz
			 *@created	2008-10-8 13:01:58
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
			 *@inparam	systemNote		系统备注
			 *@inparam	opNote			操作备注
			 *@inparam	ipAddr			IP地址
			 
			 *@inparam	sAuditAccept	审批流水
			 *@inparam	sIsAuditPass 	Y/N
			 
			 *@output parameter information
			 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
			 *@return SVR_ERR_NO 
 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td colspan="2">
						<iframe frameBorder="0" id="showFieldAccInfoFrame2" align="center" name="showFieldAccInfoFrame2" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showFieldAccInfoFrame2').style.height=showFieldAccInfoFrame2.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<iframe frameBorder="0" id="showMainOprInfoFrame2" align="center" name="showMainOprInfoFrame2" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showMainOprInfoFrame2').style.height=showMainOprInfoFrame2.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>

			<table id="oprAuditTable2" style="display:none" cellspacing="0">
				 <tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;选择的批次流水</td>
					<td>
						<input type="text" name="sAuditAccept2" value="" readonly>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审核是否通过</td>
					<td>
						<select name="sIsAuditPass2" onchange="doCheckAcc()">
							<option value="none">请选择</option>
							<option value="Y">是</option>
							<option value="N">否</option>
						</select>						
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审批意见</td>
					<td>
						<input type="text" name="sAuditSuggestion2" value="" size="80" maxlength="60">					
					</td>
				</tr>
				<tr>
					<td class="blue" nowrap>&nbsp;&nbsp;操作备注</td>
					<td><input type="text" name="opNote2" value="" size="80" maxlength="60"></td>
				</tr>
			</table>
		</div>
		
		<!--以下为操作部分-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()" >&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="确定" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()" >&nbsp;
        </td>
      </tr>
     </table>
    <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

