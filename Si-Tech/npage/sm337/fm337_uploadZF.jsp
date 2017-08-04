<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/03/24 liangyl 关于按宽带小区限定办理宽带单品资费的请示需求
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String loginNo = (String)session.getAttribute("workNo");
	String regCode=(String)session.getAttribute("regCode");
	String passWord = (String)session.getAttribute("password");
	String succNo = "0" ;
	String opName="宽带小区与资费批量";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="sysAccept"/>
<%
		System.out.println("------------m337-------------- 开始----------->");
		String ipAddr = realip;
		/*操作类型*/
		String qudaodaoruType ="";// request.getParameter("qudaodaoruType");
		String opCode = "m337";
		String fileName = opCode + "_" + sysAccept + ".txt" ;
		int count_row = 0;
		String zifeidaoruType="";

try
{
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(2*1024*1024); 
	
	mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	String path = request.getRealPath("/npage/tmp/");
	System.out.println("liangyl==path============"+path);
	String sSaveName = path+"/"+fileName;
	System.out.println("liangyl==sSaveName============"+sSaveName);
	java.io.File fileNew = new java.io.File(path);
	zifeidaoruType = mySmartUpload.getRequest().getParameter("zifeidaoruType");
	System.out.println("liangyl===zifeidaoruType==========="+zifeidaoruType);
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
					b=dis.readByte();
					data = b - '0';
					if( !( data >= 0 && data <= 9 ) )
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
					rdShowMessageDialog( "文件不存在" , 0 );
					removeCurrentTab();
				</script>
    			<%
    		}
    		catch(Exception e)
			{
				e.printStackTrace();
				flag = "error";
				%>	
				<script>
					rdShowMessageDialog( "文件格式不正确,必须是txt文本文件！" , 0 );
					removeCurrentTab();
				</script>								
				<%
    		}
		}
	
}
%>
	<wtc:service name="sAreaOfferMsg" outnum="30" routerKey="region" routerValue="<%=regCode%>"  retcode="rc_fnDoGetProdInst" retmsg="rm_fnDoGetProdInst" >
		<wtc:param value="<%=sysAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=fileName%>"/>
        <wtc:param value="<%=ipAddr%>"/>
        <wtc:param value="<%=path%>"/>
        <wtc:param value="<%=zifeidaoruType%>"/>					
	</wtc:service>
	<wtc:array id="rst_fnDoGetProdInst" scope="end" />
<%
	System.out.println("diling----rc_fnDoGetProdInst="+rc_fnDoGetProdInst);
	if (rc_fnDoGetProdInst.equals("000000"))
	{
		succNo = rst_fnDoGetProdInst[0][0] ;
		System.out.println("diling----rst_fnDoGetProdInst[0][0]="+rst_fnDoGetProdInst[0][0]);
%>
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></SCRIPT>
</HEAD>
<BODY>

<FORM  NAME = "frm" ACTION = "" METHOD = "POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV class = "title" >
			<DIV id = "title_zi"><%=opName%></DIV>
		</DIV>
		<TABLE>
			<tr>
				<th>成功数量</th>
				<th>错误信息(为空说明全部成功)</th>
			</tr>
			<TR>

				<TD WIDTH = '10%' ALIGN = 'center' class = 'blue'>
					<font color = 'red'>
						成功个数:<%=succNo%>
					</font>
				</TD>
				<TD WIDTH = '*' ALIGN = 'center' class = 'blue'>
					<%
					String CGI_PATH = "";
					
					//从公共配置文件中读取配置信息，此信息被多sever共享
					CGI_PATH = SystemUtils.getConfig("CGI_PATH");
					
					if (!CGI_PATH.endsWith("/")) 
					{
						CGI_PATH = CGI_PATH + "/";
					}
					String[] paths=CGI_PATH.split("/"); 
					CGI_PATH="";
					for(int i=0;i<paths.length-1;i++)
					{
						CGI_PATH+=paths[i]+"/";
					} 
	
					String webpath=request.getContextPath();
					String FullFileName =CGI_PATH+"npage/tmp/"+fileName+".err";
					System.out.println("liangyl=============FullFileName:"+FullFileName);
					String errorMessage="";
					String line=null;
					try{
					FileReader fr = new FileReader(FullFileName);
					BufferedReader br = new BufferedReader(fr);   
					
					do 
					{
						line=br.readLine();
						if(line==null) continue;       
						if(line.trim().equals("")) continue;   
						errorMessage+=line+"<br/>"; 
					}
					while (line!=null);       
					br.close();
					fr.close();
					}catch(Exception e) {
					%>
					<script>
						rdShowMessageDialog( "获取错误信息文件失败!"+"<%=e%>" , 0 );
						removeCurrentTab();
					</script>				
					<%		
					}
					%>
					
					<%=errorMessage%>

					<input type = 'hidden' id ='errMsg' name = 'errMsg' 
						value = '<%=errorMessage%>'>
				</TD>				
			</tr>
			
			<TR>
				<TD COLSPAN = '2' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' 
						VALUE = '复制错误信息' onClick = 'doCfm()' />     
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' 
						VALUE = '返回' onClick = 'doBack()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' 
						VALUE = '关闭' onClick = 'removeCurrentTab()' />
				</TD>
			</TR>        
		</TABLE>
		<table>
			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>操作流水</td>
				<td><%=sysAccept%>&nbsp;&nbsp;</td>
			</tr>
		</table>
	</DIV>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>	

<SCRIPT>
	$( document ).ready(
		function ()
		{
			$( "#d0" ).show(300);
		}
	);	
	
	function doBack()
	{
		window.location = 'fm337.jsp?opCode=<%=opCode%>&opName=<%=opName%>';	
	}
	
	function doCfm()
	{
			var txt = $("#errMsg").val();
			if(window.clipboardData) 
			{   
				window.clipboardData.clearData();   
				window.clipboardData.setData("Text", txt);   
			} 
			else if(navigator.userAgent.indexOf("Opera") != -1) 
			{   
				window.location = txt;   
			} 
			else if (window.netscape) 
			{   
				try 
				{   
					netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");   
				} 
				catch (e) 
				{   
					alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车"
						+"\n然后将 'signed.applets.codebase_principal_support'设置为'true'");   
				}   
				
				var clip = Components.classes['@mozilla.org/widget/clipboard;1']
					.createInstance(Components.interfaces.nsIClipboard);
					   
				if (!clip) return; 
				  
				var trans = Components.classes['@mozilla.org/widget/transferable;1']
					.createInstance(Components.interfaces.nsITransferable);
					   
				if (!trans) return;   
				
				trans.addDataFlavor('text/unicode');   
				var str = new Object();   
				var len = new Object();   
				var str = Components.classes["@mozilla.org/supports-string;1"]
					.createInstance(Components.interfaces.nsISupportsString);
					
				var copytext = txt;   
				str.data = copytext;   
				trans.setTransferData("text/unicode",str,copytext.length*2);   
				var clipid = Components.interfaces.nsIClipboard;   
				
				if (!clip) return false;   
				
				clip.setData(trans,null,clipid.kGlobalClipboard);   
			}   
			alert("复制成功！");
	}	
</SCRIPT>
<FORM>
</BODY>
</HTML>
<%
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "<%=rc_fnDoGetProdInst%>:<%=rm_fnDoGetProdInst%>" , 0 );
			removeCurrentTab();
		</script>	   
	<%    
	}	
}
catch ( Exception e )
{
	%>
		<script>
			rdShowMessageDialog( "文件上传失败!" , 0 );
			removeCurrentTab();
		</script>					
	<%	
}

System.out.println("------------i067-------------- 结束----------->");
%>