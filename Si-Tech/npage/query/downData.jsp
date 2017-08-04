<%@ page import="com.sitech.boss.pub.util.*" %>
<%
String fileName = request.getParameter("fileName");
String DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");;
String FullFileName = DETAIL_PATH + fileName;
System.out.println("filename="+fileName);
System.out.println("FullFileName="+FullFileName);
response.setContentType("application/octet-stream");
response.setHeader("Content-Disposition","attachment;filename="+fileName);
/*
OutputStream outputStream = response.getOutputStream();
InputStream inputStream = new FileInputStream(FullFileName);
	byte[] buffer = new byte[1024];
	int i = -1;
	while ((i = inputStream.read(buffer)) != -1) {
		outputStream.write(buffer, 0, i);
	}
outputStream.flush();
outputStream.close();
inputStream.close();
outputStream = null;
*/

OutputStream outputStream = response.getOutputStream();

FileReader in = new FileReader(FullFileName);
BufferedReader read  = new BufferedReader(in);;
String s = "";
while ((s = read.readLine()) != null) {
			//取 @ 之前的数据
			String[] tmpRow = s.split("\\@",-1);
			s = tmpRow[0];
    	s = s.substring(s.indexOf("|")+1,s.length());		
			s = s.replaceAll("\\|", "   ");
			s = s + "\r\n";
			outputStream.write(s.getBytes());
}
outputStream.flush();
outputStream.close();
read.close();
in.close();
outputStream = null;
%>