<%
  /*
   * ����: �ͷź���
�� * �汾: 2.0
�� * ����: 2007-07-05 16:12
�� * ����: zhanghb
�� * ��Ȩ: sitech
��*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String errCode_1="444444";    //�Է���080002
   	String errMessage_1="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";   
  	String retType=request.getParameter("retType")==null?"":request.getParameter("retType");
  	String account=request.getParameter("account");
  	String city_id=request.getParameter("city_id");
  	String conn_flag=request.getParameter("conn_flag");
  	String svc_inst_id=request.getParameter("svc_inst_id");
  	String work_form_id=request.getParameter("work_form_id");
%>
<wtc:service name="kd0102" outnum="0">
	<wtc:param value="<%=account%>"/>
	<wtc:param value="<%= city_id %>"/>
	<wtc:param value="<%=work_form_id%>"/>
	<wtc:param value="<%=svc_inst_id%>"/>
	<wtc:param value="<%=conn_flag%>"/>
</wtc:service>
<%if(retCode.equals("000000"))
{
	errCode_1="000000";
	errMessage_1=retMsg;
}
else
{
	errCode_1=retCode;
	errMessage_1=retMsg;
}%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%= errCode_1 %>");
response.data.add("retMessage","<%= errMessage_1 %>");
response.data.add("mulit_list","");
core.ajax.receivePacket(response);
