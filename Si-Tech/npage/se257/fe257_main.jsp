<%
  /*
   * ����: ��ֵ��Ӫ����ת��
   * �汾: 1.0
   * ����: 20110908
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");
String result[] = new String[12];

System.out.println("====fe257_main.jsp====wanghfa==== opCode = " + opCode);
System.out.println("====fe257_main.jsp====wanghfa==== opName = " + opName);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====0==== iLoginAccept = " + printAccept);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====1==== iChnSource = 01");
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====6==== iUserPwd = ");
%>
<wtc:service name="se257Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
</wtc:service>
<wtc:array id="result1" start="0" length="9" scope="end"/>
<%
System.out.println("====wanghfa=====fe257_main.jsp====se257Qry : " + retCode1 + "," + retMsg1);

if (!retCode1.equals("000000")) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("se257Qry����<%=retCode1%>��<%=retMsg1%>",0);
		history.go(-1);
	</script>
	<%
} else {
	if (result1[0].length > 0) {
		for (int j = 0; j < result1[0].length; j ++) {
			System.out.println("====wanghfa=====fe257_main.jsp====se257Qry==== result1[0]["+j+"] = " + result1[0][j]);
			result[j] = result1[0][j];
		}
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	window.onload = function() {
		moneyChange();
	}
	
	function moneyChange() {
		var prePayFeeObj = document.getElementById("prePayFee");
		var presentFeeObj = document.getElementById("presentFee");
		var myFeeObj = document.getElementById("myFee");
		
		var toPhone1Obj = document.getElementById("toPhone1");
		var toPhone2Obj = document.getElementById("toPhone2");
		var toPhone3Obj = document.getElementById("toPhone3");
		var toFee1Obj = document.getElementById("toFee1");
		var toFee2Obj = document.getElementById("toFee2");
		var toFee3Obj = document.getElementById("toFee3");
		
		if (toFee1Obj.value.trim().length == 0 || toPhone1Obj.value.trim().length == 0) {
			toFee1Obj.value = "0";
		}
		if (toFee2Obj.value.trim().length == 0 || toPhone2Obj.value.trim().length == 0) {
			toFee2Obj.value = "0";
		}
		if (toFee3Obj.value.trim().length == 0 || toPhone3Obj.value.trim().length == 0) {
			toFee3Obj.value = "0";
		}
		
		if (!checkElement(document.getElementById("toFee1"))) {
			document.getElementById("toFee1").focus();
			return false;
		} else if (!checkElement(document.getElementById("toFee2"))) {
			document.getElementById("toFee2").focus();
			return false;
		} else if (!checkElement(document.getElementById("toFee3"))) {
			document.getElementById("toFee3").focus();
			return false;
		}
		
		presentFeeObj.value = parseInt(toFee1Obj.value) + parseInt(toFee2Obj.value) + parseInt(toFee3Obj.value);
		myFeeObj.value = parseInt(prePayFeeObj.value) - parseInt(presentFeeObj.value);
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		
		var prePayFeeObj = document.getElementById("prePayFee");
		var presentFeeObj = document.getElementById("presentFee");
		var myFeeObj = document.getElementById("myFee");
		
		var toPhone1Obj = document.getElementById("toPhone1");
		var toPhone2Obj = document.getElementById("toPhone2");
		var toPhone3Obj = document.getElementById("toPhone3");
		var toFee1Obj = document.getElementById("toFee1");
		var toFee2Obj = document.getElementById("toFee2");
		var toFee3Obj = document.getElementById("toFee3");
		
		if (toPhone1Obj.value.trim().length == 0) {
			toFee1Obj.value = "0";
		}
		if (toPhone2Obj.value.trim().length == 0) {
			toFee2Obj.value = "0";
		}
		if (toPhone3Obj.value.trim().length == 0) {
			toFee3Obj.value = "0";
		}

		if (toPhone1Obj.value.trim().length == 0 && toPhone2Obj.value.trim().length == 0 && toPhone3Obj.value.trim().length == 0) {
			rdShowMessageDialog("������һ��ת�����룡", 1);
			controlBtn(false);
			return false;
		}
		if ((toPhone1Obj.value.trim().length != 11 && toPhone1Obj.value.trim().length != 0) ||
			 (toPhone2Obj.value.trim().length != 11 && toPhone2Obj.value.trim().length != 0) ||
			 (toPhone3Obj.value.trim().length != 11 && toPhone3Obj.value.trim().length != 0)) {
			rdShowMessageDialog("ת���������Ϊ11λ���֣�", 1);
			controlBtn(false);
			return false;
		}
		if ("<%=activePhone%>" == toPhone1Obj.value || "<%=activePhone%>" == toPhone2Obj.value ||
			 "<%=activePhone%>" == toPhone3Obj.value ||
			 (toPhone1Obj.value.length != 0 & toPhone2Obj.value.length != 0 && toPhone1Obj.value == toPhone2Obj.value) ||
			 (toPhone1Obj.value.length != 0 & toPhone3Obj.value.length != 0 && toPhone1Obj.value == toPhone3Obj.value) ||
			 (toPhone2Obj.value.length != 0 & toPhone3Obj.value.length != 0 && toPhone2Obj.value == toPhone3Obj.value)) {
			rdShowMessageDialog("������룬�����ͺ��벻�����ظ���", 1);
			controlBtn(false);
			return false;
		}
		
		if (parseInt(prePayFeeObj.value) <= 0) {
			rdShowMessageDialog("��Ӫ���������ͽ�����������ҵ��", 1);
			controlBtn(false);
			return false;
		} else if (parseInt(presentFeeObj.value) <= 0) {
			rdShowMessageDialog("���ͽ��������0��", 1);
			controlBtn(false);
			return false;
		} else if (parseInt(myFeeObj.value) < 0) {
			rdShowMessageDialog("ʣ���������ڻ����0��", 1);
			controlBtn(false);
			return false;
		} else if (parseInt(myFeeObj.value) < 0) {
			rdShowMessageDialog("ʣ���������ڻ����0��", 1);
			controlBtn(false);
			return false;
		}
		
		if (toPhone1Obj.value.trim().length > 0) {
			if (!checkElement(toPhone1Obj)) {
				controlBtn(false);
				return false;
			} else if (parseInt(toFee1Obj.value) <= 0 || (parseInt(toFee1Obj.value) % 100) != 0) {
				rdShowMessageDialog("ת��" + toPhone1Obj.value + "�Ľ������Ǵ���0�����ٽ�", 1);
				toFee1Obj.focus();
				controlBtn(false);
				return false;
			}
		} else {
			toFee1Obj.value = "";
		}
		if (toPhone2Obj.value.trim().length > 0) {
			if (!checkElement(toPhone2Obj)) {
				controlBtn(false);
				return false;
			} else if (parseInt(toFee2Obj.value) <= 0 || (parseInt(toFee2Obj.value) % 100) != 0) {
				rdShowMessageDialog("����" + toPhone2Obj.value + "�Ľ������Ǵ���0�����ٽ�", 1);
				toFee2Obj.focus();
				controlBtn(false);
				return false;
			}
		} else {
			toFee2Obj.value = "";
		}
		if (toPhone3Obj.value.trim().length > 0) {
			if (!checkElement(toPhone3Obj)) {
				controlBtn(false);
				return false;
			} else if (parseInt(toFee3Obj.value) <= 0 || (parseInt(toFee3Obj.value) % 100) != 0) {
				rdShowMessageDialog("����" + toPhone3Obj.value + "�Ľ������Ǵ���0�����ٽ�", 1);
				toFee3Obj.focus();
				controlBtn(false);
				return false;
			}
		} else {
			toFee3Obj.value = "";
		}
		
		
		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	//��ӡ���
		cfm();
	}
	
	function cfm() {
		
		if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
			document.frm.submit();
		} else {
			controlBtn(false);
			return false;
		}
	}

	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //��ʾ��ӡ�Ի���
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept="<%=printAccept%>";                          // ��ˮ��
		var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode="<%=opCode%>";                                  //��������
		var phoneNo="<%=activePhone%>";         					        //�ͻ��绰

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType) {
		var toPhone1Obj = document.getElementById("toPhone1");
		var toPhone2Obj = document.getElementById("toPhone2");
		var toPhone3Obj = document.getElementById("toPhone3");
		var toFee1Obj = document.getElementById("toFee1");
		var toFee2Obj = document.getElementById("toFee2");
		var toFee3Obj = document.getElementById("toFee3");
		
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="�ֻ����룺" + document.getElementById("activePhone").value + "|";
		cust_info+="�ͻ�������" + document.getElementById("custName").value + "|";
		//cust_info+="֤�����룺"+ "|";
		//cust_info+="�ͻ���ַ��"+ "|";
		opr_info += "ҵ�����ƣ�<%=opName%>          ҵ����ˮ��<%=printAccept%>" + "|";
		opr_info += "�ͻ�����Ӫ������ƣ�" + document.getElementById("projectName").value + "|";
		opr_info += "���ͻ��ѽ�<%=result[2]%>" + "|";
		var presentNo = 0;
		if (toPhone1Obj.value.trim().length != 0) {
			presentNo ++;
		}
		if (toPhone2Obj.value.trim().length != 0) {
			presentNo ++;
		}
		if (toPhone3Obj.value.trim().length != 0) {
			presentNo ++;
		}
		
		opr_info += "ת��������" + presentNo + "          ת����" + document.getElementById("presentFee").value + "|";
		opr_info += "ת�����뼰�����ϸ��" + "|";
		if (toPhone1Obj.value.trim().length != 0) {
			opr_info += toPhone1Obj.value + "   " + toFee1Obj.value + "Ԫ|";
		}
		if (toPhone2Obj.value.trim().length != 0) {
			opr_info += toPhone2Obj.value + "   " + toFee2Obj.value + "Ԫ|";
		}
		if (toPhone3Obj.value.trim().length != 0) {
			opr_info += toPhone3Obj.value + "   " + toFee3Obj.value + "Ԫ|";
		}
		
		document.getElementById("opNote").value = "����<%=workNo%>Ϊ<%=activePhone%>�û�����<%=opName%>��";
		
		note_info1 += ""+"|";
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST" action="fe257_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="projectCode" id="projectCode" value="<%=result[3]%>">
<input type="hidden" name="sGradeCode" id="sGradeCode" value="<%=result[4]%>">
<input type="hidden" name="partInAccept" id="partInAccept" value="<%=result[5]%>">
<input type="hidden" name="custAddr" id="custAddr" value="<%=result[7]%>">
<input type="hidden" name="idIccId" id="idIccId" value="<%=result[8]%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			�绰����
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" value="<%=result[6]%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			Ӫ���������
		</td>
		<td colspan="3">
			<%=result[0]%>
			<input name="projectName" id="projectName" type="hidden" value="<%=result[0]%>">
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			����ʱ��
		</td>
		<td width="30%">
			<%=result[1].substring(0,4)%>��<%=result[1].substring(4,6)%>��<%=result[1].substring(6,8)%>��
			<input type="hidden" name="partInTime" id="partInTime" value="<%=result[1]%>" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			���ͻ��ѽ��
		</td>
		<td width="30%">
			<input type="text" name="prePayFee" id="prePayFee" size="10" value="<%=result[2]%>" class="InputGrey" readonly>Ԫ
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			ת���ܽ��
		</td>
		<td width="30%">
			<input type="text" name="presentFee" id="presentFee" size="10" value="" class="InputGrey" readonly>Ԫ
		</td>
		<td class="blue" width="20%">
			ʣ����
		</td>
		<td width="30%">
			<input type="text" name="myFee" id="myFee" size="10" value="" class="InputGrey" readonly>Ԫ
		</td>
	</tr>
</table>
<br/>
<div class="title">
	<div id="title_zi">¼��ת����Ϣ</div>
</div>
<table>
	<tr>
		<th width="10%">���</th>
		<th width="40%">ת���ֻ�����</th>
		<th width="50%">ת�����</th>
	</tr>
	<%
	for (int i = 0; i < 3; i ++) {
		%>
		<tr>
		  <td><%=i+1%></td>
		  <td>
		  	<input type="text" name="toPhone<%=i+1%>" id="toPhone<%=i+1%>" size="12" value="" maxlength="11" v_type="0_9" v_maxlength="11">
		  </td>
		  <td>
		  	<input type="text" name="toFee<%=i+1%>" id="toFee<%=i+1%>" size="10" value="0" v_type="0_9" onchange="moneyChange();">Ԫ
		  </td>
		</tr>
		<%
	}
	%>
</table>
<table>
	<tr>
		<td colspan="4" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="doCfm();">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onClick="window.location = 'fe257.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>
