<%
/********************
 * version v3.0
 * ������: si-tech
 * author: qidp @ 2009-05-10
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

<%try{
		SmartUpload mySmartUpload = new SmartUpload();
        mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 

        mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		String iSmCode = mySmartUpload.getRequest().getParameter("sm_code");
		String sysAccept = mySmartUpload.getRequest().getParameter("sysAccept");
		System.out.println("######## sysAccept = "+sysAccept);
		System.out.println("iiiiiiiiiiiiiiiiiiiiiiiSmCode = "+iSmCode);
		//String filename = iSmCode+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		String filename = iSmCode+sysAccept;
		String path = request.getRealPath("/npage/tmp/");
		String sSaveName = path+"/"+filename;
        java.io.File fileNew = new java.io.File(path);  
        if(!fileNew.exists())  
            fileNew.mkdirs();   
		System.out.println("kkkkkkkkkkkkkkkkkkkkk");

		String flag="";
		String book_name="";
		String iInputFile = "";

		System.out.println("======zhoubym=========="+myfiles.getCount());
			if(myfiles.getCount()>0)
				{
				for(int i=0;i<myfiles.getCount();i++){
				com.jspsmart.upload.File myFile = myfiles.getFile(i);  
					if(myFile.isMissing()){
    					System.out.println("file ["+(i+1)+"] is null!");
    					continue;
					}
					String fieldName = myFile.getFieldName();
					int fileSize = myFile.getSize();
					book_name=myFile.getFileName();
					System.out.println("zhoubym �ϴ��ļ�:" + sSaveName + "\n");
					iInputFile = sSaveName;
					myFile.saveAs(iInputFile);
					System.out.println("file ["+(i+1)+"] save!");
					
					try{
        				FileInputStream fis = new FileInputStream(iInputFile);    
        				DataInputStream dis = new DataInputStream(fis); 
        				byte b;
        				int data;
        				int count=0;
        				for(count=0; (count < 2 && count < dis.available()); count++)
        				{
        					b=dis.readByte();
        					System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb--"+b);
        					data = b - '0';
        					System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb--"+data);
        					if( data >= 0 && data <= 9)
        					{
        						System.out.println(" b = ["+b+ "]");
        					}
        					else
        					{
        					    flag = "error";
        						throw new Exception("�ļ���ʽ����ȷ");
        					}
        				}
        				dis.close(); 
        				fis.close(); 
        			}catch(IOException e){
        			    e.printStackTrace();
        			    flag = "error";
        				System.out.println("�ļ�������");
        				%>
            				<script>
                                rdShowMessageDialog('�ļ�������!',0);
                                parent.doUnLoading();
                            </script>
            			<%
        			}catch(Exception e){
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
			}
	
System.out.println("--------------iInputFile======"+iInputFile);
if(!"error".equals(flag)){
%>
<SCRIPT>
    
var vInputFile = "<%=iInputFile%>";
parent.document.getElementById("inputFile").value=vInputFile;

rdShowMessageDialog('�ļ��ϴ��ɹ���',2);
parent.refMain();
</SCRIPT>
<%}
}catch(Exception e){
%>
<script>
    rdShowMessageDialog('�ļ��ϴ�ʧ�ܣ�',0);
    parent.doUnLoading();
</script>
<%
e.printStackTrace();
}
%>
