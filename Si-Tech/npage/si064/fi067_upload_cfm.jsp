<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%

		
		/*�ͻ�����*/
		String custName = request.getParameter("custName");
		System.out.println("------------i067--------------custName----------->"+custName);
		
		/*֤������*/
		String idType = request.getParameter("idType").split("\\|")[0];
		System.out.println("------------i067--------------idType----------->"+idType);
		
		/*֤������*/
		String idIccid = request.getParameter("idIccid");
		System.out.println("------------i067--------------idIccid----------->"+idIccid);
		
		
		/*֤����ַ*/
		String idAddr = request.getParameter("idAddr");
		System.out.println("------------i067--------------idAddr----------->"+idAddr);
		
		/*֤����Ч��*/
		String idValidDate = request.getParameter("idValidDate");
		System.out.println("------------i067--------------idValidDate----------->"+idValidDate);
		
		/*��ϵ������*/
		String contactPerson = request.getParameter("contactPerson");
		System.out.println("------------i067--------------contactPerson----------->"+contactPerson);
		
		/*��ϵ�˵绰*/
		String contactPhone = request.getParameter("contactPhone");
		System.out.println("------------i067--------------contactPhone----------->"+contactPhone);
		
		/*��ϵ�˵�ַ*/
		String contactAddr = request.getParameter("contactAddr");
		System.out.println("------------i067--------------contactAddr----------->"+contactAddr);
		
		/*����������*/
		String gestoresName = request.getParameter("gestoresName");
		System.out.println("------------i067--------------gestoresName----------->"+gestoresName);
		
		/*��������ϵ��ַ*/
		String gestoresAddr = request.getParameter("gestoresAddr");
		System.out.println("------------i067--------------gestoresAddr----------->"+gestoresAddr);
		
		/*������֤������*/
		String gestoresIdType = request.getParameter("gestoresIdType").split("\\|")[0];
		System.out.println("------------i067--------------gestoresIdType----------->"+gestoresIdType);
		
		/*������֤������*/
		String gestoresIccId = request.getParameter("gestoresIccId");
		System.out.println("------------i067--------------gestoresIccId----------->"+gestoresIccId);
		
		/*��ѡ���ʷ�*/
		String selOrder = request.getParameter("selOrder");
		System.out.println("------------i067--------------selOrder----------->"+selOrder);
		
		/*����������*/
		String responsibleName = request.getParameter("responsibleName");
		System.out.println("------------i067--------------responsibleName----------->"+responsibleName);
		
		/*��������ϵ��ַ*/
		String responsibleAddr = request.getParameter("responsibleAddr");
		System.out.println("------------i067--------------responsibleAddr----------->"+responsibleAddr);
		
		/*������֤������*/
		String responsibleType = request.getParameter("responsibleType").split("\\|")[0];
		System.out.println("------------i067--------------responsibleType----------->"+responsibleType);
		
		/*������֤������*/
		String responsibleIccId = request.getParameter("responsibleIccId");		
		System.out.println("------------i067--------------responsibleIccId----------->"+responsibleIccId);
		
		String realUserName = request.getParameter("realUserName");
		System.out.println("------------i067--------------realUserName------------>"+realUserName);
		String realUserAddr = request.getParameter("realUserAddr");
		System.out.println("------------i067--------------realUserAddr------------>"+realUserAddr);
		String realUserIdType = request.getParameter("realUserIdType").split("\\|")[0];
		System.out.println("------------i067--------------realUserIdType---------->"+realUserIdType);
		String realUserIccId = request.getParameter("realUserIccId");		
		System.out.println("------------i067--------------realUserIccId----------->"+realUserIccId);
		
		
		
		
/*��ҳ�洫�ݵĲ���*/
String regCode=(String)session.getAttribute("regCode");

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
String iServerIpAddr = realip.trim();  
System.out.println("gaopeng==============="+iServerIpAddr);
String succNo = "0" ;

try
{
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(2*1024*1024); 
	
	mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	String path = request.getRealPath("/npage/tmp/");
	System.out.println("gaopeng=============="+path);
	String sSaveName = path+"/"+fileName;
	System.out.println("gaopeng=============="+sSaveName);
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
					b=dis.readByte();
		
					data = b - '0';
		
					if( !( data >= 0 && data <= 9 ) )
					{
					 	flag = "error";
						throw new Exception("�ļ���ʽ����ȷ");
					}
				}
				dis.close(); 
				fis.close(); 
    		}
    		catch(IOException e)
    		{
			    e.printStackTrace();
			    flag = "error";
				System.out.println("�ļ�������");
				%>
				<script>
					rdShowMessageDialog( "�ļ�������" , 0 );
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
					rdShowMessageDialog( "�ļ���ʽ����ȷ,������txt�ı��ļ���" , 0 );
					removeCurrentTab();
				</script>								
				<%
    		}
		}
	}
