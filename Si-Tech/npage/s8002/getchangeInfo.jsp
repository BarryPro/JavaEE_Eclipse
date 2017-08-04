<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String opCode ="8002";
	String opName = "工号管理";
	String regionCode =  (String)session.getAttribute("regCode");
	
	String dWorkNo = (String)session.getAttribute("workNo");
	String accType = request.getParameter("accountType");/*1_loginNo==login_no;2_loginNo==account_no*/
	String loginNo = request.getParameter("loginNo");    /*根据accType取值*/
	String strSql = "";
	String opAccType = "1";
	
	if(dWorkNo.substring(0,1).equals("8") || dWorkNo.substring(0,1).equals("9"))
	{
		opAccType = "2";
	}
	
	if(accType.equals("1"))
	{
		System.out.println("++++++login_no++++++");
		strSql = "select e.account_no,decode(e.account_type,'1','营业类BOSS帐号','2','客服帐号','3','管理类BOSS帐号',e.account_type),"+
				"e.login_no,e.login_name,e.power_name,"+
				"e.power_right,e.right_name,e.update_login,e.update_time,"+
				"case when e.update_code='8004' then e.login_name "+
				"else f.login_name end,g.function_name from "+
				"(select  d.account_no,d.account_type,d.update_code,a.login_no,d.login_name,"+
				"b.power_name,d.power_right,c.right_name,d.update_login,d.update_time "+
				"from dloginmsg a,spowercode b ,srptright c,dloginmsghis d "+
				"where a.login_no='"+loginNo+"' and d.power_code=b.power_code "+
				"and a.rpt_right=c.rpt_right and a.login_no =d.login_no) e,dLoginMsg f,sFuncCode g "+
				"where e.update_login=f.login_no and e.update_code=g.function_code ";
	}
	else
	{
		System.out.println("========account_no=========");
		strSql = "select e.account_no,decode(e.account_type,'1','营业类BOSS帐号','2','客服帐号','3','管理类BOSS帐号',e.account_type),"+
				"e.login_no,e.login_name,e.power_name,"+
				"e.power_right,e.right_name,e.update_login,e.update_time,"+
				"case when e.update_code='8004' then e.login_name "+
				"else f.login_name end,g.function_name from "+
				"(select  d.account_no,d.account_type,d.update_code,a.login_no,d.login_name,"+
				"b.power_name,d.power_right,c.right_name,d.update_login,d.update_time "+
				"from dloginmsg a,spowercode b ,srptright c,dloginmsghis d "+
				"where a.account_no='"+loginNo+"' and d.power_code=b.power_code "+
				"and a.rpt_right=c.rpt_right and a.login_no =d.login_no) e,dLoginMsg f,sFuncCode g "+
				"where e.update_login=f.login_no and e.update_code=g.function_code ";
	}
	
	if(opAccType.equals("2"))
	{
		strSql = strSql + " and f.account_type = '2' ";
	}
	strSql = strSql + " order by e.update_time ";
	
	//comImpl co=new comImpl();
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="11">
		<wtc:sql><%=strSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="nott" scope="end" />
<%
	//ArrayList noArr = co.spubqry32("11",strSql);
	//String[][] nott = (String[][])noArr.get(0);
%>
<html>	
	<body>
		<form name=frm>
			<%@ include file="/npage/include/header.jsp" %>   
			<div class="title">
				<div id="title_zi">符合条件工号信息列表</div>
			</div>
			<TABLE  cellSpacing=0 vColorTr='set'>
				<TBODY>
					<tr> 
						<th width="13%" nowrap>帐号代码</th>
						<th width="10%" nowrap>帐号类型</th>
						<th width="13%" nowrap>工号代码</th>
						<th width="13%" nowrap>工号名称</th>
						<th width="23%" nowrap>角色代码</th>
						<th width="13%" nowrap>权限值名称</th>
						<th width="23%" nowrap>报表权限名称</th>
						<th width="23%" nowrap>操作工号</th>
						<th width="23%" nowrap>工号姓名</th>
						<th width="23%" nowrap>操作时间</th>
						<th width="23%" nowrap>操作名称</th>
					</tr>
			    <%for(int i = 0 ; i < nott.length ; i ++)
			    {%>
			    <tr> 
			    	<td width="12%">
			    		<input  type=hidden name=account_no<%=i%> disabled ><%=nott[i][0]%>
			    	</td>
			    	<td width="12%">
			    		<input  type=hidden name=account_type<%=i%> disabled ><%=nott[i][1]%>
			    	</td>
					<td width="13%">
						<input  type=hidden name=work_no<%=i%> disabled ><%=nott[i][2]%>
					</td>
					<td width="13%">
						<input  type=hidden name=login_name<%=i%> disabled ><%=nott[i][3]%>
					</td>
					<td width="23%">
						<input  type=hidden  name=power_name<%=i%> disabled ><%=nott[i][4]%>
					</td>
			 		<td width="13%">
						<input  type=hidden name=power_right<%=i%> disabled ><%=nott[i][5]%>
					</td>
			 		<td width="23%">
						<input  type=hidden name=rpt_name<%=i%> disabled ><%=nott[i][6]%>
					</td>
					<td width="23%">
						<input  type=hidden name=update_login<%=i%>  disabled ><%=nott[i][7]%>
					</td>
					<td width="23%">
						<input  type=hidden name=update_name<%=i%>  disabled ><%=nott[i][9]%>
					</td>
					<td width="23%">
						<input  type=hidden name=update_time<%=i%>  disabled ><%=nott[i][8]%>
					</td>
					<td width="23%">
						<input  type=hidden name=update_time<%=i%>  disabled ><%=nott[i][10]%>
					</td>
				</tr>
				<%}%>
			</TBODY>			
			</TABLE>
			
			<TABLE  cellSpacing=0>
				<TBODY>
				    	<TR>
						<TD id="footer" >
							<input class="b_foot" name=submitr  type=button value="关闭" onclick="history.go(-1)" >
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
