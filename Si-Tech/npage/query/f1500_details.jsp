<%
/********************
 version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1500";
	String opName = "�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String cust_name=request.getParameter("custName");
	//add by diling for ��ȫ�ӹ��޸ķ����б�
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
					<div id="title_zi">ͳһԤ������ר����ϸ</div>
				</div>
	 
			 <TABLE  cellSpacing="0">
					  <TBODY>
						<TR align="center">
						  <td>��������</td><td><%=oTypeName%></td>
						</TR>
						<TR align="center">
						  <td>��������</td><td><%=oProjectType%></td></TR>
						  <TR align="center">
						  <td>��������</td><td><%=oCodeName%></td></TR>
						  <TR align="center">
						  <td>��������</td><td><%=oProjectCode%></td></TR>
						  <TR align="center">
						  <td>����Ԥ��</td><td><%=oBaseFee%></td></TR>
						  <TR align="center">
						  <td>�Ԥ��</td><td><%=oFreeFee%></td></TR>
						  <TR align="center">
						  <td>�ۼ�����</td><td><%=oConsumMark%></td></TR>
						  <TR align="center">
						  <td>��������</td><td><%=oBaseTerm%></td></TR>
						  <TR align="center">
						  <td>�µ���</td><td><%=oMonBaseCons%></td></TR>
						  <TR align="center">
						  <td>��Ԥ��</td><td><%=oPrepayFee%></td></TR>
						  <TR align="center">
						  <td>��Ʒ����</td><td><%=oAwrdName%></td></TR>
						  <TR align="center">
						  <td>��Ʒ����</td><td><%=oAwardNum%></td></TR>
						   
							  
					 

				</TBODY>
				</TABLE>
			<%}
			  if(result1_acct!=null&&result1_acct.length>0)
			  {
					%>
		   	
					<div class="title"  >
						<div id="title_zi">Ӫ����ר��������Ϣ</div>
					</div>
		 
				 <TABLE  cellSpacing="0">
						  <TBODY>
							<TR align="center">
							  <th>�����</th>
							  <th>�����</th>
							  <th>��λ����</th>
							  <th>��λ����</th>
							  <th>��ʼʱ��</th>
							  <th>����ʱ��</th>
							  <th>Ӫ��������</th>
							  <th>Ӫ������������</th>
							  <th>Ӫ����������</th>
							  <th>Ӫ����״̬</th>
							  <th>��������</th>
							  <th>����ʱ��</th>

							  <th>����Ԥ�����</th>
							  <th>����Ԥ����</th>
							  <th>�Ԥ�����</th>
							  <th>�Ԥ����</th>
							  <th>ϵͳ��ֵ�Ԥ�����</th>
							  <th>ϵͳ��ֵ�Ԥ����</th>
							  <th>ϵͳ��ֵ����Ԥ�����</th>
							  <th>ϵͳ��ֵ����Ԥ����</th>
						 
							  
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
						  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
						  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
						  &nbsp; 
						</td>
			</tr>	
		<%@ include file="/npage/include/footer.jsp" %>
	 
	</BODY>
			<%
		}
		else
		{
			System.out.println("��ѯ���Ϊ��~~~~~~~~~~~~~~~~~~~~~~");
			%>
				<script language="JavaScript">
				rdShowMessageDialog("��ѯ���û�û�а���2289Ӫ����!");
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
					<div id="title_zi">����Ԥ�����ϸ</div>
				</div>
	 
		 <TABLE  cellSpacing="0">
				  <TBODY>
					<TR align="center">
					  <td>��������</td><td><%=oTypeName%></td>
					</TR>
					<TR align="center">
					  <td>��������</td><td><%=oProjectType%></td></TR>
					  <TR align="center">
					  <td>��������</td><td><%=oCodeName%></td></TR>
					  <TR align="center">
					  <td>��������</td><td><%=oProjectCode%></td></TR>
					 
					  <TR align="center">
					  <td>�ֽ�</td><td><%=oPayFee%></td></TR>
					  <TR align="center">
					  <td>����Ԥ��</td><td><%=oBaseFee%></td></TR>
					  <TR align="center">
					  <td>�Ԥ��</td><td><%=oFreeFee%></td></TR>
					  <TR align="center">
					  <td>�ۼ�����</td><td><%=oConsumMark%></td></TR>
					  <TR align="center">
					  <td>������������</td><td><%=oBaseTerm%></td></TR>
					  <TR align="center">
					  <td>���������</td><td><%=oFreeTerm%></td></TR>
					  <TR align="center">
					  <td>����Ԥ���</td><td><%=oReturnFee%></td></TR>
					  <TR align="center">
					  <td>����Ԥ�������</td><td><%=oReturTerm%></td></TR>
					  <TR align="center">
					  <td>��Ԥ��</td><td><%=oPrepayFee%></td></TR>
					  <TR align="center">
					  <td>ÿ���������</td><td><%=oMonthConsume%></td></TR>
				
					
			</TBODY>
			</TABLE>
			<%}
			if(result1_acct!=null&&result1_acct.length>0)
			{
					%>
		   	
					<div class="title"  >
						<div id="title_zi">Ӫ����ר��������Ϣ</div>
					</div>
		 
				 <TABLE  cellSpacing="0">
						  <TBODY>
							<TR align="center">
							  <th>�����</th>
							  <th>�����</th>
							  <th>��λ����</th>
							  <th>��λ����</th>
							  <th>��ʼʱ��</th>
							  <th>����ʱ��</th>
							  <th>Ӫ��������</th>
							  <th>Ӫ������������</th>
							  <th>Ӫ����������</th>
							  <th>Ӫ����״̬</th>
							  <th>��������</th>
							  <th>����ʱ��</th>	

							  <th>����Ԥ�����</th>
							  <th>����Ԥ����</th>
							  <th>�Ԥ�����</th>
							  <th>�Ԥ����</th>
							  <th>ϵͳ��ֵ�Ԥ�����</th>
							  <th>ϵͳ��ֵ�Ԥ����</th>
							  <th>ϵͳ��ֵ����Ԥ�����</th>
							  <th>ϵͳ��ֵ����Ԥ����</th>
						 
						 
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
		  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
		  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
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
				rdShowMessageDialog("��ѯ���û�û�а���8379Ӫ����!");
				history.go(-1);
				</script>
			<%
		}

	}
%>
	


