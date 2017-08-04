<%
/********************
 *	zhangyan@2013/9/18 15:17:55
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
String regCode = ( String )session.getAttribute( "regCode" );

String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = request.getParameter( "workNo" );
String passwd = request.getParameter( "passwd" );

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = request.getParameter( "usrPwd" );
String fileName = opCode + "_" + accept + ".txt" ;
String ipAddr = ( String )session.getAttribute ( "ipAddr" );

String opName = request.getParameter("opName");
String iServerIpAddr = realip;  
%>

<%
try
{
	SmartUpload mySmartUpload = new SmartUpload();
    mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(4*1024*1024); 

    mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	String path = request.getRealPath("/npage/tmp/");
	String sSaveName = path+"/"+fileName;
	java.io.File fileNew = new java.io.File(path);  
	if(!fileNew.exists())  
	{
		fileNew.mkdirs();
	}

	String flag="";
	String book_name="";
	String iInputFile = "";
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

			book_name=myFile.getFileName();
			
			iInputFile = sSaveName;
			myFile.saveAs(iInputFile);

			try
			{
				FileInputStream fis = new FileInputStream(iInputFile);    
				DataInputStream dis = new DataInputStream(fis); 
				byte b;
				int data;
				int count=0;
				for(count=0; (count < 2 && count < dis.available()); count++)
				{
					System.out.println(  );
					b=dis.readByte();
		
					data = b - '0';
		
					if( !( data >= 0 && data <= 9 ) )
					{
					 	flag = "error";
						throw new Exception("文件格式不正确");
					}
				}
				System.out.println( "count================"+count );
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
					window.location='f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
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
					window.location='f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
				</script>
				<%
    		}
		}
	}
	if(!"error".equals(flag))
	{
	%>
		<wtc:service name="sSpBatchFileCfm"  outnum="3" routerKey="region" routerValue="01"  
			retcode="rtc" retmsg="rtm"  >
			<wtc:param value = "<%=accept%>"/>
			<wtc:param value = "<%=chnSrc%>"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=workNo%>"/>
			<wtc:param value = "<%=passwd%>"/>

			<wtc:param value = "<%=phoNo%>"/>
			<wtc:param value = "<%=usrPwd%>"/>
			<wtc:param value="<%=fileName%>"/>
			<wtc:param value="<%=iServerIpAddr%>"/>
		</wtc:service>
		<wtc:array id="rst" scope="end" />
			
<%
		if("000000".equals(rtc))
		{
		%>
			<script>
				rdShowMessageDialog('请记住此流水号：<%=accept%> 用于后续查询批量开通结果。',2);
				window.location='f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>

		<%
		}
		else 
		{
		%>
			<script>
				rdShowMessageDialog('服务提交失败！错误代码<%=rtc%>，错误原因<%=rtm%>',0);
				window.location='f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			</script>
		<%
		}
	}
}catch(Exception e){
%>
<script>
    rdShowMessageDialog('文件上传失败，请检查文件大小，格式，内容等信息！',0);
    window.location='f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
</script>
<%
e.printStackTrace();
}
%>