<%
  /*
   * ����: У԰��Ϣ¼�� m132
   * �汾: 1.0
   * ����: 2014/6/27
   * ����: 
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.io.File.*"%>
<%
 		String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept"/>
<%

	try{
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		
		/*ҵ�����*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*ҵ������*/
		String opName = mySmartUpload.getRequest().getParameter("opName");
		
		String filename = opCode+"_"+sysAccept;
		System.out.println("diling---opCode="+opCode+"--opName="+opName+"---sysAccept="+sysAccept);
		String fileNewName = filename+".txt";
		String path = request.getRealPath("/npage/tmp/");
		String sSaveName = path+"/"+filename+".txt";
		java.io.File fileNew = new java.io.File(path);
		System.out.println("diling---fileNew="+fileNew);  
		if(!fileNew.exists())
			fileNew.mkdirs();
		
		if(myfiles.getCount()>0){
			for(int i=0;i<myfiles.getCount();i++){
				com.jspsmart.upload.File myFile = myfiles.getFile(i);  
				if(myFile.isMissing()){
					System.out.println("file ["+(i+1)+"] is null!");
%>
					<SCRIPT language=javascript>
							rdShowMessageDialog("�ļ���ʧ���ϴ����ɹ���", 0);
							window.location.href="/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
<%
					continue;
				}else{
					String fieldName = myFile.getFieldName();
					System.out.println("diling---�ϴ��ļ�:" + sSaveName + "\n");
					myFile.saveAs(sSaveName);
					System.out.println("file ["+(i+1)+"] save!");
				}
			}
		}
		
		
		
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  
	  /*���֤����*/
	  String bCardNo ="";
	  /*�ͻ�����*/
	  String bCustName = "";
	  /*ѧУ����*/
	  String bSchoolName = "";
	  /*רҵ����*/
	  String bMajorName = "";
	  /*סַ*/
	  String bAddrs = "";
	  /*�ϴ��ļ��ĸ�ʽ�Ƿ���ȷ*/
	  boolean uploadLieFlag  = false;
	  
	  
	  int fileLines=0;
	  String line=null;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;
			if(line!=null && !line.trim().equals("")){
				String arr[] = line.split("\\|");
				int arrLength = arr.length;
				if(arrLength == 5){
				uploadLieFlag = true;
					if(fileLines == 0){
						bCardNo = bCardNo + arr[0];
						bCustName = bCustName + arr[1];
						bSchoolName = bSchoolName + arr[2];
						bMajorName = bMajorName + arr[3];
						bAddrs = bAddrs + arr[4];
					}else{
						bCardNo = bCardNo + "," + arr[0];
						bCustName = bCustName + "," + arr[1];
						bSchoolName = bSchoolName + "," + arr[2];
						bMajorName = bMajorName + "," + arr[3];
						bAddrs = bAddrs + "," + arr[4];
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
					window.location.href="/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
					window.location.href="/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		
		var iLoginAccept = "<%=sysAccept%>";
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=loginNo%>";
		var iLoginPwd = "<%=noPass%>";
		var iPhoneNo = "";
		var iUserPwd = "";
		
		var iCardNo = "<%=bCardNo%>";
		var iCustName = "<%=bCustName%>";
		var iSchoolName = "<%=bSchoolName%>";
		var iMajorName = "<%=bMajorName%>";
		var iAddrs = "<%=bAddrs%>";
		
		var iOpName = "<%=opName%>";
		
		var path = "/npage/sm132/fm132_BatCfm.jsp?iLoginAccept="+iLoginAccept;
		path += "&iChnSource="+iChnSource;
		path += "&iOpCode="+iOpCode;
		path += "&iLoginNo="+iLoginNo;
		path += "&iLoginPwd="+iLoginPwd;
		path += "&iPhoneNo="+iPhoneNo;
		path += "&iUserPwd="+iUserPwd;
		
		path += "&iCardNo="+iCardNo;
		path += "&iCustName="+iCustName;
		path += "&iSchoolName="+iSchoolName;
		path += "&iMajorName="+iMajorName;
		path += "&iAddrs="+iAddrs;

		path += "&iOpName="+iOpName;
		window.location.href = path;
		
		
	</script>
<%		
	}}catch(Exception e){
		%>
		<script language="javascript">
			rdShowMessageDialog("�ϴ��ļ�ʧ�ܣ���ˢ��ҳ�������ϴ�����ϵ����Ա��",1);
			window.location.href="/npage/sm132/fm132_main.jsp?opCode=m132&opName=У԰��Ϣ¼��";
		</script>
		<%
		e.printStackTrace();
	}
%>

