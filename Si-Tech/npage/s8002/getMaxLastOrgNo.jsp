<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-26 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	//System.out.println("***********************************************");
	String regionCode =  (String)session.getAttribute("regCode");
	
	String sq2 = "select max(substr(org_code,8,2)) from dLoginMsg where login_flag = '" + loginFlag + "'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sq2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="noArr" scope="end" />	
<%	
	String[][] nott = noArr;
	if(noArr!=null&&noArr.length>0){
		if(nott[0][0].trim().equals("")){
			nott[0][0]="00";
		}
	}
%>
var response = new AJAXPacket();
response.data.add("backString","<%=nott[0][0]%>");
response.data.add("flag","11");
core.ajax.receivePacket(response);
                                                                                                                                                                                                          