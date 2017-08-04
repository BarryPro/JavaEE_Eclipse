<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-19 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	 
	String opCode = "8175";
	String opName = "工号角色管理";
		
	String workNo =(String)session.getAttribute("workNo");		
	String nopass  =  (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
%>

<%
	
	String loginNo = request.getParameter("loginNo") == null ? "" : request.getParameter("loginNo"); 
	String powerCode = request.getParameter("powerCode") == null ? "" : request.getParameter("powerCode");
	
	/*************** 输入参数 ****************************/	
	String paramsIn[] = new String[6];	 	
	
 	paramsIn[0] = workNo;                //工号
 	paramsIn[1] = nopass;                //密码
 	paramsIn[2] = opCode;                //操作代码
 	paramsIn[3] = "2";                   //操作方式
 	paramsIn[4] = loginNo;               //被查询工号
 	paramsIn[5] = powerCode;             //查询角色
	/*****************************************************/
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	String errCode = "-1";
	String errMsg ="";	
	
		//acceptList = callView.callFXService("s8175Qry", paramsIn, "4","region", regionCode);
	%>
		<wtc:service name="s8175Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
			<wtc:param value="<%=paramsIn[0]%>"/>
			<wtc:param value="<%=paramsIn[1]%>"/>
			<wtc:param value="<%=paramsIn[2]%>"/>
			<wtc:param value="<%=paramsIn[3]%>"/>
			<wtc:param value="<%=paramsIn[4]%>"/>
			<wtc:param value="<%=paramsIn[5]%>"/>
		</wtc:service>		
		<wtc:array id="sLoginNo1" start="0" length="1" scope="end"/>
		<wtc:array id="sLoginName1" start="1" length="1" scope="end"/>
		<wtc:array id="sRoleCode1" start="2" length="1" scope="end"/>
		<wtc:array id="sRoleName1" start="3" length="1" scope="end"/>
	<%	
		errCode = retCode1;
		errMsg = retMsg1;
		System.out.println("errCode====================="+errCode);
		System.out.println("errMsg====================="+errMsg);
	
	
	/********************* 输出参数 ***********************************/
	String[][] sLoginNo   = new String[][]{};      //查询工号
	String[][] sLoginName = new String[][]{};      //工号名称
	String[][] sRoleCode  = new String[][]{};      //角色代码
	String[][] sRoleName  = new String[][]{};      //角色名称
	/******************************************************************/
	
 	if(("000000").equals(errCode))
 	{
 		sLoginNo   = sLoginNo1;
		sLoginName = sLoginName1;
		sRoleCode  = sRoleCode1;
		sRoleName  = sRoleName1;
		
		if(sLoginNo==null||sLoginNo.length==0)
		{
%>
			<script language='jscript'>
				rdShowMessageDialog("没有查到相关记录！",0);	
				parent.location="f8175_1.jsp?returnFlag=3";			
			</script>
<%  
		}
	}
	else
	{
%>
		<script language='jscript'>
		     rdShowMessageDialog("错误信息：<%=errMsg%><br>错误代码：<%=errCode%>", 0);	     
		     parent.location="f8175_1.jsp?returnFlag=3";
	    </script> 
<%
		
	}
%>	

<html>
<body>
<form name="form1" method="post" action="">	
<div id="Main">

   <DIV id="Operation_Table"> 
	
			
	<table id="tabList" cellspacing=0>			
			<tr>				
				<th>工号代码</th>
				<th>工号名称</th>
				<th>角色代码</th>
				<th>角色名称</th>
			</tr>
	<%	
		for(int i = 0; i < sLoginNo.length; i++)
		{
	%>			
			<tr>				
				<td nowrap ><%=sLoginNo[i][0].trim()%>&nbsp;</td>
				<td nowrap ><%=sLoginName[i][0].trim()%>&nbsp;</td>
				<td nowrap ><%=sRoleCode[i][0].trim()%>&nbsp;</td>
				<td nowrap ><%=sRoleName[i][0].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
			
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>  
</form>
</body>
</html>