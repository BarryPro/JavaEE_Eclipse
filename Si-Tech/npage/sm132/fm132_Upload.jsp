<%
  /*
   * 功能: 校园信息录入 m132
   * 版本: 1.0
   * 日期: 2014/6/27
   * 作者: 
   * 版权: si-tech
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
		
		/*业务代码*/
		String opCode = mySmartUpload.getRequest().getParameter("opCode");
		/*业务名称*/
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
							rdShowMessageDialog("文件丢失或上传不成功！", 0);
							window.location.href="/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
<%
					continue;
				}else{
					String fieldName = myFile.getFieldName();
					System.out.println("diling---上传文件:" + sSaveName + "\n");
					myFile.saveAs(sSaveName);
					System.out.println("file ["+(i+1)+"] save!");
				}
			}
		}
		
		
		
		FileReader fr = new FileReader(sSaveName);
	  BufferedReader br = new BufferedReader(fr);   
	  
	  /*身份证号码*/
	  String bCardNo ="";
	  /*客户名称*/
	  String bCustName = "";
	  /*学校名称*/
	  String bSchoolName = "";
	  /*专业名称*/
	  String bMajorName = "";
	  /*住址*/
	  String bAddrs = "";
	  /*上传文件的格式是否正确*/
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
					rdShowMessageDialog("处理数据超过100条，请重新上传文件！",1);
					window.location.href="/npage/sm132/fm132_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		/*调用服务*/
		rdShowMessageDialog("读取文件成功，下面开始处理批量数据！",2);
		
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
			rdShowMessageDialog("上传文件失败！请刷新页面重新上传或联系管理员！",1);
			window.location.href="/npage/sm132/fm132_main.jsp?opCode=m132&opName=校园信息录入";
		</script>
		<%
		e.printStackTrace();
	}
%>

