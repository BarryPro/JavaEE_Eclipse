<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 	
<script type="text/javascript" src="date.js"></script>
<%
	String ReqPageName = request.getParameter("ReqPageName");
	String errCode = request.getParameter("errCode");	 
	String errMsg = request.getParameter("errMsg");
%>
<script language="JavaScript">
rdShowMessageDialog("´íÎó´úÂë:"+"<%=errCode%>"+"´íÎóÐÅÏ¢:"+"<%=errMsg%>");
location="<%=ReqPageName%>.jsp";
</script>