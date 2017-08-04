<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zg11";
    String opName = "GPRS流量状态查";
		String phone_no=request.getParameter("phone_no");
		String[] inParas2 = new String[2];
//	inParas2[0]="select to_char(update_time,'YYYYMMDD hh24:mi:ss'),update_login from dgprsshortmsgoffonhis where phone_no =:sphone_no union all select to_char(op_time, 'YYYYMMDD hh24:mi:ss'), login_no  from dgprsshortmsgoffon where phone_no = :sphone_no1 order by to_char(op_time, 'YYYYMMDD hh24:mi:ss') desc ";
		inParas2[0]="select to_char(login_accept), to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(login_no), to_char(update_time,'YYYYMMDD hh24:mi:ss'), to_char(update_login),'a',op_time from dgprsshortmsgoffonhis where phone_no=:sphone_no "
 									+" union all (select  to_char(login_accept), to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(login_no), to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(login_no) ,'b',op_time from dgprsshortmsgoffon where phone_no=: sphone_no )order by op_time ";
		inParas2[1]="sphone_no="+phone_no+",sphone_no="+phone_no;
		String ret_val[][];

 System.out.println("inParas2[0]--------------------"+inParas2[0]);
  System.out.println("phone_no--------------------"+phone_no);
%>
   
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_vals" scope="end" />	 
 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>优惠信息提醒变更记录查询</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">优惠信息提醒变更记录查询</div>
</div>

      <table cellspacing="0" id = "PrintA">
         <tr> 
          <th>操作流水</th>
				  <th>关闭时间</th>
				  <th>关闭工号</th>
				  <th>开通时间</th>
				  <th>开通工号</th>
				  <!--th>操作后状态</th-->
         </tr>
				<%
					ret_val=ret_vals;
					if(ret_val.length>0)
					{
						for(int i=0;i<ret_val.length;i++)
						{
							%>
								<tr>
									<td><%=ret_val[i][0]%></td>
									<td><%=ret_val[i][1]%></td>
									<td><%=ret_val[i][2]%></td>
									<% 
									if("b".equals(ret_val[i][5])){
									%>
									<td> </td>
									<td> </td>
									<%
									}else{
									%>	
									<td><%=ret_val[i][3]%></td>
									<td><%=ret_val[i][4]%></td>
									<%
									}
									%>
								
								<% 
									//if("a".equals(ret_val[i][5])){
									%>
									<!--td>开通</td-->
									<%
								//	}else{
									%>	
									<!--td>关闭</td-->
									<%
								//	}
									%>
								</tr>
							<%
						}
					}
					else
					{
						%>
							<script language="javascript">
								//alert("1");
							</script>
						<%
						
					}
					
				%>

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location='zg11_1.jsp'" type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
		 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

