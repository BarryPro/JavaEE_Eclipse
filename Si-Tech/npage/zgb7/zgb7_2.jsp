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
    String opCode = "zgb7";
    String opName = "增值税发票开具申请";
	String s_flag=request.getParameter("s_flag");
	String phone_no = request.getParameter("phone_no");
	String[] inParas2 = new String[2];
	
	//获取纳税人信息
	String tax_name = request.getParameter("tax_name");
	String tax_no1 = request.getParameter("tax_no1");
	String tax_address = request.getParameter("tax_address");
	String tax_phone = request.getParameter("tax_phone");
	String tax_khh = request.getParameter("tax_khh");
	String tax_contract_no = request.getParameter("tax_contract_no");
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr_yyyymm=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dateStr_yyyymm is "+dateStr_yyyymm);
	
	
%>
<html>
<FORM method=post name="frm1508_2">

		<HEAD><TITLE>增值税发票打印</TITLE>
	
			<script language="javascript">
				function docheck()
				{
					var q_flag = document.getElementsByName("busyType1");
					var q_value;
					for(var i=0;i<q_flag.length;i++)
					{ 
						if(q_flag[i].checked)
						{
                            q_value = q_flag[i].value;
                        }
					}
					//alert("q_flag is "+q_value);
					if(q_value=="1")//营销类
					{ 
						//alert("营销类"); 
						document.frm1508_2.action="../zg23/zg23_yx.jsp";//用新的页面 直接入表做审核
						document.frm1508_2.submit();
					} 
					else if(q_value=="2" || q_value=="3")//月结类 一点支付
					{ 
						//alert("月结类"); 
						var yj_date = document.all.yj_date.value;
						var yj_end_date = document.all.yj_end_date.value;
						if(yj_date=="" || yj_end_date=="")
						{
							rdShowMessageDialog("请输入查询开始、结束年月!");
						}
						else
						{
							document.frm1508_2.action="../zg23/zg23_yj.jsp";//增加传递s_type_flag 1=营销类 2=月结类
							document.frm1508_2.submit();
						}
						
					} 
					else
					{
						rdShowMessageDialog("月结类专票的打印开始时间为20140701!");
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
					document.getElementById("s_flag_qry").value="2";
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
		</script>
		
		</HEAD>



		<body onload="sel1()">


		 
		 

		
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">请选择打印方式</div>
		</div>

			  <table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" width="15%">打印方式</td>
							<td colspan="3">
								<q vType="setNg35Attr">
								<input name="busyType1" type="radio" onClick="sel1()" value="1" checked>
								营销购机类增值税专票打印
								</q>
								<q vType="setNg35Attr">
								<input name="busyType1" type="radio" onClick="sel2()" value="2" >
								月结增值税专票打印
								</q>
								<q vType="setNg35Attr">
								<input name="busyType1" type="radio" onClick="sel3()" value="3" >
								一点支付增值税专票打印
								</q> 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">产品号码</td>
							<td colspan="3">
								<input type="text" name="phone_no"    maxlength=11 value="<%=phone_no%>">
								</q>
								 
							</td>
						</tr>
						 
							<tr id="yxl_begin">
								<td class="blue" width="15%" >查询开始时间(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="begindate" maxlength=8 value="<%=dateStr%>">
									</q>
								</td>
							</tr>
							<tr id="yxl_end">
								<td class="blue" width="15%">查询结束时间(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="enddate" maxlength=8 value="<%=dateStr%>">
									</q>
									 
								</td>
							</tr>
					 
							<!--xl add for 月结增加年月段-->
							<tr id="yjl">
								<td class="blue" width="15%">专票打印开始年月(YYYYMM)</td>
								<td>
									<input type="text" name="yj_date" maxlength=6 value="<%=dateStr_yyyymm%>">
									</q>
								</td>
								<td class="blue" width="15%">专票打印结束年月(YYYYMM)</td>
								<td>
									<input type="text" name="yj_end_date" maxlength=6 value="<%=dateStr_yyyymm%>">
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
								<input type="text" name="tax_no1" readonly  value="<%=tax_no1%>">
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
								 
							</td>
						</tr>
					</tbody>
				</table>

				<table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
					  <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
						  &nbsp;
							<input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
					 
					  </td>
					</tr>
				  </table>
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="s_flag_qry" name="q_flag">	<!--判断是按照月结2还是营销1-->		
				

		<%@ include file="/npage/include/footer.jsp" %>
		</form>
		</BODY>
	</HTML>

</FORM>
