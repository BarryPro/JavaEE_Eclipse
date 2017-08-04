<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	 String workNo = request.getParameter("workNo");
	 System.out.println("workNo="+workNo);
%>
<wtc:utype name="sDCustOrder" id="retVal"  scope="end">
      <wtc:uparam value="<%=workNo%>" type="String"/>
</wtc:utype>
<%
System.out.println("end="+workNo);
%>