<%
  /*
   * ����: ѡ���ʼ칤��Ⱥ�����ӽڵ���Ϣ��ȡ
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����:
�� * ��Ȩ: sitech
   *
 ��*/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String nodeId = request.getParameter("nodeId");
	String sqlStr = "SELECT check_group_id,parent_group_id,group_name,is_leaf FROM DQCCHECKGROUP WHERE IS_DEL='N' AND parent_group_id = :nodeId ORDER BY check_group_id";
	myParams = "nodeId="+nodeId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >
var worknos = new Array();
<%for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%}%>
	worknos[<%=i%>] = tmpArr;
<%}%>
var response = new AJAXPacket();
response.data.add("worknos",worknos);
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);

</wtc:array>

