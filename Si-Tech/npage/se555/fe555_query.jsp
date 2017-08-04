<%
  /*
   * 功能: WLAN网络覆盖查询
   * 版本: 1.0
   * 日期: 20110715
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WLAN网络覆盖查询</title>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
	String customerNumber = request.getParameter("customerNumber") == null ? "" : request.getParameter("customerNumber");
	String toOperate = request.getParameter("toOperate") == null ? "" : request.getParameter("toOperate");
	System.out.println("====wanghfa====fe555_query.jsp==== EC编号 = " + customerNumber);
	System.out.println("====wanghfa====fe555_query.jsp==== 操作类型 = " + toOperate);
%>
	<wtc:service name="sStaPOListQry" routerKey="region" routerValue="<%=regionCode%>"
			retcode="retCode1" retmsg="retMsg1" outnum="10">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if (!"000000".equals(retCode1) || result1.length == 0) {
	%>
		rdShowMessageDialog("查询地市组织机构错误！",0);
		removeCurrentTab();
	<%
	}
%>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
	onload=function() {
		changeThis(document.getElementById("region"));
	}
	
	function changeThis(obj){
   	var getMsgPacket = new AJAXPacket("fe054_ajaxGetOption.jsp","正在获取信息，请稍候......");
    getMsgPacket.data.add("opSelect", obj.id);
    getMsgPacket.data.add("group_name", document.getElementById("region").value);
		if (obj.id == "hotArea") {
	    getMsgPacket.data.add("hotarea", document.getElementById("hotArea").value);
		} else if (obj.id == "hotName") {
	    getMsgPacket.data.add("hotarea", document.getElementById("hotArea").value);
	    getMsgPacket.data.add("hotname", document.getElementById("hotName").value);
		} else if (obj.id == "hotAddr") {
	    getMsgPacket.data.add("hotarea", document.getElementById("hotArea").value);
	    getMsgPacket.data.add("hotname", document.getElementById("hotName").value);
	    getMsgPacket.data.add("hot_addr", document.getElementById("hotAddr").value);
		}
    core.ajax.sendPacket(getMsgPacket, doGetMsg);
    getMsgPacket = null;
	}
	
	function doGetMsg(packet) {
		var resultArray = packet.data.findValueByName("resultArray");
		var opSelect = packet.data.findValueByName("opSelect");
		var ctlSelect = "";
		
		if (opSelect == "region") {
			ctlSelect = "hotArea";
		} else if (opSelect == "hotArea") {
			ctlSelect = "hotName";
		} else if (opSelect == "hotName") {
			ctlSelect = "hotAddr";
		} else if (opSelect == "hotAddr") {
			ctlSelect = "hotArea1";
		}
		document.getElementById(ctlSelect).options.length = 0;
		var optionI = document.createElement("option");
		optionI.value = "";
		optionI.text = "--请选择--";
		document.getElementById(ctlSelect).add(optionI);
		
		for (var i = 1; i <= resultArray.length; i ++) {
			var optionI = document.createElement("option");
			optionI.value = resultArray[i-1];
			optionI.text = resultArray[i-1];
			
			document.getElementById(ctlSelect).add(optionI);
		}
		
		if (opSelect == "region") {
			changeThis(document.getElementById("hotArea"));
		} else if (opSelect == "hotArea") {
			changeThis(document.getElementById("hotName"));
		} else if (opSelect == "hotName") {
			changeThis(document.getElementById("hotAddr"));
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		var startDateObj = document.getElementById("startDate");
		var endDateObj = document.getElementById("endDate");
		controlBtn(true);
		
		if (!checkElement(startDateObj) || !checkElement(endDateObj)) {
			controlBtn(false);
			return false;
		} else if (!forDate(startDateObj) || !forDate(endDateObj)) {
			//rdShowMessageDialog("请按YYYYMMDD日期格式输入正确的日期！", 1);
			controlBtn(false);
			return false;
		} else if ((parseInt(endDateObj.value) - parseInt(startDateObj.value)) < 0) {
			rdShowMessageDialog("查询结束日期必须大于开始日期！", 1);
			controlBtn(false);
			return false;
		}
		document.getElementById("startTime").value = startDateObj.value + " 00:00:00";
		document.getElementById("endTime").value = endDateObj.value + " 23:59:59";
		
		document.frm.action = "fe054_main.jsp";
		document.frm.submit();
	}
	
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">输入查询条件</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">开始时间 (格式YYYYMMDD)</td>
		<td width="30%">
			<input type="text" name="startDate" id="startDate" value="<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>01" maxlength="8" v_must="1" v_type="0_9" v_format="yyyyMMdd"/>
			<input type="hidden" name="startTime" id="startTime" value=""/>
		</td>
		<td class="blue" width="20%">结束时间 (格式YYYYMMDD)</td>
		<td width="30%">
			<input type="text" name="endDate" id="endDate" value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>" maxlength="8" v_must="1" v_type="0_9" v_format="yyyyMMdd"/>
			<input type="hidden" name="endTime" id="endTime" value=""/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">地市名称</td>
		<td width="30%">
			<select name="region" id="region" onchange="changeThis(this)">
			<%
				if ("000000".equals(retCode1) || result1.length > 0) {
					for (int i = 0; i < result1.length; i ++) {
					%>
						<option value="<%=result1[i][1]%>"><%=result1[i][1]%></option>
					<%
					}
				}
			%>
			</select>
		</td>
		<td class="blue" width="20%">热点覆盖区域</td>
		<td width="30%">
			<select name="hotArea" id="hotArea" onchange="changeThis(this)">
				<option value="">--请选择--</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">热点名称</td>
		<td>
			<select name="hotName" id="hotName" onchange="changeThis(this)">
				<option value="">--请选择--</option>
			</select>
		</td>
		<td class="blue" width="20%">热点地址</td>
		<td>
			<select name="hotAddr" id="hotAddr" onchange="changeThis(this)">
				<option value="">--请选择--</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">覆盖区域</td>
		<td colspan="3">
			<select name="hotArea1" id="hotArea1" onchange="">
				<option value="">--请选择--</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="查询" onClick="doCfm(this)">    
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
