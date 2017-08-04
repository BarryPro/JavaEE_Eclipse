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
String opCode = "4518";
String opName = request.getParameter("opName");
String iLoginAccept  =   "";
String iChnSource    =   "";
String iOpCode       =   opCode;
String iLoginNo		=(String)session.getAttribute("workNo");
String iLoginPwd	=(String)session.getAttribute("password");
String iUpdateLogin  =    request.getParameter("work_no");
String iBeginTime    =   request.getParameter("start_time");
String iEndTime      = request.getParameter("end_time");
String iOfferId      =  request.getParameter("pkg_code");;
int iPageSize = 10;
%>

<wtc:service name="s4518Qry" routerKey="workno" routerValue="<%=iLoginNo%>"
	retcode="retCode1" retmsg="retMsg1" outnum="15">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iUpdateLogin%>"/>
	<wtc:param value="<%=iBeginTime%>"/>
	<wtc:param value="<%=iEndTime%>"/>
	<wtc:param value="<%=iOfferId%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
	System.out.println("====zhangyan========  : " + retCode1 + "," + retMsg1 );
	int number = result.length;
	System.out.println("====zhangyan======== number = " + number);

	if (!retCode1.equals("000000")) {
	%>
		<script language="JavaScript">
			rdShowMessageDialog("s4518Qry���룺<%=retCode1%>����Ϣ��<%=retMsg1%>",0);
			history.go(-1);
		</script>
	<%
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<html>
<head>
	<!--************************��ҳ����ʽ��**************************-->
		<link rel="stylesheet" type="text/css"
			href="/nresources/default/css/fenye.css" media="all" />
<base target="_self">
<title>������VPMN�ʷ����ò�����Ϣ</title>

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
		document.getElementById("divBody").style.display="none";
	}
</script>
</head>

<body>
	<div id="divBody">
  <form name="form1"  method="post">
   <DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">������VPMN�ʷ����ò�����Ϣ</div>
	</div>

	<table cellspacing="0" >
		<tr  height="22">
			<TD class="blue" align="center">����</TD>
			<TD class="blue" align="center">�ʷ�����</TD>
			<TD class="blue" align="center">����</TD>
			<TD class="blue" align="center">��ʼ��</TD>
			<TD class="blue" align="center">������</TD>
			<TD class="blue" align="center">��ʼ��</TD>
			<TD class="blue" align="center">������</TD>
			<TD class="blue" align="center">��ʼ��</TD>
			<TD class="blue" align="center">������</TD>
			<TD class="blue" align="center">��ʼʱ</TD>
			<TD class="blue" align="center">����ʱ</TD>
			<TD class="blue" align="center">��ʼ��</TD>
			<TD class="blue" align="center">������</TD>
			<TD class="blue" align="center">����</TD>
			<TD class="blue" align="center">����ʱ��</TD>
		</tr>
		<%
		if (retCode1.equals("000000") && result.length > 0)
		{
			for (int rowNumber = 1; rowNumber <= result.length; rowNumber ++)
			{
				if (rowNumber % iPageSize == 1) {
				%>
					<tbody name='page_<%=(rowNumber/iPageSize+1)%>' id='page_<%=(rowNumber/iPageSize+1)%>'
						style='display:none'>
				<%
				}
				%>
				<tr>
					<td><%=result[rowNumber - 1][0]%></td>
					<td><%=result[rowNumber - 1][1]%></td>
					<td><%=result[rowNumber - 1][2]%></td>
					<td><%=result[rowNumber - 1][3]%></td>
					<td><%=result[rowNumber - 1][4]%></td>
					<td><%=result[rowNumber - 1][5]%></td>
					<td><%=result[rowNumber - 1][6]%></td>
					<td><%=result[rowNumber - 1][7]%></td>
					<td><%=result[rowNumber - 1][8]%></td>
					<td><%=result[rowNumber - 1][9]%></td>
					<td><%=result[rowNumber - 1][10]%></td>
					<td><%=result[rowNumber - 1][11]%></td>
					<td><%=result[rowNumber - 1][12]%></td>
					<td><%=result[rowNumber - 1][13]%></td>
					<td><%=result[rowNumber - 1][14]%></td>					
				</tr>
				<%
				if (rowNumber % iPageSize == 0) {
				%>
					</tbody>
				<%
				}
			}
		}
		else if (retCode1.equals("000000") && result.length == 0) {
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
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�"
				onClick="closeWindow();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>