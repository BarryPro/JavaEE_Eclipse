<%
/********************
 * version v3.0
 * 开发商: si-tech
 * author: wanghfa @ 2012-02-02
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>

<%
	String regionCode = (String)session.getAttribute("regCode");
	boolean successFlag = true;
	SmartUpload su = new SmartUpload();
	
	try {
		su.initialize(pageContext);
		su.upload();
		
		com.jspsmart.upload.Files myfiles = su.getFiles();
		String[] attachments = su.getRequest().getParameterValues("attachment");
		String[] attachmentFiles = su.getRequest().getParameterValues("attachmentFile");
		
		for (int i = 0; i < myfiles.getCount(); i ++) {
			com.jspsmart.upload.File file = su.getFiles().getFile(i);
			%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="seq"/>
			<%
			//String attachment = file.getFileName();
			//System.out.println("====wanghfa==== attachments["+i+"] = " + attachments[i]);
			//String acceptFileName = attachmentFiles[i] + "." + file.getFileExt();
			//System.out.println("====fe555_upload.jsp attachment = " + acceptFileName);
			String attachmentFile = null;
			if (!file.isMissing()) {
				String path = request.getRealPath("/npage/tmp/");
				//attachmentFile = path+"/"+acceptFileName;
				attachmentFile = attachmentFiles[i];
				file.saveAs(attachmentFile);
				System.out.println("====fe555_upload.jsp 存储成功");
			}
			%>
			<SCRIPT>
				//parent.test(<%=i%>, "<%=attachmentFile%>");
				//parent.productOrderInfo.dealInfos[<%=i%>].attachmentFile = "<%=attachmentFile%>";
				//parent.attachmentSuccess(<%=i%>, "<%=attachments[i]%>", "<%=attachmentFiles[i]%>");
			</SCRIPT>
			<%
		}
	} catch(SecurityException se) {
%>
		<script type="text/javascript">
			rdShowMessageDialog("上传失败！请选择正确的文件格式。");
			//window.opener.upLoadFail();
		</script>
<%
		se.printStackTrace(); 
	} catch(Exception e) {
%>
		<script type="text/javascript">
			rdShowMessageDialog("上传失败！");
			//window.opener.upLoadFail();
		</script>
<%
		e.printStackTrace(); 
	}
	if (successFlag == true) {
		%>
		<SCRIPT>
			//rdShowMessageDialog('文件上传成功！',2);
			window.close();
		</SCRIPT>
		<%
	}
%>