<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:wanghfa@2010-8-25 ���ಿTD�̻�
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>���ಿTD�̻�Ԥ����</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","No-cache");
	response.setDateHeader("Expires", 0);
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String brandName = WtcUtil.repNull(request.getParameter("brandName"));
	String phoneType = WtcUtil.repNull(request.getParameter("phoneType"));
	String valSaleInfo = WtcUtil.repNull(request.getParameter("valSaleInfo"));
	
	String var1 = valSaleInfo.split(",")[0];
	String var2 = valSaleInfo.split(",")[1];
	String var3 = valSaleInfo.split(",")[2];
	String var4 = valSaleInfo.split(",")[3];
	String var5 = valSaleInfo.split(",")[4];
	String var6 = valSaleInfo.split(",")[5];
%>

</head>
<script language=javascript>
	
</script>
<body>

<input type="hidden" name="opCode" id="" value="<%=opCode%>">
<input type="hidden" name="opName" id="" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">Ӫ������Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td width="20%" class="blue">TD�̻�Ʒ��</td>
		<td width="30%">
			<%=brandName%>
		</td>
		<td width="20%" class="blue">TD�̻��ͺ�</td>
		<td width="30%">
			<%=phoneType%>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">Ԥ�滰��</td>
		<td width="30%">
			<%=var1%>Ԫ
		</td>
		<td width="20%" class="blue">������������</td>
		<td width="30%">
			<%=var3%>����
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">Ӧ�ս��</td>
		<td colspan="3">
			<%=var6%>Ԫ
		</td>
	</tr>
</table>

<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type="button" name="closeTab" value="�ر�" onClick="window.returnValue='1';window.close();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</body>
</html>
