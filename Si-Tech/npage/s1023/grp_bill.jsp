<%
  /*
   * ����: ����������Ϣ����ͼ
�� * �汾: v1.0
�� * ����: 2011��05��10��
�� * ����: zhoujf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%

	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="����������Ϣ";
  String sqlStr="select c.contract_no ,c.bank_cust,c.con_cust_id,a.limit_owe,a.id_no from dbcustadm.dcustmsg a,dbvipadm.dgrpcustmsg  b, dconmsg c where a.cust_id = b.cust_id and b.cust_id=c.con_cust_id  and  a.cust_id=c.con_cust_id and a.contract_no=c.contract_no and b.unit_id='"+unit_id+"'";
  String sqlStr1="select limit_owe from dcustmsg where cust_id=(select cust_id from dgrpcustmsg where unit_id="+unit_id+")";
 // String sql ="select  from dbcustadm.dcustmsg a,dbvipadm.dgrpcustmsg  b, dconmsg c where a.cust_id = b.cust_id and b.cust_id=c.con_cust_id  and  a.cust_id=c.con_cust_id and a.contract_no=c.contract_no and b.unit_id='"+unit_id+"'";
 String  sqls = "SELECT cust_id FROM dGrpCustMsg WHERE unit_id='"+unit_id+"'";
 String  fufeisql ="select e.CONTRACT_PAY,e.CONTRACT_NO,e.BEGIN_DATE || e.BEGIN_TIME,e.END_DATE || e.END_TIME,e.ALL_FLAG,e.CYCLE_MONEY FROM DCONCONMSG e,  DCONMSG c, DCUSTCONMSG a, DGRPCUSTMSG b where  b.cust_id=a.cust_id and a.contract_no=e.contract_pay  and a.contract_no=c.contract_no and c.account_type in ('1','A')  AND  e.BEGIN_DATE || e.BEGIN_TIME<=to_char(sysdate,'yyyymmddhh24miss') AND   e.END_DATE || e.END_TIME >=to_char(sysdate,'yyyymmddhh24miss') and   b.unit_id='"+unit_id+"'";
 String  zmxsql =" select  f.phone_no, to_char(e.limit_pay) ,e.rate_flag  ,h.fee_code,h.detail_code,e.id_no,e.contract_no,e.bill_order  from DGRPCUSTMSG b, DCUSTCONMSG a,DCONMSG c,dconusermsg   e, dcustmsg  f, dconuserrate   h  where    b.cust_id = a.cust_id and  a.contract_no = c.contract_no  and c.account_type in ('1', 'A') AND a.contract_no = e.contract_no   AND h.contract_no = e.contract_no  AND  e.BEGIN_YMD || e.BEGIN_TM<=to_char(sysdate,'yyyymmdd') AND   e.END_YMD || e.END_TM >=to_char(sysdate,'yyyymmdd')  and e.id_no = h.id_No  AND e.bill_order <> 99999999   and e.id_no = f.id_no AND b.unit_id='"+unit_id+"'"; 


%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
		
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqls%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="results" scope="end" />	
		

     
 
  	
  		<% System.out.println("results[0][0]*************111111111111111111111112222222222222********************"+results[0][0]); %>	

  	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
			<wtc:sql><%=fufeisql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="resultf" scope="end" />	
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
			<wtc:sql><%=zmxsql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="resultz" scope="end" />

	

		

		
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

<div class="title"><div id="title_zi">�����˻���Ϣ</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>�˻���ʶ</th>
				<th>�ʻ�����</th>
				<th>�ͻ���ʶ</th>
				<th>���ö�ȣ�͸֧��ȣ�</th>
			  <th>����ʱ��</th>
				<th>����ʱ��</th>
				
			</tr>
		<% for(int i = 0; i < result.length; i++){%>			
			<tr>				
				<td nowrap align='center'><%=result[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[0][0].trim()%></td>
					<%System.out.println("result[i][4]=============="+result[i][4]);%>
		<wtc:service name="q_GrpCustMsg"   retcode="retCodett" retmsg="retMsgtt" outnum="10" >
   		<wtc:param value="<%=result[i][4]%>"/>
  		</wtc:service>
  	<wtc:array id="resulta" scope="end"/>	 
  	<%System.out.println("resulta[0][0]=============="+resulta[0][0]);%> 
  	<%System.out.println("resulta[0][1]=============="+resulta[0][1]);%> 
				<td nowrap align='center'><%=resulta[0][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resulta[0][1].trim()%>&nbsp;</td>
			</tr>
		<%}%>	
</table>


<br>
<div class="title"><div id="title_zi">���������ϵ��Ϣ</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>�˻���ʶ</th>
				<th>�˱���ʶ</th>
				<th>�˱���Ŀ</th>
				<th>���ȼ�</th>
			  <th>�û���ʶ</th>
			  <th>������������</th>
			  <th>�˵���Ŀ</th>
			  <th>�޶���ʽ</th>
			  <th>�޶���</th>
			  <th>��Ч��</th>
			</tr>
		<wtc:service name="q_GrpConRShip1"   retcode="retCodett" retmsg="retMsgtt" outnum="10" >
   		<wtc:param value="<%=results[0][0]%>"/>
  		</wtc:service>
  	<wtc:array id="resultb" scope="end"/>	 				
		<%	
		System.out.println("results[0][0]*********************************"+results[0][0]);
			System.out.println("resultb.length*********************************"+resultb.length);
		for(int i = 0; i < resultb.length; i++)
		{
			  
		%>		

		
			<tr>				
				<td nowrap align='center'><%=resultb[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][7].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][8].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=resultb[i][9].trim()%>&nbsp;</td>
			</tr>
			

			
		<%
				System.out.println("resultb.length*********************************"+resultb.length);
		}

		
		%>	
		
</table>
<br>
<div class="title"><div id="title_zi">���Ѽƻ���һ��֧���˻���</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>֧���ʻ�</th>
				<th>��֧���ʻ�</th>
				<th>��ʼʱ��</th>
				<th>����ʱ��</th>
				<th>ͳ����ϵ</th>
				<th>ͳ�����</th>
			</tr>
		<%	
						//System.out.println("r*************resultf**********resultf*****1111111111111111111*****"+resultf.length);
         
			for(int i = 0; i < resultf.length; i++)
			{		  

			%>			
				<tr>				
					<td nowrap align='center'><%=resultf[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resultf[i][1].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resultf[i][2].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resultf[i][3].trim()%>&nbsp;</td>
						
					<% if("1".equals(resultf[i][4])) { %>
						<td nowrap align='center'>ȫ��ͳ��&nbsp;</td>
						  <% 
						} else if("0".equals(resultf[i][4])) {
							%>
							<td nowrap align='center'>����ͳ��&nbsp;</td>
							<% } %>
					<td nowrap align='center'><%=resultf[i][5].trim()%>&nbsp;</td>
					
					
				</tr>
			<%
				//System.out.println("resultf.length*************2222222222**********2******222222222222222****");
			}
							

			%>				
</table>

<br>
<div class="title"><div id="title_zi">���Ѽƻ�����Ŀ��ѣ�</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>��֧���û�</th>
				<th>�޶����</th>
				<th>��Ŀ��</th>
				<th>һ����Ŀ��</th>
				<th>������Ŀ��</th>
			</tr>
		<%	
				System.out.println("resultz.length********rrrrrrrrrrrrr*****2222222222**********2***555555555555555***222222222222222****"+resultz.length);  
				System.out.println("unit_id********unit_id*****unit_id**********2***unit_id***unit_id****"+unit_id);  
			for(int i = 0; i < resultz.length; i++)
			{		  
			%>			
				<tr>				
						<td nowrap align='center'><%=resultz[i][0].trim()%>&nbsp;</td>
					<% if("0".equals(resultz[i][1])||"0.00".equals(resultz[i][1])) { %>
						<td nowrap align='center'>ȫ��ͳ��&nbsp;</td>
					<%} else {%>
					<% //System.out.println("resultz.length********rrrrrrr���*****2222222222**********2***555555555555555***222222222222222****"+resultz.length);  %>
						<td nowrap align='center'><%=resultz[i][1].trim()%>&nbsp;</td>
					<% } %>
					<% if("Y".equals(resultz[i][2])) { %> 
						<td nowrap align='center'>Ϊ������Ŀ���&nbsp;</td>
					<% }else if("N".equals(resultz[i][2])) {%>
							<td nowrap align='center'>Ϊ��Ŀ���&nbsp;</td>
							<% //System.out.println("resultz.length********rrrrrrr�Ǹ�*****2222222222**********2***555555555555555***222222222222222****"+resultz.length);  %>
					<% } %>
					<% String chacode ="SELECT fee_code,detail_code from dconuserrate  WHERE id_no='"+resultz[i][5]+"' and contract_no='"+resultz[i][6]+"' and bill_order='"+resultz[i][7]+"'" ;%>	
								<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
										<wtc:sql><%=chacode%></wtc:sql>
											</wtc:pubselect>
										<wtc:array id="resultg" scope="end" />
					   <%  if(0==resultg.length) { %>
             <td nowrap align='center'>Ϊ������Ŀ���&nbsp;</td>
           <% } else { %>
								<wtc:service name="q_detailName"   retcode="retCodett" retmsg="retMsgtt" outnum="10" >
								<wtc:param value="<%=resultg[0][0]%>"/>
									<wtc:param value="<%=resultg[0][1]%>"/>
									</wtc:service>
								<wtc:array id="resultk" scope="end"/>	
									<td nowrap align='center'><%=resultk[0][0].trim()%>&nbsp;</td> 
								<% System.out.println("resultg[0][0]********resultg[0][0]*****resultg[0][0]**********2***resultg[0][0]***resultg[0][0]****"+resultg[0][0]);  %>
        				<% System.out.println("resultk[0][0]********resultk[0][0]*****resultk[0][0]**********2***resultk[0][0]***resultk[0][0]****"+resultk[0][0]);  %>
        					<% System.out.println("resultg[0][1]********resultg[0][1]*****resultg[0][1]**********2***resultg[0][1]***resultg[0][1]****"+resultg[0][1]);  %>

									<%}%>	
	        <%  if(0==resultg.length) { %>
             <td nowrap align='center'>Ϊ������Ŀ���&nbsp;</td>
           <% } else { %>
								<wtc:service name="q_detailName"   retcode="retCodett" retmsg="retMsgtt" outnum="10" >
								  		<wtc:param value="<%=resultg[0][0]%>"/>
								  			<wtc:param value="<%=resultg[0][1]%>"/>
								  			 </wtc:service>
								<wtc:array id="resulth" scope="end"/>					
							<td nowrap align='center'><%=resulth[0][1].trim()%>&nbsp;</td>
							<% System.out.println("resultg[0][1]********resultg[0][1]*****resultg[0][1]**********2***resultg[0][1]***resultg[0][1]****"+resultg[0][1]);  %>
        				<% System.out.println("resulth[0][1]********resulth[0][1]*****resulth[0][1]**********2***resultk[0][1]***resultk[0][0]****"+resulth[0][1]);  %>

		
                 <%}%>
           </tr>
		     	<%	}  %>				
</table>
</BODY>
</HTML>




