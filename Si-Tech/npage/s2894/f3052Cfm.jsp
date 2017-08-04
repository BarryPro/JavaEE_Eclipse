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
	//读取用户session信息

	String workNo   = (String)session.getAttribute("workNo");	
	String loginPwd  = (String)session.getAttribute("password");
	String regionCode= (String)session.getAttribute("regCode");
			
	/* 接受输入参数 */
	
	
	String prodCode = request.getParameter("prodCode");
	String bizCode = request.getParameter("bizCode");	
	String errCode="0";
  	String errMsg=""; 
  	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//String[] acceptList = null;	
	
	String paramsIn[] = new String[6];
   	paramsIn[0] = "3052";
    	paramsIn[1] = "ADCA";
    	paramsIn[2] = bizCode;
    	paramsIn[3] = prodCode;	
    	paramsIn[4] = workNo;
    	paramsIn[5] = loginPwd;
	//acceptList = impl.callService("s3052Cfm",paramsIn,"0");
%>
	<wtc:service name="s3052Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
	</wtc:service>
<%
	errCode=retCode1;
	errMsg=retMsg1;
	
	if(!errCode.equals("000000")){
	%>
	    <script language='javascript'>
	    	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	      	history.go(-1);
	    </script>
	<%
	}
	else
	{%>
	    <script language='javascript'>
	    	rdShowMessageDialog("业务与资费对应关系配置成功！",2);
			window.close();
	    </script>
	<%
	}
	%>

