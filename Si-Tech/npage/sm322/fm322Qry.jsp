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
	String phone_no  = request.getParameter("phone_no");	
	String work_no = (String)session.getAttribute("workNo");	

	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m322";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";


	
%>
     	
	<wtc:service name="sUnProdListQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>


	</wtc:service>

        <wtc:array id="result2" scope="end"  />
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">已下线特服信息</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
					<th><input type="checkbox"   id="ssd" onclick="if(this.checked==true) { checkAll(); } else { clearAll(); }"/></th>
	        <th>特服代码</th>
	        <th>特服名称</th>

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
		%>
						<tr align="center">
						<td class="<%=tbClass%>" align="center"><input type="checkbox"  value="<%=result2[y][0]%><!--!><%=result2[y][1]%>" id="ckbox" /></td>
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='3'>查询客户已下线特服信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='3'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

