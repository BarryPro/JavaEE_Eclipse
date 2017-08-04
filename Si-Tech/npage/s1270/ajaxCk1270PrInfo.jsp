
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.DateFormat"%> 
<%@ page import="java.text.SimpleDateFormat"%> 
<%

		String regionCode= (String)session.getAttribute("regCode");
	  String iOldOfferId = request.getParameter("iOldOfferId");
	  String iNewOfferId = request.getParameter("iNewOfferId");
	  String phone = request.getParameter("phone");
	  System.out.println(iOldOfferId+"--------------wanghyd");
	  System.out.println(iNewOfferId+"--------------wanghyd");
		
    DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd"); 
		String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String str="";
		Date d1 = dateformat.parse(dateStr);
		String date2="2012-01-01";
		Date d2 = dateformat.parse(date2);


 	String paraAray[] = new String[10];
	paraAray[0] = "";
	paraAray[1] = "";
	paraAray[2] = "";
	paraAray[3] = "";
	paraAray[4] = "";
	paraAray[5] = phone;
	paraAray[6] = "";
	paraAray[7] =iOldOfferId;
	paraAray[8] =iNewOfferId;
	paraAray[9] = "1";

%>
		<wtc:service name="sVpmnQry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="5">
				<wtc:param value="<%=paraAray[0]%>"/>
				<wtc:param value="<%=paraAray[1]%>"/>
				<wtc:param value="<%=paraAray[2]%>"/>
				<wtc:param value="<%=paraAray[3]%>"/>
				<wtc:param value="<%=paraAray[4]%>"/>
				<wtc:param value="<%=paraAray[5]%>"/>
				<wtc:param value="<%=paraAray[6]%>"/>
				<wtc:param value="<%=paraAray[7]%>"/>
				<wtc:param value="<%=paraAray[8]%>"/>
				<wtc:param value="<%=paraAray[9]%>"/>

		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
		if(retCode.equals("000000")) {
		    
				if(ret[0][2].equals("1")) {
							if(d1.before(d2)){
			         		str="nono";
		            }else {
		           	  str="1";
			         }

				}
			else {
				str="nono";
				}
	  }else {
		str="nono";
		}
	  System.out.println(str+"--------------wanghyd");
%>
	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("infos","<%=str%>");
	core.ajax.receivePacket(response);