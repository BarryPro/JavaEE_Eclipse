<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="FtpTools.jsp" %>
<%
	String apkName = request.getParameter("apkName").trim();
	String opCode  = request.getParameter("opCode");
	String opName  = request.getParameter("opName");
  String bak_dir = request.getRealPath("/npage/androidFile")+"/";
	String filedownload = bak_dir+apkName;//�������ص��ļ������·��
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
				//�Ȳ�ѯFTP��Ϣ
				String regionCode = (String)session.getAttribute("regCode");
				String paraAray[] = new String[7];
				paraAray[0] = "";  																			//��ˮ
				paraAray[1] = "01";                                     //��������
				paraAray[2] = opCode;                                   //��������
				paraAray[3] = (String)session.getAttribute("workNo");   //����
				paraAray[4] = (String)session.getAttribute("password"); //��������
				paraAray[5] = "";          															//�û�����
				paraAray[6] = "";                                       //�û�����
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
				  out.println("<SCRIPT LANGUAGE=\"JavaScript\">alert(\"ȡFTP��Ϣ�������!\");window.location.href=\""+goBackUrl+"?opCode="+opCode+"&opName="+opName+"\";</SCRIPT>");	
				  throw new Exception("ȡFTP��Ϣ�������");
				}else{
				
					String upftpip   = result_t2[0][6];
					String upftpuser = result_t2[0][7];
					String upftppass = result_t2[0][8];
					//ȥ����apk�ļ�
					java.util.HashMap ftpMap = new java.util.HashMap();
					ftpMap.put("ftp_ConnecIp", upftpip);
					ftpMap.put("ftp_UserName", upftpuser);
					ftpMap.put("ftp_Password", upftppass);
					ftpMap.put("ftp_FTPiType", "BINARY");//ASCII BINARY  ftp�ļ����ͣ���������BINARY
					ftpMap.put("ftp_Encoding", "UTF-8");//�ַ�������
					ftpMap.put("ftp_LocaPath", bak_dir); //����·�� 
					ftpMap.put("ftp_DistPath", upFtpPath);//Զ��·��
					ftpMap.put("ftp_FileName", apkName); //�����ļ���
			 		String upFtpFileInfo = ftpDownLoadFile(ftpMap);
			 		if(!"OK".equals(upFtpFileInfo)){
			 			f.delete();
			 			String ftpErrMsg = "��FTPȡ��װ�����������ԭ��"+upFtpFileInfo;
			 			response.setContentType("text/plain;charset=GBK");	
			 			
			 			String goBackUrl_a = goBackUrl+"?opCode="+opCode+"&opName="+opName;
%>
	<SCRIPT LANGUAGE="JavaScript">
		alert("<%=ftpErrMsg%>");
		window.location.href="<%=goBackUrl_a%>";			
	</SCRIPT>
<%			 			
					  throw new Exception("��FTPȡ��װ�������");
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
		alert("�ļ����ش���");
		window.location.href="<%=goBackUrl_a%>";			
	</SCRIPT>
<%		

    }

%>
	