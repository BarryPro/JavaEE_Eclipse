<%
/********************
 * version v1.0
 * 开发商: si-tech
 * author: gaopeng @ 2012-8-01 17:32:00
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%
	try{
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		String printAccept = mySmartUpload.getRequest().getParameter("printAccept");
		String filename = printAccept;
		String path = request.getRealPath("/npage/tmp/");
		String sSaveName = path+"/"+filename+".txt";
		java.io.File fileNew = new java.io.File(path);  
		if(!fileNew.exists())
			fileNew.mkdirs();
			
		String flag="";
		String book_name="";
		String iInputFile = "";
		
		if(myfiles.getCount()>0){
			for(int i=0;i<myfiles.getCount();i++){
			com.jspsmart.upload.File myFile = myfiles.getFile(i);  
				if(myFile.isMissing()){
  					System.out.println("file ["+(i+1)+"] is null!");
  					continue;
				}
				String fieldName = myFile.getFieldName();
				int fileSize = myFile.getSize();
				book_name=myFile.getFileName();
				System.out.println("上传文件:" + sSaveName + "\n");
				iInputFile = sSaveName;
				myFile.saveAs(iInputFile);
				System.out.println("file ["+(i+1)+"] save!");
			}
		}
		
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  String workNoList="";
	  String line=null;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;   
			System.out.println("gaopeng s5517 upload["+line+"]");
			workNoList += line + ",";
		}while (line!=null);        
	  br.close();
	  fr.close();
%>
	<script language="javascript">
		parent.doSetFileName("<%=sSaveName%>","<%=workNoList%>");
		//上传置无效
		parent.setdisabled();
	</script>
<%		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
