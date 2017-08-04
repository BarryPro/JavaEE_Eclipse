
<%!
	//应用能力平台的路径
	//String upFtpPath = "/chnesb/applicationsNewEsb/esbAdmin/CrmForAndroidApp/";// 测试环境
	String upFtpPath = "/chnesb/applications/esbAdmin/CrmForAndroidApp/";//生产环境
 	/**
	 * 驱动力：智能终端版CRM传到生产环境的安装升级apk文件有变化，导致下载失败或下载成功安装失败。安装包程序被ftp破坏
	 * 上传到ftp主机的文件，通过设置ftp的上传方式来上传文件
	 * 
	 * 入参：ftpMap 存储FTP的目标主机数据如Ip 用户名 目录等等 
	 * java.util.HashMap ftpMap = new java.util.HashMap();
	 * ftpMap.put("ftp_ConnecIp", "10.110.13.52"); ftpMap.put("ftp_UserName","chnop"); 
	 * ftpMap.put("ftp_Password", "asdf1234");
	 * ftpMap.put("ftp_FileType", "BINARY");//ASCII BINARY ftp文件类型，基本上是BINARY
	 * ftpMap.put("ftp_Encoding", "UTF-8");//字符集编码 ftpMap.put("ftp_FilePath", "f:\\Download\\CrmAndroidApp_V1.2.apk"); //本地路径，含文件名
	 * ftpMap.put("ftp_SavePath", "/chnesb/hejwa/");//远程路径
	 * ftpMap.put("ftp_SaveName", "androidCrm_115070260661.apk"); //保存文件名
	 * 
	 * @return
	 */
	public String ftpUploadFile(java.util.HashMap ftpMap) {
		String retVal = "OK";
		java.io.BufferedInputStream  fiStream  = null;
		org.apache.commons.net.ftp.FTPClient ftpClient = null;
		try {
			String ftp_ConnecIp = (String) ftpMap.get("ftp_ConnecIp");// ftp 服务器 IP
			String ftp_UserName = (String) ftpMap.get("ftp_UserName");// ftp 登陆用户名
			String ftp_Password = (String) ftpMap.get("ftp_Password");// ftp 登陆用户名的密码
			String ftp_Encoding = (String) ftpMap.get("ftp_Encoding");// ftp的字符集
			String ftp_FTPiType = (String) ftpMap.get("ftp_FTPiType");// ftp上传类型
			String ftp_LocaPath = (String) ftpMap.get("ftp_LocaPath");// 本地文件路径
			String ftp_DistPath = (String) ftpMap.get("ftp_DistPath");// 远程主机文件路径
			String ftp_FileName = (String) ftpMap.get("ftp_FileName");// 要保存的文件名
			

			ftpClient = new org.apache.commons.net.ftp.FTPClient();
			
			//连接到ftp
			ftpClient.connect(ftp_ConnecIp);
			
			if(!ftpClient.login(ftp_UserName, ftp_Password)){
				retVal = "FTP连接用户名或密码错误";
			}else{
				//设置超时时间
				ftpClient.setDataTimeout(1000*60*10);
				//设置字符集
				ftpClient.setControlEncoding(ftp_Encoding);
				ftpClient.changeWorkingDirectory(ftp_DistPath);
				boolean bType = false;
				//设置ftp类型
				if("ASCII".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.ASCII_FILE_TYPE);
				}else if("BINARY".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.BINARY_FILE_TYPE);
				}
				if(!bType){
					retVal = "设置FTP文件类型失败";
				}else{
					fiStream = new java.io.BufferedInputStream(new java.io.FileInputStream(ftp_LocaPath+ftp_FileName));
				    if(!ftpClient.storeFile(ftp_FileName, fiStream)){
				    	retVal = "FTP文件上传失败";
				    }
				}
			}
		} catch (java.net.ConnectException e) {
			retVal = "FTP连接地址错误";
		} catch (java.io.FileNotFoundException  e) {
			e.printStackTrace();
			retVal = "FTP没找到要上传的文件";
		} catch (Exception e) {
			e.printStackTrace();
			retVal = "FTP工具异常";
		} finally{
		    try {
		    	fiStream.close();
				ftpClient.quit();
			} catch (Exception e) {
			}
		}

		return retVal;

	}
	/**
	 * 从服务器上下载安装程序
	 * @param args
	 */
	public String ftpDownLoadFile(java.util.HashMap ftpMap) {
		String retVal = "OK";
		java.io.FileOutputStream fos = null;
		org.apache.commons.net.ftp.FTPClient ftpClient = null;
		try {
			String ftp_ConnecIp = (String) ftpMap.get("ftp_ConnecIp");// ftp 服务器 IP
			String ftp_UserName = (String) ftpMap.get("ftp_UserName");// ftp 登陆用户名
			String ftp_Password = (String) ftpMap.get("ftp_Password");// ftp 登陆用户名的密码
			String ftp_Encoding = (String) ftpMap.get("ftp_Encoding");// ftp的字符集
			String ftp_FTPiType = (String) ftpMap.get("ftp_FTPiType");// ftp上传类型
			String ftp_LocaPath = (String) ftpMap.get("ftp_LocaPath");// 本地文件路径
			String ftp_DistPath = (String) ftpMap.get("ftp_DistPath");// 远程主机文件路径
			String ftp_FileName = (String) ftpMap.get("ftp_FileName");// 要保存的文件名

			ftpClient = new org.apache.commons.net.ftp.FTPClient();
			
			//连接到ftp
			ftpClient.connect(ftp_ConnecIp);
			
			if(!ftpClient.login(ftp_UserName, ftp_Password)){
				retVal = "FTP连接用户名或密码错误";
			}else{
				//设置超时时间
				ftpClient.setDataTimeout(1000*60*10);
				//设置字符集
				ftpClient.setControlEncoding(ftp_Encoding);
				ftpClient.changeWorkingDirectory(ftp_DistPath);
				boolean bType = false;
				//设置ftp类型
				if("ASCII".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.ASCII_FILE_TYPE);
				}else if("BINARY".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.BINARY_FILE_TYPE);
				}
				if(!bType){
					retVal = "设置FTP文件类型失败";
				}else{
					java.io.File f = new java.io.File(ftp_LocaPath+ftp_FileName);
				     if( f.exists() ){
				       //如果存在此文件则删除
				       f.delete();
				     }
					fos = new java.io.FileOutputStream(f);
				    if(!ftpClient.retrieveFile(ftp_FileName, fos)){
				    	retVal = "FTP文件下载失败";
				    }
				}
			}
		} catch (java.net.ConnectException e) {
			retVal = "FTP连接地址错误";
		} catch (java.io.FileNotFoundException  e) {
			e.printStackTrace();
			retVal = "FTP没找到要下载的文件";
		} catch (Exception e) {
			e.printStackTrace();
			retVal = "FTP工具异常";
		} finally{
		    try {
		    	fos.close();
				ftpClient.quit();
			} catch (Exception e) {
			}
		}

		return retVal;

	}
%>