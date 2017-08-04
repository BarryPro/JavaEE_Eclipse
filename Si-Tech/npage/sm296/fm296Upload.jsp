<%
 
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
	
	    
    String printAccept = "";
 		String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		
 		
 		
     String sqlStrl ="select sMaxSysAccept.nextval from dual";
  %>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel" retmsg="retMsgl" outnum="1">
    <wtc:sql><%=sqlStrl%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="resultl" scope="end" />
    	
<%

    if(retCodel.equals("000000")){
        printAccept = (resultl[0][0]).trim();
    }  

 		
 		String serverIp=realip.trim();
	try{
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		
		/*��������*/
		String upload_type = mySmartUpload.getRequest().getParameter("upload_type");
		/*ҵ�����*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*ҵ������*/
		String opName = mySmartUpload.getRequest().getParameter("opName");
		
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
				System.out.println("�ϴ��ļ�:" + sSaveName + "\n");
				iInputFile = sSaveName;
				myFile.saveAs(iInputFile);
				System.out.println("file ["+(i+1)+"] save!");
			}
		}
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  
	  /*�ϴ��ļ��ĸ�ʽ�Ƿ���ȷ*/
	  boolean uploadLieFlag  = false;
	  
	  /*0 */ String iLoginAccept		     = "0"; /*��ˮ*/
		/*1 */ String iChnSource		       = "01"; /*������ʶ*/
		/*2 */ String iOpCode	           = opCode; /*��������*/
		/*3 */ String iLoginNo            = loginNo; /*����*/
		/*4 */ String iLoginPwd	         = noPass; /*��������*/	
		/*5 */ String iOpNote	           = "���Ų�Ʒ�û���Ϣ��ȫ,��������"+upload_type; /*��ע*/
		/*6 */ String iPhoneNo	           = ""; /*�ֻ�����*/
		/*7 */ String iOprName				     = ""; /*����������*/
		/*8 */ String iOprAddr				     = ""; /*��������ϵ��ַ*/
		/*9 */ String iOprIdType			     = ""; /*������֤������*/
		/*10*/ String iOprIdIccId	       = ""; /*������֤������*/
		/*11*/ String iActualName			   = ""; /*ʵ��ʹ��������*/
		/*12*/ String iActualAddr			   = ""; /*ʵ��ʹ������ϵ��ַ*/
		/*13*/ String iActualIdType			 = ""; /*ʵ��ʹ����֤������*/
		/*14*/ String iActualIdIccId		   = ""; /*ʵ��ʹ����֤������*/
		/*15*/ String iFlag			         = upload_type; /*�ϴ��ļ��ķ�ʽ1.�����˵���2ʵ��ʹ���˵���3�����˺�ʵ��ʹ���˵���*/		
		/*11*/ String zerenlName			   = ""; /*����ʹ��������*/
		/*12*/ String zerenAddr			   = ""; /*��������ϵ��ַ*/
		/*13*/ String zerenIdType			 = ""; /*������֤������*/
		/*14*/ String zerenIdIccId		   = ""; /*������֤������*/



	  int fileLines=0;
	  String line=null;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;
			
			if(line!=null && !line.trim().equals("")){
				String arr[] = line.split("\\|");
				 
				 uploadLieFlag = true;
				 
				 //�ֻ�����|����������|�����˵�ַ|������֤��|������֤������
				 	if("1".equals(upload_type)){//���뾭������Ϣ
				 		if(fileLines == 0){
				 			iPhoneNo = iPhoneNo + arr[0];
				 			iOprName = iOprName + arr[1];
				 			iOprAddr = iOprAddr + arr[2];
				 			iOprIdType = iOprIdType + arr[3];
				 			iOprIdIccId = iOprIdIccId + arr[4];
				 		}else{
				 			iPhoneNo = iPhoneNo + "," + arr[0];
				 			iOprName = iOprName + "," + arr[1];
				 			iOprAddr = iOprAddr + "," + arr[2];
				 			iOprIdType = iOprIdType + "," + arr[3];
				 			iOprIdIccId = iOprIdIccId + "," + arr[4];
				 		}
				 		//�ֻ�����|ʵ��ʹ��������|ʵ��ʹ���˵�ַ|ʵ��ʹ����֤��|ʵ��ʹ����֤������
					}else if("2".equals(upload_type)){//����ʵ��ʹ������Ϣ
						if(fileLines == 0){
				 			iPhoneNo       = iPhoneNo + arr[0];
				 			iActualName    = iActualName + arr[1];
				 			iActualAddr    = iActualAddr + arr[2];
				 			iActualIdType  = iActualIdType + arr[3];
				 			iActualIdIccId = iActualIdIccId + arr[4];
				 		}else{
				 			iPhoneNo = iPhoneNo + "," + arr[0];
				 			iActualName = iActualName + "," + arr[1];
				 			iActualAddr = iActualAddr + "," + arr[2];
				 			iActualIdType = iActualIdType + "," + arr[3];
				 			iActualIdIccId = iActualIdIccId + "," + arr[4];
				 		}
				 		//�ֻ�����|����������|�����˵�ַ|������֤��|������֤������|ʵ��ʹ��������|ʵ��ʹ���˵�ַ|ʵ��ʹ����֤��|ʵ��ʹ����֤������
					}else if("3".equals(upload_type)){//���뾭���˺�ʵ��ʹ������Ϣ
						if(fileLines == 0){
				 			iPhoneNo = iPhoneNo + arr[0];
				 			iOprName = iOprName + arr[1];
				 			iOprAddr = iOprAddr + arr[2];
				 			iOprIdType = iOprIdType + arr[3];
				 			iOprIdIccId = iOprIdIccId + arr[4];
				 			iActualName    = iActualName + arr[5];
				 			iActualAddr    = iActualAddr + arr[6];
				 			iActualIdType  = iActualIdType + arr[7];
				 			iActualIdIccId = iActualIdIccId + arr[8];
				 		}else{
				 			iPhoneNo = iPhoneNo + "," + arr[0];
				 			iOprName = iOprName + "," + arr[1];
				 			iOprAddr = iOprAddr + "," + arr[2];
				 			iOprIdType = iOprIdType + "," + arr[3];
				 			iOprIdIccId = iOprIdIccId + "," + arr[4];
				 			iActualName = iActualName + "," + arr[5];
				 			iActualAddr = iActualAddr + "," + arr[6];
				 			iActualIdType = iActualIdType + "," + arr[7];
				 			iActualIdIccId = iActualIdIccId + "," + arr[8];
				 		}
					}else if("4".equals(upload_type)){//������������Ϣ
				 		if(fileLines == 0){
				 			iPhoneNo = iPhoneNo + arr[0];
				 			zerenlName = zerenlName + arr[1];
				 			zerenAddr = zerenAddr + arr[2];
				 			zerenIdType = zerenIdType + arr[3];
				 			zerenIdIccId = zerenIdIccId + arr[4];

				 		}else{
				 			iPhoneNo = iPhoneNo + "," + arr[0];
				 			zerenlName = zerenlName + "," + arr[1];
				 			zerenAddr = zerenAddr + "," + arr[2];
				 			zerenIdType = zerenIdType + "," + arr[3];
				 			zerenIdIccId = zerenIdIccId + "," + arr[4];
				 		}
					}
			}   
			
			
			fileLines ++;
		}while (line!=null);        
	  br.close();
	  fr.close();
	  
	  
	  
	  if(fileLines > 100){
	  %>
	  		<script language="javascript">
					rdShowMessageDialog("�������ݳ���100�����������ϴ��ļ���",1);
				</script>
	  <%
	  /*ɾ��*/
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
					rdShowMessageDialog("�ϴ��ļ��������ԣ��������ϴ��ļ���",1);
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
		/*���÷���*/
		rdShowMessageDialog("��ȡ�ļ��ɹ������濪ʼ�����������ݣ�",2);
		
		


		var path = "/npage/sm296/fm296_2.jsp?iLoginAccept=<%=iLoginAccept%>";
		path += "&iChnSource=<%=iChnSource%>";
		path += "&opCode=<%=opCode%>";
		path += "&opName=<%=opName%>";
		path += "&iOpCode=<%=iOpCode%>";
		path += "&iLoginNo=<%=iLoginNo%>";
		path += "&iLoginPwd=<%=iLoginPwd%>";
		path += "&iOpNote=<%=iOpNote%>";
		path += "&iPhoneNo=<%=iPhoneNo%>";
		path += "&iOprName=<%=iOprName%>";
		path += "&iOprAddr=<%=iOprAddr%>";
		path += "&iOprIdType=<%=iOprIdType%>";
		path += "&iOprIdIccId=<%=iOprIdIccId%>";
		path += "&iActualName=<%=iActualName%>";
		path += "&iActualAddr=<%=iActualAddr%>";
		path += "&iActualIdType=<%=iActualIdType%>";
		path += "&iActualIdIccId=<%=iActualIdIccId%>";
		path += "&iFlag=<%=iFlag%>";
		path += "&iOprIdIccId=<%=iOprIdIccId%>";
		path += "&zerenlName=<%=zerenlName%>";
		path += "&zerenAddr=<%=zerenAddr%>";
		path += "&zerenIdType=<%=zerenIdType%>";
		path += "&zerenIdIccId=<%=zerenIdIccId%>";
	 

		window.parent.location.href = path;
		
		
	</script>
<%		
	}}catch(Exception e){
	
		%>
		<script language="javascript">
			rdShowMessageDialog("�ϴ��ļ�ʧ�ܣ���ˢ��ҳ�������ϴ�����ϵ����Ա��",1);
		</script>
		<%
		e.printStackTrace();
	}
%>
                      