<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<html>
<body>
<form method=POST >

<%

//String url="http://"+request.getServerName().trim()+":11000/cgi-bin/PubWebPrnRpt.sh";
//String url="http://10.110.0.121:20000/cgi-bin/PubWebPrnRpt.sh"; //这个和生产上一样

String url="http://10.110.26.23:28001/cgi-bin/PubWebPrnRpt.sh";
//String url="http://"+request.getRemoteAddr().trim()+":11000/cgi-bin/PubWebPrnRpt.sh";
System.out.println("********liyangtest 11111111111**********");

Enumeration names = request.getParameterNames();
String value ;
String tmp = "";
while( names.hasMoreElements() ) {
	tmp = names.nextElement().toString();
	
	value = new String(request.getParameter(tmp).getBytes("GB2312"),"GBK"); /*ISO8859_1*/
	System.out.println("********"+tmp+"**********"+value);
	
	out.println("<input type='hidden' name="+tmp+" value=\""+value+"\" >");
/*
 *	没有考虑输入的参数的值有多个的情况
 */
/*
	value = request.getParameterValues(tmp);
	for (int i=0;i<value.length;i++){
	  out.println("<input type='hidden' name="+tmp+" value=\""+value+"\" >");
	}
*/
}

//response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);  
//response.setHeader("Location",url); 
System.out.println( request.getServerName() );
System.out.println(url);
System.out.println("********liyangtest 22222222**********"+url);

%>
</form>
<script>
document.forms[0].action="<%=url%>";
document.forms[0].submit();
</script>
</body>
</html>
