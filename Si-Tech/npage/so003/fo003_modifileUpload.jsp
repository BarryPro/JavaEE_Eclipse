<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.sitech.crmpd.core.config.Configuration"%>

<html>
<body bgcolor="white">
<div id="excelTable" style="display:none">
<%
  String upOrDeFlag = (String)request.getParameter("upOrDeFlag");//上传或删除标志U：上传 D：删除
  String fileName = (String)request.getParameter("fileName");
  String source_name = (String)request.getParameter("source_name");
  System.out.println("source_name=========================="+source_name);
  System.out.println("fileName=========================="+fileName);
    //上传到wl路径
    String webpath =request.getRealPath("/npage/tmp/");
  System.out.println("webpath=========================="+webpath);
	String sErrorMessage = " ";
	String sSaveName=webpath+"/"+fileName;
	System.out.println("sSaveName=========================="+sSaveName);
	int upLoadFlag = 0;
	String ErrorInfo = "";
	if("U".equals(upOrDeFlag)){
		 // 新建一个SmartUpload对象
		 SmartUpload mySmartUpload = new SmartUpload();
		 try{
				 //上传初始化
				 
				 mySmartUpload.initialize(pageContext);
				 mySmartUpload.upload();
		 }catch(Exception ex) {
		    upLoadFlag = -1;
				sErrorMessage = "上载文件传输中出错！";
		 }
		
		 try{
				 com.jspsmart.upload.File file1 = mySmartUpload.getFiles().getFile(0);
				 if(!file1.isMissing()){
					  file1.saveAs(sSaveName);
					  System.out.println("sSaveName=============================="+sSaveName);
				 }
		 }catch(Exception ex) {
		      upLoadFlag = -1;
					sErrorMessage = "上载文件存储时出错！";
		 }
	}else if("D".equals(upOrDeFlag)){
		  java.io.File xmlFile =new java.io.File(fileName);
			if(!xmlFile.delete()){
					upLoadFlag = -1;
					sErrorMessage = "文件删除失败，可能删除文件不存在。";
			}
	}
 ErrorInfo = upLoadFlag+"|"+sErrorMessage+"|"+upOrDeFlag;
%>

</div>
<script type="text/javascript">
	parent.document.getElementById("ModifileUpLoadIF").src="/npage/so003/fo003_modifile.jsp?upLoadFlag=<%=upLoadFlag%>";
	//文件上传路径及上传成功标志
  parent.getModiFilePath("<%=webpath%>","<%=fileName%>","<%=source_name%>","<%=ErrorInfo%>");	
</script>
</body>
</html>