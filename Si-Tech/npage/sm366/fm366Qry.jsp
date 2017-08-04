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
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");	
	String work_no = (String)session.getAttribute("workNo");	
	
	String custName  = request.getParameter("custName");	
	String idIccid  = request.getParameter("idIccid");	
	String id_type  = request.getParameter("id_type");	
	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");	

%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>   
  	  	
 <wtc:service name="sm366QryNew" outnum="8"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="m366"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=idIccid%>"/>
      <wtc:param value="<%=id_type%>"/>
      <wtc:param value=""/>
      <wtc:param value="0"/>
  </wtc:service>
  
	<wtc:array id="result2"   scope="end" start="0"  length="6"  />
	<wtc:array id="result_t1" scope="end" start="6"  length="2" />

 
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    				<div id="Operation_Table"> 

	      
<%
		if(retCode1.equals("000000")) {
		
%>
			<div class="title">
				<div id="title_zi">一证多名信息</div>
			</div>
		 	
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	      	<th >地市名称</th>   	
	      	<th >区县名称</th>    
	      	<th >客户名称</th>   
	      	<th >客户信息类型</th>   
	      	<th >数量</th>   
	      	<th >集团客户名称</th>   
	      </tr>
<%		
		 	for(int i=0;i<result2.length;i++){
%>
				<tr > 
	      	<td ><%=result2[i][0]%></td>   	
	      	<td ><%=result2[i][1]%></td>   
	      	<td ><%=result2[i][2]%></td>   
	      	<td ><%=result2[i][3]%></td>   
	      	<td ><%=result2[i][4]%></td>   
	      	<td ><%=result2[i][5]%></td>   
	      </tr>
<%		 	
		 	}
%>
		</table>
		
			<div class="title">
				<div id="title_zi">在网号码信息</div>
			</div>
			
			<table cellspacing="0" name="t1" id="t1">
				<tr align="center"> 
	      	<th >手机号码</th>   	
	      	<th >客户姓名</th>    
	      </tr>
<%
			for(int i=0;i<result_t1.length;i++){
%>	
				 <tr > 
	      	<td ><%=result_t1[i][0]%></td>   
	      	<td ><%=result_t1[i][1]%></td>   
	      </tr>
<%			
			}
%>	      
			</table>
<%
		}else {
%>
			 <table cellspacing="0">
			 	<tr height='25' align='center'><td colspan='1'>查询信息失败：<%=retCode1%>--<%=retMsg1%></td></tr>
			 </table>
<%
}
%>

	


	</BODY>
</HTML>

