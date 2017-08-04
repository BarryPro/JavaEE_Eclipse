
<%
	/********************
	 version v2.0
	开发商: si-tech
	*
	*update:zhanghonga@2008-08-15 页面改造,修改样式
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%
	String opCode = "g806";
	String opName = "校园放号激活返费金额配置";
	String orgCode = (String) session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0, 2);
	String workno = (String) session.getAttribute("workNo");
	String workname = (String) session.getAttribute("workName");
	String nopass = (String) session.getAttribute("password");
	String[] inParam = new String[2];
	String[] inParam1 = new String[2];
	inParam[0] = "select region_code,region_name from sregioncode order by region_code asc ";
	inParam1[0] = "select pay_type,op_note from sbackpay_mk order by pay_type asc ";
%>
<wtc:service name="TlsPubSelBoss" outnum="2">
	<wtc:param value="<%=inParam[0]%>" />
</wtc:service>
<wtc:array id="region_arr" scope="end" />

<wtc:service name="TlsPubSelBoss" outnum="2">
	<wtc:param value="<%=inParam1[0]%>" />
</wtc:service>
<wtc:array id="paytype_arr" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
 function inits()
 {
	 //alert("orgCode is "+"<%=orgCode%>"+" and regionCode is "+"<%=regionCode%>
	");
		document.getElementById("opCodeType").value = "0";
	}
	function docheck() {
		var opCodeType = document.getElementById("opCodeType");
		// 	alert(opCodeType.value);
		if (opCodeType.value == 0) {
			rdShowMessageDialog("请选择opCode类型！");
			return false;
		}
		var pzds = document.getElementById("pzds");
		var myffje = document.all.myffje.value;
		var ffys = document.all.ffys.value;
		var xfys = document.all.xfys.value;
		var sfljcy = document.getElementById("sfljcy");
		var s_paytype = document.getElementById("ffzklx");
		var s_login_no = document.all.s_login_no.value;
		var xfysNo = xfys * 1;
		var ffysNo = ffys * 1;
		//alert(sfljcy);
		if (pzds.value == 0) {
			rdShowMessageDialog("请选择配置地市！");
			return false;
		} else if (myffje == "") {
			rdShowMessageDialog("请输入每月返费金额！");
			document.all.myffje.focus();
			return false;
		} else if (s_paytype.value == "") {
			rdShowMessageDialog("请输入返费类型！");
			document.all.ffzklx.focus();
			return false;
		} else if (ffys == "") {
			rdShowMessageDialog("请输入返费月数！");
			document.all.ffys.focus();
			return false;
		} else if (xfys == "") {
			rdShowMessageDialog("请输入消费月数！");
			document.all.xfys.focus();
			return false;
		}

		else if (xfysNo < ffysNo) {
			rdShowMessageDialog("消费月数不能小于返费月数！");
			document.all.xfys.focus();
			return false;
		}

		else if (sfljcy.value == 0) {
			rdShowMessageDialog("请输入是否累积到次月！");
			document.all.sfljcy.focus();
			return false;
		} else if (xfysNo > ffysNo && sfljcy.value != "1") {
			rdShowMessageDialog("消费月数大于返费月数时，只能选择累积到次月！");
			document.all.sfljcy.focus();
			return false;
		} else {
			var checkPwd_Packet = new AJAXPacket("checkRegion.jsp",
					"正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("login_no", s_login_no);

			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet = null;
			//alert("ok");
		}

	}
	function doProcess(packet) {
		var retResult = packet.data.findValueByName("retResult");
		//alert("tt "+retResult);

		if (retResult == "N") {
			rdShowMessageDialog("工号所在地市查询失败！");
			return false;
		} else {
			//工号所在地市
			var login_region = packet.data.findValueByName("s_group_Id");
			//页面选择的
			var region_select = document.getElementById("pzds").value;
			//alert("login_region is "+login_region+" and region_select is "+region_select);
			if (login_region == region_select) {
				document.frm.action = "g806_2.jsp";
				document.frm.submit();
				//alert("ok");
			} else {
				rdShowMessageDialog("工号归属与所选择地市不一致！");
				return false;
			}
		}
	}

	function doclear() {
		frm.reset();
	}

	-->
</script>

<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
	<form action="" method="post" name="frm">

		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi">请输入配置条件</div>
		</div>
		<table cellspacing="0">


			<tr>
				<td class="blue">OpCode类型</td>
				<td colspan=5><select id="opCodeType" name="opCodeType">
						<option value="0" selected>--请选择</option>
						<option value="g785">g785</option>
						<option value="g784">g784</option>
				</select></td>
			</tr>

			<tr>
				<td class="blue">每月返费金额</td>
				<td><input type="text" name="myffje" size="20" maxlength="20"
					onKeyPress="return isKeyNumberdot(1)"></td>

				<td class="blue">返费专款类型</td>
				<td><select id="ffzklx" name="ffzklx">
						<option value="" selected>--请选择</option>
						<%
							for (int i = 0; i < paytype_arr.length; i++) {
						%>
						<option value="<%=paytype_arr[i][0]%>">

							<%=paytype_arr[i][0]%>--><%=paytype_arr[i][1]%></option>
						<%
							}
						%>
				</select></td>

			</tr>
			<tr>
				<td class="blue">返费月数</td>
				<td><input class="button" type="text" name="ffys" size="8"
					maxlength="8" onKeyPress="return isKeyNumberdot(0)"></td>
				<td class="blue">消费月数</td>
				<td><input class="button" type="text" name="xfys" size="8"
					maxlength="8" onKeyPress="return isKeyNumberdot(0)"></td>
			</tr>
			<tr>
				<td class="blue">是否累积到次月</td>
				<td colspan=5><select id="sfljcy" name="sfljcy">
						<option value="0" selected>--请选择</option>
						<option value="1">--是</option>
						<option value="2">--否</option></td>
			</tr>

			<tr>
				<td class="blue" width="15%">配置工号</td>
				<td><input class="button" type="text" name="s_login_no"
					size="20" maxlength="12" value="<%=workno%>" readonly></td>
				<td class="blue">配置地市</td>
				<td colspan=3><select id="pzds" name="pzdsname">
						<option value="0" selected>--请选择</option>
						<%
							for (int i = 0; i < region_arr.length; i++) {
						%>
						<option value="<%=region_arr[i][0]%>">

							<%=region_arr[i][0]%>--><%=region_arr[i][1]%></option>
						<%
							}
						%>
				</select></td>

			</tr>
			<tr>
				<td class="blue" width="15%">开始时间</td>
				<td><input type="time"></td>
				<td class="blue">结束时间</td>
				<td colspan=3><input type="time"></td>
			</tr>
		</table>
		<table cellSpacing="0">
			<tr>
				<td id="footer"><input type="button" name="query"
					class="b_foot" value="确认" onclick="docheck()"> &nbsp; <input
					type="button" name="return1" class="b_foot" value="重置"
					onclick="doclear()"> &nbsp; <input type="button"
					name="return2" class="b_foot" value="关闭"
					onClick="removeCurrentTab()"></td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer_simple.jsp"%>
		<%@ include file="../../npage/common/pwd_comm.jsp"%>
	</form>
</BODY>
</HTML>