<%
/********************
 * version v1.0
 * 开发商: si-tech
 * author: gaopeng @ 2012-7-24 10:02:00
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.io.File.*"%>

<%
	try{
		String regionCode= (String)session.getAttribute("regCode");
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		String printAccept = mySmartUpload.getRequest().getParameter("printAccept");
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		String filename = opCode+"_"+printAccept;
		String fileNewName = filename+".txt";
		String path = request.getRealPath("/npage/tmp/");
		String sSaveName = path+"/"+filename+".txt";
		java.io.File fileNew = new java.io.File(path);  
		if(!fileNew.exists())
			fileNew.mkdirs();
			
		String flag="";
		String book_name="";
		String iInputFile = "";
		
		if(myfiles.getCount()>0){
		
		if(myfiles.getCount() > 100){
			%>
				
			<%
		}else{
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
		}
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  int fileLines=0;
	  String phoneText="";
	  
	  String carPStr = "";
	  String carJStr = "";
	  String carFStr = "";
	  String carNoType = "";
	  
	  String line=null;
	  String paraAray2[] = new String[2];
		paraAray2[0] = fileNewName;
		paraAray2[1] = phoneText;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;
			if(!"".equals(line.trim()) && line != null){
				String[] myStr = line.trim().split("\\|");
				if("".equals(carPStr)){
					carPStr = myStr[0];
					carJStr = myStr[1];
					carFStr = myStr[2];
					carNoType = myStr[3];
				}else{
					carPStr += ","+myStr[0];
					carJStr += ","+myStr[1];
					carFStr += ","+myStr[2];
					carNoType += ","+myStr[3];
				}
				
				
			}
			System.out.println("=gaopengSeeLog=m260===line== " + line);
			System.out.println("=gaopengSeeLog=m260===carPStr== " + carPStr);
			System.out.println("=gaopengSeeLog=m260===carJStr== " + carJStr);
			System.out.println("=gaopengSeeLog=m260===carFStr== " + carFStr);
			System.out.println("=gaopengSeeLog=m260===carNoType== " + carNoType);
			
			fileLines ++;
		}while (line!=null);        
	  br.close();
	  fr.close();
	  System.out.println("gaopengSeeLog=====fileLines======================="+fileLines);
	  if(fileLines > 50){
	  
	  %>
	  		<script language="javascript">
					/*原文件名,上传后的文件名,文件路径*/
					window.parent.tellMore1000();
				</script>
	  <%
	  /*删除*/
	  try{
	  java.io.File delFile = new java.io.File(sSaveName);
			if(delFile.exists()){
				delFile.delete();
			}
			}catch(Exception e){
				
			}
	  
	}else{
		
%>

<%		
	  
%>
	<script language="javascript">
		/*原文件名,上传后的文件名,文件路径*/
		window.parent.doSetFileName("<%=book_name%>","<%=fileNewName%>","<%=path%>"+"/","<%=carPStr%>","<%=carJStr%>","<%=carFStr%>","<%=carNoType%>");
	</script>
<%		
	}
	
	%>		
	
	<%
	}catch(Exception e){
	
		%>
		<script language="javascript">
		window.parent.showUploadError("上传文件失败！请刷新页面重新上传或联系管理员！");
		</script>
		<%
		e.printStackTrace();
	}
%>

