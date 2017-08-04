<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>

<%
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String opCode = "zg10";
    String opName = "集团自由划拨";
	String group_no_id = request.getParameter("contract_no"); 
	String group_name = request.getParameter("group_name");
	
	String begin_tm = request.getParameter("begin_time");
	String end_tm = request.getParameter("end_time");
	//group_no_id = "15004678919";
	String[] inParas2 = new String[2];
	inParas2[0]="select phone_no,to_char(new_op_time,'YYYYMMDD hh24:mi:ss'),to_char(a.f_should_money),b.bank_cust from wgroupchargecfghis a,dconmsg b where group_contract_no=:s_no and a.group_contract_no = b.contract_no and to_char(new_op_time,'YYYYMMDD')>=:d1 and to_char(new_op_time,'YYYYMMDD')<=:d2 order by new_op_time desc";
	inParas2[1]="s_no="+group_no_id+",d1="+begin_tm+",d2="+end_tm;
 
%>
 
   
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE> 查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>

      <table cellspacing="0" id = "PrintA">
      
				
				
				
				
				<tr> 
                  <th>集团账号</th>
				  <th>集团名称</th>
                  <th>被充值手机号码</th> 
				  <th>充值时间</th>
				  <th>充值金额</th>
				   
				  
                </tr>
 
		<%
			if(ret_val.length>0)
			{
				for(int i=0;i<ret_val.length;i++)
				{
					%>
						<tr>
							<td><%=group_no_id%></td>
							<td><%=ret_val[i][3]%></td>
							<td><%=ret_val[i][0]%></td>
							<td><%=ret_val[i][1]%></td>
							<td><%=ret_val[i][2]%></td>
						</tr>
					<%
				}
				
			}
			else
			{
				%>
					<script language="javascript">
						alert("查询结果为空!");
					</script>
				<%
			}
		%>		
 
 

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'zg10_1.jsp' " type=button value=返回>
    	 
			 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

