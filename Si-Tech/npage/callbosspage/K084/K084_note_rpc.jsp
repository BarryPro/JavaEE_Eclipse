<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

	  String description       = WtcUtil.repNull(request.getParameter("description"));
	  String send_login_no     = WtcUtil.repNull(request.getParameter("send_login_no"));
	  String receive_login_no  = WtcUtil.repNull(request.getParameter("receive_login_no"));
	  String cityid            = WtcUtil.repNull(request.getParameter("cityid"));
	  String content           = WtcUtil.repNull(request.getParameter("content"));
	  String msg_type          = WtcUtil.repNull(request.getParameter("msg_type"));//消息类型：0为一般通知，1为请求通知
	  String title             = WtcUtil.repNull(request.getParameter("title"));
    String bak               = WtcUtil.repNull(request.getParameter("bak"));
	  
	  String[] receive_login_no_arr = new String[]{};
	  if(null!=receive_login_no&&!("".equals(receive_login_no))){
	  	receive_login_no_arr = receive_login_no.split(",");
	  }
	  
	  
	  for(int i=0;i<receive_login_no_arr.length;i++){
  
%>
	     <wtc:service name="sK083Note" outnum="2">
	       <wtc:param value="<%=description%>" />
	       <wtc:param value="<%=send_login_no%>" />
	       <wtc:param value="<%=receive_login_no_arr[i]%>" />
	       <wtc:param value="<%=cityid%>" />
	       <wtc:param value="<%=content%>"/>
	       <wtc:param value="<%=msg_type%>"/>
         <wtc:param value="<%=title%>"/>
	       <wtc:param value="<%=bak%>"/>
	     </wtc:service>

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
<%}%>
