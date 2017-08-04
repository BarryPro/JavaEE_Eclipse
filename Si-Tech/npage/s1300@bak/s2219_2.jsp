   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "2219";
  String opName = "批量局拆特殊用户延期";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	  String orgcode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");


	String filename = orgcode.substring(0,2)+"delay2219.txt";
	String    iErrorNo ="";
	String    sErrorMessage = " ";
	String op_code = "2219"  ;
	String remark = request.getParameter("remark");
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+orgcode.substring(0,2)+"delay2219.txt";
	System.out.println("sSaveName:"+sSaveName);
	SmartUpload mySmartUpload = new SmartUpload();
	try
	{
		mySmartUpload.initialize(pageContext);
        mySmartUpload.upload();
    }
    catch(Exception ex) {
        System.out.println("上载文件传输中出错！");
        iErrorNo = "139045";
		sErrorMessage = "上载文件传输中出错！";
    }
    try {

            com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
            if (!myFile.isMissing()){
                    myFile.saveAs(sSaveName);
            }
    }catch(Exception ex) {
            //System.out.println("上载文件存储时出错！");
            iErrorNo = "139046";
			sErrorMessage = "上载文件存储时出错！";
    }
ArrayList arlist = new ArrayList();
ArrayList arlist2 = new ArrayList();

String [][] result = new String[][]{};
String [][] result2 = new String[][]{};
String    sReturnCode = "";
int			flag = 0;
	try
	{	
		//arlist = viewBean.s2204Del(filename,remark);
		
%>

	<wtc:service name="s2204Del" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
		<wtc:param value="<%=filename%>"/>	
		<wtc:param value="<%=remark%>"/>				
	</wtc:service>
	<wtc:array id="resultS2204" scope="end"/>

<%		
		if(resultS2204!=null)
		{
		result = resultS2204;
		
		iErrorNo = result[0][0];
		System.out.println("*********:'"+iErrorNo+"'");
		sErrorMessage = result[0][1];
		}
		//System.out.println("-Del------------------------"+arlist.size());
	}
	catch(Exception e)
	{
		System.out.println("调用EJB发生失败！");
	}

		if (iErrorNo.equals("000000")==false)
		{
			System.out.println(" 错误代码 : " + iErrorNo);
			System.out.println(" 错误信息 : " + sErrorMessage);
            flag = -1;
		}

    FileReader fr = new FileReader(sSaveName);
    BufferedReader br = new BufferedReader(fr);   
    String phoneText="";
    String line = null;
    do {
        line = br.readLine();
        if (line==null) continue;       
        if (line.trim().equals("")) continue;   
        phoneText+=line+"\n"; 
        if (phoneText.length()>=1000){
                     try
						{	
							//arlist2 = viewBean.s2204Write(filename,phoneText);
							//System.out.println("-Write1------------------------"+arlist.size());
%>

			<wtc:service name="s2204Write" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
				<wtc:param value="<%=filename%>"/>	
				<wtc:param value="<%=phoneText%>"/>				
			</wtc:service>			
			<wtc:array id="result_t2" scope="end"/>

<%							
							if(result_t2!=null)
							{
							result2 = result_t2;
							iErrorNo = result[0][0];
							System.out.println("*****s2204Write*2***:'"+iErrorNo+"'");
							sErrorMessage = result[0][1];
							}
							
						}
						catch(Exception e)
						{
							//System.out.println("调用EJB发生失败！");
						}
						
							
							if (iErrorNo.equals("000000")==false)
							{
								System.out.println(" 错2误代码 : " + iErrorNo);
								System.out.println(" 错误2息 : " + sErrorMessage);
					            flag = -1;
							}
                       	 phoneText="";
        }
        }while (line!=null);        
    br.close();
    fr.close();
    
try
{	
	//arlist2 = viewBean.s2204Write(filename,phoneText);
%>

	<wtc:service name="s2204Write" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="2" >
		<wtc:param value="<%=filename%>"/>	
		<wtc:param value="<%=phoneText%>"/>				
	</wtc:service>
	<wtc:array id="result_t3" scope="end"/>

<%	
	System.out.println("-Write2-------s2204Write----------------"+arlist.size());
	System.out.println("2phoneText:"+phoneText);
	
	if(result_t3!=null){
	result2 = result_t3;
	iErrorNo = result[0][0];
	System.out.println("**s2204Write5454*******:'"+iErrorNo+"'");
	sErrorMessage = result[0][1];
}
}
catch(Exception e)
{
	System.out.println("调用EJs2204WriteB发生失败！");
}
	
	if (iErrorNo.equals("000000")==false)
	{
		System.out.println(" 错误444444444444444444444代码 : " + iErrorNo);
		System.out.println(" 错444444444444444444误信息 : " + sErrorMessage);
           flag = -1;
	}
   
	// 判断处理是否成功
	if (flag == 0)
	{
	System.out.println("success!");
	}
	else
	{
		System.out.println("failed, 请检查 !");
	}
	
%>
<SCRIPT type=text/javascript>
function ifprint(){
     <% 

     if (flag == 0){%>
     frm_print_invoice.submit();
     <% }else {%>
    rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
    history.go(-1);
    <%}
     %>
} 						
</SCRIPT>
<html>
<body onload="ifprint()">
<form action="s2219_3.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
</form>
</body></html>
