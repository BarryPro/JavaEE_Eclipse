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
		
		/*导入类型*/
		String upload_type = mySmartUpload.getRequest().getParameter("upload_type");
		/*业务代码*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*业务名称*/
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
				System.out.println("上传文件:" + sSaveName + "\n");
				iInputFile = sSaveName;
				myFile.saveAs(iInputFile);
				System.out.println("file ["+(i+1)+"] save!");
			}
		}
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  
	  /*上传文件的格式是否正确*/
	  boolean uploadLieFlag  = false;
	  
	  /*0 */ String iLoginAccept		     = "0"; /*流水*/
		/*1 */ String iChnSource		       = "01"; /*渠道标识*/
		/*2 */ String iOpCode	           = opCode; /*操作代码*/
		/*3 */ String iLoginNo            = loginNo; /*工号*/
		/*4 */ String iLoginPwd	         = noPass; /*工号密码*/	
		/*5 */ String iOpNote	           = "集团产品用户信息补全,批量导入"+upload_type; /*备注*/
		/*6 */ String iPhoneNo	           = ""; /*手机号码*/
		/*7 */ String iOprName				     = ""; /*经办人姓名*/
		/*8 */ String iOprAddr				     = ""; /*经办人联系地址*/
		/*9 */ String iOprIdType			     = ""; /*经办人证件类型*/
		/*10*/ String iOprIdIccId	       = ""; /*经办人证件号码*/
		/*11*/ String iActualName			   = ""; /*实际使用人姓名*/
		/*12*/ String iActualAddr			   = ""; /*实际使用人联系地址*/
		/*13*/ String iActualIdType			 = ""; /*实际使用人证件类型*/
		/*14*/ String iActualIdIccId		   = ""; /*实际使用人证件号码*/
		/*15*/ String iFlag			         = upload_type; /*上传文件的方式1.经办人导入2实际使用人导入3经办人和实际使用人导入*/		
		/*11*/ String zerenlName			   = ""; /*责任使用人姓名*/
		/*12*/ String zerenAddr			   = ""; /*责任人联系地址*/
		/*13*/ String zerenIdType			 = ""; /*责任人证件类型*/
		/*14*/ String zerenIdIccId		   = ""; /*责任人证件号码*/



	  int fileLines=0;
	  String line=null;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;
			
			if(line!=null && !line.trim().equals("")){
				String arr[] = line.split("\\|");
				 
				 uploadLieFlag = true;
				 
				 //手机号码|经办人姓名|经办人地址|经办人证件|经办人证件号码
				 	if("1".equals(upload_type)){//导入经办人信息
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
				 		//手机号码|实际使用人姓名|实际使用人地址|实际使用人证件|实际使用人证件号码
					}else if("2".equals(upload_type)){//导入实际使用人信息
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
				 		//手机号码|经办人姓名|经办人地址|经办人证件|经办人证件号码|实际使用人姓名|实际使用人地址|实际使用人证件|实际使用人证件号码
					}else if("3".equals(upload_type)){//导入经办人和实际使用人信息
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
					}else if("4".equals(upload_type)){//导入责任人信息
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
			rdShowMessageDialog("上传文件失败！请刷新页面重新上传或联系管理员！",1);
		</script>
		<%
		e.printStackTrace();
	}
%>
                      