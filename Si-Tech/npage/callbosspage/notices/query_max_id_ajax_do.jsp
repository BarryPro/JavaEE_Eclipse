<%@ page contentType="text/html; charset=GBK"%><%@ include file="/npage/callbosspage/notices/head.jsp"%><%
/**设置要显示的tab数组的个数.[0]名称[1]链接.**/
/*直接跳转到公告类型数修改页面.*/
String urlString = "http://"+serverIpPort+serverCont+"/npage/notices/query_max_id_ajax_do.jsp?login_no="+userId;
/*ajax不可以轮询.所以要用本地链接.访问.直接访问url将结果打印.*/
java.net.URLConnection connection = null;
try {
	java.net.URL url = new java.net.URL(urlString);
	connection = url.openConnection();
} catch (java.net.MalformedURLException e) {
	e.printStackTrace();
} catch (java.io.IOException e) {
	e.printStackTrace();
}
java.io.BufferedReader in = null;
try {
	in = new java.io.BufferedReader(new java.io.InputStreamReader(connection
			.getInputStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null) {
		out.println(inputLine);/*将结果打印.*/
	}
} catch (java.io.IOException e) {
	//e.printStackTrace();
}
%>