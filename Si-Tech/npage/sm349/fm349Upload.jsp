<%
/********************
 * version v1.0
 * ������: si-tech
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
System.out.println("gaopengSeeLog======fm349Upload.jsp");
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
		/*��ˮ*/
		String printAccept = mySmartUpload.getRequest().getParameter("printAccept");
		/*ҵ�����*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*ҵ������*/
		String opName = mySmartUpload.getRequest().getParameter("opName");
		
		/*�ͻ����*/
		String ownerType = mySmartUpload.getRequest().getParameter("ownerType");
		
		/*���˿�������*/
		String isJSX = mySmartUpload.getRequest().getParameter("isJSX");
		/*�ͻ���������*/
		String districtCode = mySmartUpload.getRequest().getParameter("districtCode");
		
		/*�ͻ�����*/
		String custName = mySmartUpload.getRequest().getParameter("custName");
		
		/*֤������*/
		String idType = mySmartUpload.getRequest().getParameter("idType").split("\\|")[0];
		
		/*֤������*/
		String idIccid = mySmartUpload.getRequest().getParameter("idIccid");
		
		/*֤����ַ*/
		String idAddr = mySmartUpload.getRequest().getParameter("idAddr");
		/*֤����Ч��*/
		String idValidDate = mySmartUpload.getRequest().getParameter("idValidDate");
		/*�ͻ���ַ*/
		String custAddr = mySmartUpload.getRequest().getParameter("custAddr");
		/*��ϵ������*/
		String contactPerson = mySmartUpload.getRequest().getParameter("contactPerson");
		/*��ϵ�˵绰*/
		String contactPhone = mySmartUpload.getRequest().getParameter("contactPhone");
		/*��ϵ�˵�ַ*/
		String contactAddr = mySmartUpload.getRequest().getParameter("contactAddr");
		/*��ϵ���ʱ�*/
		String contactPost = mySmartUpload.getRequest().getParameter("contactPost");
		/*��ϵ�˴���*/
		String contactFax = mySmartUpload.getRequest().getParameter("contactFax");
		/*��ϵ��E_MAIL*/
		String contactMail = mySmartUpload.getRequest().getParameter("contactMail");
		/*��ϵ��ͨѶ��ַ*/
		String contactMAddr = mySmartUpload.getRequest().getParameter("contactMAddr");
		
		/*����������*/
		String gestoresName = mySmartUpload.getRequest().getParameter("gestoresName");
		/*��������ϵ��ַ*/
		String gestoresAddr = mySmartUpload.getRequest().getParameter("gestoresAddr");
		/*������֤������*/
		String gestoresIdType = mySmartUpload.getRequest().getParameter("gestoresIdType").split("\\|")[0];
		/*������֤������*/
		String gestoresIccId = mySmartUpload.getRequest().getParameter("gestoresIccId");
		/*��ѡ���ʷ�*/
		String selOrder = mySmartUpload.getRequest().getParameter("selOrder");
		/*�û���ע*/
		String sysNote = mySmartUpload.getRequest().getParameter("sysNote");
		
		
		/*����������*/
		String responsibleName = mySmartUpload.getRequest().getParameter("responsibleName");

		/*��������ϵ��ַ*/
		String responsibleAddr = mySmartUpload.getRequest().getParameter("responsibleAddr");

		/*������֤������*/
		String responsibleType = mySmartUpload.getRequest().getParameter("responsibleType").split("\\|")[0];

		/*������֤������*/
		String responsibleIccId = mySmartUpload.getRequest().getParameter("responsibleIccId");		
		
		/*С������*/
		String xqdm = mySmartUpload.getRequest().getParameter("s_60001");
		if(xqdm == null || "".equals(xqdm)){
			xqdm = "";
		}
		/*���Ӳ�Ʒ����Ϣ*/
		String endStr = mySmartUpload.getRequest().getParameter("endStr");
		
		
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
	  
	  /*�ֻ�����*/
	  String bPhone ="";
	  /*SIM������*/
	  String bSimNo = "";
	  /*����*/
	  String bPassWd = "";
	  /*SMI����*/
	  String bSimFee = "";
	  /*Ԥ��*/
	  String bPreFee = "";
	  /*ʵ��ʹ��������*/
	  String bTrueName = "";
	  /*ʵ��ʹ����֤������*/
	  String bTrueIdType = "";
	  /*ʵ��ʹ����֤������*/
	  String bTrueIdNo = "";
	  /*ʵ��ʹ������ϵ��ַ*/
	  String bTrueAddr = "";
	  
	  /*�ϴ��ļ��ĸ�ʽ�Ƿ���ȷ*/
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
				if(arrLength == 9 && "m349".equals(opCode)){
				uploadLieFlag = true;
					if(fileLines == 0){
						bPhone = bPhone + arr[0];
						bSimNo = bSimNo + arr[1];
						bPassWd = bPassWd + arr[2];
						bSimFee = bSimFee + arr[3];
						bPreFee = bPreFee + arr[4];
						bTrueName = bTrueName + arr[5];
						bTrueIdType = bTrueIdType + arr[6];
						bTrueIdNo = bTrueIdNo + arr[7];
						bTrueAddr = bTrueAddr + arr[8];
						
						
					}else{
						bPhone = bPhone + "," + arr[0];
						bSimNo = bSimNo + "," + arr[1];
						bPassWd = bPassWd + "," + arr[2];
						bSimFee = bSimFee + "," + arr[3];
						bPreFee = bPreFee + "," + arr[4];
						bTrueName = bTrueName + "," + arr[5];
						bTrueIdType = bTrueIdType + "," + arr[6];
						bTrueIdNo = bTrueIdNo + "," + arr[7];
						bTrueAddr = bTrueAddr + "," + arr[8];
						
					}
				}
				
			}   
			fileLines ++;
		}while (line!=null);        
	  br.close();
	  fr.close();
	  System.out.println("gaopengSeeLog=====fileLines======================="+fileLines);
	  System.out.println("gaopengSeeLog=====line==================bPhone====="+bPhone);
	  System.out.println("gaopengSeeLog=====line==================bSimNo====="+bSimNo);
	  System.out.println("gaopengSeeLog=====line==================bPassWd====="+bPassWd);
	  System.out.println("gaopengSeeLog=====line==================bSimFee====="+bSimFee);
	  System.out.println("gaopengSeeLog=====line==================bPreFee====="+bPreFee);
	  System.out.println("gaopengSeeLog=====line==================bTrueName====="+bTrueName);
	  System.out.println("gaopengSeeLog=====line==================bTrueIdType====="+bTrueIdType);
	  System.out.println("gaopengSeeLog=====line==================bTrueIdNo====="+bTrueIdNo);
	  System.out.println("gaopengSeeLog=====line==================bTrueAddr====="+bTrueAddr);	  
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
		
		<%
			/********************************************
				*@�������ƣ�sBatchCustCfm
				*@�������ڣ�2014/06/03 17:03:10
				*@����汾��Ver1.0
				*@������Ա��chenlin
				*@����������
				*@���������
				strcpy(iLoginAccept, input_parms[0]); /*��ˮ
				strcpy(iChnSource, input_parms[1]); /*������ʶ
				strcpy(iOpCode, input_parms[2]); /*��������
				strcpy(iLoginNo, input_parms[3]); /*����
				strcpy(iLoginPwd, input_parms[4]); /*��������

				strcpy(iPhoneNo,		input_parms[5]);				//�ֻ�����
				strcpy(iUserPwd,		input_parms[6]);				//�ֻ�����
				strcpy(iSimNo,			input_parms[7]);				/*sim����
				
				strcpy(iGroupId,		input_parms[8]);				/*�ͻ���������
				strcpy(iCustName,		input_parms[9]);				/*�ͻ�����
				strcpy(iIdType,			input_parms[10]);				/*֤������
				strcpy(iIdIccId,		input_parms[11]);				/*֤������
				strcpy(iIdAddress,		input_parms[12]);				/*֤����ַ
				strcpy(iIdValid,		input_parms[13]);				/*֤����Ч��
				strcpy(iContactPerson,	input_parms[14]);				/*��ϵ������
				strcpy(iContactAddr,	input_parms[15]);				/*��ϵ�˵�ַ
				strcpy(iContactPhone,	input_parms[16]);				/*��ϵ�˵绰
				strcpy(iContactFax,		input_parms[17]);				/*��ϵ�˴���
				strcpy(iContactPost,	input_parms[18]);				/*��ϵ���ʱ�
				strcpy(iContactMail,	input_parms[19]);				/*��ϵ������
				strcpy(iOprName,		input_parms[20]);				/*����������
				strcpy(iOprAddr,		input_parms[21]);				/*��������ϵ��ַ
				strcpy(iOprIdType,		input_parms[22]);				/*������֤������
				strcpy(iOprIdIccId,		input_parms[23]);				/*������֤������
				strcpy(iOfferId,		input_parms[24]);				/*���ʷѴ���
				strcpy(iSimFee,			input_parms[25]);				/*sim����
				
				strcpy(iPrePayfee,		input_parms[26]);				/*Ԥ��

				
				*@���ز�����
				*@ oRetCode ���ش���
				*@ oRetMsg ������Ϣ
			*********************************************/
		%>
		
		var iLoginAccept = "<%=printAccept%>";
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=loginNo%>";
		var iLoginPwd = "<%=noPass%>";
		var iPhoneNo = "<%=bPhone%>";
		
		var iUserPwd = "<%=bPassWd%>";
		var iSimNo = "<%=bSimNo%>";
		
		var iGroupId = "<%=districtCode%>";
		var iCustName = "<%=custName%>";
		var iIdType = "<%=idType%>";
		var iIdValid = "<%=idValidDate%>";
		var iIdIccId = "<%=idIccid%>";
		var iIdAddress = "<%=idAddr%>";
		
		var iContactPerson = "<%=contactPerson%>";
		var iContactAddr = "<%=contactAddr%>";
		var iContactPhone = "<%=contactPhone%>";
		var iContactFax = "<%=contactFax%>";
		var iContactPost = "<%=contactPost%>";
		var iContactMail = "<%=contactMail%>";
		
		var iOprName = "<%=gestoresName%>";
		var iOprAddr = "<%=gestoresAddr%>";
		var iOprIdType = "<%=gestoresIdType%>";
		var iOprIdIccId = "<%=gestoresIccId%>";
		
		var iOprName2222 = "<%=responsibleName%>";
		var iOprAddr2222 = "<%=responsibleAddr%>";
		var iOprIdType2222 = "<%=responsibleType%>";
		var iOprIdIccId2222 = "<%=responsibleIccId%>";
		
		var iOfferId = "<%=selOrder%>";
		var iSimFee = "0";
		var iPrePayfee = "<%=bPreFee%>";
		var opName = "<%=opName%>";
		
		var xqdm = "<%=xqdm%>";
		var endStr = "<%=endStr%>";
		
		var path = "/npage/sm349/fm349BatCfm.jsp?iLoginAccept="+iLoginAccept;
		path += "&iChnSource="+iChnSource;
		path += "&iOpCode="+iOpCode;
		path += "&iLoginNo="+iLoginNo;
		path += "&iLoginPwd="+iLoginPwd;
		path += "&iGroupId="+iGroupId;
		path += "&iCustName="+iCustName;
		path += "&iIdType="+iIdType;
		path += "&iIdValid="+iIdValid;
		path += "&iIdAddress="+iIdAddress;
		path += "&iContactPerson="+iContactPerson;
		path += "&iContactAddr="+iContactAddr;
		path += "&iContactPhone="+iContactPhone;
		path += "&iContactFax="+iContactFax;
		path += "&iContactPost="+iContactPost;
		path += "&iContactMail="+iContactMail;
		path += "&iOprName="+iOprName;
		path += "&iOprAddr="+iOprAddr;
		path += "&iOprIdType="+iOprIdType;
		path += "&iOprIdIccId="+iOprIdIccId;
		path += "&iOprName2222="+iOprName2222;
		path += "&iOprAddr2222="+iOprAddr2222;
		path += "&iOprIdType2222="+iOprIdType2222;
		path += "&iOprIdIccId2222="+iOprIdIccId2222;
		path += "&iOfferId="+iOfferId;
		path += "&iSimFee="+iSimFee;
		path += "&iIdIccId="+iIdIccId;
		path += "&opName="+opName;
		path += "&xqdm="+xqdm;
		

		//alert(path);
		
		window.parent.frmaaa.bphones.value = "<%=bPhone%>";
		window.parent.frmaaa.userpwds.value = "<%=bPassWd%>";
		window.parent.frmaaa.simnos.value = "<%=bSimNo%>";
		window.parent.frmaaa.prepays.value = "<%=bPreFee%>";
		
		window.parent.frmaaa.bTrueNames.value = "<%=bTrueName%>";
		window.parent.frmaaa.bTrueIdTypes.value = "<%=bTrueIdType%>";
		window.parent.frmaaa.bTrueIdNos.value = "<%=bTrueIdNo%>";
		window.parent.frmaaa.bTrueAddrs.value = "<%=bTrueAddr%>";
		window.parent.frmaaa.bSimFees.value = "<%=bSimFee%>";
		window.parent.frmaaa.fjxspStr.value = "<%=endStr%>";
		
		
		window.parent.frmaaa.action = path;
		window.parent.frmaaa.method = "post";
		window.parent.frmaaa.submit();
		
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
