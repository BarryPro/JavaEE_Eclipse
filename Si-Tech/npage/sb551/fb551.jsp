<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-6 ���������½����º���
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>���������½����º���</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	System.out.println("=========wanghfa========= fb551.jsp " + opCode + ", " + opName);
	
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regionCode"));
	String retCode1 = "";
	String retMsg1 = "";
%>
<script language="JavaScript">
	var isPermit = "1";
<%
	System.out.println("=========wanghfa=======sLinkOprChk== activePhone = " + activePhone);
	System.out.println("=========wanghfa=======sLinkOprChk== opCode = " + opCode);
	System.out.println("=========wanghfa=======sLinkOprChk== workNo = " + workNo);
	
	if(opCode.equals("b551")){
%>
	<wtc:utype name="sLinkOprChk" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=activePhone%>" type="STRING"/>
		<wtc:uparam value="b551" type="STRING"/>
		<wtc:uparam value="<%=workNo%>" type="STRING"/>
	</wtc:utype>
<%
		retCode1 = retVal.getValue(0);
		retMsg1 = retVal.getValue(1).replaceAll("\\n"," "); 
		if(!retCode1.equals("0")){
%>
			isPermit = "0";
<%
		}
	}
%>
	var opFlag;
	var buttonId;
	var cnntId;
	
	window.onload = function() {
		opchange();
	}
	
	function opchange() {
		var opCodeObj = document.getElementById("opCode");
		var opNameObj = document.getElementById("opName");
		var loverPhoneObj = document.getElementById("loverPhone");
		var loverPhoneValue = loverPhoneObj.value;
		loverPhoneObj.value = "00000000000";
		checkElement(loverPhoneObj);
		loverPhoneObj.value = loverPhoneValue;
		
		if (document.getElementsByName("opFlag")[0].checked) {
			opFlag = "1";
			opCodeObj.value = "b551";
			opNameObj.value = "��������ҵ������";
			
			if (isPermit == "0") {
				rdShowMessageDialog("<%=retCode1%>:<%=retMsg1%>", 0);
				document.getElementsByName("opFlag")[2].checked = true;
				opchange();
				return;
			}
			
			$("#queryItems").fadeOut("1000", function() {
				$("#loverInput").slideDown("500");
				$("#submitButton").slideDown("500");
			});	//slideUp("500");
		} else if (document.getElementsByName("opFlag")[1].checked) {
			opFlag = "2";
			opCodeObj.value = "b552";
			opNameObj.value = "��������ҵ��ȡ��";
			
			$("#queryItems").fadeOut("1000", function() {
				$("#loverInput").slideUp("500");
				$("#submitButton").slideDown("500");
			});	//slideUp("500");
		} else if (document.getElementsByName("opFlag")[2].checked) {
			opFlag = "3";
			opCodeObj.value = "b553";
			opNameObj.value = "��������ҵ���ѯ";
			
			$("#loverInput").slideUp("500");
			$("#submitButton").slideUp("500", function() {
				$("#queryItems").fadeIn("1000");	//slideDown("500");
			});
		}
	}
	
	function queryInfo(buttonIdT, cnntIdT) {
		buttonId = buttonIdT;
		cnntId = cnntIdT;
		buttonObj = document.getElementById(buttonId);
		connentObj = document.getElementById(cnntId);
		
		if (buttonObj.value == "�� ѯ") {
			buttonObj.value = "�� ��";
			$("#" + cnntId + "Tip").slideDown("100", getInfo);
		} else if (buttonObj.value == "�� ��") {
			buttonObj.value = "�� ѯ";
			$("#" + cnntId + "Tip").slideUp("300");
			$("#" + cnntId).slideUp("500");
		}
	}
	
	function getInfo() {
		buttonObj = document.getElementById(buttonId);
		connentObj = document.getElementById(cnntId);
		
		var queryInfoPacket = new AJAXPacket("fb551_ajaxGetInfo.jsp", "���ڲ�ѯ��Ϣ......");
		queryInfoPacket.data.add("phone", "<%=activePhone%>");
		queryInfoPacket.data.add("opCode", "<%=opCode%>");
		
		if (cnntId == "phoneInfo") {
			queryInfoPacket.data.add("qryType", "0");
			core.ajax.sendPacketHtml(queryInfoPacket, doQueryPhoneInfo, true);
		} else if (cnntId == "productInfo") {
			queryInfoPacket.data.add("qryType", "1");
			core.ajax.sendPacketHtml(queryInfoPacket, doQueryProductInfo, true);
		} else if (cnntId == "businessInfo") {
			queryInfoPacket.data.add("qryType", "2");
			core.ajax.sendPacketHtml(queryInfoPacket, doQueryBusinessInfo, true);
		} else if (cnntId == "lastTcBsnsInfo") {
			queryInfoPacket.data.add("qryType", "3");
			core.ajax.sendPacketHtml(queryInfoPacket, doQueryLastTcBsnsInfo, true);
		} else if (cnntId == "lastNoBsnsInfo") {
			queryInfoPacket.data.add("qryType", "4");
			core.ajax.sendPacketHtml(queryInfoPacket, doQueryLastNoBsnsInfo, true);
		}
	}
	
	function doQueryPhoneInfo(data) {
		//alert(data);
		document.getElementById("qryPhoneInfoButton").value = "�� ��";
		$("#phoneInfo").empty().append(data);
		
		$("#phoneInfoTip").slideUp("300", function() {
			$("#phoneInfo").slideDown("500");
		});
	}
	
	function doQueryProductInfo(data) {
		//alert(data);
		document.getElementById("qryProductInfoButton").value = "�� ��";
		$("#productInfo").empty().append(data);
		
		$("#productInfoTip").slideUp("300", function() {
			$("#productInfo").slideDown("500");
		});
	}
	
	function doQueryBusinessInfo(data) {
		//alert(data);
		document.getElementById("qryBusinessInfoButton").value = "�� ��";
		$("#businessInfo").empty().append(data);
		
		$("#businessInfoTip").slideUp("300", function() {
			$("#businessInfo").slideDown("500");
		});
	}
	
	function doQueryLastTcBsnsInfo(data) {
		//alert(data);
		document.getElementById("qryLastTcBsnsInfoButton").value = "�� ��";
		$("#lastTcBsnsInfo").empty().append(data);
		
		$("#lastTcBsnsInfoTip").slideUp("300", function() {
			$("#lastTcBsnsInfo").slideDown("500");
		});
	}
	
	function doQueryLastNoBsnsInfo(data) {
		//alert(data);
		document.getElementById("qryLastNoBsnsInfoButton").value = "�� ��";
		$("#lastNoBsnsInfo").empty().append(data);
		
		$("#lastNoBsnsInfoTip").slideUp("300", function() {
			$("#lastNoBsnsInfo").slideDown("500");
		});
	}
	
	function submitt() {
		var buttonSub = document.getElementById("submitB");
		buttonSub.disabled = "true";
		
		var opFlagObj = document.getElementsByName("opFlag")[0];
		var loverPhoneObj = document.getElementById("loverPhone");
		
		if (opFlagObj.checked) {
			if (loverPhoneObj.value.length == 0) {
				rdShowMessageDialog("������Ҫ��������º��룡", 1);
				buttonSub.disabled = "";
				return;
			} else if (loverPhoneObj.value.length < 11) {
				rdShowMessageDialog("��������º��볤�Ȳ���11λ��", 1);
				buttonSub.disabled = "";
				return;
			}
		} else {
			loverPhoneObj.value = "";
		}
		
		frm.action = "fb551_main.jsp";
		frm.submit();
	}
	
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">��������ҵ�����</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">
			��������
		</td>
		<td width="70%">
