<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zg01";
    String opName = "һ��֧������ͳ���ֹ�����";
	String contract_no=request.getParameter("contract_no");
	
	String[] inParas2 = new String[2];
	String[] inParas_show = new String[2];
	//inParas2[0]="select b.account_type,to_char(b.prepay_fee) from dconconmsg a,dconmsg b where b.contract_no=:contract_no and  a.contract_pay = b.contract_no and b.account_type in ('A','1')";
	inParas2[0]="select b.account_type||'-->'||decode(b.account_type,'A','һ��֧��','1','ͳ��'),to_char(sum(c.prepay_fee)) ,to_char(sysdate,'dd'),b.account_type from  dconmsg b,dconmsgpre c where b.contract_no=:contract_no  and b.account_type in ('A','1') and b.contract_no =c.contract_no and c.pay_type='0' group by b.account_type ";
	inParas2[1]="contract_no="+contract_no;
	String s_flag="N";//s_flag=Y ���Բ�ѯ
	String s_show_flag="";// Aһ��֧����չʾ���Ǽ��ſͻ�������ʻ�����     1���Ų�Ʒ--��չʾ���ſͻ����루custid���ͼ�������
	String s_grp_id="";
	String s_grp_name="";
%>



<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	System.out.println("zg01 ccccccccccccccccccccccccccc"+ret_val.length);
	if(ret_val.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("�ʺŲ����ڻ���ͳ���˻���");
				window.location.href="zg01_1.jsp";
			</script>
		<%
	}
	else
	{
		//xl add begin
		if(ret_val[0][3].equals("A"))
		{
			//A�� һ��֧�� չʾ
			s_flag="Y";
			s_show_flag="A"; //չʾ���Ǽ��ſͻ�������ʻ�����
			inParas_show[0]="select to_char(a.con_cust_id),b.unit_name from dconmsg a,dgrpcustmsg b where a.con_cust_id = b.cust_id and a.contract_no=:s_con_id";
			inParas_show[1]="s_con_id="+contract_no;
			%>
				<wtc:service name="TlsPubSelCrm" retcode="retCode4" retmsg="retMsg4" outnum="2">
						<wtc:param value="<%=inParas_show[0]%>"/>
						<wtc:param value="<%=inParas_show[1]%>"/>
				</wtc:service>
				<wtc:array id="ret_val_show" scope="end" />
			<%
				if(ret_val_show.length>0)
				{
				    s_grp_id=ret_val_show[0][0];
					s_grp_name=ret_val_show[0][1];
				}
		}
		else if(ret_val[0][3].equals("1"))
		{
			String[] inParas2_np = new String[2];
			inParas2_np[0]="select to_char(count(*)) from dgrpusermsg where account_id=:a_id and sm_code='np' ";
			inParas2_np[1]="a_id="+contract_no;
			%>
				<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg2" outnum="1">
						<wtc:param value="<%=inParas2_np[0]%>"/>
						<wtc:param value="<%=inParas2_np[1]%>"/>
				</wtc:service>
				<wtc:array id="ret_val_np" scope="end" />
			<%
				System.out.println("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF ret_val_np.length is "+ret_val_np.length+" and ret_val_np[0][0] is "+ret_val_np[0][0]+" inParas2_np[0] is "+inParas2_np[0]+" and inParas2_np[1] is "+inParas2_np[1]);
				if(ret_val_np.length==0)
				{
					s_flag="N";
				}
				else
				{
					if(Integer.parseInt(ret_val_np[0][0])==0)
					{
						s_flag="N";
					}
					else
					{
						s_flag="Y";
						s_show_flag="1"; //չʾ���Ǽ��ſͻ�����ͼ�������
						inParas_show[0]="select to_char(a.cust_id),a.unit_name  from dgrpcustmsg  a,dconmsg b where a.cust_id = b.con_cust_id and  b.contract_no=:s_con_id1";
						inParas_show[1]="s_con_id1="+contract_no;
						%>
							<wtc:service name="TlsPubSelCrm" retcode="retCode5" retmsg="retMsg5" outnum="2">
									<wtc:param value="<%=inParas_show[0]%>"/>
									<wtc:param value="<%=inParas_show[1]%>"/>
							</wtc:service>
							<wtc:array id="ret_val_show1" scope="end" />
						<%
							if(ret_val_show1.length>0)
							{
								s_grp_id=ret_val_show1[0][0];
								s_grp_name=ret_val_show1[0][1];
							}
					}
				}
		}
		else
		{
			s_flag="N";
		}
	}
	if(s_flag=="Y")
	{
	%>
	<html xmlns="http://www.w3.org/1999/xhtml">
		<HEAD><TITLE>һ��֧������ͳ���ֹ�����</TITLE>
	
		<script language="javascript">
			function doQry()
			{
				document.frm1508_2.action="zg01_3.jsp?contract_no="+"<%=contract_no%>"+"&contract_money="+document.getElementById("con_money_id").value+"&now_day="+document.getElementById("now_day_id").value+"&s_show_flag="+"<%=s_show_flag%>";
				//alert(document.all.action);
				document.frm1508_2.submit();
			}
		</script>
		
		</HEAD>
		<body>


		<FORM method=post name="frm1508_2">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѯ���</div>
		</div>

			  <table cellspacing="0" id = "PrintA">
						<tr> 
						  <th>�˻�����</th>
						  <th>�˻�����</th>
						  <th>���ſͻ�����</th>
						  <%
								System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA s_show_flag is "+s_show_flag);
								if(s_show_flag.equals("A") || s_show_flag=="A")
								{
										%>
											 <th>��������</th>
										<%
								}
								else
								{
										%>
											 <th>��������</th>
										<%
								}
						  %>
						  
						  <th>�˻�Ԥ��</th> 
						</tr>
			 
						<tr>
							<td align="center"><%=contract_no%></td>
						
							<td align="center"><%=ret_val[0][0]%></td>
							<td align="center"><%=s_grp_id%></td>
							<td align="center"><%=s_grp_name%></td>
							<td align="center"><%=ret_val[0][1]%></td>
							
						</tr>
							
					<input type="hidden" id="con_money_id" value="<%=ret_val[0][1]%>">
					<input type="hidden" id="now_day_id" value="<%=ret_val[0][2]%>">
				 
				  <tr id="footer"> 
					<td colspan="9">
					  <input class="b_foot" name=query onClick="doQry()" type=button value=��ѯ�������>
					  <!--
					  <input class="b_foot" name=doCfm onClick=" " type=button value=�Ƿ����ֱ�ӻ���?> 
					  -->
					  <input class="b_foot" name=back onClick="window.location.href='zg01_1.jsp'" type=button value=����>
					</td>
				  </tr>
				  
			  </table>
			  
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="id_contractNo">			
				

		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
		</BODY>
	</HTML>
	<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��һ��֧���ʺŻ����ʺŵĲ�Ʒ���ͷ�np!");
				window.location.href="zg01_1.jsp";
			</script>
		<%
	}
%>


