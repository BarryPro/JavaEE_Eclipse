<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%
	java.util.Properties p=new java.util.Properties();
	System.out.println("ssssssssssssssssssss1111111111111");
	FileInputStream fs=new FileInputStream(request.getRealPath("/npage/common/")+"/"+"serverip.ini");
	p.load(fs);
	String serverip=p.getProperty("serverip");
	String realip=p.getProperty("realip");
	fs.close();
	p=null;
	System.out.println("serverip="+serverip);
	System.out.println("realip="+realip);
%>
