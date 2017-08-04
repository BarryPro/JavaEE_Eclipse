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
		String opCode = "zgbg";
		String opName = "增值税专票开具申请";
		String workno = (String)session.getAttribute("workNo");
		String s_qry_op_code=opCode;
		String phone_no = request.getParameter("phoneNo"); 
		//获取纳税人信息
		String tax_no = request.getParameter("s_tax_no");
		String tax_name = request.getParameter("s_tax_name");
		String tax_address = request.getParameter("s_tax_address");
		String tax_phone = request.getParameter("s_tax_phone");
		String tax_khh = request.getParameter("s_tax_khh");
		String tax_contract_no = request.getParameter("s_tax_contract");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String s_kpserver="";
		String begindate = request.getParameter("ym");
		String enddate = request.getParameter("ym"); 
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaa regionCode is "+regionCode);
		//xl add 月结类专票
		String yj_date = request.getParameter("ym"); 
		//xl add 月结合打
		String yj_end_date = request.getParameter("ym"); 
		//局方提供配置信息表
 
		String[] inParas_sp = new String[2];
		inParas_sp[0]="select a.login_no,login_name from Staxinvoice_login_sp a,dloginmsg b where   a.login_no=b.login_no and region_code=:s_region_code and op_code='zg25' ";//工号写死为aavt26
		inParas_sp[1]="s_region_code="+regionCode;
		//查询已提交的金额
		String[] inParas_je = new String[2];
		inParas_je[0]="select to_char(sum(se)) from DINVOICE_TAX_split where phone_no=:s_no and tax_no=:s_tax_no ";
		inParas_je[1]="s_no="+phone_no+",s_tax_no="+tax_no;
		String s_sum_ykj="";
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode3" retmsg="retMsg3" outnum="1">
	<wtc:param value="<%=inParas_je[0]%>"/>
	<wtc:param value="<%=inParas_je[1]%>"/> 
