<%
  /*
   * ����: �����߶˿ͻ�����ת��
   * �汾: 1.0
   * ����: 20110524
   * ����: ������wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����߶˿ͻ�����ת��</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String[] result = new String[3];

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====1==== iChnSource = 01");
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====4==== iLoginPwd = " + password);
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====5==== iPhoneNo = " + activePhone);
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====6==== iPhonePwd = ");
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====7==== iOpNote = ");
%>
	<wtc:service name="sd925Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("====wanghfa====fd925_main.jsp====sd925Qry====  " + retCode1 + ", " + retMsg1);
	if (!"000000".equals(retCode1)) {
		%>
			<script language="javascript">
				rdShowMessageDialog("sd925Qry��<%=retCode1%>��<%=retMsg1%>", 1);
				window.history.go(-1);
			</script>
		<%
	} else if (result1.length > 0) {
		for (int j = 0; j < result1[0].length; j ++) {
			System.out.println("====wanghfa====fd925_main.jsp====sd925Qry==== result1[0]["+j+"] = " + result1[0][j]);
			result[j] = result1[0][j];
		}
	}
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

	window.onload=function() {
		
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function backStep() {
		controlBtn(true);
		window.location = "fd925.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}
	
	function submitt() {
		controlBtn(true);
		var imeiCodeObj = document.getElementById("imeiCode");
		if (imeiCodeObj.value.trim().length != 15) {
			rdShowConfirmDialog("�����IMEI�������15λ��", 1);
			controlBtn(false);
			return;
		}
		
		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");
		if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
			document.frm.action = "fd925_cfm.jsp";
			document.frm.submit();
		} else {
			controlBtn(false);
		}
	}
	
function showPrtDlg(printType,DlgMessage,submitCfm) {
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";
	var billType="1";
	var sysAccept =<%=printAccept%>;
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var opCode="<%=opCode%>" ;
	var phoneNo="<%=activePhone%>";
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo=<%=activePhone%>"+
		"&submitCfm="+submitCfm+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	
	cust_info+="�ֻ����룺<%=activePhone%>|";
	cust_info+="�ͻ�������<%=result[0]%>|";
	opr_info+="����ҵ��<%=opName%>|";
	opr_info+="ҵ����ˮ��<%=printAccept%>|";
	opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
	opr_info+="�������ƣ�"+document.getElementById("saleSelect").options[document.getElementById("saleSelect").selectedIndex].text + "|";
	opr_info+="IMEI�룺" + document.getElementById("imeiCode").value + "|";
	
	note_info1="��ע��"+"|";
	if (document.getElementById("saleSelect").value == "01") {
		note_info1+="Ԥ��1000Ԫ����2000Ԫ���ѣ�Ԥ�滰��20������������ϡ����ڻ���δ�����꣬ϵͳ�Զ��ջء����β���Ԥ��Ļ��Ѳ��˲�ת������δ������ǰ���ܱ���ʷѣ����ܰ���ͣ��Ԥ����������ҵ�񡣻ר���������Ƿ�ѡ����ͻ��ѷ�20�������ͣ�ÿ������100Ԫ��������ƶ�������ֻ��ն˲�������²����ͻ��ѣ�������ƶ�������ֻ��ն�����ʹ�õ����¼������ͻ��ѡ�|";
	} else if (document.getElementById("saleSelect").value == "02") {
		note_info1+="Ԥ��2000Ԫ����4000Ԫ���ѣ�Ԥ�滰��25������������ϡ����ڻ���δ�����꣬ϵͳ�Զ��ջء����β���Ԥ��Ļ��Ѳ��˲�ת������δ������ǰ���ܱ���ʷѣ����ܰ���ͣ��Ԥ����������ҵ�񡣻ר���������Ƿ�ѡ����ͻ��ѷ�25�������ͣ�ÿ������160Ԫ��������ƶ�������ֻ��ն˲�������²����ͻ��ѣ�������ƶ�������ֻ��ն�����ʹ�õ����¼������ͻ��ѡ�|";
	}
	note_info2=" "+"|";
	note_info3=" "+"|";
	note_info4=" "+"|";
	
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
	//cust_info+="�ͻ���ַ��<%=result[1]%>|";
	//cust_info+="֤�����룺<%=result[2]%>|";
}
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
 	<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
 	
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">�ͻ�����</td>
		<td>
			<input type="text" name="custName" id="custName" class="InputGrey" value="<%=result[0]%>" readOnly/>
		</td>
		<td class="blue" width="20%">�ֻ�����</td>
		<td>
			<input type="text" name="activePhone" id="activePhone" class="InputGrey" value="<%=activePhone%>" readOnly/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">�ͻ���ַ</td>
		<td>
			<input type="text" name="custAddr" id="custAddr" class="InputGrey" value="<%=result[1]%>" readOnly/>
		</td>
		<td class="blue" width="20%">֤������</td>
		<td>
			<input type="text" name="idiccId" id="idiccId" class="InputGrey" value="<%=result[2]%>" readOnly/>
		</td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">Ӫ������Ϣ</div>
</div>
<table>
	<tr>
		<td class="blue" width="30%">IMEI��</td>
		<td width="70%">
			<input type="text" name="imeiCode" id="imeiCode" value="" size="20" maxlength="15" />
		</td>
	</tr>
	<tr>
		<td class="blue">Ӫ����ѡ��</td>
		<td>
			<select name="saleSelect" id="saleSelect" style="width:300px">
				<option value="01">Ԥ��1000Ԫ��������2000Ԫ����</option>
				<option value="02">Ԥ��2000Ԫ��������4000Ԫ����</option>
			</select>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="submitt()">    
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="��һ��" onClick="backStep()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
    <input type="hidden" id="flag" name="flag" value=""/>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
