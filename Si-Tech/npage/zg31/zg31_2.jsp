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
	String workname = (String)session.getAttribute("workName");
	String opCode = "zg31";
    String opName = "增值税专票传递结束确认";
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
	String begin_tm = request.getParameter("begin_tm");
	//String end_tm = request.getParameter("end_tm");
	String s_cust_id=request.getParameter("cust_id");//"23002348611";//应该从前台获取
 
	//xl add for 改为月分表查询
	String s_year_month = begin_tm.substring(0,6);
	String s_dinvoicecnt = "dinvoiceprint"+s_year_month;
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(tax_invoice_num),to_char(tax_invoice_code),tax_client_no,tax_kpr,decode(invoice_flag,1,'已开具','4','待传递'),to_char(invoice_flag) from "+s_dinvoicecnt+" where  invoice_type='1' and invoice_flag in ('1','4') ";
	//inParas2[1]="d1="+begin_tm+",d2="+end_tm;
 
	/*inParas2[0]="select unit_name,to_char(taxpayer_id),address,to_Char(phone_no),bank_name,to_char(bank_account) from dbcustadm.CT_TAXPAYER_INFO where cust_id=:s_cust_id ";
	inParas2[1]="s_cust_id="+s_cust_id;
	*/
	//通过前台录入的cust_id 查询dbcustadm.CT_TAXPAYER_INFO
	
	//查询 工号所在营业厅 作为审批人
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select a.login_no,login_name from Staxinvoice_login_sp a,dloginmsg b where   a.login_no=b.login_no and region_code=:s_region_code and op_code='zg25' ";//工号写死为aavt26
	inParas_sp[1]="s_region_code="+regionCode;
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas_sp[0]%>"/>
	<wtc:param value="<%=inParas_sp[1]%>"/>
</wtc:service>
<wtc:array id="ret_sp" scope="end" />


