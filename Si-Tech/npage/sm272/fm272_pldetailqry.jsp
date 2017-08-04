<%
/********************
 version v2.0
开发商: si-tech
*
*add:liangyl@2016-07-25 页面开发
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>


<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	String phone_no  = request.getParameter("phone_no");	
	String opcodess=request.getParameter("opcodess");
	String plworkorgcode=request.getParameter("plworkorgcode");
	String plywaccept=request.getParameter("plywaccept");
	String plstarttimes=request.getParameter("plstarttimes");
	String plendtimes=request.getParameter("plendtimes");
	String work_no = (String)session.getAttribute("workNo");
	String noteopr =work_no+"进行员工任务记录查询操作";
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = plywaccept;
	inputParsm[1] = "01";
	inputParsm[2] = "m272";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = plworkorgcode;
	inputParsm[8] = plstarttimes;
	inputParsm[9] = plendtimes;

	
%>
	
	
	<wtc:service name="sm272BatchQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="m275"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />
	
<HTML><HEAD><TITLE></TITLE>

</HEAD>
<body>


	
	
	<div id="Operation_Table2">
		<div class="title">
			<div id="title_zi">详情</div>
		</div>
		<table cellspacing="0" name="t1" id="t1">
			<tr align="center">
				<th>员工编号</th>
				<th>业务流水</th>
				<th>业务代码</th>
				<th>业务名称</th>
				<th>操作工号</th>
				<th>操作时间</th>
				<th>操作结果</th>
			</tr>
			<%
		if(retCode2.equals("000000")) {
		System.out.println("length======="+result2.length);
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
				<td class="<%=tbClass%>"><%=result2[y][2]%></td>
				<td class="<%=tbClass%>"><%=result2[y][3]%></td>
				<td class="<%=tbClass%>"><%=result2[y][4]%></td>
				<td class="<%=tbClass%>"><%=result2[y][5]%></td>
				<td class="<%=tbClass%>"><%=result2[y][6]%></td>
			</tr>
			<%
		    }
		  }else {
		%>
			<tr height='25' align='center' onclick="plshowDetail()">
				<td colspan='7'>查询信息为空！</td>
			</tr>
			<%}}else {
			%>
			<tr height='25' align='center'>
				<td colspan='7'>查询失败：<%=retCode2%>--<%=retMsg2%></td>
			</tr>
			<%
	}%>
		</table>
	</div>

</body>
</HTML>

