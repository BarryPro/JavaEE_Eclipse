<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա��haoyy--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String offer_id    = WtcUtil.repNull(request.getParameter("offer_id"));
 
  String regionCode = (String)session.getAttribute("regCode");
  
	String retCode    = "";
	String retMsg     = "";
	
 String sql = " SELECT offer_comments FROM product_offer WHERE offer_id=:offer_id";
 
	String param1 = "offer_id="+offer_id;
	String offer_comments = "";
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql%>" />
		<wtc:param value="<%=param1%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		offer_comments = result_t[0][0];
	}
 
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���TlsPubSelCrm��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("offer_comments","<%=offer_comments%>");
core.ajax.receivePacket(response);
