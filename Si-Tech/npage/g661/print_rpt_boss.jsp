<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<html>
<body>
<form method=POST >

<%

//String url="http://"+request.getServerName().trim()+":28001/cgi-bin/PubWebPrnBoss.sh";
String url="http://10.110.0.100/cgi-bin/PubWebPrnBoss.sh"; //�����������һ��
//String url="http://10.110.0.100/cgi-bin/PubWebPrnBoss.sh"; //�����������һ��
Enumeration names = request.getParameterNames();
String value ;
String tmp = "";
while( names.hasMoreElements() ) {
	tmp = names.nextElement().toString();
	
	value = new String(request.getParameter(tmp).getBytes("GB2312"),"GBK"); /*ISO8859_1*/
	System.out.println("********"+tmp+"**********"+value);
	
	out.println("<input type='hidden' name="+tmp+" value=\""+value+"\" >");
/*
 *	û�п�������Ĳ�����ֵ�ж�������
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

%>
</form>
<script>
document.forms[0].action="<%=url%>";
document.forms[0].submit();
</script>
</body>
</html>
