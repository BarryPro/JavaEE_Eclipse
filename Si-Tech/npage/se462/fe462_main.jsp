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
String[] result = new String[4];
//String activePhone = request.getParameter("activePhone");
String sql = "";
String sqlVar = "";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 6==== iUserPwd = ");
%>
<wtc:service name="se462Init" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg1">
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
		rdShowMessageDialog("se462Initʧ�ܣ�������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>", 0);
		window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	</script>
	<%
	return;
} else {
	System.out.println("====wanghfa==== result1.length = " + result1[0].length);
	for (int i = 0; i < result1[0].length; i ++) {
		result[i] = result1[0][i];
	}
}

sql = "select a.project_type,"
	 + "       a.project_code,"
	 + "       a.project_name,"
	 + "       to_char(a.least_prepay),"
	 + "       to_char(a.offer_id),"
	 + "       b.offer_name,"
	 + "       b.offer_comments,"
	 + "       nvl(a.ACTIVE_NOTE, ' '),"
	 + "       to_char(a.exp_date, 'yyyymmdd')"
	 + "  from sFeeTypeAction a, product_offer b"
	 + " where a.region_code = :vRegionCode"
	 + "   and a.is_valid = 'Y'"
	 + "   and to_char(sysdate, 'YYYYMMDD') >= a.begin_time"
	 + "   and to_char(sysdate, 'YYYYMMDD') <= a.end_time"
	 + "   and a.offer_id = b.offer_id";
