<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 自备机合约计划
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
	String sale_type = "48";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");

	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
//String loginNoPass = (String)session.getAttribute("password");
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	//lj. 绑定参数
	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) FROM dphonesalecode a, schnresbrand b WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;
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
					var flagCodeObj = $("#flagCode");
					flagCodeObj.empty();
					var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
					consObj.hide();
					$("#offerAttrFlag").val("");
					$("#flag_code").val("");
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
						var flagCodeObj = $("#flagCode");
						flagCodeObj.empty();
						var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
						consObj.hide();
						$("#offerAttrFlag").val("");
						$("#flag_code").val("");
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
						var flagCodeObj = $("#flagCode");
						flagCodeObj.empty();
						var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
						consObj.hide();
						$("#offerAttrFlag").val("");
						$("#flag_code").val("");
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
				/********************** 选择小区 *******************************/
				$("#flagCode").change(function(){
					var flag_code = $("#flagCode").val();
					if(typeof(flag_code) != "undefined" && flag_code != "undefined" && flag_code != "normal"){
						$("#flag_code").val(flag_code);
					}
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
				
		})
	/*************************清除手机费用input的值****************************/	
	function reset() {
		$('#prepay_limit').val(''); //底线预存
		$('#prepay_gift').val('');  //活动预存
		$('#mon_base_fee').val(''); //月赠送预存款
		$('#consume_term').val(''); //业务有效期
		$('#active_term').val('');  //拆包期限
		$('#sale_price').val('');   //用户缴费合计
		$('#sale_name').val('');
		$('#sale_name_span').text('');
		var flagCodeObj = $("#flagCode");
		flagCodeObj.empty();
		var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
		consObj.hide();
		$("#offerAttrFlag").val("");		
		$("#flag_code").val("");
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
			var offerAttrFlag = package.data.findValueByName("offerAttrFlag");
			var offerAttrResult = package.data.findValueByName("offerAttrResult");
			if(retCode == "000000") {
				$('#prepay_limit').val(result.prepay_limit); //底线预存
				$('#prepay_gift').val(result.prepay_gift);   //活动预存
				$('#mon_base_fee').val(result.mon_base_fee); //月赠送预存款
				$('#consume_term').val(result.consume_term); //业务有效期
				$('#active_term').val(result.active_term);   //拆包期限
				$('#sale_price').val(result.sale_price);     //用户缴费合计
				$('#i16').val($('#mode_sale').val());
				if(result.sale_name != null && result.sale_name != "") {
					$('#sale_name_span').text(result.sale_name + '--');
					$('#sale_name').val(result.sale_name + '--');
				}
			 $('#mon_prepay_limit').val(result.mon_prepay_limit);
			 var flagCodeObj = $("#flagCode");
			 flagCodeObj.empty();
			 flagCodeObj.append("<option value='normal'>--请选择--</option>");
			 var consObj = flagCodeObj.parent().parent().find("td:gt(1)");
			 consObj.hide();
			 $("#offerAttrFlag").val(offerAttrFlag);
			 if(offerAttrFlag == "Y"){
			 		consObj.show();
					$.each(offerAttrResult,function(i,n){
						flagCodeObj.append("<option value='"+n[0]+"'>"+n[1]+"</option>");
					});
			 }else{
			 		
				}
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	
	/*************************验证IMEI****************************/
	function checkimeino() {
	 if($('#IMEINo').val().length == 0){
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
    }else if($('#IMEINo').val().length != 15) {
    	rdShowMessageDialog("IMEI号码应为15位，请重新输入 !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
    }else if(!new RegExp(/^[0-9]{15}$/).test($.trim($('#IMEINo').val()))){
    	rdShowMessageDialog("IMEI号码应为15位数字，请重新输入 !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
    }
     
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se528/srv.jsp","正在校验IMEI信息，请稍候......");
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
				document.frm.next_step.disabled=false;
				document.frm.IMEINo.readOnly = true;
				return ;

		}else if(retResult == "000003"){
				rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
				document.frm.next_step.disabled=true;
				return false;
		}else if(retResult == "000004"){
				rdShowMessageDialog("此IMEI号已经办理过，不能再次办理！");
				document.frm.next_step.disabled=true;
				return false;
		}else{
				rdShowMessageDialog("IMEI号不存在或者已经使用！");
				document.frm.next_step.disabled=true;
				return false;
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
		/*校验*/
		var offerAttrFlag = $("#offerAttrFlag").val();
		if(offerAttrFlag == "Y"){
			var flagCodeObj = $("#flagCode");
			if(flagCodeObj.val() == "normal"){
				rdShowMessageDialog("请选择小区！");
				return false;	
			}
		}
		
		//拼接一系列参数
		//营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限｜购机款｜传0｜imei码|阶段活动名称|月底线消费
		 var str =$('#sale_ways').val()    + "|" +
							$('#phone_brand').find('option:selected').text() + "|" +
							$('#phone_type').find('option:selected').text()  + "|" +
							$('#sale_price').val()   + "|" +
							$('#prepay_limit').val() + "|" +
							$('#consume_term').val() + "|" +
							$('#prepay_gift').val()  + "|" +
							$('#active_term').val()  + "|" +
							$('#mon_base_fee').val() + "|" +  
							'0'                      + "|" + 
							$('#IMEINo').val()       + "|" + 
							$('#mon_prepay_limit').val() + "|" + 
							$('#sale_name').val(); 
		$('#iAddStr').val(str);
		$('#ip').val($('#mode_sale').val());
		$('#do_note').val($('#op_note').val());
		frm.submit();
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
				<td colspan="3"> 
					<select id="sale_ways">
					</select>
				</td>
			</tr> 
			<tr>
				<td class="blue">新主资费 </td>
				<td> 
					<select id="mode_sale">
					</select>
				</td>
				<td class="blue" style="display:none;">小区代码</td>
				<td style="display:none;">
					<select id="flagCode">
					</select>
				</td>
			</tr>
			
			<tr>
				<td class="blue">底线预存</td>
				<td>
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
		    	<input name="mon_prepay_limit" type="hidden" class="InputGrey" id="mon_prepay_limit"  readonly />
				</td>
				<td class="blue">活动预存</td>
				<td width="39%">
					<input class="InputGrey" type="text" name="prepay_gift" id="prepay_gift" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">月赠送预存款</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="mon_base_fee" name="mon_base_fee" readonly />
				</td>	
				<td class="blue">业务有效期</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="consume_term" name="consume_term" readonly />
				</td>			
			<tr>
				<td class="blue">拆包期限</td>
				<td>
					<input name="active_term" type="text" class="InputGrey" id="active_term"  readonly />
					<input type="hidden" name="sale_name" id="sale_name" >
				</td>
				<td class="blue">用户缴费合计</td>
				<td>
					<input name="sale_price" type="text" class="InputGrey" id="sale_price"  readonly />
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
					<div align="left">缴费方式</div>
				</td>
				<td>
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
					<input name="op_note" type="text" size="80" v_maxlength=60 id="op_note" value="自备机合约计划" />
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
			<input type="hidden" name="return_page" value="/npage/se528/se528_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="sale_kind" value="">
			<input type="hidden" name="main_phoneno" value="">
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="offerAttrFlag" id="offerAttrFlag" value="">
			<input type="hidden" name="flag_code" id="flag_code" value="">
</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
	<%@ include file="/npage/public/posCCB.jsp" %>
	<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
