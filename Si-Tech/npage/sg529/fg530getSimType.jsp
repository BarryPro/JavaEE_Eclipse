<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      	String regionCode= (String)session.getAttribute("regCode");
	      	String card_no = request.getParameter("card_no");
	      	String simtypesz ="flag";	
					
					String[] inParamsdd = new String[2];
					inParamsdd[0] = "select res_code from dblkcardres  where card_no =:simtype_code";
					inParamsdd[1] = "simtype_code="+card_no;
					
					%>
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
					<wtc:param value="<%=inParamsdd[0]%>"/>
					<wtc:param value="<%=inParamsdd[1]%>"/>	
					</wtc:service>	
       	   <wtc:array id="simskehu" scope="end" />

       	   	 <%

       	   	if(simskehu.length>0) {
       	   	simtypesz=simskehu[0][0];
       	   	}

       	   %>

	var response = new AJAXPacket();

	response.data.add("simtypesz","<%=simtypesz%>");
	core.ajax.receivePacket(response);