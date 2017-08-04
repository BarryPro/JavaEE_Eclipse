<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>提醒短信新增</title>
	<%
		String opCode = "d285";
		String opName = "提醒短信新增";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
		/** 查询工号组织机构 **/
		String sReleaseGroupName = "";
		String getGroupNameSql = "select group_name ,root_distance from dChnGroupMsg where group_id  = '"+groupId+"'";		
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=getGroupNameSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
	<%
		int root_distance_int = 0;
		if(retCode1.equals("000000")){
			String root_distance = sVerifyTypeArr[0][1];
			root_distance_int = Integer.parseInt(root_distance);
			if(root_distance_int>3)
			{
	%>
				<script>
					rdShowMessageDialog("该工号无增加权限!");
					window.close();
				</script>
	<%
				return ;
			}
			
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				sReleaseGroupName = sVerifyTypeArr[0][0];
			}
		}
	%>
	<%
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	%>
			
		
	<script language="javascript">
		function doReset(){
			window.location.href = "fd285.jsp"
		}
		function chkTime(time1,time2)
		{
			if(parseInt(time2.value)<=parseInt(time1.value))
			{
				time2.select();
				rdShowMessageDialog("失效时间应大于生效时间");
				return;
			}
		}
		/**改变发布节点类型触发的事件**/
		function doChangePromNodeType(){
			document.all.townByRegionTr.style.display = "none";
			$("#sGroupInfo").val("");
			$("#sGroupId").val("");
			var promulgateNodeType = document.all.promulgateNodeType;
			if(promulgateNodeType.value=="none"){
				document.getElementById("promulgateNodeFrame").style.display="none";
				return false;
			}
			document.getElementById("promulgateNodeFrame").style.display = "block";
			if(promulgateNodeType.value=="0"){
				document.promulgateNodeFrame.location = "fd285_getPromNodeByProvince.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
			}
			else if(promulgateNodeType.value=="1"){
				document.promulgateNodeFrame.location = "fd285_getPromNodeByRegion.jsp?root_distance_int=<%=root_distance_int%>";
			}else if(promulgateNodeType.value=="2"){
				document.all.townByRegionTr.style.display = "block";
				document.promulgateNodeFrame.location = "fd285_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
			}
		}
		/**发布节点类型是"区县"时,选择"地市"调用的函数**/
		function doChangeTownByRegion(){
			document.promulgateNodeFrame.location = "f9605_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
		}
		function doConfirm(){
			/* 校验短信代码是否存在 */
			if(document.all.msgCode.value.trim()==""){
				rdShowMessageDialog("请填写短信代码!");
				document.all.msgCode.focus();
				return false;
			}
			/* 校验渠道类型是否选择 */
			if(document.getElementById("Channels_Code").value=="none")
			{
				rdShowMessageDialog("请选择渠道类型");
				return false
			}
			/*验证生效时间与失效时间*/
			if(document.all.sValidTime.value.trim()==""){
				rdShowMessageDialog("生效时间不能为空!");
				return false;
			}
			if(document.all.sInvalidTime.value.trim()==""){
				rdShowMessageDialog("失效时间不能为空!");
				return false;
			}
			if(parseInt(document.all.sValidTime.value.trim())<<%=dateStr%>){
				rdShowMessageDialog("生效时间不能小于当前时间!");
				return false;						
			}
			if(parseInt(document.all.sInvalidTime.value.trim())<<%=dateStr%>){
				rdShowMessageDialog("失效时间不能小于当前时间!");
				return false;						
			}
			chkTime(document.getElementById('sValidTime'),document.getElementById('sInvalidTime'));
			/* 校验时间结束 */
			/* 校验新增内容 */
			if($("#sMsgContent").val().trim()==""){
				rdShowMessageDialog("请输入短信补充内容");
				$("#sMsgContent")[0].focus();
				return false;
			}
			/* 校验新增内容长度 */
			var msgContent =  $("#sMsgContent").val();
			var msgByteLen = getByteLen(msgContent);
			if(msgByteLen > 124){
				rdShowMessageDialog("最多只允许输入62个汉字");
				return false;
			}
			/* 校验发布区域 */
			if(document.all.sGroupId.value==""){
					rdShowMessageDialog("请选择发布区域!");
					return false;
			}
			/* 校验审批人 */
			if(document.all.sAuditLogins.value == ""){
					rdShowMessageDialog("请选择审批人,审批人至少需要一人!");
					return false;							
			}
			/* 提交页面 */
			var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
			if(confirmFlag!=1){
				return false;
			}
			/**传递如下参数,用来解决disabled不能传值问题**/
			var iPromptType = document.all.iPromptType.value;
			var sValidFlag = document.all.sValidFlag.value;
			var sCreateLogin = document.all.sCreateLogin.value;
			var sCreateTime = document.all.sCreateTime.value;

			document.frm.action = "fd285Cfm.jsp?iPromptType="+iPromptType+"&sValidFlag="+sValidFlag+"&sCreateLogin="+sCreateLogin+"&sCreateTime="+sCreateTime;
			document.frm.submit();			
		}
		function getByteLen(str){ 
			var byteLen=0,len=str.length; 
			if(str){ 
				for(var i=0; i<len; i++){ 
					if(str.charCodeAt(i)>255){ 
						byteLen += 2; 
					} 
					else{ 
						byteLen++; 
					} 
				} 
				return byteLen; 
			} 
			else{ 
				return 0; 
			} 
		}
		function getMsgInfo(){
			/* 根据短信代码或内容模糊查询短信模板 */
			var sMsgCode = $("#msgCode").val();
			var sMsgName = $("#msgNote").val();
			var sKindCode = $("#kindCode").val();
			if(sMsgCode.trim() == "" && sMsgName.trim() =="" ){
				rdShowMessageDialog("模板代码与模板名称必须输入一项!<br>(支持模糊查询,只需输入部分信息)");
				document.all.msgCode.focus();
				return false;
			}
			var h = 500;
      var w = 350;
      var t = screen.availHeight / 2 - h / 2;
      var l = screen.availWidth / 2 - w / 2;
      var impFrm = document.frm;
      var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
      var path = "fd285_getMsgInfo.jsp?kindCode="+sKindCode+"&sMsgCode="+sMsgCode+"&sMsgName="+sMsgName;
      var ret = window.showModalDialog(path, impFrm, prop);
      if(typeof(ret) != "undefined"){
	      setMsgInfo(ret);
	    }
		}
		function setMsgInfo(allStr){
			var valueArr = allStr.split("|");
			$("#msgCode").val(valueArr[0]);
			$("#msgNote").val(valueArr[1]);
			$("#sTemplateContent").val(valueArr[2]);
			/*2014/03/06 9:15:44 gaopeng  关于修改12580热线满意度调查短信内容的需求 回调之后进行赋值后，将输入框置灰*/
			if($.trim($("#msgCode").val()).length != 0){
				/*模板代码和模板名称不可修改*/
				$("#msgCode").attr("readonly","readonly");
				$("#msgNote").attr("readonly","readonly");
			}
			/*2014/03/06 9:15:44 gaopeng  关于修改12580热线满意度调查短信内容的需求 回调之后进行赋值后，将输入框置灰*/
		}
		function clearMsgInfo(){
			$("#msgCode").val("");
			$("#msgNote").val("");
			$("#msgCode").attr("readonly","");
			$("#msgNote").attr("readonly","");
			$("#sTemplateContent").val("");
			$("#msgCode")[0].focus();
		}
		function checklen(){
			/* 动态修改剩余字数 */
			var msgContent =  $("#sMsgContent").val();
			var msgByteLen = getByteLen(msgContent);
			var addedWordNumber = Math.ceil(msgByteLen / 2);
			var wordNumberObj = $("#wordNumber");
			if(msgByteLen <= 124){
				var surplusNum = 62 - addedWordNumber;
				var innetText = "已经添加" + addedWordNumber + "字，还可以添加" + surplusNum + "字";
				wordNumberObj.html(innetText);
				wordNumberObj.css("color","");
			}else{
				var overTopNum = addedWordNumber - 62;
				var innetText = "已经超出" + overTopNum + "字";
				wordNumberObj.html(innetText);
				wordNumberObj.css("color","red");
			}
		}
		function changeMsgsCode(){
			/*$("#allKind").hide();*/
			$("#kindCode").val($("#msgsCode").val());
			$("#msgsCode").attr("disabled","disabled");
			$("#mainBody").show();
			$("#reselection").show();
			document.sAuditLoginInfoFrame.location = "fd285_getAuditLoginInfo.jsp?createLoginNo=<%=workNo%>";
		}
	</script>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">提醒短信新增</div>
	</div>
	<div id="allKind">
		<table cellspacing="0">
			<tr>
				<td class="blue">请选择短信大类别</td>
				<td>
				<select name="msgsCode" id="msgsCode" onchange="changeMsgsCode()">
					<option value="none">--请选择--</option>
					<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select distinct kind_code,kind_name from sshortmsgscode</wtc:sql>
					</wtc:qoption>
				</select>
				<input type="hidden" name="kindCode" id="kindCode" />
				<input type="button" name="reselection" id="reselection" style="display:none"
				 class="b_text" value="重选" onclick="doReset()" />
				</td>
			</tr>
		</table>
	</div>
	<div id="mainBody" style="display:none;">
	<!--发布动作类型,1,发布,2,收回,3,更新-->
	<input type="hidden" name="iReleaseAction" value="1">
	<table>
		<tr>
			<td width="15%" class="blue" nowrap>短信模板代码</td>
			<td width="35%">
				<input name="msgCode" id="msgCode" />
				<input name="" type="button" class="b_text" style="cursor:hand" onClick="getMsgInfo()" value="获取">&nbsp;
				<input name=""  type="button" class="b_text" style="cursor:hand" onClick="clearMsgInfo()" value="清除">
			</td>
			<td width="15%" class="blue" nowrap>短信模板名称</td>
			<td>
				<input type="text" name="msgNote" id="msgNote" value="">&nbsp;<font class="orange">(匹配模糊查询)</font>
			</td>
		</tr>
		<tr>
			<td class="blue">发布机构</td>
			<td >
				<input type="text" name="sReleaseGroupName" value="<%=sReleaseGroupName%>" disabled>
				<input type="hidden" name="sReleaseGroup" value="<%=groupId%>">
				<!-- 提示类型,渠道类型，应市场部要求，隐藏 -->
				<input type="hidden" name="iPromptType" value="20" />
				<input type="hidden" name="Channels_Code" value="01" />
			</td>
			<td width="15%" class="blue" nowrap>有效标志</td>
			<td>
				<select name="sValidFlag" disabled>
					<option value="Y" selected>有效</option>
					<option value="N">无效</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">创建工号</td>
			<td><input type="text" name="sCreateLogin" value="<%=workNo%>" disabled></td>
			<td class="blue">创建时间</td>
			<td><input type="text" name="sCreateTime" value="<%=dateStr1%>" disabled></td>
		</tr>
		<tr>
			<td class="blue">生效时间</td>
			<td><input type="text" name="sValidTime" value="<%=dateStr%>" maxlength="8" 
						 onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;">
			</td>
			<td class="blue">失效时间</td>
			<td><input type="text" name="sInvalidTime" value="20500101" maxlength="8" 
					 onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"
					 onblur="chkTime(document.getElementById('sValidTime'),document.getElementById('sInvalidTime'))" 	/>
			</td>
		</tr>
		<tr>
			<td class="blue">模板内容</td>
			<td colspan="3">
				<textarea name="sTemplateContent" id="sTemplateContent" rows="4" cols="75" disabled readonly></textarea>
				<font class="orange"><span id="wordNumber">(注:$符为变量)</span></font>
			</td>
		</tr>
		<tr>
			<td class="blue">短信补充内容</td>
			<td colspan="3">
				<textarea name="sMsgContent" id="sMsgContent" rows="4" cols="75" 
					 onpropertychange="checklen(this)" ></textarea>
				<font class="orange"><span id="wordNumber">(注:最多62个汉字)</span></font>
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>发布区域类型</td>
			<td colspan="3">
				<select name="promulgateNodeType" onchange="doChangePromNodeType()">
					<option value="none" selected>请选择</option>
							<%
							if(root_distance_int==1)
							{
							%>
								<option value="0">省</option>
								<option value="1">地市</option>
							<%
							}
							if(root_distance_int==2)
							{
							%>
								<option value="1">地市</option>
								<option value="2">区县</option>
							<%}
							if(root_distance_int>2)
							{
							%>
								<option value="2">区县</option>
							<%}%>
				</select>
			</td>
		</tr>
		<tr id="townByRegionTr" style="display:none">
			<td width="15%" class="blue">请选择地市</td>
			<td colspan="3">
				<select name="townByRegionSelect" onchange="doChangeTownByRegion()">
					<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select group_id,group_id||'->'||group_name from dChnGroupMsg where group_id in (select parent_group_id from dChnGroupInfo  where group_id = '<%=groupId%>' ) and ROOT_DISTANCE = 2</wtc:sql>
					</wtc:qoption>
				</select> 
			</td>
		</tr>
		<tr>
			<td colspan="4" style="height:0;">
				<iframe frameBorder="0" id="promulgateNodeFrame" align="center" 
					 name="promulgateNodeFrame" scrolling="no" style="height:100%; 
					 visibility:inherit; width:100%; z-index:1; display:none;"  
					 onload="document.getElementById('promulgateNodeFrame').style.height=promulgateNodeFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>已选的发布区域</td>
			<td colspan="3">
				<textarea name="sGroupInfo" id="sGroupInfo" rows="5" cols="75" readonly></textarea>
				<input type="hidden" name="sGroupId" id="sGroupId" value="">
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>请选择审批人</td>
			<td colspan="3">
				<iframe frameBorder="0" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" 
					scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1;"  
					onload="document.getElementById('sAuditLoginInfoFrame').style.height=sAuditLoginInfoFrame.document.body.scrollHeight+'px'"></iframe>
				<input type="hidden" name="sAuditLogins" value="">
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>操作备注</td>
			<td colspan="3">
				<input type="text" name="opNote" value="" size="90" maxlength="60">
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="重置" onclick="doReset()" />
				&nbsp;
				<input type="button" name="subbtn" class="b_foot" value="提交审核" onclick="doConfirm()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>