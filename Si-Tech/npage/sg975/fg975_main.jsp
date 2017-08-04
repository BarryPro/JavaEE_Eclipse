<%
  /*
   * 功能: 预存购机-合约 g975
   * 版本: 1.0
   * 日期: 2013/9/2
   * 作者: diling
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

	String sale_type = "54";
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
/*判断是否是目标客户*/
String sqlChkTerm = "  SELECT count(1)  "
	+" FROM DTERMTARGCUST T, DCUSTMSG T1  "
	+" WHERE SYSDATE BETWEEN BEGIN_TIME AND END_TIME  "
	+" AND T.ID_NO = T1.ID_NO  "
	+" AND T.REGION_CODE = :reg_code  "
	+" AND T1.PHONE_NO = :phone_no  ";
String sqlChkParas = "reg_code="+regionCode +" , phone_no="+iPhoneNo ;
String targFlag ="";
System.out.println( "zhangyan~~sqlChkTerm~" + sqlChkTerm );
%>
<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlChkTerm%>"/>
		<wtc:param value="<%=sqlChkParas%>"/>
</wtc:service>
<wtc:array id="rst_targ" scope="end"/>
<%
targFlag = rst_targ[0][0];

/*如果是目标客户,查目标客户配置的活动类型*/
String sBrandCode = "NO";
String sResCode = "NO";
if ( !targFlag.equals("0") )
{
	String sqlIsAll = "  SELECT T.BRAND_CODE , t.res_code "
		+" FROM DTERMTARGCUST T, DCUSTMSG T1  "
		+" WHERE SYSDATE BETWEEN BEGIN_TIME AND END_TIME  "
		+" AND T.ID_NO = T1.ID_NO  "
		+" AND T.REGION_CODE = :reg_code  "
		+" AND T1.PHONE_NO = :phone_no  ";
	String sqlParasIsAll = "reg_code="+regionCode +" , phone_no="+iPhoneNo ;
	System.out.println( "zhangyan~~sqlChkTerm~" + sqlChkTerm );
	%>
	<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlIsAll%>"/>
		<wtc:param value="<%=sqlParasIsAll%>"/>
	</wtc:service>
	<wtc:array id="rst_isAll" scope="end"/>
	<%		
	System.out.println( "zhangyan~~~~rst_isAll"+rst_isAll.length );
	System.out.println( "zhangyan~~~~rst_isAll"+rst_isAll[0].length );
	sBrandCode = "";
	sResCode = "";
	
	for (int i = 0 ; i < rst_isAll.length; i ++)
	{
		sBrandCode += " '"+rst_isAll[i][0]+"' ,";
		sResCode += " '"+rst_isAll[i][1]+"' ,";
	}
	System.out.println("zhangyan``````````````"+sBrandCode.indexOf("all"));
	
	sBrandCode = sBrandCode.indexOf("all")==-1?sBrandCode : "all";
	sResCode = sResCode.indexOf("all")==-1?sResCode : "all";
	System.out.println("zhangyan sBrandCode===="+sBrandCode);
	System.out.println("zhangyan  sResCode===="+sResCode);
}

System.out.println( "zhangyan targFlag~~~"+ targFlag );

	String sql_select1 = "SELECT UNIQUE a.brand_code, TRIM (b.brand_name ),  price_save "
		+" FROM dphonesalecode a, schnresbrand b "
		+" WHERE a.region_code = :region_code  "
		+" AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' "
		+" AND a.sale_type = :sale_type ";
	if ( sBrandCode.equals("all") ) /*全部活动目标客户 , 可以看到全部目标客户机型*/
	{
		sql_select1 += " AND A.PRICE_SAVE = '1'";
	}
	else if ( sBrandCode.equals("NO") ) /*非目标客户 , 可以看到非目标客户的全部机型*/
	{
		sql_select1 += " AND A.PRICE_SAVE = '0'";
	}
	else /*指定活动的目标客户 , 可以看到指定目标客户机型, 和非指定目标客户机型*/
	{
		sql_select1 += "   AND ((A.PRICE_SAVE = '1' AND A.BRAND_CODE in ( " 
			+ sBrandCode.substring( 0 , sBrandCode.length() -1 )+" ) ) OR "
			+"(A.PRICE_SAVE = '0' AND A.BRAND_CODE not in ( " 
			+sBrandCode.substring( 0 , sBrandCode.length() -1 )+"  ) )  )";
	}
	
	String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type;
System.out.println( "zhangyan~~sql_select1~" + sql_select1 );
System.out.println( "zhangyan~~srv_params1~" + srv_params1 );
	//获取品牌名称
