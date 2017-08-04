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
	
	String workNo = (String)session.getAttribute("workNo");	
	String ip_Addr = request.getRemoteAddr();	
	String nopass  = (String)session.getAttribute("password");	
	String regionCode=(String)session.getAttribute("regCode");
%>
<%
	
	String opCode  = "8175";
	String loginNo = request.getParameter("loginNo");
	String spowerCode = request.getParameter("powerCode");
	String opType = request.getParameter("opType");
	String oaNumber = request.getParameter("oaNumber");					//OA编号
	String oaTitle = request.getParameter("oaTitle");					//OA标题
	System.out.println("liangyl------------------------"+oaNumber);
	System.out.println("liangyl------------------------"+oaTitle);

	System.out.println("loginNo:"+loginNo+" spowerCode:"+spowerCode+" opType:"+opType);
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList list = new ArrayList();
	System.out.println(">>>>>"+spowerCode);	
	String[] powerCode = spowerCode.split("\\|");
	
	for(int i = 0; i < powerCode.length; i ++)
	{
		System.out.println(">>>>>>"+ powerCode[i]);
	}
	
	
	/*list.add(new String[]{workNo});       //操作工号
	list.add(new String[]{nopass});       //密码
	list.add(new String[]{opCode});       //操作代码
	list.add(new String[]{opType});       //操作类型
	list.add(new String[]{loginNo});      //被操作工号
	list.add(powerCode);    //操作备注
	list.add(new String[]{ip_Addr});      //IP地址
	
	String[] acceptArray = new String[]{};*/
	String errCode = "-1";
	String errMsg ="";
	
	
		//acceptArray = impl.callService("s8175Cfm", list, "1","region", regionCode);	
	%>
		<wtc:service name="s8175Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=opType%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:params value="<%=powerCode%>"/>
			<wtc:param value="<%=ip_Addr%>"/>
			<wtc:param value="<%=oaNumber%>"/>
			<wtc:param value="<%=oaTitle%>"/>
		</wtc:service>		
	<%
		errCode = retCode1;
		errMsg = retMsg1;
		System.out.println("retCode1===================="+errCode);
		System.out.println("retMsg1===================="+errMsg);
		System.out.println("retCode1===================="+errCode);
		System.out.println("retMsg1===================="+errMsg);

	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 	 rdShowMessageDialog("操作成功！",2);
			 document.location.replace("<%=request.getContextPath()%>/npage/s8175/f8175_1.jsp");
        </script>
<%	}
    else
    {
%>
		  <script language='jscript'>
	          rdShowMessageDialog("错误信息：<%=errMsg%><br>错误代码：<%=errCode%>", 0);
	          document.location.replace("<%=request.getContextPath()%>/npage/s8175/f8175_1.jsp");
	      </script>
<%
    }
%>
