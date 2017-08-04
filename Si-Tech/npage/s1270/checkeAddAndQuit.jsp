<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>

<%
		String optype = WtcUtil.repNull(request.getParameter("optype"));/*1订购，2变更，3退订，4续订，9取消，Y延期*/
		String offerid = WtcUtil.repNull(request.getParameter("offerid"));
		String offerIddinggou = WtcUtil.repNull(request.getParameter("offerIddinggou"));
		String returncode =""; 
		String returnmsg ="";
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		/* liujian add workNo and password 2012-4-5 15:59:15 begin */
		String password = (String) session.getAttribute("password");
			String groupId=(String)session.getAttribute("groupId");//员工归属节点
		/* liujian add workNo and password 2012-4-5 15:59:15 end */
		String opCode = request.getParameter("opCode");
    String regionCode = (String)session.getAttribute("regCode");
		String current_timeNAME= new SimpleDateFormat("yyyyMMddhhmmssSSS", Locale.getDefault()).format(new java.util.Date());
		
%>				
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
			<wtc:service name="sProdNotice" routerKey="region" routerValue="<%=regionCode%>" outnum="11" retmsg="msg2" retcode="code2">
    		  <wtc:param value="<%=loginAccept%>"/>
    		  <wtc:param value="01"/>
    		  <wtc:param value="<%=opCode%>"/>
    		  <wtc:param value="<%=workNo%>"/>
    		  <wtc:param value="<%=password%>"/>
    		  <wtc:param value="<%=phoneNo%>"/>
					<wtc:param value=""/>
					<wtc:param value="<%=groupId%>"/>
					<wtc:param value="<%=offerid%>"/>
					<wtc:param value="<%=optype%>"/>

    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>
var result = [];
<%
if(code2.equals("000000")) {
    if (result_t.length > 0){
        for (int i = 0; i < result_t.length; i++){
           System.out.println(" zhouby " + i + " " + result_t[i][0] + " " + result_t[i][1]);
%>
            var tmp_<%=i%> = [];
            tmp_<%=i%>[0] = '<%=result_t[i][0]%>';
            tmp_<%=i%>[1] = '<%=result_t[i][1]%>';
            result[<%=i%>] = tmp_<%=i%>;
<%      }
    }
}
%>


var response = new AJAXPacket();
response.data.add("errorCode","<%=code2%>");
response.data.add("errorMsg","<%=msg2%>");
response.data.add("result", result);
response.data.add("offerIddinggou","<%=offerIddinggou%>");
core.ajax.receivePacket(response);
