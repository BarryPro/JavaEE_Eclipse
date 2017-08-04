<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@page import="com.sitech.crmpd.core.xml.*"%>
<%@page import="com.sitech.crmpd.core.xml.impl.*"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\" ?><ROOT><OUT_DATA>");
	sb.append(xml);
	sb.append("</OUT_DATA></ROOT>");
	System.out.println("xml================"+sb.toString());
	Map map = new HashMap(13);
	IXMLReader xmlReader = null;
	Unmarshalling context = null;
	InputStream is = new ByteArrayInputStream(sb.toString().getBytes());
	try {
		xmlReader = StAXReaderFactory.getInstance().createReader(is);
		context = new Unmarshalling(xmlReader);
		context.parseXML(map);
	} catch (Exception e) {
		System.out.println("getMapBeanFromXmlÄÚ²¿´íÎó");
		e.printStackTrace();
	}
	mb = new com.sitech.crmpd.core.bean.MapBean(map);

%>
