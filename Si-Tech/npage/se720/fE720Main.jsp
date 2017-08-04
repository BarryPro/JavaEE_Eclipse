<%
/*
 * 功能: 购机入网-让利计划
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>


<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String	saleType	="49";
String	opCode		=request.getParameter("opCode");
String	opName		=request.getParameter("opName");
String	loginNo		=(String)session.getAttribute("workNo");
String	loginName	=(String)session.getAttribute("workName");
String	loginNoPass	=(String)session.getAttribute("password");
String	orgCode		=(String)session.getAttribute("orgCode");
String	regCode		=(String)session.getAttribute("regCode");
String	groupId		=(String)session.getAttribute("groupId");
String	phoneNo		=(String)request.getParameter("activePhone");

/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
String op_strong_pwd = (String) session.getAttribute("password");
/* liujian 安全加固修改 2012-4-6 16:18:13 end */
%>	
<wtc:sequence	name="TlsPubSelCrm"	key="sMaxSysAccept"	
	routerKey="region" routerValue="<%=regCode%>"	id="loginAccept" />
<%	
/*获取品牌名称*/	
String	sqlSelect1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) "
	+"FROM dphonesalecode a, schnresbrand b"
	+" WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code"
	+" AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
String	srvParams1 = "region_code=" + regCode + ",sale_type=" + saleType;
%>
<wtc:service name="TlsPubSelCrm" outnum="2">
	<wtc:param value="<%=sqlSelect1%>"/>
	<wtc:param value="<%=srvParams1%>"/>
</wtc:service>
<wtc:array id="brandResult" scope="end"/>

<%
/*取手机型号*/
String sqlSelect2 = "select unique a.type_code,trim(b.res_name), b.brand_code "
	+"from dphoneSaleCode a,schnrescode_chnterm b	"
	+"where a.region_code=:region_code and  a.type_code=b.res_code "
	+"and a.brand_code=b.brand_code  and a.valid_flag='Y' and a.sale_type=:sale_type";
String srvParams2 = "region_code=" + regCode + ",sale_type=" + saleType;
%>		
<wtc:service name="TlsPubSelCrm" outnum="3">
	<wtc:param value="<%=sqlSelect2%>"/>
	<wtc:param value="<%=srvParams2%>"/>
</wtc:service>
<wtc:array id="resultType" scope="end"/>
	
<%
StringBuffer brandSb = new StringBuffer("");
brandSb.append("<option value ='-1'>请选择</option>");
for(int i=0; i<brandResult.length; i++) {
	  brandSb.append("<option value ='").append(brandResult[i][0]).append("'>")
					 .append(brandResult[i][1])
					 .append("</option>");
}

/*取用户信息*/
String	inputPrm[]	= new String[4];
inputPrm[0]			= phoneNo;
inputPrm[1]			= loginNo;
inputPrm[2]			= orgCode;
inputPrm[3]			= opCode;
%>
<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=phoneNo%>" 
	retcode="retCode2" retmsg="retMsg2" outnum="29">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputPrm[2]%>"/>
