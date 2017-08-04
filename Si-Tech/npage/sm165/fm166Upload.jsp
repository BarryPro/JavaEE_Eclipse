<%
/********************
 * version v1.0
 * 开发商: si-tech
 * author: gaopeng @ 2014/03/12 15:54:55
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.io.File.*"%>
<%@ include file="/npage/common/serverip.jsp" %>

<%
System.out.println("gaopengSeeLog======fm108Upload.jsp");
 		String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		
 		
 		String serverIp=realip.trim();
	try{
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		/*业务代码*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*业务名称*/
		String opName = mySmartUpload.getRequest().getParameter("opName");
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
				 routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%		
		
		
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
	  
	  /*手机号码*/
	  String bPhone ="";
	  /*SIM卡号码*/
	  String bSimNo = "";
	  /*密码*/
	  String bPassWd = "";
	  /*预存*/
	  String bPreFee = "";
	  /*上传文件的格式是否正确*/
	  boolean uploadLieFlag  = false;
	  
	  
	  int fileLines=0;
	  String line=null;
		do {
			line=br.readLine();
			System.out.println("gaopengSeeLog=====line======================="+line);
			if(line==null) continue;       
			if(line.trim().equals("")) continue;
			if(line!=null && !line.trim().equals("")){
				String arr[] = line.split("\\|");
				System.out.println("gaopengSeeLog=====line==================arr.length====="+arr.length);
				int arrLength = arr.length;
				if(arrLength == 1){
				uploadLieFlag = true;
					if(fileLines == 0){
						bPhone = bPhone + arr[0];
					}else{
						bPhone = bPhone + "," + arr[0];
					}
				}
				
			}   
			fileLines ++;
		}while (line!=null);        
	  br.close();
	  fr.close();
	  System.out.println("gaopengSeeLog=====fileLines======================="+fileLines);
	  System.out.println("gaopengSeeLog=====line==================bPhone====="+bPhone);

	  if(fileLines > 100){
	  %>
	  		<script language="javascript">
					rdShowMessageDialog("处理数据超过100条，请重新上传文件！",1);
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
	  
	}else if(!uploadLieFlag){
		%>
			<script language="javascript">
					rdShowMessageDialog("上传文件列数不对，请重新上传文件！",1);
			</script>
		<%
		 try{
	  java.io.File delFile = new java.io.File(sSaveName);
			if(delFile.exists()){
				delFile.delete();
			}
			}catch(Exception e){
				
			}
			
	}else{
	  
%>
	<script language="javascript">
		/*调用服务*/
		rdShowMessageDialog("读取文件成功，下面开始处理批量数据！",2);
		
		
		var iLoginAccept = "<%=printAccept%>";
		var iChnSource = "08";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=loginNo%>";
		var iLoginPwd = "<%=noPass%>";
		var iPhoneNo = "<%=bPhone%>";
		

		var opName = "<%=opName%>";
		
		var path = "fm166Cfm.jsp?iLoginAccept="+iLoginAccept;
		path += "&iChnSource="+iChnSource;
		path += "&iOpCode="+iOpCode;
		path += "&iLoginNo="+iLoginNo;
		path += "&iLoginPwd="+iLoginPwd;
		path += "&iPhoneNo="+iPhoneNo;
		path += "&opName="+opName;
		//alert(path);
		window.location.href = path;
		
		
	</script>
<%		
	}}catch(Exception e){
	
		%>
		<script language="javascript">
			rdShowMessageDialog("上传文件失败！请刷新页面重新上传或联系管理员！",1);
		</script>
		<%
		e.printStackTrace();
	}
%>
