<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String regionCode = (String)session.getAttribute("regCode");
	

	
	String sql  = "select to_char(cust_id) from dcustmsg  where phone_no = '"+phoneNo+"'";
	
	System.out.println("---------sql---------"+sql);
	if(phoneNo.indexOf("custid")==-1){
	%>
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	<%
		if(result_t.length>0&&result_t[0][0]!=null){
			phoneNo = "custid"+result_t[0][0];
		}
		
		System.out.println("--------------------phoneNo----------"+phoneNo);
	}
	
	System.out.println("--------------ajaxSetSession.jsp--------------phoneNo---------"+phoneNo);
	System.out.println("--------------ajaxSetSession.jsp--------------flag------------"+flag);
	
	java.util.HashMap hm1 = (java.util.HashMap)session.getAttribute("phoneKfCheck");
	
	hm1.put(phoneNo,flag);
	
	System.out.println("--------------hm1-------------"+hm1);
	session.setAttribute("phoneKfCheck",hm1);
	
		session.setAttribute("phone_kf_check",phoneNo);
	 	session.setAttribute("phone_kf_flag",flag);
 	
%>

var response = new AJAXPacket();
response.data.add("kfFlagOc","111");
core.ajax.receivePacket(response);
 