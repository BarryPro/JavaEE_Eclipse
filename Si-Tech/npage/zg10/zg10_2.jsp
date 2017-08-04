<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zg10";
    String opName = "集团自由划拨";
	String contract_no=request.getParameter("contract_no");
	
	String[] inParas2 = new String[2];
	String[] inParas_show = new String[2];
	String s_grp_fee="";
	String s_grp_name="";
	String s_grp_sms_name="";
	String begin_tm = request.getParameter("begin_time");
	String end_tm = request.getParameter("end_time");
	//查询集团可用预存的sql
 
	//inParas_show[0]="select to_char(a.prepay_fee),a.bank_cust,c.cust_name from dconmsg a,dgrpusermsg b,dcustdoc c where a.contract_no=:con and a.contract_no = b.account_id and b.cust_id = c.cust_id ";
	inParas_show[0]="select to_char(a.prepay_fee),trim(d.bank_cust),trim(c.cust_name) from dconmsgpre a,dgrpusermsg b,dcustdoc c,dconmsg d where a.contract_no=:con and a.contract_no = b.account_id and a.contract_no = d.contract_no and b.cust_id = c.cust_id and a.pay_type='0' ";
	inParas_show[1]="con="+contract_no;
	//inParas2[0]="select to_char(a.phone_no),to_char(a.f_should_money),to_char(b.contract_no),to_char(b.prepay_fee),b.bank_cust ,to_char(a.login_accept) from wgroupchargecfg a,dconmsg b where a.group_contract_no = b.contract_no and b.contract_no=:contract_no";
	inParas2[0]="select to_char(a.phone_no),to_char(a.f_should_money),to_char(b.contract_no),to_char(b.prepay_fee),b.bank_cust ,to_char(a.login_accept),d.run_name,to_char(c.limit_owe) from wgroupchargecfg a,dconmsg b ,dcustmsg c,sruncode d where a.group_contract_no = :contract_no  and a.phone_no = c.phone_no and b.contract_no=c.contract_no and substr(c.run_code,2,1) = d.run_code and substr(c.belong_code,0,2) = d.region_code ";
	inParas2[1]="contract_no="+contract_no;//+",d1="+begin_tm+",d2="+end_tm;
	
	int i_count=0;
	
	//xl add for huxl
	String[] inParas_sum = new String[2];
	inParas_sum[0]="select to_char(sum(f_should_money)) from wgroupchargecfg where group_contract_no = :con   ";
	inParas_sum[1]="con="+contract_no;
	String s_sum_should="";
	Float f_sum_should= new Float(0.0f);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
 <HEAD><TITLE>集团自由划拨</TITLE>
	<script language="javascript">
		function doQry(i_count)
		{
			var group_no_id = document.getElementById("group_no_id").value;
			var group_no_pay = document.getElementById("group_no_pay").value;
			var group_name = document.getElementById("group_name").value;
			var group_accept = document.getElementById("group_accept").value;
			//alert("1 "+group_accept+" andgroup_acceptgroup_no_pay is "+group_no_pay+" and group_name is "+group_name);
			var s_sum_should  = document.getElementById("s_sum_should").value;
			var prtFlag=0;

			//xl add 比较集团可充值金额和 个人的总金额
			//group_no_pay=23; 
			//alert("group_no_pay is "+group_no_pay+" and s_sum_should is "+s_sum_should);
			if(i_count>200)
			{
				rdShowMessageDialog("充值号码不能超过200个，请删除后重新上传！");
				return false;
			}
			else if(parseFloat(group_no_pay) < parseFloat(s_sum_should))
			{
				rdShowMessageDialog("现金账本可转余额不足，请缴费后再划拨!");
				return false;
			}
			else
			{
				prtFlag =rdShowConfirmDialog("是否确定划拨?");
				if (prtFlag==1){
				document.frm1508_2.action="zg10_3.jsp?group_no_id="+group_no_id+"&group_no_pay="+group_no_pay+"&group_accept="+group_accept;
				document.frm1508_2.submit();
				}else{ 
					return false;
			 }
			}
			
		}
		function doDel()
		{
			var prtFlag=0;
			var group_no_id = document.getElementById("group_no_id").value;
			var group_no_pay = document.getElementById("group_no_pay").value;
			var group_name = document.getElementById("group_name").value;
			var group_accept = document.getElementById("group_accept").value;

			prtFlag =rdShowConfirmDialog("本操作将删除集团账号"+group_no_id+ "下所有待充值的手机号码,是否确定删除?");
			if (prtFlag==1){
			document.frm1508_2.action="zg10_6.jsp?group_no_id="+group_no_id;
			//alert(document.frm1508_2.action);
			document.frm1508_2.submit();
			}else{ 
				return false;
			}
		}
		function doQry2()
		{
			//alert("2");
			var group_no_id = document.getElementById("group_no_id").value;
			var group_no_pay = document.getElementById("group_no_pay").value;
			var group_name = document.getElementById("group_name").value;
			var group_accept = document.getElementById("group_accept").value;
			document.frm1508_2.action="zg10_4.jsp?group_no_id="+group_no_id+"&group_no_pay="+group_no_pay+"&group_accept="+group_accept;
			document.frm1508_2.submit(); 
		}
		
	</script>
 </HEAD>
 <body>

