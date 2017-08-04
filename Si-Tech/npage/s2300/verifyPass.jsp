 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String inputPass = request.getParameter("inputPass");
	String customPass = request.getParameter("customPass");
	
   inputPass = Encrypt.encrypt(inputPass);
   inputPass=inputPass.trim();
      
	//String newPass = Encrypt.encrypt(inputPass);
	String info = "0";
	//if(newPass.trim().equals(customPass))
	if (Encrypt.checkpwd2(customPass,inputPass) == 1){
		info="1";
	}

%>
var response = new AJAXPacket();
response.data.add("backString","<%=info%>");
response.data.add("errCode","0");
response.data.add("errMsg","0");
response.data.add("flag","99");
core.ajax.receivePacket(response);
