<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->����(ҵ���߼�)
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
//jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
	String newNodeId = WtcUtil.repNull(request.getParameter("newNodeId"));
	String newNodeName = WtcUtil.repNull(request.getParameter("newNodeName"));
	String parNodeId = WtcUtil.repNull(request.getParameter("parNodeId"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String isleaf = WtcUtil.repNull(request.getParameter("isleaf"));

	String workNo = (String)session.getAttribute("workNo");	// boss���Ŵ���
     String ip = request.getRemoteAddr();
     String sql_insert="insert into DCALLQUERYFUNCLIST values(:v1,:v2,:v3,:v4,'','','','','',:v5,'N','jscode')&&"+newNodeId+"^"+newNodeName+"^"+parNodeId+"^"+note+"^"+isleaf;
	String sql_log="insert into dbcalladm.wloginopr values(seq_wloginopr.nextval,'K098',sysdate,to_char(sysdate,'yyyymmdd'),:v1,'','',:v2,:v3,'I','','','')&&"+workNo+"^"+ip+"^������Ȩ��["+newNodeId+"]:����-->"+newNodeName+",����-->"+note;
	
	//��������
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_insert);
	sqlList.add(sql_log);
	sqlArr=(String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1); 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("newNodeId","<%=newNodeId%>");
response.data.add("newNodeName","<%=newNodeName%>");
response.data.add("parNodeId","<%=parNodeId%>");
response.data.add("note","<%=note%>");
response.data.add("isleaf","<%=isleaf%>");
core.ajax.receivePacket(response);
