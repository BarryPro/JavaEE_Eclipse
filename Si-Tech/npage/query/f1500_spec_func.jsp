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
					  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
					  &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
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
			System.out.println("��ѯ���Ϊ��~~~~~~~~~~~~~~~~~~~~~~");
			%>
				<script language="JavaScript">
				rdShowMessageDialog("��ѯ���û�û��Ӫ���������¼!");
				history.go(-1);
				</script>
			<%
		}	
%>
  
	


