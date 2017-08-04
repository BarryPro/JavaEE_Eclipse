<% 
  /*
   * 功能: 网间号码_批量操作
　 * 版本: v1.00
　 * 日期: 2012-6-18 17:22:34
　 * 作者: liujian
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>网间号码_批量操作</title>

<%
	String opCode = "e884";
	String opName = "网间号码_批量操作";
	
	String work_no = (String) session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String org_code = (String) session.getAttribute("orgCode");
	String regionCode = org_code.substring(0, 2);

	String paraStr[] = new String[24];
	
	paraStr[0] = "0";
	paraStr[1] = "01";
  paraStr[2] = "e884";
  paraStr[3] = work_no;
  paraStr[4] = loginNoPass;
  paraStr[5] = "";
  paraStr[6] = "";
  paraStr[7] = WtcUtil.repNull(request.getParameter("iCodeStr1"));
  paraStr[8] = WtcUtil.repNull(request.getParameter("iCodeStr2"));
  paraStr[9] = WtcUtil.repNull(request.getParameter("iCodeStr3"));
  paraStr[10] = WtcUtil.repNull(request.getParameter("iCodeStr4"));
  paraStr[11] = WtcUtil.repNull(request.getParameter("iCodeStr5"));
  paraStr[12] = WtcUtil.repNull(request.getParameter("iCodeStr6"));
  paraStr[13] = WtcUtil.repNull(request.getParameter("iCodeStr7"));
  paraStr[14] = WtcUtil.repNull(request.getParameter("iCodeStr8"));
  paraStr[15] = WtcUtil.repNull(request.getParameter("iCodeStr9"));
	paraStr[16] = WtcUtil.repNull(request.getParameter("iCodeStr10"));
	
	
	for(int i=0;i<paraStr.length;i++) {
			System.out.println("paraStr[" + i + "]---liujian----" + paraStr[i]);
	}
%>

	<wtc:service name="se884Cfm" routerKey="regionCode" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=regionCode%>" outnum="5">
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/>
		<wtc:param value="<%=paraStr[12]%>"/>
		<wtc:param value="<%=paraStr[13]%>"/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value="<%=paraStr[15]%>"/>
		<wtc:param value="<%=paraStr[16]%>"/>
		<wtc:param value="<%=paraStr[17]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>

<%
System.out.println("initRetCode=========liujian========="+initRetCode);
System.out.println("initRetMsg==========liujian========="+initRetMsg);

if((result==null) || (result.length == 0))
{
%>
	<script language=javascript>
		rdShowMessageDialog("错误信息：<%=initRetMsg%>");
		window.location="s6945Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
%>

<script language=javascript>

</script>

</head>
<body>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">网间号码_批量操作</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>手机号码</td>
		<td class="blue" width="15%" nowrap>返回代码</td>
		<td class="blue" width="15%" nowrap>返回信息</td>
		<td class="blue" width="15%" nowrap>操作流水</td>
	</tr>
	
	<%
	String tbclass = "";
	for(int i=0;i<result.length;i++)
	{
		tbclass = (i%2==0)?"Grey":"blue";
	%>
		<tr>
		    <td class="<%=tbclass%>"><%=result[i][0]%>&nbsp;</td>
			<td class="<%=tbclass%>"><%=result[i][1]%>&nbsp;</td>
			<td class="<%=tbclass%>"><%=result[i][2]%>&nbsp;</td>
			<td class="<%=tbclass%>"><%=result[i][3]%>&nbsp;</td>
		</tr>
	<%
	}
	%>
    <tr>
        <td colspan="4" id="footer">
			<input class="b_foot" type="button" name="b_back" value="返回" onClick="location='f6945_netsPhoneImport.jsp'">
            &nbsp;        	
            <input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>