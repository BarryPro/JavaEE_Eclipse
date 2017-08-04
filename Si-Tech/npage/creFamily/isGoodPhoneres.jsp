<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
update:liutong@2008.09.05
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
System.out.println("---------------isGoodNo.jsp---------------------");
 
 
	   String selNumValue = request.getParameter("selNumValue");
     String countGoodSql = "SELECT count(*) FROM dgoodphoneres where phone_no= '"+selNumValue+"'";
     String regionCode = (String)session.getAttribute("regCode");
%>
				
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=countGoodSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="retAtr" scope="end"/>
<%
       String countGoodNo = "0";
       if(retAtr.length>0&&retAtr[0][0]!=null){
       	countGoodNo = retAtr[0][0];
       }
		System.out.println("----------------------countGoodNo----------------"+countGoodNo);
%>

var response = new AJAXPacket();
response.data.add("countGoodNo","<%=countGoodNo%>");
core.ajax.receivePacket(response);

