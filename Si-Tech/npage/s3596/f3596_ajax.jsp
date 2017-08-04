<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("getIfo") ) //返回字符串
{			
	String logacc = request.getParameter("logacc");
	String chnSrc = request.getParameter("chnSrc");
	String opCode = request.getParameter("opCode");
	String workNo = request.getParameter("workNo");
	String passwd = request.getParameter("passwd");
	
	String phoneNo = request.getParameter("phoneNo");
	String usrpwd = request.getParameter("usrpwd");
	String iGrpId = request.getParameter("iGrpId");
	String iOpType = request.getParameter("iOpType");
%>
	<wtc:service name="s3596MsgQry" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc" retmsg="rm" >
		<wtc:param value="<%=logacc%>"/>
		<wtc:param value="<%=chnSrc%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passwd%>"/>
			
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=usrpwd%>"/>
		<wtc:param value="<%=iGrpId%>"/>
		<wtc:param value="<%=iOpType%>"/>
		</wtc:service>
	<wtc:array id="rst" scope="end" />
<%    
	if (rc.equals("000000"))
	{
		if ( iOpType.equals("05") ) /*资费变更*/
		{
		%>
			var response = new AJAXPacket();
			response.data.add("oRetCode" ,"<%=rc%>");
			response.data.add("oRetMsg"  ,"<%=rm%>");
			response.data.add("oOldOfferId"  ,"<%=rst[0][0]%>");
			response.data.add("oOldOfferName"  ,"<%=rst[0][1]%>");
			core.ajax.receivePacket(response);    		
		<%
		}
		else if ( iOpType.equals("03") ) /*包年续签*/
		{
		%>
			var response = new AJAXPacket();
			response.data.add("oRetCode" ,"<%=rc%>");
			response.data.add("oRetMsg"  ,"<%=rm%>");
			response.data.add("oOldYearId"  ,"<%=rst[0][0]%>");
			response.data.add("oOldYearName"  ,"<%=rst[0][1]%>");
			core.ajax.receivePacket(response);    		
		<%		
		}
		else if ( iOpType.equals("02") )
		{
			System.out.println("rst~~"+rst.length);
		%>
			var response = new AJAXPacket();
			response.data.add("oRetCode" ,"<%=rc%>");
			response.data.add("oRetMsg"  ,"<%=rm%>");
			response.data.add("oYearFlag"  ,"<%=rst[0][0]%>");
			core.ajax.receivePacket(response);    		
		<%			
		}
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc%>");
		response.data.add("oRetMsg"  ,"<%=rm%>");
		core.ajax.receivePacket(response);    
	<%    
	}
}
else if ( s_ajaxType.equals("getOldIfo") ) 
{
	String logacc = request.getParameter("logacc");
	String chnSrc = request.getParameter("chnSrc");
	String opCode = request.getParameter("opCode");
	String workNo = request.getParameter("workNo");
	String passwd = request.getParameter("passwd");
	
	String phoneNo = request.getParameter("phoneNo");
	String usrpwd = request.getParameter("usrpwd");
	String oldAcc = request.getParameter( "oldAcc" );
	String vidNo = request.getParameter( "vidNo" );
%>
	<wtc:service name="s222Init" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc" retmsg="rm" >
		<wtc:param value="<%=logacc%>"/>
		<wtc:param value="<%=chnSrc%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passwd%>"/>
			
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=usrpwd%>"/>
		<wtc:param value="<%=oldAcc%>"/>
		<wtc:param value="<%=vidNo%>"/>
		</wtc:service>
	<wtc:array id="rst" scope="end" />
<%		
	if ( rc.equals("000000") ) /*资费变更*/
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" , "<%=rc%>");
		response.data.add("oRetMsg"  , "<%=rm%>");
		response.data.add("oMebId"  , "<%=rst[0][0]%>");
		response.data.add("oOldOfferID"  , "<%=rst[0][8]%>");
		response.data.add("oOldOfferName"  , "<%=rst[0][9]%>");
		response.data.add("oNewOfferID"  , "<%=rst[0][10]%>");
		response.data.add("oNewOfferName"  , "<%=rst[0][11]%>");
		response.data.add("oLoginNo"  , "<%=rst[0][7]%>");
		response.data.add("oOpTime"  , "<%=rst[0][5]%>");
		core.ajax.receivePacket(response);    		
	<%
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc%>");
		response.data.add("oRetMsg"  ,"<%=rm%>");
		core.ajax.receivePacket(response);    		
	<%		
	}	
}
%>
