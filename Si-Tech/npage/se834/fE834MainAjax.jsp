<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String regCode	=(String)session.getAttribute("regCode");
String workNo	=(String)session.getAttribute("workNo");
/*标准入参*/
String loginAccept=request.getParameter("loginAccept");
String iChnSource=request.getParameter("iChnSource");
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String iLoginPwd=request.getParameter("iLoginPwd");
String iPhoneNo=request.getParameter("iPhoneNo");
String iUserPwd=request.getParameter("iUserPwd");
String iOpNote=request.getParameter("iOpNote");

String ajaxType=request.getParameter("ajaxType");
System.out.println("@zhangyan~~~~loginAccept="+loginAccept);
System.out.println("@zhangyan~~~~iChnSource="+iChnSource);
System.out.println("@zhangyan~~~~opCode="+opCode);
System.out.println("@zhangyan~~~~workNo="+workNo);
System.out.println("@zhangyan~~~~iLoginPwd="+iLoginPwd);
System.out.println("@zhangyan~~~~iPhoneNo="+iPhoneNo);
System.out.println("@zhangyan~~~~iUserPwd="+iUserPwd);
System.out.println("@zhangyan~~~~ajaxType="+ajaxType);

if ( ajaxType.equals("POST") )
{	
	String postBT=request.getParameter("postBT");
	String postET=request.getParameter("postET");
	System.out.println("@zhangyan~~~~postBT="+postBT);
	System.out.println("@zhangyan~~~~postET="+postET);
	
%>
	<wtc:service name="sE834Qry" outnum="6" 
		retcode="retCodeP" retmsg="retMsgP" 
		routerKey="region" routerValue="<%=regCode%>">
	  	<wtc:param value="<%=loginAccept%>"/>
	  	<wtc:param value="<%=iChnSource%>"/>
	  	<wtc:param value="e834"/>
	  	<wtc:param value="<%=workNo%>"/>
	  	<wtc:param value="<%=iLoginPwd%>"/>
	  	<wtc:param value="<%=iPhoneNo%>"/>
	  	<wtc:param value="<%=iUserPwd%>"/>
	  	<wtc:param value="<%=iOpNote%>"/>
	  	<wtc:param value="<%=postBT%>"/>
	  	<wtc:param value="<%=postET%>"/>
	</wtc:service>
	<wtc:array id="rstE834" scope="end"/> 		
	<%
	if ( !retCodeP.equals("000000") )
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retCodeP","<%=retCodeP%>");
		response.data.add("retMsgP","<%=retMsgP%>");		
		core.ajax.receivePacket(response);
	<%
	}
	else
	{
	%>
		/*定义用于传到主界面的数组*/
		var arrE834 = new Array;
		
		/*按行遍历服务结果数组*/
		<%
		System.out.println("zhangyan rstE834.length="+rstE834.length);
		for ( int i=0;i<rstE834.length;i++ )
		{
			%>
			arrE834[<%=i%>]=new Array();
			<%
			for ( int j=0;j<rstE834[i].length;j++ )
			{
				
				System.out.println("@zhangyan~~~~rstE834="+rstE834[i][j]);
				%>
				arrE834[<%=i%>][<%=j%>]="<%=rstE834[i][j]%>";
				<%
			}
		}
		%>
		
		var response = new AJAXPacket();
		response.data.add("retCodeP","<%=retCodeP%>");
		response.data.add("retMsgP","<%=retMsgP%>");
		response.data.add("arrP",arrE834);
		core.ajax.receivePacket(response);	
		
	<%
	}
	%>
	

	
