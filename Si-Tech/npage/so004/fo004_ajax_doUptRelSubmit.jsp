<%
   /*
   * ����: ��˰��������Ϣ����ҳ��
�� * �汾: v1.0
�� * ����: 2013-08-30
�� * ����: wangjxc
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:2013/10/15      	�޸���:wangjxc      �޸�Ŀ��:��˰��ʶ��Ÿ�Ϊ�ֶ���д,������������Ϣ
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String orgCode  = (String)session.getAttribute("orgCode");
	String groupId  = (String)session.getAttribute("groupId");
	String orgId    = (String)session.getAttribute("orgId");

	String ParCustId = request.getParameter("ParCustId")==null ? "" : request.getParameter("ParCustId").toString();
	String LowCustId = request.getParameter("LowCustId")==null ? "" : request.getParameter("LowCustId").toString();
	String chn_CustId = request.getParameter("chn_CustId")==null ? "" : request.getParameter("chn_CustId").toString();
%>
<wtc:service name="so001RelUpt" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value=""/>
	      <wtc:param value="01"/>
	      <wtc:param value="o004"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=ParCustId%>"/>
		  <wtc:param value="<%=LowCustId%>"/>
		  <wtc:param value="<%=chn_CustId%>"/>   
</wtc:service>	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode %>");
response.data.add("retMsg","<%=retMsg %>");
core.ajax.receivePacket(response);