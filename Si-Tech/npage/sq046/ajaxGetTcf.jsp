 
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String totalFee   =  (String)request.getParameter("totalFee");
		System.out.println("---mylog--------------totalFee--------------"+totalFee);
		String regionCode = (String)session.getAttribute("regCode");
		String chinaFee = "";
		
%>		
			<wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="retMessage1"  outnum="3" >
	      <wtc:param value="<%=totalFee%>"/>
	    </wtc:service>
      <wtc:array id="result1" scope="end" />
<%
		if(ret_code1.equals("0")||ret_code1.equals("000000")){
          chinaFee=result1[0][2];
     }
     
     System.out.println("---mylog--------------chinaFee--------------"+chinaFee);
%>

var response = new AJAXPacket();
response.data.add("chinaFee","<%=chinaFee%>");
core.ajax.receivePacket(response);