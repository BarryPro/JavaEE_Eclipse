<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%

		String iLoginAcceptnew = getMaxAccept();		

%>
var response = new AJAXPacket();
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("iLoginAcceptnew","<%=iLoginAcceptnew%>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         