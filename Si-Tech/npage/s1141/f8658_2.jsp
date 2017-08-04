 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>

<%
	String regionCode = (String)session.getAttribute("regCode"); 	
	String orgcode = (String)session.getAttribute("orgCode");  
	String filename = orgcode.substring(0,2)+"AdjImei.txt";	
	String iErrorNo ="";
	String sErrorMessage = " ";	
	String remark = request.getParameter("remark");
	String sSaveName=request.getRealPath("/npage/tmp/")+"/"+orgcode.substring(0,2)+"AdjImei.txt";	
	System.out.println("*******************************************="+sSaveName);
	SmartUpload mySmartUpload = new SmartUpload();
	
	try
	{
		mySmartUpload.initialize(pageContext);
        	mySmartUpload.upload();
    }
    catch(Exception ex) 
    {
       		 System.out.println("上载文件传输中出错！");
        	 iErrorNo = "139045";
		 sErrorMessage = "上载文件传输中出错！";
    }
   	try 
   	{
   	 	com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
        if (!myFile.isMissing())
        {
            myFile.saveAs(sSaveName);
        }
   	}catch(Exception ex) 
   	{          
        iErrorNo = "139046";
		sErrorMessage = "上载文件存储时出错！";
    }
    	
	String [][] result = new String[][]{};
	String  sReturnCode = "";
	int	flag = 0;
%>
	<wtc:service name="s2204Del" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
		<wtc:param value="<%=filename%>"/>	
		<wtc:param value="<%=remark%>"/>				
	</wtc:service>
	<wtc:array id="resultS2204" scope="end"/>
	
<%
	System.out.println("iErrorNo================))))))))))))))))))"+iErrorNo);
	System.out.println("resultS2204================"+resultS2204.length);
	System.out.println("retCode================"+retCode);
	System.out.println("retMsg================"+retMsg);
	for(int i=0;i<resultS2204.length;i++)
	{
		for(int j=0;j<resultS2204[i].length;j++)
		{
			System.out.println("resultS2204["+i+"]["+j+"]="+resultS2204[i][j]);
		}
	}	
	if(resultS2204!=null&&resultS2204.length>0)
	{
		result=resultS2204;
		iErrorNo=result[0][0];	
		sErrorMessage=result[0][1];
	}
	if (iErrorNo.equals("000000")==false)
	{		
            flag = -1;
	}
    	FileReader fr = new FileReader(sSaveName);
    	BufferedReader br = new BufferedReader(fr);   
    	String phoneText="";
    	String line = null;
    	int number = 0;
    	do {
        	line = br.readLine();
        	if (line==null) continue;       
        	if (line.trim().equals("")) continue;   
        	phoneText+=line+"\n";
        	number+=1; 
        	//System.out.println("++++++++++phoneText=[%s]++++++++\n"+phoneText);
        	System.out.println("++++++++++number=[%d]++++++++\n"+number);
       		if (number<=50)
       		{              
			%>
				<wtc:service name="s2204Write" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
					<wtc:param value="<%=filename%>"/>	
					<wtc:param value="<%=phoneText%>"/>				
				</wtc:service>			
				<wtc:array id="result2" scope="end"/>
			<%				
				if(result!=null&&result.length>0)
				{
					iErrorNo=result[0][0];	
					sErrorMessage=result[0][1];
				}						
				if (iErrorNo.equals("000000")==false)
				{
					flag = -1;
				}
	            phoneText="";
        	}
        	else
        	{%>
        	<SCRIPT type=text/javascript>
        		<!--
        		rdShowMessageDialog("文件最多只能包含50条数据，您传入文件的数据过多！");
		    	history.go(-1);
		    	-->
		    </SCRIPT>
        	<%}%>	
        	<%	

        }
        while (line!=null);  
              
	br.close();
	fr.close();  	
%>
	<wtc:service name="s2204Write" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="2" >
		<wtc:param value="<%=filename%>"/>	
		<wtc:param value="<%=phoneText%>"/>				
	</wtc:service>
	<wtc:array id="result3" scope="end"/>	
	<%		
	if(result!=null&&result.length>0)
	{
		iErrorNo=result[0][0];	
		sErrorMessage=result[0][1];		
	}	
	if (iErrorNo.equals("000000")==false)
	{		
           flag = -1;
	}
%>
<SCRIPT type=text/javascript>
	function ifprint(){
	     <% 	
	     if (flag == 0)
	     {%>
	     	frm_print_invoice.submit();
	     <% 
	     }else 
	     {%>
		    rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
		    history.go(-1);
	    <%}%>
	} 						
</SCRIPT>
<html>
	<body onload="ifprint()">
		<form action="f8658_3.jsp" name="frm_print_invoice" method="post">
			<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
		</form>
	</body>
</html>
