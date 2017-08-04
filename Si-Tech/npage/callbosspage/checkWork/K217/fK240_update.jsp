<%
  /*
   * 功能: 差错类别定义
   * 版本: 1.0
   * 日期: 2008/11/05
   * 作者: kouwb
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String opType = request.getParameter("op").trim();
	String error_class_id = new String();
	String parent_error_class_id = new String();
	String error_class_name = new String();
	String note = new String();
	String title = new String();
	String valid_flag = new String();
	String valid_yes = new String();
	String valid_no = new String();
	String readonly = new String();
	
	if(opType.equals("add")){
			title = "新增";
	}else{
		title = "修改";
		readonly = "readonly";
		error_class_id = request.getParameter("error_class_id");
		parent_error_class_id = request.getParameter("parent_error_class_id");
		error_class_name = request.getParameter("error_class_name");
		note = request.getParameter("note");
		valid_flag = request.getParameter("valid_flag");
		
		if(valid_flag.equals("Y"))
				valid_yes = "selected";
		else
				valid_no = "selected";
		}
		String opCode = "K240";
		String opName = "差错类别定义";
	  request.setCharacterEncoding("gb2312");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  String sql = "";
%>
<html>
	<head>
		<title>差错类别<%=title%></title> 
		
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<script language="javascript">
function modCfm(){
		if(document.form1.error_class_id.value == ""){
				similarMSNPop("请输入编号！");
				document.form1.error_class_id.select();
				return;
		}else if(document.form1.error_class_name.value == ""){
				similarMSNPop("请输入名称！");
				document.form1.error_class_name.select();
				return;
		}else if(document.form1.parent_error_class_id.value == ""){
				similarMSNPop("请输入上层节点编号！");
				document.form1.parent_error_class_id.select();
				return;
		}else if(isNaN(document.form1.error_class_id.value)){
				similarMSNPop("编号必须为数字！");
				document.form1.error_class_id.select();
				return;
		}else if(isNaN(document.form1.parent_error_class_id.value)){
				similarMSNPop("请输入上层编号必须为数字！");
				document.form1.parent_error_class_id.select();
				return;
		}
		
		var myPacket = new AJAXPacket("fK240I_AddMod.jsp","正在提交，请稍候......");
		myPacket.data.add("retType","<%=opType%>");
		myPacket.data.add("login_no","<%=workNo%>");
		myPacket.data.add("error_class_name",trim(document.form1.error_class_name.value));
		myPacket.data.add("note",trim(document.form1.note.value));
		myPacket.data.add("error_class_id",trim(document.form1.error_class_id.value));
		myPacket.data.add("parent_error_class_id",trim(document.form1.parent_error_class_id.value));
		myPacket.data.add("valid_flag",trim(document.form1.valid_flag.value));
		core.ajax.sendPacket(myPacket,doProcess);
		myPacket=null;
} 
					
function doProcess(packet) {
		var retType = packet.data.findValueByName("retType");		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");		
		
		if(retCode=='000000'){
				similarMSNPop(retMsg + "[" + retCode + "]");
				window.returnValue = "" + retCode + "~" + retMsg + "~" + trim(document.form1.error_class_name.value) +
														"~" + trim(document.form1.note.value) +
														"~" + trim(document.form1.error_class_id.value) +
														"~" + trim(document.form1.parent_error_class_id.value) +
														"~" + trim(document.form1.valid_flag.value) +
														"~";
				window.close();					
		}else{
				similarMSNPop(retMsg + "[" + retCode + "]");
				window.returnValue = "" + retCode + "~" + retMsg + "~";
				window.close();							
		}
}			
			
function ltrim(s){
		return s.replace( /^\s*/, ""); 
} 

function rtrim(s){
		return s.replace( /\s*$/, ""); 
}
 
function trim(s){
		return rtrim(ltrim(s)); 
}		
</script>

	</head>
	<body>
		<form name="form1" method="POST">
			<%@ include file="/npage/include/header.jsp" %>	
				<div class="title">差错类别<%=title%></div>
				<table cellspacing="0">
					<tr>
						<td>
							<div align="right">编号</div>
						</td>
						<td>
							<div align="left"><input type="text" name="error_class_id" value="<%=error_class_id%>" maxlength="10" <%=readonly%>/></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right">名称</div>
						</td>
						<td>
							<div align="left"><input type="text" name="error_class_name" value="<%=error_class_name%>" maxlength="50"/></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right">上层节点编号</div>
						</td>
						<td>
							<div align="left"><input type="text" name="parent_error_class_id" value="<%=parent_error_class_id%>" maxlength="10"/></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right">是否可用</div>
						</td>
						<td>
							<div align="left">
								<select name="valid_flag">
									<option value="Y" <%=valid_yes%>>是</option>
									<option value="N" <%=valid_no%>>否</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<td style="border-right:0px;border-bottom:0px">
							<div align="right">描述</div>
						</td>
						<td>
							<div align="left" style="border-bottom:0px">&nbsp;&nbsp;</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center"><textarea name="note" cols="40" rows="5"><%=note%></textarea></div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								<input type="button" name="cfm" class="b_foot" value="确认" onclick="modCfm()"/>
								<input type="button" name="clo" class="b_foot" value="关闭" onclick="javascript:window.close();"/>
							</div>
						</td>
					</tr>
				</table>
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