<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:param value="<%=inParas2[0]%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询结果不存在");
				history.go(-1);
			</script>
		<%
	}
	else
	{
		%>
		<FORM method=post name="frm1508_2">
			<html xmlns="http://www.w3.org/1999/xhtml">
					<HEAD><TITLE>增值税发票作废开具申请</TITLE>
				
						<script language="javascript">
							 
							function spno()
							{
								alert("状态改为 红字 否 即未发起冲红请求");
							}
							
							function doprint()
							{
								//alert("从表里取已传递记录");
								document.frm1508_2.action="zg30_4.jsp";
								document.frm1508_2.submit();
							}	
							 
							function docfm()
							{
								//alert("1");
								var sprid = document.frm1508_2.spr[document.frm1508_2.spr.selectedIndex].value;
								var  zp_numberArrays=[]; 
								var  zp_codeArrays=[]; 
								var  zp_zdArrays=[]; 
								var  zp_kprArrays=[]; 
								var  zp_ztArrays=[]; 
								var len = "";
								len=document.frm1508_2.testcheck.length;
								var check_flag=0;//判断是否已经选中
								if(len==undefined)
								{
									//alert("1?");
									len=1;
									check_flag=1;
									var zp_number = document.getElementById("zp_number"+i).value;
									var zp_code = document.getElementById("zp_code"+i).value;
									var zp_zd = document.getElementById("zp_zd"+i).value;
									var zp_kpr = document.getElementById("zp_kpr"+i).value;
									var zp_zt = document.getElementById("zp_zt"+i).value;
									zp_ztArrays.push(zp_zt);
									zp_numberArrays.push(zp_number);
									zp_codeArrays.push(zp_code);
									zp_zdArrays.push(zp_zd);
									zp_kprArrays.push(zp_kpr);
									//alert("zp_number is "+zp_number+" and zp_numberArrays is "+zp_numberArrays);
								}
								else
								{
									for (i = 0; i < len; i++) 
									{
										if (document.frm1508_2.testcheck[i].checked == true) 
										{
											var zp_number = document.getElementById("zp_number"+i).value;
											var zp_code = document.getElementById("zp_code"+i).value;
											var zp_zd = document.getElementById("zp_zd"+i).value;
											var zp_kpr = document.getElementById("zp_kpr"+i).value;
											var zp_zt = document.getElementById("zp_zt"+i).value;
											zp_ztArrays.push(zp_zt);
											zp_numberArrays.push(zp_number);
											zp_codeArrays.push(zp_code);
											zp_zdArrays.push(zp_zd);
											zp_kprArrays.push(zp_kpr);
										}
									}	
									check_flag=1;	
								}
								if(check_flag=="1")
								{
									var url="zg31_3.jsp?zp_numberArrays="+zp_numberArrays+"&zp_codeArrays="+zp_codeArrays+"&zp_zdArrays="+zp_zdArrays+"&zp_kprArrays="+zp_kprArrays+"&zp_ztArrays="+zp_ztArrays+"&sprid="+sprid;
									var url_new =url;//URLencode(url); 提交传递请求
								 
									document.frm1508_2.action=url_new;
									alert(document.frm1508_2.action);
									var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
									if (prtFlag==1)
									{
										//打印内部传递单 下一个页面调用接口入表
										document.frm1508_2.submit();  
									}
									else
									{
										return false;
									}
								}
							}
							 

					</script>
					
					</HEAD>



					<body  >


					

					
					<%@ include file="/npage/include/header.jsp" %>
					<div class="title">
						<div id="title_zi">增值税发票作废开具申请</div>
					</div>

						  <table cellspacing="0" >
								<tr>
									<th>增值税专票发票号码</th>
									<th>增值税专票发票代码</th>
									<th>开票终端</th>
									<th>开票人</th>
									<th>当前发票状态</th>
									<th>操作</th>
								</tr> 
									 
									<%
										for(int i=0;i<ret_val.length;i++)
										{
											%>
											<input type="hidden" id="zp_number<%=i%>" value="<%=ret_val[i][0]%>">
											<input type="hidden" id="zp_code<%=i%>" value="<%=ret_val[i][1]%>">
											<input type="hidden" id="zp_zd<%=i%>" value="<%=ret_val[i][2]%>">
											<input type="hidden" id="zp_kpr<%=i%>" value="<%=ret_val[i][3]%>">
											<input type="hidden" id="zp_zt<%=i%>" value="<%=ret_val[i][5]%>">
												<tr>
													<td><%=ret_val[i][0]%></td>
													<td><%=ret_val[i][1]%></td>
													<td><%=ret_val[i][2]%></td>
													<td><%=ret_val[i][3]%></td>
													<td><%=ret_val[i][4]%></td>
													<td><input type="checkbox" id="impCheck<%=i%>" name="testcheck"></td> 
												</tr>
											<%
										}
									%>
									 
									
									<tr>
												<td colspan=8>
													申请人 <%=workname%>
													审批人 <select name="spr" id="sprid" >
													<option value="0" selected>---请选择---</option>
													<%for(int i=0; i<ret_sp.length; i++){%>
													<option value="<%=ret_sp[i][0]%>">
													
													<%=ret_sp[i][0]%>--><%=ret_sp[i][1]%></option>
													<%}%>
		 
												</select>

												审批人联系电话：<input type="text" name="lxr_phone">
												</td>
									</tr>  
								 <input type="text" name="s_year_month" value="<%=s_year_month%>">
							  <tr id="footer"> 
								<td colspan="9">
						 
								  <input class="b_foot" name=tjsq onClick="docfm()" type=button value=确认传递>	
								  <!-- ret_sp
								  <input class="b_foot" name=doCfm onClick=" " type=button value=是否可以直接划拨?> 
								  -->
								  <input class="b_foot" name=back onClick="window.location.href='zg27_1.jsp'" type=button value=返回>
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
%>

