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
	  String line=null;
	  String paraAray2[] = new String[2];
		paraAray2[0] = fileNewName;
		paraAray2[1] = phoneText;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;   
			phoneText+=line+"\n"; 
			System.out.println("=gaopengSeeLog=phoneText== " + phoneText);
			fileLines ++;
		}while (line!=null);        
	  br.close();
	  fr.close();
	  System.out.println("gaopengSeeLog=====fileLines======================="+fileLines);
	  if(fileLines > 200){
	  
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
		paraAray2[1] = phoneText;
		/*调用服务入tuexdo文件*/
%>
		<wtc:service name="sbatchWrite" routerKey="region" 
			 routerValue="<%=regionCode%>" 
					retcode="errCode2" retmsg="errMsg2"  outnum="2" >
		<wtc:param value="<%=paraAray2[0]%>"/>
		<wtc:param value="<%=paraAray2[1]%>"/>
		</wtc:service>
		<wtc:array id="resultArr" scope="end" />
<%		
	  
%>
	<script language="javascript">
		/*原文件名,上传后的文件名,文件路径*/
		window.parent.doSetFileName("<%=book_name%>","<%=fileNewName%>","<%=path%>"+"/");
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

