<%
/********************
 version v2.0
开发商: si-tech
功能:综合信息查询之预存分类信息
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1500";
	String opName = "综合信息查询之预存分类信息";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String cust_name=request.getParameter("custName");
	//add by diling for 安全加固修改服务列表
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	
	String sql_str0="SELECT bill_flag FROM cBillCond WHERE run_flag=1 and to_number(to_char(sysdate,'ddhh24')) between begin_dayhour and end_dayhour";
	String paytype= request.getParameter("paytype");
	System.out.println("qqqqqqqqqqqqqqqqqqqq paytype is "+paytype);
	String phoneNo = request.getParameter("phoneNo");
	String[][] result1  = null ;
	String oCodeName="";
	String oTypeName="";
 
	String oProjectCode="";
	String oPayFee="";
	String oBaseFee="";
	String oFreeFee="";
	String oConsumMark="";
	String oBaseTerm="";
	String oFreeTerm="";
	String oReturnFee ="";
	String oReturTerm="";
	String oPrepayFee="";
	String  oMonthConsume="";
	String oMonBaseCons="";
	String oAwrdName ="";
	String oAwardNum ="";
	String oProjectType="";

	String[][] result1_acct  = null ;

	if(paytype.equals("AQ") ||paytype.equals("R"))
	{
		System.out.println("is paytype is AQ or R ");
		
		%>
		 
 <wtc:service name="sQryProjectInfo" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="17">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="0"/>
	<wtc:param value="AQ|R"/>
 </wtc:service>
 <wtc:array id="sVerifyTypeArr1" scope="end"/>

<!--xl add for zhouwy begin-->
<wtc:service name="sSpecialFundQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="21">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=paytype%>"/>
 </wtc:service>
 <wtc:array id="s_acct_id" scope="end"/>
<!--end of for zhouwy-->


<%
		result1 = sVerifyTypeArr1; 
		result1_acct =s_acct_id;
		if((result1!=null&&result1.length>0) || (result1_acct!=null&&result1_acct.length>0) )
		{
			%>
		<body>
		<%@ include file="/npage/include/header.jsp" %> 
			<%
			if(result1!=null&&result1.length>0)
			{
				oTypeName=result1[0][0];
				oProjectType=result1[0][1];
				oCodeName=result1[0][2];
				oProjectCode=result1[0][3];
				oBaseFee=result1[0][5];
				oFreeFee=result1[0][6];
				oConsumMark=result1[0][7];
				oBaseTerm=result1[0][8];
				oPrepayFee=result1[0][12];
				oMonBaseCons=result1[0][14];
				oAwrdName=result1[0][15];
				if(oAwrdName==null)
				{
					oAwrdName="";
				}
				oAwardNum=result1[0][16];
				if(oAwardNum==null)
				{
					oAwardNum="";
				}
				%>
				    	
				<div class="title">
					<div id="title_zi">统一预存赠礼专款明细</div>
				</div>
	 
			 <TABLE  cellSpacing="0">
					  <TBODY>
						<TR align="center">
						  <td>类型名称</td><td><%=oTypeName%></td>
						</TR>
						<TR align="center">
						  <td>方案类型</td><td><%=oProjectType%></td></TR>
						  <TR align="center">
						  <td>方案名称</td><td><%=oCodeName%></td></TR>
						  <TR align="center">
						  <td>方案代码</td><td><%=oProjectCode%></td></TR>
						  <TR align="center">
						  <td>底线预存</td><td><%=oBaseFee%></td></TR>
						  <TR align="center">
						  <td>活动预存</td><td><%=oFreeFee%></td></TR>
						  <TR align="center">
						  <td>扣减积分</td><td><%=oConsumMark%></td></TR>
						  <TR align="center">
						  <td>消费期限</td><td><%=oBaseTerm%></td></TR>
						  <TR align="center">
						  <td>月底线</td><td><%=oMonBaseCons%></td></TR>
						  <TR align="center">
						  <td>总预存</td><td><%=oPrepayFee%></td></TR>
						  <TR align="center">
						  <td>礼品名称</td><td><%=oAwrdName%></td></TR>
						  <TR align="center">
						  <td>礼品数量</td><td><%=oAwardNum%></td></TR>
						   
							  
					 

				</TBODY>
				</TABLE>
			<%}
			  if(result1_acct!=null&&result1_acct.length>0)
			  {
					%>
		   	
					<div class="title"  >
						<div id="title_zi">营销案专款配置信息</div>
					</div>
		 
				 <TABLE  cellSpacing="0">
						  <TBODY>
							<TR align="center">
							  <th>活动名称</th>
							  <th>活动代码</th>
							  <th>档位名称</th>
							  <th>档位代码</th>
							  <th>开始时间</th>
							  <th>结束时间</th>
							  <th>营销案描述</th>
							  <th>营销案归属部门</th>
							  <th>营销案负责人</th>
							  <th>营销案状态</th>
							  <th>操作工号</th>
							  <th>操作时间</th>

							  <th>底线预存代码</th>
							  <th>底线预存金额</th>
							  <th>活动预存代码</th>
							  <th>活动预存金额</th>
							  <th>系统充值活动预存代码</th>
							  <th>系统充值活动预存金额</th>
							  <th>系统充值底限预存代码</th>
							  <th>系统充值底限预存金额</th>
						 
							  
							</TR>
						<%
							String s_now="";
							String s_begin="";
							for(int i=0;i<result1_acct.length;i++)
							{
								if((!s_now.equals(result1_acct[i][3])) || (!s_begin.equals(result1_acct[i][4]))  )
								{
									s_now=result1_acct[i][3];
									s_begin=result1_acct[i][4];
									 
									%>
									<tr>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][0]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][1]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][2]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][3]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][4]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][14]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][15]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][16]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][17]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][18]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][19]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][20]%></td>
										
										<td><%=result1_acct[i][5]%> </td>
										<td><%=result1_acct[i][6]%></td>
										<td><%=result1_acct[i][7]%></td>
										<td><%=result1_acct[i][8]%></td>
										<td><%=result1_acct[i][9]%></td>
										<td><%=result1_acct[i][10]%></td>
										<td><%=result1_acct[i][11]%></td>
										<td><%=result1_acct[i][12]%></td>
									 
										

									</tr>
									<%}else{%>
									<tr>
										<td ><%=result1_acct[i][5]%> </td>
										<td ><%=result1_acct[i][6]%></td>
										<td ><%=result1_acct[i][7]%></td>
										<td ><%=result1_acct[i][8]%></td>
										<td ><%=result1_acct[i][9]%></td>
										<td ><%=result1_acct[i][10]%></td>
										<td ><%=result1_acct[i][11]%></td>
										<td ><%=result1_acct[i][12]%></td>
									 
									 
									</tr>
								<%}
							}
						%>	
						 	  
						 

					</TBODY>
					</TABLE>
		 
					<%
				} 
			%>
			
			<tr> 
						<td id=footer colspan=2>
						  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
						  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
						  &nbsp; 
						</td>
			</tr>	
		<%@ include file="/npage/include/footer.jsp" %>
	 
	</BODY>
			<%
		}
		else
		{
			System.out.println("查询结果为空~~~~~~~~~~~~~~~~~~~~~~");
			%>
				<script language="JavaScript">
				rdShowMessageDialog("查询的用户没有办理2289营销案!");
				history.go(-1);
				</script>
			<%
		}	
%>
 
		<%
	}
	else if(paytype.equals("CC") ||paytype.equals("CD")||paytype.equals("CZ"))
	{
		System.out.println(" is is CD or CC");
 
		%>
	<wtc:service name="sQryProjectInfo" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="17">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="0"/>
		<wtc:param value="CC|CD|CZ"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr2" scope="end"/> 

<!--xl add for zhouwy begin-->
<wtc:service name="sSpecialFundQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="21">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=paytype%>"/>
 </wtc:service>
 <wtc:array id="s_acct_id" scope="end"/>

<!--end of for zhouwy-->

<%
		result1 = sVerifyTypeArr2; 	
		result1_acct = s_acct_id; 
		if((result1!=null&&result1.length>0) || (result1_acct!=null&&result1_acct.length>0) )
		{
		%>
		<body>
	<%@ include file="/npage/include/header.jsp" %>  
		<%	
			if(result1!=null&&result1.length>0)
			{
				oTypeName=result1[0][0];
				oProjectType=result1[0][1];
				oCodeName=result1[0][2];
				oProjectCode=result1[0][3];
				oPayFee=result1[0][4];
				oBaseFee=result1[0][5];
				oFreeFee=result1[0][6];
				oConsumMark=result1[0][7];
				oBaseTerm=result1[0][8];
				oFreeTerm=result1[0][9];
				oReturnFee=result1[0][10];
				oReturTerm=result1[0][11];
				oPrepayFee=result1[0][12];
				oMonthConsume=result1[0][13];
			
				 
				%>
				
				<div class="title">
					<div id="title_zi">赠送预存款明细</div>
				</div>
	 
		 <TABLE  cellSpacing="0">
				  <TBODY>
					<TR align="center">
					  <td>类型名称</td><td><%=oTypeName%></td>
					</TR>
					<TR align="center">
					  <td>方案类型</td><td><%=oProjectType%></td></TR>
					  <TR align="center">
					  <td>方案名称</td><td><%=oCodeName%></td></TR>
					  <TR align="center">
					  <td>方案代码</td><td><%=oProjectCode%></td></TR>
					 
					  <TR align="center">
					  <td>现金</td><td><%=oPayFee%></td></TR>
					  <TR align="center">
					  <td>底线预存</td><td><%=oBaseFee%></td></TR>
					  <TR align="center">
					  <td>活动预存</td><td><%=oFreeFee%></td></TR>
					  <TR align="center">
					  <td>扣减积分</td><td><%=oConsumMark%></td></TR>
					  <TR align="center">
					  <td>底线消费期限</td><td><%=oBaseTerm%></td></TR>
					  <TR align="center">
					  <td>活动消费期限</td><td><%=oFreeTerm%></td></TR>
					  <TR align="center">
					  <td>赠送预存款</td><td><%=oReturnFee%></td></TR>
					  <TR align="center">
					  <td>赠送预存款月数</td><td><%=oReturTerm%></td></TR>
					  <TR align="center">
					  <td>总预存</td><td><%=oPrepayFee%></td></TR>
					  <TR align="center">
					  <td>每月最低消费</td><td><%=oMonthConsume%></td></TR>
				
					
			</TBODY>
			</TABLE>
			<%}
			if(result1_acct!=null&&result1_acct.length>0)
			{
					%>
		   	
					<div class="title"  >
						<div id="title_zi">营销案专款配置信息</div>
					</div>
		 
				 <TABLE  cellSpacing="0">
						  <TBODY>
							<TR align="center">
							  <th>活动名称</th>
							  <th>活动代码</th>
							  <th>档位名称</th>
							  <th>档位代码</th>
							  <th>开始时间</th>
							  <th>结束时间</th>
							  <th>营销案描述</th>
							  <th>营销案归属部门</th>
							  <th>营销案负责人</th>
							  <th>营销案状态</th>
							  <th>操作工号</th>
							  <th>操作时间</th>	

							  <th>底线预存代码</th>
							  <th>底线预存金额</th>
							  <th>活动预存代码</th>
							  <th>活动预存金额</th>
							  <th>系统充值活动预存代码</th>
							  <th>系统充值活动预存金额</th>
							  <th>系统充值底限预存代码</th>
							  <th>系统充值底限预存金额</th>
						 
						 
							</TR>
						<%
							String s_now="";
							String s_begin="";
							for(int i=0;i<result1_acct.length;i++)
							{
								if((!s_now.equals(result1_acct[i][3])) || (!s_begin.equals(result1_acct[i][4]))  )
								{
									s_now=result1_acct[i][3];
									s_begin=result1_acct[i][4];
									 
									%>
									<tr>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][0]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][1]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][2]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][3]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"><%=result1_acct[i][4]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][14]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][15]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][16]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][17]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][18]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][19]%></td>
										<td rowspan="<%=Integer.parseInt(result1_acct[i][13])%>"> <%=result1_acct[i][20]%></td>

										<td><%=result1_acct[i][5]%> </td>
										<td><%=result1_acct[i][6]%></td>
										<td><%=result1_acct[i][7]%></td>
										<td><%=result1_acct[i][8]%></td>
										<td><%=result1_acct[i][9]%></td>
										<td><%=result1_acct[i][10]%></td>
										<td><%=result1_acct[i][11]%></td>
										<td><%=result1_acct[i][12]%></td>
										 
										
									 
									</tr>
									<%}else{%>
									<tr>
										<td ><%=result1_acct[i][5]%> </td>
										<td ><%=result1_acct[i][6]%></td>
										<td ><%=result1_acct[i][7]%></td>
										<td ><%=result1_acct[i][8]%></td>
										<td ><%=result1_acct[i][9]%></td>
										<td ><%=result1_acct[i][10]%></td>
										<td ><%=result1_acct[i][11]%></td>
										<td ><%=result1_acct[i][12]%></td>
								 
									 
										 
									</tr>
								<%}
							}
						%>	
						 	  
						 

					</TBODY>
					</TABLE>
		 
					<%
				} 
			
			%>

		
	<tr> 
		<td id=footer colspan=2>
		  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
		  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
		  &nbsp; 
		</td>
	</tr>		
            
    <%@ include file="/npage/include/footer.jsp" %>
 
</BODY>
			<%
		}
		else
		{
			%>
				<script language="JavaScript">
				rdShowMessageDialog("查询的用户没有办理8379营销案!");
				history.go(-1);
				</script>
			<%
		}

	}
%>
	


