<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2011/12/12
   * 作者: liujian
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
  //待补充
	String sale_type = "47";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	//增加参数区分网站预约和前台办理ningtn
	String banlitype =request.getParameter("banlitype");
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	//String loginNoPass = (String)session.getAttribute("password");
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	//lj. 绑定参数
	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) FROM dphonesalecode a, schnresbrand b WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;
	//
	//获取品牌名称
%>
	<wtc:service name="TlsPubSelCrm" outnum="2">
		<wtc:param value="<%=sql_select1%>"/>
		<wtc:param value="<%=srv_params1%>"/>
	</wtc:service>
	<wtc:array id="result_brand" scope="end"/>
<%
	StringBuffer brandSb = new StringBuffer("");
	brandSb.append("<option value ='-1'>请选择</option>");
	for(int i=0; i<result_brand.length; i++) {
		  brandSb.append("<option value ='").append(result_brand[i][0]).append("'>")
						 .append(result_brand[i][1])
						 .append("</option>");
	}
	
	//获取所有的手机型号
	//lj. 绑定参数
	String sql_select2 = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b  where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code  and a.valid_flag='Y' and a.sale_type=:sale_type";
	String srv_params2 = "region_code=" + regionCode + ",sale_type=" + sale_type;
	
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="TlsPubSelCrm" outnum="3">
		<wtc:param value="<%=sql_select2%>"/>
		<wtc:param value="<%=srv_params2%>"/>
	</wtc:service>
	<wtc:array id="result_type" scope="end"/>


<%
	String  inputParsm[] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = opCode;
	System.out.println("----------orgCode=" + orgCode +"------------phoneNO === "+ iPhoneNo);
	System.out.println("----------loginNo=" + loginNo +"------------opCode === "+ opCode);
%>

  <wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="29">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
		
<%
	System.out.println("----------liujian--------errCode2=" + retCode2);
  String errCode = retCode2;
  String errMsg = retMsg2;
  String  retFlag="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {

	    bp_name = tempArr[0][3];           //机主姓名

	    bp_add = tempArr[0][4];            //客户地址

	    passwordFromSer = tempArr[0][2];  //密码

	    sm_code = tempArr[0][11];         //业务类别

	    sm_name = tempArr[0][12];        //业务类别名称

	    hand_fee = tempArr[0][13];      //手续费

	    favorcode = tempArr[0][14];     //优惠代码

	    rate_code = tempArr[0][5];      //资费代码

	    rate_name = tempArr[0][6];     //资费名称

	    next_rate_code = tempArr[0][7];//下月资费代码

	    next_rate_name = tempArr[0][8];//下月资费名称

	    bigCust_flag = tempArr[0][9];//大客户标志

	    bigCust_name = tempArr[0][10];//大客户名称

	    lack_fee = tempArr[0][15];//总欠费

	    prepay_fee = tempArr[0][16];//总预交

	    cardId_type = tempArr[0][17];//证件类型

	    cardId_no = tempArr[0][18];//证件号码

	    cust_id = tempArr[0][19];//客户id

	    cust_belong_code = tempArr[0][20];//客户归属id

	    group_type_code = tempArr[0][21];//集团客户类型

	    group_type_name = tempArr[0][22];//集团客户类型名称

	    imain_stream = tempArr[0][23];//当前资费开通流水

	    next_main_stream = tempArr[0][24];//预约资费开通流水

	    print_note = tempArr[0][25];//工单广告

	    contract_flag = tempArr[0][27];//是否托收账户

	    high_flag = tempArr[0][28];//是否中高端用户
	    
	    
	    for(int m = 0 ; m<tempArr[0].length; m++){
	    	System.out.println("------lj-------tempArr[" + m + "]--------" + tempArr[0][m]);
	    }

	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 
	}
%>

<%
//******************查询资费名称***************************//
	//lj. 绑定参数
	String sql_select3 = "select offer_name from product_offer where offer_id =:rate_code";
	String srv_params3 = "rate_code=" + rate_code;
%>
<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql_select3%>"/>
		<wtc:param value="<%=srv_params3%>"/>
