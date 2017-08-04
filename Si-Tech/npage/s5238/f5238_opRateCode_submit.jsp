<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@page contentType="text/html;charset=gb2312" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
			
	//错误信息，错误代码
	String errCode = "";
	String errMsg = "";
	String iErrorNo ="";
  String sErrorMessage = " ";
	
  SmartUpload mySmartUpload = new SmartUpload();
	String opType   = request.getParameter("opType");
	String sSaveName="";
	System.out.println(opType);
	if (opType.equals("Y"))
	{
		String filename = "PROD"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename+".TXT";
		System.out.println("fileName = " + sSaveName);
	}
	
	try 
	{
	    mySmartUpload.initialize(pageContext);
	    mySmartUpload.upload();
			System.out.println("初始化完毕!!");
	}
	catch(Exception ex)   
	{
		System.out.println("异常抛出!!");
		ex.printStackTrace();
	  iErrorNo = "11111";
	  sErrorMessage = "上载文件传输中出错1！";
%>
		<script language='jscript'>
			rdShowMessageDialog('上载文件传输中出错！',0);
			location = "f5238_opRateCode.jsp";
		</script>
<%
	}
	try 
	{
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0); 
		if (!myFile.isMissing())
		{
			myFile.saveAs(sSaveName);        
		}
	}	
	catch(Exception ex)	
	{
		iErrorNo = "22222";
		sErrorMessage = "上载文件存储时出错1！";
%>
		<script language='jscript'>
			rdShowMessageDialog('上载文件存储时出错！',0);
			window.close();
		</script>
<%
	}
	
	String login_accept = mySmartUpload.getRequest().getParameter("login_accept");
	String region_code = mySmartUpload.getRequest().getParameter("region_code");
	String detail_code = mySmartUpload.getRequest().getParameter("detail_code");
	String sIn_note = mySmartUpload.getRequest().getParameter("sIn_note");
	String typeButtonNum = mySmartUpload.getRequest().getParameter("typeButtonNum");
	String flag_code = mySmartUpload.getRequest().getParameter("flag_code")==null?"":mySmartUpload.getRequest().getParameter("flag_code");
	String flag_name = mySmartUpload.getRequest().getParameter("flag_name")==null?"":mySmartUpload.getRequest().getParameter("flag_name");
	String flag_codes_list = mySmartUpload.getRequest().getParameter("flag_codes_list")==null?"":mySmartUpload.getRequest().getParameter("flag_codes_list");
	String area_codes_list = mySmartUpload.getRequest().getParameter("area_codes_list")==null?"":mySmartUpload.getRequest().getParameter("area_codes_list"); 

	String[] flag_codes_array = flag_codes_list.split(",");
	String[] area_codes_array = area_codes_list.split(",");
    
		
	String paramsIn[] = new String[12];
	
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	paramsIn[6]=sIn_note;
	paramsIn[7]=flag_code;
	paramsIn[8]=flag_name;
	paramsIn[9]=opType;
	paramsIn[10]=sSaveName;
	paramsIn[11]=realip;

	
//acceptList = impl.callService("s5238_RateCfm",paramsIn,"2");
	%>
	
	  <wtc:service name="s5238_RateCfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />	
			<wtc:param value="<%=paramsIn[3]%>" />	
			<wtc:param value="<%=paramsIn[4]%>" />	
			<wtc:param value="<%=paramsIn[5]%>" />	
			<wtc:param value="<%=paramsIn[6]%>" />	
			<wtc:param value="<%=paramsIn[7]%>" />	
			<wtc:param value="<%=paramsIn[8]%>" />				
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />
			<wtc:param value="<%=paramsIn[11]%>" />			
			<wtc:params value="<%=flag_codes_array%>" />				
			<wtc:params value="<%=area_codes_array%>" />				
		</wtc:service>
		<wtc:array id="result_t" scope="end" />
	
	<%
	errCode=code;   
	errMsg=msg;
	
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			rdShowMessageDialog("配置成功" ,2);
			window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;
      window.opener.form1.typeButton<%=typeButtonNum%>.value="已配置";
			window.close();
        </script>
<%
	}
%>

