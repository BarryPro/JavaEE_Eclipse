<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
 /**
 * 查询宽带开户存储的免填单内容。
 */ 
 
 String regionCode   = (String)session.getAttribute("regCode");
 String workNo       = (String)session.getAttribute("workNo");
 String login_accept = request.getParameter("login_accept");
 String opCode       = request.getParameter("opCode");
 String printInfoRet = "";
 
%>
  <wtc:service name="sPrintSaveOutSv" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=login_accept%>" />
		<wtc:param value="<%=opCode%>" />		
		<wtc:param value="<%=workNo%>" />			
	</wtc:service>
	<wtc:array id="result_t2" scope="end"/>	
<%
	if(result_t2.length>0){
		printInfoRet += result_t2[0][3]+"#";//cust_info
		printInfoRet += result_t2[0][4]+"#";//opr_info
		printInfoRet += result_t2[0][5].trim()+"#";//note_info1
		printInfoRet += result_t2[0][6].trim()+"#";//note_info2
		printInfoRet += result_t2[0][7].trim()+"#";//note_info3
		printInfoRet += result_t2[0][8].trim()+"#";//note_info4
	}
	out.print(printInfoRet);
%>