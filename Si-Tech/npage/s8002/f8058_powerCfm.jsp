<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%	
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");

	String loginNo1 = request.getParameter("loginNo1");//被操作工号
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称
	String popeDomCodeIn1 = request.getParameter("parPopeDomCode");	
	
	System.out.println("popeDomCodeIn1="+popeDomCodeIn1);
	String [] check = request.getParameterValues("check");
	String [] rolePdomIn = {""};
	String [] rolePdomTypeIn = {""};
	String [] beginTimeIn = {""};
	String [] endTimeIn = {""};
	
	String [] oldCheck     = request.getParameterValues("old_check");
	String [] newCheck     = request.getParameterValues("new_check");
	String [] rolePdom     = request.getParameterValues("rolePdom");
	String [] rolePdomType = request.getParameterValues("rolePdomType");
	String [] beginTime    = request.getParameterValues("beginTime");
	String [] endTime      = request.getParameterValues("endTime");
	String [] oldPdomType  = request.getParameterValues("oldPdomType");
	
	ArrayList paramsIn = new ArrayList();
	
	paramsIn.add(new String[]{loginNo});
	paramsIn.add(new String[]{loginNo1});
	paramsIn.add(new String[]{"8002"});
	paramsIn.add(new String[]{"0"});// 1修改, 2查询 ,0修改确认
	paramsIn.add(new String[]{"0"});
	
	paramsIn.add(rolePdom);
	paramsIn.add(rolePdomType);
	paramsIn.add(beginTime);
	paramsIn.add(endTime);
	paramsIn.add(new String[]{popeDomCodeIn1});
	paramsIn.add(oldCheck);
	paramsIn.add(newCheck);
	paramsIn.add(oldPdomType);
	
	System.out.println("ggggggggggggggggggggggggg");
	

	//retStr = impl.callService("sSetLoginRole", paramsIn, "1"); 
	System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhh");
%>
	<wtc:service name="sSetLoginRole" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo1%>"/>
		<wtc:param value="8002"/>
		<wtc:param value="0"/>
		<wtc:param value="0"/>		
		<wtc:params value="<%=rolePdom%>"/>
		<wtc:params value="<%=rolePdomType%>"/>
		<wtc:params value="<%=beginTime%>"/>
		<wtc:params value="<%=endTime%>"/>
		<wtc:param value="<%=popeDomCodeIn1%>"/>
		<wtc:params value="<%=oldCheck%>"/>
		<wtc:params value="<%=newCheck%>"/>
		<wtc:params value="<%=oldPdomType%>"/>	
		
	</wtc:service>	
<%
	System.out.println("retMsg1====="+retMsg1);
	String errCode=retCode1;
	String errMsg=retMsg1;
	if(!errCode.equals("000000"))
	{
	%>
		<script language='jscript'>
				rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
				history.go(-1);
		</script> 
	<%  
	}
	else
	{
	%>
		<script language='jscript'>
				rdShowMessageDialog("操作成功!",2);				
				parent.rightFrame.location="funclist.jsp?loginNo1="+"<%=loginNo1%>"+"&roleCode="+"<%=roleCode%>"+"&popeDomCode="+"<%=popeDomCodeIn1%>"+"&roleName="+"<%=roleName%>";
		</script> 
<%
	}
%>



