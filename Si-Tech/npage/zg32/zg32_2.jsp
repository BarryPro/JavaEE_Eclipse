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
    String workno = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = "zg32";
    String opName = "�����мۿ���ֵ";
  /**
	String s_good_name=request.getParameter("s_good_name");
	String s_ggxh = request.getParameter("s_ggxh");
	String s_dw =  request.getParameter("s_dw");
	String s_sl =  request.getParameter("s_sl");
	String s_dj =  request.getParameter("s_dj");
	String s_je =  request.getParameter("s_je");
	String s_tax_rate =  request.getParameter("s_tax_rate");
	String s_se =  request.getParameter("s_se");
	**/
	String phone_no = request.getParameter("phone_no");
	String pay_accept = request.getParameter("pay_accept");
	/*String s_cust_id=request.getParameter("cust_id");//"23002348611";//Ӧ�ô�ǰ̨��ȡ**/
	/**String[] inParas2 = new String[2];
	inParas2[0]="select unit_name,to_char(taxpayer_id),address,to_Char(phone_no),bank_name,to_char(bank_account) from dbcustadm.CT_TAXPAYER_INFO where cust_id=:s_cust_id ";
	inParas2[1]="s_cust_id="+s_cust_id;
	ͨ��ǰ̨¼���cust_id ��ѯdbcustadm.CT_TAXPAYER_INFO
	
	��ѯ���ߺ���ԭ��
	String[] inParas2_ch = new String[1];
	inParas2_ch[0]="select reason_id,reason_name from staxinvoice_ch";
	 

	��ѯ ��������Ӫҵ�� ��Ϊ������
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select login_no,login_name from dloginmsg where group_id=:s_group_id";
	inParas_sp[1]="s_group_id="+groupId;**/
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	
	String[] inParas_qry = new String[4];
	inParas_qry[0]=phone_no;
	inParas_qry[1]=pay_accept;
	inParas_qry[2]=opCode;
	inParas_qry[3]=workno;
	String custname="";
	String opDate="";
	String sCardMoney="";
		  		  	
%>


		<wtc:service name="szg32init" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="4">
			<wtc:param value="<%=inParas_qry[0]%>"/>
			<wtc:param value="<%=inParas_qry[1]%>"/>	
			<wtc:param value="<%=inParas_qry[2]%>"/>
			<wtc:param value="<%=inParas_qry[3]%>"/>
		</wtc:service>
		<wtc:array id="ret_1" scope="end" /> 

		<%

			if(retCode11=="000000" || retCode11.equals("000000"))
			{
				if(ret_1!=null&&ret_1.length>0){
					custname=ret_1[0][1].trim();
					sCardMoney=ret_1[0][2].trim()+"Ԫ";
					opDate=ret_1[0][3].trim();
				}
				%>
				<FORM method=post name="frm1508_2">
			 
							<HEAD><TITLE>�����мۿ���ֵ</TITLE>
						
								<script language="javascript">
									function doQry()
									{
						
										
										
											var prtFlag=0;
											prtFlag=rdShowConfirmDialog("�Ƿ�ȷ�ϳ�ֵ?");
											if (prtFlag==1)
											{
												/**document.frm1508_2.action="zg24_3.jsp?sprid="+sprid+"&hzyy="+hzyy;*/
												document.frm1508_2.query.disabled=true;
												document.frm1508_2.action="zg32_3.jsp";
												document.frm1508_2.submit();
											}
											else
											{
												return false;
												window.location.href="zg32_1.jsp";
											}
											
										
									}
									 
							</script>
							
							</HEAD>



							<body>
							 

							

							
							<%@ include file="/npage/include/header.jsp" %>
							<div class="title">
								<div id="title_zi">�����мۿ���ֵ</div>
							</div>

								  <table cellspacing="0" >
											<input type="hidden" name="phone_no" value="<%=phone_no%>">
											<input type="hidden" name="pay_accept" value="<%=pay_accept%>">											
											  <tr>
                  				<td class="blue" >�ͻ�����</td>
                  				<td>
                    				<input type="text" readonly class="InputGrey" name="custname" value="<%=custname%>">
                  				</td>
                 				 	<td class="blue">�ͻ��绰</td>
                  				<td>
                    				<input type="text" readonly class="InputGrey" name="phone_no"  value="<%=phone_no%>">
                  				</td>
                  				<td class="blue">��������</td>
                  				<td>
                    				<input type="text" readonly class="InputGrey" name="opDate"  value="<%=opDate%>">
                  				</td>
                				</tr>
											<tr>
												<!--
												<th>�мۿ�����</th>
												-->
												<td class="blue" >��ֵ���</td>
												<td>
                    				<input type="text" readonly class="InputGrey" name="sCardMoney"  value="<%=sCardMoney%>">
                  			</td>
															
											</tr>
											<tr> 
																						 
											</tr>

											<input type="hidden" value="<%=phone_no%>" name="phone_no">

										 
									  <tr id="footer"> 
										<td colspan="9">
										  <input class="b_foot" name=query onClick="doQry()" type=button value=��ֵ>
										  <!-- ret_sp
										  <input class="b_foot" name=doCfm onClick=" " type=button value=�Ƿ����ֱ�ӻ���?> 
										  -->
										  <input class="b_foot" name=back onClick="window.location.href='zg32_1.jsp'" type=button value=����>
										</td>
									  </tr>
									  
								  </table>
								  
								  <tr id="footer"> 
									   
									  </tr>
								
									
							<input type="hidden" id="id_contractNo">			
									

							<%@ include file="/npage/include/footer.jsp" %>
							
							</BODY>
						</HTML>

					</FORM>
				<%
			}
			else
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("��ѯ�쳣,�������:"+"<%=retCode11%>"+",����ԭ��:"+"<%=retMsg11%>");
						window.location.href="zg32_1.jsp";
					</script>
				<%
			}	

%>