%>
	<wtc:service name="TlsPubSelCrm" outnum="3">
		<wtc:param value="<%=sql_select1%>"/>
		<wtc:param value="<%=srv_params1%>"/>
	</wtc:service>
	<wtc:array id="result_brand" scope="end"/>
<%
	StringBuffer brandSb = new StringBuffer("");
	brandSb.append("<option value ='-1' >请选择</option>");
	for(int i=0; i<result_brand.length; i++) {
		  brandSb.append("<option value ='").append(result_brand[i][0]).append("' price_save = '"+result_brand[i][2]+"'  >")
						 .append(result_brand[i][1])
						 .append("</option>");
	}
	
	//获取所有的手机型号
	//lj. 绑定参数
	String sql_select2 = "select unique a.type_code,trim( b.res_name ), b.brand_code , a.price_save"
	+" from dphoneSaleCode a,schnrescode_chnterm b  "
	+" where a.region_code=:region_code and  a.type_code=b.res_code and "
	+" a.brand_code=b.brand_code  and a.valid_flag='Y' " 
	+" and a.sale_type=:sale_type  ";
	
	if ( sResCode.equals("all") ) /*全部活动目标客户 , 可以看到全部目标客户机型*/
	{
		sql_select2 += " AND A.PRICE_SAVE = '1'";
	}
	else if ( sResCode.equals("NO") ) /*非目标客户 , 可以看到非目标客户的全部机型*/
	{
		sql_select2 += " AND A.PRICE_SAVE = '0'";
	}
	else /*指定活动的目标客户 , 可以看到指定目标客户机型, 和非指定目标客户机型*/
	{
		sql_select2 += "   AND ((A.PRICE_SAVE = '1' AND A.type_code in ( "
			+sResCode.substring( 0 , sResCode.length() -1 )+" ) ) OR "
			+"(A.PRICE_SAVE = '0' AND A.type_code not in ( "
			+sResCode.substring( 0 , sResCode.length() -1 )+"  ) ))";			
	}	
	String srv_params2 = "region_code=" + regionCode + ",sale_type=" + sale_type;	
	System.out.println( "zhangyan~~sql_select2~" + sql_select2 );
	System.out.println( "zhangyan~~srv_params2~" + srv_params2 );
	
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
                 +" from product_offer a,region b,dloginmsg c "
                 +" where a.offer_attr_type ='ZDFL' "
                 +" and a.offer_id = b.offer_id "
                 +" and b.group_id in(select parent_group_id from dchngroupinfo d where c.group_id = d.group_id) "
                 +" and c.login_no =:loginno "
                 +" and c.power_right>= b.right_limit "
                 +" and a.exp_date>sysdate "
                 +" and a.eff_date<sysdate "
                 +" and a.offer_type=40 ";
  inParams[1] = "loginno="+loginNo;
  System.out.println( "zhangyan~~~" + inParams[0]);
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
          window.location.href="/npage/sg975/fg975_login.jsp?activePhone=<%=iPhoneNo%>&opCode=g975&opName=<%=opName%>";
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
		if( resultOffer_name.length>0&&resultOffer_name[0][0]!=null)
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
    var sign = false;
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
					$("#mode_sale").empty();
					reset();
					$('#contract_time').val("-1");
					$('#limit_fee').val("-1");

					$("#phone_type").append('<option value ="-1">请选择</option>');
					$.each(phone_types[brand],function(n,ele){
            $("<option value="+n+"  >"+ele+"</option>").appendTo($("#phone_type"));
					});
				});
				
				/*************************切换型号，需要往后台发请求*****************************/
				/* 
			   *  begin  diling update for 终端和资费分离的补充需求 @2013/9/19
			   */
				$('#phone_type').change(function() {
				   //查询目标用户表中是否已配置数据
				   var phoneBrand = $('#phone_brand').val();
				   var phoneType = $('#phone_type').val();
				   var packet = new AJAXPacket("ajax_checkTableDeployed.jsp","正在获得相关信息，请稍候......");
					 var _data = packet.data;
					 _data.add("phoneBrand",phoneBrand);
					 _data.add("phoneType",phoneType);
					 core.ajax.sendPacket(packet,doCheckTableDeployed);
					 packet = null;
				});
				
				function doCheckTableDeployed(package) {
      		var retCode = package.data.findValueByName("retCode");
      		var retMsg = package.data.findValueByName("retMsg");
      		var checkDeployFlay = package.data.findValueByName("checkDeployFlay");//目标用户表是否已配置标识 Y 已配置 N 没配置
      		var phoneBrand = $('#phone_brand').val();
				  var phoneType = $('#phone_type').val();
      		if(retCode == "000000") {
      			getParameters();
      			//if(checkDeployFlay=="Y"){ //如已配置，那么只有表中的目标用户才能办理，如果没有满足这种条件的数据，那么就是所有人都可以办理；
              //alert("已配置！");
              /*
              var packet = new AJAXPacket("ajax_checkGoalUser.jsp","正在获得相关信息，请稍候......");
              var _data = packet.data;
              _data.add("phoneBrand",phoneBrand);
              _data.add("phoneType",phoneType);
              _data.add("iPhoneNo","<%=iPhoneNo%>");
              core.ajax.sendPacket(packet,doCheckGoalUser);
              packet = null;*/
      			//getParameters();
      			//}else{
      			//  //alert("没配置！正常办理！");
      			//  getParameters();
      			//}
      		}else {
      			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
      			$("#phone_type").val("-1");
      			return false;
      		}
      	}
      	
      	function doCheckGoalUser(package){
      	  var retCode = package.data.findValueByName("retCode");
      		var retMsg = package.data.findValueByName("retMsg");
      		var checkGoalUserFlay = package.data.findValueByName("checkGoalUserFlay");//表中是否存在目标用户标识 Y 存在 N 不存在
      		if(retCode == "000000") {
      			if(checkGoalUserFlay=="Y"){ //表中存在此目标用户，可以办理
      			  //alert("存在！");
              getParameters();
      			}else{//表中不存在，则不能办理
      			  //alert("不存在！不能办理！");
      			  rdShowMessageDialog("用户非目标客户，不允许办理！请重新选择！",1);
      			  $("#phone_type").val("-1");
      			  return false;
      			}
      		}else {
      			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
      			$("#phone_type").val("-1");
      			return false;
      		}
      	}
      	
      	/* 
         *  end  diling update for 终端和资费分离的补充需求 @2013/9/19
         */
      	
      	/***************** 获得合约价格、优惠比例、营销案代码、采购价格等参数 ***********************/
      	function getParameters(){
      	  //获得手机类型
					var typeCode = $('#phone_type').val();
					reset();
					$('#contract_time').val("-1");
					$('#limit_fee').val("-1");

					$('#p3').val($('#phone_type').val());
					/*获取相关参数*/
					 var packet = new AJAXPacket("ajax_getPriceAndPrepay.jsp","正在获得相关信息，请稍候......");
					 var _data = packet.data;
					 _data.add("sale_type","<%=sale_type%>");
					 _data.add("type_code",typeCode);
					 _data.add("targFlag",  $("#targFlag").val());
					 _data.add("sResCode",  $("#sResCode").val());
					 core.ajax.sendPacket(packet,getSaleWaysProcess);
					 packet = null;
      	}
				/*************************切换型号，ajax返回的营销方案数据****************************/
      	function getSaleWaysProcess(package) {
      		var retCode = package.data.findValueByName("retCode");
      		var retMsg = package.data.findValueByName("retMsg");
      		var sale_price = package.data.findValueByName("sale_price");//合约价格
      		sale_price = parseFloat(sale_price).toFixed(0);
      		var privilege_scale = package.data.findValueByName("prepay_limit");//优惠比例

      		var sale_code = package.data.findValueByName("sale_code");//营销案代码
      		var cost_price = package.data.findValueByName("cost_price");//采购价格
      		if(retCode == "000000") {
      			$("#contract_fee_hidd").val(sale_price);
      			$("#privilege_scale_Hidd").val(privilege_scale);
      			$("#sale_code_Hidd").val(sale_code);
      			$("#cost_price_Hidd").val(cost_price);
      		}else {
      			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
      			return false;
      		}
      	}
				/*************************切换合约期限，校验条件是否选择全面 ******************************/
				$('#contract_time').change(function() {
				    var contract_time = $('#contract_time').val();
						if($('#phone_brand').val()=="-1"){
						  rdShowMessageDialog("请选择手机品牌!");
        			$('#phone_brand').focus();
        			$('#contract_time').val("-1");
        			return false;
						}
						if($('#phone_type').val()=="-1"){
						  rdShowMessageDialog("请选择手机类型!");
        			$('#phone_type').focus();
        			$('#contract_time').val("-1");
        			return false;
						}
					  reset();
					  $('#limit_fee').val("-1");
				});
				
				/************************* 切换底限资费，校验条件是否选择全面  ************************/
				$('#limit_fee').change(function() {
						var limit_fee = $("#limit_fee").val();
						
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

          var contract_fee_hidd = $("#contract_fee_hidd").val();//合约价格
					var privilege_scale_Hidd = $("#privilege_scale_Hidd").val();//优惠比例
		
					var contract_time = $("#contract_time").val();//合约期限
          var prepay_limit = ""; //底限预存
          var base_fee = ""; //购机款
          var sale_price = "";//应收金额
          if(retCode == "000000") {
            $("#monBaseFee_hidd").val(parseFloat(monBaseFee).toFixed(0));
            $("#contract_fee").val(contract_fee_hidd);
            //底限预存=底限资费的月租*优惠比例*消费期限(合约期限)
            //alert(monBaseFee+"*"+privilege_scale_Hidd+"*"+contract_time);
            //prepay_limit = parseFloat(monBaseFee*privilege_scale_Hidd*contract_time/100).toFixed(2);
            prepay_limit = parseFloat(parseFloat(monBaseFee*privilege_scale_Hidd/100).toFixed(0)*contract_time);//市场部确认，先取整，再*合约期限
            //购机款=应收金额-底限预存
            //如果底限预存<=合约价格时，应付金额取合约价，购机款=合约价-底限预存；
			//alert ("prepay_limit==="+prepay_limit);
			//alert ("contract_fee_hidd==="+contract_fee_hidd);
            if(parseFloat(prepay_limit)<parseFloat(contract_fee_hidd)||parseFloat(prepay_limit)==parseFloat(contract_fee_hidd)){ 
              sign = false;
              sale_price = parseFloat(contract_fee_hidd).toFixed(0);
              base_fee = parseFloat(contract_fee_hidd) - parseFloat(prepay_limit);    
            }else{ //如果底限预存>合约价时， 应付金额取底限预存，购机款=底限预存-底限预存；
              sign = true;
              rdShowMessageDialog("无法办理，请重新选择终端、底线或合约期。");
              return;
              sale_price = parseFloat(prepay_limit).toFixed(0);
              base_fee = parseFloat(prepay_limit) - parseFloat(prepay_limit);
            }
            $("#prepay_limit").val(prepay_limit);
            $("#sale_price").val(sale_price);
            $("#base_fee").val(base_fee.toFixed(0));
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
		if (sign){//底限预存>合约价
		    rdShowMessageDialog("无法办理，请重新选择终端、底线或合约期。");
		    return;
		}
		
		if(!check(document.frm) ) {
			return false;
		}
		getAfterPrompt();
		var retMonFee = parseFloat($('#prepay_limit').val())/parseFloat($('#contract_time').val());
		$("#retMonFee_hidd").val(retMonFee);
		var costFee = parseFloat($("#cost_price_Hidd").val())-parseFloat($("#base_fee").val());//成本补贴
		var str=
			$("#sale_code_Hidd").val()+"|"
			+$('#phone_brand').find('option:selected').text()+"|"
			+$('#phone_type').find('option:selected').text()+"|"
			+$('#sale_price').val()+"|"
			+""+"|"
			+parseFloat(retMonFee).toFixed(0)+"|"
			+$('#monBaseFee_hidd').val()+"|"
			+parseFloat($('#base_fee').val()).toFixed(0)+"|"
			+$('#contract_time').val()+"|"
			+$("#limit_fee").val()+"|"
			+$('#IMEINo').val()+"|"
			+parseFloat(costFee).toFixed(0)+"|"
			+""+"|"
			+parseFloat($('#prepay_limit').val()).toFixed(0)+"|";
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
  	var opCode="g975" ;                   			 	//操作代码
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
  	cust_info+="手机号码："+document.all.phoneNo.value+"|";
  	cust_info+="客户姓名："+document.all.oCustName.value+"|";
  
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	retInfo+=" "+"|";
  	opr_info+="用户品牌："+document.all.oSmName.value+"    办理业务：<%=opName%>"+"|";
    opr_info+="业务流水："+document.all.printAccept.value+"|";
    opr_info+="手机型号："+$('#phone_type').find('option:selected').text()+"    IMEI码："+$("#IMEINo").val()+"|";
  	opr_info+="缴费合计："+$('#sale_price').val()+"元  含：预存话费"+$("#prepay_limit").val()+"元，每月返还金额："+_retMonFee_hidd+"元，月底限消费："+$('#monBaseFee_hidd').val()+"元，合约期："+$("#contract_time").val()+"个月。"+"|"; 
  
  	//note_info1+="备注："+document.all.do_note.value+"|";
  
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
  	  document.all.payType.value = document.all.payTypeSelect.value;
  		if(document.all.payType.value=="BX")
    	{
      		/*set 输入参数*/
  				var transerial    = "000000000000";  	                    //交易唯一号 ，将会取消
  				var trantype      = "00";         //交易类型
  				var bMoney        = $('#sale_price').val(); 				//缴费金额
  				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
  				var tranoper      = "<%=loginNo%>";                       //交易操作员
  				var orgid         = "<%=groupId%>";                       //营业员归属机构
  				var trannum       = "<%=activePhone%>";                      //电话号码
  				getSysDate();       /*取boss系统时间*/
  				var respstamp     = document.all.Request_time.value;      //提交时间
  				var transerialold = "";																		//原交易唯一号,在缴费时传入空
  				var org_code      = "<%=orgCode%>";                       //营业员归属						
  				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
  				if(ccbTran=="succ") posSubmitForm();
    	}
  		else if(document.all.payType.value=="BY")
  		{
  				var transType     = "05";					/*交易类型 */         
  				var bMoney        = $('#sale_price').val();         /*交易金额 */
  				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
  				var response_time = "";                								 		/*原交易日期 */				
  				var rrn           = "";                           				/*原交易系统检索号 */ 
  				var instNum       = "";                                   /*分期付款期数 */     
  				var terminalId    = "";                    								/*原交易终端号 */			
  				getSysDate();       																			//取boss系统时间                                            
  				var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
  				var workno        = "<%=loginNo%>";                        /*交易操作员 */       
  				var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
  				var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
  				var phoneNo       = "<%=activePhone%>";                       /*交易缴费号 */       
  				var toBeUpdate    = "";						                        /*预留字段 */         
  				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
  				if(icbcTran=="succ") posSubmitForm();
  		}else{
  				posSubmitForm();
  		}
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
  <form name="frm" method="post" action="fg975_cfm.jsp">
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
            <option value="6">6</option>
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
			  <td class="blue">合约价格</td>
				<td width="39%">
					<input class="InputGrey" type="text" name="contract_fee" id="contract_fee" readonly />
				</td>
				<td class="blue">底限预存</td>
				<td>
					<input name="prepay_limit" type="text" class="InputGrey" id="prepay_limit"  readonly />
					<input name="mon_prepay_limit" type="hidden" class="InputGrey" id="mon_prepay_limit"  readonly />
					<input name="mon_base_fee" type="hidden" class="InputGrey" id="mon_base_fee"  readonly />
				</td>
			</tr>
			<tr>
			  <td class="blue">购机款</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="base_fee" name="base_fee" readonly />
				</td>
				<td class="blue">应收金额</td>
				<td width="39%">
					<input class="InputGrey" type="text" id="sale_price" name="sale_price" readonly />
					<input class="InputGrey" type="hidden" id="sale_price_source" name="sale_price_source" readonly />
				</td>
			</tr>
			<tr>
				<td class="blue">IMEI码</td>
		        <td colspan="3">
					<input name="IMEINo" id="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
					<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()" >
		          	<font color="orange">*</font>
		        </td>
			</tr>
						<TR id=showHideTr >
  			<TD class="blue">
  				<div align="left">付机时间</div>
        </TD>
  			<TD >
  				<input name="payTime" type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
  				(年月日)<font color="orange">*</font>
  			<TD class="blue">
  				<div align="left">保修时限</div>
  			</TD>
  			<TD >
  				<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12" onblur="viewConfirm()">
  				(个月)<font color="orange">*</font>
  			</TD>
      </TR>
			<tr>
				<td class="blue">
					<div align="left">缴费方式</div>
				</td>
				<td colspan="3">
					<select name="payTypeSelect" id="payTypeSelect" >
						<option value="0" checked>现金缴费</option>
						<option value="BX">建设银行POS机缴费</option>
						<option value="BY">工商银行POS机缴费</option>
					</select>
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
			
			<!-- pos机 begin-->		
			<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
			<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
			<input type="hidden" id = "targFlag" name="targFlag"  value="<%=targFlag%>">
			<input type="hidden" id = "sBrandCode" name="sBrandCode"  value="<%=sBrandCode%>">
			<input type="hidden" id = "sResCode" name="sResCode"  value="<%=sResCode%>">
			<!-- pos机 end-->	
</div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
	<%@ include file="/npage/public/posCCB.jsp" %>
	<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