<FORM method=post name="frm1508_2">

<wtc:service name="TlsPubSelBoss" retcode="retCode6" retmsg="retMsg6" outnum="1">
		<wtc:param value="<%=inParas_sum[0]%>"/>
		<wtc:param value="<%=inParas_sum[1]%>"/>
</wtc:service>
<wtc:array id="ret_val_sum" scope="end" />
<%
	if(ret_val_sum.length>0)
	{
		s_sum_should=ret_val_sum[0][0];
 
	}
%>

<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="3">
		<wtc:param value="<%=inParas_show[0]%>"/>
		<wtc:param value="<%=inParas_show[1]%>"/>
</wtc:service>
<wtc:array id="ret_val_grp" scope="end" />
<%
	if(ret_val_grp.length>0)
	{
		s_grp_fee=ret_val_grp[0][0];
		s_grp_name=ret_val_grp[0][1];
		s_grp_sms_name=ret_val_grp[0][2];
	}
%>

<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="8">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	System.out.println("zg01 ccccccccccccccccccccccccccc "+ret_val.length);
	if(ret_val.length>0)
	{
	%>
	
		
		
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>

			  <table cellspacing="0" id = "PrintA">
						<tr> 
						  <th>集团账号</th>
						  <th>集团产品名称</th>
						  <th>集团预存</th> 
						  <th>被充值手机号码总数</th>
						</tr>
			 
						<tr>
							<td align="center"><%=contract_no%></td>
						
							<td align="center"><%=s_grp_name%></td>
							<td align="center"><%=s_grp_fee%></td>
							<td align="center"><%=ret_val.length%></td>
					 <input type="hidden" id="group_no_id" value="<%=contract_no%>">
					 <input type="hidden" id="s_sum_should" value="<%=s_sum_should%>">
					 
					 <input type="hidden" id="group_name" name="group_name" value="<%=s_grp_sms_name%>">	
					 <input type="hidden" id="group_no_pay" value="<%=s_grp_fee%>">	
					 <input type="hidden" id="group_accept" value="<%=ret_val[0][5]%>">
						</tr>
			 
				  </table>
				  <table cellspacing="0" id = "PrintA">
				  <tr> 
						  <th>被充值手机号码</th>
						  <th>被充值金额</th>
						  <th>被充值手机号码状态</th>
					 
						</tr>
					<%
						
		 
						for(int i=0;i<ret_val.length;i++)
						{
						 
							%>
								<tr>
									<td align="center"><%=ret_val[i][0]%></td>
									<td align="center"><%=ret_val[i][1]%></td>
									<td align="center"><%=ret_val[i][6]%></td>
									 
								</tr>
							<%
						}
					%>		
							
				  <tr id="footer"> 
					<td colspan="9">
					  <input class="b_foot" name=query onClick="doQry('<%=ret_val.length%>')" type=button value=划拨>
					  <input class="b_foot" name=del onClick="doDel()" type=button value=删除>
					  
					   
					  <input class="b_foot" name=back onClick="window.location.href='zg10_1.jsp'" type=button value=返回>
					</td>
				  </tr>
				  
			  </table>
			  
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="id_contractNo">			
				

		<%@ include file="/npage/include/footer.jsp" %>
		
	<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询失败!");
				window.location.href="zg10_1.jsp";
			</script>
		<%
	}
%>

</FORM>
</BODY>
</HTML>
