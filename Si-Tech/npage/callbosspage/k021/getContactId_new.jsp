<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

	<wtc:service name="sGetConId_new" outnum="1">

		<wtc:param value="<%="500"%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	var temparr = new Array();	
	<%
	  if(rows!=null&&rows[0]!=null){
	    
	    for(int i=0;i<rows.length;i++){
	       
	    %>
	      temparr[<%=i%>] = '<%=rows[i][0]%>'; 

	    <%
	    }
	  }
	%>

	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	response.data.add("contactId",temparr);
	response.data.add("contactMonth","");
	core.ajax.receivePacket(response);
