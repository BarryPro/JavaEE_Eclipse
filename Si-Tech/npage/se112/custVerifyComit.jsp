<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@ page import ="java.util.*" %>
<%
	String otherPhoneNo = request.getParameter("otherPhoneNo")==null?"":request.getParameter("otherPhoneNo");
	String meansId = request.getParameter("meansId")==null?"":request.getParameter("meansId");
	System.out.println("+++++++++++++++custVerifyComit+otherPhoneNo="+otherPhoneNo);
	System.out.println("+++++++++++++++custVerifyComit+meansId="+meansId);
%>
	<s:service name="WsMktVerifyCust" >
	    <s:param  name="ROOT">
		     <s:param  name="REQUEST_INFO">
				<s:param name="OTHER_PHONENO" type="string" value="<%=otherPhoneNo%>" />
				<s:param name="MEANS_ID" type="string" value="<%=meansId%>" />
		    </s:param>
	     </s:param>
	</s:service>
<%
String RETURN_CODE = (String) result.getValue("RETURN_CODE");
String RETURN_MSG = (String) result.getValue("RETURN_MSG");
String DETAIL_MSG = (String)result.getValue("DETAIL_MSG");
System.out.println("+++++++++++++++custVerifyComit+RETURN_CODE="+RETURN_CODE);
System.out.println("+++++++++++++++custVerifyComit+RETURN_MSG="+RETURN_MSG);
System.out.println("+++++++++++++++custVerifyComit+DETAIL_MSG="+DETAIL_MSG);
StringBuffer buf = new StringBuffer(80);
buf.append(RETURN_CODE.trim()).append("~").append(RETURN_MSG.trim()).append("~").append(DETAIL_MSG.trim());
out.print(buf.toString());
 %>



