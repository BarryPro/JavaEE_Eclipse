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
<%
	String opCode ="g210"; //"d223";
	String opName = "";//"退费统计";
 	String[][] result = new String[][]{}; 
	String phone_no = request.getParameter("phone_no");	
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
    String inParas2[] = new String[1];
    inParas2[0]="select to_char(sysdate,'YYYYMM') from dual";
	String date=request.getParameter("date");	
	//查询结果
	String unit_id = request.getParameter("unit_id");
	String user_no = request.getParameter("phoneNo");  
	String date_month=date.substring(0,6);
	System.out.println("AAAAAAAAAAAAaaaaaaaaa date_month is "+date_month);
	String total_ll="";
	String fav_ll="";
	String used_ll="";
	String jtmc = request.getParameter("jtmc");
	String cpmc = request.getParameter("cpmc");

 %>
	<wtc:service name="TlsPubSelBoss"  outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/> 
		</wtc:service>
	<wtc:array id="ret_0" scope="end" />
<%
	String dates0="";
	dates0=ret_0[0][0];
%>
	<wtc:service name="s210FavMsg" retcode="sid_code" retmsg="s_id_ret" outnum="7">
    <wtc:param value="<%=work_no%>"/> 
	<wtc:param value="<%=nopass%>"/> 
	<wtc:param value="<%=opCode%>"/> 
	<wtc:param value="<%=phone_no%>"/> 
    <wtc:param value="<%=date%>"/>
 
</wtc:service>
<wtc:array id="ret_id" scope="end" />
<%
	if(ret_id==null||ret_id.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("集团共享流量查询失败,错误代码："+"<%=sid_code%>");
			    window.location='g210_1.jsp';
		    </script>
		<%
	}
	else
	{
		//total_ll=ret_0[0][6];
		//fav_ll=ret_0[0][6];
%>
	 
 <HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">集团共享流量查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <%
			 if(date_month.equals(dates0))
		     {
				System.out.println("~~~~~~~~~~~~~~~~~~~~当月的");
				%>
				<tr>
					<td>
						截止查询时，您所属的集团名称:<%=jtmc%>,产品名称：<%=cpmc%>,集团产品号码：<%=user_no%>的移动数据流量情况：
					</td>
				</tr>
				<tr>
					<td>
						集团产品总流量<%=ret_id[0][5]%> K;
					</td>
				</tr>
				<tr>
					<td>
						已使用<%=ret_id[0][6]%> K。
					</td>
				</tr>
				 
				<%
             }
			 else
			 {
				System.out.println("~~~~~~~~~~~~~~~~~~~~往月的");
				%>
				<tr>
					<td>
						<%=date_month.substring(0,4)%>年<%=date_month.substring(4,6)%>月份，您所属的集团名称:<%=jtmc%>,产品名称：<%=cpmc%>,集团产品号码：<%=user_no%>的移动数据流量情况：
					</td>
				</tr>
				<tr>
					<td>
						集团产品已使用总流量<%=ret_id[0][5]%> K 
					</td>
				</tr>
				 
				 
				<%
             }
		 %>
	 
	<tr>
	<%
		   
	%>
		<td align="center" id="footer" colspan="8">
		 	 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g210_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
 
		}
%>	 
 
 	
 

