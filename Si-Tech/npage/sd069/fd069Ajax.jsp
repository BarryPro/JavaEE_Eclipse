<%
/*
zhangyan create 2012-06-14 16:45:08
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*���ѻ��ֶ�Ӧ����ѯ*/
String ajaxType=request.getParameter("ajaxType");
if ( ajaxType.equals("getM") )
{
	/*��ҳ�洫�ݵĲ���*/
	String inLoginAccept	="0";
	String inChnSource	="01";
	String inOpCode		=request.getParameter("opCode");
	String inLoginNo		=(String)session.getAttribute("workNo");
	String inLoginPwd		=(String)session.getAttribute("password");
	String inPhoneNo		=(String)request.getParameter("phoneNo");
	String inUserPwd		="";
	String inOpNote		=inOpCode;
	String inregioncode	=(String)session.getAttribute("regCode");	/*���д���*/
	String inMachPrice	=request.getParameter("machPrice"); 		/*������*/
	String inMarkPoint	=request.getParameter("markPoint"); 		/*���ѻ���*/
	
	System.out.println("d069~~~~inLoginAccept="+inLoginAccept);
	System.out.println("d069~~~~inChnSource="+inChnSource);
	System.out.println("d069~~~~inOpCode="+inOpCode);
	System.out.println("d069~~~~inLoginNo="+inLoginNo);
	System.out.println("d069~~~~inLoginPwd="+inLoginPwd);
	System.out.println("d069~~~~inPhoneNo="+inPhoneNo);
	System.out.println("d069~~~~inUserPwd="+inUserPwd);
	System.out.println("d069~~~~inOpNote="+inOpNote);
	System.out.println("d069~~~~inregioncode="+inregioncode);
	System.out.println("d069~~~~inMachPrice="+inMachPrice);
	System.out.println("d069~~~~inMarkPoint="+inMarkPoint);
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
	/*���񷵻�����*/
	System.out.println(inOpCode+"~~~~rtCode="+rtCode);
	System.out.println(inOpCode+"~~~~rstMarkQry.length="+rstMarkQry.length);
	System.out.println(inOpCode+"~~~~rstMarkQry[0][0]="+rstMarkQry[0][0]);

	if ( rtCode.equals("000000") )
	{
		/*����û�з��ؽ��*/
		if ( rstMarkQry.length==0 )
		{
		%>
			var response = new AJAXPacket();
			response.data.add("rtCode","ZY0000");
			response.data.add("rtMsg","���񷵻ؽ��Ϊ��!");
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
	else /*����У�����*/
	{
	%>	
		var response = new AJAXPacket();
		response.data.add("rtCode","<%=rtCode%>");
		response.data.add("rtMsg","<%=rtMsg%>");
		core.ajax.receivePacket(response);
	<%
	}
}
%>
