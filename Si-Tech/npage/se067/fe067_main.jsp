<%
  /*
   * ����: WLANʹ����Ϣ��ѯ
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
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
  String startDate = request.getParameter("startDate");
  String endDate = request.getParameter("endDate");
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	int iPageSize = 15;
  
	String CGI_PATH = SystemUtils.getConfig("CGI_PATH");
	String DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
	String outFile = "";
	System.out.println("====wanghfa====fe067_main.jsp==== CGI_PATH = " + CGI_PATH);
	System.out.println("====wanghfa====fe067_main.jsp==== DETAIL_PATH = " + DETAIL_PATH);
	if (!CGI_PATH.endsWith("/")) {
		CGI_PATH = CGI_PATH + "/";
		DETAIL_PATH = DETAIL_PATH + "/";
	}
	
	try {
		//����·��,�������ļ���
		String kshString = CGI_PATH + "QueryPrint.sh" + " ";
		String paramterString = "0 " + "01 " + "e067 " + workNo + " " + password + " " + activePhone + " 0 " + startDate + " " + endDate + " 8999 ";
		outFile = activePhone + "e067" + dateStr1 + ".txt";
		String exePath = "/usr/bin/ksh " + kshString + paramterString + DETAIL_PATH + outFile;
		System.out.println("====wanghfa====fe067_main.jsp==== kshString->"+kshString+"&paramterString->"+paramterString+"&outFile->"+outFile);
		System.out.println("====wanghfa====fe067_main.jsp==== exePath = " + exePath);
		Runtime.getRuntime().exec(exePath);
		
	} catch (Exception ioe) {
		ioe.printStackTrace();
		%>
		<script language="javascript">
			rdShowMessageDialog("ִ��shell����δ�ܳɹ�,ԭ��:<%=ioe.getMessage()%>");
			history.go(-1);
		</script>
		<%					
	}
String tline = null;
int beginLine = 0;
int pageSize = 30;

File temp = new File(DETAIL_PATH, outFile);

int wait = 0;
while (!temp.exists() && wait < 50) {
	System.out.println("====wanghfa====fe067_main.jsp==== wait = " + wait);
	Thread.sleep(1000);
	wait ++;
}
FileReader outFrT = new FileReader(temp);
BufferedReader outBrT = new BufferedReader(outFrT);
int number = 0;

for (number = 0; !"".equals(outBrT.readLine().trim()); number ++) {
}
if (number > 0) {
	number --;
}
/*
do {
	tline = outBrT.readLine();
	number++;
} while (tline != null);
*/
outBrT.close();
outFrT.close();
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
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
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
		<td class="blue">�ֻ�����</td>
		<td colspan="3">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readOnly/>
		</td>
	</tr>
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
<table>
<%


FileReader outFrT1 = new FileReader(temp);
BufferedReader outBrT1 = new BufferedReader(outFrT1);
String tlinetep = "";

	int rowNumber = 0;
	if (rowNumber == 0) {
		tline = outBrT1.readLine();
		%>
		<tr>
			<th width="30%">��½��ʼʱ��</th>
			<th width="30%">��½����ʱ��</th>
			<th width="20%">��½�ص�</th>
			<th width="20%">��½ʱ��</th>
		</tr>
		<%
		rowNumber ++;
	}
	do {
		tline = outBrT1.readLine();
		System.out.println("====wanghfa====fe067_main.jsp==== rowNumber " + tline);
		System.out.println("====wanghfa====fe067_main.jsp==== rowNumber = " + rowNumber);
		if (rowNumber < number && rowNumber % iPageSize == 1) {
			%>
				<tbody name='page_<%=(rowNumber/iPageSize+1)%>' id='page_<%=(rowNumber/iPageSize+1)%>' style='display:none'>
			<%
		}
		if (tline != null) {
			if((tline.trim().equals(""))&&(rowNumber == 1)) {
				if (tline.indexOf("|") == -1) {
					System.out.println("====wanghfa====fe067_main.jsp==== ��|");
					outBrT1.close();
					outFrT1.close();
					continue;
				} else {
					System.out.println("====wanghfa====fe067_main.jsp==== ����Ϣ");
					outBrT1.close();
					outFrT1.close();
					%>
					<script language="javascript">
						rdShowMessageDialog("��ϢΪ�գ�", 1);
						window.history.go(-1);
					</script>
					<%
					return;
				}
			}
			tlinetep = tline.replaceAll(" ", "&nbsp;");
			if (!"".equals(tline.trim())) {
				out.print("<tr>");
				out.print("<td>"+tline.split("\\|")[0].trim()+"</td>");
				out.print("<td>"+tline.split("\\|")[1].trim()+"</td>");
				out.print("<td>"+tline.split("\\|")[2].trim()+"</td>");
				out.print("<td>"+tline.split("\\|")[3].trim()+"</td>");
				out.print("</tr>");
			}
		}
		if (rowNumber % iPageSize == 0) {
		%>
			</tbody>
		<%
		}
		rowNumber ++;
	} while (tline != null);


outBrT1.close();
outFrT1.close();
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
		<td colspan="4" id="footer" align="center">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onClick="window.location = 'fe067.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="closeWindow();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>
