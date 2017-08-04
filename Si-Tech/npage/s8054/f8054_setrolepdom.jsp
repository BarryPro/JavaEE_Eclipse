   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-27
********************/
%>
            
              
<%
  String opCode = "8054";
  String opName = "角色权限管理";
%>              

<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");        //工号
	String regionCode= (String)session.getAttribute("regCode");
	
	
	
	//获取输入的信息
	String roleCode = request.getParameter("roleCode");					//角色代码
	String roleName = request.getParameter("roleName");					//角色名称
	String parPopeDomCode = request.getParameter("parPopeDomCode");		//父权限代码
	String[] popeDomCode = request.getParameterValues("popeDomCode");	//权限代码
	String[] old_check = request.getParameterValues("old_check");		//旧选择标志
	String[] new_check = request.getParameterValues("new_check");		//新选择标志
	
	for(int i=0;i<popeDomCode.length;i++){
		System.out.println("liangyl---popeDomCode---------------------"+popeDomCode[i]);
	}
	System.out.println("liangyl----------------------------------------------");
	for(int i=0;i<old_check.length;i++){
		System.out.println("liangyl---old_check---------------------"+old_check[i]);
	}
	System.out.println("liangyl----------------------------------------------");
	for(int i=0;i<new_check.length;i++){
		System.out.println("liangyl---new_check---------------------"+new_check[i]);
	}
	
	String oaNumber = request.getParameter("oaNumber");					//OA编号
	String oaTitle = request.getParameter("oaTitle");					//OA标题
	
	System.out.println("liangyl------------------------"+oaNumber);
	System.out.println("liangyl------------------------"+oaTitle);
	
	
	
	String paramsIn[] = new String[4];
	paramsIn[0] = workNo;
	paramsIn[1] = "8054";
	paramsIn[2] = roleCode;
	paramsIn[3] = parPopeDomCode;
	//paramsIn[6] = new_check;

	String errCode="";
	String errMsg="";
	try
	{   
	 	//acceptList = impl.callService("sSetRolePDOM",paramsIn,"1","region", regionCode);
	 	%>
	 	
    <wtc:service name="sSetRolePDOM" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:params value="<%=popeDomCode%>" />
			<wtc:params value="<%=old_check%>" />
			<wtc:params value="<%=new_check%>" />
			<wtc:param value="<%=oaNumber%>" />
			<wtc:param value="<%=oaTitle%>" />
		</wtc:service>
	 	
	 	<%
		errCode=code;
		errMsg=msg;
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	       
	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("操作成功！",2);
              parent.rightFrame.location="funclist.jsp?popeDomCode="+"<%=parPopeDomCode%>"+"&roleCode="+"<%=roleCode%>"+"&roleName="+"<%=roleName%>";
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
