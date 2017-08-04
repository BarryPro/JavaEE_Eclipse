<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%        
	String offerId = request.getParameter("offerId");
	String regionCode=(String)session.getAttribute("regCode");
	String groupId=(String)session.getAttribute("groupId");
	String qrySql = "  select A.flag_code,A.flag_code_name FROM SOFFERFLAGCODE A  WHERE A.OFFER_ID = '"+offerId+"'  AND A.GROUP_ID IN(SELECT B.PARENT_GROUP_ID FROM DCHNGROUPINFO B  WHERE b.GROUP_ID= '"+groupId+"') ";
 %>	
 	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=qrySql%></wtc:sql>
 	  </wtc:pubselect>
 	  <wtc:array id="retarr" scope="end"/>  
 	  	
 	  <option value="0">--«Î—°‘Ò--</option>
 	  <%
 	     
 	  	for(int i=0;i<retarr.length;i++){
 	  %>
        <option value="<%=retarr[i][0]%>"><%=retarr[i][1]%></option> 	  		
 	  <%	
 	  	}
 	  %>
	