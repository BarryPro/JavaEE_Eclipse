<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: huangrong
 * date  : 20101103
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
	String phone_no=request.getParameter("phone_no");
	String cust_id=request.getParameter("cust_id");
	String iUserPwd = "";
	String iYearMonth = (String)request.getParameter("iYearMonth");

	String [] inParas = new String[8];
	inParas[0] = iLoginAccept;
	inParas[1] = opCode;
	inParas[2] = iLoginNo;
	inParas[3] = phone_no;
	inParas[4] = iChnSource;
	inParas[5] = iLoginPwd;
	inParas[6] = iUserPwd;
	inParas[7] = cust_id;
%>
<wtc:service name="sb824PreQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8">
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>预约营销案查询</title>
</head>

<body>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>

<table cellspacing="0">
	<tr>
		<th class="blue" align="center">预约营销案名称</th>			
		<th class="blue" align="center">办理时间</th>									
		<th class="blue" align="center">专款金额</th>
		<th class="blue" align="center">预约专款类型</th>
		<th class="blue" align="center">预约专款开始时间</th>
		<th class="blue" align="center">结束时间</th>
		<th class="blue" align="center">操作工号</th>
		<th class="blue" align="center">操作工号归属地</th>
	</tr>	
	<%	
	if (retCode.equals("000000"))
	{
		System.out.println("result.length==================="+result.length);
		if(result.length>0)
		{
			for (int i = 0; i < result.length; i++) {			
	%>				
				<tr align="center">
					<td nowrap><%=result[i][0]%>&nbsp;</td>
					<td nowrap><%=result[i][1]%>&nbsp;</td>
					<td nowrap><%=result[i][2]%>&nbsp;</td>
					<td nowrap><%=result[i][3]%>&nbsp;</td>
					<td nowrap><%=result[i][4]%>&nbsp;</td>
					<td nowrap><%=result[i][5]%>&nbsp;</td>
					<td nowrap><%=result[i][6]%>&nbsp;</td>
					<td nowrap><%=result[i][7]%>&nbsp;</td>					
				</tr>
	<%
			}
		}
	}
	else{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		history.go(-1);
	</script>
<%
	}
%>	
	<tr>
    <td noWrap colspan="8" id="footer">
			<div align="center">
 				<input type="button" name="print" class="b_foot" value="确认" onClick="removeCurrentTab()">
              &nbsp;
				<input type="button" name="return1" class="b_foot" value="返回" onClick="history.go(-1)">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="关闭" onClick="removeCurrentTab()">
      </div>
   	</td>
	</tr>
<table>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