%>
	<wtc:service name="sWlwBatchDeal" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_fnDoGetProdInst" retmsg="rm_fnDoGetProdInst" >
		<wtc:param value="<%=accept%>"/>
		<wtc:param value="<%=chnSrc%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passwd%>"/>
			
			
		<wtc:param value="<%=phoNo%>"/>
		<wtc:param value="<%=usrPwd%>"/>
		<wtc:param value="<%=fileName%>"/>
		<wtc:param value="<%=iServerIpAddr%>"/>
		<wtc:param value="<%=opName%>"/>
			
		<wtc:param value=""/>
		<wtc:param value="<%=path%>"/>

		<wtc:param value="<%=custName%>"/>      <!-- strcpy(iCustName,input_parms[12]);--�ͻ�����               	-->
		<wtc:param value="<%=idType%>"/>      <!-- strcpy(iIdType,input_parms[13]);--֤������                 	-->
		<wtc:param value="<%=idIccid%>"/>      <!-- strcpy(iIdIccId,input_parms[14]);--֤������                	-->
		<wtc:param value="<%=idAddr%>"/>      <!-- strcpy(iIdAddress,input_parms[15]);--֤����ַ              	-->
		<wtc:param value="<%=idValidDate%>"/>      <!-- strcpy(iIdValid,input_parms[16]);--֤����Ч��              	-->
		<wtc:param value="<%=selOrder%>"/>      <!-- strcpy(iOfferId,input_parms[17]);--�ʷѴ���                	-->
		<wtc:param value="<%=contactPerson%>"/>      <!-- strcpy(iContactPerson,input_parms[18]);--��ϵ������        	-->						
		<wtc:param value="<%=contactAddr%>"/>      <!-- strcpy(iContactAddr,input_parms[20]);---��ϵ�˵�ַ         	-->
		<wtc:param value="<%=contactPhone%>"/>      <!-- strcpy(iContactPhone,input_parms[19]);--��ϵ�˵绰         	-->
		<wtc:param value="<%=gestoresIdType%>"/>      <!-- strcpy(iOprName,input_parms[23]);--������֤������          	-->
		<wtc:param value="<%=gestoresIccId%>"/>      <!-- strcpy(iOprAddr,input_parms[24]);---������֤������	        	-->
		<wtc:param value="<%=gestoresName%>"/>      <!-- strcpy(iOprIdType,input_parms[21]);---����������           	-->			
		<wtc:param value="<%=gestoresAddr%>"/>      <!-- strcpy(iOprIdIccId,input_parms[22]);--�����˵�ַ           	-->
		<wtc:param value="<%=responsibleType%>"/>      <!-- strcpy(iDutyIdType,input_parms[25]);--������֤������       	-->								
		<wtc:param value="<%=responsibleIccId%>"/>      <!-- strcpy(iDutyIdIccid,input_parms[26]);--������֤������      	-->
		<wtc:param value="<%=responsibleName%>"/>      <!-- strcpy(iDutyName,input_parms[27]);--����������             	-->
		<wtc:param value="<%=responsibleAddr%>"/>      <!-- strcpy(iDutyAddr,input_parms[28]);--�����˵�ַ             	-->
		<wtc:param value="<%=realUserIdType%>"/>      <!-- strcpy(iUserIdType,input_parms[29]);--ʵ��ʹ����֤������   	-->
		<wtc:param value="<%=realUserIccId%>"/>      <!-- strcpy(iUserIdIccid,input_parms[30]);--ʵ��ʹ����֤������		-->
		<wtc:param value="<%=realUserName%>"/>      <!-- strcpy(iUserName,input_parms[31]);	--ʵ��ʹ��������        	-->
		<wtc:param value="<%=realUserAddr%>"/>      <!-- strcpy(iUserAddr,input_parms[32]);--ʵ��ʹ����֤����ַ     	-->						
	
				
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
				<th>�ɹ�����</th>
				<th>������Ϣ(Ϊ��˵��ȫ���ɹ�)</th>
			</tr>
			<TR>

				<TD WIDTH = '20%' ALIGN = 'center' class = 'blue'>
					<font color = 'red'>
						�ɹ�����:<%=succNo%>
					</font>
				</TD>
				<TD WIDTH = '*' ALIGN = 'center' class = 'blue'>
					<%
					String CGI_PATH = "";
					
					//�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
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
					System.out.println("gaopeng=============FullFileName:"+FullFileName);
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
						errorMessage+=line; 
					}
					while (line!=null);       
					br.close();
					fr.close();
					}catch(Exception e) {
					%>
					<script>
						rdShowMessageDialog( "��ȡ������Ϣ�ļ�ʧ��!" , 0 );
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
						VALUE = '���ƴ�����Ϣ' onClick = 'doCfm()' />     
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' 
						VALUE = '����' onClick = 'doBack()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' 
						VALUE = '�ر�' onClick = 'removeCurrentTab()' />
				</TD>
			</TR>        
		</TABLE>
		<table>
			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>������ˮ</td>
				<td><%=accept%>&nbsp;&nbsp<font class="orange"><%if("i067".equals(opCode) || "i068".equals(opCode)){%>����ˮ������i072����ҵ������ѯ��m239������ҵ��ͨ״̬��ѯ  ��ѯʹ��<%}else{%>����ˮ������i072����ҵ������ѯ  ��ѯʹ��<%}%></font></td>
			</tr>
		</table>
	</DIV>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>	

<SCRIPT>
	$( document ).ready(
		function ()
		{
			$( "#d0" ).show( 300 );
		}
	);	
	
	function doBack()
	{
		window.location = 'fi064_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';	
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
					alert("��������ܾ���\n�����������ַ������'about:config'���س�"
						+"\nȻ�� 'signed.applets.codebase_principal_support'����Ϊ'true'");   
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
			alert("���Ƴɹ���")
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
			rdShowMessageDialog( "�ļ��ϴ�ʧ��!" , 0 );
			removeCurrentTab();
		</script>					
	<%	
}%>
