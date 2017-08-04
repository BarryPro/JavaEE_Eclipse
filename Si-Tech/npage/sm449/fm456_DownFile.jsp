<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String j_fileName = request.getParameter("j_fileName").trim();
	String opCode  = request.getParameter("opCode");
	String opName  = request.getParameter("opName");
	
	
  String bak_dir = request.getRealPath("/npage/tmp")+"/";
  
	String filedownload = bak_dir+j_fileName;//即将下载的文件的相对路径
	System.out.println("-------hejwa-------filedownload------------------>"+filedownload);
	

try{
			File f = new File(filedownload);	
	
			if(!f.exists()){
	%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("文件不存在");
		window.location.href="fm456_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";			
	</SCRIPT>
	<%			
			}	
	
			InputStream fis = new FileInputStream(filedownload);
			byte[] buffer = new byte[fis.available()];
      fis.read(buffer);
      fis.close();
      response.reset();
			OutputStream toClient = response.getOutputStream();
			response.setHeader("Content-Disposition", "attachment;filename=\"" +j_fileName + "\""); 
			response.addHeader("Content-Length", "" + f.length());
      toClient.write(buffer);
      toClient.flush();
      toClient.close();
  
}catch(Exception e){
    		e.printStackTrace();

%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("文件下载错误");
		window.location.href="fm456_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";			
	</SCRIPT>
<%		

    }

%>
	