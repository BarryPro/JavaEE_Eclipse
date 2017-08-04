
<%!
	//Ӧ������ƽ̨��·��
	//String upFtpPath = "/chnesb/applicationsNewEsb/esbAdmin/CrmForAndroidApp/";// ���Ի���
	String upFtpPath = "/chnesb/applications/esbAdmin/CrmForAndroidApp/";//��������
 	/**
	 * �������������ն˰�CRM�������������İ�װ����apk�ļ��б仯����������ʧ�ܻ����سɹ���װʧ�ܡ���װ������ftp�ƻ�
	 * �ϴ���ftp�������ļ���ͨ������ftp���ϴ���ʽ���ϴ��ļ�
	 * 
	 * ��Σ�ftpMap �洢FTP��Ŀ������������Ip �û��� Ŀ¼�ȵ� 
	 * java.util.HashMap ftpMap = new java.util.HashMap();
	 * ftpMap.put("ftp_ConnecIp", "10.110.13.52"); ftpMap.put("ftp_UserName","chnop"); 
	 * ftpMap.put("ftp_Password", "asdf1234");
	 * ftpMap.put("ftp_FileType", "BINARY");//ASCII BINARY ftp�ļ����ͣ���������BINARY
	 * ftpMap.put("ftp_Encoding", "UTF-8");//�ַ������� ftpMap.put("ftp_FilePath", "f:\\Download\\CrmAndroidApp_V1.2.apk"); //����·�������ļ���
	 * ftpMap.put("ftp_SavePath", "/chnesb/hejwa/");//Զ��·��
	 * ftpMap.put("ftp_SaveName", "androidCrm_115070260661.apk"); //�����ļ���
	 * 
	 * @return
	 */
	public String ftpUploadFile(java.util.HashMap ftpMap) {
		String retVal = "OK";
		java.io.BufferedInputStream  fiStream  = null;
		org.apache.commons.net.ftp.FTPClient ftpClient = null;
		try {
			String ftp_ConnecIp = (String) ftpMap.get("ftp_ConnecIp");// ftp ������ IP
			String ftp_UserName = (String) ftpMap.get("ftp_UserName");// ftp ��½�û���
			String ftp_Password = (String) ftpMap.get("ftp_Password");// ftp ��½�û���������
			String ftp_Encoding = (String) ftpMap.get("ftp_Encoding");// ftp���ַ���
			String ftp_FTPiType = (String) ftpMap.get("ftp_FTPiType");// ftp�ϴ�����
			String ftp_LocaPath = (String) ftpMap.get("ftp_LocaPath");// �����ļ�·��
			String ftp_DistPath = (String) ftpMap.get("ftp_DistPath");// Զ�������ļ�·��
			String ftp_FileName = (String) ftpMap.get("ftp_FileName");// Ҫ������ļ���
			

			ftpClient = new org.apache.commons.net.ftp.FTPClient();
			
			//���ӵ�ftp
			ftpClient.connect(ftp_ConnecIp);
			
			if(!ftpClient.login(ftp_UserName, ftp_Password)){
				retVal = "FTP�����û������������";
			}else{
				//���ó�ʱʱ��
				ftpClient.setDataTimeout(1000*60*10);
				//�����ַ���
				ftpClient.setControlEncoding(ftp_Encoding);
				ftpClient.changeWorkingDirectory(ftp_DistPath);
				boolean bType = false;
				//����ftp����
				if("ASCII".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.ASCII_FILE_TYPE);
				}else if("BINARY".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.BINARY_FILE_TYPE);
				}
				if(!bType){
					retVal = "����FTP�ļ�����ʧ��";
				}else{
					fiStream = new java.io.BufferedInputStream(new java.io.FileInputStream(ftp_LocaPath+ftp_FileName));
				    if(!ftpClient.storeFile(ftp_FileName, fiStream)){
				    	retVal = "FTP�ļ��ϴ�ʧ��";
				    }
				}
			}
		} catch (java.net.ConnectException e) {
			retVal = "FTP���ӵ�ַ����";
		} catch (java.io.FileNotFoundException  e) {
			e.printStackTrace();
			retVal = "FTPû�ҵ�Ҫ�ϴ����ļ�";
		} catch (Exception e) {
			e.printStackTrace();
			retVal = "FTP�����쳣";
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
	 * �ӷ����������ذ�װ����
	 * @param args
	 */
	public String ftpDownLoadFile(java.util.HashMap ftpMap) {
		String retVal = "OK";
		java.io.FileOutputStream fos = null;
		org.apache.commons.net.ftp.FTPClient ftpClient = null;
		try {
			String ftp_ConnecIp = (String) ftpMap.get("ftp_ConnecIp");// ftp ������ IP
			String ftp_UserName = (String) ftpMap.get("ftp_UserName");// ftp ��½�û���
			String ftp_Password = (String) ftpMap.get("ftp_Password");// ftp ��½�û���������
			String ftp_Encoding = (String) ftpMap.get("ftp_Encoding");// ftp���ַ���
			String ftp_FTPiType = (String) ftpMap.get("ftp_FTPiType");// ftp�ϴ�����
			String ftp_LocaPath = (String) ftpMap.get("ftp_LocaPath");// �����ļ�·��
			String ftp_DistPath = (String) ftpMap.get("ftp_DistPath");// Զ�������ļ�·��
			String ftp_FileName = (String) ftpMap.get("ftp_FileName");// Ҫ������ļ���

			ftpClient = new org.apache.commons.net.ftp.FTPClient();
			
			//���ӵ�ftp
			ftpClient.connect(ftp_ConnecIp);
			
			if(!ftpClient.login(ftp_UserName, ftp_Password)){
				retVal = "FTP�����û������������";
			}else{
				//���ó�ʱʱ��
				ftpClient.setDataTimeout(1000*60*10);
				//�����ַ���
				ftpClient.setControlEncoding(ftp_Encoding);
				ftpClient.changeWorkingDirectory(ftp_DistPath);
				boolean bType = false;
				//����ftp����
				if("ASCII".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.ASCII_FILE_TYPE);
				}else if("BINARY".equals(ftp_FTPiType)){
					bType = ftpClient.setFileType(org.apache.commons.net.ftp.FTP.BINARY_FILE_TYPE);
				}
				if(!bType){
					retVal = "����FTP�ļ�����ʧ��";
				}else{
					java.io.File f = new java.io.File(ftp_LocaPath+ftp_FileName);
				     if( f.exists() ){
				       //������ڴ��ļ���ɾ��
				       f.delete();
				     }
					fos = new java.io.FileOutputStream(f);
				    if(!ftpClient.retrieveFile(ftp_FileName, fos)){
				    	retVal = "FTP�ļ�����ʧ��";
				    }
				}
			}
		} catch (java.net.ConnectException e) {
			retVal = "FTP���ӵ�ַ����";
		} catch (java.io.FileNotFoundException  e) {
			e.printStackTrace();
			retVal = "FTPû�ҵ�Ҫ���ص��ļ�";
		} catch (Exception e) {
			e.printStackTrace();
			retVal = "FTP�����쳣";
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