<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	  String custPass = request.getParameter("custPass");
	  System.out.println("AAAAAAAAAAAAAAAAAAAAAAAaa custPass is "+custPass);
	  
	  String opCode = "g679";
      String opName = "��ͥδ���ʲ�ѯ";
	  String i_flag=request.getParameter("i_flag");
	  String m_phone_no=request.getParameter("m_phone_no");
	  String s_phone_no=request.getParameter("s_phone_no");
	  String ym = request.getParameter("ym");
	  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	  System.out.println("aaaaaaaaaaaa i_flag is "+i_flag+" and s_phone_no is "+s_phone_no+" and m_phone_no is "+m_phone_no); 	
	  custPass = Encrypt.encrypt(custPass);
	  System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbb custPass is "+custPass); 
		//contractno
      String phone_input = request.getParameter("contractno");
	  

	  String[] inParas2 = new String[2];	//��ѯ�ҳ����ʺ�
	  String m_contract_no="";
	  inParas2[0]=" select to_char(contract_no) from dcustmsg where phone_no=:phone_no";
	  inParas2[1]="phone_no="+m_phone_no;
	  %>
	  <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="1">
				<wtc:param value="<%=inParas2[0]%>"/>
				<wtc:param value="<%=inParas2[1]%>"/>
	   </wtc:service>
	   <wtc:array id="result20" scope="end" />
	  <%
      if(result20!=null&&result20.length>0)
	  {
			m_contract_no=result20[0][0];
	  }
	  else
	  {
		  %>
		  <script language="javascript">
			rdShowMessageDialog("�˺Ų�ѯʧ��");
			history.go(-1);
		  </script>
			
		  <%
	  }

	  String s_id="";
	  String[] inParas0 = new String[2];
	  if(i_flag.equals("0") ||i_flag=="0")
	  {
		  
		  //xl add ����ɷ� begin
		  String s_res_flag="";
		  
		  s_res_flag="000000";//result9[0][0];
		  System.out.println("FFFFFFFFFFFFFFFFFFFFFFFFFFF checkflag = "+s_res_flag);
		  if(s_res_flag=="000000" || s_res_flag.equals("000000"))
          {
              System.out.println("AAAAAAAAAAAAAAAAAAAAAAa ��Ա");
			  inParas0[0]=" select to_char(id_no) from dcustmsg where phone_no=:phone_no ";
			  inParas0[1]="phone_no="+s_phone_no;
			  %>
			  <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="1">
						<wtc:param value="<%=inParas0[0]%>"/>
						<wtc:param value="<%=inParas0[1]%>"/>
			   </wtc:service>
			   <wtc:array id="result10" scope="end" />
			  <%
				  if(result10!=null&&result10.length>0)
				  {
					  s_id=result10[0][0];
					  String[] inParas1 = new String[2];
					  inParas1[0]=" select to_char(sum(should_pay-favour_fee)),to_char(contract_pay),to_char(bill_ym),min(phone_no)  from dbbilladm.dcustowefamily where contract_pay=:m_contract_no and bill_ym=:year_month and id_no = :id_no group by contract_pay, bill_ym,id_no ";
					  inParas1[1]="m_contract_no="+m_contract_no+",year_month="+ym+",id_no="+s_id;	
					  %>
					  <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode20" retmsg="retMsg20" outnum="4">
						<wtc:param value="<%=inParas1[0]%>"/>
						<wtc:param value="<%=inParas1[1]%>"/>
					   </wtc:service>
					   <wtc:array id="result20" scope="end" />
					  <%
						  if(result20!=null&&result20.length>0)
						  {
						  //չʾ ��ʼ
						  %>
						  <html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>δ���ʲ�ѯ���</TITLE>
	</HEAD>
	<body>


	<FORM method=post name="frm1508_2">
	<%@ include file="/npage/include/header.jsp" %>


		  
	  
		
			
				
			


						  <div class="title">
		<div id="title_zi">��ѯ���</div>
	</div>
							<table cellspacing="0" id = "PrintA">
							<tr> 
							  <th>��ͥ����</th>
							  <th>��ͥ�ʺ�</th>
							  <th>��������</th>
							  <th>��Ա����</th> 
							  <th>ʵ�ս��</th>
							</tr>
							<%
								for(int i=0;i<result20.length;i++)
								{
								 %>
									<tr>
										<td><%=m_phone_no%></td>
										<td><%=result20[i][1]%></td>
										<td><%=result20[i][2]%></td>
										<td><%=result20[i][3]%></td>
										<td><%=result20[i][0]%></td>
									</tr>
								 <%
								}
							%>	

					 
							  <tr id="footer"> 
								<td colspan="9">
								  <input class="b_foot" name=back onClick="window.location = 'g679_1.jsp?activePhone=<%=phone_input%>' " type=button value=����>
								  <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
						 
								</td>
							  </tr>
							  
						  </table>
						  <%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	</BODY></HTML>
						  <%
						  //չʾ ����
						  }
						  else
						  {
							%>
							<script language="javascript">
								rdShowMessageDialog("��ѯ����δ����ʧ��,�����²�ѯ!");
								history.go(-1);
							  </script>
							<%
						  } 
				  }
				  else
				  {
						%>
						<script language="javascript">
							rdShowMessageDialog("����id_no��ѯʧ��");
							history.go(-1);
						</script>
						<%
				  }	
		  }
		  else
	      {
			  %>
				<script language="javascript">
					//rdShowMessageDialog("�û�����У��ʧ��!");
					history.go(-1);
				</script>
				<%
		  }	
		  //xl end ����У��
		   
		  
	  }
	  if(i_flag.equals("1") ||i_flag=="1")
	  {
		  System.out.println("AAAAAAAAAAAAAAAAAAAAAAa �ҳ�");

		  //xl add ����ɷ� begin
		  String s_res_flag_jz="";
		  
		  s_res_flag_jz="000000";//result91[0][0];
		  System.out.println("FFFFFFFFFFFFFFFFFFFFFFFFFFF s_res_flag_jz = "+s_res_flag_jz);
		  if(s_res_flag_jz=="000000" || s_res_flag_jz.equals("000000"))
		  {
			  String[] inParas4 = new String[2];
			  inParas4[0]=" select to_char(sum(should_pay-favour_fee)),to_char(contract_pay),to_char(bill_ym),min(phone_no)  from dbbilladm.dcustowefamily where contract_pay=:m_contract_no and bill_ym=:year_month group by contract_pay, bill_ym,id_no ";
			  inParas4[1]="m_contract_no="+m_contract_no+",year_month="+ym ;
			  %>
				<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode21" retmsg="retMsg21" outnum="4">
				 <wtc:param value="<%=inParas4[0]%>"/>
				 <wtc:param value="<%=inParas4[1]%>"/>
				</wtc:service>
				<wtc:array id="result21" scope="end" />
			  <%
				  if(result21!=null&&result21.length>0)
				  {
				  //չʾ ��ʼ
				  %>
				  <html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>δ���ʲ�ѯ���</TITLE>
	</HEAD>
	<body>


	<FORM method=post name="frm1508_2">
	<%@ include file="/npage/include/header.jsp" %>
				  
					 <div class="title">
		<div id="title_zi">��ѯ���</div>
	</div>
							<table cellspacing="0" id = "PrintA">
							<tr> 
							  <th>��ͥ����</th>
							  <th>��ͥ�ʺ�</th>
							  <th>��������</th>
							  <th>��Ա����</th> 
							  <th>ʵ�ս��</th>
							</tr>
							<%
								for(int i=0;i<result21.length;i++)
								{
								 %>
									<tr>
										<td><%=m_phone_no%></td>
										<td><%=result21[i][1]%></td>
										<td><%=result21[i][2]%></td>
										<td><%=result21[i][3]%></td>
										<td><%=result21[i][0]%></td>
									</tr>
								 <%
								}
							%>	

					 
							  <tr id="footer"> 
								<td colspan="9">
								  <input class="b_foot" name=back onClick="window.location = 'g679_1.jsp?activePhone=<%=phone_input%>' " type=button value=����>
						 
								  <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
								 
								</td>
							  </tr>
							  
						  </table>
							  <%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	</BODY></HTML>  
						  
				  <%
					  //չʾ ����
				  }
				  else
				  {
					  %>
						<script language="javascript">
							rdShowMessageDialog("��ѯ�ҳ�δ����ʧ��,���ݲ�����");
							history.go(-1);
						</script>
					  <%
				  } 
		  }
		  else
		  {
			  %>
						<script language="javascript">
							 
							history.go(-1);
						</script>
					  <%
		  }	



		  
	  }
%>
   
	 
 


