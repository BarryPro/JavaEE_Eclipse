<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      	String regionCode= (String)session.getAttribute("regCode");
	      	String simtypesz="0";
	      	String phoneNo = request.getParameter("phoneNo");

       		//增加网络优先客户sim类型判断20111213 wanghyd-----start
       	  String[] inParamsss = new String[2];
					inParamsss[0] = "select count(0) from dcustres where  resource_code in ('1','0','h','p','d','k','f') and  phone_no=:phoness";
					inParamsss[1] = "phoness="+phoneNo;
					
       	   	 %>
       	  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1dd" retmsg="retMsg1dd" outnum="1">			
					<wtc:param value="<%=inParamsss[0]%>"/>
					<wtc:param value="<%=inParamsss[1]%>"/>	
					</wtc:service>	
       	   <wtc:array id="simstypes" scope="end" />
       	   	 <%
       	   if(retCode1dd.equals("0") || retCode1dd.equals("000000")) {
       	   	if(simstypes.length>0) {
       	   		simtypesz=simstypes[0][0];
       	   	}
       	   	
       	    }

       	   %>

	var response = new AJAXPacket();

	response.data.add("simtypesz","<%=simtypesz%>");
	core.ajax.receivePacket(response);