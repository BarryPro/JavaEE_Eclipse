<%
/********************
 * version v3.0
 * 开发商: si-tech
 * author: zhangyan @ 2012-1-19 14:15:48
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
String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
String opName = WtcUtil.repNull(request.getParameter("pageOpName"));
String sysAccept = "";
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
	routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>

<%
sysAccept = seq;
System.out.println("zhangyan@page=[f6998_upload.jsp]seq=["+seq+"]");

try
{
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(2*1024*1024); 
	mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	String filename = "FILE6998"+sysAccept;
	String path = request.getRealPath("/npage/tmp/");
	String sSaveName = path+"/"+filename;
	System.out.println("zhangyan@page=[f6998_upload.jsp]sSaveName=["+sSaveName+"]");
	java.io.File fileNew = new java.io.File(path);  
	if(!fileNew.exists())  
	{
		fileNew.mkdirs();  
	} 

	String flag="";
	String book_name="";
	String iInputFile = "";
	System.out.println("zhangyan@page=[f6998_upload.jsp]myfiles.getCount()=["+myfiles.getCount()+"]");
	if(myfiles.getCount()>0)
	{
		for(int i=0;i<myfiles.getCount();i++)
		{
			com.jspsmart.upload.File myFile = myfiles.getFile(i);  
			if(myFile.isMissing())
			{
				continue;
			}
			String fieldName = myFile.getFieldName();
			int fileSize = myFile.getSize();
			System.out.println("zhangyan@page=[f6998_upload.jsp]fileSize=["+fileSize+"]");
			book_name=myFile.getFileName();
			iInputFile = sSaveName;
			myFile.saveAs(iInputFile);
		
			try
			{
				FileInputStream fis = new FileInputStream(iInputFile);    
				DataInputStream dis = new DataInputStream(fis); 
				System.out.println("iInputFile" +iInputFile);
				byte b;
				int data;
				int count=0;
				for(count=0; (count < 2 && count < dis.available()); count++)
				{
					b=dis.readByte();
					data = b - '0';
					if( data >= 0 && data <= 9)
					{
						System.out.println(" b = ["+b+ "]");
					}
					else
					{
					    flag = "error";
						throw new Exception("文件格式不正确");
					}
				}
				dis.close(); 
				fis.close(); 
			}
			catch(IOException e)
			{
				e.printStackTrace();
				flag = "error";
				System.out.println("文件不存在");
				%>
				<script>
					rdShowMessageDialog('文件不存在!',0);
					parent.doUnLoading();
				</script>
			<%
			}
			catch(Exception e)
			{
		    	e.printStackTrace();
		   	 	flag = "error";
				%>
				<script>
			        rdShowMessageDialog('文件格式不正确,必须是txt文本文件！',0);
			        parent.doUnLoading();
			    </script>
				<%
			}
		}
	}
	
	if(!"error".equals(flag))
	{
	%>
		<SCRIPT>
			var vInputFile = "<%=iInputFile%>";
			parent.document.getElementById("fileName").value=vInputFile;
			parent.doFileCfm();
		</SCRIPT>
	<%
	}
}
catch(Exception e)
{
%>
	<script>
	    rdShowMessageDialog('文件上传失败！',0);
	    parent.doUnLoading();
	</script>
<%
	e.printStackTrace();
}
%>
