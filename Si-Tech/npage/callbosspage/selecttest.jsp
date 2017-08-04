<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

    String orgCode ="00000000"; //(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String myParams="";
		String serialno="00000000000000000062";

	String sqlGetAffirm = "SELECT t1.belongno, t1.submitno, decode(to_char(t1.type),'0','质检结果通知','1','申诉','2','答复','3','确认'), " + 
	                      "t1.staffno, t1.evterno, to_char(t1.applydate,'yyyy-mm-dd hh24:mi:ss'), t1.title, t1.content, " + 
	                      "nvl(t2.recordernum,' '), nvl(t2.contentinsum,' '), nvl(t2.handleinfo,' ') " +
	                      "FROM dqcresultaffirm t1, dqcinfo t2 " +
	                     "WHERE t1.serialnum = t2.serialnum AND serialno = :serialno ";
	myParams = "serialno="+serialno;
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
		<wtc:param value="<%=sqlGetAffirm%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="affirmList" scope="end"/>