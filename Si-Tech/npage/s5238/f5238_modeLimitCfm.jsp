<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-20
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_name = request.getParameter("mode_name");
	String mode_code = request.getParameter("mode_code");
	String aold_mode_array = request.getParameter("old_mode_array");
	String anew_mode_array = request.getParameter("new_mode_array");
	String amode_flag_array = request.getParameter("mode_flag_array");
	String region_code = request.getParameter("region_code");
	String trans_type = request.getParameter("trans_type");
	System.out.println("QQQQQQQQ"+anew_mode_array);
			String errCode ="";
		String errMsg = "";
	if(aold_mode_array!=null)
	{
		String[] old_mode = aold_mode_array.split(",");
		String[] new_mode = anew_mode_array.split(",");
    	String[] mode_flag = amode_flag_array.split(",");
 		
		String[] acceptList = null;
		
		String[] paramsIn = new String[9];
		paramsIn[0]=workNo;
		paramsIn[1]=nopass;
		paramsIn[2]="5238";
		paramsIn[3]=login_accept;
		//paramsIn[4]=old_mode;
		//paramsIn[5]=new_mode;
		//paramsIn[6]=mode_flag;
		paramsIn[7]=region_code;
		paramsIn[8]=trans_type;
    	
		//acceptList = impl.callService("s5238_LimitCfm",paramsIn,"2");
		%>
	 <wtc:service name="s5238_LimitCfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:params value="<%=old_mode%>" />
			<wtc:params value="<%=new_mode%>" />
			<wtc:params value="<%=mode_flag%>" />
			<wtc:param value="<%=paramsIn[7]%>" />						
			<wtc:param value="<%=paramsIn[8]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
					
		
		
		
		<%
		 errCode = code;
		 errMsg = msg;
		System.out.println("----------------code------------f5238_modeLimitCfm.jsp-----------"+code);
	}
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
        	parent.document.form1.conmit.disabled=false;
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			if("<%=trans_type%>"=="0")
			{
				parent.opener.window.form1.modeTransOtherButton.disabled=false;
			}
			else
			{
				parent.opener.window.form1.otherTransModeButton.disabled=false;
			}
			parent.opener.window.middle2.location='f5238_showLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>';
        	parent.window.close();
        </script>

<%	}
%>
