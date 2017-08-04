<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
String opCode = "g961";
String opName = "空中充值批量转账情况查询";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
String op_code = "g961"  ;
String phone_no = request.getParameter("phoneno");
String s_begin = request.getParameter("s_begin");
String s_end = request.getParameter("s_end");

String[] inPutArray = new String[2];
//inPutArray[0]="select to_char(phone_no),to_char(statis_month),to_char(sum(flow_fee)),to_char(sum(flow_count)) from dflowfilemsg where phone_no=:s_phone_no and statis_month =:s_month group by phone_no,statis_month";
//inPutArray[0]="select to_char(a.phone_no),to_char(a.op_time,'YYYYMMDD hh24:mi:ss'),a.login_no,to_char(sysdate,'YYYYMMDD hh24:mi:ss'),to_char(a.pay_money),to_char(a.agt_phone),c.cust_name from dagtchargemsg a,dcustmsg b,dcustdoc c where a.agt_phone = b.phone_No and b.cust_id = c.cust_id and a.phone_no = :s_phone_no and to_char(a.op_time,'YYYYMMDD') =:s_month   ";
//inPutArray[1]="s_phone_no="+phone_no+",s_month="+year_month; 
inPutArray[0]="select to_char(cust_phone),to_char(import_time,'YYYYMMDD hh24:mi:ss'),import_login,to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(pay_money),to_char(agt_phone),agt_name,'充值成功',to_char(login_accept) from dagtchargeopr where cust_phone=:s_phone_no and to_char(op_time,'YYYYMMDD')<=:s_date1 and to_char(op_time,'YYYYMMDD')>=:s_date2 union all select to_char(phone_no),to_char(import_time,'YYYYMMDD hh24:mi:ss'),import_login,to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(pay_money),to_char(agt_phone),agt_name,op_note,'' from dagtchargemsgerr where phone_no=:s_phone_no2 and to_char(op_time,'YYYYMMDD')<=:s_date11 and to_char(op_time,'YYYYMMDD')>=:s_date21 ";
inPutArray[1]="s_phone_no="+phone_no+",s_date1="+s_end+",s_date2="+s_begin+",s_phone_no2="+phone_no+",s_date11="+s_end+",s_date21="+s_begin;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="9" >
		<wtc:param value="<%=inPutArray[0]%>"/> 
		<wtc:param value="<%=inPutArray[1]%>"/> 
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 
<%   
	 
	if(result==null||result.length==0){
		%>
			 <script language="javascript">
				rdShowMessageDialog("查询结果为空.请重新查询",0);
				window.location.href="g961_1.jsp";
			</script>
		<% 
		 
	}
	
	else
	{
		System.out.println("success~~~~~~~~~~~~~~~~~~~~~~~~~ !");
		%>
		<html xmlns="http://www.w3.org/1999/xhtml">
			<HEAD><TITLE>空中充值批量充值查询结果</TITLE>
			</HEAD>
			<body>
			<FORM method=post name="frm1508_2">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">查询结果</div>
			</div>
			<table cellspacing="0" id = "PrintA">
                <tr>
					<th>被充值手机号码</th>
					<th>导入时间</th>
					<th>导入工号</th>
					<th>充值时间</th>
					<th>充值金额</th>
					<th>代理商手机号码</th>
					<th>代理商名称</th>
					<th>充值成功/失败原因</th>
					<th>业务流水</th>
				</tr>
				<%
					for(int i=0;i<result.length;i++)
					{
						%>
						<tr>
							<td><%=result[i][0]%></td>
							<td><%=result[i][1]%></td>
							<td><%=result[i][2]%></td>
							<td><%=result[i][3]%></td>
							<td><%=result[i][4]%>(元)</td>
							<td><%=result[i][5]%></td>
							<td><%=result[i][6]%></td>
							<td><%=result[i][7]%></td>
							<td><%=result[i][8]%></td>
						</tr>
						<%
					}
				%>
				
				
			</table>
			
			<table cellSpacing="0">
				<tr> 
				  <td id="footer"> 
				  
					   <input type="button" name="back" class="b_foot" value="返回" onclick="window.location.href='g961_1.jsp'" >
					  &nbsp;
					 
				  </td>
				</tr>
			 </table>
		<%@ include file="/npage/include/footer.jsp" %>
 
			</FORM>
		</BODY>


		</HTML>
			 
		<% 
	}
	 
	
%>
 