</wtc:service>
<wtc:array id="tempArr"  scope="end"/>
<%
String	bp_name			="";
String	sm_code			="";
String	family_code		="";
String	rate_code		="";
String	bigCust_flag	="";
String	sm_name			="";
String	rate_name		="";
String	bigCust_name	="";
String	next_rate_code	="";
String	next_rate_name	="";
String	lack_fee		="";
String	prepay_fee		="";
String	bp_add			="";
String	cardId_type		="";
String	cardId_no		="";
String	cust_id			="";
String	cust_belong_code="";
String	group_type_code	="";
String	group_type_name	="";
String	imain_stream	="";
String	next_main_stream="";
String	hand_fee		="";
String	favorcode		="";
String	card_no			="";
String	print_note		="";
String	contract_flag	="";
String	high_flag		="";
String	passwordFromSer	="";
String	retFlag			="";
String	errCode			="";
String	errMsg			="";
if(tempArr.length==0)
{
	retFlag = "1";
	retMsg = "查询号码基本信息为空!";
}
else	if(retCode2.equals("000000") && tempArr.length>0)
{
	bp_name			=tempArr[0][3];		//机主姓名
	bp_add			=tempArr[0][4];		//客户地址
	passwordFromSer	=tempArr[0][2];		//密码
	sm_code			=tempArr[0][11];	//业务类别
	sm_name			=tempArr[0][12];	//业务类别名称
	hand_fee		=tempArr[0][13];	//手续费
	favorcode		=tempArr[0][14];	//优惠代码
	rate_code		=tempArr[0][5];		//资费代码
	rate_name		=tempArr[0][6];		//资费名称
	next_rate_code	=tempArr[0][7];		//下月资费代码
	next_rate_name	=tempArr[0][8];		//下月资费名称
	bigCust_flag	=tempArr[0][9];		//大客户标志
	bigCust_name	=tempArr[0][10];	//大客户名称
	lack_fee		=tempArr[0][15];	//总欠费
	prepay_fee		=tempArr[0][16];	//总预交
	cardId_type		=tempArr[0][17];	//证件类型
	cardId_no		=tempArr[0][18];	//证件号码
	cust_id			=tempArr[0][19];	//客户id
	cust_belong_code=tempArr[0][20];	//客户归属id
	group_type_code	=tempArr[0][21];	//集团客户类型
	group_type_name	=tempArr[0][22];	//集团客户类型名称
	imain_stream	=tempArr[0][23];	//当前资费开通流水
	next_main_stream=tempArr[0][24];	//预约资费开通流水
	print_note		=tempArr[0][25];	//工单广告
	contract_flag	=tempArr[0][27];	//是否托收账户
	high_flag		=tempArr[0][28];	//是否中高端用户	
}
else
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=retCode2%>:<%=retMsg2%>",0);
		history.go(-1);
	</script>
<%
}
/*查资费名称*/
String sqlSelect3 = "select offer_name from product_offer where offer_id =:rate_code";
String srvParams3 = "rate_code=" + rate_code;
%>
<wtc:service	name="TlsPubSelCrm"	outnum="1"
	retmsg="msg1"	retcode="code1"	routerKey="region"	routerValue="<%=regCode%>">
	<wtc:param value="<%=sqlSelect3%>"/>
	<wtc:param value="<%=srvParams3%>"/>
