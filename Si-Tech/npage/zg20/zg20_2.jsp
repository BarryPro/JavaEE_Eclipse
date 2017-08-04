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
	String workname = (String)session.getAttribute("workName");
	String opCode = "zg20";
    String opName = "电子发票冲红";
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
	String s_cust_id="";//"23002348611";//应该从前台获取
	 
	//通过前台录入的cust_id 查询dbcustadm.CT_TAXPAYER_INFO
	//查询开具红字原因
	String[] inParas2_ch = new String[1];
	inParas2_ch[0]="select reason_id,reason_name from staxinvoice_ch";
	
	//xl add for 月分表
	String year_month = request.getParameter("year_month");  
%>

<wtc:service name="TlsPubSelBoss" retcode="retCode_ch" retmsg="retMsg_ch" outnum="2">
	<wtc:param value="<%=inParas2_ch[0]%>"/>
</wtc:service>
<wtc:array id="ret_ch" scope="end" />


<wtc:service name="bs_zg20init" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="13">
	<wtc:param value="<%=tax_number%>"/>
	<wtc:param value="<%=tax_code%>"/>	
	<wtc:param value="<%=s_cust_id%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="0"/>
	
</wtc:service>
<wtc:array id="ret_1" scope="end" start="0"  length="2" /> 
<wtc:array id="tax_1" scope="end" start="2"  length="5" />
<wtc:array id="tax_msg" scope="end" start="7"  length="6" />	
<%
	if(retCode11=="000000" || retCode11.equals("000000"))
	{
		%>
			<FORM method=post name="frm1508_2">
				<html xmlns="http://www.w3.org/1999/xhtml">
						<HEAD><TITLE>改为“电子发票冲红</TITLE>
					
							<script language="javascript">
								function inits()
								{
									//document.all.zjzf.disabled=true;
									//document.all.tjsq.disabled=true;
								}
								function spno()
								{
									alert("状态改为 红字 否 即未发起冲红请求");
								}
								function doCheck()
								{
									//alert("校验是否已经传递至客户经理,查询该张发票状态是否是已传递，已传递的需要审批，未传递的直接可以进行作废流程");
									var check_Packet = new AJAXPacket("s_check_trans.jsp","正在校验发票传递状态，请稍候......");
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
										if(s_count>=1)//已传递的要申请
										{
											//alert("1 已传递的要申请");
											document.all.zjzf.disabled=true;
											document.all.tjsq.disabled=false;
										}
										else
										{
											//alert("2 未传递的可以直接作废");
											document.all.zjzf.disabled=false;
											document.all.tjsq.disabled=true;
										}	
									}
									else
									{
										alert("校验发票状态异常！");
									}
								}
								function tjsq1()
								{
									//var hzyy = document.frm1508_2.hzyy[document.frm1508_2.hzyy.selectedIndex].value;
									var hzyy ="1";
									if(hzyy=="0")
									{
										rdShowMessageDialog("请选择红字发票开具原因!");
										return false;
									}
									else
									{
										var prtFlag=0;
										prtFlag=rdShowConfirmDialog("是否确认提交冲红申请?");
										if (prtFlag==1)
										{
											document.frm1508_2.action="zg20_3.jsp";
											document.frm1508_2.submit();
										}
										else
										{
											return false;
											window.location.href="zg20_1.jsp";
										}
									}
									
								}
								function zjzf1()
								{
									alert("2");
								}

						</script>
						
						</HEAD>



						<body onload="inits()">


						

						
						<%@ include file="/npage/include/header.jsp" %>
						<div class="title">
							<div id="title_zi">改为“电子发票冲红</div>
						</div>

							  <table cellspacing="0" id = "PrintA">
										<tr> 
										   <td colspan="4">原蓝字发票号码<%=tax_number%></td>
										   <td colspan="4">原蓝字发票代码<%=tax_code%></td>	
										   <input type="hidden" name="tax_number" value="<%=tax_number%>">
										   <input type="hidden" name="tax_code" value="<%=tax_code%>">
									 
										</tr>
									 
										<tr>
											<th>货物或应税劳务名称</th>
											<th>规格型号</th>
											<th>单位</th>
											<th>数量</th>
											<th>金额</th>
											<th>流水</th>
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
											 
													</tr>
												<%
											}
										%>
									<!--
									<tr> 
									<input type="text" name="year_month" value="<%=year_month%>">			
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
									-->
									<input type="text" name="year_month" value="<%=year_month%>">		
										 
								  <tr id="footer"> 
									<td colspan="9">
								 
									  <input class="b_foot" name=zjzf onClick="tjsq1()" type=button value=红字发票开具>	
									  <!-- ret_sp
									  <input class="b_foot" name=doCfm onClick=" " type=button value=是否可以直接划拨?> 
									  -->
									  <input class="b_foot" name=back onClick="window.location.href='zg20_1.jsp'" type=button value=返回>
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
				window.location.href="zg20_1.jsp";
			</script>
		<%
	}

%>

