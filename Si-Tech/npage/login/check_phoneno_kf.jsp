<%@ page import="java.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workNo = (String)session.getAttribute("workNo");
    String phone_no  = request.getParameter("phone_no").trim();
    String contactId = request.getParameter("parContactId");
    String caller=request.getParameter("caller");
    if(caller==null){caller="";}
    String called=request.getParameter("called");
 		if(called==null){called="";}
     
     
    String ret_code = "000000";
    //String sqlStr = "select to_char(count(1))  as rowcount from dcustmsg where phone_no='"+phone_no+"' and substr(run_code,2,1)<'a' ";
    String sqlStr = "select id_no from dcustmsg where phone_no='"+phone_no+"' and substr(run_code,2,1)<'a' ";
    String selfIp = request.getRemoteAddr();
%>
<wtc:service name="sPubSelect"  routerKey="phone" routerValue="<%=phone_no%>" outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="rows"  scope="end"/>
<%
	//用户不存在
	if(rows==null||rows.length==0){
		ret_code = "999999";
	}
	//用户存在
  else
  {
  	ContactInfo contactInfo = new ContactInfo();
    contactInfo.setPhoneno(phone_no);
    Map map = (Map)session.getAttribute("contactInfoMap");
    map.put(phone_no, contactInfo);
    String url="/npage/contact/InitCntt.jsp?phone_no="+phone_no;
%>
  <jsp:include page="/npage/contact/GetCnttStatus.jsp" flush="true" />
  <jsp:include page="<%=url%>" flush="true" />
<%     	
  }
	out.println(ret_code);
%>
