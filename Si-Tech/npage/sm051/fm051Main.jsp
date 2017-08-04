<%
  /*
   * 功能:R_CMI_HLJ_xueyz_2014_1365513@关于开发批量添加vip功能的需求
   * 版本: 1.0
   * 日期: 2014/03/10 9:03:55
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		
 		String loginAccept = getMaxAccept();
 		String nowRootDistance = "";
 		/*true时，说明是省级工号*/
 		boolean isProvFlag = false;
	
		String sRegionSql = "select b.root_distance from dloginmsg a, dchngroupmsg b "
		+"where a.group_id = b.group_id and a.login_no = '"+loginNo+"'";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="1">
			<wtc:param value="<%=sRegionSql%>"/>
		</wtc:service>
<wtc:array id="resultRegion" scope="end" />

<%
	if("000000".equals(code0) && resultRegion.length > 0){
		nowRootDistance = resultRegion[0][0];
		if("1".equals(nowRootDistance)){
			isProvFlag = true;
		}else if("2".equals(nowRootDistance)){
			isProvFlag = false;
		}
	}else{
%>
	<script language="javascript">
		rdShowMessageDialog("获取工号权限失败！",1);
		removeCurrentTab();
	</script>
<%
}
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			/*默认选中*/
			$("input[name='opFlag']").each(function(){
				var thisObj = $(this);
					if(thisObj.val() == "<%=opCode%>"){
						$(this).attr("checked","checked");
					}
			});
			/*显隐*/
			changeOpFlag("<%=opCode%>");
			
		});
		/*操作类型改变事件*/
		function changeOpFlag(opcode){
			$("#resultContent").hide();
			if(opcode == "m051"){
				$("#insertContent").show();
				$("#qryContent").hide();
				$("#submitr").val("确认");
			}else if(opcode == "m052"){
				$("#insertContent").hide();
				$("#qryContent").show();
				$("#submitr").val("查询");
			}
		}
		/*确认或查询方法*/
		function doCfm(){
			var opFlag = $("input[name='opFlag'][checked]").val();
			if(opFlag == "m051"){
				if(!checkElement(document.all.oaFileNo)){
					return false;
				};
				if(!checkElement(document.all.oaFileName)){
					return false;
				};
				if(!checkElement(document.all.uploadFile)){
					return false;
				};
				
				/*执行上传文件操作，上传文件后调用服务*/
				if($("#uploadFile").val() == ""){
					rdShowMessageDialog("请选择vip批量导入文件！");
					$("#uploadFile").focus();
					return false;
				}
				var formFile=form_m051.uploadFile.value.lastIndexOf(".");
				var beginNum=Number(formFile)+1;
				var endNum=form_m051.uploadFile.value.length;
				formFile=form_m051.uploadFile.value.substring(beginNum,endNum);
				formFile=formFile.toLowerCase(); 
				if(formFile!="txt"){
					rdShowMessageDialog("上传文件格式只能是txt，请重新选择宽带提速信息文件！",1);
					document.form_m051.uploadFile.focus();
					return false;
				}
				else
					{
						/*准备上传*/
						document.form_m051.target="hidden_frame";
				    document.form_m051.encoding="multipart/form-data";
				    document.form_m051.action="/npage/sm051/fm051Upload.jsp";
				    document.form_m051.method="post";
				    document.form_m051.submit();
						return true;
					}
				
			}else if(opFlag == "m052"){
				if(!checkElement(document.all.phoneNo)){
					return false;
				};
				var oaFileNoQry = $.trim($("#oaFileNoQry").val());
				var phoneNo = $.trim($("#phoneNo").val());
				if(oaFileNoQry.length == 0 && phoneNo.length ==0){
					rdShowMessageDialog("oa文件编号和手机号码至少输入一项！",1);
					return false;
				}
				/*执行查询操作，查询后展示*/
				var iLoginAccept = "<%=loginAccept%>";
				var iChnSource = "01";
				var iOpCode = opFlag;
				var iLoginNo = "<%=loginNo%>";
				var iLoginPwd = "<%=noPass%>";
				var iPhoneNo = document.all.phoneNo.value;
				var iUserPwd = "";
				var iFileNo = document.all.oaFileNoQry.value;
				
				var getdataPacket = new AJAXPacket("/npage/sm051/fm052Qry.jsp","正在获得数据，请稍候......");
				getdataPacket.data.add("iLoginAccept",iLoginAccept);
				getdataPacket.data.add("iChnSource",iChnSource);
				getdataPacket.data.add("iOpCode",iOpCode);
				getdataPacket.data.add("iLoginNo",iLoginNo);
				getdataPacket.data.add("iLoginPwd",iLoginPwd);
				getdataPacket.data.add("iPhoneNo",iPhoneNo);
				getdataPacket.data.add("iUserPwd",iUserPwd);
				getdataPacket.data.add("iFileNo",iFileNo);
				
				core.ajax.sendPacket(getdataPacket,doRetRegion);
				getdataPacket = null;
				
			}
			
		}
		function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			if(retCode == "000000"){
				$("#resultContent").show();
				$("#appendBody").empty();
				var appendTh = 
					"<tr>"
					+"<th width='25%'>手机号码</th>"
					+"<th width='25%'>导入时间</th>"
					+"<th width='25%'>VIP卡号</th>"
					+"<th width='25%'>VIP级别</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				for(var i=0;i<retArray.length;i++){
					var appendStr = "<tr>";
					appendStr += "<td width='25%'>"+retArray[i][0]+"</td>"
											+"<td width='25%'>"+retArray[i][1]+"</td>"
											+"<td width='25%'>"+retArray[i][3]+"</td>"
											+"<td width='25%'>"+retArray[i][2]+"</td>"
					appendStr +="</tr>";						
					$("#appendBody").append(appendStr);
				}
				
				
			}else{
				$("#resultContent").hide();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		function tellMore(){
			rdShowMessageDialog("最多只能上传200条数据！，请重新选择文件!",1);
			$("#oaFileName").val("");
			return false;
		}
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			window.location.href='/npage/sm051/fm051Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="form_m051" id="form_m051">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
	<table >
		<tr>
			<td width="20%" class="blue">操作类型</td>
			<td width="80%" colspan="3">
				<input type="radio" name="opFlag" value="m051" onclick="changeOpFlag(this.value);"/>录入&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="m052" onclick="changeOpFlag(this.value);"/>查询
			</td>
			<!--
			<td width="50%" colspan="2">
				<a href="/npage/sm051/vip_bat_templet.xls" ><font color="red">模板下载</font></a>
			</td>
			-->
		</tr>
	</table>
	<table id="insertContent">
		<tr>
			<td width="20%" class="blue">oa文件编号</td>
			<td width="30%">
				<input type="text" id="oaFileNo" name="oaFileNo" v_must="1" maxlength="30" value=""/>&nbsp;<font color="red">*</font>
			</td>
			<td width="20%" class="blue">oa文件名称</td>
			<td width="30%">
				<input type="text" id="oaFileName" name="oaFileName" v_must="1" value=""/>&nbsp;<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">导入来源</td>
			<td width="30%">
				<select name="provLogin">
					<%if(isProvFlag){%>
						<option value="01">省公司</option>
					<%
					}
					%>
					<option value="02">地市</option>
				</select>&nbsp;<font color="red">*</font>
			</td>
			<td width="20%" class="blue">导入文件</td>
			<td width="30%">
				<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
			</td>
		</tr>
		<tr>
				<td class="blue">
					文件格式说明
				</td>
        <td colspan="3"> 
            上传文件文本格式为“手机号码+‘|’+客户级别+‘|’+VIP卡号+回车键”，示例如下：<br>
            <font class='orange'>
            	&nbsp;&nbsp; 13836141618|01|0814011010112341<br/>
            	&nbsp;&nbsp; 13836141611|02|0814011010112342<br/>
            	&nbsp;&nbsp; 13836141612|03|0814011010112343<br/>
            	&nbsp;&nbsp; 13836141613|01|0814011010112344<br/>
            	&nbsp;&nbsp; 13836141614|02|0814011010112345<br/>
            	&nbsp;&nbsp; 13836141615|03|0814011010112346
            </font>
            <b>
            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且都需要回车换行。
            	文本文件格式为txt文件，最多可输入1000行数据。
            </b> 
        </td>
	    </tr>
	</table>
	
	<table id="qryContent">
		<tr>
			<td width="20%" class="blue">oa文件编号</td>
			<td width="30%">
				<input type="text" id="oaFileNoQry" v_must="1" name="oaFileNoQry" maxlength="30" value=""/>&nbsp;
			</td>
			<td width="20%" class="blue">手机号码</td>
			<td width="30%">
				<input type="text" id="phoneNo" name="phoneNo"   v_type="mobphone"  maxlength="11" value="" onblur="checkElement(this)"/>&nbsp;
			</td>
		</tr>
	</table>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="确认" onclick="doCfm()" id="submitr" >&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="重置" onclick="window.location.href = '/npage/sm051/fm051Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';" >&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
			<!--流水号 -->
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<!-- 查询结果列表 -->
<div id="resultContent" style="display:none">
	<div class="title">
		<div id="title_zi">查询结果列表</div>
	</div>
	<table id="exportExcel" name="exportExcel">
		<tbody id="appendBody">
			
		
		</tbody>
	</table>
</div>
</div>


	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