<%
			if ("b551".equals(opCode)) {
%>
			<input type="radio" name="opFlag" id="opFlag" value="1" onclick="opchange()" checked>����&nbsp;&nbsp;
			<input type="radio" name="opFlag" id="opFlag" value="2" onclick="opchange()">ȡ��&nbsp;&nbsp;
			<input type="radio" name="opFlag" id="opFlag" value="3" onclick="opchange()">��ѯ&nbsp;&nbsp;
<%
			} else if ("b552".equals(opCode)) {
%>
			<input type="radio" name="opFlag" id="opFlag" value="1" onclick="opchange()">����&nbsp;&nbsp;
			<input type="radio" name="opFlag" id="opFlag" value="2" onclick="opchange()" checked>ȡ��&nbsp;&nbsp;
			<input type="radio" name="opFlag" id="opFlag" value="3" onclick="opchange()">��ѯ&nbsp;&nbsp;
<%
			} else if ("b553".equals(opCode)) {
%>
			<input type="radio" name="opFlag" id="opFlag" value="1" onclick="opchange()">����&nbsp;&nbsp;
			<input type="radio" name="opFlag" id="opFlag" value="2" onclick="opchange()">ȡ��&nbsp;&nbsp;
			<input type="radio" name="opFlag" id="opFlag" value="3" onclick="opchange()" checked>��ѯ&nbsp;&nbsp;
<%
			}
%>
		</td>
	</tr>
	<tr>
		<td class="blue" width="30%">
			�û�����
		</td>
		<td width="70%">
			<input type="text" maxlength="11" name="activePhone" id="activePhone" value="<%=activePhone%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
</table>
<div class="itemContent" name="loverInput" id="loverInput">
	<table>
		<tr>
			<td class="blue" width="30%">
				���º���
			</td>
			<td width="70%">
				<input type="text" maxlength="11" v_maxlength="11" name="loverPhone" id="loverPhone" value="" v_must="1" onKeyPress="return isKeyNumberdot(0)" onblur="checkElement(this);">
			</td>
		</tr>
	</table>
