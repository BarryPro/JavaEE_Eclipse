<%
/********************
 *	zhangyan@2013/9/18 15:17:55
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="FtpTools.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.uploadftp.*"%>

<%
String regCode 	= ( String )session.getAttribute( "regCode" );
String workNo   = (String)session.getAttribute("workNo");
String ipAddr 	= ( String )session.getAttribute ( "ipAddr" );

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="sysAcceptl" /> 
<%
String opCode 	    = request.getParameter("opCode");
String opName 	    = request.getParameter("opName");
String apkMemo 	    = request.getParameter("apkMemo");
String apkVersionId = request.getParameter("apkVersionId");
String mustUpgFlag  = request.getParameter("mustUpgFlag");
String upftpip      = request.getParameter("upftpip");
String upftpuser    = request.getParameter("upftpuser");
String upftppass    = request.getParameter("upftppass");



String fileName = "androidCrm_"+sysAcceptl+".apk" ;
String path = request.getRealPath("/npage/androidFile/");
String sSaveName = path+"/"+fileName;
try
{
	  SmartUpload mySmartUpload = new SmartUpload();
    mySmartUpload.initialize(pageContext);
	  mySmartUpload.setMaxFileSize(50*1024*1024); //文件大小为50M
    mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		
		java.io.File fileNew = new java.io.File(path);  
		if(!fileNew.exists()){
			fileNew.mkdirs();
		}

		String flag="";
		String iInputFile = "";
		if(myfiles.getCount()>0)
		{
			com.jspsmart.upload.File myFile = myfiles.getFile(0);  
			if(!myFile.isMissing()){
				String fieldName = myFile.getFieldName();
				int fileSize = myFile.getSize();
				iInputFile = sSaveName;
				myFile.saveAs(iInputFile);
			}
		}
	if(!"error".equals(flag)){ //调用服务
	
		String paraAray[] = new String[14];
		
		paraAray[0] = "";  																			//流水
		paraAray[1] = "01";                                     //渠道代码
		paraAray[2] = opCode;                                   //操作代码
		paraAray[3] = (String)session.getAttribute("workNo");   //工号
		paraAray[4] = (String)session.getAttribute("password"); //工号密码
		paraAray[5] = "";          															//用户号码
		paraAray[6] = "";                                       //用户密码
		paraAray[7] = apkVersionId;                             //版本号
		paraAray[8] = fileName;                                 //程序名
		paraAray[9] = apkMemo;                                  //备注
		paraAray[10] = mustUpgFlag;                              //
		paraAray[11] = upftpip;                              	 //
		paraAray[12] = upftpuser;                              //
		paraAray[13] = upftppass;                              //
		
%>
  <wtc:service name="sm016Cfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
 		<wtc:param value="<%=paraAray[8]%>" />			
 		<wtc:param value="<%=paraAray[9]%>" />				
 		<wtc:param value="<%=paraAray[10]%>" />	
 		<wtc:param value="<%=paraAray[11]%>" />	
 		<wtc:param value="<%=paraAray[12]%>" />	
 		<wtc:param value="<%=paraAray[13]%>" />				
	</wtc:service>
	<wtc:array id="result_t" scope="end"   />		 
			
<%
		if("000000".equals(code))
		{
			String upFtpFileInfo = "";
			//取文件名路径
			String saveNameUpFtp=request.getRealPath("npage/androidFile/")+"/";
			
			System.out.println("hejwa----ftp_FileName---"+fileName);
				
			System.out.println("hejwa----ftp_LocaPath---"+saveNameUpFtp);
			System.out.println("hejwa----ftp_DistPath---"+upFtpPath);
			
			java.util.HashMap ftpMap = new java.util.HashMap();
			ftpMap.put("ftp_ConnecIp", upftpip);
			ftpMap.put("ftp_UserName", upftpuser);
			ftpMap.put("ftp_Password", upftppass);
			ftpMap.put("ftp_FTPiType", "BINARY");//ASCII BINARY  ftp文件类型，基本上是BINARY
			ftpMap.put("ftp_Encoding", "UTF-8");//字符集编码
			ftpMap.put("ftp_LocaPath", saveNameUpFtp); //本地路径 
			ftpMap.put("ftp_DistPath", upFtpPath);//远程路径
			ftpMap.put("ftp_FileName", fileName); //保存文件名
			
			 
			String showmsg = "";
			String showflag = "";
			
			upFtpFileInfo = ftpUploadFile(ftpMap); 
			System.out.println("hejwa---upFtpFileInfo---"+upFtpFileInfo);
			if(!"OK".equals(upFtpFileInfo)){
				showmsg = "文件保存数据库成功。文件上传应用能力平台失败，请将安装包手动FTP上传至能力平台！失败原因："+upFtpFileInfo;
				showflag = "1";
			}else{
				showmsg = "文件保存数据库成功。文件上传应用能力平台成功";
				showflag = "2";
			}
		%>
			<script>
				rdShowMessageDialog("<%=showmsg%>",<%=showflag%>);
				window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>
		<%
		}
		else 
		{
			//调用服务失败删除文件
			java.io.File f = new java.io.File(sSaveName);
		  try{
				//f.delete();
		  }catch(Exception ex){
		      ex.printStackTrace();
		  }finally{   	
		 	
			}
		%>
			<script>
				rdShowMessageDialog("调用上传服务失败，<%=code%>：<%=msg%>",0);
				window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>
		<%
		}
	}else{
  %>
  		<script>
				rdShowMessageDialog("文件上传到主机失败",0);
				window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>
  <%  		
	}
}catch(Exception e){
			//调用服务失败删除文件
			java.io.File f = new java.io.File(sSaveName);
		  try{
				//f.delete();
		  }catch(Exception ex){
		      ex.printStackTrace();
		  }finally{   	
		 	
			}
%>
<script>
    rdShowMessageDialog('文件上传失败，请检查文件大小，格式，内容等信息！',0);
    window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
</script>
<%
e.printStackTrace();
}
%>