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
String opCode = "e459";     
String opName = "��ϲ����Ӫ�����������޸�";
String regionCode = (String)session.getAttribute("regCode");

int opNum = Integer.parseInt(request.getParameter("opNum"));
String projectType = request.getParameterValues("projectType")[opNum];
String typeName    = request.getParameterValues("typeName"   )[opNum];
String projectCode = request.getParameterValues("projectCode")[opNum];
String projectName = request.getParameterValues("projectName")[opNum];
String flag        = request.getParameterValues("flag"       )[opNum];
String offerId     = request.getParameterValues("offerId"    )[opNum];
String regionName  = request.getParameterValues("regionName" )[opNum];
String leastPrepay = request.getParameterValues("leastPrepay")[opNum];
String expDate     = request.getParameterValues("expDate"    )[opNum];
String beginTime   = request.getParameterValues("beginTime"  )[opNum];
String endTime     = request.getParameterValues("endTime"    )[opNum];
String isValid     = request.getParameterValues("isValid"    )[opNum];
String fileName    = request.getParameterValues("fileName"   )[opNum];
String fileNo      = request.getParameterValues("fileNo"     )[opNum];
String auditName   = request.getParameterValues("auditName"  )[opNum];
String auditPhone  = request.getParameterValues("auditPhone" )[opNum];
String activeNote  = request.getParameterValues("activeNote" )[opNum];
String opWorkNo    = request.getParameterValues("opWorkNo"   )[opNum];
String auditSuggestion = request.getParameterValues("auditSuggestion")[opNum];
String auditLoginNo    = request.getParameterValues("auditLoginNo"   )[opNum];
String auditDate       = request.getParameterValues("auditDate"      )[opNum];
String auditLoginName  = request.getParameterValues("auditLoginName" )[opNum];

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>

<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);

		if (!checkElement(document.getElementById("stopTime"))) {
			controlBtn(false);
			return false;
		} else if (rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��") != 1) {
			controlBtn(false);
			return false;
		} else {
			document.frm.action = "fe459_cfm.jsp";
			document.frm.submit()
		}
	}
</script>
</head>
<body>
<form name="frm" method="post">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">Ӫ����������������޸�</div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">�����</td>
      <td class="blue" width="30%">
      	<input type=text name='projectType' id='projectType' value="<%=projectType%>" class="InputGrey" readonly>
			</td>
			<td class="blue" width="20%">���������</td>
		  <td class="blue" width="30%">
				<input type=text name='projectTypeName' id='projectTypeName' value="<%=typeName%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">ʡ��˾�����ļ���</td>
			<td width="30%">
				<input name="fileName" type="text" id="fileName" value="<%=fileName%>" class="InputGrey" readonly>
			</td>
			<td width="20%" class="blue">ʡ��˾�����ļ���</td>
			<td width="30%">
				<input name="fileNo" type="text" id="fileNo" value="<%=fileNo%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">����������</td>
			<td>
				<input name="auditName"  type="text" id="auditName" value="<%=auditName%>" class="InputGrey" readonly>
			</td>
			<td class="blue">�����˵绰</td>
			<td>
				<input name="auditPhone" type="text" id="auditPhone" value="<%=auditPhone%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">��������</td>
			<td>
				<input name="projectCode" type="text" id="projectCode" value="<%=projectCode%>" class="InputGrey" readonly>
			</td>
			<td class="blue">��������</td>
			<td>
				<input name="projectName" type="text" id="projectName" value="<%=projectName%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">���ʼʱ��</td> 
			<td>
				<input name="beginTime" type="text" id="beginTime" value="<%=beginTime%>" class="InputGrey" readonly>
			</td>
			<td class="blue">�����ʱ��</td>
			<td>
				<input name="stopTime" type="text" id="stopTime" value="<%=endTime%>" maxlength="8" v_type="date" v_must="1">(YYYYMMDD)
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">��Ԥ��</td>
			<td colspan="3">
				<input name="leastPrepay" type="text" id="leastPrepay" value="<%=leastPrepay%>" class="InputGrey" readonly>
				(ֻ��ȷ��0.01Ԫ)
			</td>
		</tr>
		<tr>
			<td class="blue">��ѡ�ʷѴ���</td> 
			<td>
				<input name="offerId" type="text" id="offerId" value="<%=offerId%>" class="InputGrey" readonly>
			</td>
			<td class="blue">�ʷ�ʧЧʱ��</td>
			<td>
				<input name="expDate" type="text" id="expDate" value="<%=expDate%>" class="InputGrey" readonly>
			</td>
		</tr>
	</table>
	
	<div class="title">
		<div id="title_zi">����״̬</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th>��������</th>
			<th>����ʱ��</th>
			<th>�������</th>
		</tr>
		<%
		String[] auditLoginNos = auditLoginNo.split("\\|");
		String[] auditLoginNames = auditLoginName.split("\\|");
		String[] auditDates = auditDate.split("\\|");
		String[] auditSuggestions = auditSuggestion.split("\\|");
		for (int i = 0; i < auditLoginNos.length; i ++) {
			%>
			<tr>
				<td><%=auditLoginNames[i]%> <%=auditLoginNos[i]%></td>
				<td><%=auditDates[i]%></td>
				<td><%=auditSuggestions[i]%></td>
			</tr>
			<%
		}                       
		%>
	</table>

	<table cellspacing="0"> 
		<tr>
			<td colspan="6" align="center" id="footer">
				<input type="button" name="submitBtn" id="submitBtn" class="b_foot" value="ȷ��" onClick="doCfm()">
				<input type="reset" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe458_query.jsp?opCode=<%=opCode%>&opName=<%=opName%>&opFlag=query'" value="����" >
				<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="�ر�">
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
