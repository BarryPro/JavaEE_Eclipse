<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 批量添加免密信息
　 * 版本: v1.0
　 * 日期: 2012-1-30 10:47:05
　 * 作者: zhangyan
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
/*4 route */
String regionCode = (String)session.getAttribute("regCode");

/*inc head*/
String opName = "客服密码验证配置";
String opCode="6998";

/*input param*/
String iLoginAccept="" ;/*操作流水*/
String iChnSource ="";/*渠道标识*/
String iOpCode =opCode;/*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo"); ;/* 操作工号*/
String iLoginPwd=WtcUtil.repNull((String)session.getAttribute("password"));;/* 工号密码*/
String iPhoneNo="";/* 手机号码*/
String iUserPwd="";/* 用户密码*/
String iOpType=request.getParameter("opType") ;/*操作类型*/
String iFileName=request.getParameter("fileName");/* 文件名称*/ 
String iSystemFlag=request.getParameter("sysFlagFile");
String iIpAddr= realip; /*IP地址*/
//String iIpAddr= "10.110.0.204"; /*IP地址*/

System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iLoginAccept=["+iLoginAccept+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iChnSource=["+iChnSource+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iOpCode=["+iOpCode+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iLoginNo=["+iLoginNo+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iLoginPwd=["+iLoginPwd+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iPhoneNo=["+iPhoneNo+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iUserPwd=["+iUserPwd+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iOpType=["+iOpType+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iFileName=["+iFileName+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iIpAddr=["+iIpAddr+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]iSystemFlag=["+iSystemFlag+"]");
String retCode="";
String retMsg="";
%>
<wtc:service name="s6998BaCfm" routerKey="region" routerValue="<%=regionCode%>" 
	outnum="7"  retcode="code" retmsg="msg">
	<wtc:param value="<%=iLoginAccept%>"/>			
	<wtc:param value="<%=iChnSource%>"/>			
	<wtc:param value="<%=iOpCode%>"/>			
	<wtc:param value="<%=iLoginNo%>"/>			
	<wtc:param value="<%=iLoginPwd%>"/>			
	<wtc:param value="<%=iPhoneNo%>"/>			
	<wtc:param value="<%=iUserPwd%>"/>			
	<wtc:param value="<%=iOpType%>"/>			
	<wtc:param value="<%=iFileName%>"/>			
	<wtc:param value="<%=iIpAddr%>"/>			
	<wtc:param value="<%=iSystemFlag%>"/>			
</wtc:service>
<wtc:array id="result" scope="end"/>
	
<%
retCode=code;
retMsg=msg;
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]retCode=["+retCode+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]retMsg=["+retMsg+"]");
System.out.println("zhangyan@page=[f6998_fileCfm.jsp]result.length=["+result.length+"]");

if ( !retCode.equals("000000") )
{
%>
<script language="JavaScript">
	rdShowMessageDialog("错误代码:"+"<%=retCode%></br>"+"错误信息:"+"<%=retMsg%>",0);
	window.location.replace("f6998_1.jsp");
</script>
<%
}
%>
<HTML>
	<HEAD>
		<TITLE> 未成功号码列表 </TITLE>
	</HEAD>
	<body>
		<FORM method=post name="backandwhite">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
			<div id="title_zi">未成功信息列表</div>
			</div>		
			<TABLE cellSpacing="0">
			<TBODY>
			<TR> 			
				<Th class = "blue">系统标识</Th>
				<Th class = "blue">角色代码</Th>
				<Th class = "blue">角色名称</Th>
				<Th class = "blue">操作代码</Th>
				<Th class = "blue">密码校验标志</Th>
				<Th class = "blue">错误原因</Th>
			</TR>
			<%
			if  ( result.length > 0 )
			{
				if ( !result[0][0].equals("0") )
				{
					System.out.println("zhangyan@page=[f6998_fileCfm.jsp]result[i][0]=["+result[0][0]+"]");
				
					for (int i=0;i<result.length;i++) 
					{			
					%>
					<TR>
						<td> <%=result[i][1]%> </td>
						<td> <%=result[i][2]%> </td>
						<td> <%=result[i][3]%> </td>
						<td> <%=result[i][4]%> </td>
						<td> <%=result[i][5]%> </td>
						<td> <%=result[i][6]%> </td>
					</TR>
					<%
					}
				}
				%>			
				<TR>
					<td colspan = "6">处理失败信息条数:<%=result[result.length-1][0]%>条!</td>
				</TR>		
			<%	
			}
			else
			{
			%>				
				<TR>
					<td colspan = "6">全部成功!</td>
				</TR>
			<%		
			}
			%>
			</TBODY>
			</TABLE>			
			
			<table cellspacing=0>
			<tbody> 
				<tr> 
				<td id="footer">
				<input class="b_foot" name=back 
					onClick="window.location.href='f6998_1.jsp';" type=button value=返回>
				<input class="b_foot" name=close 
					onClick="removeCurrentTab();" type=button value=关闭>
				</td>
				</tr>
			</tbody> 
      		</table>
  			<%@ include file="/npage/include/footer.jsp" %>      
		</FORM>
	</BODY>
</HTML>
