<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String groupId = (String)session.getAttribute("groupId");
	String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	//regionCode="12";
	String workname = (String)session.getAttribute("workName");
	String opCode = "zg27";
    String opName = "��ֵ˰��Ʊ���Ͽ�������";
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
	 
	//ͨ��ǰ̨¼���cust_id ��ѯdbcustadm.CT_TAXPAYER_INFO
	
	//��ѯ ��������Ӫҵ�� ��Ϊ������
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select a.login_no,login_name from Staxinvoice_login_sp a,dloginmsg b where   a.login_no=b.login_no and region_code=:s_region_code and op_code='zg25' ";//����д��Ϊaavt26
	inParas_sp[1]="s_region_code="+regionCode;
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas_sp[0]%>"/>
	<wtc:param value="<%=inParas_sp[1]%>"/> 
</wtc:service>
<wtc:array id="ret_sp" scope="end" />



		<wtc:service name="bs_zg27init" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="10">
			<wtc:param value="<%=tax_number%>"/>
			<wtc:param value="<%=tax_code%>"/>	
			<wtc:param value="<%=s_cust_id%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="0"/>
	 
		</wtc:service>
		<wtc:array id="ret_1" scope="end" start="0"  length="2" /> 
		<wtc:array id="tax_msg" scope="end" start="2"  length="8" />	
		<%
			//retCode11="000000";
			if(retCode11=="000000" || retCode11.equals("000000"))
			{
				%>
					<FORM method=post name="frm1508_2">
						<html xmlns="http://www.w3.org/1999/xhtml">
								<HEAD><TITLE>��ֵ˰��Ʊ���Ͽ�������</TITLE>
							
									<script language="javascript">
										function inits()
										{
											document.all.zjzf.disabled=true;
											document.all.tjsq.disabled=true;
										}
										function spno()
										{
											alert("״̬��Ϊ ���� �� ��δ����������");
										}
										function doCheck()
										{
											//alert("У���Ƿ��Ѿ��������ͻ�����,��ѯ���ŷ�Ʊ״̬�Ƿ����Ѵ��ݣ��Ѵ��ݵ���Ҫ������δ���ݵ�ֱ�ӿ��Խ�����������");
											var check_Packet = new AJAXPacket("s_check_trans.jsp","����У�鷢Ʊ����״̬�����Ժ�......");
											check_Packet.data.add("tax_number", document.all.tax_number.value);
											check_Packet.data.add("tax_code", document.all.tax_code.value);
											core.ajax.sendPacket(check_Packet,doPosSubInfo); 
											check_Packet=null;
										}
										function doPosSubInfo(packet)
										{
											var s_flag = packet.data.findValueByName("s_flag");
											var s_count = packet.data.findValueByName("s_count");
											//alert("s_flag is "+s_flag+" and s_count is "+s_count);
											if(s_flag=="Y")
											{
												if(s_count>=1)//�Ѵ��ݵ�Ҫ����
												{
													//alert("1 �Ѵ��ݵ�Ҫ����");
													document.all.zjzf.disabled=true;
													document.all.tjsq.disabled=false;
												}
												else
												{
													//alert("2 δ���ݵĿ���ֱ������");
													document.all.zjzf.disabled=false;
													document.all.tjsq.disabled=true;
												}	
											}
											else
											{
												alert("У�鷢Ʊ״̬�쳣��");
											}
										}
										function tjsq1()
										{
											var sprid = document.frm1508_2.spr[document.frm1508_2.spr.selectedIndex].value;
											 ;
											var prtFlag=0;
											prtFlag=rdShowConfirmDialog("�Ƿ�ȷ���ύ��������?");
											if (prtFlag==1)
											{
												document.frm1508_2.action="zg27_3.jsp?sprid="+sprid;
												document.frm1508_2.submit();
											}
											else
											{
												return false;
												window.location.href="zg24_1.jsp";
											}
										}
										function zjzf1()
										{
											//alert("2 ����һ���ӿ� invoice_flag=7");
											document.frm1508_2.action="zg27_update.jsp";
											document.frm1508_2.submit();
										}

								</script>
								
								</HEAD>



								<body onload="inits()">


								

								
								<%@ include file="/npage/include/header.jsp" %>
								<div class="title">
									<div id="title_zi">��ֵ˰��Ʊ���Ͽ�������</div>
								</div>

									  <table cellspacing="0" id = "PrintA">
												<tr> 
												   <td colspan="3">ԭ���ַ�Ʊ����<%=tax_number%></td>
												   <td colspan="3">ԭ���ַ�Ʊ����<%=tax_code%></td>	
												   <input type="hidden" name="tax_number" value="<%=tax_number%>">
												   <input type="hidden" name="tax_code" value="<%=tax_code%>">
												    
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
													��Ʊ�Ƿ��Ѵ���У��<input type="checkbox" id="check_id" onclick="doCheck()">
													(רƱ���Ѵ���,����Ҫ�����������������ֱ����zg29�������ϲ�����)
												   </td>
												 
												</tr>
												
												<tr>
													<td colspan=8>
														������ <select name="spr" id="sprid" >
														<option value="0" selected>---��ѡ��---</option>
														<%for(int i=0; i<ret_sp.length; i++){%>
														<option value="<%=ret_sp[i][0]%>">
														
														<%=ret_sp[i][0]%>--><%=ret_sp[i][1]%></option>
														<%}%>
			 
													</select>

													��������ϵ�绰��<input type="text" name="lxr_phone" maxlength="11">
													</td>
												</tr> 
											 
										  <tr id="footer"> 
											<td colspan="9">
											  <input class="b_foot" name=tjsq onClick="tjsq1()" type=button value=�ύ��������>
											  <input class="b_foot" name=zjzf onClick="zjzf1()" type=button value=ֱ������>	
											  <!-- ret_sp
											  <input class="b_foot" name=doCfm onClick=" " type=button value=�Ƿ����ֱ�ӻ���?> 
											  -->
											  <input class="b_foot" name=back onClick="window.location.href='zg27_1.jsp'" type=button value=����>
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
						rdShowMessageDialog("��ѯ�쳣,����ԭ��:"+"<%=retCode11%>"+",����ԭ��:"+"<%=retMsg11%>");
						window.location.href="zg27_1.jsp";
					</script>
				<%
			}

%>

