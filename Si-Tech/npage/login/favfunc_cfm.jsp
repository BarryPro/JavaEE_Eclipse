<%
  /*
   * ����: ����ӪҵԱ���ù���
�� * �汾: v1.0
�� * ����: 2008��4��13��
�� * ����: wuln
�� * ��Ȩ: sitech
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
  //�������
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String loginNo = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	
  String function_code=request.getParameter("function_code")==null?"2609":request.getParameter("function_code");   
  String op_type   =request.getParameter("op_type")==null?"i":request.getParameter("op_type");   
  String selCls   =request.getParameter("selCls")==null?"":request.getParameter("selCls");   
  
  
%>

<wtc:service name="sIndexFuncCfm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=function_code%>"/>
	<wtc:param value="<%=op_type%>"/>
	<wtc:param value="<%=selCls%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	
<%
	String detailMsg = "";
	if(retCode.equals("000000")){
		detailMsg = "���볣�ù��ܳɹ�";
	}else{
		detailMsg = retMsg;
	}
%>
var retCode   = "<%=retCode%>";
var retMsg    = "<%=retMsg%>";
var detailMsg = "<%=detailMsg%>";


var response = new AJAXPacket();
response.data.add("retMsg",retMsg );
response.data.add("retCode",detailMsg );
response.data.add("retCode",retCode);