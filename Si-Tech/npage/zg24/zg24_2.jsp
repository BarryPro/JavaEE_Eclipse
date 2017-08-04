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
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	//regionCode="12";
	String workno = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = "zg24";
    String opName = "增值税红字发票开具申请";
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
	String s_cust_id=request.getParameter("cust_id");//"23002348611";//应该从前台获取
	 
	//通过前台录入的cust_id 查询dbcustadm.CT_TAXPAYER_INFO
	
	//查询开具红字原因
	String[] inParas2_ch = new String[1];
	inParas2_ch[0]="select reason_id,reason_name from staxinvoice_ch";
	 

	//查询 工号所在营业厅 作为审批人
	//局方提供配置信息表
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select a.login_no,login_name from Staxinvoice_login_sp a,dloginmsg b where   a.login_no=b.login_no and region_code=:s_region_code and op_code='zg25' ";//工号写死为aavt26
	inParas_sp[1]="s_region_code="+regionCode;
	
	String[] inParas_qry = new String[5];
	inParas_qry[0]=tax_number;
	inParas_qry[1]=tax_code;
	inParas_qry[2]=s_cust_id;
	inParas_qry[3]="zg24";
	inParas_qry[4]=workno;

	String year_month = request.getParameter("year_month");
%>



<wtc:service name="TlsPubSelBoss" retcode="retCode_ch" retmsg="retMsg_ch" outnum="2">
	<wtc:param value="<%=inParas2_ch[0]%>"/>
</wtc:service>
<wtc:array id="ret_ch" scope="end" />

<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas_sp[0]%>"/>
	<wtc:param value="<%=inParas_sp[1]%>"/> 
