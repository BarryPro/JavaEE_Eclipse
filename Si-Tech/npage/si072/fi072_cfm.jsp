<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_doQryMIfo") ) //返回字符串
{
	System.out.println("if~~"+s_ajaxType);
}
else if ( s_ajaxType.equals("setLst") ) //返回html
{
	String accept = request.getParameter( "logacc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = request.getParameter( "workNo" );
	String passwd = request.getParameter( "passwd" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = request.getParameter( "usrPwd" );
	String op_acc = request.getParameter( "op_acc" );
	%>
	
	<wtc:service name = "sWlwBatchQry" outnum = "30" 
		routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "retcode" retmsg = "retmsg" >
		<wtc:param value = "<%=op_acc%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			               
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
		
	<TABLE ID = '' >
		<TH ALIGN = "CENTER">手机号码</TH>    
		<TH ALIGN = "CENTER">操作代码</TH>     
		<TH ALIGN = "CENTER">操作工号</TH>     
		<TH ALIGN = "CENTER">文件内容</TH>     
		<TH ALIGN = "CENTER">处理时间</TH>
		     
		<TH ALIGN = "CENTER">集团反馈</TH>     
		<TH ALIGN = "CENTER">反馈内容</TH>   
		<TH ALIGN = "CENTER">集团流水</TH>   
  

<%
	if ( !retcode.equals( "000000" ) )
	{
	%>
		<TR >
			<TD ALIGN = "CENTER" colspan = '8' >无数据!</TD>
		</TR>  	
	<%
	}
	else
	{
		for ( int i=0;i<rst.length;i++ )
		{
		%>
			<TR>
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = '' name = '' VALUE = '<%=rst[i][0]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][1]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>		
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = '' name = '' VALUE = '<%=rst[i][2]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][3]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>		
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = '' name = '' VALUE = '<%=rst[i][4]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
				
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][5]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
						
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' tips="<%=rst[i][6]%>" onmousemove="seashowtip(this.tips,1,150)" onmouseout=seashowtip(this.tips,0,150) VALUE = '<%=rst[i][6]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>		
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][7]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>														
			</TR>        
		<%
		}
	}
	%>
	</TABLE>
<%
}
%>
