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
 		String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		int endSize = 0;
 		
 		String serverIp=realip.trim();
	try{
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		String printAccept = mySmartUpload.getRequest().getParameter("printAccept");
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		String opName = mySmartUpload.getRequest().getParameter("opName");
		
		String phoneType = mySmartUpload.getRequest().getParameter("phoneType");
		System.out.println("------hejwa-------------phoneType------------------>"+phoneType);
		
		String phoneNo = mySmartUpload.getRequest().getParameter("i1");
		/*批量强开或者批量强关标识*/
		String opType = mySmartUpload.getRequest().getParameter("opType");
		String sOpName = "";
		if("BK".equals(opType)){
			sOpName = "批量强开";
		}
		if("BN".equals(opType)){
			sOpName = "批量强关";
		}
		/*批量强开天数*/
		String bat_open_day = mySmartUpload.getRequest().getParameter("bat_open_day");
		String force_type_sel = mySmartUpload.getRequest().getParameter("force_type_sel");
		String force_reason = mySmartUpload.getRequest().getParameter("force_reason");
		String force_judgement = mySmartUpload.getRequest().getParameter("force_judgement");
		String largeticket_time = mySmartUpload.getRequest().getParameter("largeticket_time");
		String largeticket_fee = mySmartUpload.getRequest().getParameter("largeticket_fee");
		String suboffice = mySmartUpload.getRequest().getParameter("suboffice");
		String suboffice_phone = mySmartUpload.getRequest().getParameter("suboffice_phone");
		String document_number = mySmartUpload.getRequest().getParameter("document_number");
		
		System.out.println("--------hejwa-------idocument_number------------>"+document_number);
		
		String document_date = mySmartUpload.getRequest().getParameter("document_date");
		String contact_name = mySmartUpload.getRequest().getParameter("contact_name");
		String contact_phone = mySmartUpload.getRequest().getParameter("contact_phone");
		String operator_name = mySmartUpload.getRequest().getParameter("operator_name");
		String operator_phone = mySmartUpload.getRequest().getParameter("operator_phone");
		String sysnote = mySmartUpload.getRequest().getParameter("sysnote");
		
		
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
	  int fileLines=0;
	  String line=null;
		do {
			line=br.readLine();
			if(line==null) continue;       
			if(line.trim().equals("")) continue;   
			fileLines ++;
		}while (line!=null);        
	  br.close();
	  fr.close();
	  System.out.println("gaopengSeeLog=====fileLines======================="+fileLines);
	  endSize = fileLines;
	  if(fileLines > 1000){
	  %>
	  		<script language="javascript">
					rdShowMessageDialog("处理数据超过1000条，请重新上传文件！",1);
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
	  
	}else{
		
		String sInLoginAccept = printAccept;
		String sInOpCode = "1246";
		String sInLoginNo = loginNo;
		String sInLoginPasswd = noPass;
		String sInOrgCode = regionCode;
		String sInIdNo = "";
		String sInCmdCode = "";
		String sInNewRun = "";
		if("BK".equals(opType)){
			sInNewRun = "K";
		}
		if("BN".equals(opType)){
			sInNewRun = "N";
		}
		String sInPayFee = "0";
		String sInRealFee = "0";
		String sInExpDays = bat_open_day;//强开天数
		String sInOpNote = sysnote;
		String sInIpAddr = "";
		String sForceType = force_type_sel;//强关类型
		String sFourceReason =force_reason;//强关原因
		String sForceJudgement =force_judgement;
		String sLargeTicketTime =largeticket_time;
		String sLargeTicketFee =largeticket_fee;
		String sOwningFee ="";//当前可用余额
		String sSubOffice = suboffice;
		String sSubOfficePhone = suboffice_phone;
		String sDocumentNumber = document_number;
		String sDocumentDate = document_date;
		String sOperatorName = operator_name;
		String sOperatorPhone = operator_phone;
		String sContactName = contact_name;
		String sContactPhone = contact_phone;
		String inFileName = fileNewName;
		String inServerIP = serverIp;
		String inFileDir = path+"/";
		String errFileNmae = fileNewName;
		String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
		
		String inParam[] = new String[31];
  
	  inParam[0] = sInLoginAccept   ; 
	  inParam[1] = sInOpCode				 ;
	  inParam[2] = sInLoginNo       ; 
	  inParam[3] = sInLoginPasswd   ; 
	  inParam[4] = hdorg_code       ; 
	  inParam[5] = sInIdNo          ; 
	  inParam[6] = sInCmdCode       ; 
	  inParam[7] = sInNewRun        ; 
	  inParam[8] = sInPayFee        ; 
	  inParam[9] = sInRealFee       ; 
	  inParam[10] =sInExpDays       ; 
	  inParam[11] =sInOpNote        ; 
	  inParam[12] =sInIpAddr        ; 
	  inParam[13] =sForceType       ; 
	  inParam[14] =sFourceReason    ; 
	  inParam[15] =sForceJudgement  ; 
	  inParam[16] =sLargeTicketTime ; 
	  inParam[17] =sLargeTicketFee  ; 
	  inParam[18] =sOwningFee       ; 
	  inParam[19] =sSubOffice       ; 
	  inParam[20] =sSubOfficePhone  ; 
	  inParam[21] =sDocumentNumber  ; 
	  inParam[22] =sDocumentDate    ; 
	  inParam[23] =sOperatorName    ; 
	  inParam[24] =sOperatorPhone   ; 
	  inParam[25] =sContactName     ; 
	  inParam[26] =sContactPhone    ; 
	  inParam[27] =inFileName       ; 
	  inParam[28] =inServerIP       ; 
	  inParam[29] =inFileDir        ; 
	  inParam[30] =phoneType        ; 
	  
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[0]="+inParam[0]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[1]="+inParam[1]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[2]="+inParam[2]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[3]="+inParam[3]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[4]="+inParam[4]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[5]="+inParam[5]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[6]="+inParam[6]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[7]="+inParam[7]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[8]="+inParam[8]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[9]="+inParam[9]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[10]="+inParam[10]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[11]="+inParam[11]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[12]="+inParam[12]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[13]="+inParam[13]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[14]="+inParam[14]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[15]="+inParam[15]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[16]="+inParam[16]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[17]="+inParam[17]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[18]="+inParam[18]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[19]="+inParam[19]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[20]="+inParam[20]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[21]="+inParam[21]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[22]="+inParam[22]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[23]="+inParam[23]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[24]="+inParam[24]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[25]="+inParam[25]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[26]="+inParam[26]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[27]="+inParam[27]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[28]="+inParam[28]);
	  System.out.println("gaopengSeeLog=======f1246BatCfm.jsp===========inParam[29]="+inParam[29]);
	  
	  
%>

	<script language="javascript">
		var path = "/npage/s1246/f1246Error.jsp?accept=<%=inParam[0]%>&findS=<%=endSize%>";
		window.parent.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	</script>	

<wtc:service name="s1246BatCfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
			<wtc:param value="<%=inParam[0]%>" />
			<wtc:param value="<%=inParam[1]%>" />
			<wtc:param value="<%=inParam[2]%>" />
			<wtc:param value="<%=inParam[3]%>" />
			<wtc:param value="<%=inParam[4]%>" />
			<wtc:param value="<%=inParam[5]%>" />
			<wtc:param value="<%=inParam[6]%>" />
			<wtc:param value="<%=inParam[7]%>" />
			<wtc:param value="<%=inParam[8]%>" />
			<wtc:param value="<%=inParam[9]%>" />
			<wtc:param value="<%=inParam[10]%>" />
			<wtc:param value="<%=inParam[11]%>" />
			<wtc:param value="<%=inParam[12]%>" />
			<wtc:param value="<%=inParam[13]%>" />
			<wtc:param value="<%=inParam[14]%>" />
			<wtc:param value="<%=inParam[15]%>" />
			<wtc:param value="<%=inParam[16]%>" />
			<wtc:param value="<%=inParam[17]%>" />
			<wtc:param value="<%=inParam[18]%>" />
			<wtc:param value="<%=inParam[19]%>" />
			<wtc:param value="<%=inParam[20]%>" />
			<wtc:param value="<%=inParam[21]%>" />
			<wtc:param value="<%=inParam[22]%>" />
			<wtc:param value="<%=inParam[23]%>" />
			<wtc:param value="<%=inParam[24]%>" />
			<wtc:param value="<%=inParam[25]%>" />
			<wtc:param value="<%=inParam[26]%>" />
			<wtc:param value="<%=inParam[27]%>" />
			<wtc:param value="<%=inParam[28]%>" />
			<wtc:param value="<%=inParam[29]%>" />
			<wtc:param value="<%=inParam[30]%>" />	
		</wtc:service>
		<wtc:array id="result1" scope="end" />


		
		
	
		
	
<%		
	}}catch(Exception e){
	
		%>
		<script language="javascript">
			rdShowMessageDialog("上传文件或调用服务失败！请刷新页面重新上传或联系管理员！",1);
		</script>
		<%
		e.printStackTrace();
	}
%>
