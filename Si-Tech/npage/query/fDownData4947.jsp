<%
String fileName = request.getParameter("fileName");
String FullFileName = "../../QueryData4947/" + fileName;
System.out.println("filename="+fileName);
System.out.println("FullFileName="+FullFileName);
response.setContentType("application/octet-stream");
response.setHeader("Content-Disposition","attachment;filename="+fileName);
%>
<jsp:include page="<%=FullFileName%>" flush="true"/>>