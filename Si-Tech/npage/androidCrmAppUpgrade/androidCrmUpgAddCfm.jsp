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
	  mySmartUpload.setMaxFileSize(50*1024*1024); //�ļ���СΪ50M
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
	if(!"error".equals(flag)){ //���÷���
	
		String paraAray[] = new String[14];
		
		paraAray[0] = "";  																			//��ˮ
		paraAray[1] = "01";                                     //��������
		paraAray[2] = opCode;                                   //��������
		paraAray[3] = (String)session.getAttribute("workNo");   //����
		paraAray[4] = (String)session.getAttribute("password"); //��������
		paraAray[5] = "";          															//�û�����
		paraAray[6] = "";                                       //�û�����
		paraAray[7] = apkVersionId;                             //�汾��
		paraAray[8] = fileName;                                 //������
		paraAray[9] = apkMemo;                                  //��ע
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
			//ȡ�ļ���·��
			String saveNameUpFtp=request.getRealPath("npage/androidFile/")+"/";
			
			System.out.println("hejwa----ftp_FileName---"+fileName);
				
			System.out.println("hejwa----ftp_LocaPath---"+saveNameUpFtp);
			System.out.println("hejwa----ftp_DistPath---"+upFtpPath);
			
			java.util.HashMap ftpMap = new java.util.HashMap();
			ftpMap.put("ftp_ConnecIp", upftpip);
			ftpMap.put("ftp_UserName", upftpuser);
			ftpMap.put("ftp_Password", upftppass);
			ftpMap.put("ftp_FTPiType", "BINARY");//ASCII BINARY  ftp�ļ����ͣ���������BINARY
			ftpMap.put("ftp_Encoding", "UTF-8");//�ַ�������
			ftpMap.put("ftp_LocaPath", saveNameUpFtp); //����·�� 
			ftpMap.put("ftp_DistPath", upFtpPath);//Զ��·��
			ftpMap.put("ftp_FileName", fileName); //�����ļ���
			
			 
			String showmsg = "";
			String showflag = "";
			
			upFtpFileInfo = ftpUploadFile(ftpMap); 
			System.out.println("hejwa---upFtpFileInfo---"+upFtpFileInfo);
			if(!"OK".equals(upFtpFileInfo)){
				showmsg = "�ļ��������ݿ�ɹ����ļ��ϴ�Ӧ������ƽ̨ʧ�ܣ��뽫��װ���ֶ�FTP�ϴ�������ƽ̨��ʧ��ԭ��"+upFtpFileInfo;
				showflag = "1";
			}else{
				showmsg = "�ļ��������ݿ�ɹ����ļ��ϴ�Ӧ������ƽ̨�ɹ�";
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
			//���÷���ʧ��ɾ���ļ�
			java.io.File f = new java.io.File(sSaveName);
		  try{
				//f.delete();
		  }catch(Exception ex){
		      ex.printStackTrace();
		  }finally{   	
		 	
			}
		%>
			<script>
				rdShowMessageDialog("�����ϴ�����ʧ�ܣ�<%=code%>��<%=msg%>",0);
				window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>
		<%
		}
	}else{
  %>
  		<script>
				rdShowMessageDialog("�ļ��ϴ�������ʧ��",0);
				window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>
  <%  		
	}
}catch(Exception e){
			//���÷���ʧ��ɾ���ļ�
			java.io.File f = new java.io.File(sSaveName);
		  try{
				//f.delete();
		  }catch(Exception ex){
		      ex.printStackTrace();
		  }finally{   	
		 	
			}
%>
<script>
    rdShowMessageDialog('�ļ��ϴ�ʧ�ܣ������ļ���С����ʽ�����ݵ���Ϣ��',0);
    window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
</script>
<%
e.printStackTrace();
}
%>