</wtc:service>
<wtc:array id="ret_je" scope="end" />
<%
	if(ret_je.length>0)
	{
		s_sum_ykj=ret_je[0][0];
	}
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
	  var s_tax_id = "<%=tax_no%>";
	  var i_rate_count = i_count; 
	  var s_phone_no = document.getElementById("phone_no").value;
	  var f_money = 0;
	  var begindate = "<%=yj_date%>";
	 // var yj_end_date = "<%=yj_end_date%>";

	  var enddate = "<%=yj_end_date%>";
	  var spr = document.all.spr[document.all.spr.selectedIndex].value;
	  var lxr_phone = document.all.lxr_phone.value;
	  var lxr_phone2 = document.all.lxr_phone2.value;//2次确认
	  //alert(spr);
	  var bzxx = document.all.bzxx.value;//备注信息
	//  i_rate_count=1;
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
		  prtFlag=rdShowConfirmDialog("开票人工号是"+spr+",联系电话是"+lxr_phone+",备注信息为"+bzxx+",是否确定提交申请?");
		  if (prtFlag==1)
		  {
			 // alert("1 入表 在zg12时先查询这个表是否有记录 "+s_tax_id+" and i_rate_count is "+i_rate_count);
			 document.frm.action="";//用新的页面 直接入表做审核
			 //alert(document.frm.action);
			 document.frm.submit();
		  }
		  else
		  {
			  return false;
		  } 	
		  
		  
	  }	
	 
	  
  }
  function docals(size,zk)//数组长度 折扣的长度
  {
	  var sl = document.all.sl.value;
	  var dj = document.all.dj.value;
	  var s_input="";
	  var s_se ="";
	  var s_get_sl="";
	  var s_se_zk="";
	  var s_final_se="";
	  var s_final_se_zk="";
	  var s_final_cal="";//计算后的税额
	  var hwmc = document.all.hwmc.value;
	  if(sl!="0.06" &&sl!="0.11")
	  {
		  rdShowMessageDialog("输入的税率不合法!税率只能是0.06和0.11!");
		  return false;
	  }	
	  else
	  {
		  for(var i=0;i<size;i++)
		  {
			  s_se= document.getElementById("tax_money"+i).value;
			  s_get_sl  = document.getElementById("tax_rate"+i).value;
			  //alert("test here :sl is "+sl+" and s_input_sl is "+s_get_sl);
			  if(s_get_sl==sl)
			  {
				  //alert("i is "+i+" and s_se is "+s_se+" and sl is "+sl);
				  s_final_se=s_se;
			  }	
			  
		  }	
		  //计算折扣的
		  for(var j=0;j<zk;j++)
		  {
			  s_se_zk= document.getElementById("tax_money_zk"+j).value;
			  s_input_sl_zk  = document.getElementById("tax_rate_zk"+j).value;
			  //alert("test here :sl is "+sl+" and s_input_sl is "+s_input_sl);
			  if(s_input_sl_zk==sl)
			  {
				  //alert("j is "+j+" and s_se_zk is "+s_se_zk+" and sl is "+sl);
				  s_final_se_zk=s_se_zk;
			  }	
			  
		  }
		  s_input=Number(sl)*Number(dj);
		  s_final_cal=Number(s_final_se)+Number(s_final_se_zk);
		  document.all.s_final_cal.value=s_final_cal;
		 
		 // alert("final s_final_se is "+s_final_se+" and s_final_se_zk is "+s_final_se_zk+" and s_final_cal is "+s_final_cal+" and s_input is "+s_input);
		  if(hwmc=="")
		  {
			  rdShowMessageDialog("请输入货物名称!");
			  return false;
		  }	
		  else if(dj=="")
		  {
			  rdShowMessageDialog("请输入单价!");
			  return false;
		  }
		  else
		  {
			  //alert("s_sum_ykj is "+"<%=s_sum_ykj%>");
			  //本次金额+已开具金额 <= 可开具的金额
			  /*
			  if(Number(s_input)+Number("<%=s_sum_ykj%>")<=s_final_cal)
			  {
				 document.all.se.value=s_input.toFixed(2);
				 document.all.docfm.disabled=false;
			  }
			  else
			  {
				  rdShowMessageDialog("该产品号码下此纳税人识别号码可开具金额小于配置金额!");
				  return false;
			  }	
			  */
			  document.all.se.value=s_input.toFixed(2);
			  document.all.docfm.disabled=false;
		  }	
	  }	
  }
  function dotj()
  {
	var s_phone_no = "<%=phone_no%>";
	var s_tax_no =document.all.tax_no1.value;
	var s_tax_name =document.all.tax_name.value;
	var s_tax_address =document.all.tax_address.value;
	var s_tax_phone =document.all.tax_phone.value;
	var s_tax_khh =document.all.tax_contract_no.value;
	var s_tax_zh =document.all.tax_no1.value;
	var s_begin_ym ="<%=begindate%>";
	var s_end_ym = s_begin_ym;
	var s_spr =document.all.spr[document.all.spr.selectedIndex].value; ;
	var s_spr_phone =document.all.lxr_phone.value ;
	var s_hwmc= document.all.hwmc.value;
	var s_dj= document.all.dj.value;
	var s_sl= document.all.sl.value;
	var s_je= document.all.se.value;
	var s_sl_je=document.all.s_final_cal.value;//传入的可拆分金额 不要前台算了 前台的税率没法取
	var bzxx = document.all.bzxx.value;//备注信息
	//预开or正常开
	var kj_flag = document.all.kjbz[document.all.kjbz.selectedIndex].value;
	//非空性校验
	if(s_spr=="0")
	{
		rdShowMessageDialog("请选择审批人!");
		return false;
	}
	else if(s_spr_phone=="")
	{
		rdShowMessageDialog("请输入审批人电话!");
		return false;
	}
	else
	{
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("是否确定提交?");
		if (prtFlag==1)
		{
			var myPacket = new AJAXPacket("zgbg_cfm.jsp","正在提交，请稍候......");
			//校验产品号码是否申请审批通过 校验通过后调用专票查询接口
			myPacket.data.add("s_phone_no",s_phone_no);
			myPacket.data.add("s_tax_no",s_tax_no);
			myPacket.data.add("s_tax_name",s_tax_name);
			myPacket.data.add("s_tax_address",s_tax_address);
			myPacket.data.add("s_tax_phone",s_tax_phone);
			myPacket.data.add("s_tax_khh",s_tax_khh);
			myPacket.data.add("s_tax_zh",s_tax_zh);
			myPacket.data.add("s_begin_ym",s_begin_ym);
			myPacket.data.add("s_end_ym",s_end_ym);
			myPacket.data.add("s_spr",s_spr);
			myPacket.data.add("s_spr_phone",s_spr_phone);
			myPacket.data.add("s_hwmc",s_hwmc);
			myPacket.data.add("s_dj",s_dj);
			myPacket.data.add("s_sl",s_sl);
			myPacket.data.add("s_je",s_je);
			myPacket.data.add("s_sl_je",s_sl_je);
			myPacket.data.add("bzxx",bzxx);
			myPacket.data.add("kj_flag",kj_flag);
			core.ajax.sendPacket(myPacket,doPosSubInfo3);
			myPacket=null;
		}
		else
		{
			return false;
		}
	}	
  }
   function doPosSubInfo3(packet)
   {
	 //alert("2");
	 var s_flag =  packet.data.findValueByName("s_flag");
	 var s_msg = packet.data.findValueByName("s_msg");
	 alert("s_flag is "+s_flag+" and s_msg is "+s_msg);
	 if(s_flag=="0")
	 {
		 rdShowMessageDialog("提交成功!");
		 //状态置为之前的
		 document.all.docfm.disabled=true;
		 document.all.hwmc.value="";
		 document.all.dj.value="";
		 document.all.sl.value="";
		 document.all.se.value="";
	 }	
	 else
	 {
		 rdShowMessageDialog("提交失败!错误原因:"+s_msg);
		 document.all.docfm.disabled=true;
		 document.all.hwmc.value="";
		 document.all.dj.value="";
		 document.all.sl.value="";
		 document.all.se.value="";
	 }	
   }
