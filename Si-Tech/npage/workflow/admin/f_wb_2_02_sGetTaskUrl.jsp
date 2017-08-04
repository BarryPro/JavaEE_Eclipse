<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa@2014-3-12 16:32:10
 update hejwa@
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retCode     = "";
	String retMsg      = "";
	
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String condition1  = WtcUtil.repNull(request.getParameter("condition1"));
	String loginNo     = (String)session.getAttribute("workNo");
	String currPage    = "-1";
	String numsPerPage = "1";
	
try{
%>
    <wtc:service name="sGetTaskUrl" outnum="18" retmsg="msg" retcode="code"  >
		 <wtc:param value="<%=opCode%>"/>
		 <wtc:param value="<%=loginNo%>"/>
		 <wtc:param value="<%=currPage%>"/>
		 <wtc:param value="<%=numsPerPage%>"/>
		 <wtc:param value="<%=condition1%>"/>
		</wtc:service>
<%
	retCode = code;
	retMsg = msg;
	
}catch(Exception ex){
	retCode = "404040";
	retMsg  = "调用服务sGetTaskUrl出错，请联系管理员";
}
if("000000".equals(retCode)){
	out.print(retMsg);
}else{
	out.print(retCode+"："+retMsg);
}
%> 	
 