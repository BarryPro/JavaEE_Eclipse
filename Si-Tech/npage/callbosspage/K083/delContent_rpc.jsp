<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  //jiangbing 20091118 ���������滻
  String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
  String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
  String sqlMulKfCfm="";
	String opCode = "K083";
	String opName = "ɾ��Ԥ�����������";
	
	String msg_mod_content = (String) request.getParameter("msg_mod_content");
	String msg_mod_content_ids = (String) request.getParameter("msg_mod_content_ids");
	
	
	String[] str = (String[])msg_mod_content_ids.split(",");
	String[] sqlArr = new String[]{};
	List sqlList = new ArrayList();
	String delSql = "";
	for(int i = 0; i < str.length; i++){
		delSql = "delete from DMESSAGEMODELCONTENT_CON where msg_mod_content_id = :v1&&"+str[i];
		sqlList.add(delSql);
	}
	sqlArr = (String[])sqlList.toArray(new String[sqlList.size()]); 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%
			if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "ɾ��Ԥ�����������ʧ��!";
	%>
	rdShowMessageDialog("ɾ��Ԥ�����������ʧ�ܣ��������:<%=rows[0][0] %>");
	<%
	  	}
	%>
	rdShowMessageDialog("ɾ��Ԥ����������ݳɹ���");
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode %>");
	response.data.add("retMsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
