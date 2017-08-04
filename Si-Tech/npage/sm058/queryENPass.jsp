<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanghyd@2013-10-10 获取加密后密码
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
		String passTrans=WtcUtil.repNull(request.getParameter("jiamiqianmima"));
		String passFromPage="";
	  if(!passTrans.equals("")){
			 passFromPage=Encrypt.encrypt(passTrans);	
		}


%>
var response = new AJAXPacket();
response.data.add("jiamimima","<%=passFromPage%>");
core.ajax.receivePacket(response);
