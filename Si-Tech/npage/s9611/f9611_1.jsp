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
    
 		String opCode = "9611";
 		String opName = "注意事项库查询";
 		
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
	<title>黑龙江BOSS-注意事项库查询</title>
	<!--调用js库-->
	<script language="javascript">
		<!--

			/**显示"根据界面增加"**/
			function showOprInfo(){
				doReset();
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
				document.getElementById("qryFieldInfoFrame").style.display = "none";
			}

			/**显示"根据业务增加"**/
			function showFieldInfo(){
				doReset();
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
				document.getElementById("qryOprInfoFrame").style.display="none";
				
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
			
			/**开始查询**/
			function doQuery(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					var audit_accept = document.all.audit_accept.value;
					var op_time_begin = document.all.op_time_begin.value;
					var op_time_end = document.all.op_time_end.value;
					var op_code = document.all.op_code.value;
					var bill_type = document.all.bill_type.value;
					var prompt_type = document.all.prompt_type.value;
					var login_no = document.all.login_no.value;
					
					if(op_code=="")
					{
						rdShowMessageDialog("操作代码不能为空！");
						return;
					}
						
				
								
					document.getElementById("qryOprInfoFrame").style.display="block"; 
					document.qryOprInfoFrame.location = "f9611_getAuditByFunctionCode.jsp?audit_accept="+audit_accept+"&op_time_begin="+op_time_begin+"&op_time_end="+op_time_end+"&op_code="+op_code+"&bill_type="+bill_type+"&prompt_type="+prompt_type+"&login_no="+login_no;
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var audit_accept01 = document.all.audit_accept01.value;
					var op_time01_begin = document.all.op_time01_begin.value;
					var op_time01_end = document.all.op_time01_end.value;
					var op_code01 = document.all.op_code01.value;
					var bill_type01 = document.all.bill_type01.value;
					var prompt_type01 = document.all.prompt_type01.value;
					var login_no01 = document.all.login_no01.value;
					var class_code = document.all.class_code.value;
		      var class_value = document.all.class_value.value;

					if(op_code01=="")
					{
						rdShowMessageDialog("操作代码不能为空！");
						return;
					}
					
					
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location = "f9611_getAuditByClassCode.jsp?audit_accept01="+audit_accept01+"&op_time01_begin="+op_time01_begin+"&op_time01_end="+op_time01_end+"&op_code01="+op_code01+"&bill_type01="+bill_type01+"&prompt_type01="+prompt_type01+"&login_no01="+login_no01+"&class_code="+class_code+"&class_value="+class_value;					
				}
			}
			
			/**重置页面**/
			function doReset(){
				//因为document.all.confirmFlag.value随着切换拥有不同的值
				//如果frm.reset(),则容易错误.
				//可废弃以下的代码,修改成:window.location.reload()或者window.location.href="xxxx"
				var e = document.forms[0].elements;
				for(var i=0;i<e.length;i++){
				  if(e[i].type=="select-one"){
				  	e[i].value="";
				  }
			  	e[i].disabled=false;
				  if(e[i].type=="text"&&e[i].name!="confirmFlag"){
				  	e[i].value="";
				  }
				}
				
				//隐藏所有的显示的iframe
				var iframes = document.getElementsByTagName("iframe");
				for(var i=0;i<iframes.length;i++){
					iframes[i].style.display = "none";	
				}
			}
			
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
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
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据界面查询</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>根据业务查询</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
    
		<!--
			/*@service information
			 *@name						s9616
			 *@description				审核记录查询
			 *@author					yangrq
			 *@created	2008-10-19 17:21:22
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
 			 *@inparam			audit_accept 审批流水
			 *@inparam			op_time      操作时间（创建时间、或修改时间）
			 *@inparam			op_code      操作代码
			 *@inparam			bill_type    票据类型
			 *@inparam			prompt_type  提示类型
			 *@inparam			login_no     发起人工号：（创建人、修改人、删除人）
			 *@return SVR_ERR_NO 
 			 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td width="35%">
						<input type="text" name="op_code" id="op_code" value="">
						<font class="orange">*(ALL代表全部操作)</font>
						&nbsp;&nbsp;</td>
					<td width="15%" class="blue" nowrap>审批流水</td>
					<td><input type="text" name="audit_accept" id="audit_accept" value="">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>操作时间</td>
					<td><input type="text" name="op_time_begin" id="op_time_begin" size="10" value="">&nbsp;-&nbsp;<input type="text" name="op_time_end" size="10" value="">(格式：yyyymmdd)</td>
					<td width="15%" class="blue" nowrap>票据类型</td>
					<td width="35%">
						<select name="bill_type">
							<option value="" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType  where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>	
					</td>
				</tr>
					<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td width="35%">
						<select name="prompt_type">
							<option value="" selected>请选择</option>
							<option value="11">11->事前提示</option>
							<option value="13">13->事后提示</option>
						</select>	
					</td>
					<td width="15%" class="blue" nowrap>发起人工号</td>
					<td width="35%"><input type="text" name="login_no" value="">&nbsp;&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
		</div>
		<!--
			/*@service information
			 *@name						s9616Cfm1
			 *@description				审核记录查询
			 *@author					yangrq
			 *@created	2008-10-19 17:21:22
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
 			 *@inparam			audit_accept 审批流水
			 *@inparam			op_time      操作时间（创建时间、或修改时间）
			 *@inparam			op_code      操作代码
			 *@inparam			bill_type    票据类型
			 *@inparam			prompt_type  提示类型
			 *@inparam			login_no     发起人工号：（创建人、修改人、删除人）
			 *@inparam			class_code   代码
			 *@inparam			class_value  字段域值
			 *@return SVR_ERR_NO 
 			 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
			<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td width="35%">
						<input type="text" name="op_code01" value="">
						<font class="orange">*(ALL代表全部操作)</font>
					</td>
					<td width="15%" class="blue" nowrap>审批流水</td>
					<td><input type="text" name="audit_accept01" value="">&nbsp;&nbsp;</td>
			</tr>
				<tr>
					<td width="15%" class="blue" nowrap>操作时间</td>
					<td><input type="text" name="op_time01_begin" size="10" value="">&nbsp;-&nbsp;<input type="text" name="op_time01_end" size="10" value="">(格式：yyyymmdd)</td>
					<td width="15%" class="blue" nowrap>票据类型</td>
					<td width="35%">
						<select name="bill_type01">
							<option value="" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>	
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td width="35%">
						<select name="prompt_type01">
							<option value="" selected>请选择</option>
							<option value="2">11->资费描述</option>
							<option value="12">12->事中提示</option>
							<option value="13">13->事后提示</option>
						</select>	
					</td>
					<td width="15%" class="blue" nowrap>发起人工号</td>
					<td width="35%"><input type="text" name="login_no01" value="">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>代码</td>
					<td width="35%">
						<select name="class_code">
							<option value="" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select class_code,to_char(class_code)||'->'||class_name from sClass where class_code in (10431,10442,10702)</wtc:sql>
							</wtc:qoption>
						</select>
					</td>
					<td width="15%" class="blue" nowrap>字段域值</td>
					<td width="35%"><input type="text" name="class_value" value="">&nbsp;&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
    </div>
     <table cellspacing="0">
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		<!--以下为操作部分-->
		<table cellspacing="0">
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprAuditInfoFrame" align="center" name="qryOprAuditInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldAuditInfoFrame" align="center" name="qryFieldAuditInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

