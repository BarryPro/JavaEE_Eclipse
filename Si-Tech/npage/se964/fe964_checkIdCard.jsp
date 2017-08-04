<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/04/20 liangyl 关于开发网上营业厅号码销售能力及信息公告栏的需要
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%
		String cust_name = request.getParameter("cust_name");
		String id_iccid = request.getParameter("id_iccid");
		String[] inParas2 = new String[2];
		inParas2[0]="select count(1) from dwebopenphonemsg t where t.cust_name =:cust_name and t.id_iccid =:id_iccid and t.op_code = 'g040'";
		inParas2[1]="cust_name="+cust_name+",id_iccid="+id_iccid;
%>
<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>" />
	<wtc:param value="<%=inParas2[1]%>" />
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
	
	String return_code = retCode1;
	String return_msg = retMsg1;
	String s_result = result1[0][0];
%>
var response = new AJAXPacket(); 
var return_code = "<%=return_code%>";
var return_msg = "<%=return_msg%>"; 
var s_result = "<%=s_result%>";

response.data.add("return_code",return_code);
response.data.add("return_msg",return_msg);
response.data.add("s_result",s_result);
core.ajax.receivePacket(response);
