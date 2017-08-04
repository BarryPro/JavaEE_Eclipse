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
	
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="sysAccept"/>
<%

		String ipAddr = realip;


try
{
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 
		mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	
	
		String opName    = mySmartUpload.getRequest().getParameter("opName");
		String opCode    = mySmartUpload.getRequest().getParameter("opCode");
		String busi_type = mySmartUpload.getRequest().getParameter("busi_type");
		String op_type   = mySmartUpload.getRequest().getParameter("op_type");
	
		String fileName = loginNo+"_"+opCode + "_" + sysAccept + ".txt" ;
		
		
		
		
		
	String path = request.getRealPath("/npage/tmp/");
	String sSaveName = path+"/"+fileName;
	
	System.out.println("-------hejwa--------path----------------->"+path);
	System.out.println("-------hejwa--------sSaveName----------------->"+sSaveName);
	
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
				int count=0;
				for(count=0; (count < 2 && count < dis.available()); count++)
				{
					b=dis.readByte();
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
	
		
		
	//7个标准化入参
	String paraAray[] = new String[13];
	
	paraAray[0] = sysAccept;                                //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = loginNo;   //工号
	paraAray[4] = passWord; //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = "备注"; 
	paraAray[8] = fileName; 
	paraAray[9] = ipAddr; 
	paraAray[10] = path; 
	paraAray[11] = busi_type; 
	paraAray[12] = op_type;
	

%>
	
	<wtc:service name="sm489Cfm" outnum="4" routerKey="region" routerValue="<%=regCode%>"  retcode="rc_sm489Cfm" retmsg="rm_sm489Cfm" >
			<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------[sm489Cfm]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>		
	</wtc:service>
	<wtc:array id="result_sm489Cfm1" scope="end" start="0"  length="2"  />
	<wtc:array id="result_sm489Cfm2" scope="end" start="2"  length="2"  />
<%

	System.out.println("hejwa----rc_sm489Cfm="+rc_sm489Cfm);
	
 
	
	String result_sues_num = "";
	String result_fail_num = "";
	if(result_sm489Cfm2.length>0){
		result_sues_num = result_sm489Cfm2[0][0];
		result_fail_num = result_sm489Cfm2[0][1];
	}
	
	if (!rc_sm489Cfm.equals("000000")) {
	%>
		<script>
			rdShowMessageDialog( "<%=rc_sm489Cfm%>:<%=rm_sm489Cfm%>" , 0 );
			removeCurrentTab();
		</script>	   
	<%    
	}	
%>

<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
</HEAD>
<BODY>
<FORM id="form1" name="form1" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%>错误信息</div></div>

		
		<table  cellSpacing="0">
			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>操作流水</td>
				<td><%=sysAccept%>&nbsp;&nbsp;</td>
			</tr>
		</table>
		
		<TABLE  cellSpacing="0">
			<tr>
				<td width="50%">成功记录数：<%=result_sues_num%></td>
				<td width="50%">失败记录数：<%=result_fail_num%></td>
			</tr>  
		</TABLE>
		
		<TABLE  cellSpacing="0">
			<tr>
				<th width="20%">失败记录</th>
				<th>失败原因</th>
			</tr>  
<%
for(int i=0;i<result_sm489Cfm1.length;i++){
%>
			<tr>
				<td width="20%"><%=result_sm489Cfm1[i][0]%></td>
				<td><%=result_sm489Cfm1[i][1]%></td>
			</tr>  
<%
}
%>			
		</TABLE>
		

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
		
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%
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

%>