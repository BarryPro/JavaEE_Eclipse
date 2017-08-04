<%
/********************
 version v2.0
开发商: si-tech
uodate:liutong@2008.09.02
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
/*
  Pwd1,Pwd2:密码
  Pwd1Type:密码1的类型；
  Pwd2Type：密码2的类型      
  
  show:明码；hid：密码
  */
   
		String retType = request.getParameter("retType");
		String Pwd1 = request.getParameter("Pwd1");
		String Pwd1Type = request.getParameter("Pwd1Type");
		String Pwd2 = request.getParameter("Pwd2");
		String Pwd2Type = request.getParameter("Pwd2Type");
		
		
		System.out.println("Pwd1==="+Pwd1);
		
		System.out.println("Pwd2==="+Pwd2);
		
		String retResult  = "false";
		String retCode="000000";
		String retMessage="密码校验成功！";   
      try
      {
          retResult = Encrypt.view_CheckPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type);
          
      }catch(Exception e){
			retCode="0001";
			retMessage="密码校验失败！";
      } 		
%>
			var response = new AJAXPacket();
			var retType = "<%=retType%>";
			var retMessage="<%=retMessage%>";
			var retCode= "<%=retCode%>";
			var retResult = "<%=retResult%>";
			
			response.data.add("retType",retType);
			response.data.add("retResult",retResult);
			response.data.add("retCode",retCode);
			response.data.add("retMessage",retMessage);
			core.ajax.receivePacket(response);