</wtc:service>
<wtc:array id="ret_sp" scope="end" />


 


		<wtc:service name="bs_zg24init" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="12">
			<wtc:param value="<%=inParas_qry[0]%>"/>
			<wtc:param value="<%=inParas_qry[1]%>"/>	
			<wtc:param value="<%=inParas_qry[2]%>"/>
			<wtc:param value="<%=inParas_qry[3]%>"/>
			<wtc:param value="<%=inParas_qry[4]%>"/>
			<wtc:param value="<%=year_month%>"/>
		</wtc:service>
		<wtc:array id="ret_1" scope="end" start="0"  length="2" /> 
		<wtc:array id="tax_msg" scope="end" start="2"  length="8" />	
		<wtc:array id="all_msg" scope="end" start="10"  length="2" />
		<%
			if(retCode11=="000000" || retCode11.equals("000000"))
			{
				%>
				<FORM method=post name="frm1508_2">
			 
							<HEAD><TITLE>增值税红字发票开具申请</TITLE>
						
								<script language="javascript">
									function doQry()
									{
										var sprid = document.frm1508_2.spr[document.frm1508_2.spr.selectedIndex].value;
										var hzyy = document.frm1508_2.hzyy[document.frm1508_2.hzyy.selectedIndex].value;
										var lxr_phone = document.frm1508_2.lxr_phone.value;
										if(sprid=="0")
										{
											rdShowMessageDialog("请选择上级审批人!");
											return false;
										}
										else if(hzyy=="0")
										{
											rdShowMessageDialog("请选择红字发票开具原因!");
											return false;
										}
										/*
										else if((document.getElementById("check_id").checked) &&(document.frm1508_2.accepts.value==""))
										{
											rdShowMessageDialog("需要我方提供《开具红字增值税专用发票通知单》,请输入《开具红字增值税专用发票通知单》编号!");
											return false;
										}
										*/
										else if(lxr_phone=="")
										{
											rdShowMessageDialog("请输入联系人电话号码以便发送审批短信!");
											return false;
										}		
										else
										{
											var prtFlag=0;
											prtFlag=rdShowConfirmDialog("是否确认提交冲红申请?");
											if (prtFlag==1)
											{
												document.frm1508_2.action="zg24_3.jsp?sprid="+sprid+"&hzyy="+hzyy;
												document.frm1508_2.submit();
											}
											else
											{
												return false;
												window.location.href="zg24_1.jsp";
											}
											
										}
									}
									function doCheck()
									{
										//alert("1");
										if(document.getElementById("check_id").checked)
										{
											document.getElementById("div1").style.display="block";
											document.frm1508_2.ifcheck.value="1";
										}
										else
										{
											document.getElementById("div1").style.display="none";
											document.frm1508_2.ifcheck.value="0";
										}
										
									}
									function inits()
									{
										//document.getElementById("div1").style.display="none";
									}
							</script>
							
							</HEAD>



							<body onload="inits()">


							

							
							<%@ include file="/npage/include/header.jsp" %>
							<div class="title">
								<div id="title_zi">增值税红字发票开具申请</div>
							</div>

								  <table cellspacing="0" >
											<tr> 
											<input type="hidden" name="tax_number" value="<%=tax_number%>">
											<input type="hidden" name="tax_code" value="<%=tax_code%>">
											<input type="hidden" name="s_cust_id" value="<%=s_cust_id%>">
											
											   <td colspan="4">原蓝字发票号码<%=tax_number%></td>
											   <td colspan="4">原蓝字发票代码<%=tax_code%></td>	
										 
											</tr>
											 
											<tr>
												<th>货物或应税劳务名称</th>
												<th>规格型号</th>
												<th>单位</th>
												<th>数量</th>
												<th>单价</th>
												<th>金额</th>
												<th>税率</th>
												<th>税额</th>
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
												<td align="right" colspan=8>
													总金额：<%=all_msg[0][0]%>
													总税额：<%=all_msg[0][1]%>
												</td>
											</tr>
											<tr> 
												
												<td colspan=8>
												红字发票开具原因
												<select id="hzyyid" name="hzyy">
													<option value="0" selected>---请选择---</option>
													<%for(int i=0; i<ret_ch.length; i++){%>
													<option value="<%=ret_ch[i][0]%>">
													
													 <%=ret_ch[i][1]%></option>
													<%}%>
												</select>
												</td>
											 
											</tr>
											<!--
											<tr>
												
												<td colspan=8>
													<input type="checkbox" id="check_id" onclick="doCheck()">需要我方提供《开具红字增值税专用发票通知单》(若原蓝字发票已认证，应由对方申请《开具红字增值税专用发票通知单》)
													<input type="hidden" name="ifcheck">
												</td>
												
											</tr> 
											<tr id="div1">
												<td colspan=8>《开具红字增值税专用发票通知单》编号:<input type="text" maxlength=30 size=30 name="accepts"  maxlength="300"> </td>
											</tr>
											-->
											<tr>
												<td colspan=8>
													审批人 <select name="spr" id="sprid" >
													<option value="0" selected>---请选择---</option>
													<%for(int i=0; i<ret_sp.length; i++){%>
													<option value="<%=ret_sp[i][0]%>">
													
													<%=ret_sp[i][0]%>--><%=ret_sp[i][1]%></option>
													<%}%>
		 
												</select>

												审批人联系电话：<input type="text" name="lxr_phone" maxlength="11">
												</td>
										<input type="text" name="year_month" value="<%=year_month%>">													</tr> 
										 
									  <tr id="footer"> 
										<td colspan="9">
										  <input class="b_foot" name=query onClick="doQry()" type=button value=发起审核>
										  <!-- ret_sp
										  <input class="b_foot" name=doCfm onClick=" " type=button value=是否可以直接划拨?> 
										  -->
										  <input class="b_foot" name=back onClick="window.location.href='zg24_1.jsp'" type=button value=返回>
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
						rdShowMessageDialog("查询异常,错误原因:"+"<%=retCode11%>"+",错误原因:"+"<%=retMsg11%>");
						window.location.href="zg24_1.jsp";
					</script>
				<%
			}	
		 
	
%>

