<%
    /*************************************
    * ��  ��: ����Ϊ�ͷ����ſ���ǿ��Ȩ�޵�����
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2013/9/6 
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String opType = request.getParameter("opType");//���� 0-�� 1-��
		String opFlag = request.getParameter("opFlag");//������ʶ q:��ѯ����
		String regCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String v_note = "";
		if("".equals(opType)){
			v_note = "[��ѯ]";
		}else{
			if("0".equals(opType)){
				v_note = "[��]";
			}else{
				v_note = "[��]";
			}
		}
		String opNote = workNo+"������"+opName+v_note+"����";
		String ipAddr = (String)session.getAttribute("ipAddr");
		String bakOpType = "";
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
    
	<wtc:service name="sm162Cfm" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=opType%>"/>
	  <wtc:param value="1246"/>
	  <wtc:param value="<%=opNote%>"/>
	  <wtc:param value="<%=ipAddr%>"/>
	  <wtc:param value="<%=opFlag%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%
  if("000000".equals(retCode)){
    if(result1.length>0){
      bakOpType = result1[0][0];
    }
  }
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("bakOpType","<%=bakOpType%>");
core.ajax.receivePacket(response);
