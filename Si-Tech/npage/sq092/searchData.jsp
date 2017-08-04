<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String serv_order_id = request.getParameter("ordernum");   //查询条件
	String login_no = request.getParameter("login_no"); //条件值
	String optime = request.getParameter("optime");      //条件值
	String func_code = request.getParameter("func_code");        //条件值
	String service_no = request.getParameter("service_no");      //条件值
	
	System.out.println("serv_order_id==============="+serv_order_id);
	System.out.println("login_no========================="+login_no);
	System.out.println("optime==========================="+optime);
	
	String sqlstr="select a.serv_order_id, b.login_no, to_char(b.create_time,'yyyymmdd hh24:mi:ss'), d.function_code, d.function_name, "
							 +" b.id_no, b.service_no, a.err_msg "
							 +" from wservordersuccbacke a, dservordermsg b, dorderarraymsg c, sFuncCode d"
							 +" where  a.serv_order_id = b.serv_order_id"
							 +" and    b.ORDER_ARRAY_ID = c.ORDER_ARRAY_ID"
							 +" and    c.function_code = d.function_code"
							 +" and    a.serv_order_id like '%"+serv_order_id+"%' "
							 +" and    b.login_no like '%"+login_no+"%' "
							 +" and    to_char(b.create_time,'yyyymmdd') like '%"+optime+"%' "
							 +" and    b.service_no like '%%' "
							 +" and    d.function_code like '%%' "
							 +" and rownum<51 ";
							 
  String regionCode = (String)session.getAttribute("regCode");	
  
  System.out.println("sqlstr==="+sqlstr);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
			<wtc:sql><%=sqlstr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="myresult" scope="end" />
<%
	System.out.println("retCode========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
if(retCode.equals("000000")){	
//客户信息
%>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">订单信息表</div>
</div>
<table id="dataTable" cellspacing=0>
	<tr>
		<th>订单编号</th>
		<th>受理工号</th>
		<th>操作时间</th>
		<th>OPCODE</th>
		<th>业务名称</th>
		<th>用户ID</th>
		<th>服务号码</th>
		<th>错误原因</th>
		<th>动作</th>		
		<!--th>操作</th-->
	</tr>
<%	      
System.out.println("----------------------myresult.length------------------"+myresult.length);     
	for(int i=0;i<myresult.length;i++){//客户订单个数
  %>
				<tr style="cursor:pointer">
					<%for(int j=0;j<myresult[0].length;j++){%>				 
					<td ><%=myresult[i][j]%></td>
					<%}%>
					  <td>              
						 <input class="b_foot" onclick="doSee('<%=myresult[i][0]%>')"  type=button value="查看"/>&nbsp;&nbsp;
             <input class="b_foot" onclick="doRedo()"  type=button value="重新执行"/>
           </td>
				</tr>
    <%
   }
%>
</table>
</div>
<%
}else{
%>
<script>
	rdShowMessageDialog("[<%=retCode%>]:<%=retMsg%>",0);
</script>
<%}%>
