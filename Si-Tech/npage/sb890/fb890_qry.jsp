<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-11-29 ���Ͽ�������
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>���Ͽ�������</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	System.out.println("=========wanghfa========= fb890_qry.jsp " + opCode + ", " + opName);
	
	String regionCode=(String)session.getAttribute("regCode");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String groupId = WtcUtil.repNull(request.getParameter("qryGroupId"));
  String webGroupType = WtcUtil.repNull(request.getParameter("webGroupTypeQry"));
	int iPageSize = 10;

	
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====1==== iChnSource = 01");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====2==== op_code = ");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====4==== iLoginPwd = " + noPass);
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====5==== iPhoneNo = ");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====6==== iUserPwd = ");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====7==== iopCode = b890");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====8==== iorgtype = ");
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====9==== iparent_groupid = " + groupId);
%>
<wtc:service name="sb890Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value=""/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="b890"/>
	<wtc:param value="<%=webGroupType%>"/>
	<wtc:param value="<%=groupId%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
	System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry : " + retCode1 + ", " + retMsg1);
	
	if ("000000".equals(retCode1)) {
		for (int i = 0; i < result1.length; i ++) {
			for (int j = 0; j < result1[i].length; j ++) {
				System.out.println("====wanghfa====fb890_qry.jsp====sb890Qry====result1["+i+"]["+j+"]" + result1[i][j]);
			}
		}
		if (result1.length == 0) {
%>
			<script language=javascript>
				rdShowMessageDialog("��Ӫҵ����Ϣ��", 1);
				window.location = "fb890.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
		}
	} else {
%>
		<script language=javascript>
			rdShowMessageDialog("��Ӫҵ���Ĳ�ѯʧ�ܣ�sb890Qry��<%=retCode1%>��<%=retMsg1%>��", 1);
			window.location = "fb890.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}
	if("000000".equals(retCode1) && result1.length > 0) {
%>
<script language=javascript>
	window.onload = function () {
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
			for (var a = 1; a <= <%=(result1.length-1)/iPageSize+1%>; a ++) {
				document.getElementById("page_" + a).style.display = "none";
			}
			document.getElementById("currentPage").innerText = pageNo;
			document.getElementById("page_" + pageNo).style.display = "";
		}
		
	}
</script>
<body>
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">���Ͽ���Ӫҵ�����ò�ѯ</div>
</div>
<table cellspacing="0">
	<tr>
		<th width="30%">��֯��������</th>
		<th width="40%">��֯��������</th>
		<th width="30%">�Ѱ���ҵ������</th>
	</tr>
</table>
<%
for (int rowNumber = 1; rowNumber <= result1.length; rowNumber ++) {
	if (rowNumber % iPageSize == 1) {
%>
		<div name='page_<%=(rowNumber/iPageSize+1)%>' id='page_<%=(rowNumber/iPageSize+1)%>' style='display:none'>
<%
	}
%>
		<table>
			<tr>
				<td width="30%"><%=result1[rowNumber - 1][0]%></td>
				<td width="40%"><%=result1[rowNumber - 1][1]%></td>
				<td width="30%"><%=result1[rowNumber - 1][3]%></td>
			</tr>
		</table>
<%
	if (rowNumber % iPageSize == 0 || rowNumber == result1.length) {
%>
		</div>
<%
	}
}
%>
<div align="center">
	<table align="center">
		<tr>
			<td align="center">
				�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=result1.length%></font>&nbsp;&nbsp;
				��ҳ����<font name="totalPage" id="totalPage"><%=(result1.length-1)/iPageSize+1%></font>&nbsp;&nbsp;
				��ǰҳ��<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
				ÿҳ������<%=iPageSize%>
				<a href="javascript:page('1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('-1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('+1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('<%=(result1.length-1)/iPageSize+1%>');">[���һҳ]</a>&nbsp;&nbsp;
				��ת��ָ��ҳ��
				<select name="toPage" id="toPage" style="width:80px" onchange="page(this.value);">
<%
					for (int i = 1; i <= (result1.length-1)/iPageSize+1; i ++) {
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

<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="back" value="����" onClick="window.location='fb890.jsp?opCode=<%=opCode%>&opName=<%=opName%>'">
	      <input class="b_foot" type=button value="�ر�" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</body>
</html>

<%
	}
%>
