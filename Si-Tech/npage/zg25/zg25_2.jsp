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
	String opCode = "zg25";
    String opName = "��ֵ˰���ַ�Ʊ��������";
	String s_good_name=request.getParameter("s_good_name");
	String s_ggxh = request.getParameter("s_ggxh");
	String s_dw =  request.getParameter("s_dw");
	String s_sl =  request.getParameter("s_sl");
	String s_dj =  request.getParameter("s_dj");
	String s_je =  request.getParameter("s_je");
	String s_tax_rate =  request.getParameter("s_tax_rate");
	String s_se =  request.getParameter("s_se");
	String tax_code = request.getParameter("tax_code");
	String tax_number = request.getParameter("tax_number");
	String s_cust_id=request.getParameter("cust_id");//"23002348611";//Ӧ�ô�ǰ̨��ȡ
	String[] inParas2 = new String[2];

	String year_month = request.getParameter("year_month");
	//��ѯ���ߺ���ԭ��
	String[] inParas2_ch = new String[1];
	inParas2_ch[0]="select reason_id,reason_name from staxinvoice_ch";
	 

	//��ѯ ��������Ӫҵ�� ��Ϊ������
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select login_no,login_name from dloginmsg where   login_no='aavt26'";
	inParas_sp[1]="s_group_id="+groupId;
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String[] inParas_qry = new String[5];
	inParas_qry[0]=tax_number;
	inParas_qry[1]=tax_code;
	inParas_qry[2]=s_cust_id;
	inParas_qry[3]="zg24";
	inParas_qry[4]=workno;
%>



<wtc:service name="TlsPubSelBoss" retcode="retCode_ch" retmsg="retMsg_ch" outnum="2">
	<wtc:param value="<%=inParas2_ch[0]%>"/>
</wtc:service>
<wtc:array id="ret_ch" scope="end" />

<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas_sp[0]%>"/>
 
</wtc:service>
<wtc:array id="ret_sp" scope="end" />






		<wtc:service name="bs_zg24Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="14">
			<wtc:param value="<%=tax_number%>"/>
			<wtc:param value="<%=tax_code%>"/>	
			<wtc:param value=""/>
			<wtc:param value="zg25"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=year_month%>"/>
		</wtc:service>
		<wtc:array id="ret_1" scope="end" start="0"  length="2" /> 
		<wtc:array id="tax_msg" scope="end" start="2"  length="8" />	
		<wtc:array id="all_msg" scope="end" start="10"  length="4" />
		<%
			if(retCode11=="000000" || retCode11.equals("000000"))
			{
				%>
				<FORM method=post name="frm1508_2">
			 
							<HEAD><TITLE>��ֵ˰���ַ�Ʊ��������</TITLE>
						
								<script language="javascript">
									function doQry()
									{
										var robj=document.frm1508_2.ok;
										var hzyy = document.getElementById("hzyy").value;
										var ifcheck = document.getElementById("ifcheck").value;
										var accepts  = document.getElementById("accepts").value;
										
										var radio_value ="";
										for(i=0;i<robj.length;i++){
											if(robj[i].checked){
											//alert(robj[i].value);
											radio_value=robj[i].value;
											}
										}
										var prtFlag=0;
										prtFlag=rdShowConfirmDialog("�Ƿ�ȷ���ύ?");
										if (prtFlag==1)
										{
											document.frm1508_2.action="zg25_3.jsp?hzyy="+hzyy+"&radio_value="+radio_value+"&accepts="+accepts;
											document.frm1508_2.submit();
										}
										else
										{
											return false;
											window.location.href="zg25_1.jsp";
										}
									}
									 
									 
							</script>
							
							</HEAD>



							<body>


							

							
							<%@ include file="/npage/include/header.jsp" %>
							<div class="title">
								<div id="title_zi">��ֵ˰���ַ�Ʊ��������</div>
							</div>

								  <table cellspacing="0" >
											<tr> 
											<input type="hidden" name="tax_number" value="<%=tax_number%>">
											<input type="hidden" name="tax_code" value="<%=tax_code%>">
											<input type="hidden" name="s_cust_id" value="<%=s_cust_id%>">
											
											   <td colspan="4">ԭ���ַ�Ʊ����<%=tax_number%></td>
											   <td colspan="4">ԭ���ַ�Ʊ����<%=tax_code%></td>	
										 
											</tr>
											 
											<tr>
												<th>�����Ӧ˰��������</th>
												<th>����ͺ�</th>
												<th>��λ</th>
												<th>����</th>
												<th>����</th>
												<th>���</th>
												<th>˰��</th>
												<th>˰��</th>
											</tr>
											<%
												for(int i =0;i<tax_msg.length;i++)
												{
													%>
														<tr>
															<td><%=tax_msg[i][0]%></td>
															<td><%=tax_msg[i][1]%></td>
															<td><%=tax_msg[i][2]%></td>
															<td><%=tax_msg[i][3]%></td>
															<td><%=tax_msg[i][4]%></td>
															<td><%=tax_msg[i][5]%></td>
															<td><%=tax_msg[i][6]%></td>
															<td><%=tax_msg[i][7]%></td>
														</tr>
													<%
												}
											%>
											 
											<tr> 
												
												<td colspan=8>
												���ַ�Ʊ����ԭ��<%=all_msg[0][0]%>
												<input type="hidden" id="hzyy" value="<%=all_msg[0][0]%>">
												</td>
											 
											</tr>
											<tr>
												<td colspan=8>
													<input type="hidden" id="ifcheck" value="<%=all_msg[0][1]%>">
													<input type="hidden" id="accepts" value="<%=all_msg[0][2]%>">
													 
													 
													

												</td>
											</tr> 
										 
											<tr>
												<td colspan=8>
												������ <%=all_msg[0][3]%><br>
												������ <%=workno%><br>
												 
												</td>
											</tr> 
											<tr>
												<td colspan=8>
													���������<p>
													����ͨ��<input type="radio" name="ok" value="0" checked><p>
													������ͨ��<input type="radio" name="ok" value="1"><p>
												</td>
											</tr>
										 
									  <tr id="footer"> 
										<td colspan="9">
										  <input class="b_foot" name=query onClick="doQry()" type=button value=�������>
										  <!-- ret_sp
										  <input class="b_foot" name=doCfm onClick=" " type=button value=�Ƿ����ֱ�ӻ���?> 
										  -->
										  <input class="b_foot" name=back onClick="window.location.href='zg25_1.jsp'" type=button value=����>
										</td>
									  </tr>
									<input type="text" name="year_month" value="<%=year_month%>">  
								  </table>
								  
								 
								
									
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
						rdShowMessageDialog("��ѯ�쳣,����ԭ��:"+"<%=retCode11%>"+",����ԭ��:"+"<%=retMsg11%>");
						window.location.href="zg25_1.jsp";
					</script>
				<%
			}	
		 

%>

