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

System.out.println("====fe258_main.jsp====wanghfa==== opCode = " + opCode);
System.out.println("====fe258_main.jsp====wanghfa==== opName = " + opName);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====0==== iLoginAccept = " + printAccept);
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====1==== iChnSource = 01");
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe258_main.jsp====se257Qry====6==== iUserPwd = ");
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
<wtc:array id="result2" start="10" length="2" scope="end"/>
<%
System.out.println("====wanghfa=====fe258_main.jsp====se257Qry : " + retCode1 + "," + retMsg1);

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
			System.out.println("====wanghfa=====fe258_main.jsp====se257Qry==== result1[0]["+j+"] = " + result1[0][j]);
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
	var toFeeObj = new Array();
	var toPhoneObj = new Array();
	
	window.onload = function() {
		<%
		for (int i = 0; i < result2.length; i ++) {
			%>
			toFeeObj[<%=i%>] = document.getElementById("toFee<%=i+1%>");
			<%
		}
		for (int i = 0; i < result2.length; i ++) {
			%>
			toPhoneObj[<%=i%>] = document.getElementById("toPhone<%=i+1%>");
			<%
		}
		%>
		moneyChange();
	}
	function moneyChange() {
		var prePayFeeObj = document.getElementById("prePayFee");
		var presentFeeObj = document.getElementById("presentFee");
		var myFeeObj = document.getElementById("myFee");
		
		for (var a = 0; a < toFeeObj.length; a ++) {
			if (toFeeObj[a].value.trim().length == 0) {
				toFeeObj[a].value = "0";
			}
			if (!checkElement(toFeeObj[a])) {
				toFeeObj[a].focus();
				return false;
			}
		}
		
		presentFeeObj.value = "0";
		for (var a = 0; a < toFeeObj.length; a ++) {
			presentFeeObj.value = parseInt(presentFeeObj.value) + parseInt(toFeeObj[a].value);
		}
		
		myFeeObj.value = parseInt(prePayFeeObj.value) - parseInt(presentFeeObj.value);
	}
	
	function selectThis(n) {
		if (document.getElementById("select" + n).checked == true) {
			toPhoneObj[n - 1].disabled = false;
			toFeeObj[n - 1].disabled = false;
		} else {
			toPhoneObj[n - 1].value = document.getElementById("toPhoneOld" + n).value;
			toFeeObj[n - 1].value = document.getElementById("toFeeOld" + n).value;
			moneyChange();
			toPhoneObj[n - 1].disabled = true;
			toFeeObj[n - 1].disabled = true;
		}
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
		
		var checkedIt = 0;
		for (var a = 0; a < toPhoneObj.length; a ++) {
			if (document.getElementById("select" + (a + 1)).checked) {
				checkedIt ++;
			}
		}
		if (checkedIt == 0) {
			rdShowMessageDialog("����ѡ��һ��Ҫ�޸ĵ�ת����Ϣ��", 1);
			controlBtn(false);
			return false;
		}
		
		for (var a = 0; a < toPhoneObj.length; a ++) {
			if (toPhoneObj[a].value.trim().length != 11) {
				rdShowMessageDialog("ת���������Ϊ11λ���֣�", 1);
				controlBtn(false);
				toPhoneObj[a].focus();
				return false;
			}
			if ("<%=activePhone%>" == toPhoneObj[a].value) {
				rdShowMessageDialog("������벻����Ϊ���ͺ��룡", 1);
				controlBtn(false);
				toPhoneObj[a].focus();
				return false;
			}
			if (toPhoneObj[a].value.trim().length > 0) {
				if (!checkElement(toPhoneObj[a])) {
					controlBtn(false);
					toPhoneObj[a].focus();
					return false;
				} else if (parseInt(toFeeObj[a].value) <= 0 || (parseInt(toFeeObj[a].value) % 100) != 0) {
					rdShowMessageDialog("ת��" + toPhoneObj[a].value + "�Ľ������Ǵ���0�����ٽ�", 1);
					controlBtn(false);
					toPhoneObj[a].focus();
					return false;
				}
			} else {
				toFeeObj[a].value = "";
			}
		}
		
		if (toPhoneObj.length == 2) {
			if (toPhoneObj[0].value == toPhoneObj[1].value) {
				rdShowMessageDialog("���ͺ��벻���ظ���", 1);
				controlBtn(false);
				return false;
			}
		} else if (toPhoneObj.length == 3) {
			if (toPhoneObj[0].value == toPhoneObj[1].value || toPhoneObj[0].value == toPhoneObj[2].value || toPhoneObj[1].value == toPhoneObj[2].value) {
				rdShowMessageDialog("���ͺ��벻���ظ���", 1);
				controlBtn(false);
				return false;
			}
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
		
		for (var a = 0; a < toPhoneObj.length; a ++) {
			if (toPhoneObj[a].value.trim().length != 0) {
				presentNo ++;
			}
		}
		
		opr_info += "ת��������" + presentNo + "          ת����" + document.getElementById("presentFee").value + "|";
		opr_info += "ת�����뼰�����ϸ��" + "|";
		for (var a = 0; a < toPhoneObj.length; a ++) {
			if (toPhoneObj[a].value.trim().length != 0) {
				opr_info += toPhoneObj[a].value + "   " + toFeeObj[a].value + "Ԫ|";
			}
		}
		
		document.getElementById("opNote").value = "����<%=workNo%>Ϊ<%=activePhone%>�û�����<%=opName%>��";
		
		note_info1+=""+"|";
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST" action="fe258_cfm.jsp">
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
		<th width="5%">ѡ��</th>
		<th width="5%">���</th>
		<th width="40%">ת���ֻ�����</th>
		<th width="50%">ת�����</th>
	</tr>
	<%
	for (int i = 0; i < result2.length; i ++) {
		System.out.println("====wanghfa=====fe258_main.jsp====se257Qry==== " + result2[i][0] + "," + result2[i][1]);
		%>
		<tr>
		  <td>
		  	<input type="checkbox" name="select<%=i+1%>" id="select<%=i+1%>" onclick="selectThis('<%=i+1%>');" />
		  </td>
		  <td><%=i+1%></td>
		  <td>
		  	<input type="text" name="toPhone<%=i+1%>" id="toPhone<%=i+1%>" size="12" value="<%=result2[i][0]%>" maxlength="11" v_type="0_9" v_maxlength="11" disabled>
		  	<input type="hidden" name="toPhoneOld<%=i+1%>" id="toPhoneOld<%=i+1%>" value="<%=result2[i][0]%>">
		  </td>
		  <td>
		  	<input type="text" name="toFee<%=i+1%>" id="toFee<%=i+1%>" size="20" value="<%=result2[i][1]%>" v_type="0_9" onchange="moneyChange();" disabled>Ԫ
		  	<input type="hidden" name="toFeeOld<%=i+1%>" id="toFeeOld<%=i+1%>" value="<%=result2[i][1]%>">
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