<%
}
else if ( ajaxType.equals("CLG") )
{

	String clgBT=request.getParameter("clgBT");
	String clgET=request.getParameter("clgET");
	
	System.out.println("@zhangyan~~~~clgBT="+clgBT);
	System.out.println("@zhangyan~~~~clgET="+clgET);	
%>
	<wtc:service name="sE835Qry" outnum="6" 
		retcode="retCodeC" retmsg="retMsgC" 
		routerKey="region" routerValue="<%=regCode%>">
	  	<wtc:param value="<%=loginAccept%>"/>
	  	<wtc:param value="<%=iChnSource%>"/>
	  	<wtc:param value="e835"/>
	  	<wtc:param value="<%=workNo%>"/>
	  	<wtc:param value="<%=iLoginPwd%>"/>
	  	<wtc:param value="<%=iPhoneNo%>"/>
	  	<wtc:param value="<%=iUserPwd%>"/>
	  	<wtc:param value="<%=iOpNote%>"/>
	  	<wtc:param value="<%=clgBT%>"/>
	  	<wtc:param value="<%=clgET%>"/>
	</wtc:service>
	<wtc:array id="rstE835" scope="end"/> 		
	
	/*定义用于传到主界面的数组*/

	<%
		System.out.println("zhangyan~~~~retCodeC="+retCodeC);
	if ( !retCodeC.equals("000000") )
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retCodeC","<%=retCodeC%>");
		response.data.add("retMsgC","<%=retMsgC%>");		
		core.ajax.receivePacket(response);
	<%
	}
	else
	{
	%>
		/*按行遍历服务结果数组*/
		var arrE835 = new Array;
		<%
		for ( int i=0;i<rstE835.length;i++ )
		{
		%>
			arrE835[<%=i%>]=new Array;
			<%
			for ( int j=0;j<rstE835[i].length;j++ )
			{
				System.out.println("@zhangyan~~~~rstE835="+rstE835[i][j]);
				%>
				arrE835[<%=i%>][<%=j%>]="<%=rstE835[i][j]%>";
				<%
			}
		}
		%>
		
		var response = new AJAXPacket();
		response.data.add("retCodeC","<%=retCodeC%>");
		response.data.add("retMsgC","<%=retMsgC%>");		
		response.data.add("arrC",arrE835);
		core.ajax.receivePacket(response);
	<%
	}
	%>	
<%
}
else if ( ajaxType.equals("INIT") )
{
%>
	<wtc:service name="sE834Init" outnum="6" 
		retcode="retCodeI" retmsg="retMsgI" 
		routerKey="region" routerValue="<%=regCode%>">
	  	<wtc:param value="<%=loginAccept%>"/>
	  	<wtc:param value="<%=iChnSource%>"/>
	  	<wtc:param value="e834"/>
	  	<wtc:param value="<%=workNo%>"/>
	  	<wtc:param value="<%=iLoginPwd%>"/>
	  	<wtc:param value="<%=iPhoneNo%>"/>
	  	<wtc:param value="<%=iUserPwd%>"/>
	  	<wtc:param value="<%=iOpNote%>"/>
	</wtc:service>
	<wtc:array id="rstE834I" scope="end"/> 		
	
	/*定义用于传到主界面的数组*/
	var arrE834I = new Array;
	<%
	System.out.println("@zhangyan~~~~rstE834I.length"+rstE834I.length);
	System.out.println("@zhangyan~~~~retCodeI"+retCodeI);
	
	if ( !retCodeI.equals("000000") )
	{
	%>
		var response = new AJAXPacket();
		
		response.data.add("retCodeI","<%=retCodeI%>");
		response.data.add("retMsgI","<%=retMsgI%>");		
		response.data.add("arrI",arrE834I);
		core.ajax.receivePacket(response);
	<%
	}
	%>	
	/*按行遍历服务结果数组*/
	<%
	for ( int i=0;i<rstE834I.length;i++ )
	{
	%>
		arrE834I[<%=i%>]=new Array;
		<%
		for ( int j=0;j<rstE834I[i].length;j++ )
		{
			System.out.println("@zhangyan~~~~rstE834I="+rstE834I[i][j]);
			%>
			arrE834I[<%=i%>][<%=j%>]="<%=rstE834I[i][j]%>";
			<%
		}
	}
	%>
	
	var response = new AJAXPacket();
	response.data.add("arrI",arrE834I);
	response.data.add("retCodeI","<%=retCodeI%>");
	response.data.add("retMsgI","<%=retMsgI%>");		
	core.ajax.receivePacket(response);
<%
}
%>
