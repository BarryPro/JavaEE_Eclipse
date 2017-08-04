<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String regCode=(String)session.getAttribute("regCode");
String ajaxType=request.getParameter("ajaxType");

if ( ajaxType.equals("getProdInfo") )
{
	String loginAccept = request.getParameter("loginAccept");
	String chnSrc = request.getParameter("chnSrc");
	String opCode = request.getParameter("opCode");
	String workNo = request.getParameter("workNo");
	String passwd = request.getParameter("passwd");
	String cldPhoneNo = request.getParameter("cldPhoneNo");
	String cldPwd = request.getParameter("cldPwd");
	System.out.println("e889~~~~cldPhoneNo="+cldPhoneNo);
%>
	<wtc:service name="sChildOfferInit" outnum="4"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSrc%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passwd%>"/>
		<wtc:param value="<%=cldPhoneNo%>"/>
		<wtc:param value="<%=cldPwd%>"/>
		<wtc:param value="1"/>
	</wtc:service>
	<wtc:array id="rstProd" scope="end" />
	
	var arrPid=new Array();
	var arrPnm=new Array();
		
	<%
	System.out.println("e889~~~~retCode="+retCode);
	System.out.println("e889~~~~rstProd.length="+rstProd.length);
	
	if ( retCode.equals("000000") && rstProd.length>0 )
	{
		for ( int i=0; i<rstProd.length; i++ )
		{
		%>
			arrPid[<%=i%>]="<%=rstProd[i][0]%>";
			arrPnm[<%=i%>]="<%=rstProd[i][1]%>";
		<%
		}
		%>
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");		
		response.data.add("arrPid",arrPid);
		response.data.add("arrPnm",arrPnm);
		core.ajax.receivePacket(response);
	<%
	}
	else
	{
		if (retCode.equals("000000") && rstProd.length<=0)
		{
			retCode="ZZZZZZ"; 
			retMsg="查询结果为空"; 
		}
	
	%>
		var response = new AJAXPacket();
		response.data.add("retCode",retCode);
		response.data.add("retMsg",retMsg);		
		core.ajax.receivePacket(response);	
	<%
	}		
		
}
else if ( ajaxType.equals("getWlanInfo") )
{
	String cldPhone=request.getParameter("cldPhone");
	
	String sql="select count(1) from wwlanusermsghis t where t.opr_code='D' and t.phone_no=:cldPhone "
		+"and to_char(update_time,'yyyymmdd')=to_char(sysdate , 'yyyymmdd')";
	
	String sqlPrm="cldPhone="+cldPhone;
	
	System.out.println("e889~~~~sql="+sql);
	System.out.println("e889~~~~cldPhone="+cldPhone);
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" 
	retmsg="msg0" retcode="code0" outnum="1">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="<%=sqlPrm%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
	 <%
	 	System.out.println("e889~~~~result0="+result0[0][0]);
	 %>
		var response = new AJAXPacket();
		response.data.add("wlanRst","<%=result0[0][0]%>");	
		core.ajax.receivePacket(response);	
	<%
}
%>