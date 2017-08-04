<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
 
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode = "zg23";
		String opName = "增值税专票开具申请";
		String workno = (String)session.getAttribute("workNo");
		
		String q_flag = request.getParameter("q_flag");
		//获取纳税人信息
		String tax_name = request.getParameter("tax_name");
		String tax_no1 = request.getParameter("tax_no1");
		String tax_address = request.getParameter("tax_address");
		String tax_phone = request.getParameter("tax_phone");
		String tax_khh = request.getParameter("tax_khh");
		String tax_contract_no = request.getParameter("tax_contract_no");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String s_kpserver="";
		 
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaa regionCode is "+regionCode);
		//xl add 月结类专票
		String yj_date = request.getParameter("yj_date"); 
		String begindate = request.getParameter("begindate");
		String enddate = request.getParameter("enddate");
		//局方提供配置信息表
 
		String[] inParas_sp = new String[2];
		inParas_sp[0]="select a.login_no,login_name from Staxinvoice_login_sp a,dloginmsg b where   a.login_no=b.login_no and region_code=:s_region_code and op_code='zg25' ";//工号写死为aavt26
		inParas_sp[1]="s_region_code="+regionCode;
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas_sp[0]%>"/>
	<wtc:param value="<%=inParas_sp[1]%>"/> 
</wtc:service>
<wtc:array id="ret_sp" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
 

 function doclear() {
 		frm.reset();
 }
 
 function doPrint(i_count)
 {
	  var s_tax_id = "<%=tax_no1%>";
	  var i_rate_count = i_count; 
	  var s_phone_no = document.getElementById("phone_no").value;
	  var f_money = 0;
	  var begindate = "<%=begindate%>";
	  var enddate = "<%=enddate%>";
	  var spr = document.all.spr[document.all.spr.selectedIndex].value;
	  var lxr_phone = document.all.lxr_phone.value;
	  var lxr_phone2 = document.all.lxr_phone2.value;
	  //alert(spr);
	  if(i_rate_count=="0")
	  {
		  rdShowMessageDialog("无专票打印信息!");
		  return false;
	  }
	  else if(spr=="0")
	  {
		  rdShowMessageDialog("请选择审批人工号!");
		  return false;
	  }	
	  else if(lxr_phone=="")
	  {
		  rdShowMessageDialog("请输入审批人手机号码!");
		  return false;
	  }	
	  //xl add for 二次确认
	  else if(lxr_phone2=="")
	  {
		  rdShowMessageDialog("请再次输入审批人手机号码!");
		  return false;
	  }
	  else if(lxr_phone!=lxr_phone2)
	  {
		  rdShowMessageDialog("两次审批人手机号码输入不一致,请核对后重新输入!");
		  return false;
	  }
	  else
	  {
		  var prtFlag=0;
		  prtFlag=rdShowConfirmDialog("是否确定提交申请?");
		  if (prtFlag==1)
		  {
			 // alert("1 入表 在zg12时先查询这个表是否有记录 "+s_tax_id+" and i_rate_count is "+i_rate_count);
			 document.frm.action="zg23_cfm.jsp?s_tax_id="+s_tax_id+"&s_phone_no="+s_phone_no+"&begindate="+begindate+"&enddate="+enddate+"&spr="+spr+"&lxr_phone="+lxr_phone+"&tax_name="+"<%=tax_name%>"+"&tax_no1="+"<%=tax_no1%>"+"&tax_address="+"<%=tax_address%>"+"&tax_phone="+"<%=tax_phone%>"+"&tax_khh="+"<%=tax_khh%>"+"&tax_contract_no="+"<%=tax_contract_no%>"+"&q_flag="+"<%=q_flag%>";//用新的页面 直接入表做审核
			 //alert(document.frm.action);
			 document.frm.submit();
		  }
		  else
		  {
			  return false;
		  } 	
		  
		  
	  }	
	 
	  
  }
</script> 
 
	 
<%
	 
	 
	
	
	String dateStr="";
	 
	//inParas2[0]="select substr(goodsname,0,10),trim(scales),trim(units),to_char(units_money),to_char(small_money),to_char(tax_rate),to_char(tax_money),to_char(tax_invoice_tax_count) from dinvoicecntt where tax_invoice_num='2' ";
	//phone_no="13503685502";
 
	String nopass = (String)session.getAttribute("password");
	String phone_no = request.getParameter("phone_no");

 
 
	String[] inParas2 = new String[11];
	//inParas2[0]="select substr(goodsname,0,10),trim(scales),trim(units),to_char(units_money),to_char(small_money),to_char(tax_rate),to_char(tax_money),to_char(tax_invoice_tax_count) from dinvoicecntt where tax_invoice_num='2' ";
	//phone_no="13503685502";
	inParas2[0]="";//流水
	inParas2[1]="02";
	inParas2[2]="zg12";
	inParas2[3]=workno;
	inParas2[4]=nopass;
	inParas2[5]=phone_no;
	inParas2[6]="";
	inParas2[7]="专票开具";
	inParas2[8]=dateStr;
	inParas2[9]=begindate;
	inParas2[10]=enddate;
%>
<wtc:service name="bs_yxPrintInit" retcode="retCode2" retmsg="retMsg2" outnum="15">
	<wtc:param value="<%=inParas2[0]%>"/> 
	<wtc:param value="<%=inParas2[1]%>"/>
	<wtc:param value="<%=inParas2[2]%>"/> 
	<wtc:param value="<%=inParas2[3]%>"/> 
	<wtc:param value="<%=inParas2[4]%>"/> 
	<wtc:param value="<%=inParas2[5]%>"/> 
	<wtc:param value="<%=inParas2[6]%>"/> 
	<wtc:param value="<%=inParas2[7]%>"/> 
	<wtc:param value="<%=inParas2[8]%>"/> 
	<wtc:param value="<%=inParas2[9]%>"/> 
	<wtc:param value="<%=inParas2[10]%>"/>
	<wtc:param value="1"/> 
