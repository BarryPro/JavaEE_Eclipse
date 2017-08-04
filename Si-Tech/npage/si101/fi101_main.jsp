<%
  /*
   * 功能: 购机赠费
   * 版本: 1.0
   * 日期: 2013/10/10
   * 作者: wanghyd
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

	String sale_type = "39";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = activePhone;
	String op_strong_pwd = (String) session.getAttribute("password");
	//lj. 绑定参数
	//String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name) FROM dphonesalecode a, schnresbrand b WHERE a.region_code = :region_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type";
	//String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;

	String sql_select1 = "SELECT UNIQUE t.brand_code,t.brand_name FROM DBCHNTERM.SCHNRESBRAND T, DBCHNTERM.SCHNRESCODE T1 WHERE T.BRAND_CODE = T1.BRAND_CODE AND T1.PRODUCT_TYPE = 'Y'  AND T.KIND_CODE = '50' ";
 

	//获取品牌名称
%>
	<wtc:service name="TlsPubSelCrm" outnum="2">
		<wtc:param value="<%=sql_select1%>"/>
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
  String  inParams [] = new String[2];
  inParams[0] = "select a.offer_id ,a.offer_name "
                 +" from product_offer a,region b,dloginmsg c, product_offer_attr e"
                 +" where a.offer_attr_type ='ZDFL' "
                 +" and a.offer_id = b.offer_id "
                 +" and b.group_id in(select parent_group_id from dchngroupinfo d where c.group_id = d.group_id) "
                 +" and c.login_no =:loginno "
                 +" and c.power_right>= b.right_limit "
                 +" and a.exp_date>sysdate "
                 +" and a.eff_date<sysdate "
                 +" and a.offer_id = e.offer_id and a.offer_type=40 and e.offer_attr_seq ='50003' and e.offer_attr_value in (18,28,38,48,58,68,78,88,98,108,118,128,138,148,158,168,178,188,198) ";
                 
                 
  inParams[1] = "loginno="+loginNo;
  
  System.out.println(inParams[0]+"-----"+  inParams[1]);
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_limitOfferInfo"  scope="end"/>
<%
  	StringBuffer limitFeeSb = new StringBuffer("");
  	limitFeeSb.append("<option value ='-1'>请选择</option>");
  	if("000000".equals(retCode1)){
  	  if(result_limitOfferInfo.length>0){
      	for(int i=0; i<result_limitOfferInfo.length; i++) {
      	      if (true){
      	          System.out.println("zhouby + " +result_limitOfferInfo[i][0]+"--"+result_limitOfferInfo[i][1] );
      	      }
      		  limitFeeSb.append("<option value ='").append(result_limitOfferInfo[i][0]).append("'>")
      						 .append(result_limitOfferInfo[i][0]+"--"+result_limitOfferInfo[i][1])
      						 .append("</option>");
      	}
  	  }
  	}
  	
%>
<%
	String  inputParsm[] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = opCode;
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
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg：" + errMsg;
%>
        <SCRIPT language="JavaScript">
        	rdShowMessageDialog("<%=retMsg%>",0);
          window.location.href="/npage/si101/fi101_login.jsp?activePhone=<%=iPhoneNo%>&opCode=i101&opName=<%=opName%>";
        </SCRIPT>
<%
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
	    print_note = tempArr[0][25];//当前积分
	    contract_flag = tempArr[0][27];//是否托收账户
	    high_flag = tempArr[0][28];//是否中高端用户
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("调用服务s126bInit出错！错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
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
			//设置底限资费的下拉列表
			$('#limit_fee').append("<%=limitFeeSb.toString()%>");
			//获得手机型号对象
			/*
			 *对象类型
			[
				brandCode1:{code1:name1,code2:name2}
		    brandCode2:{code1:name1,code2:name2}
		  ]
				*/
			var phone_types = [];

			/*************************切换手机品牌*****************************/
			$('#phone_brand').change(function() {
							    document.frm.next_step.disabled=true;
						document.frm.IMEINo.readOnly = false;
						document.frm.IMEINo.value="";
					//获得手机品牌
					var brand = $('#phone_brand').val();
					//把所有设置成空
					$("#phone_type").empty();
					//$("#sale_ways").empty();

					reset();
					//$('#contract_time').val("-1");
					//$('#limit_fee').val("-1");
					
						//alert($("#phone_brand").val());
							var packet = new AJAXPacket("queryBaseInfo.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("phone_brand",$("#phone_brand").val());
						 _data.add("method","phone_typess");
						 core.ajax.sendPacket(packet,getphone_types);
						 packet = null;
				});
				
				/*************************切换型号，需要往后台发请求*****************************/
				$('#phone_type').change(function() {
				    document.frm.next_step.disabled=true;
						document.frm.IMEINo.readOnly = false;
						document.frm.IMEINo.value="";
						//获得手机类型
						var typeCode = $('#phone_type').val();
						//alert(typeCode);
						//reset();
						//$('#contract_time').val("-1");
						//$('#limit_fee').val("-1");
						$('#p3').val($('#phone_type').val());
						
						if(typeCode=="-1") {
						$("#youhuibili").val("");
						$("#prepay_limit").val("");	
						return false;
						}
						 var packet = new AJAXPacket("queryBaseInfo.jsp","正在获得相关信息，请稍候......");
						 var _data = packet.data;
						 _data.add("phone_type",typeCode);
						 _data.add("method","yingxiaoan");
						 core.ajax.sendPacket(packet,getSaleWaysProcess);
						 packet = null;
				});
				
					/*************************切换品牌，ajax返回的手机型号****************************/
	    function getphone_types(package) {
			var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				//填充营销方案数据
				var txt = '<option value="-1" >--请选择--</option>';
				for(var i=0,len=result.length;i<len;i++) {
					txt += '<option value="' + result[i].value + '">';
					txt +=     result[i].name;
					txt += '</option>'
				}
				$('#phone_type').append(txt);
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	
	
	
				/*************************切换型号，ajax返回的营销方案数据****************************/
      	function getSaleWaysProcess(package) {
      		var retCode = package.data.findValueByName("retcode");
      		var retMsg = package.data.findValueByName("retmsg");
      		var youhuibili = package.data.findValueByName("youhuibili");//合约价格
      		//var sale_codess = package.data.findValueByName("sale_code");//合约价格
      		
      		
      		if(retCode == "000000") {
      			$("#youhuibili").val(youhuibili/100);
      			//$("#sale_codess").val(sale_codess);
      			
      			var contract_time = $("#contract_time").val();//合约期限
      			var qian=  $("#monBaseFeesssss").val();
      			//alert(parseFloat(qian*youhuibili/100).toFixed(0));
      			if(contract_time!=-1 && qian!="") {
      		   var prepay_limit = parseFloat(parseFloat(qian*youhuibili/100).toFixed(0)*contract_time);//市场部确认，先取整，再*合约期限

            $("#prepay_limit").val(prepay_limit);	
            }

      		}else {
      			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
      			return false;
      		}
      	}
				/*************************切换合约期限，校验条件是否选择全面 ******************************/
				$('#contract_time').change(function() {
				    var contract_time = $('#contract_time').val();
					  reset();
					  //$('#limit_fee').val("-1");
					  
					  var contract_time = $("#contract_time").val();//合约期限
      			var qian=  $("#monBaseFeesssss").val();
      			var youhuibili =$("#youhuibili").val();
      			
      			if(contract_time!=-1 && qian!="" && youhuibili!="") {
      		   var prepay_limit = parseFloat(parseFloat(qian*youhuibili).toFixed(0)*contract_time);//市场部确认，先取整，再*合约期限

            $("#prepay_limit").val(prepay_limit);	
            }
            
				});
				
				/************************* 切换底限资费，校验条件是否选择全面  ************************/
				$('#limit_fee').change(function() {
						var limit_fee = $("#limit_fee").val();
						
      			if(limit_fee=="-1"||limit_fee==-1){//请选择
      			  reset();
							return;
      			}else{ //获取底限资费的月租
      			  var packet = new AJAXPacket("ajax_getMonBaseFee.jsp","正在获得相关信息，请稍候......");
              var _data = packet.data;
              _data.add("limit_fee",limit_fee);
              core.ajax.sendPacket(packet,doGetMonBaseFee);
              packet = null;
      			}
				});
				
				function doGetMonBaseFee(package){
          var retCode = package.data.findValueByName("retCode");
          var retMsg = package.data.findValueByName("retMsg");
          var monBaseFee = package.data.findValueByName("monBaseFee");//底限资费的月租
          
          $("#monBaseFeesssss").val(monBaseFee);
          //alert(monBaseFee);
					var privilege_scale_Hidd = $("#youhuibili").val();//优惠比例
					var contract_time = $("#contract_time").val();//合约期限
          var prepay_limit = ""; //赠送话费
          if(retCode == "000000") {
            $("#monBaseFee_hidd").val(parseFloat(monBaseFee).toFixed(0));
            //底限预存=底限资费的月租*优惠比例*消费期限(合约期限)
            //alert(monBaseFee+"*"+privilege_scale_Hidd+"*"+contract_time);
            //prepay_limit = parseFloat(monBaseFee*privilege_scale_Hidd*contract_time/100).toFixed(2);
            prepay_limit = parseFloat(parseFloat(monBaseFee*privilege_scale_Hidd).toFixed(0)*contract_time);//市场部确认，先取整，再*合约期限

            $("#prepay_limit").val(prepay_limit);

          }else {
            rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
            return false;
          }
				}
				
				//默认情况下，不验证IMEI码，不能点击提交按钮
				$('#next_step').attr('disabled','disabled');
				/*************************提交按钮注册事件****************************/
				$('#next_step').click(function() {
					printCommit();	
				})
				/*************************清除按钮注册事件****************************/
				$('#reset_btn').click(function() {
						$('#phone_brand').val("-1");
						$('#limit_fee').val("-1");
						$('#contract_time').val("-1");
						$('#phone_brand').change();
						$('#IMEINo').val('');
				});
		});
	/*************************清除手机费用input的值****************************/	
	function reset() {
		$('#sale_name_span').text('');
		$('#contract_fee').val('');
    $('#prepay_limit').val('');
    $('#base_fee').val('');		
    $('#sale_price').val('');
	}

	/*************************验证IMEI****************************/
	function checkimeino() {
	 if($('#IMEINo').val().length == 0){
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      $('#next_step').attr('disabled','disabled');
	 	  return false;
     }
    var flag = check();
    if(!flag){
      return false;
    }
		var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
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
						rdShowMessageDialog("IMEI号校验成功!！",2);
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
		var limit_fee = $('#limit_fee').val();
		var contract_time = $("#contract_time").val();
		if(phone_brand == -1) {
			rdShowMessageDialog("请选择手机品牌！");
			return false;	
		}else if(phone_type == -1) {
			rdShowMessageDialog("请选择手机类型！");
			return false;	
		}else if(contract_time == -1){
		  rdShowMessageDialog("请选择合约期限！");
			return false;	
		}else if(limit_fee == -1) {
		  rdShowMessageDialog("请选择底限资费！");
			return false;
		}
		return true;
	}
	
	
	function printCommit() {
		//拼接一系列参数
		/*	
		    sale_code_Hidd               营销案代码
				phone_brand                  手机品牌
				phone_type                   手机类型
				sale_price                   应收金额
				  0                          活动预存
				prepay_limit/contract_time   每月返还金额=底线预存/合同期限
				monBaseFee_hidd：            月底线消费
				base_fee - 0                 购机款-积分对应的钱数
				contract_time                合同期限
				limit_fee                    资费代码
				IMEINo                       IMEI码
				cost_price_Hidd-base_fee     成本补贴= 采购价格-购机款
				  0                          手机电视费消费期限
				prepay_limit                 底限预存  
		*/
		if(!check(document.frm) ) {
			return false;
		}
		getAfterPrompt();
		var retMonFee = parseFloat($('#prepay_limit').val())/parseFloat($('#contract_time').val());
		$("#retMonFee_hidd").val(retMonFee);
		var costFee = parseFloat($("#cost_price_Hidd").val())-parseFloat($("#base_fee").val());//成本补贴
		var str=
			$("#phone_type").val()+"|"
			+$('#phone_brand').find('option:selected').text()+"|"
			+$('#phone_type').find('option:selected').text()+"|"
			+"0"+"|"
			+""+"|"
			+""+"|"
			+$('#monBaseFee_hidd').val()+"|"
			+"0"+"|"
			+$('#contract_time').val()+"|"
			+$("#limit_fee").val()+"|"
			+$('#IMEINo').val()+"|"
			+$('#prepay_limit').val()+"|"
			+$('#phone_brand').val()+"|" 
			+"0"+"|";
		$('#iAddStr').val(str);
		document.frm.p3.value = $('#phone_type').find('option:selected').text();
		if($('#phone_brand').val()=="-1"){
		  rdShowMessageDialog("请选择手机品牌!");
			$('#phone_brand').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		if($('#phone_type').val()=="-1"){
		  rdShowMessageDialog("请选择手机类型!");
			$('#phone_type').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		if($('#contract_time').val()=="-1"){
		  rdShowMessageDialog("请选择合约价格!");
			$('#contract_time').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		
		if($('#limit_fee').val()=="-1"){
		  rdShowMessageDialog("请选择底限资费!");
			$('#contract_time').focus();
			$('#limit_fee').val("-1");
			return false;
		}
		
		if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.all.IMEINo.focus();
      document.all.next_step.disabled = true;
	 		return false;
     }
     
     var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
    if(typeof(ret)!="undefined"){ 
      if((ret=="confirm")){
        if(rdShowConfirmDialog('确认电子免填单吗？')==1){
  	      frmCfm();
        }
  	  }
    	if(ret=="continueSub"){
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
  	      frmCfm();
        }
    	}
    }else{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1){
        frmCfm();
      }
    }
	}
	
	function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
  
    var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
  	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
  	var sysAccept =<%=loginAccept%>;             	//流水号
  	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
  	var mode_code=null;           							  //资费代码
  	var fav_code=null;                				 		//特服代码
  	var area_code=null;             				 		  //小区代码
  	var opCode="i101" ;                   			 	//操作代码
  	var phoneNo="<%=activePhone%>";               //客户电话
  	var iccidInfoStr = "";
  	var accInfoStr = "";
  		iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
  		accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
  			+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();		
  
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
      path+="&mode_code="+mode_code+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr+
  			"&fav_code="+fav_code+"&area_code="+area_code+
  			"&opCode="+opCode+"&sysAccept="+sysAccept+
  			"&phoneNo="+document.frm.phoneNo.value+
  			"&submitCfm="+submitCfm+"&pType="+
  			pType+"&billType="+billType+ "&printInfo=" + printStr;
       var ret=window.showModalDialog(path,printStr,prop);
       return ret;
  }
  
  function printInfo(printType)
  {
  	var cust_info="";  				//客户信息
  	var opr_info="";   				//操作信息
  	var note_info1=""; 				//备注1
  	var note_info2=""; 				//备注2
  	var note_info3=""; 				//备注3
  	var note_info4=""; 				//备注4
  	var retInfo = "";  				//打印内容

  	var _retMonFee_hidd = parseFloat($("#retMonFee_hidd").val()).toFixed(0);
  	
  	//opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
  	//opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	cust_info+="手机号码："+document.all.i1.value+"|";
	cust_info+="证件号码：" +document.all.i7.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
  
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	opr_info+="用户品牌："+document.all.oSmName.value+"    办理业务：<%=opName%>"+"|";
    opr_info+="业务流水："+document.all.printAccept.value+"|";
    opr_info+="手机型号："+$('#phone_type').find('option:selected').text()+"    IMEI码："+$("#IMEINo").val()+"|";
  	opr_info+="赠送话费："+$('#prepay_limit').val()+"元，月底限消费"+$("#monBaseFee_hidd").val()+"元，合约期："+$("#contract_time").val()+"个月。"+"|"; 
  
  	note_info1+="备注："+document.all.do_note.value+"|";
  
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
  }
  
  function frmCfm()
  {
  	posSubmitForm(); 		
  }
  
  function posSubmitForm(){
		frm.submit();
		return true;
	}
  
  function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
