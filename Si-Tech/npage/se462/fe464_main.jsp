<%
/********************
version v1.0
������: si-tech
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
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 
String[] result = new String[13];
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe464_main.jsp====se464Qry==== 6==== iUserPwd = ");

%>
<wtc:service name="se464Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode1" retmsg="retMsg1">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
if (!"000000".equals(retCode1)) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("se464Qryʧ�ܣ�������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>", 0);
		window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	</script>
	<%
	return;
} else {
	System.out.println("====wanghfa==== result1.length = " + result1.length);
	for (int i = 0; i < result1[0].length; i ++) {
		result[i] = result1[0][i];
	}
}
%>
<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	onload = function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		
		if (rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��") != 1) {
			controlBtn(false);
			return false;
		} else {
			document.frm.action = "fe464_cfm.jsp";
			document.frm.submit()
		}
	}
	
	function showPrtDlg(printType,DlgMessage,submitCfm) {  //��ʾ��ӡ�Ի���
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept =<%=loginAccept%>;             			//��ˮ��
		var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
		var mode_code=null;           							//�ʷѴ���
		var fav_code=null;                				 		//�ط�����
		var area_code=null;             				 		//С������
		var opCode="e464" ;                   			 		//��������
		var phoneNo="<%=activePhone%>";                  	 		//�ͻ��绰
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

	function printInfo(printType) {
		var cust_info="";  				//�ͻ���Ϣ
		var opr_info="";   				//������Ϣ
		var note_info1=""; 				//��ע1
		var note_info2=""; 				//��ע2
		var note_info3=""; 				//��ע3
		var note_info4=""; 				//��ע4
		var retInfo = "";  				//��ӡ����
		
		cust_info+="�ֻ����룺"+document.all.activePhone.value+"|";
		cust_info+="�ͻ�������"+document.all.custName.value+"|";
		//cust_info+="�ͻ���ַ��"+document.all.custAddr.value+"|";
		//cust_info+="֤�����룺"+document.all.idIccid.value+"|";
		//retInfo+=" "+"|";
		
		opr_info+="�û�Ʒ�ƣ�"+document.all.smName.value+"    ����ҵ����ϲ����Ӫ����ȡ��"+"|";
		opr_info+="������ˮ��"+document.all.loginAccept.value+"    ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
		opr_info+="|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
}
</script>
</head>
<body>
<form name="frm" method="post" action="fe457_cfm.jsp">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="accept" value="<%=result[4]%>">
	<input type="hidden" name="opNote" value="">
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">�ֻ�����</td>
			<td width="30%">
				<input type="text" name="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
			</td>
			<td class="blue" width="20%">�ͻ�����</td>
			<td width="30%">
				<input name="custName" type="text" class="InputGrey" id="custName" value="<%=result[8]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ���ַ</td>
			<td colspan="3">
				<input name="custAddr" type="text" class="InputGrey" size="60" id="custAddr" value="<%=result[9]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">֤������</td>
			<td>
				<input name="idIccid" type="text" class="InputGrey" id="idIccid" value="<%=result[10]%>" readonly>
			</td>
			<td class="blue">Ʒ������</td>
			<td>
				<input name="smName" type="text" class="InputGrey" id="smName" value="<%=result[11]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">��������</td>
			<td>
				<input name="projectTypeName" type="text" class="InputGrey" size="30" id="projectTypeName" value="<%=result[6]%>--<%=result[0]%>" readonly>
			</td>
			<td class="blue">����</td>
			<td>
				<input name="projectCodeName" type="text" class="InputGrey" size="30" id="projectCodeName" value="<%=result[7]%><%=result[1]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">��ʼʱ��</td>
			<td>
				<input name="beginTime" type="text" class="InputGrey" id="beginTime" value="<%=result[2]%>" readonly>
			</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input name="endTime" type="text" class="InputGrey" id="endTime" value="<%=result[3]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ʷѴ���</td>
			<td>
				<input name="offerId" type="text" class="InputGrey" id="offerId" value="<%=result[5]%>" readonly>
			</td>
			<td class="blue">�ʷ�����</td>
			<td>
				<input name="offerName" type="text" class="InputGrey" id="offerName" size="40" value="<%=result[12]%>" readonly>
			</td>
		</tr>
	</table>

	<table cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input type="button" name="submitBtn" id="submitBtn" class="b_foot" value="ȷ��" onClick="doCfm()" >
				<input type="button" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>'" value="����" >
				<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="�ر�">
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