sqlVar = " vRegionCode=" + regionCode;
%>
<wtc:service name="TlsPubSelCrm" outnum="9" retmsg="retMsgType" retcode="retCodeType" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="<%=sqlVar%>"/>
</wtc:service>
<wtc:array id="resultType" scope="end" />
<%
if (!"000000".equals(retCodeType)) {
	%>
	<script language="javascript">
		rdShowMessageDialog("ȡӪ��������������ϵ����Ա��", 1);
		window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	</script>
	<%
	return;
}
%>
<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	var projectTypes = new Array();
	var projectCodes = new Array();
	var projectNames = new Array();
	var leastPrepays = new Array();
	var offerIds = new Array();
	var offerNames = new Array();
	var offerComments = new Array();
	var activeNotes = new Array();
	var expDates = new Array();
	
	onload = function() {
		<%
		for (int a = 0; a < resultType.length; a ++) {
			%>
			projectTypes[<%=a%>] = "<%=resultType[a][0]%>";
			projectCodes[<%=a%>] = "<%=resultType[a][1]%>";
			projectNames[<%=a%>] = "<%=resultType[a][2]%>";
			leastPrepays[<%=a%>] = parseFloat("<%=resultType[a][3]%>");
			offerIds[<%=a%>] = "<%=resultType[a][4]%>";
			offerNames[<%=a%>] = "<%=resultType[a][5]%>";
			offerComments[<%=a%>] = "<%=resultType[a][6]%>";
			activeNotes[<%=a%>] = "<%=resultType[a][7]%>";
			expDates[<%=a%>] = "<%=resultType[a][8]%>";
			<%
		}
		%>
		projectTypeChange();
	}
	
	function projectTypeChange() {
		var projectType = $("#projectType").val();
		$("#projectCode").empty();
		
		for (var a = 0; a < projectTypes.length; a ++) {
			if (projectTypes[a] == projectType) {
				$("<option value='" + projectCodes[a] + "'>" + projectCodes[a] + "--" + projectNames[a] + "</option>").appendTo($("#projectCode"));
			}
		}
		
		projectCodeChange();
	}
	
	function projectCodeChange() {
		var projectCode = $("#projectCode").val();
		
		if (projectTypes.length == 0) {
			$("#baseFee").val("");
			$("#offerId").val("");
			$("#offerName").val("");
			$("#offerComment").val("");
			$("#activeNote").val("");
			$("#expDate").val("");
		} else {
			for (var a = 0; a < projectTypes.length; a ++) {
				if (projectCodes[a] == projectCode) {
					$("#baseFee").val(leastPrepays[a]);
					$("#offerId").val(offerIds[a]);
					$("#offerName").val(offerNames[a]);
					$("#offerComment").val(offerComments[a]);
					$("#activeNote").val(activeNotes[a]);
					$("#expDate").val(expDates[a]);
				}
			}
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);

		if ($("#projectType").val() == null) {
			rdShowMessageDialog("û�з������͹�ѡ�񣬲����԰���ҵ��");
			controlBtn(false);
			return false;
		}
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		
		if (rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��") != 1) {
			controlBtn(false);
			return false;
		} else {
			document.frm.action = "fe462_cfm.jsp";
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
		var opCode="e462" ;                   			 		//��������
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
		
		opr_info+="�û�Ʒ�ƣ�"+document.all.smName.value+"    ����ҵ����ϲ����Ӫ����"+"|";
		opr_info+="������ˮ��"+document.all.loginAccept.value+"    ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
		opr_info+="���Ϳ�ѡ�ײͣ�" + $("#offerId").val() + "-" + $("#offerName").val() + "|";
		opr_info+="���Ϳ�ѡ�ײ���Ч�ڣ�" + $("#expDate").val() + "|";
		opr_info+="|";
		if($("#activeNote").val().trim().length > 0) {
			note_info1+="��ע��" + $("#activeNote").val() + "|";
		}
		note_info1+="���Ϳ�ѡ�ײ�������" + $("#offerComment").val() + "|";
		note_info1+="ע�����|";
		note_info1+="1���û����°�����ѡ�ʷ�������Ч��ֻ���������Ӫ�������������ѡ�ʷ�����ʧЧ����������������2��ʱ���ٴΰ���Ӫ����ʱ�ʷ�ΪԤԼ��Ч������֮����κ�ʱ�䶼����ȡ��Ӫ������ȡ�����ѡ�ʷ�ԤԼʧЧ�����²����ٴΰ���Ӫ�������룬��������ʱ��������Ч��|";
		note_info1+="2�������ײ���Ч�ڵ��ڣ������ײ��Զ�ȡ����|";
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
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="opNote" value="">
	
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
				<input name="custName" type="text" class="InputGrey" id="custName" value="<%=result[0]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ���ַ</td>
			<td colspan="3">
				<input name="custAddr" type="text" class="InputGrey" id="custAddr" value="<%=result[1]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">֤������</td>
			<td>
				<input name="idIccid" type="text" class="InputGrey" id="idIccid" value="<%=result[2]%>" readonly>
			</td>
			<td class="blue">Ʒ������</td>
			<td>
				<input name="smName" type="text" class="InputGrey" id="smName" value="<%=result[3]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">��������</td>
			<td colspan="3">
				<select id=projectType name=projectType style="width:400px" onchange="projectTypeChange()">
					<%
					sql = "select distinct trim(a.project_type), trim(a.type_name)"
						 + "  from sactivetype a, sFeeTypeAction b"
						 + " where a.op_code = 'e462'"
						 + "   and a.region_code = :vRegionCode"
						 + "   and a.region_code = b.region_code"
						 + "   and a.project_type = b.project_type"
						 + "   and b.is_valid = 'Y'"
						 + "   and b.begin_time <= to_char(sysdate, 'YYYYMMDD')"
						 + "   and b.end_time >= to_char(sysdate, 'YYYYMMDD')";
					sqlVar = " vRegionCode=" + regionCode;
					%>
					<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="retMsgType" retcode="retCodeType" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sql%>"/>
						<wtc:param value="<%=sqlVar%>"/>
					</wtc:service>
					<wtc:array id="resultType" scope="end" />
					<%
					if (!"000000".equals(retCodeType)) {
						%>
						<script language="javascript">
							rdShowMessageDialog("ȡӪ���������ʹ�������ϵ����Ա��", 1);
							window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
							return;
						</script>
						<%
						return;
					} else {
						for (int i = 0; i < resultType.length; i ++) {
							%>
							<option value="<%=resultType[i][0]%>"><%=resultType[i][0]%>--<%=resultType[i][1]%></option>
							<%
						}
					}
					
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">����</td>
			<td colspan="3">
				<select id=projectCode name=projectCode style="width:400px" onchange="projectCodeChange()">
				
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">��Ԥ��</td>
			<td colspan="3">
				<input name="baseFee" type="text" class="InputGrey" id="baseFee" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ʷѴ���</td>
			<td>
				<input name="offerId" type="text" class="InputGrey" id="offerId" readonly>
			</td>
			<td class="blue">�ʷ�����</td>
			<td>
				<input name="offerName" type="text" class="InputGrey" id="offerName" size="40" readonly>
				<input name="offerComment" type="hidden" id="offerComment">
				<input name="activeNote" type="hidden" id="activeNote">
				<input name="expDate" type="hidden" id="expDate">
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
