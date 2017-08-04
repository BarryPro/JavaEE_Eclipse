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
		String oaFileNo = mySmartUpload.getRequest().getParameter("oaFileNo");
		String oaFileName = mySmartUpload.getRequest().getParameter("oaFileName");
		String provLogin = mySmartUpload.getRequest().getParameter("provLogin");
		
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
	  
%>
	<script language="javascript">
		/*调用服务*/
		rdShowMessageDialog("上传文件成功，下面开始处理vip批量数据！",2);
		
		<%
			/********************************************
				*@服务名称：sm051Cfm
				*@编码日期：2014/03/12
				*@服务版本：Ver1.0
				*@编码人员：liuminga
				*@功能描述：
				*@输入参数：
				*@ iLoginAccept 业务流水
				*@ iChnSource 渠道标识
				*@ iOpCode 操作代码
				*@ iLoginNo 操作工号
				*@ iLoginPwd 工号密码
				*@ iPhoneNo 服务号码
				*@ iUserPwd 号码密码
				*@ iFileNo 文件编号
				*@ iFileName 文件名称
				*@ iOpNote 操作备注
				*@ iOpSource 操作来源：地市/省公司
				*@ iInputFile 文件路径
				*@ iFileIpAddr 文件IP地址
				
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
		var iPhoneNo = "";
		var iUserPwd = "";
		var iFileNo = "<%=oaFileNo%>";
		var iFileName = "<%=oaFileName%>";
		var iOpNote = "操作员["+iLoginNo+"]进行["+iOpCode+"]操作";
		var iOpSource = "<%=provLogin%>";
		var iInputFile = "<%=sSaveName%>";
		var iFileIpAddr = "<%=serverIp%>";
		
		var path = "/npage/sm051/fm051Cfm.jsp?iLoginAccept="+iLoginAccept;
		path += "&iChnSource="+iChnSource;
		path += "&iOpCode="+iOpCode;
		path += "&iLoginNo="+iLoginNo;
		path += "&iLoginPwd="+iLoginPwd;
		path += "&iPhoneNo="+iPhoneNo;
		path += "&iUserPwd="+iUserPwd;
		path += "&iFileNo="+iFileNo;
		path += "&iFileName="+iFileName;
		path += "&iOpNote="+iOpNote;
		path += "&iOpSource="+iOpSource;
		path += "&iInputFile="+iInputFile;
		path += "&iFileIpAddr="+iFileIpAddr;
		path += "&opName="+"<%=opName%>";
		
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
