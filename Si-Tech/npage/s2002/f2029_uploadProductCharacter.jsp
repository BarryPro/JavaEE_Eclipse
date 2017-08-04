<%
/********************
 * version v3.0
 * 开发商: si-tech
 * author: wangzn 2010-3-23 14:49:06
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
    String fieldName="";
%>

<%try{
		SmartUpload mySmartUpload = new SmartUpload();
        mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 

        mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		String iSmCode = mySmartUpload.getRequest().getParameter("sm_code");
		String sysAccept = mySmartUpload.getRequest().getParameter("sysAccept");
		String retField = mySmartUpload.getRequest().getParameter("retField");
		%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
		<%
		sysAccept = seq;
		System.out.println("######## sysAccept = "+sysAccept);
		System.out.println("iiiiiiiiiiiiiiiiiiiiiiiSmCode = "+iSmCode);
		//String filename = iSmCode+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		String filename = "ProductAttachment"+sysAccept;
		String path = request.getRealPath("/npage/tmp/");
		String sSaveName = path+"/"+filename;
        java.io.File fileNew = new java.io.File(path);  
        if(!fileNew.exists())  
            fileNew.mkdirs();   
		System.out.println("kkkkkkkkkkkkkkkkkkkkk");

		String flag="";
		String book_name="";
		String iInputFile = "";
    
   
		System.out.println("@:***myfiles.getCount()="+myfiles.getCount());
		if(myfiles.getCount()>0)
		{
			com.jspsmart.upload.File myFile = null;
			String fileType = null;
			for(int i=0;i<myfiles.getCount();i++){
				%>
					<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
				<%
				sysAccept = seq;
				System.out.println("@:*** sysAccept = "+sysAccept);
				filename = "ProductAttachment"+sysAccept;
				path = request.getRealPath("/npage/tmp/");
				sSaveName = path+"/"+filename;
				System.out.println("i ["+i+"]");
				try{
					myFile = myfiles.getFile(i);  
				}
				catch(Exception e){
					e.printStackTrace();
				}
			
			
				if(myFile.isMissing()){
					System.out.println("file ["+(i+1)+"] is null!");
					continue;
				}
				try{
					fieldName = myFile.getFieldName();
				}catch(Exception e){
					e.printStackTrace();
				}
				try{
					//fileType = myFile.getFileName().split("\\.")[1];
					int fileTypeLength = myFile.getFileName().split("\\.").length;
					fileType = myFile.getFileName().split("\\.")[fileTypeLength-1];/*获取最后一个.后面的后缀*/
				}catch(Exception e){
					e.printStackTrace();
					System.out.println("@:DEBUG_0086");
					fileType = "";
				}
				int fileSize = myFile.getSize();
				
				sSaveName = sSaveName+"."+fileType;
				System.out.println("上传文件:" + sSaveName + "\n");
				iInputFile = sSaveName;
				myFile.saveAs(iInputFile);
				System.out.println("file ["+(i+1)+"] save!");
				
				try{
    				FileInputStream fis = new FileInputStream(iInputFile);    
    				DataInputStream dis = new DataInputStream(fis); 
    				
    		    	dis.close(); 
    				fis.close(); 
    			}catch(IOException e){
    			    e.printStackTrace();
    			    flag = "error";
    				System.out.println("文件不存在");
    				%>
        				<script>
                            rdShowMessageDialog('文件不存在!',0);
                            parent.doUnLoading();
                        </script>
        			<%
    			}catch(Exception e){
    			    e.printStackTrace();
    			    flag = "error";
    			%>
    				<script>
                        rdShowMessageDialog('文件格式不正确,必须是txt文本文件！',0);
                        parent.doUnLoading();
                    </script>
    			<%
    			}
    			System.out.println("--------------iInputFile======"+iInputFile);
    			%>
	    			<SCRIPT>
		    			//var vInputFile = "<%=iInputFile.substring(iInputFile.lastIndexOf("/")+1)%>";
						var vInputFile = "<%=iInputFile%>";
						
						if('<%=fieldName%>'!=''){
						   parent.document.getElementsByName("texCharacterVal"+"<%=fieldName.substring(fieldName.indexOf("_")+1)%>")[0].value=vInputFile;
						}
					</SCRIPT>
				<%
			}
		}
if(!"error".equals(flag)){
%>
<SCRIPT>

//rdShowMessageDialog('文件上传成功！',2);
parent.doUnLoading();
parent.saveTo();
</SCRIPT>
<%}
}catch(Exception e){
%>
<script>
    rdShowMessageDialog('文件上传失败！',0);
    parent.doUnLoading();
</script>
<%
e.printStackTrace();
}
%>
