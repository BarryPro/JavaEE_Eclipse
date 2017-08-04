
<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
		String opCode = "e901";
		String opName = "铁通发票信息查询";
		

		String check_key = request.getParameter("check_num");
		//int check = Integer.parseInt(check_key);
		int key = 99999;
		//int realKey = key ^ check;
		
		String phoneNo = request.getParameter("phoneNo");
		String login_accept =  request.getParameter("login_accept");
		String print_time = request.getParameter("print_time");
		String bill_type = "2";
		String[] inParas1 = new String[2];
		
		inParas1[0] = "select to_char(print_content) from Dservorderprtcntt"+print_time+" where serv_order_id in (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = :login_accept  ) and bill_type = :bill_type order by col_num asc";
		inParas1[1] = "login_accept="+login_accept+",bill_type="+bill_type;
		//String sqlStr = "select print_content from Dservorderprtcntt"+print_time+" where serv_order_id = (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = '"+login_accept+"' and rownum=1) and bill_type in ('1','2') order by col_num asc";
//		System.out.println("========QQQQQQQQQQQQQQQQQQ======="+sqlStr);

		 String[][] result = new String[][]{};

		 // xl add 根据查询的function_code 区分业务的展示信息
		String s_function_code="";
		String s_function_name="";
		String s_parent_code="";
		String[] inParas2 = new String[2];
		inParas2[0]="select a.op_code,b.function_name,b.parent_code from Dservorderprtcntt"+print_time+" a,sfunccode b where a.serv_order_id = (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = :login_accept and rownum=1) and a.bill_type ='2' and a.op_code =b.function_code and rownum=1";
		inParas2[1]="login_accept="+login_accept;


%>
		<wtc:service name="TlsPubSelCrm"   retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
		</wtc:service>
		<wtc:array id="ret_val" scope="end" />
<%
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaa s_parent_code is "+ret_val[0][2].trim());
	if(ret_val!=null && ret_val.length>0)
	{
		s_function_code=ret_val[0][0].trim();
		s_function_name=ret_val[0][1].trim();
		s_parent_code=ret_val[0][2].trim();
	}
	/*
	else if(((!s_parent_code.equals("99155"))||(!s_parent_code=="99155"))&&((!s_parent_code.equals("94023"))||!s_parent_code=="94023"))*/

	else
	{
		%><script language="javascript">
				rdShowMessageDialog("发票信息查询失败，请重新输入!");	
				window.location.href='e902.jsp?opCode=e901&opName=铁通发票信息查询&crmActiveOpCode=e901';
		  </script><%
	}
		Date nowTime = new Date();
		//System.out.println("by zhangyta for test，s9493_query.jsp===========现在时间："+nowTime+"========================= s_function_code："+s_function_code);
		%>
		<!--
		<script language="javascript">alert("test s_function_code is "+"<%=s_function_code%>");</script>
		-->
		<%
%>	
<wtc:service name="TlsPubSelCrm"   retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>	
		</wtc:service>
<wtc:array id="retList" scope="end" />	
		
<%
		result = retList;
		
%>
 
<HTML>
<HEAD>
<title>发票信息查询</title>

 

</HEAD>

<BODY>
<FORM action="" method="post" name="frm">
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">发票信息</div>
		</div>
 <%	
 if(retList.length != 0)
 
 // 88-168对应 用opcode去限制
	if((!(s_parent_code.equals("99155")))&&(!(s_parent_code.equals("94023"))))
	{
		%>
		  <script language="javascript">
				rdShowMessageDialog("该功能点仅可查询铁通发票信息!");
				//alert("该功能点仅可查询铁通发票信息 and is "+"<%=s_parent_code%>");
				window.location.href='e902.jsp?opCode=e901&opName=铁通发票信息查询&crmActiveOpCode=e901';
		  </script>
		<%
	}
	else
	{
		int i_length=retList.length;
		String date = result[1][0];
	 %>
		<script language="javascript">//alert("t = "+"<%=retList.length%>");</script>
		<table cellspacing="0">
		<tr>
			<td class="blue" width="15%">缴费日期：<%=date.substring(0,4)%>年<%=date.substring(4,6)%>月<%=date.substring(6,8)%>日</td>
			<td class="blue" width="15%">工号：<%=result[0][0]%></td>
	 
		
			
	<%
		//根据opcode判断 宽带号码的信息
		if(s_function_code.equals("e006")||s_function_code.equals("e007")||s_function_code.equals("e033"))
		{
			%>
			<tr>
				<td class="blue" width="15%">缴费号码:
				<%=result[2][0]%>
				</td>
				<td class="blue" width="15%">
				<%=result[4][0]%>
				</td>
			</tr>
			<tr>
				<td class="blue" width="15%">缴费金额(大写)：
				<%=result[5][0]%>
				</td>
				<td class="blue" width="15%">缴费金额(小写)：￥
				<%=result[6][0]%>
				</td>
			</tr>
			<tr>
				<td class="blue" width="15%">帐号：
				<%=result[3][0]%>
				</td>
				<td class="blue" width="15%">
				<%=result[8][0]%>
				</td>
			</tr>
			<tr>
				<td class="blue" colspan=2>业务名称：
				<%=s_function_name%>
				</td>
				 
			</tr>
			<tr>
				<td class="blue" colspan=2>备注：
				<%
					for(int i =9;i<i_length-2;i++ )
					{
						%><%=result[i][0]%> <%
					}
				%>
				</td>
			</tr>
			<%
		}
		if(s_function_code.equals("4977") ||s_function_code.equals("e083")||s_function_code.equals("b540")||s_function_code.equals("b541"))
		{
			%>
			<tr>
				<td class="blue" width="15%">缴费号码:
				<%=result[12][0]%>
				</td>
				<td class="blue" width="15%">缴费号码:
				<%=s_function_name%>
				</td>
			</tr>
			<tr>
				<td class="blue" width="15%">缴费金额(大写)：
				<%=result[14][0]%>
				</td>
				<td class="blue" width="15%">缴费金额(小写)：￥
				<%=result[15][0]%>
				</td>
			</tr>
			<tr>
				<td class="blue" width="15%">帐号：
				<%=result[3][0]%>
				</td>
				<td class="blue" width="15%">
				<%=result[16][0]%>
				</td>
			</tr>
			<tr>
				<td class="blue" colspan=2>用户姓名：
				<%=result[11][0]%>
				</td>
				 
			</tr>
			<tr>
				<td class="blue" colspan=2>备注：
				<%
					for(int i =17;i<i_length-2;i++ )
					{
						%><%=result[i][0]%> <%
					}
				%>
				</td>
			</tr>
			 
			<%
		}
	%>
			
		    
		 
		
		<tr>
			<td class="blue" width="15%">发票号码:<%=result[i_length-1][0]%></td>
		    <td class="blue" width="15%">发票代码:<%=result[i_length-2][0]%></td>
		</tr>		  
					 
			
		</table>
      <%
	}
	
	//下面都是空的   
	else{	%>
      <table cellspacing="0">
       <tr>
          <td class="blue" align="center">无发票信息</td>
       </tr>
	   
      </table>
      <%}%>
	  <table cellspacing="0">
		<tr>
			<td id="footer" align="center" colspan="2">           
			
				<input class="b_foot" name=reset type=reset value=返回 onclick="window.location.href='e902.jsp?opCode=e901&opName=铁通发票信息查询&crmActiveOpCode=e901'">
			</td>
		</tr>
	  </table> 
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
