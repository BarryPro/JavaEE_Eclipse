<%
  /*
   * ����: ���¿ͷ���½����
�� * �汾: 1.0.0
�� * ����: 2009/04/11
�� * ����: fangyuan
�� * ��Ȩ: sitech
	 *update: by yinzx 20091123
	 *��������ҳ���Ƿ�ʹ�� �������滻�·����û��to_char
��*/
%>
<%
	String opCode = "K099";
	String opName = "��ѯ�Ǽ�����״̬";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	//System.out.println("############################################");
	
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	String Sql ="select to_char(round(sysdate-t.login_date)),t.remarks from dlogincfg t where t.login_no=:login_no";
	myParams = "login_no="+login_no ;

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=Sql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("everyDay","<%=rows[0][0]%>");
response.data.add("remarks","<%=rows[0][1]%>");
core.ajax.receivePacket(response);





