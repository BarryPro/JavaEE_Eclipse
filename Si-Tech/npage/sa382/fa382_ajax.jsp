<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("setIfo") ) //返回字符串
{
	System.out.println(" s_ajaxType = " + s_ajaxType );
}
else if ( s_ajaxType.equals("getLst") ) //返回html
{
	String accept = request.getParameter( "logAcc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = request.getParameter( "workNo" );
	String passwd = request.getParameter( "passwd" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = request.getParameter( "usrPwd" );
	
	String comp_odr_id = request.getParameter( "comp_odr_id" );
	String svcName = "sA382Qry"; //sJQKTest  sA381Qry
%>
	<wtc:service name = "<%=svcName%>" outnum = "30" 
		routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "retcode" retmsg = "retmsg" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			               
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
			
		<wtc:param value = "<%=comp_odr_id%>"/>
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
		
	<input id = 'rc_set_ifo' name = 'rc_set_ifo' type = 'hidden' 
		value = '<%=retcode%>'>
	<input id = 'rm_set_ifo' name = 'rm_set_ifo' type = 'hidden' 
		value = '<%=retmsg%>'>
	<%
	if ( retcode.equals("000000") )
	{
	%>
		<TABLE ID = 'det_ifo' >
			<tr >
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >订单编号</td>
				<td width = '25%' >
					<input id = 'odr_id' name = 'odr_id' type = 'text'
						value = '<%=rst[0][0]%>' class = 'InputGrey'>
				</td>
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >手机号</td>	
				<td width = '25%' >
					<input id = 'pho_no' name = 'pho_no' type = 'text'
						value = '<%=rst[0][1]%>' class = 'InputGrey'>
				</td>			
			</tr>
			<tr>					
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >商品名称</td>
				<td width = '25%' >
					<input id = 'prod_name' name = 'prod_name' type = 'text'
						value = '<%=rst[0][2]%>' class = 'InputGrey'>
				</td>			
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >物流公司名称</td>
				<td width = '25%' >
					<input id = 'comp_nm' name = 'comp_nm' type = 'text'
						value = '<%=rst[0][3]%>' class = 'InputGrey'>					
				</td>			
			</tr>
			<tr>				
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >订单状态</td>
				<td width = '25%' >
					<input id = 'odr_stat' name = 'odr_stat' type = 'text'
						value = '<%=rst[0][4]%>' class = 'InputGrey'>
				</td>		
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >下物流单时间 </td>
				<td width = '25%'>
					<input id = 'odr_fee' name = 'odr_fee' type = 'text'
						value = '<%=rst[0][5]%>' class = 'InputGrey'>
				</td>					
			</tr>
			<tr>				
				<td width = '25%'  ALIGN = 'CENTER' class = 'blue' >收件人电话</td>
				<td width = '25%' colspan = "3">
					<input id = 'odr_stat' name = 'odr_stat' type = 'text'
						value = '<%=rst[0][6]%>' class = 'InputGrey'>
						<input type="hidden" id="odr_flag" name="odr_flag" value="<%=rst[0][7]%>"/>
				</td>						
			</tr>			
		</table>
	<%
	}
}
%>


