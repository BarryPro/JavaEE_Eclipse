
<%
/********************
 version v2.0
 开发商 si-tech
 update haoyy@2010-8-20
********************/
%>


<%
  	String opCode = "b465";
	String opName = "地市级角色批量赋权";
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
	String popes = request.getParameter("popes");	//所有所选的权限代码
	String roles = request.getParameter("roles");	//所有所选的角色代码
	String[] roleCodeS=roles.split(",");
	String[] popeDomCode=popes.split(",");

	String paramsIn[] = new String[10];
	paramsIn[0] = "";
	paramsIn[1] = "";
	paramsIn[2] = "b465";
	paramsIn[3] = workNo;
	paramsIn[4] = "";
	paramsIn[5] = "";
	paramsIn[6] = "";
	paramsIn[7] = parPopeDomCode;

	String errCode="";
	String errMsg="";
	try
	{
	 	//acceptList = impl.callService("sSetRolePDOM",paramsIn,"1","region", regionCode);
	 	%>

    <wtc:service name="sb465Cfm" outnum="0" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:params value="<%=roleCodeS%>" />
			<wtc:params value="<%=popeDomCode%>" />
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
              history.go(-1);
              parent.rightFrame.location="funclist.jsp?popeDomCode="+"<%=parPopeDomCode%>"+"&roles="+"<%=roles%>"+"&roleName="+"<%=roleName%>";
        </script>
<%	}
	else if(errCode.equals("000001"))
	{
%>
		  <script language='jscript'>
	          rdShowMessageDialog("<%=errMsg%>",1);
	          history.go(-1);
	      </script>
<%
	}
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
