<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String regionCode = (String)session.getAttribute("regCode");

	
	String sql  = "select to_char(cust_id) from dcustmsg  where phone_no = '"+phoneNo+"'";
	String custId = "";
	System.out.println("---------sql---------"+sql);
	%>
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	<%
		if(result_t.length>0&&result_t[0][0]!=null){
			custId = "custid"+result_t[0][0];
		}
 	System.out.println("------------custId-----------"+custId);
%>

var response = new AJAXPacket();
response.data.add("custId","<%=custId%>");
core.ajax.receivePacket(response);
 