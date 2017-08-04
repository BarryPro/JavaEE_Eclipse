<%@page contentType="text/html;charset=GB2312"%>
<%@ include file="callinclude.jsp"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="org.apache.log4j.Logger"%>

<%
	Logger log = Logger.getLogger(this.getClass());
	try {
		String url = request.getParameter("url");//要获取XML数据的jsp的URL
		Enumeration en = request.getParameterNames();
		String url_parameter = "?";
		for (int i = 0; en.hasMoreElements(); i++) {
			String parname = (String) en.nextElement();
			if (!parname.equals("url")) {
		if (i == 0) {
			url_parameter = url_parameter + parname + "="
			+ request.getParameter(parname);
		} else {
			url_parameter = url_parameter + "&" + parname + "="
			+ request.getParameter(parname);
		}
			}
			log.info(url_parameter);
		}
		String parTargUrl = targUrl + url + url_parameter;
		log.info(parTargUrl);
		URL CGIurl = new URL(parTargUrl);
		URLConnection c = CGIurl.openConnection();
		c.setDoOutput(true);
		c.setUseCaches(false);
		c.setRequestProperty("content-type",
		"application/x-www-form-urlencoded");
		DataOutputStream outs = new DataOutputStream(c
		.getOutputStream());
		outs.writeBytes("");
		outs.flush();
		outs.close();

		BufferedReader in = new BufferedReader(new InputStreamReader(c
		.getInputStream()));
		String aLine;
		String str_xml = "";
		while ((aLine = in.readLine()) != null) {
			if (!aLine.trim().equals("")) {
		str_xml = str_xml
				+ aLine.trim().replaceAll("\n", "").replaceAll(
				"\r", "");
			}
		}
		System.out.print(str_xml);
		out.print(str_xml);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