</div>
<div class="itemContent" name="submitButton" id="submitButton">
	<table cellspacing="0">
		<tr>
		    <td colspan="3" id="footer">
		      <input class="b_foot" type=button name="submitB" value="ȷ��" onClick="submitt();">
		      <input class="b_foot" type=button name="closeTab" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
		    </td>
		</tr>
	</table>
</div>


<div class="itemContent" name="queryItems" id="queryItems">
	<div class="title">
		<div name="title_zi" id="title_zi">�����������������Ϣ</div>
	</div>
	<table>
		<tr>
			<th width="100%">
				<input type="button" name="qryPhoneInfoButton" id="qryPhoneInfoButton" class="b_text" value="�� ѯ" onclick="queryInfo('qryPhoneInfoButton', 'phoneInfo');">
				&nbsp;&nbsp;&nbsp;&nbsp;���º�����Ϣ&nbsp;&nbsp;&nbsp;&nbsp;
			</th>
		</tr>
	</table>
	<div class="itemContent" name="phoneInfo" id="phoneInfo">
	</div>
	<div class="itemContent" name="phoneInfoTip" id="phoneInfoTip">
		<table>
			<tr>
				<td width="100%">
					���ڲ�ѯ���º�����Ϣ�����Ե�......
				</td>
			</tr>
		</table>
	</div>
	
	
	<table>
		<tr>
			<th width="100%">
				<input type="button" name="qryProductInfoButton" id="qryProductInfoButton" class="b_text" value="�� ѯ" onclick="queryInfo('qryProductInfoButton', 'productInfo');">
				&nbsp;&nbsp;&nbsp;&nbsp;����Ʒ������Ϣ&nbsp;&nbsp;&nbsp;&nbsp;
			</th>
		</tr>
	</table>
	<div class="itemContent" name="productInfo" id="productInfo">
	</div>
	<div class="itemContent" name="productInfoTip" id="productInfoTip">
		<table>
			<tr>
				<td width="100%">
					���ڲ�ѯ����Ʒ������Ϣ�����Ե�......
				</td>
			</tr>
		</table>
	</div>
	
	
	<table>
		<tr>
			<th width="100%">
				<input type="button" name="qryBusinessInfoButton" id="qryBusinessInfoButton" class="b_text" value="�� ѯ" onclick="queryInfo('qryBusinessInfoButton', 'businessInfo');">
				&nbsp;&nbsp;&nbsp;&nbsp;ҵ�������Ϣ&nbsp;&nbsp;&nbsp;&nbsp;
			</th>
		</tr>
	</table>
	<div class="itemContent" name="businessInfo" id="businessInfo">
	</div>
	<div class="itemContent" name="businessInfoTip" id="businessInfoTip">
		<table>
			<tr>
				<td width="100%">
					���ڲ�ѯҵ�������Ϣ�����Ե�......
				</td>
			</tr>
		</table>
	</div>
	
	
	
	<div class="title">
		<div name="title_zi" id="title_zi">��������°����¼��Ϣ</div>
	</div>
	<table>
		<tr>
			<th width="100%">
				<input type="button" name="qryLastTcBsnsInfoButton" id="qryLastTcBsnsInfoButton" class="b_text" value="�� ѯ" onclick="queryInfo('qryLastTcBsnsInfoButton', 'lastTcBsnsInfo');">
				&nbsp;&nbsp;&nbsp;&nbsp;�ײͰ����¼&nbsp;&nbsp;&nbsp;&nbsp;
			</th>
		</tr>
	</table>
	<div class="itemContent" name="lastTcBsnsInfo" id="lastTcBsnsInfo">
	</div>
	<div class="itemContent" name="lastTcBsnsInfoTip" id="lastTcBsnsInfoTip">
		<table>
			<tr>
				<td width="100%">
					���ڲ�ѯ�ײͰ�����Ϣ�����Ե�......
				</td>
			</tr>
		</table>
	</div>
	
	
	<table>
		<tr>
			<th width="100%">
				<input type="button" name="qryLastNoBsnsInfoButton" id="qryLastNoBsnsInfoButton" class="b_text" value="�� ѯ" onclick="queryInfo('qryLastNoBsnsInfoButton', 'lastNoBsnsInfo');">
				&nbsp;&nbsp;&nbsp;&nbsp;���º�������¼&nbsp;&nbsp;&nbsp;&nbsp;
			</th>
		</tr>
	</table>
	<div class="itemContent" name="lastNoBsnsInfo" id="lastNoBsnsInfo">
	</div>
	<div class="itemContent" name="lastNoBsnsInfoTip" id="lastNoBsnsInfoTip">
		<table>
			<tr>
				<td width="100%">
					���ڲ�ѯ���º�������¼�����Ե�......
				</td>
			</tr>
		</table>
	</div>
</div>


<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
