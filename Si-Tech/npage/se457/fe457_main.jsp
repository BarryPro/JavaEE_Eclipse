<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-09
********************/
%>
 <!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode = "e457";     
String opName = "四喜号码营销方案配置";
String regionCode = (String)session.getAttribute("regCode");
String sql = "";
String sqlVar = "";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>

<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	onload = function() {
		projectTypeSelChange();
	}
	
	function projectTypeSelChange() {
		var projectTypeSel = $("input[@name=projectTypeSel]:checked").val();
		if (projectTypeSel == "one") {
			$("#projectTypeSelOne").show();
			$("#projectTypeSelTwo").hide();
		} else if (projectTypeSel == "two") {
			var getSeqPacket = new AJAXPacket("fe457_ajaxGetSeq.jsp", "请稍候......");
			core.ajax.sendPacket(getSeqPacket, doGetSeqPacket);
		}
	}
	
	function doGetSeqPacket(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var seq = packet.data.findValueByName("seq");
		
		if (retCode != "000000") {
			rdShowMessageDialog("获取活动类型错误，" + retCode + "，" + retMsg + "。");
			$("input[@name=projectTypeSel]").each(function() {
				if (this.value == "one") {
					this.checked = true;
				}
			});
			projectTypeSelChange();
		} else {
			$("#projectTypeAdd").val(seq);
			$("#projectTypeSelOne").hide();
			$("#projectTypeSelTwo").show();
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		var projectTypeSel = $("input[@name=projectTypeSel]:checked").val();
		if (projectTypeSel == "one") {
			$("#projectNameAdd").attr("v_must", "");
			$("#projectNameAdd").attr("v_type", "");
			$("#projectNameAdd").attr("v_maxlength", "");
		} else if (projectTypeSel == "two") {
			$("#projectNameAdd").attr("v_must", "1");
			$("#projectNameAdd").attr("v_type", "string");
			$("#projectNameAdd").attr("v_maxlength", "60");
		}
		
		if (!check(document.frm)) {
			controlBtn(false);
			return false;
		} else if (parseInt($("#beginTime").val()) >= parseInt($("#stopTime").val())) {
			rdShowMessageDialog("活动开始时间必须小于活动结束时间，请重新填写！", 1);
			controlBtn(false);
			return false;
		} else if (parseInt($("#stopTime").val()) >= parseInt($("#expDate").val())) {
			rdShowMessageDialog("活动结束时间必须小于资费结束时间，请重新填写！", 1);
			controlBtn(false);
			return false;
/*		} else if (leastPrepayObj.value.substring(leastPrepayObj.value.indexOf(".") + 1, leastPrepayObj.value.length).length > 2) {
			rdShowMessageDialog("净预存只精确到0.01元，请重新填写！", 1);
			controlBtn(false);
			return false;*/
		} else if (rdShowConfirmDialog("确认要提交信息吗？") != 1) {
			controlBtn(false);
			return false;
		} else {
			document.frm.action = "fe457_cfm.jsp";
			document.frm.submit()
		}
	}
	
</script>
</head>
<body>
<form name="frm" method="post" action="fe457_cfm.jsp">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="opNote" value="">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">营销方案活动类型配置</div>
	</div>
	<table>
		<tr>
			<td class="blue" width="30%">活动类型选择</td>
			<td class="blue" width="70%">
				<input type = 'radio' name='projectTypeSel' value="one" onclick="projectTypeSelChange()" checked >选择已有&nbsp;&nbsp;
				<input type = 'radio' name='projectTypeSel' value="two" onclick="projectTypeSelChange()">新增
			</td>
		</tr>
		<tbody id="projectTypeSelOne" style="display:none">
			<tr>
				<td class="blue" width="30%">活动类型</td>
	      <td class="blue" width="70%">
					<select id="projectType" name="projectType" style="width:400px" onChange="">
					<%
					sql = "select trim(project_type), trim(type_name) from sactivetype where op_code='e462' and region_code=:vRegionCode";
					sqlVar = " vRegionCode=" + regionCode;
					%>
					<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="retMsgProject" retcode="retCodeProject" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sql%>"/>
						<wtc:param value="<%=sqlVar%>"/>
					</wtc:service>
					<wtc:array id="projectResult" scope="end" />
					<%
					System.out.println("====wanghfa==== retCodeProject = " + retCodeProject);
					if ("000000".equals(retCodeProject)) {
						for (int i = 0; i < projectResult.length; i ++) {
							out.println("<option value='" + projectResult[i][0] + "'>" + projectResult[i][0]+"-->"+projectResult[i][1] + "</option>");
						}
					}
					%>
					</select>
			  </td>
			</tr>
		</tbody>
		<tbody id="projectTypeSelTwo" style="display:none">
			<tr>
				<td class="blue" width="30%">活动类型</td>
	      <td class="blue" width="70%">
	      	<input type=text name='projectTypeAdd' id='projectTypeAdd' class="InputGrey" readonly>
				</td>
			</tr>
			<tr>
				<td class="blue" width="30%">活动类型名称</td>
			  <td class="blue" width="70%">
					<input type=text name='projectNameAdd' id='projectNameAdd' maxlength="30" size="40">&nbsp;<font class="orange">*</font>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="title">
		<div id="title_zi">营销方案基本信息配置</div>
	</div>
	<table>
		<tr>
			<td width="20%" class="blue">省公司审批文件名</td>
			<td width="30%">
				<input name="fileName" type="text" id="fileName" maxlength="30" v_type="string" v_maxlength="60" v_must="1">
				<font class="orange">*</font>
			</td>
			<td width="20%" class="blue">省公司审批文件号</td>
			<td width="30%">
				<input name="fileNo" type="text" id="fileNo" maxlength="30" v_type="string" v_maxlength="60" v_must="1">
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">申请人姓名</td>
			<td>
				<input name="auditName"  type="text" id="auditName" maxlength="10" v_type="string" v_maxlength="20" v_must="1">
				<font class="orange">*</font>
			</td>
			<td class="blue">申请人电话</td>
			<td>
				<input name="auditPhone" type="text" id="auditPhone" maxlength="15" v_type="phone" v_must="1">
				<font class="orange">*</font>
			</td>
		</tr>
		<%
		String projectCode = "";
		sql = "select lpad(to_char(nvl(max(project_code),0)+1),4,'0') project_code from sactivecode";
		%>
		<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="retMsgPjtCd" retcode="retCodePjtCd" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
		</wtc:service>
		<wtc:array id="pjtCdResult" scope="end" />
		<%
		if ("000000".equals(retCodePjtCd) && pjtCdResult.length > 0) {
			projectCode = pjtCdResult[0][0];
		} else {
			%>
			<script language="javascript">
				rdShowMessageDialog("取活动代码失败，请联系管理员！", 1);
				history.go(-1);
			</script>
			<%
			return;
		}
		%>
		<tr>
			<td class="blue">方案代码</td>
			<td>
				<input name="projectCode" type="text" id="projectCode" v_must="1" value="<%=projectCode%>" class="InputGrey" readonly>
			</td>
			<td class="blue">方案名称</td>
			<td>
				<input name="projectName" type="text" id="projectName" v_must="1" maxlength="30" v_maxlength="30">
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">活动开始时间</td> 
			<td>
				<input name="beginTime" type="text" id="beginTime" maxlength="8" v_type="date" v_must="1">(YYYYMMDD)
				<font class="orange">*</font>
			</td>
			<td class="blue">活动结束时间</td>
			<td>
				<input name="stopTime" type="text" id="stopTime" maxlength="8" v_type="date" v_must="1">(YYYYMMDD)
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">净预存</td>
			<td colspan="3">
				<input name="leastPrepay" type="text" id="leastPrepay" v_type="money" maxlength="19" v_must="1">
				(只精确到0.01元，小数点后第三位将四舍五入)
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">可选资费代码</td> 
			<td>
				<input name="offerId" type="text" id="offerId" maxlength="9" v_type="0_9" v_must="1">
				<font class="orange">*</font>
			</td>
			<td class="blue">资费失效时间</td>
			<td>
				<input name="expDate" type="text" id="expDate" maxlength="8" v_type="date" v_must="1">(YYYYMMDD)
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">免填单备注</td> 
			<td colspan="3">
				<textarea name="activeNote" id="activeNote" COLS="60" ROWS="3" maxlength="500"></textarea>(限填500个字)
			</td>
		</tr>
	</table>
	
	<div class="title">
		<div id="title_zi">审批人</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td width="20%" class="blue">审批人</td>
			<%
			String[] workNoMem = new String[2];
			sql = "SELECT a.login_no, b.login_name from shighlogin a, dloginmsg b WHERE a.op_code='e457' and a.login_no = b.login_no";
			%>
			<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="retMsgApv" retcode="retCodeApv" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value="<%=sql%>"/>
			</wtc:service>
			<wtc:array id="apvResult" scope="end" />
			<%
			if ("000000".equals(retCodeApv) && apvResult.length == 2) {
				workNoMem[0] = apvResult[0][1] + " " + apvResult[0][0];
				workNoMem[1] = apvResult[1][1] + " " + apvResult[1][0];
			} else {
				%>
				<script language="javascript">
					rdShowMessageDialog("取审批人个数错误，请联系管理员！", 1);
				</script>
				<%
				return;
			}
			%>
			<td width="80%">
      	<input type=hidden name="workNoMem1" id="workNoMem1" value="<%=apvResult[0][0]%>">
      	<input type=hidden name="workNoMem2" id="workNoMem2" value="<%=apvResult[1][0]%>">
      	<input type=text value="<%=workNoMem[0]%>" class="InputGrey" readonly>&nbsp;&nbsp;&nbsp;&nbsp;
      	<input type=text value="<%=workNoMem[1]%>" class="InputGrey" readonly>
			</td>
		</tr>
	</table>

	<table cellspacing="0"> 
		<tr>
			<td colspan="6" align="center" id="footer">
				<input type="button" name="submitBtn" id="submitBtn" class="b_foot" value="确认" onClick="doCfm()" >
				<input type="reset" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" value="返回" >
				<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="关闭">
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
