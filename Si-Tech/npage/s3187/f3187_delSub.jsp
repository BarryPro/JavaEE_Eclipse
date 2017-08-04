<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-12
********************/
%>
<%
  String opCode = "3187";
  String opName = "帐户关系维护";
%>              


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
	
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@page contentType="text/html;charset=gbk"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>

<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");  									//密码
	String regionCode = (String)session.getAttribute("regCode");
	
	Logger logger = Logger.getLogger("f3187_delSub.jsp");
	
	
	String contractPay = request.getParameter("contractPay");		//支付帐号
	String contractNo = request.getParameter("contractNo"); 		//被支付帐户
	
	System.out.println("contractPay:"+contractPay);
	System.out.println("contractNo:"+contractNo);

	String[] paramsIn = new String[4];
	paramsIn[0] = workNo;
	paramsIn[1] = nopass;
	paramsIn[2] = contractPay;
	paramsIn[3] = contractNo;
	String  errCode ="";   
	String	errMsg=""; 	
	//acceptList = impl.callFXService("s3187Del",paramsIn,"2");
try{	
%>

    <wtc:service name="s3187Del" outnum="2" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t3" scope="end" />

<%	
	  errCode =code3;   
		errMsg=msg3; 	

	}catch(Exception e){
	errCode="999999";
	errMsg = "TpCall Service Fail in viewBean";
	}
	
	if(!errCode.equals("999999"))
	{
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("操作成功！",2);
			 document.location.href="f3187_1.jsp";
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("错误代码：<%=errCode%><br>错误信息：<%=errMsg%>",0);
	          history.go(-1);
	      </script>         
<%            
    }
    }
  else{
%>
		  <script language='jscript'>
	          rdShowMessageDialog("错误代码：<%=errCode%><br>错误信息：<%=errMsg%>",0);
	          history.go(-1);
	      </script>      
<%}%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	
<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&retMsgForCntt="+errMsg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+sysAcceptl+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+contractPay+"&contactType=acc";	%>						
<jsp:include page="<%=url%>" flush="true" />