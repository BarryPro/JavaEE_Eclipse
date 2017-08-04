<%
/********************
 * version v3.0
 * ������: si-tech
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
	System.out.println("========================================"+myfiles.getCount());
	String path = request.getRealPath("/npage/tmp/");
	java.io.File fileNew = new java.io.File(path);
	if(!fileNew.exists()) fileNew.mkdirs();
	
	if(myfiles.getCount()>0) {
		for (int i=0; i<myfiles.getCount(); i++) {
			com.jspsmart.upload.File myFile = myfiles.getFile(i);
			if(myFile.isMissing()){
				System.out.println("file ["+i+"] is null!");
				continue;
			}
			%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
			<%
			poAttName = myFile.getFileName();
			contName = "POAttachment"+seq+"."+poAttName.split("\\.")[1];
			poAttName = contName;
			poAttNameFile = path+"/"+contName;

			System.out.println("====wanghfa==== poAttName = " + poAttName + ", poAttNameFile = "+poAttNameFile);
			System.out.println("�ϴ��ļ�:" + poAttNameFile + "\n");
			myFile.saveAs(poAttNameFile);
			System.out.println("file ["+i+"] save!");
			
			try {
				FileInputStream fis = new FileInputStream(poAttNameFile);    
				DataInputStream dis = new DataInputStream(fis); 
				
				dis.close();
				fis.close();
			} catch(IOException e) {
				e.printStackTrace();
				flag = "error";
				System.out.println("�ļ�������");
				%>
				<script>
					rdShowMessageDialog('�ļ�������!',0);
					parent.doUnLoading();
				</script>
				<%
			} catch(Exception e) {
				e.printStackTrace();
				flag = "error";
				%>
				<script>
					rdShowMessageDialog('�ļ��ϴ�����',0);
					parent.doUnLoading();
				</script>
				<%
			}
			%>
			<script>
				parent.upLoadSuccess(<%=i%>, "<%=poAttNameFile%>", "<%=poAttName%>", "<%=contName%>");
			</script>
			<%
		}
	}
	if (!"error".equals(flag)) {
		%>
		<SCRIPT>
			var vInputFile = "<%=poAttNameFile%>";
			//parent.document.getElementById("POAttachment").value=vInputFile;
			//rdShowMessageDialog('�ļ��ϴ��ɹ���',2);
			parent.doUnLoading();
			parent.nextoper();
		</SCRIPT>
		<%
	}
} catch(Exception e) {
	%>
	<script>
		rdShowMessageDialog('�ļ��ϴ�ʧ�ܣ�',0);
		parent.doUnLoading();
	</script>
	<%
	e.printStackTrace();
}
%>
