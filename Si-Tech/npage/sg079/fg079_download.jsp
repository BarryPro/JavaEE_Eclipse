<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%
response.reset();
String fileName = request.getParameter("fileName");
String filePath = request.getRealPath("/npage/tmp/");
String fullFileName = filePath + "/" + fileName;
System.out.println("------liujian------filename="+fileName);
System.out.println("------liujian---------fullFileName="+fullFileName);
String loginNo = (String)session.getAttribute("workNo");
String loginPwd  = (String)session.getAttribute("password");//登陆密码
String regionCode= (String)session.getAttribute("regCode");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
		<wtc:service name="sg079File" routerKey="region" routerValue="<%=regionCode%>"
			 retcode="retCodeDown" retmsg="retMsgDown" outnum="7">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="g079"/>
			<wtc:param value="<%=loginNo%>"/>	
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=fileName%>"/>
			<wtc:param value="<%=realip%>"/>
			<wtc:param value="<%=filePath%>"/>
		</wtc:service>
		<wtc:array id="downRst"  scope="end"/>
<%
if("000000".equals(retCodeDown)){


OutputStream outp = null;
FileInputStream in = null;
try{
	File file = new File(fullFileName);
	if(file.exists()) {
		response.setContentType("application/x-download");
		String filedownload = fullFileName;
		String filedisplay = fileName;
		response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);
		
		
		outp = response.getOutputStream();
		in = new FileInputStream(filedownload);
		byte[] b = new byte[1024];
		int i = 0;
		while((i = in.read(b)) > 0) {
		  outp.write(b, 0, i);
		}
		outp.flush();
	}else {
%>
		<script>
			alert("文件下载失败");
			window.close();
		</script>	
<%
	}

}catch(Exception e) {
          System.out.println("Error!");
          e.printStackTrace();
%>
		<script>
			alert("文件下载失败");
			window.close();
		</script>
<%	
}finally {
	if(in != null) {
	  in.close();
	  in = null;
	}
	if(outp != null) {
	  outp.close();
	  outp = null;
	}
}

}else{
	%>
		<script>
			alert("错误代码：<%=retCodeDown%>，错误信息：<%=retMsgDown%>");
			window.close();
		</script>
<%	
}
%>