</wtc:service>
<wtc:array id="resultOffer_name" scope="end"/>
<%
  System.out.println("resultOffer_name"+resultOffer_name); 
	if(!code1.equals("000000")&&!code1.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("查询资费名称出错，错误代码：<%=code1%>，错误信息：<%=msg1%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if(resultOffer_name.length>0&&resultOffer_name[0][0]!=null)
		{
			rate_name = resultOffer_name[0][0];
		}
	  else
  	{%>
  	<script language="JavaScript">
			rdShowMessageDialog("资费名称为空！",0);
			history.go(-1);
		</script>
  	<%
  	}
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script>
	var bankInstalArr = new Array();
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
			 for(int i=0;i<result_type.length;i++) {
			%>
					if(typeof phone_types[<%= result_type[i][2]%>] == 'undefined') {
						phone_types[<%= result_type[i][2]%>] = {};
					}
					var typeObj = phone_types[<%= result_type[i][2]%>];
					typeObj['<%= result_type[i][0]%>'] = '<%= result_type[i][1]%>'
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
					setFeeMark(false);
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
						 var packet = new AJAXPacket("srv.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=sale_type%>");
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
						 var packet = new AJAXPacket("srv.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=sale_type%>");
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
						 var packet = new AJAXPacket("srv.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("sale_type","<%=sale_type%>");
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
						$('#IMEINo').val('');
				})
				//liujian add 
				$('#feeMark').change(function(e) {
					getMarkPoint();
					e.stopPropagation();
				});
				
		})
	/*************************清除手机费用input的值****************************/	
	function reset() {
		$('#prepay_limit').val('');
		$('#prepay_gift').val('');
		$('#consume_term').val('');
		$('#mon_base_fee').val('');
		$('#base_fee').val('');
		$('#sale_price').val('');
		$('#sale_price_source').val('');
		$('#active_term').val('');
		$('#sale_name').val('');
		$('#sale_name_span').text('');
	}
	/*************************切换型号，ajax返回的营销方案数据****************************/
	function getSaleWaysProcess(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				setFeeMark(false);
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
				setFeeMark(false);
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
				setFeeMark(true);
				$('#prepay_limit').val(result.prepay_limit);
				$('#prepay_gift').val(result.prepay_gift);
				$('#consume_term').val(result.consume_term);
				$('#mon_base_fee').val(result.mon_base_fee);
				/***购机款base_fee**/
				var baseFee = result.base_fee;
				$('#base_fee').val(result.base_fee);
				/**用户缴费合计(result.sale_price)**/
				var salePrice = result.sale_price;
				$('#sale_price').val(result.sale_price);
				$('#sale_price_source').val(result.sale_price);
				$('#active_term').val(result.active_term);
				$('#sale_name').val(result.sale_name);
				$('#i16').val($('#mode_sale').val());
				if(result.sale_name != null && result.sale_name != "") {
					$('#sale_name_span').text(result.sale_name + '--');
					$('#e505_sale_name').val(result.sale_name + '--');
				}
				$('#mon_prepay_limit').val(result.mon_prepay_limit);
				/*判断用户是否可以使用POS机分期付款 ningtn*/
				$("#instalTd").hide();
				$("#installmentTd").hide();
				checkInstal(baseFee,salePrice);
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	
	function checkInstal(vMachFee,vPrePay){
		/********
			两个入参
			vMachFee 购机款
			vPrePay 缴费合计
		*/
		/*先清一下缴费方式，并且初始化缴费方式*/
		$("#payType").find("option:gt(2)").remove();
		$("#payType")[0].selectedIndex=0;
		var v_regionCode = "<%=regionCode%>";
		var selectSql = "Select to_char(bank_code),to_char(bank_name),to_char(bank_paytype),to_char(instal_numbers),to_char(income_ratios) FROM ssaleinstal WHERE machine_fee <= :vMachFee AND begine_fee<=:vPrePay AND end_fee>:vPrepay and region_code in('"+v_regionCode+"','99') and func_code='e505'";
		var params = "vMachFee=" + vMachFee + ",vPrePay=" + vPrePay+ ",vPrePay=" + vPrePay;
		var getInstal_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","正在校验请稍候......");
		getInstal_Packet.data.add("selectSql",selectSql);
		getInstal_Packet.data.add("params",params);
		getInstal_Packet.data.add("wtcOutNum","5");
		core.ajax.sendPacket(getInstal_Packet,doQryInstalBack);
		getInstal_Packet = null;
	}
	function doQryInstalBack(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		var result = packet.data.findValueByName("result");
		if(retcode == "000000"){
			if(result.length > 0){
				/*证明有可以进行分期付款的配置*/
				bankInstalArr = result;
				/******
					同一银行的开始结束金额没有重叠
					所以如果有多条(大于一条)信息一定是多个银行
				*/
				$.each(bankInstalArr,function(i,n){
					var optionInsertStr = "<option value='"+ n[2] +"'>"+n[1]+"信用卡分期付款</option>";
					$("#payType").append(optionInsertStr);
				});
			}
		}
	}
	/*************************验证IMEI****************************/
	function checkimeino() {
	 if($('#IMEINo').val().length == 0){
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
     }
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
		myPacket.data.add("imei_no",$.trim($('#IMEINo').val()));
		myPacket.data.add("brand_code",$('#phone_brand').val());
		myPacket.data.add("style_code",$('#phone_type').val());
		myPacket.data.add("opcode",'<%=opCode%>');
		myPacket.data.add("retType","0");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	
	// 获得并设置IMEI
	function doProcess(packet) {
	    var vRetPage=packet.data.findValueByName("rpc_page");
			var retType=packet.data.findValueByName("retType");
			var verifyType = packet.data.findValueByName("verifyType");
			if(retType=="0"){
				var  retResult=packet.data.findValueByName("retResult");
				if(retResult == "000000"){
						rdShowMessageDialog("IMEI号校验成功！",2);
						$('#next_step').removeAttr('disabled');
						$('#IMEINo').attr('readonly','readonly');
						return ;
	
				}else if(retResult == "000001"){
						rdShowMessageDialog("IMEI号校验成功2！",2);
						document.frm.next_step.disabled=false;
						document.frm.IMEINo.readOnly = true;
						return ;
	
				}else if(retResult == "000003"){
						rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
						document.frm.next_step.disabled=true;
						return false;
				}else{
						rdShowMessageDialog("IMEI号不存在或者已经使用！");
						document.frm.next_step.disabled=true;
						return false;
				}
		}
	}
 
  	function viewConfirm(){
		if(document.frm.IMEINo.value==""){
			document.frm.next_step.disabled=true;
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
				phone_brand 手机品牌
				phone_type  手机类型
				sale_ways   营销方案
				mode_sale    新主资费
				prepay_limit：底线预存 (分月)
				prepay_gift：活动预存 （总和）
				consume_term：预存消费期限（月）
				mon_base_fee：月底线消费
				base_fee：用户购机款
				sale_price：用户缴费合计（应收金额）
				active_term:拆包期限（月）
				sale_name：阶段活动名称
		*/
		if(!check(document.frm) ) {
			return false;
		}
		/*
			如果选择的是分期付款的话
			增加分期付款分期数和贴息比例
		*/
		var payTypeVal = $("#payType").val();
		var instalNum = "";
		var instalIncome = "";
		if(payTypeVal != "0" && payTypeVal != "BX" && payTypeVal != "BY"){
			instalNum = $("input[@name='installmentList'][@checked]").val();
			instalIncome = $("input[@name='installmentList'][@checked]").attr("income");
		}
		 var str = $('#phone_brand').find('option:selected').text() + "|" +
					$('#phone_type').find('option:selected').text()   + "|" +
					$('#sale_ways').val()    + "|" +
					$('#mode_sale').val()    + "|" +
					$('#prepay_limit').val() + "|" +
					$('#prepay_gift').val()  + "|" +
					$('#consume_term').val() + "|" +
					$('#mon_base_fee').val() + "|" +
					$('#base_fee').val()     + "|" +
					$('#sale_price').val()   + "|" +
					$('#active_term').val()  + "|" +
					$('#sale_name').val()    + "|" +   
					$('#IMEINo').val()      + "|" + 
					$('#mon_prepay_limit').val() + "|" +
					$('#feeMark').val() + "|" +
					$('#pointMoney').val() +"|"+
					instalNum + "|" +
					instalIncome
					;
		$('#iAddStr').val(str);
		$('#ip').val($('#mode_sale').val());
		//"用户"+document.all.phoneNo.value+"办理合约计划购机营销案，营销代码："+$('#sale_ways').val()
		$('#do_note').val($('#op_note').val());
		frm.submit();
	}

	/*liujian 2012-7-26 13:51:44 add*/
	function getMarkPoint() {
		/*校验*/
		if(!checkElement(document.all.phoneNo)) return;
		if(!$('#phone_brand').val()) {
			rdShowMessageDialog("请选择手机品牌!");
			$('#phone_brand').focus();
			return false;
		}
		if(!$('#phone_type').val()) {
			rdShowMessageDialog("请选择手机型号!");
			$('#phone_type').focus();
			return false;
		}
		if(!$('#sale_ways').val()) {
			rdShowMessageDialog("请选择营销代码!");
			$('#sale_ways').focus();
			return false;
		}	
		var fm =  $('#feeMark').val();
		if(isNaN(fm)) {
			rdShowMessageDialog("消费积分必须是数字!");
			$('#feeMark').val("0");
			$('#feeMark').focus();
			return false;
		}
		/*指定Ajax调用页*/
		var packet = new AJAXPacket("fe505_ajax.jsp","请稍后...");
			
		/*给ajax页面传递参数*/
		packet.data.add("opCode","<%=opCode%>" );
		packet.data.add("phoneNo",document.all.phoneNo.value );
		/*购机款*/
		packet.data.add("machPrice",$('#base_fee').val());
		/*消费积分*/
		packet.data.add("markPoint",  parseInt($('#feeMark').val() ,10));
		
		/*调用页面,并指定回调方法*/
		core.ajax.sendPacket(packet,setMarkPoint,false);
		packet=null;
	}
	
	/*liujian 2012-7-26 13:55:30 add*/
	function setMarkPoint(packet) {
		/*Prepay_Fee 应收金额*/
		var rtCode=packet.data.findValueByName("rtCode"); 	
		var rtMsg=packet.data.findValueByName("rtMsg"); 		
		if ( rtCode=="000000" ) {
			/*积分对应的钱数*/
			var	rstMarkQry	=packet.data.findValueByName("rstMarkQry"); 
			/*表单赋值*/
			$('#pointMoney').val(rstMarkQry);
			var ppFee=$('#sale_price_source').val();
			
			/*应收金额-积分兑换的钱数*/
			ppFee=parseFloat(ppFee-rstMarkQry).toFixed(2);
			$('#sale_price').val(ppFee);
		}
		else {
			$('#feeMark').val('0');
			$('#pointMoney').val('0');
			$('#sale_price').val($('#sale_price_source').val());
			rdShowMessageDialog(rtCode+":"+rtMsg);
			return false;
		}
	}
	
	function setFeeMark(flag) {
		$('#feeMark').val('0');	
		if(flag) {
			$('#feeMark').removeClass("InputGrey").removeAttr('readonly');	
			
		}else {
			$('#feeMark').addClass("InputGrey").attr('readonly','readonly');		
		}
	}
	
	function changePayType(){
		var payTypeVal = $("#payType").val();
		if(payTypeVal != "0" && payTypeVal != "BX" && payTypeVal != "BY"){
			$.each(bankInstalArr,function(i,n){
				if(payTypeVal == n[2]){
					var tmpNumArr = n[3].substr(0,n[3].length-1).split("|");
					var tmpIncomeArr = n[4].substr(0,n[4].length-1).split("|");
					$("#installmentTd").empty();
					$.each(tmpNumArr,function(j,m){
						var tmpStr = "";
						if(j == 0){
							tmpStr = "<input type='radio' name='installmentList' value='"+m+"' income='"+tmpIncomeArr[j]+"' checked='checked'/>"+m+"期";
						}else{
							tmpStr = "<input type='radio' name='installmentList' value='"+m+"' income='"+tmpIncomeArr[j]+"'/>"+m+"期";
						}
						$("#installmentTd").append(tmpStr);
						$("#instalTd").show();
						$("#installmentTd").show();
					});
				}
			});
		}else{
			/*隐藏*/
			$("#instalTd").hide();
			$("#installmentTd").hide();
		}
	}

</script>
</head>
<body>
  <form name="frm" method="post" action="../bill/f1270_3.jsp">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span><%=opName%></div>
		</div>
		<table cellspacing="0">
			<tr>
				<td class="blue">手机号码</td>
				<td width="39%">
					<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=activePhone%>" id="phoneNo" maxlength=11 index="3" readonly />
				</td>
				<td class="blue">机主名称</td>
				<td>
					<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">业务品牌</td>
				<td width="39%">
					<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="" readonly>
				</td>
				<td class="blue">资费名称</td>
        <td>
					<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="" readonly>
				</td>
				
			</tr>
			<tr>
				<td class="blue">帐号预存</td>
				<td>
					<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="" readonly>
				</td>
				<td class="blue">当前积分</td>
				<td>
					<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="" readonly />
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
				<td class="blue">底线预存</td>
				<td>
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
					<input name="mon_prepay_limit" type="hidden" class="InputGrey" id="mon_prepay_limit"  readonly />
					<input name="mon_base_fee" type="hidden" class="InputGrey" id="mon_base_fee"  readonly />
				</td>
				<td class="blue">活动预存</td>
				<td width="39%">
					<input class="InputGrey" type="text" name="prepay_gift" id="prepay_gift" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">预存消费期限</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="consume_term" name="consume_term" readonly />
				</td>			
			<!--
				<td class="blue">月底线消费</td>
				<td>
					<input name="mon_base_fee" type="text" class="InputGrey" id="mon_base_fee"  readonly />
				</td>
			-->
			
				<td class="blue">购机款</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="base_fee" name="base_fee" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">用户缴费合计</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="sale_price" name="sale_price" readonly />
					<input class="InputGrey" type="hidden" id="sale_price_source" name="sale_price_source" readonly />
				</td>
			
				<td class="blue">拆包期限</td>
				<td>
					<input name="active_term" type="text" class="InputGrey" id="active_term"  readonly />
					<input type="hidden" name="sale_name" id="sale_name" >
					<input type="hidden" name="e505_sale_name" id="e505_sale_name">
				</td>
			</tr>
			<tr>
				<td class="blue">IMEI码</td>
		        <td>
					<input name="IMEINo" id="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
					<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()" >
		          	<font color="orange">*</font>
		        </td>
        		<td class="blue">
					<div align="left">消费积分</div>
				</td>
				<td>
					<input type="text" id="feeMark" name="feeMark" value="0" class="InputGrey" />
						<!-- onkeyup="this.value=this.value.replace(/[^\d]/g,'');"  onafterpaste="this.value=this.value.replace(/[^\d]/g,'')"-->
					<!--积分对应的钱数-->
					<input type="hidden" name="pointMoney" id="pointMoney" value="0">
				</td>
				
			</tr>
			<tr>
				<td class="blue">
					<div align="left">缴费方式</div>
				</td>
				<td>
					<select name="payType" id="payType" onchange="changePayType()">
						<option value="0" checked>现金缴费</option>
						<option value="BX">建设银行POS机缴费</option>
						<option value="BY">工商银行POS机缴费</option>
					</select>
				</td>
				<td class="blue" id="instalTd" style="display:none;">
					分期
				</td>
				<td id="installmentTd" style="display:none;">
				</td>	
			</tr>
			<tr>
				<td class="blue">操作备注</td>
				<td colspan="3">
					<input name="op_note" type="text" size="80" id="op_note" value="" maxlength="60"/>
				</td>
			</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="next_step" id="next_step" value="下一步" index="2">    
			<input class="b_foot" type=button name="reset_btn" id="reset_btn" value="清除"">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
		 </table>
		 
		 <div name="licl" id="licl">
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
			<input type="hidden" name="return_page" value="/npage/se505/se505_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="sale_kind" value="">
			<input type="hidden" name="main_phoneno" value="">
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="banlitype" value="<%=banlitype%>">
			
</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
	<%@ include file="/npage/public/posCCB.jsp" %>
	<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
