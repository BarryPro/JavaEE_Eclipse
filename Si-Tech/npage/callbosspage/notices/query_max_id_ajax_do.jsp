<%@ page contentType="text/html; charset=GBK"%><%@ include file="/npage/callbosspage/notices/head.jsp"%><%
/**����Ҫ��ʾ��tab����ĸ���.[0]����[1]����.**/
/*ֱ����ת�������������޸�ҳ��.*/
String urlString = "http://"+serverIpPort+serverCont+"/npage/notices/query_max_id_ajax_do.jsp?login_no="+userId;
/*ajax��������ѯ.����Ҫ�ñ�������.����.ֱ�ӷ���url�������ӡ.*/
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
		out.println(inputLine);/*�������ӡ.*/
	}
} catch (java.io.IOException e) {
	//e.printStackTrace();
}
%>