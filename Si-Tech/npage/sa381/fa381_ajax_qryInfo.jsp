<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
	String operType = request.getParameter("operType"); //查询条件
	String operNo = request.getParameter("operNo"); //查询号码
	String tm_b = request.getParameter("tm_b"); //
	String tm_e = request.getParameter("tm_e"); //
	
	String recordPerPage = request.getParameter("recordPerPage"); //
	String pageNumber = request.getParameter("pageNumber"); //
	
	String qry_op_code ="";
	String phoneNo = "";
	String cus_pass = "";
	String orderNo = "";
	if("1".equals(operType)){ //手机号码查询
	  phoneNo = operNo;
	  orderNo = "";
	  tm_b = "";
	  tm_e = "";
	}
	else if("0".equals(operType))
	{
	  phoneNo = "";
	  orderNo = operNo;
	  tm_b = "";
	  tm_e = "";
	}
	else
	{
	  phoneNo = "";
	  orderNo = "";
	  tm_b = tm_b + " 00:00:00";
	  tm_e  = tm_e + " 23:59:59";
	  qry_op_code  = request.getParameter("qry_op_code");
	}
	String svcName = "sA381Qry"; // sJQKTest sA381Qry
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 	routerValue="<%=regionCode%>"  id="loginAccept" />
	
  <wtc:service name="<%=svcName%>" outnum="20"
  	routerKey="region" routerValue="<%=regionCode%>" 
  	retcode="retCode1" retmsg="retMsg1">
    <wtc:param value="<%=loginAccept%>"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    	
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="<%=cus_pass%>"/>
    <wtc:param value="<%=operType%>"/>
    <wtc:param value="<%=orderNo%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    	
	<wtc:param value="<%=tm_b%>"/>
	<wtc:param value="<%=tm_e%>"/>
	<wtc:param value="<%=recordPerPage%>"/>	
	<wtc:param value="<%=pageNumber%>"/>	
	<wtc:param value="<%=qry_op_code%>"/>	
  </wtc:service>
	<wtc:array id="rst0" start = "0" length = "1" scope="end" />
	<wtc:array id="dcust2" start = "1" length = "9" scope="end" />
<%if(retCode1.equals("000000")) {
%>
<body>
<div id="Main">
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">查询信息</div>
		</div>
		<input type = 'hidden' id = 'totalNum' name = 'totalNum' value = '<%=rst0[0][0]%>'>
		<table >
			<tr >
				<th>订单编号</th>
				<th>手机号</th>								
				<th>商品名称</th>
				<th>物流公司名称</th>
				<th>订单状态</th>
				
				<th>预占工号</th>
				<th>物流单号</th>
				<th>操作</th>
			</tr>
			<%
			if(dcust2.length>0) 
			{
				System.out.println("dcust2.length~~~~"+dcust2.length);
				for(int i=0;i<dcust2.length; i++) {
					for ( int j = 0 ; j < dcust2[i].length ; j ++ )
					{
						System.out.println("dcust2["+i+"]["+j+"]=="+dcust2[i][j]);
					}
					
					String s_pp = dcust2[i][4].equals("07")?"disabled"
						:(dcust2[i][4].equals("02"))?"disabled":"";
					
					String s_class = " class='InputGrey' readOnly ";
					String s_ord ="disabled";
					if (  dcust2[i][4].equals("07") )
					{
						if (  dcust2[i][5].equals( workNo ) )
						{
							s_ord = " ";
							s_class = dcust2[i][6].equals("1")?" class='InputGrey' readOnly "
								:" ";
						}
					}
					else if (   dcust2[i][4].equals("02")  )
					{
						s_ord ="disabled";
					}
					
					String s_print = "disabled";
					
					if (   dcust2[i][4].equals("02")   )
					{
						if ( dcust2[i][5].equals( workNo ) )
						{
							s_print = " ";
						}
					}
				%>
				<tr> 
					<td width="5%"><%=dcust2[i][0]%></td>
					<td width="5%"><%=dcust2[i][1]%></td>
					<td width="7%"><%=dcust2[i][2]%></td>
					<td width="5%"><%=dcust2[i][3]%></td>
					<td width="6%">
						<%=( dcust2[i][4].equals( "01" )?"01-->已出库或已写卡未邮寄"
							:( dcust2[i][4].equals( "02" )?"02-->已下物流单"
							:( dcust2[i][4].equals( "03" )?"03-->配送成功" 
							:( dcust2[i][4].equals( "04" )?"04-->配送失败"
							:( dcust2[i][4].equals( "05" )?"05-->用户拒收"
							:( dcust2[i][4].equals( "06" )?"06-->外呼预占" 
							:( dcust2[i][4].equals( "07" )?"07-->物流单下单预占":"其它" )))))))%>
					</td>
					<td width="5%"><%=dcust2[i][5]%></td>
					<td width="5%">
						<input id = 'lgst_id_<%=i%>' name = 'lgst_id' type = 'text' maxlength = '20' 
							value = '<%=dcust2[i][8]%>' <%=s_class%>>
					</td>
					<td width="5%" align="center" >
					<input type="hidden" name="contactOrderNos<%=i%>" id="contactOrderNos<%=i%>" value=""/>
					<input type="button" id="preparedDoBtn<%=i%>" name="preparedDoBtn<%=i%>" 
						class="b_foot" value="预占" 
						v_orderId="<%=dcust2[i][0]%>" 
						v_phone="<%=dcust2[i][1]%>" <%=s_pp%>
						onclick="preparedDo(this,'<%=i%>')" />
					<input type="button" id="makeOrderBtn<%=i%>"  
						name="makeOrderBtn<%=i%>" 
						class="b_foot" value="下单"  
						v_orderId="<%=dcust2[i][0]%>" 
						v_orderItemId="" 
						v_express="<%=dcust2[i][1]%>" 
						v_phone="<%=dcust2[i][1]%>" <%=s_ord%> 
						v_comp_id = "<%=dcust2[i][6]%>"
						onclick="makeOrder(this,'<%=i%>')"
						 />
					<input type="button" id="printBtn"  name="printBtn" class="b_foot"
						 value="打印" 
						v_lnk_pho = "<%=dcust2[i][7]%>" 
						v_orderId="<%=dcust2[i][0]%>" v_orderItemId="<%=dcust2[i][1]%>" 
						v_express="<%=dcust2[i][1]%>" v_phone="<%=dcust2[i][1]%>" 
						 onclick="printInfo(this)"  <%=s_print%> />
					</td>
				</tr>
				<%
				}
			}
			else
			{
			%>
			<tr height='25' align='center'><td colspan='8'>查询信息为空！</td></tr>
			<%
			}
			%>
		</table>
	</div>
</div>
</body>
<%}else{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=retCode1%><br>错误信息：<%=retMsg1%>",0);	
		window.location.href = "fa381_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%}%>
</html>

