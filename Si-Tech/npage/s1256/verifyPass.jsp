<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String inputPass = request.getParameter("inputPass");
	String customPass = request.getParameter("customPass");
	String newPass = Encrypt.encrypt(inputPass);
	String info = "0";
	if(1==Encrypt.checkpwd2(customPass,newPass.trim())){
		info="1";
	}
%>

	var response = new AJAXPacket();
	response.data.add("backString","<%=info%>");
	response.data.add("errCode","0");
	response.data.add("errMsg","0");
	response.data.add("flag","99");
	core.ajax.receivePacket(response);
