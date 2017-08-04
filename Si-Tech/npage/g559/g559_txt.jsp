<%
	String return_page = "g559_1.jsp";
	/*String from = request.getParameter("from").trim();
	String to = request.getParameter("to").trim();
	String region_code = request.getParameter("s_in_ModeTypeCode");
	String dis_code = request.getParameter("s_in_CaseTypeCode");*/
	String from = "";
	String to = "";
	String region_code = request.getParameter("sregino_code");
	String dis_code = request.getParameter("sdis_code");
	String flag = request.getParameter("sflag");
	String syear = request.getParameter("syear");
	String smonth = request.getParameter("smonth");
	String year_month=syear+smonth;
	System.out.println("WWWWWWWWWWWWWWWWWWWWWWWWWWWWW flag is "+flag);
	if(dis_code.length()==4)
	{
	     dis_code = dis_code.substring(2);
	}
	String bak_dir = request.getRealPath("/npage/invoice_new")+"/";
	String filedownload ="";//即将下载的文件的相对路径
	if((flag=="0")||flag.equals("0")  )
	{
		System.out.println("AAAAAAAAAAAAAAAAAA 地市级明细");
		filedownload= bak_dir+"tt_"+region_code+"_"+year_month+"used"+".txt";
	}
	if((flag=="1") || flag.equals("1"))
	{
		System.out.println("AAAAAAAAAAAAAAAAAA qx级明细");
		filedownload= bak_dir+"tt_"+region_code+"_"+dis_code+"_"+year_month+"used"+".txt";
	}
	
	
	
    
	//String filedownload = bak_dir+"invoice"+region_code+dis_code+from+to+".txt";//即将下载的文件的相对路径
	
	System.out.println("AAAAAAAAAAAAAAAAAA filedownload:"+filedownload);
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
		   out.println("<SCRIPT LANGUAGE=\"JavaScript\">alert(\"您下载的文件不存在!\");window.location.href=\"g559_1.jsp\";</SCRIPT>");	
		   throw new Exception("文件不存在请联系管理员");		   		
		}
		response.setContentType("APPLICATION/OCTET-STREAM"); 
		response.setHeader("Content-Disposition", "attachment;filename=\"" + "invoice"+region_code+dis_code+from+to+".txt" + "\""); 
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