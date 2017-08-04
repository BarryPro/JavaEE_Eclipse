<%
/********************
 * version v3.0
 * 开发商: si-tech
 * author: wangzn 2010-3-23 14:49:16
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>

<%
try {
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(10*1024*1024); 
	
	mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	//String iSmCode = mySmartUpload.getRequest().getParameter("sm_code");
	
	String flag="";
	String poAttNameFile = "";
	String poAttName = "";
	String contName = "";
	String path = request.getRealPath("/npage/tmp/");
	java.io.File fileNew = new java.io.File(path);
	if(!fileNew.exists()) fileNew.mkdirs();
	
		System.out.println("-------hejwa2002-----------myfiles.getCount()-------------------->"+myfiles.getCount());
		
	if(myfiles.getCount()>0) {
			com.jspsmart.upload.File myFile = myfiles.getFile(0);
			
			System.out.println("-------hejwa2002-----------myfiles.isMissing()-------------------->"+myFile.isMissing());
			if(myFile.isMissing()){
				flag = "error";
				%>
				<script>
					rdShowMessageDialog('文件不存在!',0);
					parent.doUnLoading();
				</script>
				<%
			}
			%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
			<%
			poAttName = myFile.getFileName();
			contName = "CustIdScFile"+seq+"."+poAttName.split("\\.")[1];
			poAttName = contName;
			poAttNameFile = path+"/"+contName;

System.out.println("-------hejwa2002----------poAttName------------------->"+poAttName);
System.out.println("-------hejwa2002----------contName-------------------->"+contName);
System.out.println("-------hejwa2002----------poAttNameFile--------------->"+poAttNameFile);


			myFile.saveAs(poAttNameFile);
			System.out.println("-------hejwa2002----------1ok--------------->");
			try {
				FileInputStream fis = new FileInputStream(poAttNameFile);    
				DataInputStream dis = new DataInputStream(fis); 
				System.out.println("-------hejwa2002----------2ok--------------->");
				dis.close();
				fis.close();
			} catch(IOException e) {
				e.printStackTrace();
				flag = "error";
				System.out.println("文件不存在");
				%>
				<script>
					rdShowMessageDialog('文件不存在!',0);
					parent.doUnLoading();
				</script>
				<%
			} catch(Exception e) {
				e.printStackTrace();
				flag = "error";
				%>
				<script>
					rdShowMessageDialog('文件上传错误！',0);
					parent.doUnLoading();
				</script>
				<%
				
				
			}
			
			System.out.println("-------hejwa2002----------flag--------------->"+flag);


				if (!"error".equals(flag)) {
						%>
						<SCRIPT>
							parent.upLoadSuccess("<%=poAttNameFile%>",  "<%=contName%>");
						</SCRIPT>
						<%
					}			 
	}
	
} catch(Exception e) {
	%>
	<script>
		rdShowMessageDialog('文件上传失败！',0);
		parent.doUnLoading();
	</script>
	<%
	e.printStackTrace();
}
%>
