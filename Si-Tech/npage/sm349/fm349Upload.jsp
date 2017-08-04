<%
/********************
 * version v1.0
 * 开发商: si-tech
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
		/*流水*/
		String printAccept = mySmartUpload.getRequest().getParameter("printAccept");
		/*业务代码*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*业务名称*/
		String opName = mySmartUpload.getRequest().getParameter("opName");
		
		/*客户类别*/
		String ownerType = mySmartUpload.getRequest().getParameter("ownerType");
		
		/*个人开户分类*/
		String isJSX = mySmartUpload.getRequest().getParameter("isJSX");
		/*客户归属市县*/
		String districtCode = mySmartUpload.getRequest().getParameter("districtCode");
		
		/*客户名称*/
		String custName = mySmartUpload.getRequest().getParameter("custName");
		
		/*证件类型*/
		String idType = mySmartUpload.getRequest().getParameter("idType").split("\\|")[0];
		
		/*证件号码*/
		String idIccid = mySmartUpload.getRequest().getParameter("idIccid");
		
		/*证件地址*/
		String idAddr = mySmartUpload.getRequest().getParameter("idAddr");
		/*证件有效期*/
		String idValidDate = mySmartUpload.getRequest().getParameter("idValidDate");
		/*客户地址*/
		String custAddr = mySmartUpload.getRequest().getParameter("custAddr");
		/*联系人姓名*/
		String contactPerson = mySmartUpload.getRequest().getParameter("contactPerson");
		/*联系人电话*/
		String contactPhone = mySmartUpload.getRequest().getParameter("contactPhone");
		/*联系人地址*/
		String contactAddr = mySmartUpload.getRequest().getParameter("contactAddr");
		/*联系人邮编*/
		String contactPost = mySmartUpload.getRequest().getParameter("contactPost");
		/*联系人传真*/
		String contactFax = mySmartUpload.getRequest().getParameter("contactFax");
		/*联系人E_MAIL*/
		String contactMail = mySmartUpload.getRequest().getParameter("contactMail");
		/*联系人通讯地址*/
		String contactMAddr = mySmartUpload.getRequest().getParameter("contactMAddr");
		
		/*经办人姓名*/
		String gestoresName = mySmartUpload.getRequest().getParameter("gestoresName");
		/*经办人联系地址*/
		String gestoresAddr = mySmartUpload.getRequest().getParameter("gestoresAddr");
		/*经办人证件类型*/
		String gestoresIdType = mySmartUpload.getRequest().getParameter("gestoresIdType").split("\\|")[0];
		/*经办人证件号码*/
		String gestoresIccId = mySmartUpload.getRequest().getParameter("gestoresIccId");
		/*可选主资费*/
		String selOrder = mySmartUpload.getRequest().getParameter("selOrder");
		/*用户备注*/
		String sysNote = mySmartUpload.getRequest().getParameter("sysNote");
		
		
		/*责任人姓名*/
		String responsibleName = mySmartUpload.getRequest().getParameter("responsibleName");

		/*责任人联系地址*/
		String responsibleAddr = mySmartUpload.getRequest().getParameter("responsibleAddr");

		/*责任人证件类型*/
		String responsibleType = mySmartUpload.getRequest().getParameter("responsibleType").split("\\|")[0];

		/*责任人证件号码*/
		String responsibleIccId = mySmartUpload.getRequest().getParameter("responsibleIccId");		
		
		/*小区代码*/
		String xqdm = mySmartUpload.getRequest().getParameter("s_60001");
		if(xqdm == null || "".equals(xqdm)){
			xqdm = "";
		}
		/*附加产品串信息*/
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
				System.out.println("上传文件:" + sSaveName + "\n");
				iInputFile = sSaveName;
				myFile.saveAs(iInputFile);
				System.out.println("file ["+(i+1)+"] save!");
			}
		}
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  
	  /*手机号码*/
	  String bPhone ="";
	  /*SIM卡号码*/
	  String bSimNo = "";
	  /*密码*/
	  String bPassWd = "";
	  /*SMI卡费*/
	  String bSimFee = "";
	  /*预存*/
	  String bPreFee = "";
	  /*实际使用人姓名*/
	  String bTrueName = "";
	  /*实际使用人证件类型*/
	  String bTrueIdType = "";
	  /*实际使用人证件号码*/
	  String bTrueIdNo = "";
	  /*实际使用人联系地址*/
	  String bTrueAddr = "";
	  
	  /*上传文件的格式是否正确*/
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
					rdShowMessageDialog("处理数据超过100条，请重新上传文件！",1);
				</script>
	  <%
	  /*删除*/
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
					rdShowMessageDialog("上传文件列数不对，请重新上传文件！",1);
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
		/*调用服务*/
		rdShowMessageDialog("读取文件成功，下面开始处理批量数据！",2);
		
		<%
			/********************************************
				*@服务名称：sBatchCustCfm
				*@编码日期：2014/06/03 17:03:10
				*@服务版本：Ver1.0
				*@编码人员：chenlin
				*@功能描述：
				*@输入参数：
				strcpy(iLoginAccept, input_parms[0]); /*流水
				strcpy(iChnSource, input_parms[1]); /*渠道标识
				strcpy(iOpCode, input_parms[2]); /*操作代码
				strcpy(iLoginNo, input_parms[3]); /*工号
				strcpy(iLoginPwd, input_parms[4]); /*工号密码

				strcpy(iPhoneNo,		input_parms[5]);				//手机号码
				strcpy(iUserPwd,		input_parms[6]);				//手机密码
				strcpy(iSimNo,			input_parms[7]);				/*sim卡号
				
				strcpy(iGroupId,		input_parms[8]);				/*客户归属市县
				strcpy(iCustName,		input_parms[9]);				/*客户名称
				strcpy(iIdType,			input_parms[10]);				/*证件类型
				strcpy(iIdIccId,		input_parms[11]);				/*证件号码
				strcpy(iIdAddress,		input_parms[12]);				/*证件地址
				strcpy(iIdValid,		input_parms[13]);				/*证件有效期
				strcpy(iContactPerson,	input_parms[14]);				/*联系人姓名
				strcpy(iContactAddr,	input_parms[15]);				/*联系人地址
				strcpy(iContactPhone,	input_parms[16]);				/*联系人电话
				strcpy(iContactFax,		input_parms[17]);				/*联系人传真
				strcpy(iContactPost,	input_parms[18]);				/*联系人邮编
				strcpy(iContactMail,	input_parms[19]);				/*联系人邮箱
				strcpy(iOprName,		input_parms[20]);				/*经办人姓名
				strcpy(iOprAddr,		input_parms[21]);				/*经办人联系地址
				strcpy(iOprIdType,		input_parms[22]);				/*经办人证件类型
				strcpy(iOprIdIccId,		input_parms[23]);				/*经办人证件号码
				strcpy(iOfferId,		input_parms[24]);				/*主资费代码
				strcpy(iSimFee,			input_parms[25]);				/*sim卡费
				
				strcpy(iPrePayfee,		input_parms[26]);				/*预存

				
				*@返回参数：
				*@ oRetCode 返回代码
				*@ oRetMsg 返回信息
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
			rdShowMessageDialog("上传文件失败！请刷新页面重新上传或联系管理员！",1);
		</script>
		<%
		e.printStackTrace();
	}
%>
