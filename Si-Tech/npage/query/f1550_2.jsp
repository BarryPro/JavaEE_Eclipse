 <%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-01-08 页面改造,修改样式
********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	String workNo = (String)session.getAttribute("workNo");    //工号 
	String workName = (String)session.getAttribute("workName");//工号名称  	
	String regionCode= (String)session.getAttribute("regCode");//地市
	String ip_Addr = "172.16.23.13";	
	String opCode = "1550";	
	String opName = request.getParameter("opName");	//header.jsp需要的参数     	
	
	//输入参数 查询类型，查询条件，机构代码，工号，权限代码。	
	String queryType  = request.getParameter("QueryType");//查询类型	
	String condText  = request.getParameter("condText");  //手机号码	
	String password ="password";
%>
<wtc:service name="s1550PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=condText%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=opCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%	
	if(!retCode1.equals("000000")){
%>
	<script language="JavaScript">		
		rdShowMessageDialog("<%=retCode1%><br>错误代码 '<%=retMsg1%>'。");
		history.go(-1);
	</script>
	<%	
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("查询结果为空,无此条件信息的相关内容!");
		history.go(-1);
	</script>
<%		
		return;
	}
	System.out.println("!@#$%^&*"+result.length);
	String return_code = result[0][0];
	String return_message = result[0][1];
	if ( (result.length==1)&&( return_code.equals("000000") ) ) {		
		response.sendRedirect("f1550_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]);
		return;
	}
%>

<HTML>
	<HEAD>
		<TITLE>综合历史信息查询</TITLE>
	</HEAD>
	<BODY>
		<FORM method=post name="frm1550">
			<input type="hidden" name="opCode"  value="1550">	
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title" id="changxun">
				<div id="title_zi">查询结果</div>
			</div>		
	    		<table  cellspacing="0">
			      	<tr align="center">
				        <th>服务号码</th>
				        <th>用户ID号</th>
				        <th>用户名称</th>
				        <th>服务类型</th>
				        <th>当前状态</th>  
				        <th>状态变更时间</th>  
				        <th>入网时间</th>
	     			</tr>
				<%
					for(int y=0;y<result.length;y++){
				%>	
					<tr>
					<%    
						for(int j=2;j<result[0].length;j++){
						/*2014/10/08 9:51:16 gaopeng 关于完善BOSS和经分系统客户信息模糊化展示的函（201409） 
							修改 用户名称 模糊化 当j==4时 为用户名称
						*/
						if(j == 4){
								String cust_name = result[y][j];
								if(cust_name != null && !"".equals(cust_name) && !"NULL".equals(cust_name)){
									if(cust_name.length() == 2 ){
										cust_name = cust_name.substring(0,1)+"*";
									}
									if(cust_name.length() == 3 ){
										cust_name = cust_name.substring(0,1)+"**";
									}
									if(cust_name.length() == 4){
										cust_name = cust_name.substring(0,2)+"**";
									}
									if(cust_name.length() > 4){
										cust_name = cust_name.substring(0,2)+"******";
									}
								}
							%>
							<td><div align="center"><a href="f1550_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>"><%=cust_name %> </a></div></td>
							<%
						}else{
					%>
						<td><div align="center"><a href="f1550_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>"><%= result[y][j]%> </a></div></td>
					<%
						
						}
					}
					%>
				</tr>
				<%
				    }
				%>
			</table>
			<table cellspacing="0">
				  <tr> 
					    <td id="footer">
						      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
						      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
						      &nbsp; 
					    </td>
				  </tr>
			</table>
		</FORM>
	</BODY>
</HTML>
