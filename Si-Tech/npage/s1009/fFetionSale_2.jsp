<%
/********************
 * version v2.0
 * ������: si-tech
 * author: daixy
 * date  : 20100625
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String regionCode = (String)session.getAttribute("regCode");
    
	String iLoginAccept = "";
	String iChnSource = "";
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String iPhoneNo=request.getParameter("iPhoneNo");
	String iUserPwd = "";
	String iYearMonth = (String)request.getParameter("iYearMonth");

	String [] inParas = new String[8];
	inParas[0] = iLoginAccept;
	inParas[1] = iChnSource;
	inParas[2] = opCode;
	inParas[3] = iLoginNo;
	inParas[4] = iLoginPwd;
	inParas[5] = iPhoneNo;
	inParas[6] = iUserPwd;
	inParas[7] = iYearMonth;
%>
<wtc:service name="sFetionSaleQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5">
	<wtc:param value="<%=inParas[0]%>" />
	<wtc:param value="<%=inParas[1]%>" />
	<wtc:param value="<%=inParas[2]%>" />
	<wtc:param value="<%=inParas[3]%>" />
	<wtc:param value="<%=inParas[4]%>" />
	<wtc:param value="<%=inParas[5]%>" />
	<wtc:param value="<%=inParas[6]%>" />
	<wtc:param value="<%=inParas[7]%>" />
</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
	String oFriendNum = "";
	String oMessageNum = "";
	String oCustName = "";
	
	if (result.length>0 && retCode.equals("000000"))
	{
		 oCustName = result[0][2];
		 oFriendNum = result[0][3];
		 oMessageNum = result[0][4];
	}else{
%>
	<script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>������룺'<%=retCode%>'��������Ϣ��'<%=retMsg%>'��",0);
		history.go(-1);
	</script>
<%
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����Ӫ������ѯ</title>
</head>

<body>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>

<table cellspacing="0">
	<tr>
		<td>�ֻ�����</td>
        <td><input name="PhoneNo" type="text" value="<%=iPhoneNo%>" class="InputGrey" readonly></td>

        <td>�ͻ�����</td>
        <td><input name="messageNum" type="text" value="<%=oCustName%>" class="InputGrey" readonly></td>
	</tr>	

	<tr>
		<td>������������</td>
		<td><input name="friendNum" type="text" value="<%=oFriendNum%>" class="InputGrey" readonly></td>
		
		<td>���ͷ�������</td>
		<td><input name="messageNum" type="text" value="<%=oMessageNum%>" class="InputGrey" readonly></td>
	</tr>
	<tr>
    	<td noWrap colspan="6" id="footer">
		<div align="center">
 		<input type="button" name="print" class="b_foot" value="ȷ��" onClick="removeCurrentTab()">
              &nbsp;
		<input type="button" name="return1" class="b_foot" value="����" onClick="history.go(-1)">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
      	</div>
   		</td>
	</tr>
<table>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
