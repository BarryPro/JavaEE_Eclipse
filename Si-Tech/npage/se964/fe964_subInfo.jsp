<%
    /*************************************
    * ��  ��: ��ȡ����ѡ��SIM�� e964
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
    **************************************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String iPhoneNo = WtcUtil.repStr(request.getParameter("qryPhoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
  String simCode = WtcUtil.repStr(request.getParameter("simCodeBack"), "");/*sim������*/
  String cardNo = WtcUtil.repStr(request.getParameter("cardNo"), "");/*�տ�����*/
  String idNo = WtcUtil.repStr(request.getParameter("idNo"), "");
  String simType = WtcUtil.repStr(request.getParameter("simType"), "");/*sim������*/
  String prePayFee = WtcUtil.repStr(request.getParameter("prePayFee"), "");/*Ԥ���*/
  String simPayFee = WtcUtil.repStr(request.getParameter("simPayFee"), "");/*sim����*/
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String groupId = (String)session.getAttribute("groupId");
	String regCode = (String)session.getAttribute("regCode");
	String ipAdd = (String)session.getAttribute("ipAddr");
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sE964Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="1"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=ipAdd%>"/>
		<wtc:param value="<%=simCode%>"/>
		<wtc:param value="<%=cardNo%>"/>
		<wtc:param value="<%=idNo%>"/>
		<wtc:param value="<%=simType%>"/>
		<wtc:param value="<%=prePayFee%>"/>
		<wtc:param value="<%=simPayFee%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 if(!"000000".equals(retCode)){
%>
  <script>
    rdShowMessageDialog("������룺<%=retCode%><br>������Ϣ��<%=retMsg%>",0);
    window.location.href="fe964_main.jsp?opCode=e964&opName=��ȡ����ѡ��SIM��";
  </script>
<%
 }else{
%>
  <script>
     rdShowMessageDialog("�ύ�ɹ���",2);
     window.location.href="fe964_main.jsp?opCode=e964&opName=��ȡ����ѡ��SIM��";
  </script>
<%
 }
%>

	    