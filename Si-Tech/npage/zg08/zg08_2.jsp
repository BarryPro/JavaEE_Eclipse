<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg08";
    String opName = "总对总退费";
	String phone_no = request.getParameter("phone_no");
	String times = request.getParameter("times");
	String end_time = request.getParameter("end_time");
	 
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>一点支付定额统付手工划拨</TITLE>
	
</HEAD>
<body>


<form method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="s1310" retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=times%>"/>
		<wtc:param value="<%=end_time%>"/>
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2" />	
<wtc:array id="ret_val1" scope="end"  start="2"  length="3" />	 
<wtc:array id="ret_val_sys" scope="end"  start="5"  length="1" />
<%
	String return_code="";
	String return_msg="";
	int i_count=0;	
	String s_sys = "";
	return_code=retCode1;
	return_msg=retMsg1;
 	if(!return_code.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("退费查询报错!错误代码"+"<%=return_code%>，错误原因："+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg08_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<%
	}
	else
	{
		i_count = ret_val1.length;
		s_sys = ret_val_sys[0][0];
		%>
		
			
		 
			 <%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>

			  <table cellspacing="0" id = "PrintA">
						<tr> 
						  <th>选择</th>
						  <th>预交费流水</th>
						  <th>交易日期</th>
						  <th>交易金额(分)</th>
						  
						</tr>
						<input type="hidden" name="s_sys" value="<%=s_sys%>">
						<%
							String tbclass="";
							for(int i =0;i<ret_val1.length;i++)
							{
								tbclass=(i%2==0)?"Grey":"";
								if ((i% 2) == 1)
								{
									%>
										<tr>
											<td align="right"><input type="radio" name="radiobutton" value="<%=ret_val1[i][0]%>" <%if(i==ret_val1.length-1){%>checked<%}%> ></td>
											<td align="center"><%=ret_val1[i][0]%></td>
											<td align="center"><%=ret_val1[i][1]%></td>
											<td align="center"><%=ret_val1[i][2]%></td>
										</tr>
										<input type="hidden" name="totaldate" value="<%=ret_val1[i][1]%>">
									<%
								}
								else
								{
									%>
										<tr>
											<td align="right"><input type="radio" name="radiobutton" value="<%=ret_val1[i][0]%>" <%if(i==ret_val1.length-1){%>checked<%}%>>
                    </td>
											<td align="center"><%=ret_val1[i][0]%></td>
											<td align="center"><%=ret_val1[i][1]%></td>
											<td align="center"><%=ret_val1[i][2]%></td>
										</tr>
										<input type="hidden" name="totaldate" value="<%=ret_val1[i][1]%>">
									<%
								}			
							%>
								
							<%
							}
						%>
						
							
			 
				 
				  <tr id="footer"> 
					<td colspan="9">
					  <input class="b_foot" name=query onClick="doQry()" type=button value=退费>
					 
					  <input class="b_foot" name=back onClick="window.location.href='zg08_1.jsp?activePhone=<%=phone_no%>'" type=button value=返回>
					</td>
				  </tr>
				  
			  </table>
			  
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="id_contractNo">			
				

		<%@ include file="/npage/include/footer.jsp" %>

		<%
	}
%>
<script language="javascript">
			function doQry()
			{
				var login_accept;
			    var totaldate;
				var lines =<%=i_count%>;
				var s_sys = document.all.s_sys.value;
				//alert(s_sys);
				var s_now = <%=dateStr%>;
				if (lines == 1)
				{
					login_accept = document.all.radiobutton.value;
					totaldate = document.all.totaldate.value;
				}
				else
				{
					for (var i = 0; i < lines; i++)
					{
						if (document.all.radiobutton[i].checked == true)
						{
							login_accept = document.all.radiobutton[i].value;
							totaldate = document.all.totaldate[i].value;  
						}
					}
				}
				//alert("totaldate is "+totaldate+" and s_now is "+s_now);
				 
				 
				 
					document.frm.action="zg08_3.jsp?login_accept="+login_accept+"&totaldate="+totaldate+"&phone_no="+"<%=phone_no%>"+"&s_sys="+s_sys;
					document.frm.submit();
				 
				
				
			}
		</script>
</form>
</body>
</html>

