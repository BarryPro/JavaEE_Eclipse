<%
String fileName = request.getParameter("fileName");
String sFilePath = request.getParameter("sFilePath");

String FullFileName = sFilePath+fileName;
System.out.println("filename="+fileName);
System.out.println("FullFileName="+FullFileName);
response.setContentType("application/octet-stream");
response.setHeader("Content-Disposition","attachment;filename="+fileName);

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

%>

