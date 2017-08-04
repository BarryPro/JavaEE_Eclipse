<%
/*
liujian create 2012-7-26 15:09:39
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*消费积分对应金额查询*/

	/*主页面传递的参数*/
	String inLoginAccept	="0";
	String inChnSource	="01";
	String inOpCode		=request.getParameter("opCode");
	String inLoginNo		=(String)session.getAttribute("workNo");
	String inLoginPwd		=(String)session.getAttribute("password");
	String inPhoneNo		=(String)request.getParameter("phoneNo");
	String inUserPwd		="";
	String inOpNote		=inOpCode;
	String inregioncode	=(String)session.getAttribute("regCode");	/*地市代码*/
	String inMachPrice	=request.getParameter("machPrice"); 		/*购机款*/
	String inMarkPoint	=request.getParameter("markPoint"); 		/*消费积分*/
	
	System.out.println("-----liujian------inLoginAccept="+inLoginAccept);
	System.out.println("-----liujian------inChnSource="+inChnSource);
	System.out.println("-----liujian------inOpCode="+inOpCode);
	System.out.println("-----liujian------inLoginNo="+inLoginNo);
	System.out.println("-----liujian------inLoginPwd="+inLoginPwd);
	System.out.println("-----liujian------inPhoneNo="+inPhoneNo);
	System.out.println("-----liujian------inUserPwd="+inUserPwd);
	System.out.println("-----liujian------inOpNote="+inOpNote);
	System.out.println("-----liujian------inregioncode="+inregioncode);
	System.out.println("-----liujian------inMachPrice="+inMachPrice);
	System.out.println("-----liujian------inMarkPoint="+inMarkPoint);
	%>
	<wtc:service name="sMarkQryChg"  outnum="4"
		routerKey="region" routerValue="<%=inregioncode%>"  
		retcode="rtCode" retmsg="rtMsg"  >
		<wtc:param value="<%=inLoginAccept%>"/>
		<wtc:param value="<%=inChnSource%>"/>
		<wtc:param value="<%=inOpCode%>"/>
		<wtc:param value="<%=inLoginNo%>"/>
		<wtc:param value="<%=inLoginPwd%>"/>
		<wtc:param value="<%=inPhoneNo%>"/>
		<wtc:param value="<%=inUserPwd%>"/>
		<wtc:param value="<%=inOpNote%>"/>
		<wtc:param value="<%=inregioncode%>"/>
		<wtc:param value="<%=inMarkPoint%>"/>
		<wtc:param value="<%=inMachPrice%>"/>

	</wtc:service>
	<wtc:array id="rstMarkQry" scope="end" />
		
<%
	/*服务返回正常*/
	System.out.println(inOpCode+"~~~~rtCode="+rtCode);
	System.out.println(inOpCode+"~~~~rstMarkQry.length="+rstMarkQry.length);
	System.out.println(inOpCode+"~~~~rstMarkQry[0][0]="+rstMarkQry[0][0]);

	if ( rtCode.equals("000000") )
	{
		/*服务没有返回结果*/
		if ( rstMarkQry.length==0 )
		{
		%>
			var response = new AJAXPacket();
			response.data.add("rtCode","ZY0000");
			response.data.add("rtMsg","服务返回结果为空!");
			core.ajax.receivePacket(response);		
		<%			
		}
		else
		{
		%>
			var response = new AJAXPacket();
			response.data.add("rtCode","<%=rtCode%>");
			response.data.add("rtMsg","<%=rtMsg%>");
			response.data.add("rstMarkQry","<%=rstMarkQry[0][0]%>");
			core.ajax.receivePacket(response);		
		<%		
		}
	}
	else /*服务校验出错*/
	{
	%>	
		var response = new AJAXPacket();
		response.data.add("rtCode","<%=rtCode%>");
		response.data.add("rtMsg","<%=rtMsg%>");
		core.ajax.receivePacket(response);
	<%
	}
%>