</script> 
 
	 
<%
	String nopass = (String)session.getAttribute("password");
	

	
	
	String dateStr="";
	String[] inParas2 = new String[11];
	//inParas2[0]="select substr(goodsname,0,10),trim(scales),trim(units),to_char(units_money),to_char(small_money),to_char(tax_rate),to_char(tax_money),to_char(tax_invoice_tax_count) from dinvoicecntt where tax_invoice_num='2' ";
	//phone_no="13503685502";
	inParas2[0]="";//流水
	inParas2[1]="02";
	inParas2[2]=s_qry_op_code;//"zg12";
	inParas2[3]=workno;
	inParas2[4]=nopass;
	inParas2[5]=phone_no;
	inParas2[6]="";
	inParas2[7]="月结专票开具";
	inParas2[8]=dateStr;
	inParas2[9]=yj_date;
	inParas2[10]=yj_end_date;
	 
%>
<wtc:service name="bs_TaxMmInit" retcode="retCode2" retmsg="retMsg2" outnum="14">
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
</wtc:service>
<wtc:array id="ret_code" scope="end" start="0"  length="2" />
<wtc:array id="ret_mx" scope="end" start="2"  length="4" />
<wtc:array id="ret_zk" scope="end" start="6"  length="4" />
<wtc:array id="ret_rate" scope="end" start="10"  length="4" />
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
<input type="hidden" name="s_final_cal" > 
<input type="hidden" name="tax_name" value="<%=tax_name%>">
<input type="hidden" name="tax_no1" value="<%=tax_no%>">
<input type="hidden" name="tax_address" value="<%=tax_address%>">
<input type="hidden" name="tax_phone" value="<%=tax_phone%>">
<input type="hidden" name="tax_khh" value="<%=tax_khh%>">
<input type="hidden" name="tax_contract_no" value="<%=tax_contract_no%>">
<%
 
 
	//retCode2="000000";
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
				
				for(int i=0;i<ret_mx.length;i++)
				{
					%>
						<tr>
							<td width="12.5%"><%=ret_mx[i][0]%></td>
							<td width="12.5%"></td>
							<td width="12.5%"></td>
							<td width="12.5%">1</td>
							<td width="12.5%"><%=ret_mx[i][1]%></td>
							<td width="12.5%"><%=ret_mx[i][1]%></td>
							<td width="12.5%"><%=ret_mx[i][2]%></td>
							<td width="12.5%"><%=ret_mx[i][3]%></td>
						
						<input type="hidden" id="goods_name<%=i%>" value="<%=ret_mx[i][0]%>">
						<input type="hidden" id="dj<%=i%>" value="<%=ret_mx[i][1]%>">
						<input type="hidden" id="je<%=i%>" value="<%=ret_mx[i][1]%>">
						<input type="hidden" id="tax_rate<%=i%>" value="<%=ret_mx[i][2]%>">
						<input type="hidden" id="tax_money<%=i%>" value="<%=ret_mx[i][3]%>">
						</tr>
						 
						
					<%
				}
				//折扣
				for(int i=0;i<ret_zk.length;i++)
				{
					 
					%>
						<tr>
							<td width="12.5%"><%=ret_zk[i][0]%></td>
							<td width="12.5%"></td>
							<td width="12.5%"></td>
							<td width="12.5%">1</td>
							<td width="12.5%"><%=ret_zk[i][1]%></td>
							<td width="12.5%"><%=ret_zk[i][1]%></td>
							<td width="12.5%"><%=ret_zk[i][2]%></td>
							<td width="12.5%"><%=ret_zk[i][3]%></td>
						<input type="hidden" id="goods_name_zk<%=i%>" value="<%=ret_zk[i][0]%>">
						<input type="hidden" id="dj_zk<%=i%>" value="<%=ret_zk[i][1]%>">
						<input type="hidden" id="je_zk<%=i%>" value="<%=ret_zk[i][1]%>">
						<input type="hidden" id="tax_rate_zk<%=i%>" value="<%=ret_zk[i][2]%>">
						<input type="hidden" id="tax_money_zk<%=i%>" value="<%=ret_zk[i][3]%>">
						</tr>
						 
						
					<%
					
				}
				String s_6="";
				String s_11="";//计算出加上折扣后的 分税率的可打印总金额是多少
				int i_rate_count=Integer.parseInt(ret_rate[0][3]);//xuxza接口提供
				
			%>
			<!--拆分信息 begin-->
			<table cellSpacing="0">
			<div class="title">
				<div id="title_zi">信息拆分</div>
			</div>
			<tr>
				<td colspan="3">纳税人识别号码:<%=tax_no%></td>
				<td colspan="4">纳税人名称:<%=tax_name%></td>
			</tr>
			<tr>
				<td colspan="3">地址:<%=tax_address%></td>
				<td colspan="4">电话:<%=tax_phone%></td>
			</tr>
			<tr>
				<td colspan="3">开户行:<%=tax_khh%></td>
				<td colspan="4">账号:<%=tax_contract_no%></td>
			</tr>
			<tr>
				<td><b>产品号码</b></td>
				<td><b>货物名称</b></td>
				<td><b>单价</b></td>
				<td><b>税率</b></td>
				<td><b>税额</b></td>
				<td>开具标志</td>
				<td><b>操作</b></td>
			</tr>
			<tr>
				<td><%=phone_no%></td>
				<td><input type="text" name="hwmc"></td>
				<td><input type="text" name="dj"  onKeyPress="return isKeyNumberdot(1)"></td>
				<td><input type="text" name="sl" onKeyPress="return isKeyNumberdot(1)" >&nbsp;<input type="button" class="b_foot" value="计算" name="docal" onclick="docals('<%=ret_mx.length%>','<%=ret_zk.length%>')"></td>
				<td><input type="text" name="se" readonly></td>
				<td><select name="kjbz">
						<option value="0">正常开具</option>
						<option value="1">欠费预开</option>
					</select></td>
				<td><input type="button" class="b_foot" value="提交" name="docfm" onclick="dotj()" disabled></td>
				 
			</tr>

			<tr>
				<td colspan=8>
					审批人 <select name="spr" id="sprid" >
					<option value="0" selected>---请选择---</option>
					<%for(int i=0; i<ret_sp.length; i++){%>
					<option value="<%=ret_sp[i][0]%>">
					
					<%=ret_sp[i][0]%>--><%=ret_sp[i][1]%></option>
					<%}%>

				</select>

				
				</td>
			</tr>
			<tr>
				<td colspan=8>审批人联系电话：<input type="text" name="lxr_phone" maxlength="11"> 
				</td>
			</tr>
			<tr>
				<td colspan=8>备注信息：<input type="text" name="bzxx" size=100  > 
			 </td>
			</tr>
			</table>
			<!--end of 拆分信息-->
			
						 
					
			<input type="hidden" value="<%=i_rate_count%>">
			<input type="hidden" id="lz_fphm">
			<input type="hidden" id="lz_fpdm"> 
			<input type="hidden" id="begindate" value="<%=begindate%>">
			<input type="hidden" id="enddate" value="<%=enddate%>">
			<input type="hidden" id="phone_no" value="<%=phone_no%>">
			<input type="hidden" id="yj_date" value="<%=yj_date%>">
			<!--xl add for 月结合打-->
			<input type="hidden" id="yj_end_date" value="<%=yj_end_date%>">

			<input type="hidden" id="print_sum_money" value="<%=ret_rate[0][0]%>">
			<input type="hidden" id="print_accept" value="<%=ret_rate[0][1]%>">
			<input type="hidden" id="print_ym" value="<%=ret_rate[0][2]%>">
			<tr> 
			  <td id="footer" colspan=8> 
			    
			 
				 
				  <!--
				  <input type="button" name="return1" class="b_foot" value="专票补打" onclick="rePrint()" >
				  &nbsp;-->
				  <input type="button" name="return1" class="b_foot" value="返回" onclick="window.location.href='zgbg_1.jsp'" >
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
				rdShowMessageDialog('zgbg报错,<%=retCode2%>:<%=retMsg2%>',0);
				history.go(-1);
				//document.location.replace('zg23_1.jsp');
			</script>
		<%
	}
%>

	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>