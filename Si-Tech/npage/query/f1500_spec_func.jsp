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
	/*
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
	String oProjectType="";*/
	String vActName="";
    String vActId="";
	String vMeansName="";
	String vMeansId="";
	String vOperDate="";
    String vBasePayCode="";
	String vBasePayMoney="";
	String vActivityPayCode="";
	String vActivityPayMoney="";
	String vBaseSysPayCode="";
	String vBaseSysPayMoney="";
	String vActivitySysPayCode="";
	String vActivitySysPayMoney="";
 
	System.out.println("is paytype is   "+paytype);
		
		%>
		 
 <wtc:service name="sSpecialFundQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="21">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=paytype%>"/>
 </wtc:service>
 <wtc:array id="sVerifyTypeArr1" scope="end"/>
<%
		result1 = sVerifyTypeArr1; 
		if(result1!=null&&result1.length>0)
		{
			%>
			<body>
	<%@ include file="/npage/include/header.jsp" %>     	
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
					for(int i=0;i<result1.length;i++)
					{
						if((!s_now.equals(result1[i][3])) || (!s_begin.equals(result1[i][4]))  )
						{
							s_now=result1[i][3];
							s_begin=result1[i][4];
							System.out.println("aaaaaaaaaaaaaaaaaaaaaaaa s_now is "+s_now+" and i is "+i+"and result1[i][3] is "+result1[i][3]+" and s_begin is "+s_begin+" and result1[i][4] is "+result1[i][4]);
							//result1[i][13]="2";
							%>
							<tr> 
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][0]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][1]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][2]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][3]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][4]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][14]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][15]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][16]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][17]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][18]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][19]%></td>
								<td rowspan="<%=Integer.parseInt(result1[i][13])%>"><%=result1[i][20]%></td>
								<td><%=result1[i][5]%> </td>
								<td><%=result1[i][6]%></td>
								<td><%=result1[i][7]%></td>
								<td><%=result1[i][8]%></td>
								<td><%=result1[i][9]%></td>
								<td><%=result1[i][10]%></td>
								<td><%=result1[i][11]%></td>
								<td><%=result1[i][12]%></td>
							 

							</tr>
							<%}else{%>
							<tr>
								<td ><%=result1[i][5]%> </td>
								<td ><%=result1[i][6]%></td>
								<td ><%=result1[i][7]%></td>
								<td ><%=result1[i][8]%></td>
								<td ><%=result1[i][9]%></td>
								<td ><%=result1[i][10]%></td>
								<td ><%=result1[i][11]%></td>
								<td ><%=result1[i][12]%></td>
								 
						 
							</tr>
						<%}
					}
				%>	
				<tr> 
					<td id=footer colspan=13>
					  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
					  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
					  &nbsp; 
					</td>
				</tr>		  
				 

			</TBODY>
			</TABLE>
				
		<%@ include file="/npage/include/footer.jsp" %>
	 
	</BODY>
			<%
		}
		else
		{
			System.out.println("查询结果为空~~~~~~~~~~~~~~~~~~~~~~");
			%>
				<script language="JavaScript">
				rdShowMessageDialog("查询的用户没有营销案办理记录!");
				history.go(-1);
				</script>
			<%
		}	
%>
  
	


