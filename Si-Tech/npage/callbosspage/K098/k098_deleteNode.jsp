<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->ɾ��
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
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String par_Id= WtcUtil.repNull(request.getParameter("par_Id"));
	String workNo = (String)session.getAttribute("workNo");	// boss���Ŵ���
     String ip = request.getRemoteAddr();	

	//����ɾ���ýڵ㼰���ӽڵ�
	//String sql_del="delete from DCALLQUERYFUNCLIST t where t.funcid='"+nodeId+"' or t.parfuncid='"+nodeId+"'";
	String sql_del="update DCALLQUERYFUNCLIST t set t.is_del='Y' where t.funcid=:v1 or t.parfuncid=:v2&&"+nodeId+"^"+nodeId;
	String sql_log="insert into dbcalladm.wloginopr values(seq_wloginopr.nextval,'K098',sysdate,to_char(sysdate,'yyyymmdd'),:v1,'','',:v2,:v3,'I','','','')&&"+workNo+"^"+ip+"^ɾ��Ȩ��["+nodeId+"]����������Ȩ��:��Ȩ������-->"+nodeName;
	//��������
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_del);
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
response.data.add("par_Id","<%=par_Id%>");
core.ajax.receivePacket(response);
