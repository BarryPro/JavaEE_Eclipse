   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@page contentType="text/html;charset=gbk"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
  	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  //读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");             //工号
	String regionCode= (String)session.getAttribute("regCode");
	String nopass  = (String)session.getAttribute("password");                  //登陆密码

	Logger logger = Logger.getLogger("f8026_submit_add.jsp");
	
		
	String role_code = request.getParameter("role_code"); 			 //角色代码
	String role_name = request.getParameter("role_name");				 //角色名称
	String role_describe = request.getParameter("role_describe");//角色信息描述 
	String roleType_code = request.getParameter("roleType_code");//角色类型
	String use_flag = request.getParameter("use_flag");					 //有效标志
	String op_note = request.getParameter("op_note");
	String ip_Addr = request.getParameter("ip_Addr");


    String paramsIn[] = new String[11];
	  paramsIn[0] = workNo;
		paramsIn[1] = nopass;
		paramsIn[2] = "8026";
    paramsIn[3] = ip_Addr;				//ip
    paramsIn[4] = 	op_note;   
    paramsIn[5] =  role_code;       
    paramsIn[6] =  role_name;     
    paramsIn[7] =  roleType_code;     
    paramsIn[8] =  role_describe;   
    paramsIn[9] =  use_flag;           
    paramsIn[10] = op_note;   
                               
	String errCode="-1";
  String errMsg="";
	try
	{   
	 	//acceptList = impl.callFXService("s8026_Ist",paramsIn,"2","region", regionCode);
%>

    <wtc:service name="s8026_Ist" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
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
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%	 	
		errCode= code2;   
		errMsg= msg2; 		 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call s8026_Ist is Failed!");
	}
	       
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("操作成功！",2);
             document.location.replace("<%=request.getContextPath()%>/npage/s8026/f8026_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	          history.go(-1);
	      </script>         
<%            
    }
%>