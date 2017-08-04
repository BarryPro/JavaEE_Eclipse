<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_chkMebPho") )
{	
	String s_loginacc=request.getParameter("s_loginacc");
	String s_chnSrc=request.getParameter("s_chnSrc");
	String s_opCode=request.getParameter("s_opCode");
	String s_workNo=request.getParameter("s_workNo");
	String s_passwd=request.getParameter("s_passwd");
	String s_phone=request.getParameter("s_phone");
	String s_userPwd=request.getParameter("s_userPwd");
	String s_orgCode=(String)session.getAttribute("orgCode");
	String s_unitId=request.getParameter("s_unitId");
	String s_mebPho=request.getParameter("t_mebPho");
	
	/*
    if( s_mebPho.length() > 5 && s_mebPho.substring(0,5).equals("10648")) {
		s_mebPho = s_mebPho.replaceFirst("10648", "205");
	}	
	
    if( s_mebPho.length() > 3 && s_mebPho.substring(0,3).equals("147")) {
		s_mebPho = s_mebPho.replaceFirst("147", "206");
	}		
	*/
	//sCheckPhoneNo
%>
	<wtc:service name="sCheckPhoneNo" outnum="20" routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_chkMeb" retmsg="rm_chkMeb" >
		<wtc:param value="<%=s_workNo%>"/>
		<wtc:param value="<%=s_passwd%>"/>
		<wtc:param value="<%=s_opCode%>"/>
			
		<wtc:param value="<%=s_orgCode%>"/>
		<wtc:param value="<%=s_unitId%>"/>
		<wtc:param value="<%=s_mebPho%>"/>
	
		<wtc:param value=""/>
		<wtc:param value="PA"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="rst_chkMeb" scope="end" />
		
		
	<%
	System.out.println("rst_chkMeb[0][10]~~~"+rst_chkMeb[0][10]);
	if ( rc_chkMeb.equals("000000") )
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc_chkMeb%>");
		response.data.add("oRetMsg"  ,"<%=rm_chkMeb%>");
		response.data.add("SubsID"  ,"<%=rst_chkMeb[0][0]%>");
		response.data.add("OfferId"  ,"<%=rst_chkMeb[0][8]%>");
		response.data.add("OfferName"  ,"<%=rst_chkMeb[0][9]%>");
		response.data.add("ProdID"  ,"<%=rst_chkMeb[0][10]%>");
		response.data.add("ProdInstID"  ,"<%=rst_chkMeb[0][11]%>");
		core.ajax.receivePacket(response);
	<%	
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc_chkMeb%>");
		response.data.add("oRetMsg"  ,"<%=rm_chkMeb%>");
		core.ajax.receivePacket(response);
	<%		
	}
	%>

<%
}

else if ( s_ajaxType.equals("fn_doGetProdInst") )
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
else if ( s_ajaxType.equals("fn_doGetUsrId") )
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
		<wtc:param value="sPbossSubsIDSeq"/>
	</wtc:service>
	<wtc:array id="rst_fnDoGetProdInst" scope="end" />

	var response = new AJAXPacket();
	response.data.add("oRetCode" ,"<%=rc_fnDoGetProdInst%>");
	response.data.add("oRetMsg"  ,"<%=rm_fnDoGetProdInst%>");
	response.data.add("outSeq"  ,"<%=rst_fnDoGetProdInst[0][0]%>");
	core.ajax.receivePacket(response);
<%
}
else if (s_ajaxType.equals("fn_doShowAddAtt"))
{
System.out.println("11111111111111111111");
	String s_accept=request.getParameter("s_loginacc");
	String s_chnSrc=request.getParameter("s_chnSrc");
	String s_opCode=request.getParameter("s_opCode");
	String s_workNo=request.getParameter("s_workNo");
	String s_passwd=request.getParameter("s_passwd");
	String s_phoNo =request.getParameter("s_phone");   
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
	<wtc:array id="rst_doGetProdAA" start="0" length="7" scope="end" />
		
	<table id="tb_prodAAList" >
		<th align="center">服务代码</th>	
		<th align="center">附加属性代码</th>	
		<th align="center">附加属性名称</th>	
		<th align="center">附加属性默认值</th>	
		<th align="center">是否必须</th>	

<%
System.out.println("rst_doGetProdAA.length~~~"+rst_doGetProdAA.length);
for (int i=0;i<rst_doGetProdAA.length;i++){
//	for(int j=0;j<rst_doGetProdAA[i].length;j++){
		System.out.println("liangyl---"+i+"-"+0+"------"+rst_doGetProdAA[i][0]);
		System.out.println("liangyl---"+i+"-"+1+"------"+rst_doGetProdAA[i][1]);
		System.out.println("liangyl---"+i+"-"+2+"------"+rst_doGetProdAA[i][2]);
		System.out.println("liangyl---"+i+"-"+3+"------"+rst_doGetProdAA[i][3]);
		System.out.println("liangyl---"+i+"-"+4+"------"+rst_doGetProdAA[i][4]);
		System.out.println("liangyl---"+i+"-"+5+"------"+rst_doGetProdAA[i][5]);
		System.out.println("liangyl---"+i+"-"+6+"------"+rst_doGetProdAA[i][6]);
//	}
	System.out.println("liangyl------------------------------------------------------");
}
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
			<td align="center">
				<%
				if("text".equals(rst_doGetProdAA[i][5])){%>
					<input type="text" ch_name='附加属性默认值' name="t_prodAADef" value="<%=rst_doGetProdAA[i][3]%>">
				<%}else if("select".equals(rst_doGetProdAA[i][5])){%>
					<select id="t_prodAADef" name="t_prodAADef">
						<%
							String selectStr=rst_doGetProdAA[i][6];
							System.out.println("liangyl---------------"+selectStr);
							String[] selectVal = selectStr.split(",");
							for(int j=0;j<selectVal.length;j++){
								String[] selValue = selectVal[j].split(":");
								%>
								<option value="<%=selValue[0]%>"><%=selValue[1]%></option>
								<%
							}
						%>
					</select>
				<%}%>
				
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAIfNeeds" value="<%=ifNeeds%>" class="InputGrey"  readOnly>
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
		