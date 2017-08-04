<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
		String loginNo=(String)session.getAttribute("workNo");    //工号 
		String workPwd = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");    
    String alterCodeProp = request.getParameter("alterCodeProp");
		String alterCode = request.getParameter("alterCode");
		String OprCode = request.getParameter("OprCode");
		String queryName = request.getParameter("queryName");
		String qryInfo = request.getParameter("qryInfo");
    String returnCode = "";
    String returnMsg = "";
    String flag = "";
    try{
        %>
       <wtc:service name="se539Check" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value=""/>
  			<wtc:param value=""/>
			  <wtc:param value="<%=OprCode%>"/>
			  <wtc:param value="<%=loginNo%>"/>
			  <wtc:param value="<%=workPwd%>"/>
			  <wtc:param value=""/>
			  <wtc:param value=""/>
			  <wtc:param value="<%=qryInfo%>"/>
			  <wtc:param value="<%=queryName%>"/>
			  <wtc:param value="<%=alterCode%>"/>
			  <wtc:param value="<%=alterCodeProp%>"/>
			  <wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="callData" scope="end" />	
        <%
        returnCode = retCode1;
        returnMsg = retMsg1;        
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnCode = "+returnCode);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnMsg  = "+returnMsg);
    }catch(Exception e){
        returnCode = "999999";
        returnMsg = "调用服务check_ISDNNO失败！";
        e.printStackTrace();
    }

%>
var response = new AJAXPacket();
var returnCode = "<%=returnCode%>";
var returnMessage = "<%=returnMsg%>";


response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMessage);
core.ajax.receivePacket(response);
