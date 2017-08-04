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
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%!

%>
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");	
	String work_no = (String)session.getAttribute("workNo");	
	String xiaoqunameccc  = request.getParameter("xiaoqunameccc");	
	String opType  = request.getParameter("opType");	
	String showTip = "点击任意行小区信息可以查询对应的资费信息";
	/*2016/4/21 21:12:00 gaopeng 小区经理信息查询*/
	if("managerConfig".equals(opType)){
		showTip = "点击任意行小区信息可以查询对应的小区经理信息";
	}

	
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
			String beizhuss =work_no+"进行宽带资费查询";

%>
     	
	<wtc:service name="sM337KDQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=xiaoqunameccc%>"/>
	</wtc:service>
  <wtc:array id="result2" scope="end"/>

	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">小区信息(<font color='red'><%=showTip%></font>)</div>
			</div>
	    <table cellspacing="0" >
	      <tr align="center"> 

	        <th>地市名称</th>
	        <th>小区代码</th>
	        <th>小区名称</th>
	        <th>小区建设性质代码</th>
					<th>小区建设性质名称</th>	        

	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
							/*2016/4/21 21:15:46 gaopeng 如果是小区客户经理查询*/
		%>				
							<%if("managerConfig".equals(opType)){
							%>
								<tr id="manager<%=y%>" align="center" onclick="sBroadManagerQry('manager<%=y%>');" >
							<%
							}else{
								%>
								<tr align="center" onclick="queryofferidajax('<%=result2[y][1]+"|"+result2[y][3]%>');" >
							<%
							}
							%>
						
							
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>
	
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='6'>查询小区信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='6'>查询小区信息失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

