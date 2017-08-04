
<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp"%>
<%
       
	
	String regionCode =  (String)session.getAttribute("regCode");		
	String work_no = (String)session.getAttribute("workNo");	
	String xiaoqudaima  = request.getParameter("xiaoqudaima");
	
	
	String opflag = (String)request.getParameter("opflag") == null ? "" : (String)request.getParameter("opflag") ;
	
	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
			inputParsm[0] = "0";
			inputParsm[1] = "01";
			inputParsm[2] = "m337";
			inputParsm[3] = work_no;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";	
			inputParsm[7] = work_no+"进行宽带小区对应营业厅和营业厅名称查询";
			inputParsm[8] = xiaoqudaima;
			
%>

<wtc:service name="sM337KDGroupQry" routerKey="region"
	routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"
	outnum="15">
	<wtc:param value="<%=inputParsm[0]%>" />
	<wtc:param value="<%=inputParsm[1]%>" />
	<wtc:param value="<%=inputParsm[2]%>" />
	<wtc:param value="<%=inputParsm[3]%>" />
	<wtc:param value="<%=inputParsm[4]%>" />
	<wtc:param value="<%=inputParsm[5]%>" />
	<wtc:param value="<%=inputParsm[6]%>" />
	<wtc:param value="<%=inputParsm[7]%>" />
	<wtc:param value="<%=inputParsm[8]%>" />
</wtc:service>
<wtc:array id="result2" scope="end" />
<html>
<head>
<title></TITLE>
</head>
<body>

	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">小区对应营业厅和营业厅名称信息&nbsp;&nbsp;</div>
		</div>
		<table cellspacing="0" name="t1" id="t1">
			<tr align="center">
				<th>营业厅代码</th>
				<th>营业厅名称</th>
			</tr>
			<%
		if(retCode.equals("000000")) {
		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
			<tr align="center">

				<td class="<%=tbClass%>"><%=result2[y][0]%></td>
				<td class="<%=tbClass%>"><%=result2[y][1]%></td>
			</tr>
			<%
		    }
		  }else {
		%>
			<tr height='25' align='center'>
				<td colspan='13'>查询小区对应营业厅和营业厅名称信息为空！</td>
			</tr>
			<%}}else {
			%>
			<tr height='25' align='center'>
				<td colspan='13'>查询小区对应营业厅和营业厅名称信息失败：<%=retCode%>--<%=retMsg%></td>
			</tr>

			<%
	}%>
		</table>
	</div>
</body>
</HTML>