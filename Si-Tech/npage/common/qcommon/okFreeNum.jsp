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
	String retType=request.getParameter("retType");
	String account=request.getParameter("account");
	String city_id=request.getParameter("city_id");
	String branch_no=request.getParameter("branch_no");
	String work_form_id=request.getParameter("work_form_id");
	String staff_id=request.getParameter("staff_id");
	String conn_flag=request.getParameter("conn_flag");
	String lastaccount=request.getParameter("lastaccount");
	String prod_id=request.getParameter("prod_id");
	String svc_inst_id=request.getParameter("svc_inst_id");
	System.out.println("queding");
%>
<wtc:service name="RBM_kd_xh02" outnum="0">
	<wtc:param value="<%=account%>"/><%System.out.println("account == "+account);%>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=city_id%>"/><%System.out.println("city_id == "+city_id);%>
	<wtc:param value="1"/><%System.out.println("1 == "+1);%>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=work_form_id%>"/><%System.out.println("work_form_id == "+work_form_id);%>
	<wtc:param value="<%=conn_flag%>"/><%System.out.println("conn_flag == "+conn_flag);%>
	<wtc:param value="<%=lastaccount%>"/><%System.out.println("lastaccount == "+lastaccount);%>
	<wtc:param value="<%=branch_no%>"/><%System.out.println("branch_no == "+branch_no);%>
	<wtc:param value="<%=prod_id%>"/><%System.out.println("prod_id == "+prod_id);%>
	<wtc:param value="<%=svc_inst_id%>"/><%System.out.println("svc_inst_id == "+svc_inst_id);%>
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
}
%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%= errCode_1 %>");
response.data.add("retMessage","<%= errMessage_1 %>");
response.data.add("mulit_list","");
core.ajax.receivePacket(response);
