<%
/********************
 * version v1.0
 * ������: si-tech
 * author: zhangyan@2013/5/6 16:45:50
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
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAcceptss"/>
<%
try
{
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(2*1024*1024); 
	
	mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	String sysAccept = mySmartUpload.getRequest().getParameter("hd_loginacc");
	String s_opCode = mySmartUpload.getRequest().getParameter("hd_opCode");
	System.out.println("######## sysAccept = "+sysAccept);
	//String filename = iSmCode+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
	String filename = s_opCode+sLoginAcceptss+".txt";
	String path = request.getRealPath("/npage/tmp/");
	String sSaveName = path+"/"+filename;
	int phonenumss=0;
	java.io.File fileNew = new java.io.File(path);  
	if(!fileNew.exists())  
		fileNew.mkdirs();   
	System.out.println("kkkkkkkkkkkkkkkkkkkkk");
				String s_tmp="";
				String s_ret="";
	String flag="";
	String book_name="";
	String iInputFile = "";

	System.out.println("========================================"+myfiles.getCount());
	if(myfiles.getCount()>0)
	{
		for(int i=0;i<myfiles.getCount();i++)
		{
			com.jspsmart.upload.File myFile = myfiles.getFile(i);  
			if(myFile.isMissing())
			{
				System.out.println("file ["+(i+1)+"] is null!");
				continue;
			}
			String fieldName = myFile.getFieldName();
			int fileSize = myFile.getSize();
			book_name=myFile.getFileName();
			System.out.println("�ϴ��ļ�:" + sSaveName + "\n");
			iInputFile = sSaveName;
			myFile.saveAs(iInputFile);
			System.out.println("file ["+(i+1)+"] save!");
	
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
					if(!( data >= 0 && data <= 9))
					{
						flag = "error";
						throw new Exception("�ļ���ʽ����ȷ");
					}
				}
				

				FileReader fr = new FileReader( iInputFile ); 
				BufferedReader br = new BufferedReader(fr); 

				while ( ( s_tmp=br.readLine() )!= null) 
				{  
					s_ret=s_ret+s_tmp+"@";
					//System.out.println("s_ret~~~~~~~~~~~~~~~~"+s_ret);
					phonenumss++;
				}	
			
				br.close(); //�ر�BufferedReader����
				fr.close(); //�ر��ļ�				
				
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
				rdShowMessageDialog('�ļ�������!',0);
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
					rdShowMessageDialog('�ļ���ʽ����ȷ,������txt�ı��ļ���',0);
					parent.doUnLoading();
				</script>
			<%
			}
		}
		
		System.out.println("==============�ļ��ϴ����==========");
				/* ��ȡ�ļ���д��tuxedo������� */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String phoneText="";
				String line = null;
				String paraAray2[] = new String[2];
				paraAray2[0] = filename;
				paraAray2[1] = phoneText;
				do {
					line = br.readLine();
					if (line==null) continue;       
					if (line.trim().equals("")) continue;   
					phoneText+=line+"\n"; 
					System.out.println("==phoneText== " + phoneText);
					if (phoneText.length()>=1000){
						paraAray2[1] = phoneText;
%>
						<wtc:service name="sbatchWrite" routerKey="region" 
							 routerValue="<%=regionCode%>" 
									retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=paraAray2[0]%>"/>
						<wtc:param value="<%=paraAray2[1]%>"/>
						</wtc:service>
						<wtc:array id="resultArr" scope="end" />
<%
						phoneText="";
					}
				}while (line!=null);        
				br.close();
				fr.close();
				paraAray2[1] = phoneText;
%>
				<wtc:service name="sbatchWrite" routerKey="region" 
					 routerValue="<%=regionCode%>" outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr3" scope="end" />
<%					
	}
	
	System.out.println("--------------iInputFile======"+iInputFile);
	System.out.println("--------------phonenumss======"+phonenumss);
	if(!"error".equals(flag))
	{
	
	if(phonenumss>500) {

%>
<script>
    rdShowMessageDialog('�����������ܳ���500�����������ϴ��ļ���',0);
    parent.doUnLoading();
</script>
<%	
	
  }else {
	
	%>
		<SCRIPT>
		var vInputFile = "<%=iInputFile%>";
		parent.document.getElementById("inputFile").value="<%=path%>";
		parent.document.getElementById("hd_retPho").value="<%=s_ret%>";
		parent.document.getElementById("filenames").value="<%=filename%>";
		//rdShowMessageDialog('�ļ��ϴ��ɹ���',2);
		parent.refMain();
		</SCRIPT>
	<%
	}
	}
}
catch(Exception e)
{
%>
<script>
    rdShowMessageDialog('�ļ��ϴ�ʧ�ܣ�',0);
    parent.doUnLoading();
</script>
<%
e.printStackTrace();
}
%>
