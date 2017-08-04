<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_doQryMIfo") )
{
	String iLoginAccept=request.getParameter("iLoginAccept");
	String iChnSource=request.getParameter("iChnSource");
	String iOpCode=request.getParameter("iOpCode");
	String iLoginNo=request.getParameter("iLoginNo");
	String iLoginPwd=request.getParameter("iLoginPwd");
	
	String iPhoneNo=request.getParameter("iPhoneNo");
	String iUserPwd=request.getParameter("iUserPwd");
	String iSubsId=request.getParameter("iSubsId");
	String iProdInstId=request.getParameter("iProdInstId");
	String uUserNo=request.getParameter("ecUsrId");
	
    if( iPhoneNo.length() > 5 && iPhoneNo.substring(0,5).equals("10648")) {
		iPhoneNo = iPhoneNo.replaceFirst("10648", "205");
	}
    if( iPhoneNo.length() > 5 && iPhoneNo.substring(0,5).equals("10647")) {
		iPhoneNo = iPhoneNo.replaceFirst("10647", "206");
	}
	
//    if( iPhoneNo.length() > 3 && iPhoneNo.substring(0,3).equals("147")) {
//		iPhoneNo = iPhoneNo.replaceFirst("147", "206");
//	}	
	

%>
	<wtc:service name="sPbossPhoneQry" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_fnDoGetProdInst" retmsg="rm_fnDoGetProdInst" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
			
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iSubsId%>"/>
		<wtc:param value="<%=uUserNo%>"/>
		<wtc:param value="<%=iProdInstId%>"/>
	
	</wtc:service>
	<wtc:array id="rst_fnDoGetProdInst" scope="end" />
<%
	if (rc_fnDoGetProdInst.equals("000000"))
	{
	%>   
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc_fnDoGetProdInst%>");
		response.data.add("oRetMsg"  ,"<%=rm_fnDoGetProdInst%>");
		
		response.data.add("oPhoneNo"  ,'<%=rst_fnDoGetProdInst[0][0]%>');
		response.data.add("oUserName"  ,'<%=rst_fnDoGetProdInst[0][1]%>');
		response.data.add("oOfferId"  ,'<%=rst_fnDoGetProdInst[0][2]%>');
		response.data.add("oOfferName"  ,'<%=rst_fnDoGetProdInst[0][3]%>');
		response.data.add("oProdId"  ,'<%=rst_fnDoGetProdInst[0][4]%>');
		
		response.data.add("oProdInstId"  ,'<%=rst_fnDoGetProdInst[0][5]%>');
		response.data.add("oMemSubsId"  ,'<%=rst_fnDoGetProdInst[0][6]%>');
		response.data.add("oProvinceId"  ,'<%=rst_fnDoGetProdInst[0][7]%>');
		core.ajax.receivePacket(response);	
	<%
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc_fnDoGetProdInst%>");
		response.data.add("oRetMsg"  ,"<%=rm_fnDoGetProdInst%>");
		core.ajax.receivePacket(response);	
	<%	
	}
}
else if ( s_ajaxType.equals("fn_doGetProdOdr") )
{
	String s_iLoginAccept=request.getParameter("iLoginAccept");
	String s_iOpCode=request.getParameter("iOpCode");
	String s_iLoginNo=request.getParameter("iLoginNo");
	String s_iLoginPwd=request.getParameter("iLoginPwd");
	String s_iPhoneNo=request.getParameter("iPhoneNo");
	String s_iUserPwd=request.getParameter("iUserPwd");
	String s_iCustomerNumber=request.getParameter("iCustomerNumber");
	String s_iOpType=request.getParameter("iOpType");
	String s_iUnitId=request.getParameter("iUnitId");

%>
	<wtc:service name="sPbossSeqQry" outnum="5"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_fnDoGetProdInst" retmsg="rm_fnDoGetProdInst" >
		<wtc:param value="<%=s_iLoginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=s_iOpCode%>"/>
		<wtc:param value="<%=s_iLoginNo%>"/>
		<wtc:param value="<%=s_iLoginPwd%>"/>
		<wtc:param value="<%=s_iPhoneNo%>"/>
		<wtc:param value="<%=s_iUserPwd%>"/>
		<wtc:param value="seq14"/>
	</wtc:service>
	<wtc:array id="rst_fnDoGetProdInst" scope="end" />

	var response = new AJAXPacket();
	response.data.add("oRetCode" ,"<%=rc_fnDoGetProdInst%>");
	response.data.add("oRetMsg"  ,"<%=rm_fnDoGetProdInst%>");
	response.data.add("outSeq"  ,"<%=rst_fnDoGetProdInst[0][0]%>");
	core.ajax.receivePacket(response);
<%
}

