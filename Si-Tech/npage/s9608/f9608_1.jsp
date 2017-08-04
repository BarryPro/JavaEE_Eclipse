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
    
 		String opCode = "9608";
 		String opName = "注意事项库删除";

		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
				
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());

		String getGroupNameSql = "select group_name ,root_distance from dChnGroupMsg where group_id  = '"+groupId+"'";		
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getGroupNameSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
	/*zhangyan add 客服工号不校验服务*/
	String accountType=(String)session.getAttribute("accountType");
	int root_distance_int = 0;
	if (  ! accountType.equals("2") )
	{
		if(retCode1.equals("000000")){
			String root_distance = sVerifyTypeArr[0][1];
			root_distance_int = Integer.parseInt(root_distance);
			if(root_distance_int>3)
			{
			%>
			<script>
				rdShowMessageDialog("该工号无删除权限!");
				window.close();
			</script>
			<%
				return ;
			}
	
		}
	}
%>
<html>
	<head>
	<meta http-equiv="content-Type" content="text/html;charset=gb2312">
	<title>黑龙江BOSS-注意事项库删除</title>
	<script language="javascript">
		<!--
			/**显示"根据界面删除"**/
			function showOprInfo(){
				//doReset();
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
				//document.all("sAuditLoginInfoFrame").height=sAuditLoginInfoFrame.document.body.scrollHeight;
			}

			/**显示"根据业务删除"**/
			function showFieldInfo(){
				//doReset();
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
			}
			
			/**点击切换标签调用事件**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//根据界面删除
					showOprInfo();
				}else if(flag==2){
					//根据业务删除
					showFieldInfo();
				}
			}	
			
			/**选择代码**/
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9608_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			
			/**根据制定的条件,查询需要删除的信息**/
			function doQuery(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					var sFunctionCode = jtrim(document.all.sFunctionCode.value);
					var iBillType = document.all.iBillType.value;
					var iPromptType = document.all.iPromptType.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq.value);	

					document.getElementById("qryOprInfoFrame").style.display="block";
					document.qryOprInfoFrame.location.href = "f9608_getOprInfoByFunctionCode.jsp?sFunctionCode="+sFunctionCode+"&iBillType="+iBillType+"&iPromptType="+iPromptType+"&iPromptSeq="+iPromptSeq;
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);
					var sFunctionCode = jtrim(document.all.sFunctionCode2.value);	
					
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location.href = "f9608_getFieldInfoByClassCode.jsp?iClassCode="+iClassCode+"&sClassValue="+sClassValue+"&iPromptSeq2="+iPromptSeq+"&iPromptType2="+iPromptType+"&iBillType2="+iBillType+"&sFunctionCode2="+sFunctionCode;						
				}
			}
			
			/**提交页面**/
			function doConfirm(){
				
				var sAuditLoginsValue = "";
					if(document.all.confirmFlag.value=="oprPromptConfirm"){
						var sFunctionCode = jtrim(document.all.sFunctionCode.value);
						var iBillType = document.all.iBillType.value;
						var iPromptType = document.all.iPromptType.value;
						var iPromptSeq = jtrim(document.all.iPromptSeq.value);
						
						if(sFunctionCode==""||sFunctionCode.length==0){
							rdShowMessageDialog("提示操作代码不能为空!");
							document.all.iClassCode.focus();
							return false;
						}	
						if(iPromptSeq==""||iPromptSeq.length==0){
							rdShowMessageDialog("提示序号不能为空!");
							document.all.iPromptSeq.focus();
							return false;
						}	
						if(iPromptType==""||iPromptType=="none"){
							rdShowMessageDialog("请选择提示类型!");
							document.all.iPromptType.focus();
							return false;
						}					
						if(iBillType==""||iBillType=="none"){
							rdShowMessageDialog("请选择票据类型!");
							document.all.iBillType.focus();
							return false;
						}	
						
					if(document.getElementById("qryOprInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value == ""){
							rdShowMessageDialog("请选择审批人,审批人至少需要一人!");
							return false;							
					}
					
					sAuditLoginsValue = document.getElementById("qryOprInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value;
						
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);	
						
					if(iClassCode==""||iClassCode.length==0){
						rdShowMessageDialog("代码不能为空!");
						document.all.iClassCode.focus();
						return false;
					}	
					
					if(sClassValue==""||sClassValue.length==0){
						rdShowMessageDialog("字段域值不能为空!");
						document.all.sClassValue.focus();
						return false;
					}						
					
					if(iPromptSeq==""||iPromptSeq.length==0){
						rdShowMessageDialog("提示序号不能为空!");
						document.all.iPromptSeq2.focus();
						return false;
					}	
					if(iPromptType==""||iPromptType=="none"){
						rdShowMessageDialog("请选择提示类型!");
						document.all.iPromptType2.focus();
						return false;
					}					
					if(iBillType==""||iBillType=="none"){
						rdShowMessageDialog("请选择票据类型!");
						document.all.iBillType2.focus();
						return false;
					}			
					
					if(document.getElementById("qryFieldInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value == ""){
							rdShowMessageDialog("请选择审批人,审批人至少需要一人!");
							return false;							
					}
					
					sAuditLoginsValue = document.getElementById("qryFieldInfoFrame").contentWindow.document.getElementById ('sAuditLogins').value;
				}
				
				var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
				if(confirmFlag!=1){
					return false;
				}
				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					//解决因为disabled而不能传值的问题
					var sFunctionCode = replaceSpacialCharacter(jtrim(document.all.sFunctionCode.value));
					var iBillType = replaceSpacialCharacter(document.all.iBillType.value);
					var iPromptType = replaceSpacialCharacter(document.all.iPromptType.value);
					var iPromptSeq = replaceSpacialCharacter(jtrim(document.all.iPromptSeq.value));
					//rdShowMessageDialog(sAuditLoginsValue);	
					document.frm.action = "f9608_oprCfm.jsp?sFunctionCode="+sFunctionCode+"&iBillType="+iBillType+"&iPromptType="+iPromptType+"&iPromptSeq="+iPromptSeq+"&sAuditLogins="+sAuditLoginsValue;
					document.frm.submit();					
				}else if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					//解决因为disabled而不能传值的问题
					var iClassCode = replaceSpacialCharacter(jtrim(document.all.iClassCode.value));
					var sClassValue =replaceSpacialCharacter(jtrim(document.all.sClassValue.value));
					var iBillType = replaceSpacialCharacter(document.all.iBillType2.value);
					var iPromptType = replaceSpacialCharacter(document.all.iPromptType2.value);
					var iPromptSeq = replaceSpacialCharacter(jtrim(document.all.iPromptSeq2.value));
					var sFunctionCode = replaceSpacialCharacter(jtrim(document.all.sFunctionCode2.value));
									
					//rdShowMessageDialog(sAuditLoginsValue);	
					document.frm.action = "f9608_fieldCfm.jsp?sFunctionCode2="+sFunctionCode+"&iBillType2="+iBillType+"&iPromptType2="+iPromptType+"&iPromptSeq2="+iPromptSeq+"&iClassCode="+iClassCode+"&sClassValue="+sClassValue+"&sAuditLogins="+sAuditLoginsValue;
					
					document.frm.submit();
				}
			}

			function replaceSpacialCharacter(source)
			{
				source = source.replace("#","%23");
				source = source.replace("&","%26");
				source = source.replace("+","%2b");
				source = source.replace("?","%3f");
				source = source.replace("_","%5f");
				source = source.replace('"',"%22");
				source = source.replace("'","%27");
				return source;
			}
			
			/**重置页面**/
			function doReset(){
				window.location.reload();
				/*
				//因为document.all.confirmFlag.value随着切换拥有不同的值
				//如果frm.reset(),则容易错误.
				//可废弃以下的代码,修改成:window.location.reload()或者window.location.href="xxxx"
				var e = document.forms[0].elements;
				for(var i=0;i<e.length;i++){
				  if(e[i].type=="select-one"){
				  	e[i].value="none";
				  }
				  if(e[i].type=="text"&&e[i].name!="confirmFlag"){
				  	e[i].value="";
				  }
				}
				
				//隐藏所有的显示的iframe
				var iframes = document.getElementsByTagName("iframe");
				for(var i=0;i<iframes.length;i++){
					if(iframes[i].id!="sAuditLoginInfoFrame"||iframes[i].id!="sAuditLoginInfoFrame2")
					iframes[i].style.display = "none";	
				}
				*/
			}
			
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			
			/**过滤字符左右的空格**/
			function jtrim(str){
				if(str==null)return;
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
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据界面删除</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>根据业务删除</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
		
		<!--
			/*@service information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
			 *@inparam	opNote			操作备注
			 *@inparam	ipAddr			IP地址
			 
			 
			 *@inparam	sFunctionCode	提示操作功能
			 *@inparam	iBillType	票据类型
			 *@inparam	iPromptType	提示类型
			 *@inparam	iPromptSeq	提示序号
			 *@output parameter information
			 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td width="35%">
						<input type="text" name="sFunctionCode" value="" onKeyDown="if(event.keyCode==13)doQuery()">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>
					<td width="15%" class="blue">提示序号</td>
					<td width="35%">
						<input type="text" name="iPromptSeq" value="">
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td>
						<select name="iPromptType">
							<option value="none" selected>请选择</option>
							<option value="2">2->资费描述</option> <!--add by diling for 申告：注意事项库修改和删除不成功@2011/11/3-->
							<option value="11">11->事前提示</option>
							<option value="13">13->事后提示</option>
						</select>						
					</td>
					<td class="blue">票据类型</td>
					<td>
						<select name="iBillType">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
				</tr>
				<tr> 
		        <td noWrap align="center" colspan="4" > 
		        	 <input type="button" name="queryButton"  class="b_text" value="查询" style="cursor:hand;" onclick="doQuery()">
						<td>
				</tr>				
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>操作备注</td>
					<td colspan="3"><input type="text" name="opNote" value="" size="100" maxlength="60"></td>
				</tr>		
			</table>		
		</div>
		<!--
			/*@service information
			 *@name						s9608Cfm2
			 *@author					lugz
			 *@created	2008-10-10 14:54:23
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
			 *@inparam	opNote			操作备注
			 *@inparam	ipAddr			IP地址
			 
			 *@inparam	iBillType	票据类型
			 *@inparam	iClassCode	代码
			 *@inparam	sClassValue	字段域值
			 *@inparam	iPromptType	提示类型
			 *@inparam	iPromptSeq	提示序号
			 *@output parameter information
			 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>代码</td>
					<td width="35%">
						<input type="text" name="iClassCode" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFieldClassCode()" value="查询">
					</td>
					<td width="15%" class="blue" nowrap>字段域名称</td>
					<td width="35%">
						<input type="text" name="iClassName" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>	
				</tr>
				<tr>
					<td colspan="4" style='height:0;'>
						<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td colspan="3">
						<input type="text" name="sFunctionCode2" value="" onKeyDown="if(event.keyCode==13)doQuery()">
					</td>
				</tr>				
				<tr>
					<td width="15%" class="blue">字段域值</td>
					<td>
						<input type="text" name="sClassValue" value="">
					</td>	
					<td width="15%" class="blue">提示序号</td>
					<td><input type="text" name="iPromptSeq2" value=""></td>
				</tr>
				<tr>		
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td>
						<select name="iPromptType2">
							<option value="none" selected>请选择</option>
							<option value="2">2->资费描述</option> <!--add by diling for 申告：注意事项库修改和删除不成功@2011/11/3-->
							<option value="12">12->事中提示</option>
							<option value="13">13->事后提示</option>
						</select>						
					</td>
					<td class="blue">票据类型</td>
					<td>
						<select name="iBillType2">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
				</tr>
		      <tr> 
		        <td noWrap align="center" colspan="4" > 
		        	 <input type="button" name="queryButton"  class="b_text" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
						<td>
					</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="15%" nowrap>操作备注</td>
					<td colspan="3"><input type="text" name="opNote2" value="" size="100" maxlength="60"></td>
				</tr>	
			</table>
		</div>
		
		<!--以下为操作部分-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="确定删除" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
     <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
