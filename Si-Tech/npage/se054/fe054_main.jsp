<%
  /*
   * ����: WLAN���縲�ǲ�ѯ
   * �汾: 1.0
   * ����: 20110715
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
	String regionCode = (String)session.getAttribute("regCode");
  String startTime = request.getParameter("startTime");
  String endTime = request.getParameter("endTime");
  String startDate = request.getParameter("startDate");
  String endDate = request.getParameter("endDate");
  String region = request.getParameter("region");
  String hotArea = request.getParameter("hotArea").trim();
  String hotName = request.getParameter("hotName").trim();
  String hotAddr = request.getParameter("hotAddr").trim();
  String hotArea1 = request.getParameter("hotArea1").trim();
	int iPageSize = 15;
	
  System.out.println("====fe054_main.jsp====wanghfa==== opCode = " + opCode);
  System.out.println("====fe054_main.jsp====wanghfa==== opName = " + opName);
	
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====1==== iChnSource = 01");
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====2==== iOpCode = " + opCode);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====3==== iloginNo = " + workNo);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====4==== iloginPwd = " + password);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====5==== iPhoneNo = ");
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====6==== iUserPwd = ");
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====7==== iBeginTime = " + startTime);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====8==== iEndTime = " + endTime);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry====9==== iGroupId = " + region);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry===10==== iHotArea = " + hotArea);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry===11==== iHotName = " + hotName);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry===12==== iHotAddr = " + hotAddr);
	System.out.println("====wanghfa====fe054_main.jsp====se054Qry===13==== iHotArea1 = " + hotArea1);
%>
	<wtc:service name="se054Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=startTime%>"/>
		<wtc:param value="<%=endTime%>"/>
		<wtc:param value="<%=region%>"/>
		<wtc:param value="<%=hotArea%>"/>
		<wtc:param value="<%=hotName%>"/>
		<wtc:param value="<%=hotAddr%>"/>
		<wtc:param value="<%=hotArea1%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	System.out.println("====wanghfa====fe054_main.jsp==== se054Qry : " + retCode1 + "," + retMsg1);
	int number = result.length;
	System.out.println("====wanghfa====fe054_main.jsp==== number = " + number);
	
	if (!retCode1.equals("000000")) {
	%>
		<script language="JavaScript">
			rdShowMessageDialog("se054Qry���룺<%=retCode1%>����Ϣ��<%=retMsg1%>",0);
			history.go(-1);
		</script>
	<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>WLAN���縲�ǲ�ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	window.onload = function() {
		page("1");
	}
	
	function page(pageNo) {
		if (pageNo == "-1") {
			page(String(parseInt(document.getElementById("currentPage").innerText) - 1));
			return;
		} else if (pageNo == "+1") {
			page(String(parseInt(document.getElementById("currentPage").innerText) + 1));
			return;
		} else if (pageNo == "pageNo") {
			page(document.getElementById("pageNo").value);
			return;
		} else {
			pageNo = parseInt(pageNo);
			if (pageNo > parseInt(document.getElementById("totalPage").innerText) || pageNo < 1) {
				return;
			}
			for (var a = 1; a <= <%=(number-1)/iPageSize+1%>; a ++) {
				document.getElementById("page_" + a).style.display = "none";
			}
			document.getElementById("currentPage").innerText = pageNo;
			document.getElementById("page_" + pageNo).style.display = "";
		}
		
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function closeWindow() {
		if(window.opener == undefined) {
			removeCurrentTab();
		} else {
			window.close();
		}
	}
</script>
</head>
<body>

<form name="frm" method="POST" action="fe054_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">WLAN���縲�ǲ�ѯʱ��</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">��ʼʱ�� (��ʽYYYYMMDD)</td>
		<td width="30%">
			<input type="text" name="startDate" id="startDate" value="<%=startDate%>" class="InputGrey" readOnly/>
		</td>
		<td class="blue" width="20%">����ʱ�� (��ʽYYYYMMDD)</td>
		<td width="30%">
			<input type="text" name="endDate" id="endDate" value="<%=endDate%>" class="InputGrey" readOnly/>
		</td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">WLAN���縲�ǲ�ѯ���</div>
</div>
<table>
	<tr>
		<th width="5%">��������</th>
		<th width="10%">��������</th>
		<th width="20%">�ȵ㸲������</th>
		<th width="20%">�ȵ�����</th>
		<th width="25%">�ȵ��ַ</th>
		<th width="20%">��������</th>
	</tr>
<%
	if (retCode1.equals("000000") && result.length > 0) {
		for (int rowNumber = 1; rowNumber <= result.length; rowNumber ++) {
			if (rowNumber % iPageSize == 1) {
			%>
					<tbody name='page_<%=(rowNumber/iPageSize+1)%>' id='page_<%=(rowNumber/iPageSize+1)%>' style='display:none'>
			<%
			}
		%>
			<tr>
				<td><%=rowNumber%></td>
				<td><%=result[rowNumber - 1][1]%></td>
				<td><%=result[rowNumber - 1][2]%></td>
				<td><%=result[rowNumber - 1][3]%></td>
				<td><%=result[rowNumber - 1][4]%></td>
				<td><%=result[rowNumber - 1][5]%></td>
			</tr>
		<%
			if (rowNumber % iPageSize == 0) {
			%>
				</tbody>
			<%
			}
		}
	} else if (retCode1.equals("000000") && result.length == 0) {
		%>
			<td colspan="5">
				����Ϣ
			</td>
		<%
	}
%>
</table>
<div align="center">
	<table align="center">
		<tr>
			<td align="center">
				�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=number%></font>&nbsp;&nbsp;
				��ҳ����<font name="totalPage" id="totalPage"><%=(number-1)/iPageSize+1%></font>&nbsp;&nbsp;
				��ǰҳ��<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
				ÿҳ������<%=iPageSize%>
				<a href="javascript:page('1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('-1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('+1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('<%=number/iPageSize+1%>');">[���һҳ]</a>&nbsp;&nbsp;
				��ת��ָ��ҳ��
				<select name="toPage" id="toPage" style="width:80px" onchange="page(this.value);">
<%
					for (int i = 1; i <= (number-1)/iPageSize+1; i ++) {
%>
						<option value="<%=i%>">��<%=i%>ҳ</option>
<%
					}
%>
				</select>
			</td>
		</tr>
	</table>
</div>
<table>
	<tr>
		<td colspan="4" id="footer">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onClick="window.location = 'fe054.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="closeWindow();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>
