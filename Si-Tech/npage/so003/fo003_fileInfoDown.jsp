<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.io.*,java.net.*"%>
<%@ page import="com.sitech.crmpd.core.config.Configuration"%>
<%

   String source_name = (String)request.getParameter("source_name");
   	System.out.println("down_source_name======================="+source_name);
   String save_name= (String)request.getParameter("save_name");
   String filePath = request.getRealPath("/npage/tmp/");
  
		
    File file=new File(filePath,save_name);
		response.reset();
		response.setContentType("application/octet-stream"); 
    response.addHeader("Content-Length", "" + file.length()); 
		//filename应该是编码后的(utf-8) 
		response.setHeader("Content-Disposition", "attachment; filename=" + source_name);  
		OutputStream outputStream = response.getOutputStream(); 
		InputStream inputStream = new FileInputStream(file); 
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
