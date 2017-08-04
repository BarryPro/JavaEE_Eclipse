<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String orgCode = (String)session.getAttribute("orgCode");
		 String regionCode = orgCode.substring(0,2);
%>
<wtc:service name="s7012Sel" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%@ include file="dispatch.jsp" %>
<ul>
<%
	if(retCode.equals("000000")){
  	if(result.length>0){
    	 for(int i=0;i<result.length;i++)
    	 {
    		 String tmp = getLink(result[i][5],result[i][6],result[i][1],session,request,result[i][2]);
    	 %>
       	<li><a href='javascript:L("<%=result[i][5]%>","<%=result[i][1]%>","<%=result[i][2]%>","<%=tmp%>","<%=result[i][3]%>")'><%=result[i][0]%>-->[<%=result[i][1]%>]<%=result[i][2]%></a></li>
    	 <%
    	 }
    }
  }
%>
</ul>
