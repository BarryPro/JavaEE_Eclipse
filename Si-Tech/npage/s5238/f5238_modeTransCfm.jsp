<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
              
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
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
	String apower_right_array = request.getParameter("power_right_array");
	String region_code = request.getParameter("region_code");
	String trans_type = request.getParameter("trans_type");
	
	System.out.println("---------------------------------f5238_modeTransCfm.jsp----------------------");
	String errCode="";
    String errMsg="";
	if(aold_mode_array!=null)
	{
		String[] old_mode = aold_mode_array.split(",");
		String[] new_mode = anew_mode_array.split(",");
    	String[] mode_flag = amode_flag_array.split(",");
		String[] power_right = apower_right_array.split(",");
 		
		String[] acceptList = null;
		
		String paramsIn[] = new String[10];
		paramsIn[0]=workNo;
		paramsIn[1]=nopass;
		paramsIn[2]="5238";
		paramsIn[3]=login_accept;
		//paramsIn[4]=old_mode;
		//paramsIn[5]=new_mode;
		//paramsIn[6]=mode_flag;
		paramsIn[7]=region_code;
		paramsIn[8]=trans_type;
		//paramsIn[9]=power_right;
    	
	//acceptList = impl.callService("s5238_BBChgCfm",paramsIn,"2");
		%>
		
		    <wtc:service name="s5238_BBChgCfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />		
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:params value="<%=old_mode%>" />
			<wtc:params value="<%=new_mode%>" />
			<wtc:params value="<%=mode_flag%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:params value="<%=power_right%>" />							
		</wtc:service>
		
		<%
		errCode=code;   
		errMsg=msg;
		System.out.println("------------errCode------------"+errCode);
		System.out.println("------------trans_type--------------"+trans_type);
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
        	parent.window.close();
        </script>

<%	}
%>
