<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
		response.setHeader("Pragma","No-Cache"); 
    response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 	
		String opCode = "1302";
		String opName="账号缴费";
		String bankcode = request.getParameter("bankcode").trim();
    String checkno = request.getParameter("checkno").trim();
    String sqlStr =  "select to_char(CHECK_PREPAY) from dcheckprepay where bank_code = '?' and check_no='?'";
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
%>
		<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		<wtc:param value="<%=bankcode%>"/>
		<wtc:param value="<%=checkno%>"/>	
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
		if(result==null||result.length==0){
%>

	<SCRIPT LANGUAGE="JavaScript">
	<!--
	 		window.close();
	//-->
	</SCRIPT>
<%
   }else{
%>
 <SCRIPT LANGUAGE="JavaScript">
 <!--
 		window.returnValue="<%=result[0][0].trim()%>";	
		window.close(); 
 //-->
 </SCRIPT>
<%
	}
%>
 