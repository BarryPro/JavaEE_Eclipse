<%
	String return_page = "g053_4.jsp";
	String from = request.getParameter("from").trim();
	String to = request.getParameter("to").trim();
	String region_code = request.getParameter("region_code");
	String bank_code = request.getParameter("bank_code");
    String bak_dir = request.getRealPath("/npage/qd_invoice")+"/";
	String filedownload = bak_dir+"sqinvoice"+region_code+bank_code+from+to+".txt";//即将下载的文件的相对路径
System.out.println("filedownload:"+filedownload);
	File f = new File(filedownload);
    OutputStream output = null;
	FileInputStream fis = null;
    BufferedInputStream bis=null;
    BufferedOutputStream osb=null;
    try
    {
		if(!f.exists())
		{
		   response.setContentType("text/plain;charset=GBK");	
		   out.println("<SCRIPT LANGUAGE=\"JavaScript\">alert(\"您下载的文件不存在!\");window.location.href=\"g053_4.jsp\";</SCRIPT>");	
		   throw new Exception("文件不存在请联系管理员");		   		
		}
		response.setContentType("APPLICATION/OCTET-STREAM"); 
		response.setHeader("Content-Disposition", "attachment;filename=\"" + "sqinvoice"+region_code+bank_code+from+to+".txt" + "\""); 
		//新建File对象,同样你可以选择你自己的InputStream
		output = response.getOutputStream();
		osb = new BufferedOutputStream(output);
		fis = new FileInputStream(f);
		bis = new BufferedInputStream(fis);
		//设置每次写入缓存大小
		byte[] b = new byte[500];
		//把输出流写入客户端
		int i = 0; 
		try{
		    while((i = bis.read(b)) > 0){
		        osb.write(b, 0, i);
		    }
		}catch(IOException e){
		   osb = null;
		   output = null;
		   out.clear();
           out = pageContext.pushBody();
		   return;
		}
		osb.flush();
    }
    catch(Exception e)
    {
        e.printStackTrace();
        return;
    }
   	finally{   	
		if(bis!= null)
		{
			bis.close();
			bis=null;
		}
		if(fis != null){
		    fis.close();
		    fis = null;
		}
		if(osb!=null)
		{
			osb.close();
			osb = null;
		}
		if(output != null){
		    output.close();
		    output = null;
		}
	}
   out.clear();
   out = pageContext.pushBody();

%>
	
</body></html>