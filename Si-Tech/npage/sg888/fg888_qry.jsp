<%
/********************
 * 版本: 1.0
 * 作者: zhangyan
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_doQryMIfo") ) //返回字符串
{
	String iLoginAccept=request.getParameter("iLoginAccept");
	String iChnSource=request.getParameter("iChnSource");
	String iOpCode=request.getParameter("iOpCode");
	String iLoginNo=request.getParameter("iLoginNo");
	String iLoginPwd=request.getParameter("iLoginPwd");
	String iPhoneNo=request.getParameter("iPhoneNo");
	String iUserPwd=request.getParameter("iUserPwd");
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
else if (s_ajaxType.equals("setQry")) //返回html
{
	String s_accept=request.getParameter("s_accept");
	String s_chnSrc=request.getParameter("s_chnSrc");
	String s_opCode=request.getParameter("s_opCode");
	String s_workNo=request.getParameter("s_workNo");
	String s_passwd=request.getParameter("s_passwd");
	String s_phoNo =request.getParameter("s_phoNo");   
	String s_usrPwd=request.getParameter("s_usrPwd");
	String qry_reg_code=request.getParameter("reg_code");
System.out.println("qry_reg_code~~~"+qry_reg_code);
%>
	<wtc:service name="sG888Qry" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" retcode="rc_doGetProdAA" retmsg="rm_doGetProdAA" >
		<wtc:param value="<%=s_accept%>"/>
		<wtc:param value="<%=s_chnSrc%>"/>
		<wtc:param value="<%=s_opCode%>"/>
		<wtc:param value="<%=s_workNo%>"/>
		<wtc:param value="<%=s_passwd%>"/>
		<wtc:param value="<%=s_phoNo%>"/>
		<wtc:param value="<%=s_usrPwd%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=qry_reg_code%>"/>
	</wtc:service>
	<wtc:array id="rst" scope="end" />
	<table id="tb_qry" >
		<th align="center">手机号码</th>    
		<th align="center">地市代码</th>    
		<th align="center">地市名称</th>    
		<th align="center">操作</th>    

<%
	if ( rst.length>0 )
	{
		for ( int i=0;i<rst.length;i++ )
		{
		%>
			<tr>
				<td align="center">
					<input type="text" id='pho_no<%=i%>' name="qry_pho_no" value="<%=rst[i][0]%>" class="InputGrey" readOnly>
				</td>
				<td align="center">                
					<input type="text" id='reg_code<%=i%>' name="qry_reg_code" value="<%=rst[i][1]%>" class="InputGrey" readOnly>
				</td>
				<td align="center">                
					<input type="text" id='' name="" value="<%=rst[i][2]%>" class="InputGrey" readOnly>
				</td>
				<td align="center">                
					<input type="button" id='' name="" value="删除" class="b_text" readOnly onclick='doDel(<%=i%>)'>
				</td>						
			</tr>        
		<%
		}
	}
	else
	{
		%>
			<tr>
				<td align="center" colspan='4'>
					该地市没有配置集团套卡短信提醒号码!
				</td>						
			</tr>        
		<%	
	}
	%>
	</table>
<%
}
%>