</wtc:service>
<wtc:array id="ret_code" scope="end" start="0"  length="4" />
<wtc:array id="ret_mx" scope="end" start="4"  length="10" />
<wtc:array id="ret_rate" scope="end" start="14"  length="1" /> 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
 
<input type="hidden" name="tax_name" value="<%=tax_name%>">
<input type="hidden" name="tax_no1" value="<%=tax_no1%>">
<input type="hidden" name="tax_address" value="<%=tax_address%>">
<input type="hidden" name="tax_phone" value="<%=tax_phone%>">
<input type="hidden" name="tax_khh" value="<%=tax_khh%>">
<input type="hidden" name="tax_contract_no" value="<%=tax_contract_no%>">
<%
 
 
	
	if(retCode2=="000000" ||retCode2.equals("000000"))
	{
		%>
		 <!--xl add 查询-->

		<input type="hidden" id="invoice_code">	
		<input type="hidden" id="invoice_number">
				<%@ include file="/npage/include/header.jsp" %>   
			<div class="title">
					<div id="title_zi">请输入查询条件</div>
				</div>
		 
		  <table cellSpacing="0">
			<tr>
				<th width="12.5%">货物名称</th>
				<th width="12.5%">规格型号</th>
				<th width="12.5%">单位</th>
				<th width="12.5%">数量</th>
				<th width="12.5%">单价</th>
				<th width="12.5%">金额</th>
				<th width="12.5%">税率</th>
				<th width="12.5%">税额</th>
				
			 
			</tr>
			<%
				int i_rate_count=Integer.parseInt(ret_rate[0][0]);//xuxza接口提供
				for(int i=0;i<ret_mx.length;i++)
				{
					%>
						<tr>
							<td width="12.5%"><%=ret_mx[i][0]%></td>
							<td width="12.5%"><%=ret_mx[i][1]%></td>
							<td width="12.5%"><%=ret_mx[i][2]%></td>
							<td width="12.5%"><%=ret_mx[i][3]%></td>
							<td width="12.5%"><%=ret_mx[i][4]%></td>
							<td width="12.5%"><%=ret_mx[i][5]%></td>
							<td width="12.5%"><%=ret_mx[i][6]%></td>
							<td width="12.5%"><%=ret_mx[i][7]%></td>
					 
						</tr>
						<input type="hidden" id="goods_name<%=i%>" value="<%=ret_mx[i][0]%>">
						<input type="hidden" id="ggxh<%=i%>" value="<%=ret_mx[i][1]%>">
						<input type="hidden" id="dw<%=i%>" value="<%=ret_mx[i][2]%>">
						<input type="hidden" id="sl<%=i%>" value="<%=ret_mx[i][3]%>">
						<input type="hidden" id="dj<%=i%>" value="<%=ret_mx[i][4]%>">
						<input type="hidden" id="je<%=i%>" value="<%=ret_mx[i][5]%>">
						<input type="hidden" id="tax_rate<%=i%>" value="<%=ret_mx[i][6]%>">
						<input type="hidden" id="tax_money<%=i%>" value="<%=ret_mx[i][7]%>">
						 
						
					<%
				}
				 
			%>
			
			<%
				if(ret_mx.length>0)
				{
					%>
						<tr>
							<td colspan=8>
								审批人 <select name="spr" id="sprid" >
								<option value="0" selected>---请选择---</option>
								<%for(int i=0; i<ret_sp.length; i++){%>
								<option value="<%=ret_sp[i][0]%>">
								
								<%=ret_sp[i][0]%>--><%=ret_sp[i][1]%></option>
								<%}%>

							</select>

							 
						</tr>
						<tr>
							<td colspan=8>审批人联系电话：<input type="text" name="lxr_phone" maxlength="11"> 
							请再次输入手机号码：<input type="text" name="lxr_phone2" maxlength="11"></td>
						</tr>
					 	<tr>
							<td colspan=8 align="left"><input type="button" name="return1" class="b_foot" value="提交申请" onclick="doPrint(<%=i_rate_count%>)" ></td>
						</tr>
					<%
				}
				
			%>
			<input type="hidden" value="<%=i_rate_count%>">
			<input type="hidden" id="lz_fphm">
			<input type="hidden" id="lz_fpdm"> 
			<input type="hidden" id="begindate" value="<%=begindate%>">
			<input type="hidden" id="enddate" value="<%=enddate%>">
			<input type="hidden" id="phone_no" value="<%=phone_no%>">
			<input type="hidden" id="yj_date" value="<%=yj_date%>">
			
		 
			<tr> 
			  <td id="footer" colspan=8> 
			    
			 
				 
				  <!--
				  <input type="button" name="return1" class="b_foot" value="专票补打" onclick="rePrint()" >
				  &nbsp;-->
				  <input type="button" name="return1" class="b_foot" value="返回" onclick="window.location.href='zg23_1.jsp'" >
				  &nbsp;
				  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
			  </td>
			</tr>
		  </table>
		<%
	}
	else
	{
		%>
			<script>		
				rdShowMessageDialog('<%=retCode2%>:<%=retMsg2%>',0);
				document.location.replace('zg23_1.jsp');
			</script>
		<%
	}
%>

	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>