else if ( s_ajaxType.equals("fn_doQryMPIfo") )
{
	String s_iLoginAccept=request.getParameter("iLoginAccept");
	String s_iOpCode=request.getParameter("iOpCode");
	String s_iLoginNo=request.getParameter("iLoginNo");
	String s_iLoginPwd=request.getParameter("iLoginPwd");
	String s_iPhoneNo=request.getParameter("iPhoneNo");
	String s_iUserPwd=request.getParameter("iUserPwd");
	String iSubsId=request.getParameter("iSubsId");
	String ecUsrId=request.getParameter("ecUsrId");
	
    if( s_iPhoneNo.length() > 5 && s_iPhoneNo.substring(0,5).equals("10648")) {
		s_iPhoneNo = s_iPhoneNo.replaceFirst("10648", "205");
	}
    if( s_iPhoneNo.length() > 5 && s_iPhoneNo.substring(0,5).equals("10647")) {
		s_iPhoneNo = s_iPhoneNo.replaceFirst("10647", "206");
	}
	
 //   if( s_iPhoneNo.length() > 3 && s_iPhoneNo.substring(0,3).equals("147")) {
//		s_iPhoneNo = s_iPhoneNo.replaceFirst("147", "206");
//	}		
%>
	<wtc:service name="sMemProdListQry" outnum="5"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_fnDoGetProdInst1" retmsg="rm_fnDoGetProdInst1" >
		<wtc:param value="<%=s_iLoginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=s_iOpCode%>"/>
		<wtc:param value="<%=s_iLoginNo%>"/>
		<wtc:param value="<%=s_iLoginPwd%>"/>
			
		<wtc:param value="<%=s_iPhoneNo%>"/>
		<wtc:param value="<%=s_iUserPwd%>"/>
		<wtc:param value="<%=iSubsId%>"/>
		<wtc:param value="<%=ecUsrId%>"/>
	</wtc:service>
	<wtc:array id="rst_fnDoGetProdInst1" scope="end" />
	<%
	String s_outJsn="";
	for ( int i=0;i<rst_fnDoGetProdInst1.length ;i++)
	{
		s_outJsn=s_outJsn+rst_fnDoGetProdInst1[i][0];
		System.out.println("!!!!rst_fnDoGetProdInst1!!>>>>>>>"+s_outJsn);
	}

	if (rc_fnDoGetProdInst1.equals("000000"))
	{
		//rst_fnDoGetProdInst[0][0].
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc_fnDoGetProdInst1%>");
		response.data.add("oRetMsg"  ,"<%=rm_fnDoGetProdInst1%>");
		response.data.add("oProdJsonStr"  ,'<%=s_outJsn%>');
		core.ajax.receivePacket(response);	
	<%
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc_fnDoGetProdInst1%>");
		response.data.add("oRetMsg"  ,"<%=rm_fnDoGetProdInst1%>");
		core.ajax.receivePacket(response);	
	<%	
	}
	%>

<%
}
else if (s_ajaxType.equals("doGetProdAA"))
{
	String s_accept=request.getParameter("s_accept");
	String s_chnSrc=request.getParameter("s_chnSrc");
	String s_opCode=request.getParameter("s_opCode");
	String s_workNo=request.getParameter("s_workNo");
	String s_passwd=request.getParameter("s_passwd");
	String s_phoNo =request.getParameter("s_phoNo");   
	String s_usrPwd=request.getParameter("s_usrPwd");
	String s_offerId=request.getParameter("s_unitOffer");
	String s_entType=request.getParameter("s_prodId");
%>
	<wtc:service name="sg599QrySerAttr" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" retcode="rc_doGetProdAA" retmsg="rm_doGetProdAA" >
		<wtc:param value="<%=s_accept%>"/>
		<wtc:param value="<%=s_chnSrc%>"/>
		<wtc:param value="<%=s_opCode%>"/>
		<wtc:param value="<%=s_workNo%>"/>
		<wtc:param value="<%=s_passwd%>"/>
		<wtc:param value="<%=s_phoNo%>"/>
		<wtc:param value="<%=s_usrPwd%>"/>
		<wtc:param value="<%=s_offerId%>"/>
		<wtc:param value="<%=s_entType%>"/>
	</wtc:service>
	<wtc:array id="rst_doGetProdAA" scope="end" />
		
	<table id="tb_prodAAList" >
		<th align="center">服务代码</th>	
		<th align="center">附加属性代码</th>	
		<th align="center">附加属性名称</th>	
		<th align="center">附加属性默认值</th>	
		<th align="center">是否必须</th>	

<%
System.out.println("rst_doGetProdAA.length~~~"+rst_doGetProdAA.length);

	for ( int i=0;i<rst_doGetProdAA.length;i++ )
	{
		String ifNeeds="否";
		if (rst_doGetProdAA[i][4].equals("1"))
		{
			ifNeeds="是";
		}
	%>
		<tr>
			<td align="center"><input type="text" 
				name="t_prodAAServId" value="<%=rst_doGetProdAA[i][0]%>" class="InputGrey" readOnly>
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAId" value="<%=rst_doGetProdAA[i][1]%>" class="InputGrey" readOnly>
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAName" value="<%=rst_doGetProdAA[i][2]%>" class="InputGrey" readOnly>
			</td>
			<td align="center"><input type="text"  ch_name='附加属性默认值'
				name="t_prodAADef" value="<%=rst_doGetProdAA[i][3]%>">
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAIfNeeds" value="<%=ifNeeds%>" class="InputGrey" readOnly>
				<input type="hidden" name="t_needsCode" value="<%=rst_doGetProdAA[i][4]%>" class="InputGrey" readOnly>
				
			</td>
		</tr>		
	<%
	}
	%>
	</table>
<%
}
%>
		