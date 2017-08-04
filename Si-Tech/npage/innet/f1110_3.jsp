 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1110";		
	String opName = "一卡双号对应关系";	//header.jsp需要的参数 	
	
   	String regionCode=(String)session.getAttribute("regCode");  
	/*
	输入参数：操作方式（A、D），主手机号码，工号，工号编码
	输出参数：错误代码，错误信息
	*/ 
	String opType = request.getParameter("bakOpType");            		/*操作类型 增加、删除*/
	String mainPhoneNo = request.getParameter("mainPhoneNo");       /*主手机号码*/
	String iSimNo1= request.getParameter("mainSimNo");				/*主SIM卡号*/
	String iImsiNo1= request.getParameter("mainImsiNo");			/*主IMSI号*/
	String iPhoneNo2= request.getParameter("appendPhoneNo");		/*副手机号码*/
	String iSimNo2	= request.getParameter("appendSimNo");			/*副SIM卡号*/
	String iImsiNo2= request.getParameter("appendImsiNo");			/*副IMSI号*/
	String iOpNote	= request.getParameter("opNote");				/*备注*/
	String iLoginNo	= request.getParameter("loginNo");				/*工号*/
	String iOrgCode	= request.getParameter("orgCode");				/*工号机构编码*/
	String iOpCode	= "1110";										/*操作代码*/
	String iIpAdd	= request.getRemoteAddr();				/*营业员登陆IP*/
	
	String loginAccept="0";
	System.out.println("loginAccept====="+loginAccept);
	String orgId= request.getParameter("org_id");				    /*orgId*/
//----------------------------
	String ret_code = "0";      
	String retMessage = "";	 	        
	String serviceName = "s1110Cfm";
	String[] paraStrIn = new String[]{opType,mainPhoneNo,iSimNo1,iImsiNo1,iPhoneNo2,iSimNo2,iImsiNo2,iOpNote,iLoginNo,iOrgCode,iOpCode,iIpAdd,loginAccept,orgId};
	String outParaNums= "1";   	  
	    //retArray = callSvrImpl.callFXService(serviceName, paraStrIn, outParaNums);
	 %>
	 	<wtc:service name="s1110Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
			<wtc:params value="<%=paraStrIn%>"/>	
		</wtc:service>		
		<wtc:array id="result1"  scope="end"/>
	 <%
	       ret_code=retCode1;
	       retMessage=retMsg1;    
	       if(result1.length!=0)
	       	  loginAccept = result1[0][2];        
    
		if(ret_code.equals("000000"))
		{
			if(opType.compareTo("A") == 0)
			{		opType = "增加";		}
			if(opType.compareTo("D") == 0)
			{		opType = "删除";		}					
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=opType%>" + "一卡双号对应关系成功！",2);
                history.go(-1);
            </script>            
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]" ,0);
                history.go(-1);
            </script>
<%        
        }
%>



<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+mainPhoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />

