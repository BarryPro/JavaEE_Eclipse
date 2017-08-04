<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%


//通知发送记录删除
//获取参数
String msg_id=request.getParameter("msg_id");
String str="DELETE Dcallercalloutphone WHERE caller_call_out_id =  :v1 ";
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);

%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=str%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=msg_id%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
