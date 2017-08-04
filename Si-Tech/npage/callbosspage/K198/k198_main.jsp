<%
	String login_no = (String)session.getAttribute("workNo");
	String phone_no = request.getParameter("phone_no");
	String caller_no = request.getParameter("caller_no");
	String called_no = request.getParameter("called_no");
	String audio_seq = request.getParameter("audio_seq");
%>

<script type="text/javascript">
	window.location.href = "http://10.110.0.206:6600/workflow/common/cspAuth.jsp"
	                       + "?login_no=<%=login_no%>"
	                       + "&phone_no=<%=phone_no%>"
	                       + "&caller_no=<%=caller_no%>"
	                       + "&called_no=<%=called_no%>"
	                       + "&audio_seq=<%=audio_seq%>";
</script>