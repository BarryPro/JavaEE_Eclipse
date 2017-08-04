<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%


//通知发送记录删除
//获取参数
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String msg_id=request.getParameter("msg_id");
String str="DELETE scalloutfailreson WHERE failure_code =  :v1 ";

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

