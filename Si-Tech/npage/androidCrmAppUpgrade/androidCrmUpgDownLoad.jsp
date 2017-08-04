<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="FtpTools.jsp" %>
<%
	String apkName = request.getParameter("apkName").trim();
	String opCode  = request.getParameter("opCode");
	String opName  = request.getParameter("opName");
  String bak_dir = request.getRealPath("/npage/androidFile")+"/";
	String filedownload = bak_dir+apkName;//即将下载的文件的相对路径
	String goBackUrl = "";
	if("m017".equals(opCode)){
		goBackUrl = "androidCrmDownLoad.jsp";
	}else if("m016".equals(opCode)){
		goBackUrl = "androidCrmUpgMain.jsp";
	}
		File f = new File(filedownload);
    
    try
    {
		if(!f.exists())
		{
				//先查询FTP信息
				String regionCode = (String)session.getAttribute("regCode");
				String paraAray[] = new String[7];
				paraAray[0] = "";  																			//流水
				paraAray[1] = "01";                                     //渠道代码
				paraAray[2] = opCode;                                   //操作代码
				paraAray[3] = (String)session.getAttribute("workNo");   //工号
				paraAray[4] = (String)session.getAttribute("password"); //工号密码
				paraAray[5] = "";          															//用户号码
				paraAray[6] = "";                                       //用户密码
	%>
			 	<wtc:service name="sm017Qry" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			 		<wtc:param value="<%=paraAray[0]%>" />
			 		<wtc:param value="<%=paraAray[1]%>" />
			 		<wtc:param value="<%=paraAray[2]%>" />
			 		<wtc:param value="<%=paraAray[3]%>" />
			 		<wtc:param value="<%=paraAray[4]%>" />
			 		<wtc:param value="<%=paraAray[5]%>" />					
			 		<wtc:param value="<%=paraAray[6]%>" />	
			 	</wtc:service>
			 	<wtc:array id="result_t2" scope="end"/>
	<%			
				
				if(!"000000".equals(code)){
				  f.delete();
					response.setContentType("text/plain;charset=GBK");	
				  out.println("<SCRIPT LANGUAGE=\"JavaScript\">alert(\"取FTP信息服务错误！!\");window.location.href=\""+goBackUrl+"?opCode="+opCode+"&opName="+opName+"\";</SCRIPT>");	
				  throw new Exception("取FTP信息服务错误！");
				}else{
				
					String upftpip   = result_t2[0][6];
					String upftpuser = result_t2[0][7];
					String upftppass = result_t2[0][8];
					//去下载apk文件
					java.util.HashMap ftpMap = new java.util.HashMap();
					ftpMap.put("ftp_ConnecIp", upftpip);
					ftpMap.put("ftp_UserName", upftpuser);
					ftpMap.put("ftp_Password", upftppass);
					ftpMap.put("ftp_FTPiType", "BINARY");//ASCII BINARY  ftp文件类型，基本上是BINARY
					ftpMap.put("ftp_Encoding", "UTF-8");//字符集编码
					ftpMap.put("ftp_LocaPath", bak_dir); //本地路径 
					ftpMap.put("ftp_DistPath", upFtpPath);//远程路径
					ftpMap.put("ftp_FileName", apkName); //保存文件名
			 		String upFtpFileInfo = ftpDownLoadFile(ftpMap);
			 		if(!"OK".equals(upFtpFileInfo)){
			 			f.delete();
			 			String ftpErrMsg = "从FTP取安装程序出错，出错原因："+upFtpFileInfo;
			 			response.setContentType("text/plain;charset=GBK");	
			 			
			 			String goBackUrl_a = goBackUrl+"?opCode="+opCode+"&opName="+opName;
%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("<%=ftpErrMsg%>");
		window.location.href="<%=goBackUrl_a%>";			
	</SCRIPT>
<%			 			
					  throw new Exception("从FTP取安装程序出错");
			 		}
			  }	
		}
		
			
			InputStream fis = new FileInputStream(bak_dir+apkName);
			byte[] buffer = new byte[fis.available()];
      fis.read(buffer);
      fis.close();
      response.reset();
			OutputStream toClient = response.getOutputStream();
			response.setHeader("Content-Disposition", "attachment;filename=\"" +apkName + "\""); 
			response.addHeader("Content-Length", "" + f.length());
      toClient.write(buffer);
      toClient.flush();
      toClient.close();
    }catch(Exception e){
    		e.printStackTrace();

			 			String goBackUrl_a = goBackUrl+"?opCode="+opCode+"&opName="+opName;
%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("文件下载错误");
		window.location.href="<%=goBackUrl_a%>";			
	</SCRIPT>
<%		

    }

%>
	