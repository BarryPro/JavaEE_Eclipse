<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.sitech.crmpd.core.config.Configuration"%>

<html>
<body bgcolor="white">
<div id="excelTable" style="display:none">
<%
  String upOrDeFlag = (String)request.getParameter("upOrDeFlag");//�ϴ���ɾ����־U���ϴ� D��ɾ��
  String fileName = (String)request.getParameter("fileName");
  String source_name = (String)request.getParameter("source_name");
  System.out.println("source_name=========================="+source_name);
  System.out.println("fileName=========================="+fileName);
    //�ϴ���wl·��
    String webpath =request.getRealPath("/npage/tmp/");
  System.out.println("webpath=========================="+webpath);
	String sErrorMessage = " ";
	String sSaveName=webpath+"/"+fileName;
	System.out.println("sSaveName=========================="+sSaveName);
	int upLoadFlag = 0;
	String ErrorInfo = "";
	if("U".equals(upOrDeFlag)){
		 // �½�һ��SmartUpload����
		 SmartUpload mySmartUpload = new SmartUpload();
		 try{
				 //�ϴ���ʼ��
				 
				 mySmartUpload.initialize(pageContext);
				 mySmartUpload.upload();
		 }catch(Exception ex) {
		    upLoadFlag = -1;
				sErrorMessage = "�����ļ������г���";
		 }
		
		 try{
				 com.jspsmart.upload.File file1 = mySmartUpload.getFiles().getFile(0);
				 if(!file1.isMissing()){
					  file1.saveAs(sSaveName);
					  System.out.println("sSaveName=============================="+sSaveName);
				 }
		 }catch(Exception ex) {
		      upLoadFlag = -1;
					sErrorMessage = "�����ļ��洢ʱ����";
		 }
	}else if("D".equals(upOrDeFlag)){
		  java.io.File xmlFile =new java.io.File(fileName);
			if(!xmlFile.delete()){
					upLoadFlag = -1;
					sErrorMessage = "�ļ�ɾ��ʧ�ܣ�����ɾ���ļ������ڡ�";
			}
	}
 ErrorInfo = upLoadFlag+"|"+sErrorMessage+"|"+upOrDeFlag;
%>

</div>
<script type="text/javascript">
	parent.document.getElementById("ModifileUpLoadIF").src="/npage/so003/fo003_modifile.jsp?upLoadFlag=<%=upLoadFlag%>";
	//�ļ��ϴ�·�����ϴ��ɹ���־
  parent.getModiFilePath("<%=webpath%>","<%=fileName%>","<%=source_name%>","<%=ErrorInfo%>");	
</script>
</body>
</html>