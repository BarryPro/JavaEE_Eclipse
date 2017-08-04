   
<%
/********************
 version v2.0
 开发商 si-tech
 create hejw@2009-3-17
********************/
%>
              
<%
  String opCode = "1885";
  String opName = "身份证扫描件稽核报表";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.uploadftp.*"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	String picName=request.getParameter("picName");
  String fileName=request.getRealPath("npage/cust_ID1250")+"/";
  
  System.out.println(fileName);
  
  File filePic =new File(fileName);
  boolean ccc = filePic.delete();
  DeleteFileUtil dfu =new DeleteFileUtil();
  dfu.delete(fileName);
%>
 