//-->
</script>
</head>
<body>
  <form name="frm" method="post" action="fi101_cfm.jsp">
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
				<td class="blue">合约期限</td>
				<td> 
					<select id="contract_time" name="contract_time">
					  <option value="-1" checked>请选择</option>
            
						<option value="12">12</option>
						<option value="18">18</option>	
						<option value="24">24</option>							  
					</select>
				</td>
				<td class="blue">底限资费 </td>
				<td> 
					<select id="limit_fee" style="width:200px">
					</select>
				</td>
			</tr> 
			<tr>
				<td class="blue">赠送话费</td>
				<td >
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
				</td>

				<td class="blue">IMEI码</td>
		        <td >
					<input name="IMEINo" id="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
					<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()" >
		          	<font color="orange">*</font>
		        </td>
			</tr>

			<tr>
				<td class="blue">操作备注</td>
				<td colspan="3">
					<input name="do_note" type="text" size="80" id="do_note" value="" maxlength="60"/>
				</td>
			</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="next_step" id="next_step" value="确定&打印" index="2">    
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
			
			<input type="hidden" name="monBaseFeesssss" id="monBaseFeesssss">
			<input type="hidden" name="sale_codess" id="sale_codess">
			<input type="hidden" name="youhuibili" id="youhuibili">
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
			<input type="hidden" name="sale_kind" value="">
			<input type="hidden" name="main_phoneno" value="">
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			
			<input type="hidden" name="privilege_scale_Hidd" id="privilege_scale_Hidd" value="" />
			<input type="hidden" name="sale_code_Hidd" id="sale_code_Hidd" value="" />
			<input type="hidden" name="contract_fee_hidd" id="contract_fee_hidd" value="" />
			<input type="hidden" name="monBaseFee_hidd" id="monBaseFee_hidd" value="" />
			<input type="hidden" name="retMonFee_hidd" id="retMonFee_hidd" value="" />
			<input type="hidden" name="cost_price_Hidd" id="cost_price_Hidd" value="" />
			<input type="hidden" name="p3" id="p3" value=""><!--手机型号-->
			<input type="hidden" name="opCode" value="<%=opCode%>">
			

</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