</wtc:service>
<wtc:array id="resultOfferName" scope="end"/>
<%
if(!code1.equals("000000")&&!code1.equals("0"))
{%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=code1%>:<%=msg1%>",0);
		history.go(-1);
	</script>
<%
}
else
{
	if(resultOfferName.length>0&&resultOfferName[0][0]!=null)
	{
		rate_name = resultOfferName[0][0];
	}
	else
	{%>
		<script language="JavaScript">
			rdShowMessageDialog("资费名称为空！",0);
			history.go(-1);
		</script>
  	<%
  	}
}%>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>		
<script>
		$(function() {		
			/*************************初始化表格信息*****************************/
			$('#oCustName').val('<%=bp_name%>');
			$('#oSmName').val('<%=sm_name%>');
			$('#oModeName').val('<%=rate_name%>');
			$('#oPrepayFee').val('<%=prepay_fee%>');
			$('#oMarkPoint').val('<%=print_note%>');
			//设置手机品牌的下拉列表
			$('#phone_brand').append("<%=brandSb.toString()%>");
			//获得手机型号对象
			/*
			 *对象类型
			[
				brandCode1:{code1:name1,code2:name2}
		    brandCode2:{code1:name1,code2:name2}
		  ]
				*/
			var phone_types = [];
			<%
			 for(int i=0;i<resultType.length;i++) {
			%>
					if(typeof phone_types[<%= resultType[i][2]%>] == 'undefined') {
						phone_types[<%= resultType[i][2]%>] = {};
					}
					var typeObj = phone_types[<%= resultType[i][2]%>];
					typeObj['<%= resultType[i][0]%>'] = '<%= resultType[i][1]%>'
			<% 		
			 }
			%>
			/*************************切换手机品牌*****************************/
			$('#phone_brand').change(function() {
					//获得手机品牌
					var brand = $('#phone_brand').val();
					//把所有设置成空
					$("#phone_type").empty();
					$("#sale_ways").empty();
					$("#mode_sale").empty();
					if(brand == -1 || brand == '-1'){
						reset();
						return;
					}
					
					$("#phone_type").append('<option value ="-1">请选择</option>');
					$.each(phone_types[brand],function(n,ele){
								$("<option value="+n+">"+ele+"</option>").appendTo($("#phone_type"));
					});
				});
				
				/*************************切换型号，需要往后台发请求*****************************/
				$('#phone_type').change(function() {
						//获得手机品牌
						var typeCode = $('#phone_type').val();
						//把营销方案和新主资费成空
						$("#sale_ways").empty();
						$("#mode_sale").empty();
						if(typeCode == -1 || typeCode == '-1'){
							reset();
							return;
						}
					
						$('#p3').val($('#phone_type').val());
						 var packet = new AJAXPacket("fE720Ajax.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=saleType%>");
						 _data.add("brand_code",$('#phone_brand').val());
						 _data.add("type_code",typeCode);
						 _data.add("method","apply_getSaleWays");
						 core.ajax.sendPacket(packet,getSaleWaysProcess);
						 packet = null;
				});
				
				/*************************切换营销方案，需要往后台发请求****************************/
				$('#sale_ways').change(function() {
						var sale_code = $('#sale_ways').val();
						//把所有设置成空
						$("#mode_sale").empty();
						if(sale_code == -1 || sale_code == '-1'){
							reset();
							return;
						}
						 var packet = new AJAXPacket("fE720Ajax.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=saleType%>");
						 _data.add("sale_code",sale_code);
						 _data.add("method","apply_getModeSale");
						 core.ajax.sendPacket(packet,getModeSaleProcess);
						 packet = null;
				});
				
				/*************************切换自主资费，需要往后台发请求****************************/
				$('#mode_sale').change(function() {
						var sale_code = $('#sale_ways').val();
						var mode_sale = $('#mode_sale').val();
						if(mode_sale == -1 || mode_sale == '-1'){
							reset();
							return;
						}
						 $('#new_Mode_Name').val($('#mode_sale').find("option:selected").text());
						 var packet = new AJAXPacket("fE720Ajax.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=saleType%>");
						 _data.add("sale_code",sale_code);
						 _data.add("mode_code",mode_sale);
						 _data.add("method","apply_getPayInfo");
						 core.ajax.sendPacket(packet,getPayInfoProcess);
						 packet = null;
				});
				
				//默认情况下，不验证IMEI码，不能点击提交按钮
				$('#next_step').attr('disabled','disabled');
				/*************************提交按钮注册事件****************************/
				$('#next_step').click(function() {
				//	printCommit();
					frmCfm();	
				})
				/*************************清除按钮注册事件****************************/
				$('#reset_btn').click(function() {
						$('#phone_brand').val("-1");
						$('#phone_brand').change();
						$('#phoneOther').val('');
						$('#IMEINo').val('');
				})
				
		})
	/*************************清除手机费用input的值****************************/	
	function reset() {
		$('#prepay_limit').val(''); //底线预存
		$('#cashPay').val(''); //底线预存
		$('#prepay_gift').val('');  //活动预存
		$('#mon_base_fee').val(''); //月赠送预存款
		$('#consume_term').val(''); //业务有效期
		$('#active_term').val('');  //拆包期限
		$('#sale_price').val('');   //用户缴费合计
		$('#sale_name').val('');
		$('#free_fee').val('');
		$('#base_fee').val('');
		$('#sale_name_span').text('');
	}
	/*************************切换型号，ajax返回的营销方案数据****************************/
	function getSaleWaysProcess(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				//填充营销方案数据
				var txt = '<option value="-1" >--请选择--</option>';
				for(var i=0,len=result.length;i<len;i++) {
					txt += '<option value="' + result[i].code + '">';
					txt +=     result[i].name;
					txt += '</option>'
				}
				$('#sale_ways').append(txt);
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	/*************************切换营销方案，ajax返回的自主资费数据****************************/
	function getModeSaleProcess(package) {
	  	var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				//填充营销方案数据
				var txt = '<option value="-1" >--请选择--</option>';
				for(var i=0,len=result.length;i<len;i++) {
					txt += '<option value="' + result[i].code + '">';
					txt +=     result[i].name;
					txt += '</option>'
				}
				$('#mode_sale').append(txt);
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	/*************************切换自主资费，ajax返回的手机付费数据****************************/
	function getPayInfoProcess(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				$('#prepay_limit').val(result.prepay_limit); //底线预存
				$('#cashPay').val(result.prepay_limit); //应收金额=底线预存
				$('#prepay_gift').val(result.prepay_gift);   //活动预存
				$('#mon_base_fee').val(result.mon_base_fee); //月赠送预存款
				$('#consume_term').val(result.consume_term); //业务有效期
				$('#free_fee').val(result.free_fee); //
				$('#base_fee').val(result.base_fee); //
				$('#active_term').val(result.active_term);   //拆包期限
				$('#sale_price').val(result.sale_price);     //用户缴费合计
				$('#i16').val($('#mode_sale').val());
				if(result.sale_name != null && result.sale_name != "") {
					$('#sale_name_span').text(result.sale_name + '--');
					$('#sale_name').val(result.sale_name + '--');
				}
			 $('#mon_prepay_limit').val(result.mon_prepay_limit);
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	
	/*************************验证IMEI****************************/
	function checkimeino() {
		if($('#IMEINo').val().length == 0)
		{
			rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
			document.fE720MainForm.IMEINo.focus();
			$('#next_step').attr('disabled','disabled');
			return false;
		}else if($('#IMEINo').val().length != 15) {
			rdShowMessageDialog("IMEI号码应为15位，请重新输入 !!");
			document.fE720MainForm.IMEINo.focus();
			$('#next_step').attr('disabled','disabled');
			return false;
		}
		else if(!new RegExp(/^[0-9]{15}$/).test($.trim($('#IMEINo').val())))
		{
			rdShowMessageDialog("IMEI号码应为15位数字，请重新输入 !!");
			document.fE720MainForm.IMEINo.focus();
			$('#next_step').attr('disabled','disabled');
			return false;
		}

		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se720/fE720Ajax.jsp","正在校验IMEI信息，请稍候......");
		packet.data.add("method",'apply_checkIMEI');
		packet.data.add("imei_no",$.trim($('#IMEINo').val()));
		packet.data.add("brand_code",$('#phone_brand').val());
		packet.data.add("type_code",$('#phone_type').val());
		core.ajax.sendPacket(packet);

		packet=null;
	}
	
	// 获得并设置IMEI
	function doProcess(packet) {
		var  retResult=packet.data.findValueByName("retcode");
		if(retResult == "000000"){
				rdShowMessageDialog("IMEI号校验成功！",2);
				$('#next_step').removeAttr('disabled');
				$('#IMEINo').attr('readonly','readonly');
				return ;

		}else if(retResult == "000001"){
				rdShowMessageDialog("IMEI号校验成功2！",2);
				document.fE720MainForm.next_step.disabled=false;
				document.fE720MainForm.IMEINo.readOnly = true;
				return ;

		}else if(retResult == "000003"){
				rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
				document.fE720MainForm.next_step.disabled=true;
				return false;
		}else if(retResult == "000004"){
				rdShowMessageDialog("此IMEI号已经办理过，不能再次办理！");
				document.fE720MainForm.next_step.disabled=true;
				return false;
		}else{
				rdShowMessageDialog("IMEI号不存在或者已经使用！");
				document.fE720MainForm.next_step.disabled=true;
				return false;
		}
 }
 
  function viewConfirm(){
		if(document.fE720MainForm.IMEINo.value==""){
			document.fE720MainForm.next_step.disabled=true;
		}
	}
	
	function check() {
		var phone_brand = $('#phone_brand').val();
		var phone_type = $('#phone_type').val();
		var sale_ways = $('#sale_ways').val();
		var mode_sale = $('#mode_sale').val();
		if(phone_brand == -1) {
			rdShowMessageDialog("请选择手机品牌！");
			return false;	
		}else if(phone_type == -1) {
			rdShowMessageDialog("请选择手机类型！");
			return false;	
		}else if(sale_ways == -1) {
			rdShowMessageDialog("请选择营销方案！");
			return false;	
		}else if(mode_sale == -1) {
			rdShowMessageDialog("请选择新主资费！");
			return false;	
		}
		return true;
	}
	
	
function frmCfm() {
		//拼接一系列参数
		/*
		if(!forInt(document.fE720MainForm.phoneOther)){
			rdShowMessageDialog("必须输入数字!",0);
			return false;
		};*/
		
		
		
		 var str =$('#sale_ways').val()    + "|" + /*iSaleCode|*/
			$('#phone_brand').find('option:selected').text() + "|" + /*iBrandName|*/
			$('#phone_type').find('option:selected').text()  + "|" + /*iTypeName|*/
			$('#prepay_limit').val() + "|" + 	/*缴费金额*/
			 "0|" +   /*iBaseFee*/
			$('#consume_term').val() + "|" + 	/*合约期限*/
			$('#free_fee').val()   + "|" +  	/*优惠总金额|*/
			$('#active_term').val()  + "|" +	/*	|拆包期限*/
			$('#base_fee').val() +"|"+ 			/*|优惠比例*/
			$('#phoneOther').val() + "|" +  
			$('#IMEINo').val()       + "|" ;	
		
		$('#iAddStr').val(str);

		$('#ip').val($('#mode_sale').val());
		$('#do_note').val($('#op_note').val());
		fE720MainForm.submit();
}
	</script>
</head>
<form name="fE720MainForm" method="POST" action ="../bill/f1270_3.jsp">
<%@ include file="/npage/include/header.jsp" %>
<div id="opr">
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">手机号码</td>
		<td>
			<input	class="InputGrey"	type="text"	name="phoneNo"
				id="phoneNo"	value="<%=activePhone%>"	readonly />
		</td>
		<td class="blue">机主姓名</td>
		<td>
			<input	class="InputGrey"	type="text"	name="oCustName"
				id="oCustName"	value="<%=bp_name%>"	readonly />
		</td>
	</tr>	
	<tr>
		<td class="blue">业务品牌</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oSmName"
				id="oSmName"	value="<%=sm_name%>"	readonly />
		</td>
		<td class="blue">资费名称</td>
		<td>
			<input	class="InputGrey"	type="text"	name="oModeName"
				id="oModeName"	value="<%=rate_name%>"	readonly />
		</td>
	</tr>	
	<tr>
		<td class="blue">帐号预存</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oPrepayFee"
				id="oPrepayFee"	value="<%=prepay_fee%>"	readonly />		
		</td>
		<td class="blue">当前积分</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oMarkPoint"
				id="oMarkPoint"	value="<%=print_note%>"	readonly />			
		</td>
	</tr>	
	
	<tr> 
		<td class="blue">手机品牌</td>
		<td> 
			<select id="phone_brand">
			</select>
		</td>
		<td class="blue">手机类型 </td>
		<td> 
			<select id="phone_type">				
			</select>
		</td>
	</tr>  
	<tr> 
		<td class="blue">营销方案</td>
		<td> 
			<select id="sale_ways">
			</select>
		</td>
		<td class="blue">新主资费 </td>
		<td> 
			<select id="mode_sale">
			</select>
		</td>
	</tr> 	
	
	
	<tr>
		<td class="blue">拆包期限</td>
		<td>
			<input name="active_term" type="text" class="InputGrey" 
				id="active_term"  readonly />
			<input type="hidden" name="sale_name" id="sale_name" >		
		</td>
		<td class="blue">IMEI码</td>
		<td>
			<input name="IMEINo" id="IMEINo" class="button" type="text" 
				v_type="0_9" v_name="IMEI码"  maxlength=15 value="" 
				onblur="viewConfirm()">
			<input name="checkimei" class="b_text" type="button" 
			value="校验" onclick="checkimeino()" >
			<font color="orange">*</font>		
		</td>
	</tr>
	<tr>
		<td class="blue">现金预存</td>
		<td>		
			<input name="prepay_limit" type="text" 
				class="InputGrey" id="prepay_limit"  readonly />
			<input name="mon_prepay_limit" type="hidden" 
				class="InputGrey" id="mon_prepay_limit"  readonly />
		</td>
		<td class="blue">合约期限</td>
		<td>
			<input class="InputGrey" type="text" id="consume_term" 
				name="consume_term" readonly />		
		</td>
	</tr>		
	<tr>
		<td class="blue">总优惠额度</td>
		<td>		
			<input class="InputGrey" type="text" id="free_fee" 
				name="free_fee" readonly />	
		</td>
		<td class="blue">优惠比例(%)</td>
		<td>		
			<input class="InputGrey" type="text" id="base_fee" 
				name="base_fee" readonly />	
		</td>
	</tr>				
	<tr>
	  <%/*%>
		<td class="blue"> 绑定人手机号</td>
		<td >			
			<input class="" type="text" id="phoneOther" 
				name="phoneOther"  maxlength=11 />(联通/电信手机号码)			
		</td>
		<%*/%>
		<td class="blue"> 应收金额</td>
		<td colspan="3">			
			<input  class="InputGrey"  type="text" id="cashPay" 
				name="cashPay"  />	
		  <input type="hidden" id="phoneOther" name="phoneOther" value="" />		
		</td>
	</tr>		
	<tr>
        <td class="blue">
					<div align="left">缴费方式</div>
				</td>
				<td colspan ="3">
					<select name="payType" >
						<option value="0" checked>现金缴费</option>
						<option value="BX">建设银行POS机缴费</option>
						<option value="BY">工商银行POS机缴费</option>
					</select>
				</td>
	</tr>	
	<tr>
		<td class="blue">操作备注</td>
		<td colspan="3">
			<input name="op_note" type="text" size="80" v_maxlength=60 id="op_note" 
				value="购机入网-让利计划" />
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="next_step" 
				id="next_step" value="下一步">    
			<input class="b_foot" type=button name="reset_btn" 
				id="reset_btn" value="清除"">
			<input class="b_foot" type=button name="closeBtn" value="关闭" 
				onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</div>

<!--以下部分是为调f1270_3.jsp所定义的参数
	i2:客户ID
	i16:当前主套餐代码
	ip:申请主套餐代码
	belong_code:belong_code
	print_note:工单广告词
	iAddStr:

	i1:手机号码
	i4:客户名称
	i5:客户地址
	i6:证件类型
	i7:证件号码
	i8:业务品牌

	ipassword:密码
	group_type:集团客户类别
	ibig_cust:大客户类别
	do_note:用户备注
	favorcode:手续费优惠权限
	maincash_no:现主套餐代码（老）
	imain_stream:当前主资费开通流水
	next_main_stream:预约主资费开通流水

	i18:下月主套餐
	i19:手续费
	i20:最高手续费
	-->
	<input type="hidden" name="i2" value="<%=cust_id%>"> <!-- 客户id -->
	<input type="hidden" name="i16" value="<%=rate_code%>"> <!-- 资费代码 -->
	<input type="hidden" name="iOpCode" value="<%=opCode%>"> <!-- opCode -->
	<input type="hidden" name="ip" id="ip" value=""> <!-- 新主资费 -->
	<input type="hidden" name="belong_code" value="<%=cust_belong_code%>"> <!-- 客户归属id-->
	<input type="hidden" name="print_note" value="<%=print_note%>"> <!--服务中获取 工单广告-->
	<input type="hidden" name="iAddStr"  id="iAddStr" value="">
	
	<input type="hidden" name="i1" value="<%=activePhone%>"> <!--phoneNo -->
	<input type="hidden" name="i4" value="<%=bp_name%>"> <!-- 机主姓名 -->
	<input type="hidden" name="i5" value="<%=bp_add%>"> <!-- 机主地址 -->
	<input type="hidden" name="i6" value="<%=cardId_type%>"> <!-- 证件类型 -->
	<input type="hidden" name="i7" value="<%=cardId_no%>"> <!-- 证件号码 -->
	<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>"> <!--服务中 ??这个是opCode 和 opName? -->
	<input type="hidden" name="i9" value="<%=contract_flag%>"> <!--服务中 是否托收账户-->
	
	
	<input type="hidden" name="ipassword" value="">
	<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
	<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
	<input type="hidden" name="do_note" id="do_note" value="">
	<input type="hidden" name="favorcode" value="<%=favorcode%>">
	<input type="hidden" name="maincash_no" value="<%=rate_code%>">
	<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
	<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
	
	<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
	<input type="hidden" name="i19" value="<%=hand_fee%>">
	<input type="hidden" name="i20" value="<%=hand_fee%>">
	<input type="hidden" name="cus_pass" value=""> <!-- 是否可以不用传值 -->
	
	<input type="hidden" name="mode_type" value="">
	<input type="hidden" name="new_Mode_Name" id="new_Mode_Name" value="">
	<input type="hidden" name="return_page" value="/npage/se720/fE720Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>">
	<input type="hidden" name="sale_kind" value="">
	<input type="hidden" name="main_phoneno" value="">
	<input type="hidden" name="printAccept" value="<%=loginAccept%>">
	<input type="hidden" name="opName" value="<%=opName%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
	
</body>
</html>