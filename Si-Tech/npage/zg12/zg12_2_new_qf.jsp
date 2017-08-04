<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 
 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zgb8";
    String opName = "欠费增值税发票打印";
	
	String[] inParas2 = new String[2];
	
	//xl add 根据流水查询信息 begin
	String login_accept = request.getParameter("login_accept");
	inParas2[0]="select to_char(phone_no),to_char(begin_dt),to_char(end_dt),tax_name,tax_no,tax_address,tax_phone,tax_khh,tax_contract_no,spr,to_char(s_type_flag),nvl(notes,'') from DINVOICE_TAX_SP where login_accept=:s_accept";
	inParas2[1]="s_accept="+login_accept;
	%>
		<wtc:service name="TlsPubSelBoss" retcode="retCode_ch" retmsg="retMsg_ch" outnum="12">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="ret_ch" scope="end" />
	<%
	if(ret_ch.length>0)
	{
	 
			//end of 根据流水查询
	//获取纳税人信息
	String tax_name = ret_ch[0][3];
	String tax_no1 = ret_ch[0][4];
	String tax_address = ret_ch[0][5];
	String tax_phone = ret_ch[0][6];
	String tax_khh = ret_ch[0][7];
	String tax_contract_no = ret_ch[0][8];
	String s_flag="0";//审批查询成功 s_flag=0
	String phone_no = ret_ch[0][0];
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr_yyyymm=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	//xl add 增加根据入表结果 查询的开始时间 结束时间
	String begin_dt=ret_ch[0][1];
	String end_dt=ret_ch[0][2];
	String s_qry_flag=ret_ch[0][10];//增加3=一点支付的
	String s_notes = ret_ch[0][11];
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dateStr_yyyymm is "+dateStr_yyyymm);
%>
<html>
<FORM method=post name="frm1508_2">

		<HEAD><TITLE>增值税发票打印</TITLE>
	
			<script language="javascript">
				function docheck()
				{
					//xl add for zg23 开具前先对是否已经发票审批进行校验
					var phone_no = "<%=phone_no%>";
					var tax_id = "<%=tax_no1%>";
					//xl add 根据单选框取值
					var q_flag = document.getElementsByName("busyType1");
					var q_value;
					var begin_dt ;
					var end_dt;
					for(var i=0;i<q_flag.length;i++)
					{ 
						if(q_flag[i].checked)
						{
							q_value = q_flag[i].value;
						}
					}
				 
					if(q_value=="1") 
					{ 
						 
						begin_dt = document.frm1508_2.begindate.value;
						end_dt = document.frm1508_2.enddate.value;
						//alert("营销类 begin_dt is "+begin_dt+" and end_dt is "+end_dt);
						
					} 
					else 
					{ 
						begin_dt = document.frm1508_2.yj_date.value;
						end_dt = document.frm1508_2.yj_date.value;
						//alert("月结类 begin_dt is "+begin_dt+" and end_dt is "+end_dt);
					} 
					var pactket1 = new AJAXPacket("../zg12/zg12_sp.jsp","正在进行发票预占取消，请稍候......");
					pactket1.data.add("phone_no",phone_no);
					pactket1.data.add("tax_id",tax_id);
					pactket1.data.add("begin_dt",begin_dt);
					pactket1.data.add("end_dt",end_dt);
					core.ajax.sendPacket(pactket1);
					pactket1=null;
					//end of zg23 
					/*
					
					*/
					
				}
				function doProcess(packet)
				{
					var s_flag = packet.data.findValueByName("s_flag");
					var s_count = packet.data.findValueByName("s_count");
					//alert("s_flag is "+s_flag+" and s_count is "+s_count);
					if(s_flag=="1")
					{
						rdShowMessageDialog("判断专票开具申请记录报错!");
						history.go(-1);
					}
					else
					{
						if(s_flag=="0")
						{
							s_count=1;
							if(s_count<1)
							{
								rdShowMessageDialog("发票未发起审批操作,请先在zgb7发起开具审批!",0);
								history.go(-1);
							}
							else
							{
								var q_flag = document.getElementsByName("busyType1");
								//alert(q_flag);
								var q_value;
								for(var i=0;i<q_flag.length;i++)
								{ 
									if(q_flag[i].checked)
									{
										q_value = q_flag[i].value;
									}
								}
							 
								if(q_value=="4") 
								{ 
									document.frm1508_2.action="zg12_yj.jsp?q_value=4";
									document.frm1508_2.submit();
								} 
								else
								{
									rdShowMessageDialog("月结类专票的打印开始时间为20140701!");
								}
							}
							
						}
						else
						{
							rdShowMessageDialog("判断专票开具申请记录报错1!");
							history.go(-1);
						}
					}
				 }
				function sel1()
				{
					//window.location.href='zg12_2.jsp?phone_no='+document.frm1508_2.phone_no.value;
					//alert("1");
					document.getElementById("s_flag_qry").value="1";
					document.all.yxl_begin.style.display="block";
					document.all.yxl_end.style.display="block";
					document.all.yjl.style.display="none";
				}
				function sel2()
				{
					//alert("2");
					document.getElementById("s_flag_qry").value="4";
					document.all.yxl_begin.style.display="none";
					document.all.yxl_end.style.display="none";
					document.all.yjl.style.display="block";

					
					//xl 去掉20140701限制
					/*
						rdShowMessageDialog("月结类专票的打印时间为20140701后!");
						sel1();
					*/

				}
				function sel3()
				{
					//alert("2");
					document.getElementById("s_flag_qry").value="3";
					document.all.yxl_begin.style.display="none";
					document.all.yxl_end.style.display="none";
					document.all.yjl.style.display="block";

					
					//xl 去掉20140701限制
					/*
						rdShowMessageDialog("月结类专票的打印时间为20140701后!");
						sel1();
					*/

				}
				//限制 当s_qry_flag=1时为营销类 月结的单选框不可用
				function inits(s_qry_flag)
				{
					sel2();
					document.getElementById("radio2").checked=true;
			 
					//alert("end 2");

				}
		</script>
		
		</HEAD>



		<body onload="inits(<%=s_qry_flag%>)">


		 
		 

		
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">请选择打印方式</div>
		</div>

			  <table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" width="15%">打印方式</td>
							<td colspan="3">
								<!--
								<q vType="setNg35Attr">
								<input name="busyType1" id="radio1" type="radio" onClick="sel1()" value="1">
								营销购机类增值税专票打印
								</q>
								</q>
								<q vType="setNg35Attr">
								<input name="busyType1" id="radio3" type="radio" onClick="sel3()" value="3" >
								一点支付增值税专票打印
								</q> 
								-->
								<q vType="setNg35Attr">
								<input name="busyType1" id="radio2" type="radio" onClick="sel2()" value="4" >
								月结增值税专票打印
								
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">手机号码</td>
							<td colspan="3">
							<!--<input type="text" name="phone_no"   maxlength=11 value="20210058797">-->
								<input type="text" name="phone_no" readonly   maxlength=11 value="<%=phone_no%>">
								
								</q>
								 
							</td>
						</tr>
						 
							<tr id="yxl_begin">
								<td class="blue" width="15%" >查询开始时间(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="begindate" readonly maxlength=8 value="<%=begin_dt%>">
									</q>
								</td>
							</tr>
							<tr id="yxl_end">
								<td class="blue" width="15%">查询结束时间(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="enddate" readonly maxlength=8 value="<%=end_dt%>">
									</q>
									 
								</td>
							</tr>
					 
						 
							<tr id="yjl">
								<td class="blue" width="15%">月结发票打印开始年月(YYYYMM)</td>
								<td >
									<input type="text" name="yj_date" readonly maxlength=6 value="<%=ret_ch[0][1]%>" >
									</q>
								</td>
								<td class="blue" width="15%">月结发票打印结束年月(YYYYMM)</td>
								<td >
									<input type="text" name="yj_end_date" readonly maxlength=6 value="<%=ret_ch[0][2]%>" >
									</q>
								</td>
							</tr>
							
					 
					</tbody>
				</table>

				<table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" colspan=6>购方单位信息展示</td>
							 
						</tr>
						<tr>
							<td class="blue" width="15%">纳税人名称</td>
							<td>
								<input type="text" name="tax_name" readonly  value="<%=tax_name%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">纳税人识别号</td>
							<td>
								<input type="text" name="tax_no1"    value="<%=tax_no1%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">地址</td>
							<td>
								<input type="text" name="tax_address" readonly  value="<%=tax_address%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">电话</td>
							<td>
								<input type="text" name="tax_phone" readonly  value="<%=tax_phone%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">开户行</td>
							<td>
								<input type="text" name="tax_khh" readonly  value="<%=tax_khh%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">账号</td>
							<td>
								<input type="text" name="tax_contract_no" readonly  value="<%=tax_contract_no%>">
								</q>
								 <input type="hidden" name="s_notes" value="<%=s_notes%>">
							</td>
						</tr>
						<!--增加备注信息展示-->
						<tr>
							<td class="blue" width="15%">备注信息</td>
							<td colspan=3>
								<input type="text" name="s_notes"    value="<%=s_notes%>">
								</q>
								 
							</td>
						</tr>
					</tbody>
				</table>

				<table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
					  <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
						  &nbsp;
						  <!--<input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >-->
							<input type="button" name="return1" class="b_foot" value="返回" onclick="history.go(-1)" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
					 
					  </td>
					</tr>
				  </table>
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="s_flag_qry" value="<%=s_qry_flag%>">	<!--判断是按照月结2还是营销1-->		
				

		<%@ include file="/npage/include/footer.jsp" %>
		</form>
		</BODY>
	</HTML>

</FORM>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("流水记录不存在!");
				window.location.href="zgb8_1.jsp";
			</script>
		<%
	}
	%>
