<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>

<wtc:service name="s7012Sel" retcode="retCodeHK" routerKey="region" routerValue="<%=regionCode%>"  outnum="10" >
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="resultHotKey" scope="end" />

	<%@ include file="dispatch.jsp" %>
	
<script>
function doCtrl(pos)
{	
<%
if(retCodeHK.equals("000000")){
	if(resultHotKey.length>0){
		 %>
	  	 if("<%=resultHotKey[0][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[0][5]%>","<%=resultHotKey[0][1]%>","<%=resultHotKey[0][2]%>","<%=getLink(resultHotKey[0][5],resultHotKey[0][6],resultHotKey[0][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[0][3]%>");
	  	 }else if("<%=resultHotKey[1][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[1][5]%>","<%=resultHotKey[1][1]%>","<%=resultHotKey[1][2]%>","<%=getLink(resultHotKey[1][5],resultHotKey[1][6],resultHotKey[1][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[1][3]%>");
	  	 }else if("<%=resultHotKey[2][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[2][5]%>","<%=resultHotKey[2][1]%>","<%=resultHotKey[2][2]%>","<%=getLink(resultHotKey[2][5],resultHotKey[2][6],resultHotKey[2][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[2][3]%>");
	  	 }else if("<%=resultHotKey[3][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[3][5]%>","<%=resultHotKey[3][1]%>","<%=resultHotKey[3][2]%>","<%=getLink(resultHotKey[3][5],resultHotKey[3][6],resultHotKey[3][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[3][3]%>");
	  	 }else if("<%=resultHotKey[4][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[4][5]%>","<%=resultHotKey[4][1]%>","<%=resultHotKey[4][2]%>","<%=getLink(resultHotKey[4][5],resultHotKey[4][6],resultHotKey[4][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[4][3]%>");
	  	 }else if("<%=resultHotKey[5][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[5][5]%>","<%=resultHotKey[5][1]%>","<%=resultHotKey[5][2]%>","<%=getLink(resultHotKey[5][5],resultHotKey[5][6],resultHotKey[5][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[5][3]%>");
	  	 }else if("<%=resultHotKey[6][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[6][5]%>","<%=resultHotKey[6][1]%>","<%=resultHotKey[6][2]%>","<%=getLink(resultHotKey[6][5],resultHotKey[6][6],resultHotKey[6][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[6][3]%>");
	  	 }else if("<%=resultHotKey[7][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[7][5]%>","<%=resultHotKey[7][1]%>","<%=resultHotKey[7][2]%>","<%=getLink(resultHotKey[7][5],resultHotKey[7][6],resultHotKey[7][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[7][3]%>");
	  	 }else if("<%=resultHotKey[8][0]%>"==pos)
	  	 {
	  	 		openPage("<%=resultHotKey[8][5]%>","<%=resultHotKey[8][1]%>","<%=resultHotKey[8][2]%>","<%=getLink(resultHotKey[8][5],resultHotKey[8][6],resultHotKey[8][1],session,request,resultHotKey[0][2])%>","<%=resultHotKey[8][3]%>");
	  	 }
	  <%
	}
}
%>	
}	
</script>
