
<%
	/********************
	 version v2.0
	������: si-tech
	*
	*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
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
	String opName = "У԰�źż���ѽ������";
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
			rdShowMessageDialog("��ѡ��opCode���ͣ�");
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
			rdShowMessageDialog("��ѡ�����õ��У�");
			return false;
		} else if (myffje == "") {
			rdShowMessageDialog("������ÿ�·��ѽ�");
			document.all.myffje.focus();
			return false;
		} else if (s_paytype.value == "") {
			rdShowMessageDialog("�����뷵�����ͣ�");
			document.all.ffzklx.focus();
			return false;
		} else if (ffys == "") {
			rdShowMessageDialog("�����뷵��������");
			document.all.ffys.focus();
			return false;
		} else if (xfys == "") {
			rdShowMessageDialog("����������������");
			document.all.xfys.focus();
			return false;
		}

		else if (xfysNo < ffysNo) {
			rdShowMessageDialog("������������С�ڷ���������");
			document.all.xfys.focus();
			return false;
		}

		else if (sfljcy.value == 0) {
			rdShowMessageDialog("�������Ƿ��ۻ������£�");
			document.all.sfljcy.focus();
			return false;
		} else if (xfysNo > ffysNo && sfljcy.value != "1") {
			rdShowMessageDialog("�����������ڷ�������ʱ��ֻ��ѡ���ۻ������£�");
			document.all.sfljcy.focus();
			return false;
		} else {
			var checkPwd_Packet = new AJAXPacket("checkRegion.jsp",
					"���ڽ�������У�飬���Ժ�......");
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
			rdShowMessageDialog("�������ڵ��в�ѯʧ�ܣ�");
			return false;
		} else {
			//�������ڵ���
			var login_region = packet.data.findValueByName("s_group_Id");
			//ҳ��ѡ���
			var region_select = document.getElementById("pzds").value;
			//alert("login_region is "+login_region+" and region_select is "+region_select);
			if (login_region == region_select) {
				document.frm.action = "g806_2.jsp";
				document.frm.submit();
				//alert("ok");
			} else {
				rdShowMessageDialog("���Ź�������ѡ����в�һ�£�");
				return false;
			}
		}
	}

	function doclear() {
		frm.reset();
	}

	-->
</script>

<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
	<form action="" method="post" name="frm">

		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi">��������������</div>
		</div>
		<table cellspacing="0">


			<tr>
				<td class="blue">OpCode����</td>
				<td colspan=5><select id="opCodeType" name="opCodeType">
						<option value="0" selected>--��ѡ��</option>
						<option value="g785">g785</option>
						<option value="g784">g784</option>
				</select></td>
			</tr>

			<tr>
				<td class="blue">ÿ�·��ѽ��</td>
				<td><input type="text" name="myffje" size="20" maxlength="20"
					onKeyPress="return isKeyNumberdot(1)"></td>

				<td class="blue">����ר������</td>
				<td><select id="ffzklx" name="ffzklx">
						<option value="" selected>--��ѡ��</option>
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
				<td class="blue">��������</td>
				<td><input class="button" type="text" name="ffys" size="8"
					maxlength="8" onKeyPress="return isKeyNumberdot(0)"></td>
				<td class="blue">��������</td>
				<td><input class="button" type="text" name="xfys" size="8"
					maxlength="8" onKeyPress="return isKeyNumberdot(0)"></td>
			</tr>
			<tr>
				<td class="blue">�Ƿ��ۻ�������</td>
				<td colspan=5><select id="sfljcy" name="sfljcy">
						<option value="0" selected>--��ѡ��</option>
						<option value="1">--��</option>
						<option value="2">--��</option></td>
			</tr>

			<tr>
				<td class="blue" width="15%">���ù���</td>
				<td><input class="button" type="text" name="s_login_no"
					size="20" maxlength="12" value="<%=workno%>" readonly></td>
				<td class="blue">���õ���</td>
				<td colspan=3><select id="pzds" name="pzdsname">
						<option value="0" selected>--��ѡ��</option>
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
				<td class="blue" width="15%">��ʼʱ��</td>
				<td><input type="time"></td>
				<td class="blue">����ʱ��</td>
				<td colspan=3><input type="time"></td>
			</tr>
		</table>
		<table cellSpacing="0">
			<tr>
				<td id="footer"><input type="button" name="query"
					class="b_foot" value="ȷ��" onclick="docheck()"> &nbsp; <input
					type="button" name="return1" class="b_foot" value="����"
					onclick="doclear()"> &nbsp; <input type="button"
					name="return2" class="b_foot" value="�ر�"
					onClick="removeCurrentTab()"></td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer_simple.jsp"%>
		<%@ include file="../../npage/common/pwd_comm.jsp"%>
	</form>
</BODY>
</HTML>