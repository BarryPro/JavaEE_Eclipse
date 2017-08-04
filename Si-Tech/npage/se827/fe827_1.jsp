<%

/*************************************

* 功  能: 自有业务查询 e827

* 版  本: version v1.0

* 开发商: si-tech

* 创建者: liujian @ 2012-05-03

**************************************/

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%


		response.setHeader("Pragma","No-Cache"); 
	  response.setHeader("Cache-Control","No-Cache");
	  response.setDateHeader("Expires", 0);
		
		String opCode     = "e827";

    String opName     = "自有业务查询";

    String j_year_w  = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
    String j_month_w = new java.text.SimpleDateFormat("MM").format(new java.util.Date());

    String workNo     = (String)session.getAttribute("workNo");

    String regionCode = (String)session.getAttribute("regCode");
    
    String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    
    String dateStrgai = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());

		String[] mon = new String[]{""};
		String bMon="";
	
    Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(5,7)) - 1),Integer.parseInt(dateStr.substring(8,10)));
		for(int i=0;i<=0;i++){
        if(i!=0){
          mon[i] = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(cal.getTime());
          cal.add(Calendar.MONTH,-1);
        }else{
          mon[i] = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(cal.getTime());
        }
    }      
    cal.add(Calendar.MONTH,-5);  
    bMon = new java.text.SimpleDateFormat("yyyy-MM-", Locale.getDefault()).format(cal.getTime())+"01";
	System.out.println("bMon~~~~"+bMon);
	  bMon=bMon+" 00:00:00";
	  
	  bMon=dateStrgai+"-01 00:00:00";
	  
	  String dateStr22gai = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	  
	  
  String dateStr22 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

		String[] mon22 = new String[]{""};
		String bMon22="";
	
    Calendar cal22 = Calendar.getInstance(Locale.getDefault());
		cal22.set(Integer.parseInt(dateStr22.substring(0,4)),(Integer.parseInt(dateStr22.substring(4,6)) - 1),Integer.parseInt(dateStr22.substring(6,8)));
		for(int i=0;i<=0;i++){
        if(i!=0){
          mon22[i] = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal22.getTime());
          cal22.add(Calendar.MONTH,-1);
        }else{
          mon22[i] = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(cal22.getTime());
        }
    }      
    cal22.add(Calendar.MONTH,-5);  
    bMon22 = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal22.getTime())+"01";
	System.out.println("bMon22~~~~"+bMon22);
	
	bMon22 = dateStr22gai+"01";
	  

   		String bMon33="";
   	
      Calendar cal33 = Calendar.getInstance(Locale.getDefault());
   		cal33.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(5,7)) - 1),Integer.parseInt(dateStr.substring(8,10)));
     
       cal33.add(Calendar.DATE,-4);  
       System.out.println("cal33~~~~"+cal33.getTime());

       bMon33 = new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(cal33.getTime());
   	
   	   bMon33=bMon33+" 00:00:00";
   	   System.out.println("bMon33~~~~"+bMon33);
   	   
   	    	   
   	   		String bMon44="";
	   	
	      Calendar cal44 = Calendar.getInstance(Locale.getDefault());
	   		cal44.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(5,7)) - 1),Integer.parseInt(dateStr.substring(8,10)));
	     
	       cal44.add(Calendar.MONTH,-1);
	       cal44.add(Calendar.DATE,1);
	       System.out.println("cal44~~~~"+cal44.getTime());

	       bMon44 = new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(cal44.getTime());
	   	
	   	   bMon44=bMon44+" 00:00:00";
	   	   System.out.println("bMon44~~~~"+bMon44);


	  

		String dateStr1111 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		
		String dateStr5555 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		String dateStr6666 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		String datestrsmm=dateStr6666+"01000000";
		
		String dangtiankaishi = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+" 00:00:00";
		String datedangtiande = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())+" 23:59:59";
		
		
		 String loginNoPass = (String)session.getAttribute("password");
		 String ipAddrss = (String)session.getAttribute("ipAddr");
		 String beizhussdese="根据phoneNo=["+activePhone+"]进行查询";
		 String bp_name="";
		 String sm_codes="";
		 String xingjis="04";
		 
		 
		 
		 Calendar cal_month_6 = Calendar.getInstance(Locale.getDefault());
		 
		 String date_month_0 = new java.text.SimpleDateFormat("yyyy-MM-01", Locale.getDefault()).format(cal_month_6.getTime());
		 String date_time_0_ = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(cal_month_6.getTime());
		 
		 cal_month_6.add(Calendar.MONTH,-2);  
		 String date_month_3 = new java.text.SimpleDateFormat("yyyy-MM-01", Locale.getDefault()).format(cal_month_6.getTime());
		 
		 cal_month_6.add(Calendar.MONTH,-3);  
		 String date_month_6 = new java.text.SimpleDateFormat("yyyy-MM-01", Locale.getDefault()).format(cal_month_6.getTime());
		 
		 System.out.println("-e827-------------date_time_0_-------------->"+date_time_0_);
		 System.out.println("-e827-------------date_month_0-------------->"+date_month_0);
		 System.out.println("-e827-------------date_month_3-------------->"+date_month_3);
		 System.out.println("-e827-------------date_month_6-------------->"+date_month_6);
		 
		 
%>

<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="e827" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
          bp_name = (baseArr[0][5]).trim();
          sm_codes = (baseArr[0][38]).trim();
          
          if(sm_codes.equals("dn")) {
          sm_codes="02";
	        }else if(sm_codes.equals("gn")) {
	          sm_codes="01";
	        }else {
	        	sm_codes="03";
	        }
	        
	        
	        
          System.out.println("2266-------------------bp_name="+bp_name);
          System.out.println("2266-------------------sm_codes="+sm_codes);
          }
    }
    
    //测试写死手机号，上线时去掉
    //activePhone = "15046557789";
    
    %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <title><%=opName%></title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv="expires" content="0" /> 
  	<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	

</head>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>


<script type=text/javascript>
    var e827_search_froms = ""; 

    var search_flag = false;

    //定义 手机游戏-消费记录查询-受理类型

    function cntCode (code,name) {

		this.code = code;

		this.name = name;

	}

	//定义 手机游戏-消费记录查询-受理内容

	function cntType (code,cc) {

		this.code = code;

		this.cc = cc;

	}

	//创建受理内容对象和受理内容对象的数组

	{

		var code_1_1 = new cntCode('101','扣费记录');

		var code_2_1 = new cntCode('201','业务点播订购方法');

		var code_2_2 = new cntCode('202','营销活动');

		var code_2_3 = new cntCode('203','业务使用');

		var code_3_1 = new cntCode('301','业务订购');

		var code_3_2 = new cntCode('302','业务退订');

		var code_4_1 = new cntCode('401','营销-不知情定制、取消或变更');

		var code_4_2 = new cntCode('402','营销-话费/实物返还问题');

		var code_4_3 = new cntCode('403','营销-到期未自动取消');

		var code_4_4 = new cntCode('404','营销-对营销规定/流程不满');

		var code_4_5 = new cntCode('405','营销-宣传不完善或与业务规定不一致');

		var code_4_6 = new cntCode('406','办理-定制不成功');

		var code_4_7 = new cntCode('407','办理-无法取消业务');

		var code_4_8 = new cntCode('408','使用-订购后未收到提醒短信');

		var code_4_9 = new cntCode('409','使用-下载后与实际游戏不符');

		var code_4_10 = new cntCode('410','使用-业务无法正常访问或站内功能无法正常使用');

		var code_4_11 = new cntCode('411','使用-订制正常，业务无法使用');

		var code_4_12 = new cntCode('412','使用-客户端无法正常下载安装');

		var code_4_13 = new cntCode('413','使用-对产品规定/流程不满');

		var code_4_14 = new cntCode('414','使用-使用不方便');

		var code_4_15 = new cntCode('415','资费-计费错误');

		var code_4_16 = new cntCode('416','资费-取消业务后仍收费');

		var code_4_17 = new cntCode('417','资费-收费和宣传不相符');

		var code_4_18 = new cntCode('418','资费-多收取信息费/流量费');

		

		var types = {};

		var codeArray1 = new Array();

		var codeArray2 = new Array();

		var codeArray3 = new Array();

		var codeArray4 = new Array();

		codeArray1.push(code_1_1);

		

		codeArray2.push(code_2_1);

		codeArray2.push(code_2_2);

		codeArray2.push(code_2_3);

		

		codeArray3.push(code_3_1);

		codeArray3.push(code_3_2);

		

		codeArray4.push(code_4_1);

		codeArray4.push(code_4_2);

		codeArray4.push(code_4_3);

		codeArray4.push(code_4_4);

		codeArray4.push(code_4_5);

		codeArray4.push(code_4_6);

		codeArray4.push(code_4_7);

		codeArray4.push(code_4_8);

		codeArray4.push(code_4_9);

		codeArray4.push(code_4_10);

		codeArray4.push(code_4_11);

		codeArray4.push(code_4_12);

		codeArray4.push(code_4_13);

		codeArray4.push(code_4_14);

		codeArray4.push(code_4_15);

		codeArray4.push(code_4_16);

		codeArray4.push(code_4_17);

		codeArray4.push(code_4_18);

		

		types.c1 = codeArray1;

		types.c2 = codeArray2;

		types.c3 = codeArray3;

		types.c4 = codeArray4;

	}	

  $(function() {

  	 $('#busiType').change(function() {

  	 	$('#validateDiv').css('display','none');

  	 	var type = $('#busiType').val();

  	 	var opr_type = new Array();

  	 	if(type == '42') {

  	 		opr_type.push('<option value="001">业务黑名单用户查询</option>');

  	 		opr_type.push('<option value="002">阅读记录查询</option>');

  	 		opr_type.push('<option value="003">书籍信息查询</option>');

  	 		opr_type.push('<option value="004">书卷查询</option>');

  	 		opr_type.push('<option value="005">包月记录查询</option>');

  	 		opr_type.push('<option value="006">点播订购查询</option>');

  	 		opr_type.push('<option value="007">手持绑定关系查询</option>');
  	 		
  	 		opr_type.push('<option value="008">充值记录查询</option>');
  	 		opr_type.push('<option value="009">短信上下行查询</option>');

  	 	}else if(type == '57') {

  	 		opr_type.push('<option value="001">黑名单查询</option>');

  	 		opr_type.push('<option value="002">消费记录查询</option>');

  	 		opr_type.push('<option value="003">套餐订购关系查询</option>');

  	 		opr_type.push('<option value="004">套餐订购记录查询</option>');

  	 		opr_type.push('<option value="005">点数充值记录查询</option>');

  	 		opr_type.push('<option value="006">点数余额查询</option>');
  	 		opr_type.push('<option value="007">业务基本信息查询</option>');
  	 		opr_type.push('<option value="008">营销消息屏蔽查询</option>');
  	 		/*2014/08/05 14:05:26 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
  	 			手机游戏 
  	 			用户信息查询 灰名单查询 核查查询 使用记录查询
  	 		*/
  	 		opr_type.push('<option value="009">用户信息查询</option>');
  	 		opr_type.push('<option value="010">灰名单查询</option>');
  	 		opr_type.push('<option value="011">核查查询</option>');
  	 		opr_type.push('<option value="012">使用记录查询</option>');
  	 	}else if(type == '82') {
  	 		opr_type.push('<option value="001">营销短彩信查询</option>');
  	 		opr_type.push('<option value="002">包月信息查询</option>');
  	 		opr_type.push('<option value="003">点播订购查询</option>');
  	 		opr_type.push('<option value="005">异常稽核用户查询</option>');
  	 		opr_type.push('<option value="006">灰名单查询</option>');
  	 		/*2014/08/05 10:01:51 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
  	 			手机视频 加入 使用记录查询 业务黑名单查询
  	 		*/
  	 		opr_type.push('<option value="007">使用记录查询</option>');
  	 		opr_type.push('<option value="008">黑名单查询</option>');
  	 		
  	 		opr_type.push('<option value="009">用户账户查询</option>');
  	 		opr_type.push('<option value="010">充值记录查询</option>');
  	 		opr_type.push('<option value="011">消费记录查询</option>');
  	 		

  	 	}else if(type == '72') {
  	 		opr_type.push('<option value="001">短/彩信黑名单查询</option>');
  	 		opr_type.push('<option value="002">点播订购查询</option>');
  	 		
  	 		opr_type.push('<option value="003">会员历史操作记录查询</option>');
  	 		opr_type.push('<option value="004">包月历史操作记录查询</option>');
  	 		opr_type.push('<option value="005">单次消费历史记录查询</option>');
  	 		opr_type.push('<option value="006">彩铃订购历史记录查询</option>');
  	 		opr_type.push('<option value="007">合作渠道黑名单查询</option>');
  	 		opr_type.push('<option value="008">短信上下行记录查询</option>');
  	 		
  	 	}else if(type == '64') {

  	 		opr_type.push('<option value="001">用户账户余额查询</option>');

  	 		opr_type.push('<option value="002">缴话费交易查询</option>');

  	 		opr_type.push('<option value="003">电子卷查询</option>');

  	 		opr_type.push('<option value="004">用户订单信息列表查询</option>');

  	 		opr_type.push('<option value="005">用户订单详细信息查询</option>');

  	 		opr_type.push('<option value="006">用户开销户历史查询</option>');
  	 		
  	 		opr_type.push('<option value="007">订购关系查询</option>');
  	 		opr_type.push('<option value="008">账户充值查询</option>');
  	 		opr_type.push('<option value="009">自动充话费查询</option>');
  	 		opr_type.push('<option value="010">实名认证关联手机号查询</option>');
  	 		opr_type.push('<option value="011">交流量明细查询</option>');
  	 	
  	 	}else if(type == '40') {
  	 		opr_type.push('<option value="001">开放订购信息查询</option>');
  	 		opr_type.push('<option value="002">开放全部日志查询</option>');
  	 		opr_type.push('<option value="003">主动密钥请求日志查询</option>');
  	 		opr_type.push('<option value="004">业务订购日志查询</option>');
  	 		opr_type.push('<option value="005">业务开通日志查询</option>');
  	 		opr_type.push('<option value="006">GBA初始化日志查询</option>');
  	 		opr_type.push('<option value="007">SG业务下载日志查询</option>');
  	 		opr_type.push('<option value="008">订购密钥请求日志查询</option>');
  	 		opr_type.push('<option value="009">订购关系日志查询</option>');
  	 		opr_type.push('<option value="010">订购关系更新日志查询</option>');
  	 		opr_type.push('<option value="011">开放最新订购记录查询</option>');
  	 	}else if (type == '95'){
  	 	  opr_type.push('<option value="001">点播记录查询</option>');
  	 		opr_type.push('<option value="002">包月信息查询</option>');
  	 		opr_type.push('<option value="003">黑名单查询</option>');
  	 		/*2014/08/05 8:56:31 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口） 
  	 			当业务类别为“咪咕动漫”时
  	 			
  	 		*/
  	 		/*异常行为用户查询*/
  	 		opr_type.push('<option value="004">灰名单查询</option>');
  	 		/*用户接收状态查询*/
  	 		opr_type.push('<option value="005">动漫杂志接收状态查询</option>');
  	 		opr_type.push('<option value="006">包月配额查询</option>');
  	 		opr_type.push('<option value="007">充值记录查询</option>');
  	 		opr_type.push('<option value="008">漫币消费记录查询</option>');
  	 		opr_type.push('<option value="009">漫币代购记录查询</option>');
  	 		
  	 		opr_type.push('<option value="010">包月订购关系历史记录查询</option>');
  	 		opr_type.push('<option value="011">消费记录查询</option>');
  	 		opr_type.push('<option value="012">用户账户查询</option>');
  	 		
  	 		opr_type.push('<option value="013">短信上下行查询</option>');
  	 		opr_type.push('<option value="014">核查</option>');

  	 	}else if (type == '70'){
  	 	  opr_type.push('<option value="001">通信账户支付历史订购查询</option>');
  	 	  opr_type.push('<option value="002">短信上下行查询</option>');
  	 	  opr_type.push('<option value="003">黑名单查询</option>');
  	 	  opr_type.push('<option value="004">话费业务查询</option>');
  	 	}else if(type == '41') {
  	 		/*MobileMarket 2014/08/05 14:34:32 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知*/
  	 		opr_type.push('<option value="001">MM订购黑名单查询</option>');
  	 		opr_type.push('<option value="002">MM订购关系查询</option>');
  	 		opr_type.push('<option value="003">用户订购异常行为核查</option>');
  	 		opr_type.push('<option value="004">用户短信上下行日志查询</option>');
  	 		opr_type.push('<option value="005">用户轨迹行为核查</option>');
  	 		opr_type.push('<option value="006">用户日月限额查询</option>');
  	 		opr_type.push('<option value="007">用户图形验证码查询</option>');
  	 		
  	 	}else if(type == '99') {
  	 		/*MobileMarket 2014/08/05 14:34:32 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知*/
  	 		opr_type.push('<option value="001">IVR拨打记录查询</option>');
  	 		opr_type.push('<option value="002">MDO订购关系查询</option>');
  	 	}else if(type == '62') {//139邮箱
  	 		opr_type.push('<option value="001">139邮箱账号信息查询</option>');
  	 		opr_type.push('<option value="002">营销类邮件屏蔽查询</option>');
  	 	}else if(type == '54') {//手机导航
  	 		opr_type.push('<option value="001">和地图订购关系履历查询</option>');
  	 		opr_type.push('<option value="002">和地图订购关系状态查询</option>');
  	 		opr_type.push('<option value="003">和地图订购黑名单查询</option>');
  	 	}else if(type == '130') {//12582
  	 		opr_type.push('<option value="001">订购历史查询</option>');
  	 		opr_type.push('<option value="002">内容定制关系查询</option>');
  	 		opr_type.push('<option value="003">下发历史记录查询</option>');
  	 		opr_type.push('<option value="004">业务黑名单查询</option>');
  	 	}else if(type == '50') {//12580
  	 		opr_type.push('<option value="001">12580订购关系查询</option>');
  	 		opr_type.push('<option value="002">历史记录查询</option>');
  	 		opr_type.push('<option value="003">点播记录查询</option>');
  	 	}else if(type == '121') {//12590
  	 		opr_type.push('<option value="001">拨打记录查询</option>');
  	 		opr_type.push('<option value="002">客户端业务使用查询</option>');
  	 		opr_type.push('<option value="003">用户短信上下行查询</option>');
  	 		opr_type.push('<option value="004">黑名单查询</option>');
  	 		
  	 		opr_type.push('<option value="005">所有消费记录查询</option>');
  	 		opr_type.push('<option value="006">按次业务查询</option>');
  	 		opr_type.push('<option value="007">按时长业务查询</option>');
  	 		opr_type.push('<option value="008">灰名单查询</option>');
  	 		
  	 	}else if(type == '47') {//12590
  	 		opr_type.push('<option value="001">短信上下行查询</option>');
  	 		opr_type.push('<option value="002">MDO订购关系查询</option>');
  	 		opr_type.push('<option value="003">黑名单查询</option>');
  	 	}
  	 	
  	 	
  	 	$('#indictSeq').val("");
  	 	

  	 	$('#oprType').empty().append(opr_type.join(''));

		/*
  	 	if(type == '64') {

  	 		$('#oprType[@value="007"]').change();	

  	 	}else {

  	 		$('#oprType[@value="001"]').change();	

  	 	}
*/
  	 	$('#oprType').change();	

  	 	

  	 	//如果查询过，切换业务类别时，清空查询结果列表

  	 	if(search_flag) {

  	 		clearResultIframe();

  	 	}

  	 });

  	

  	 $("#busiType[@value='42']").change();

  	 

	 $('#oprType').change(function() {

	 	$('#validateDiv').css('display','none');

	 	var busiType = $('#busiType').val();

		var oprType = $('#oprType').val();

		$('.tbody_form').css('display','none');	
		//alert('#d_' + busiType + '_' + oprType);
	 	$('#d_' + busiType + '_' + oprType).css('display','block');	
	 	
	 	if(busiType=="99") {
	 	document.all.ivr_backEnd.disabled=false;
	 	}else {
	 	document.all.ivr_backEnd.disabled=true;
	 	}

	 	//如果查询过，切换业务类别时，清空查询结果列表

  	 	if(search_flag) {

  	 		clearResultIframe();

  	 	}

	 });

  	

  	 /*liujian 手机游戏 受理类型和受理内容联动 2012-5-4 14:23:20 */

  	 $('#d_57_002_type').change(function() {

		var d_type = $('#d_57_002_type').val();

		var d_cnt = new Array();

		for(var i=0,len=types['c'+d_type].length;i<len;i++) {

			var codeObj = types['c'+d_type];

			d_cnt.push('<option value=' + codeObj[i].code + '>' + codeObj[i].name + '</option>');

		}

		$('#d_57_002_connect').empty().append(d_cnt.join(''));

		//设置select的宽度

		$('#d_57_002_connect').css('width',"270px");	

	 });

	  

  $('#searchBtn').click(function() {
		//1. 获得选择的业务类别
		var busiType = $('#busiType').val();

		//2. 获得操作类型
		var oprType = $('#oprType').val();
		var qry_type = $('#qryType').val();
		if ( busiType == '42')
		{
			if ( oprType != '001' && qry_type == '')
			{
				
				rdShowMessageDialog("类型必须选择!",0);
				return false;
			}
		}
		else
		{
			if (qry_type == '')
			{
				rdShowMessageDialog("类型必须选择!",0);
				return false;	
			}
		}
		
		if ( $('#d_64_002_phone').val()=='' && $( 'd_64_002_payPhone' ).val()=='' )
		{
			rdShowMessageDialog('手机号和缴费手机号不能同时为空',0);
			return false;
		}
		
		//3. 获取form表单
		//new Function('getValue_' + busiType + '_' + oprType + '()')();

		if(!checkObj($('#d_' + busiType + '_' + oprType))){
			return false;
		}

		var beginDate = '';
		var endDate = '';
		var $begTime = $('#d_' + busiType + '_' + oprType + '_begTime');
		var $endTime = $('#d_' + busiType + '_' + oprType + '_endTime');
		
		var vType = $begTime.attr('v_type');
		if(($begTime.val() || $endTime.val()) && (vType == 'date_time' || vType == 'date')){
			if(compareDatesByType($begTime[0],$endTime[0],vType)==-1){
	   			rdShowMessageDialog("开始时间输入格式不正确,请重新输入!");
	   			$begTime.focus();
	  		  return false;
			}

			if(compareDatesByType($begTime[0],$endTime[0],vType)==-2){
         rdShowMessageDialog("结束时间输入格式不正确,请重新输入!");
         $endTime.focus();
         return false;
			}

			if(compareDatesByType($begTime[0],$endTime[0],vType)==1){
         rdShowMessageDialog("开始时间应大于结束时间,请重新输入!");
         $endTime.focus();
         return false;
			}

			//设置时间 时间查询跨度不能超过1年
			if((busiType == '57' && oprType!='004') || (busiType == '72' && oprType!='005')|| busiType == '82') {
				var beginT = $begTime.val();
				var endT = $endTime.val();
				var rb = beginT.replace(/\D/g, "");
				var re = endT.replace(/\D/g, "");
				if(rb && re && (parseFloat(re) - parseFloat(rb) > 10000000000)) {
					rdShowMessageDialog("开始时间与结束时间跨度不能超过一年,请重新输入!");
	        $endTime.focus();
	        return false;
				}
			}
			
			//设置时间 时间查询跨度不能超过5天
			if(busiType == '40') {
				if (oprType != '001' && oprType != '011'){
					var beginT = $begTime.val();
					var endT = $endTime.val();
					var rb = beginT.replace(/-/g, "/");
					var re = endT.replace(/-/g, "/");
					var endDate = new Date(re);
					var begDate = new Date(rb);
					if(rb && re && (endDate.getTime() - begDate.getTime() > 5 * 24 * 60 * 60 * 1000)) {
						rdShowMessageDialog("开始时间与结束时间跨度不能超过5天,请重新输入!");
		        $endTime.focus();
		        return false;
					}
				}
			}
			
			//设置时间 时间查询跨度不能超过一个月
			if(busiType == '72' && oprType == '005') {
					var beginT = $begTime.val();
  				var endT = $endTime.val();
  				var rb = beginT.replace(/\D/g, "");
  				var re = endT.replace(/\D/g, "");
  				if(rb && re && (parseFloat(re) - parseFloat(rb) > 100000000)) {
  					rdShowMessageDialog("开始时间与结束时间跨度不能超过一个月,请重新输入!");
  	        $endTime.focus();
  	        return false;
  				}
			}
		}	

		var $phoneNo = $('#d_' + busiType + '_' + oprType + '_phone');
		/*
		if($phoneNo.attr('id') && !$.trim($phoneNo.val())) {
			rdShowMessageDialog("手机号码不能为空");
			return false;	
		}
		*/

		if(busiType == '64' && oprType== '004') {
			if($.trim($('#d_64_004_phone').val())=='' && $.trim($('#d_64_004_byname').val())=='') {
				rdShowMessageDialog("手机号和别名必须输入一项!");
        $('#d_64_004_phone').focus();
        return false;
			}
		}
		
		if(busiType == '64' && oprType== '011') {
			if($.trim($('#d_64_011_pay_no').val())=='' && $.trim($('#d_64_011_pay_no_n').val())=='') {
				rdShowMessageDialog("支付号码和被充值号码必须输入一项!");
        return false;
			}
			
					var beginT =$.trim($('#d_64_011_begTime').val()) ;
  				var endT = $.trim($('#d_64_011_endTime').val());
			
        if(beginT.substring(0,4)==endT.substring(0,4)) {
            if(beginT.substring(4,6)==endT.substring(4,6)) {
						}else {
						rdShowMessageDialog("开始时间与结束时间跨度不能超过一个月,请重新输入!");
  	        return false;
						}
        }else {
          	rdShowMessageDialog("开始时间与结束时间跨度不能超过一个月,请重新输入!");
  	        return false;
        }
  				
		}
		
		
		var phoneNo = "";
		if(!$phoneNo.attr('id')) {
			phoneNo="";
		}else {
			phoneNo = $.trim($phoneNo.val());	
		}
		//showBox();
		var resultStr = getValue('d_' + busiType + '_' + oprType);
		//alert(resultStr);
		if(busiType == '64' && oprType== '007') {
			//busiType = '70';	
		}
		if(busiType == '99') {
			
			    		var jsonstr='[';
    		
    		   $('#d_'+busiType+'_'+oprType+' tr').each(
    		    function(){
    		    	 if($(this).find("td:eq(0)").html()!=null && $(this).find("td:eq(0)").html()!="") {
							jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(0)").html()+'"';
							
							}
							if($(this).find("td:eq(1)").html()!=null && $(this).find("td:eq(1)").html()!="") {
								
								if($(this).find("td:eq(1) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) select option:selected").text()+'"},';
								}
								if($(this).find("td:eq(1) input").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) input").val()+'"},';
								}						
							
							}						
							
							 if($(this).find("td:eq(2)").html()!=null && $(this).find("td:eq(2)").html()!="") {
							 	jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(2)").html()+'"';
							}
							
								if($(this).find("td:eq(3)").html()!=null && $(this).find("td:eq(3)").html()!="") {
								
								if($(this).find("td:eq(3) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) select option:selected").text()+'"},';
								}
								 
								if($(this).find("td:eq(3) input").val()!=undefined) {
									//alert($(this).find("td:eq(3) input").val());
									if($(this).find("td:eq(3) input").hasClass('ignore')) {
  								                       	
					         var tsss = '';
					        $(':checked').each(function () {
					            if (tsss == ''){
					                tsss += $(this).next().html();
					            }else {
					                tsss += ',' + $(this).next().html();
					            }
					        });
					            jsonstr=jsonstr+',"value":"'+tsss+'"},';
                             
									}else {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) input").val()+'"},';
									}
								}						
							
							}
							
						
            }
           );
           jsonstr=jsonstr.substring(0,(jsonstr.length-1));
           jsonstr=jsonstr+']';
           //alert(jsonstr);
           
           //$('#jsontext').val(jsonstr);
			
		document.resultIframe.location='fe827_frame_mdo.jsp?opCode=<%=opCode%>&phoneNo=' + phoneNo + '&busiType='+ busiType + '&oprType=' + oprType + '&infoStr=' + resultStr+'&bp_name=<%=bp_name%>&sm_codes=<%=sm_codes%>&xingjis=<%=xingjis%>&jsonstr='+jsonstr;	
		}else {
		document.resultIframe.location="fe827_frame.jsp?opCode=<%=opCode%>&phoneNo=" + phoneNo + "&busiType="+ busiType + "&oprType=" + oprType + "&infoStr=" + resultStr;
		}
		search_flag = true;
  });

  	 

  	 

  	 /* liujian 重置 2012-5-4 13:32:02 */

  	 $('#clearBtn').click(function() {
  	 
  	 window.location.href = "fe827_1.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";

  	 	//$('input[type="text"]').val('');

		$("select").each(function(){

			//$(this).get(0).options[0].selected = true;  

		});

		$("#busiType[value=42]").change();

  	 //	window.frames["resultIframe"].clearTable();	

  	 });

 

  });

  		

  //获得this.id是id的tbody内的form表单，只限input和select

  function getValue(id) {

	var arr = new Array();

	$('#' + id).find('td').each(function(i){

		var $this = $(this);

		$this.find('input').each(function(){

			arr.push($(this).val());

		});

		$this.find('select').each(function(){

			arr.push($(this).val());

		});

	}); 

	return arr.join('|');

  }



  

/*

  function listQry() {

  		var groupNo = $('#groupNo').val();

			var beginNo = $('#beginNo').val();

  		var endNo = $('#endNo').val();

  		document.middle.location="fe767_2.jsp?opCode=<%=opCode%>&groupNo="+ groupNo + "&beginNo=" + beginNo + "&endNo=" + endNo;

  }

 */ 

  function showIfTable() {

  	window.frames["resultIframe"].showTable();	

  }

  

	function check() {

		

	}

  	

	function showBox() {

		showLightBox();

	}

	

	function hideBox() {

		hideLightBox();	

	}

	

	function clearResultIframe() {

		window.frames["resultIframe"].clearTable();	

	}

	

	function setByName() {

		if($('#d_64_004_phone').val())	{

			if(!$('#d_64_004_byname').val())	{

					$('#d_64_004_byname').val($('#d_64_004_phone').val())

			}

		}

	}

//比较时间大小

function compareDatesByType(obj1,obj2,type)

{

	var date1=obj1.value;

	var dateformat1 = '';

	var date2= obj2.value;

	var dateformat2 = '';

	if(type == 'date_time') {

		dateformat1	= 'yyyy-MM-dd HH:mm:ss';

		dateformat2	= 'yyyy-MM-dd HH:mm:ss';

	}else if(type == 'date') {

		dateformat1	= 'yyyyMMdd';

		dateformat2	= 'yyyyMMdd';	

	}

	var d1=getDateFromFormat(date1,dateformat1);

	var d2=getDateFromFormat(date2,dateformat2);

	if (d1==0 )

		return -1;

	else if(d2==0)

		return -2;

	else if (d1 > d2)

		return 1;

	return 0;

}


	function goBackEnd(){//查询之后再选择其他的查询类型后，则不能进行归档未修改还，
	
	var indictSeq_token = $('#indictSeq').val();
	
		if(indictSeq_token==""){
			  		rdShowMessageDialog("请先查询数据再归档！");
  	        return false;
		}else{
		
		var busiType = $('#busiType').val();
		var oprType = $('#oprType').val();		
		
		var jsonstr='[';
    		
    		   $('#d_'+busiType+'_'+oprType+' tr').each(
    		    function(){
    		    	 if($(this).find("td:eq(0)").html()!=null && $(this).find("td:eq(0)").html()!="") {
							jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(0)").html()+'"';
							
							}
							if($(this).find("td:eq(1)").html()!=null && $(this).find("td:eq(1)").html()!="") {
								
								if($(this).find("td:eq(1) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) select option:selected").text()+'"},';
								}
								if($(this).find("td:eq(1) input").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) input").val()+'"},';
								}						
							
							}						
							
							 if($(this).find("td:eq(2)").html()!=null && $(this).find("td:eq(2)").html()!="") {
							 	jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(2)").html()+'"';
							}
							
								if($(this).find("td:eq(3)").html()!=null && $(this).find("td:eq(3)").html()!="") {
								
								if($(this).find("td:eq(3) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) select option:selected").text()+'"},';
								}
								 
								if($(this).find("td:eq(3) input").val()!=undefined) {
									//alert($(this).find("td:eq(3) input").val());
									if($(this).find("td:eq(3) input").hasClass('ignore')) {
  								                       	
					         var tsss = '';
					        $(':checked').each(function () {
					            if (tsss == ''){
					                tsss += $(this).next().html();
					            }else {
					                tsss += ',' + $(this).next().html();
					            }
					        });
					            jsonstr=jsonstr+',"value":"'+tsss+'"},';
                             
									}else {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) input").val()+'"},';
									}
								}						
							
							}
							
						
            }
           );
           jsonstr=jsonstr.substring(0,(jsonstr.length-1));
           jsonstr=jsonstr+']';
           //alert(jsonstr);
           
           $('#jsontext').val(jsonstr);
		     var resultStrss = getValue('d_' + busiType + '_' + oprType);
		     $('#resultStrss').val(resultStrss);
		
				document.frm.action = "fe827_1_backEnd.jsp";
   			document.frm.submit();
		}
	}
	
	function guanbis() {
	
	 	var busiType = $('#busiType').val();
	 	
	 	if(busiType=="99") {
	
	var indictSeq_token = $('#indictSeq').val();
	
		if(indictSeq_token==""){
			removeCurrentTab();
		}else{
		
		var busiType = $('#busiType').val();
		var oprType = $('#oprType').val();		
		
		var jsonstr='[';
    		
    		   $('#d_'+busiType+'_'+oprType+' tr').each(
    		    function(){
    		    	 if($(this).find("td:eq(0)").html()!=null && $(this).find("td:eq(0)").html()!="") {
							jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(0)").html()+'"';
							
							}
							if($(this).find("td:eq(1)").html()!=null && $(this).find("td:eq(1)").html()!="") {
								
								if($(this).find("td:eq(1) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) select option:selected").text()+'"},';
								}
								if($(this).find("td:eq(1) input").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(1) input").val()+'"},';
								}						
							
							}						
							
							 if($(this).find("td:eq(2)").html()!=null && $(this).find("td:eq(2)").html()!="") {
							 	jsonstr=jsonstr+'{"key":"'+$(this).find("td:eq(2)").html()+'"';
							}
							
								if($(this).find("td:eq(3)").html()!=null && $(this).find("td:eq(3)").html()!="") {
								
								if($(this).find("td:eq(3) select").val()!=undefined) {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) select option:selected").text()+'"},';
								}
								 
								if($(this).find("td:eq(3) input").val()!=undefined) {
									//alert($(this).find("td:eq(3) input").val());
									if($(this).find("td:eq(3) input").hasClass('ignore')) {
  								                       	
					         var tsss = '';
					        $(':checked').each(function () {
					            if (tsss == ''){
					                tsss += $(this).next().html();
					            }else {
					                tsss += ',' + $(this).next().html();
					            }
					        });
					            jsonstr=jsonstr+',"value":"'+tsss+'"},';
                             
									}else {
									jsonstr=jsonstr+',"value":"'+$(this).find("td:eq(3) input").val()+'"},';
									}
								}						
							
							}
							
						
            }
           );
           jsonstr=jsonstr.substring(0,(jsonstr.length-1));
           jsonstr=jsonstr+']';
           //alert(jsonstr);
           
           $('#jsontext').val(jsonstr);
		
		    $('#guidangflag').val("1");
				document.frm.action = "fe827_1_backEnd.jsp";
   			document.frm.submit();
		}
	
		 	}else {
	removeCurrentTab();
	 	}
	
	
	}

</script>



<body>

<form name="frm" action="fe827_2.jsp" method="post" >

<%@ include file="/npage/include/header.jsp" %>

		<div class="title">

			<div id="title_zi"><%=opName%></div>

		</div>

		<input type="hidden" value=""  id="opCode" name="opCode" />

		<input type="hidden" value=""  id="opName" name="opName" />
		
		<input type="hidden" value=""  id="indictSeq" name="indictSeq" />
	  <input type="hidden" value="<%=activePhone%>"  id="indictSeqphone" name="indictSeqphone" />	
	  <input type="hidden" value=""  id="jsontext" name="jsontext" />
	  <input type="hidden" value=""  id="resultStrss" name="resultStrss" />
	  <input type="hidden" value=""  id="guidangflag" name="guidangflag" />
	  

		<div>

				<table cellspacing=0>

				    <tr>

				        <td class='blue' width="15%">业务类别</td>

				        <td width="35%">

				        	<select id="busiType">

				        		<option value="42">咪咕阅读</option>

				        		<option value="57">咪咕游戏</option>

				        		<option value="64">手机支付</option>

					        	<option value="72">咪咕音乐</option>

										<option value="82">咪咕视频</option>
										
										<option value="95">咪咕动漫</option>
										<option value="70">通信账户支付</option>
										<option value="41">MobileMarket</option>
										<option value="99">MDO查询</option>
										
										<option value="62">139邮箱</option>
										<option value="54">手机导航</option>
										<option value="130">12582基地</option>
										<option value="50">12580业务</option>
										<option value="121">12590语音杂志业务</option>
										<option value="47">卓望MDO</option>
										
							</select>

				        </td>

				        <td class='blue' width="15%">操作类型</td>

				        <td  width="35%">

				        	<select id="oprType">

							</select>

				        </td>

				    </tr>    

				    <!-- 手机阅读42--黑名单查询-->

				    <tbody id="d_42_001" class="tbody_form" >

				   		<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_42_001_phone" id="d_42_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

								<font class="orange">*</font>

					        </td>

					        <td class='blue'>类型</td>

					        <td>

					        	<!--

								<input type="radio" name="d_42_001_type" id="d_42_001_type0" value="0" checked>短信

								<input type="radio" name="d_42_001_type" id="d_42_001_type1" value="1">彩信

								<input type="radio" name="d_42_001_type" id="d_42_001_type2" value="2">Wap Push

								-->

								<select id = 'qry_type' name = 'qry_name'>
									<option value="0">短信</option>

									<option value="1">彩信</option>

									<option value="2">Wap Push</option>
									
									<option value="3">图形验证码</option>
									<option value="4">订购黑名单用户</option>
									

								</select>

					        </td>

					    </tr>

					</tbody>

				    <!-- 手机阅读--阅读记录查询-->

					<tbody id="d_42_002" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_42_002_phone" id="d_42_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>阅读开始时间</td>

					        <td>

					        	<input name="d_42_002_begTime" type="text" id="d_42_002_begTime" value="<%=bMon%>"  v_must ='1' 
										onclick="WdatePicker({el:'d_42_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
					        	maxlength="19"  v_type="date_time" onblur = "checkElement(this)"/>

					        	
					        		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>阅读结束时间</td>

					        <td>

								<input name="d_42_002_endTime" type="text" id="d_42_002_endTime" value="<%=mon[0]%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>阅读途径</td>

					        <td>

					        	<select id="d_42_002_path">

					        		<option value="0">所有</option>

					        		<option value="1">wap</option>

					        		<option value="2">www</option>

					        		<option value="3">电子书</option>

					        		<option value="4">客户端</option>

					        		<option value="11">平板电脑</option>

								</select>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>内容类型</td>

					        <td>

								<select id="d_42_002_cntType">

									<option value="0">所有</option>

					        		<option value="1">图书</option>

					        		<option value="2">漫画</option>

					        		<option value="3">杂志</option>

					        		<option value="5">听书</option>

								</select>

					        </td>

					        <td class='blue'>书名</td>

					        <td>

					        	<input name="d_42_002_book" type="text"  id="d_42_002_book" maxlength="300" value="" 

					        	  onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>章节名称</td>

					        <td>

					        	<input name="d_42_002_chapter" type="text" id="d_42_002_chapter" maxlength="300" 

					        	value="" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>

					<!-- 手机阅读--书籍信息查询-->

					<tbody id="d_42_003" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>书项名称</td>

					        <td>

								<input type="text" name="d_42_003_book" id="d_42_003_book" value="" v_must ='1'

								maxlength="128" onblur = "checkElement(this)"/><font class="orange">*</font>

					        </td>

					        <td class='blue'>MCP名称</td>

					        <td>

								<input type="text" name="d_42_003_mcp" id="d_42_003_mcp" value="" maxlength="100" 

								onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>作家笔名</td>

					        <td>

								<input type="text" name="d_42_003_author" id="d_42_003_author" value="" 

								maxlength="40" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>

					<!-- 手机阅读--书卷查询-->	

					<tbody id="d_42_004" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>用户手机号码</td>

					        <td colspan="3">

								<input type="text" name="d_42_004_phone" id="d_42_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					       		<font class="orange">*</font>

					        </td>



					    </tr>

					    <tr>

					        <td class='blue'>书券名</td>

					        <td>

								<input type="text" name="d_42_004_book" id="d_42_004_book" 

							value="" maxlength="256" onblur = "checkElement(this)"/>

								

					        </td>

					        <td class='blue'>书券ID</td>

					        <td>

								<input type="text" name="d_42_004_id" id="d_42_004_id" value="" 

								maxlength="10"  onblur = "checkElement(this)"/>

								

					        </td>

					    </tr>

						<tr>

					        <td class='blue'>用户消费开始时间</td>

					        <td>

					        	<input name="d_42_004_begTime" type="text" id="d_42_004_begTime" value="<%=bMon%>"
										onclick="WdatePicker({el:'d_42_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)" />

					        		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
											<font class="orange">(yyyy-mm-dd hh24:mi:ss)</font>

					        </td>

					        <td class='blue'>用户消费结束时间</td>

					        <td>

								<input name="d_42_004_endTime" type="text" id="d_42_004_endTime" value="<%=mon[0]%>"
								onclick="WdatePicker({el:'d_42_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)</font>

					        </td>

					    </tr>

					</tbody>

					<!-- 手机阅读--包月记录查询-->

				    <tbody id="d_42_005" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_42_005_phone" id="d_42_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- 手机阅读--点播订购查询-->

					<tbody id="d_42_006" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_42_006_phone" id="d_42_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>书名</td>

					        <td>

					        	<input name="d_42_006_book" type="text" id="d_42_006_book" value=""  

					        	maxlength="100" onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>订购起始时间</td>

					        <td>

								<input name="d_42_006_begTime" type="text" id="d_42_006_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>订购结束时间</td>

					        <td>

								<input name="d_42_006_endTime" type="text" id="d_42_006_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_42_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>计费方式</td>

					        <td>
								<select id="d_42_006_billing">

									<option value="0" selected>全部</option>
									<option value="1">按本计费</option>
									<option value="2">按章计费</option>
									<option value="3">按千字计费</option>
									<option value="4">包月</option>
									<option value="5">促销包</option>
									<option value="7">按册</option>
									<option value="15">免费</option>
								</select>

					        </td>

					        <td class='blue'>内容类型</td>

					        <td>

					        	<select id="d_42_006_content">

									<option value="0">所有</option>

					        		<option value="1">图书</option>

					        		<option value="2">漫画</option>

					        		<option value="3">杂志</option>

					        		<option value="5">听书</option>

								</select>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>是否赠送</td>

					        <td>

					        	<select id="d_42_006_send">

									<option value="-1" selected>全部</option>

									<option value="1">是</option>

									<option value="0">否</option>

								</select>

					        </td>

					        <td class='blue'>订购途径</td>

					        <td>

					        	<select id="d_42_006_path">
									<option value="0" selected>所有</option>
									<option value="1" >wap</option>

									<option value="2">www</option>

									<option value="3">手持终端</option>

									<option value="4">客户端软件</option>

									<option value="5">客服</option>

									<option value="6">boss</option>

									<option value="7">短信</option>

								</select>

							</td>

					    </tr>

					    <tr>

					    	<td class='blue'>章节名称</td>

					        <td>

								<input name="d_42_006_chapter" type="text" id="d_42_006_chapter" value=""  

								maxlength="100" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'></td>

					        <td></td>

						</tr>

					</tbody>

					<!-- 手机阅读--手持绑定关系查询-->

				    <tbody id="d_42_007" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>计费卡号</td>

					        <td>

								<input type="text" name="d_42_007_card" id="d_42_007_card" value="<%=activePhone%>"  readonly class="InputGrey" v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- 咪咕阅读42--008	充值记录查询-->

				    <tbody id="d_42_008" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_42_008_phone" id="d_42_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>

					    </tr>

					    <tr>

					        <td class='blue'>充值起始时间</td>

					        <td>

								<input name="d_42_008_begTime" type="text" id="d_42_008_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>充值结束时间</td>

					        <td>

								<input name="d_42_008_endTime" type="text" id="d_42_008_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_42_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

	<tr>

					        
					        
					        <td class='blue'>充值方式</td>

					        <td>
					        	<select id="d_42_008_type" name="d_42_008_type">
					        		<option value="0">银联充值</option>
					        		<option value="8">Appstore充值</option>
					        		<option value="9">联通充值</option>
					        	</select>
					        </td>
								<td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>
					    </tr>
					    
					    
					</tbody> 					


	<!-- “12590语音杂志业务”  121	005	所有消费记录查询-->

				    <tbody id="d_121_005" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td colspan="3">

								<input type="text" name="d_121_005_phone" id="d_121_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    <tr>

					        <td class='blue'>开始时间</td>

					        <td>

								<input name="d_121_005_begTime" type="text" id="d_121_005_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_121_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_121_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_121_005_endTime" type="text" id="d_121_005_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_121_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 		
					
	<!-- “12590语音杂志业务”  121	006	按次业务查询-->

				    <tbody id="d_121_006" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td colspan="3">

								<input type="text" name="d_121_006_phone" id="d_121_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    <tr>

					        <td class='blue'>开始时间</td>

					        <td>

								<input name="d_121_006_begTime" type="text" id="d_121_006_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_121_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_121_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_121_006_endTime" type="text" id="d_121_006_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_121_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 						



	<!-- “12590语音杂志业务”  007	按时长业务查询-->

				    <tbody id="d_121_007" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td colspan="3">

								<input type="text" name="d_121_007_phone" id="d_121_007_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    <tr>

					        <td class='blue'>开始时间</td>

					        <td>

								<input name="d_121_007_begTime" type="text" id="d_121_007_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_121_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_121_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_121_007_endTime" type="text" id="d_121_007_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_121_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 	
					<!-- “12590语音杂志业务”  008	灰名单查询-->

				    <tbody id="d_121_008" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_121_008_phone" id="d_121_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>

					        </td>


					    </tr>

					    

					</tbody> 	
															
					<!-- 手机游戏42--009	短信上下行查询-->
  			<tbody id="d_42_009" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_42_009_phone" id="d_42_009_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					       <td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>

					    </tr>

					    <tr>

					        <td class='blue'>发送开始时间</td>

					        <td>

								<input name="d_42_009_begTime" type="text" id="d_42_009_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_42_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_42_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>发送结束时间</td>

					        <td>

								<input name="d_42_009_endTime" type="text" id="d_42_009_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_42_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_42_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>
					    
					    
					    <tr>

					        
					        <td class='blue'>方向</td>

					        <td>
					        	<select id="d_42_009_type" name="d_42_008_type">
					        		<option value="0">上行</option>
					        		<option value="1">下行</option>
					        		<option value="2">全部</option>
					        	</select>
					        </td>
									<td class='blue'>&nbsp;</td>

					        <td class='blue'>&nbsp;</td>

					    </tr>
					    

					</tbody> 					
					
		<!-- 1）业务类别“无线音乐”改名为“咪咕音乐”；72--008	短信上下行记录查询-->
  			<tbody id="d_72_008" class="tbody_form" style="display:none">

				   	<tr>

					        <td class='blue'>用户手机号码</td>

					        <td colspan="3">

								<input type="text" name="d_72_008_phone" id="d_72_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					       

					    </tr>

					    <tr>

					        <td class='blue'>开始时间</td>

					        <td>

								<input name="d_72_008_begTime" type="text" id="d_72_008_begTime" value="<%=bMon%>"  v_must ='1' 
								onclick="WdatePicker({el:'d_72_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_72_008_endTime" type="text" id="d_72_008_endTime" value="<%=mon[0]%>" v_must ='1' 
								onclick="WdatePicker({el:'d_72_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

											<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody> 						

					<!-- 手机游戏57--黑名单查询-->

					<tbody id="d_57_001" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_57_001_phone" id="d_57_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- 手机游戏--消费记录查询-->

					<tbody id="d_57_002" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_57_002_phone" id="d_57_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey"   

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>起始日期</td>

					        <td>

					        	<input type="text" name="d_57_002_begTime" id="d_57_002_begTime" value="<%=bMon%>"  v_must ='1'
										onclick="WdatePicker({el:'d_57_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>截止日期</td>

					        <td>

								<input type="text" name="d_57_002_endTime" id="d_57_002_endTime" value="<%=mon[0]%>"  v_must ='1'
								onclick="WdatePicker({el:'d_57_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>受理类型</td>

					        <td>

					        	<select id="d_57_002_type">

					        		<option value="1">查询</option>

					        		<option value="2">咨询</option>

					        		<option value="3">办理</option>

					        		<option value="4">投诉</option>

								</select>

					        </td>

					    </tr>

					    <tr>

					    	<td class='blue'>受理内容</td>

					        <td>

					        	<select id="d_57_002_connect">

					        		<option value="101">扣费记录</option>

								</select>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody> 

					<!-- 手机游戏--套餐订购关系查询-->

					<tbody id="d_57_003" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_57_003_phone" id="d_57_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					    <tr>

					    	<td class='blue'>开始时间</td>

					        <td>

					        	<input name="d_57_003_begTime" type="text" id="d_57_003_begTime" value="<%=bMon%>"  
										onclick="WdatePicker({el:'d_57_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_57_003_endTime" type="text" id="d_57_003_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_57_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody>

					<!-- 手机游戏--套餐订购记录查询-->

					<tbody id="d_57_004" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_57_004_phone" id="d_57_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					    <tr>

					    	<td class='blue'>开始时间</td>

					        <td>

					        	<input name="d_57_004_begTime" type="text" id="d_57_004_begTime" value="<%=bMon%>"  v_must ='1'
										onclick="WdatePicker({el:'d_57_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					        		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_57_004_endTime" type="text" id="d_57_004_endTime" value="<%=mon[0]%>"   v_must ='1'
								onclick="WdatePicker({el:'d_57_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody>	

					<!-- 手机游戏--点数充值记录查询-->

					<tbody id="d_57_005" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_57_005_phone" id="d_57_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					    <tr>

					    	<td class='blue'>开始时间</td>

					        <td>

					        	<input name="d_57_005_begTime" type="text" id="d_57_005_begTime" value="<%=bMon%>"   v_must ='1'
										onclick="WdatePicker({el:'d_57_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_57_005_endTime" type="text" id="d_57_005_endTime" value="<%=mon[0]%>"  v_must ='1'
								onclick="WdatePicker({el:'d_57_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_57_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					</tbody>			

					<!-- 手机游戏--点数余额查询-->

					<tbody id="d_57_006" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_57_006_phone" id="d_57_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

								<font class="orange">*</font>

					        </td>

					        <td class='blue'></td><td></td>

					    </tr>

					</tbody>			

					<!-- 手机游戏--业务基本信息查询-->

					<tbody id="d_57_007" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>业务名称</td>

					        <td>

								<input type="text" name="d_57_007_name" id="d_57_007_name" value=""

								maxlength="200" onblur = "checkElement(this)"/>

					        </td>

					        <td class='blue'>业务代码</td>

					        <td>

								<input type="text" name="d_57_007_code" id="d_57_007_code" value=""

								maxlength="12" onblur = "checkElement(this)"/>

					        </td>

					    </tr>

					    <tr>

					    	<td class='blue'>套餐类型</td>

					    	<td class='blue'>

					    		<select id="d_57_007_type">

					        		<option value="0">全部</option>

					        		<option value="1">套餐</option>

					        		<option value="2">非套餐</option>

								</select>

					    	</td>

					    	<td class='blue'></td><td></td>

					    </tr>

					</tbody>	

					<!-- 手机游戏--营销消息屏蔽查询-->
					<tbody id="d_57_008" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td>
  								<input type="text" name="d_57_008_phone" id="d_57_008_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- 手机游戏--用户信息查询 57_009-->
					<tbody id="d_57_009" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td>
  								<input type="text" name="d_57_009_phone" id="d_57_009_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- 手机游戏--灰名单查询 57_010-->
					<tbody id="d_57_010" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td>
  								<input type="text" name="d_57_010_phone" id="d_57_010_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- 手机游戏--核查查询 57_011-->
					<tbody id="d_57_011" class="tbody_form" style="display:none">
							<tr>
								<td class="blue">操作日期</td>
								<td>
									<input name="d_57_011_opTime" type="text" id="d_57_011_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_57_011_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
											 value="<%=dateStr1111%>" readonly  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_011_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>	
								</td>
								<td class="blue">业务代码</td>
								<td>
									<input type="text" name="d_57_011_opNum"	id="d_57_011_opNum" value="" v_must ='1' onblur = "checkElement(this)"/>
									<font class="orange">*</font>
								</td>
							</tr>
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td colspan="3">
  								<input type="text" name="d_57_011_phone" id="d_57_011_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					</tbody>
					
					<!-- 手机游戏--使用记录查询 57_012-->
					<tbody id="d_57_012" class="tbody_form" style="display:none">
							<tr>
								<td class="blue">操作日期</td>
								<td>
									<input name="d_57_012_opTime" type="text" id="d_57_012_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_57_012_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
											readonly value="<%=dateStr1111%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_57_012_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>	
								</td>
								<td class="blue">业务代码</td>
								<td>
									<input type="text" name="d_57_012_opNum"	id="d_57_012_opNum" value=""  onblur = "checkElement(this)"/>
								 
								</td>
							</tr>
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td colspan="3">
  								<input type="text" name="d_57_012_phone" id="d_57_012_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					</tbody>

					<!-- 手机支付 订购关系查询 64_007 -->
					<tbody id=d_64_007 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_64_007_phone" id="d_64_007_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>
					
					
					
					<!-- 手机支付 账户充值查询 64_008 -->
					<tbody id=d_64_008 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_64_008_phone" id="d_64_008_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>订单编号</td>
			        <td>
  							<input name="d_64_008_order_no" type="text" id="d_64_008_order_no" value=""  v_must='0' />
							
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>用户类型</td>
			        <td>
  							<select name="d_64_008_cust_type"  id="d_64_008_cust_type">
  								<option value="0">手机用户</option>
  								<option value="1">商户</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>账户类型</td>
			        <td>
  							 <select name="d_64_008_account_type"  id="d_64_008_account_type">
  							 	<option value="">所有类型</option>
  								<option value="1">现金</option>
  								<option value="2">充值卡</option>
  								<option value="3">移动电子券</option>
  								<option value="4">积分</option>
  								<option value="5">商户电子券</option>
  								<option value="6">支出专户</option>
  								<option value="7">和包刷卡</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>排序类型</td>
			        <td>
  							<select name="d_64_008_order_type"  id="d_64_008_order_type">
  								<option value="A">升序</option>
  								<option value="D">降序</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>交易类型</td>
			        <td>
  							<input name="d_64_008_pay_type" type="text" id="d_64_008_pay_type" value=""  v_must='0' maxlength="10" />
								
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
										
								<input name="d_64_008_begTime" type="text" id="d_64_008_begTime" value="<%=bMon22%>"  
			        	onclick="WdatePicker({el:'d_64_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
										
			        </td>			        <td class='blue'>结束时间</td>
			        <td>
									
								<input name="d_64_008_endTime" type="text" id="d_64_008_endTime" value="<%=mon22[0]%>" v_must ='1' 
  							onclick="WdatePicker({el:'d_64_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
  							v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
										
										
					    </td>
					  </tr>
					</tbody>				
					
					
					
										<!-- 手机支付 自动充话费查询 64_009 -->
					<tbody id=d_64_009 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_64_009_phone" id="d_64_009_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>
					
					<!-- 手机支付 实名认证关联手机号查询 64_010 -->
					<tbody id=d_64_010 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户身份证</td>
			        <td  colspan="3">
  							<input name="d_64_010_idiccid" type="text" id="d_64_010_idiccid" value=""  v_must='1' maxlength="20"/>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					
					
					<!-- 手机支付 交流量明细查询 64_011 -->
					<tbody id=d_64_011 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>支付号码</td>
			        <td>
  							<input name="d_64_011_pay_no" type="text" id="d_64_011_pay_no" value=""  v_must='0' />
								
					    </td>
					    <td class='blue'>被充值号码</td>
			        <td>
  							<input name="d_64_011_pay_no_n" type="text" id="d_64_011_pay_no_n" value=""  v_must='0' />
								
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>有效期</td>
			        <td>
  							<select name="d_64_011_validate"  id="d_64_011_validate">
  								<option value="0">本月</option>
  								<option value="1">90天</option>
  								<option value="2">180天</option>
  							</select>

								<font class="orange">*</font>
					    </td>
					    		    
					    
					    					    <td class='blue'>开始时间</td>
			        <td>
			        	
			        		<input name="d_64_011_begTime" type="text" id="d_64_011_begTime" value="<%=bMon22%>"  
			        	onclick="WdatePicker({el:'d_64_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					 						
										<font class="orange">(yyyymmdd)*</font>
			        </td>	

					  </tr>
					  <tr>

		        <td class='blue'>结束时间</td>
			        <td>
									
								<input name="d_64_011_endTime" type="text" id="d_64_011_endTime" value="<%=mon22[0]%>" v_must ='1' 
  							onclick="WdatePicker({el:'d_64_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
  							v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
										
										
					    </td>
					    
					    					    <td class='blue'>充流量渠道</td>
			        <td>
  							<select name="d_64_011_chn_type"  id="d_64_011_chn_type">
  								<option value="">全部</option>
  								<option value="THD">外部互联网</option>
  								<option value="CNM">移动自有渠道</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    
					  </tr>
					</tbody>					
					
										<!--手机支付64 --用户账户余额查询-->
					<tbody id="d_64_001" class="tbody_form" style="display:none">
				   		<tr>
					      <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_64_001_phone" id="d_64_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    </tr>
					</tbody>
					
					

					<!-- 手机支付64--缴话费交易查询-->
					<tbody id="d_64_002" class="tbody_form" style="display:none">
						<tr>
					    <td class='blue'>支付手机号</td>
					    <td>
								<input type="text" name="d_64_002_phone" id="d_64_002_phone"  value="<%=activePhone%>"  readonly class="InputGrey"  
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					    </td>
					    <td class='blue'>缴费手机号</td>
			        <td>
  							<input type="text" name="d_64_002_payPhone" id="d_64_002_payPhone" value=""
  							maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  							onafterpaste="this.value=this.value.replace(/\D/g,'')"
  							onblur = "checkElement(this)"/>
				      </td>
					  </tr>

				    <tr>
			        <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_64_002_begTime" type="text" id="d_64_002_begTime" value="<%=bMon22%>" v_must ='1'
			        	onclick="WdatePicker({el:'d_64_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
			        
			        <td class='blue'>查询截止日期</td>
			        <td>
  							<input name="d_64_002_endTime" type="text" id="d_64_002_endTime" value="<%=mon22[0]%>" v_must ='1' 
  							onclick="WdatePicker({el:'d_64_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
  							v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
				    </tr>

				    <tr>
			        <td class='blue'>缴费金额</td>
				      <td>
  							<input name="d_64_002_payFee" type="text" id="d_64_002_payFee" value=""
  							maxlength="11" onkeyup="this.value=this.value.replace(/-?\d+\.\d+/g,'')" 
  							onafterpaste="this.value=this.value.replace(/-?\d+\.\d+/g,'')"
  							onblur = "checkElement(this)"/>
				      </td>
				      <td class='blue'>缴费渠道</td>
			        <td>
							  <select id="d_64_002_channel">
								  <option value="">全部</option>
								  <option value="10086">移动门户</option>
								  <option value="139">139邮箱</option>
								  <option value="ATM">自助终端</option>
								  <option value="BOSS">营业厅</option>
								  <option value="CMPAY">互联网</option>
								  <option value="CALL">客服及电话支付系统</option>
								  <option value="SMS">短信</option>
								  <option value="STK">SIM卡工具包</option>
								  <option value="WAP">无线通讯网</option>
								  <option value="SYS">手机支付系统平台</option>
								  <option value="FETIO">飞信</option>
								  <option value="SP">省平台</option>
								  <option value="NETAC">网厅账户</option>
								  <option value="NETBK">网厅网银</option>
								  <option value="CAS">手机客户端</option>
								  <option value="SMSBH">省BOSS短信营业厅</option>
								  <option value="IVRBH">省BOSS语音营业厅</option>
								  <option value="FEIX1">移动飞信缴话费</option>
								  <option value="AHCP">安徽移动手机支付购彩</option>
								  <option value="QSYS">全网批扣</option>
								  <option value="MS24">云南移动商城</option>
								  <option value="MMSMS">电子券到期充话费</option>
								  <option value="MOP">开放平台</option>
							  </select>
			        </td>
				    </tr>
					</tbody>
					
					<!-- 手机支付64--电子券查询-->
					<tbody id="d_64_003" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>手机号</td>
			        <td>
  							<input type="text" name="d_64_003_phone" id="d_64_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
  							  v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')" 
  								onblur = "checkElement(this)"/>
  								<font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_64_003_begTime" type="text" id="d_64_003_begTime" value="<%=bMon22%>"  
			        	onclick="WdatePicker({el:'d_64_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
					  </tr>

					  <tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_64_003_endTime" type="text" id="d_64_003_endTime" value="<%=mon22[0]%>" 
								onclick="WdatePicker({el:'d_64_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"   
								v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
					    </td>
					    <td class='blue'>营销工具类型</td>
			        <td>
  							<select id="d_64_003_tool">
  								<option value="">全选</option>
  								<option value="0">代金卷</option>
			        		<option value="1">普通电子券</option>
			        		<option value="2">积分电子券</option>
			        		<option value="3">折扣电子券</option>
							  </select>
				      </td>
					  </tr>

				    <tr>
				      <td class='blue'>交易类型</td>
				      <td colspan="3">
							  <select id="d_64_003_trade">
  								<option value="0">领用</option>
			        		<option value="1">消费</option>
			        		<option value="2">转赠</option>
			        		<option value="3">交易</option>
							  </select>
				      </td>
				    </tr>
					</tbody>

					<!-- 手机支付64--用户订单信息列表查询-->
					<tbody id="d_64_004" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_64_004_phone" id="d_64_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1'  maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this);setByName();"/>
								<font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>查询开始日期</td>
			        <td>
				        	<input name="d_64_004_begTime" type="text" id="d_64_004_begTime" value="<%=bMon22%>"  
				        	onclick="WdatePicker({el:'d_64_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
				        	v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
				        			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
				      </td>
					  </tr>
					  
				    <tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
							<input name="d_64_004_endTime" type="text" id="d_64_004_endTime" value="<%=mon22[0]%>"  
							onclick="WdatePicker({el:'d_64_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  
    						v_must ='1' maxlength="8" v_type="date" onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_64_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
				      </td>
				      
				      <td class='blue'>支付类型</td>
			        <td>
  							<select id="d_64_004_pay">
  							  <option value="">全部</option>
  								<option value="S">直接支付</option>
  								<option value="L">预授权支付</option>
  								<option value="C">担保支付</option>
  		        		<option value="B">B2C预授权支付</option>
  		        		<option value="W">无密协议支付</option>
  		        		<option value="U">无密无协议支付</option>
  							</select>
  						</td>
				    </tr>
					</tbody>

					<!-- 手机支付64--用户订单详细信息查询-->
					<tbody id="d_64_005" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>商户编号</td>
			        <td>
								<input type="text" name="d_64_005_no" id="d_64_005_no" value="" maxlength="50" 
									v_must ='1' onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>订单号</td>
			        <td>
								<input type="text" name="d_64_005_order" id="d_64_005_order" value="" maxlength="50"
								v_must='1' onblur="checkElement(this)"/>
								<font class="orange">*</font>
					    </td>
				    </tr>

				    <tr>
			        <td class='blue'>下订日期</td>
			        <td colspan="3">
			        	<input name="d_64_005_date" type="text" id="d_64_005_date" value="<%=mon22[0]%>" v_must ='1' 
			        	onclick="WdatePicker({el:'d_64_005_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
  			        	maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_005_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
					  </tr>
					</tbody>

					<!-- 手机支付64--用户开销户历史查询-->
					<tbody id="d_64_006" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_64_006_phone" id="d_64_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
				        	<font class="orange">*</font>
				      </td>
				      
				      <td class='blue'>账户类型</td>
			        <td>
  							<select id="d_64_006_type">
  								<option value="">全部</option>
  								<option value="M">手机支付主账户</option>
				        	<option value="S">手机支付子账户</option>
							  </select>
			        </td>
					  </tr>

				    <tr>
			        <td class='blue'>开户开始日期</td>
			        <td colspan="3">
			        	<input name="d_64_006_date" type="text" id="d_64_006_date" value="<%=mon22[0]%>" v_must ='1' 
			        	onclick="WdatePicker({el:'d_64_006_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" 
			        	maxlength="8" v_type="date" onblur = "checkElement(this)"/>
			        				<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_64_006_date',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>
			        </td>
					  </tr>
					</tbody>
					
	

			
					
					
					
					
					<!-- 手机支付 订购关系查询 64_007 -->
					<tbody id=d_64_007 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
			        <td>
  							<input name="d_64_007_hone" type="text" id="d_64_007_String" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>
					
					
					
					
					
					
					<!-- 无线音乐72--黑名单屏蔽日志查询-->
					<tbody id="d_72_001" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>手机号</td>

					        <td>

								<input type="text" name="d_72_001_phone" id="d_72_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1' 

								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')" 

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>
					
					<!--无线音乐72--点播记录查询-->
					
					<tbody id="d_72_002" class="tbody_form" style="display:none">
						<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" name="d_72_002_phone" id="d_72_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					        </td>

					        <td class='blue'>开始时间</td>
					        <td>
					        	<input name="d_72_002_begTime" type="text" id="d_72_002_begTime" value="<%=bMon%>"  
	                  onclick="WdatePicker({el:'d_72_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"					        	
					        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					    </tr>
					    
					    <tr>
					        <td class='blue'>结束时间</td>
					        <td>
								<input name="d_72_002_endTime" type="text" id="d_72_002_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_72_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>产品类型</td>

					        <td>

								<select id="d_72_002_type">

									<option value="RING">振铃</option>

					        		<option value="FULL_MUSIC">歌曲下载</option>

					        		<option value="SST">随身听</option>

								</select>

					        </td>

						</tr>

					</tbody>
                    
          <!--无线音乐72--会员历史操作记录查询-->
					<tbody id="d_72_003" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
  							<input type="text" name="d_72_003_phone" id="d_72_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
  				      <font class="orange">*</font>
			        </td>

			        <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_72_003_begTime" type="text" id="d_72_003_begTime" value="<%=bMon%>"  
			        	onclick="WdatePicker({el:'d_72_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
				    </tr>
					    
					  <tr>
			        <td class='blue'>结束时间</td>
			        <td colspan="3">
								<input name="d_72_003_endTime" type="text" id="d_72_003_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_72_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
						</tr>
					</tbody>
                    
                    <!--无线音乐72--包月历史操作记录查询-->
					<tbody id="d_72_004" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
							  <input type="text" name="d_72_004_phone" id="d_72_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
				        	<font class="orange">*</font>
				      </td>

			        <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_72_004_begTime" type="text" id="d_72_004_begTime" value="<%=bMon%>"  
			        	onclick="WdatePicker({el:'d_72_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
				    </tr>
					    
				    <tr>
			        <td class='blue'>结束时间</td>
			        <td colspan="3">
  							<input name="d_72_004_endTime" type="text" id="d_72_004_endTime" value="<%=mon[0]%>"  
  							onclick="WdatePicker({el:'d_72_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
  							maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
				      </td>
						</tr>
					</tbody>
					
					<!--无线音乐72--单次消费历史记录查询-->
					<tbody id="d_72_005" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
							<input type="text" name="d_72_005_phone" id="d_72_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
				        	<font class="orange">*</font>
				        </td>

				        <td class='blue'>开始时间</td>
				        <td>
				        	<input name="d_72_005_begTime" type="text" id="d_72_005_begTime" value="<%=bMon%>"  
				        	onclick="WdatePicker({el:'d_72_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
				        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
				        </td>
				    </tr>
				    
				    <tr>
				        <td class='blue'>结束时间</td>
				        <td colspan="3">
							<input name="d_72_005_endTime" type="text" id="d_72_005_endTime" value="<%=mon[0]%>"  
							onclick="WdatePicker({el:'d_72_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
							maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
				        </td>
						</tr>
					</tbody>
					
					<!--无线音乐72--彩铃订购历史记录查询-->
					<tbody id="d_72_006" class="tbody_form" style="display:none">
						<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" name="d_72_006_phone" id="d_72_006_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					        </td>

					        <td class='blue'>开始时间</td>
					        <td>
					        	<input name="d_72_006_begTime" type="text" id="d_72_006_begTime" value="<%=bMon%>"  
					        	onclick="WdatePicker({el:'d_72_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_72_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					    </tr>
					    
					    <tr>
					        <td class='blue'>结束时间</td>
					        <td colspan="3">
								<input name="d_72_006_endTime" type="text" id="d_72_006_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_72_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_must="1" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_72_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
						</tr>
					</tbody>
                    
                    
                    <!--无线音乐72--合作渠道黑名单查询-->
					<tbody id="d_72_007" class="tbody_form" style="display:none">
						<tr>
			        <td class='blue'>用户手机号码</td>
			        <td colspan="3">
								<input type="text" name="d_72_007_phone" id="d_72_007_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					        </td>
					    </tr>
					</tbody>
					
					<!-- 手机视频82--黑名单查询-->

					<tbody id="d_82_001" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>手机号</td>

					        <td>

								<input type="text" name="d_82_001_phone" id="d_82_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must ='1'

									 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

									 onafterpaste="this.value=this.value.replace(/\D/g,'')"

									 onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>

					<!--手机视频82--历史订购查询-->

					<tbody id="d_82_002" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_82_002_phone" id="d_82_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'

								 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								 onafterpaste="this.value=this.value.replace(/\D/g,'')"

								 onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>开始时间</td>

					        <td>

					        	<input name="d_82_002_begTime" type="text" id="d_82_002_begTime" v_must ='1' 
										onclick="WdatePicker({el:'d_82_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        		v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_82_002_endTime" type="text" id="d_82_002_endTime" v_must ='1' 
								onclick="WdatePicker({el:'d_82_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>查询结束类型</td>

					        <td>

					        	<select id="d_82_002_type">

									<option value="1">当日查询</option>

					        		<option value="2">历史查询</option>

								</select>

							</td>

						</tr>

					</tbody>

					<!--手机视频82--点播记录查询-->

					<tbody id="d_82_003" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>用户手机号码</td>

					        <td>

								<input type="text" name="d_82_003_phone" id="d_82_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')" 

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'>开始时间</td>

					        <td>

					        	<input name="d_82_003_begTime" type="text" id="d_82_003_begTime" value="<%=bMon%>" 
										onclick="WdatePicker({el:'d_82_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        		v_must ='1' v_type="date_time"  maxlength="19" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					    </tr>

					    <tr>

					        <td class='blue'>结束时间</td>

					        <td>

								<input name="d_82_003_endTime" type="text" id="d_82_003_endTime" v_must ='1' 
								onclick="WdatePicker({el:'d_82_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_type="date_time" value="<%=mon[0]%>"  maxlength="19" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>计费类型</td>

					        <td>

					        	<select id="d_82_003_type">

					        		<option value="0">包月</option>
					        		<option value="1">按次</option>
					        		<option value="7">免费</option>
					        		<option value="13">包年</option>
					        		<option value="15">大包月</option>
											<option value="16">平台包月产品</option>

								</select>

							</td>

						</tr>

					</tbody>

					<!-- 手机视频82--适配机型查询-->

					<tbody id="d_82_004" class="tbody_form" style="display:none">

						<tr>

					        <td class='blue'>手机号</td>

					        <td>

								<input type="text" name="d_82_004_phone" id="d_82_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  

									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

									onafterpaste="this.value=this.value.replace(/\D/g,'')" 

									onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>

					        <td class='blue'></td>

					        <td></td>

					    </tr>

					</tbody>
						
				    <!-- 手机视频82--异常稽核用户查询-->
					<tbody id="d_82_005" class="tbody_form" style="display:none">
					    <tr>
				        <td class='blue'>用户手机号码</td>
				        <td>
  								<input type="text" name="d_82_005_phone" id="d_82_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
  									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
  									onblur = "checkElement(this)"/>
  					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'></td>
				        <td></td>
					    </tr>
					</tbody>
					
					<!-- 手机视频82--图形验证码用户查询-->
					<tbody id="d_82_006" class="tbody_form" style="display:none">
					    <tr>
				        <td class='blue'>用户手机号码</td>
				        <td>
  								<input type="text" name="d_82_006_phone" id="d_82_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
  									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
  									onblur = "checkElement(this)"/>
  					        	<font class="orange">*</font>
				        </td>
				       
				      </tr>
					</tbody>
					<!-- 2014/08/05 10:04:14 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						使用记录查询
					 -->
					<tbody id="d_82_007" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户手机号码</td>
					      <td colspan="3">
									<input type="text" name="d_82_007_phone" id="d_82_007_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					    <tr>
									<td class='blue'>开始时间</td>
					        <td>
					        	<input name="d_82_007_begTime" type="text" id="d_82_007_begTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_82_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					        
					        <td class='blue'>结束时间</td>
					        <td>
										<input name="d_82_007_endTime" type="text" id="d_82_007_endTime" v_must ='1' 
											onclick="WdatePicker({el:'d_82_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
											value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					       </td>
					     </tr>
					   </tbody>
					<!-- 2014/08/05 10:04:14 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						业务黑名单查询
					 -->
					<tbody id="d_82_008" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户手机号码</td>
					      <td colspan="3">
									<input type="text" name="d_82_008_phone" id="d_82_008_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					   </tbody>
					   
					   
  	 		
  	 		<!-- 手机视频82--<option value="009">用户账户查询</option>-->
  	 		
					<tbody id="d_82_009" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户账号</td>
					      <td  >
									<input type="text" name="d_82_009_phone" id="d_82_009_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					     
					   </tbody>   
					   <!-- 手机视频82--<option value="010">充值记录查询</option>-->
					<tbody id="d_82_010" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户账号</td>
					      <td  >
									<input type="text" name="d_82_010_phone" id="d_82_010_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					       
					       <td class='blue'>&nbsp;</td>
					      <td >
								 &nbsp;
									 
									 
					       </td>
					    </tr>
					      <tr>
									<td class='blue'>开始时间</td>
					        <td>
					        	<input name="d_82_010_begTime" type="text" id="d_82_010_begTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_82_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					        
					        <td class='blue'>结束时间</td>
					        <td>
										<input name="d_82_010_endTime" type="text" id="d_82_010_endTime" v_must ='1' 
											onclick="WdatePicker({el:'d_82_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
											value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					       </td>
					     </tr>
					   </tbody>   					   
					   
  	 					<!-- 手机视频82--<option value="011">消费记录查询</option>-->
					   <tbody id="d_82_011" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户手机号码</td>
					      <td  colspan="3">
									<input type="text" name="d_82_011_phone" id="d_82_011_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					       
					        
					    </tr>
					      <tr>
									<td class='blue'>开始时间</td>
					        <td>
					        	<input name="d_82_011_begTime" type="text" id="d_82_011_begTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_82_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											v_type="date_time" value="<%=bMon%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_82_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					        </td>
					        
					        <td class='blue'>结束时间</td>
					        <td>
										<input name="d_82_011_endTime" type="text" id="d_82_011_endTime" v_must ='1' 
											onclick="WdatePicker({el:'d_82_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
											value="<%=mon[0]%>" v_type="date_time" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_82_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					       </td>
					     </tr>
					     
					     <tr>
					      <td class='blue'>计费类型</td>
					      <td  colspan="3">
								 	<select id="d_82_011_type">


					        		<option value="0">包月</option>
					        		<option value="1">按次</option>
					        		<option value="7">免费</option>
					        		<option value="13">包年</option>
					        		<option value="15">大包月</option>
											<option value="16">平台包月产品</option>
								</select>
					       	<font class="orange">*</font>
					       </td>
					    </tr>
					   </tbody>   					   
					   
					 <!-- 无忧行 159 001	用户无忧行流量包订购记录查询-->
					   <tbody id="d_159_001" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户手机号码</td>
					      <td >
									<input type="text" name="d_159_001_phone" id="d_159_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					        <td class='blue'>业务类型关键字</td>
					         <td>
					    <input type="text" name="d_159_001_msgid" id="d_159_001_msgid" value="10020010"  readonly class="InputGrey"  />
										  </td>
										</tr>
					   </tbody>    
					   
					 <!-- 无忧行 159 	002	流量包状态过程查询-->
					   <tbody id="d_159_002" class="tbody_form" style="display:none">
							<tr>
					      <td class='blue'>用户手机号码</td>
					      <td  >
									<input type="text" name="d_159_002_phone" id="d_159_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
										 maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
										 onafterpaste="this.value=this.value.replace(/\D/g,'')"
										 onblur = "checkElement(this)"/>
					       	<font class="orange">*</font>
					       </td>
					        <td class='blue'>业务类型关键字</td>
					        <td>
					    <input type="text" name="d_159_002_msgid" id="d_159_002_msgid" value="10020011"  readonly class="InputGrey"  />
										   </td>
										</tr>
										
										<tr>
					      
					        		<td class='blue'>订单号</td>
					        		<td colspan="3">
					    					<input type="text" name="d_159_002_order_no" id="d_159_002_order_no" value=""     />
										  </td>
										</tr>
					   </tbody>    
					   
					   					   
					   
					<!-- 手机电视40--1开放订购信息查询-->
					<tbody id="d_40_001" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_001_phone" id="d_40_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'></td>
				      <td></td>
				    </tr>
					</tbody>
					
					<!-- 手机电视40--2开放全部日志查询-->
					<tbody id="d_40_002" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_002_phone" id="d_40_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_002_begTime" type="text" id="d_40_002_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_002_endTime" type="text" id="d_40_002_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td></td>
					    <td></td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--主动密钥请求日志查询-->
					<tbody id="d_40_003" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_003_phone" id="d_40_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_003_begTime" type="text" id="d_40_003_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_003_endTime" type="text" id="d_40_003_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_003_trade" name="d_40_003_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--业务订购日志查询-->
					<tbody id="d_40_004" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_004_phone" id="d_40_004_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_004_begTime" type="text" id="d_40_004_begTime" value="<%=bMon33%>" 
			        		onclick="WdatePicker({el:'d_40_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_004_endTime" type="text" id="d_40_004_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_004_trade" name="d_40_004_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--业务开通日志查询-->
					<tbody id="d_40_005" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_005_phone" id="d_40_005_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_005_begTime" type="text" id="d_40_005_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_005_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_005_endTime" type="text" id="d_40_005_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_005_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_005_trade" name="d_40_005_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--6GBA初始化日志查询-->
					<tbody id="d_40_006" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_006_phone" id="d_40_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_006_begTime" type="text" id="d_40_006_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_006_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_006_endTime" type="text" id="d_40_006_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_006_trade" name="d_40_006_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--7SG业务下载和日志查询-->
					<tbody id="d_40_007" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_007_phone" id="d_40_007_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_007_begTime" type="text" id="d_40_007_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_007_endTime" type="text" id="d_40_007_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_007_trade" name="d_40_007_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--8订购密钥请求日志查询-->
					<tbody id="d_40_008" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_008_phone" id="d_40_008_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_008_begTime" type="text" id="d_40_008_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_008_endTime" type="text" id="d_40_008_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_008_trade" name="d_40_008_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
								</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--9订购关系日志查询-->
					<tbody id="d_40_009" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_009_phone" id="d_40_009_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_009_begTime" type="text" id="d_40_009_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_009_endTime" type="text" id="d_40_009_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_009_trade" name="d_40_009_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
								</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--10订购关系更新日志查询-->
					<tbody id="d_40_010" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_010_phone" id="d_40_010_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td class='blue'>查询开始日期</td>
			        <td>
			        	<input name="d_40_010_begTime" type="text" id="d_40_010_begTime" value="<%=bMon33%>" 
			        	onclick="WdatePicker({el:'d_40_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1'  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_40_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>查询截止日期</td>
			        <td>
								<input name="d_40_010_endTime" type="text" id="d_40_010_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_40_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
									v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_40_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					    <td class='blue'>交易类型</td>
					    <td>
								<select id="d_40_010_trade" name="d_40_010_trade">
									<option value="003">主动密钥请求</option>
			        		<option value="004">业务订购</option>
			        		<option value="005">业务开通</option>
			        		<option value="006">GBA初始化</option>
			        		<option value="007">SG业务下载</option>
			        		<option value="008">订购密钥请求</option>
			        		<option value="009">订购关系</option>
			        		<option value="010">订购关系更新</option>
			        		<option value="010">订购关系更新日志查询</option>
			        		<option value="011">开放最新订购记录查询</option>
								</select>
							</td>
					  </tr>
					</tbody>
					
					<!-- 手机电视40--11开放最新订购记录查询-->
					<tbody id="d_40_011" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>手机号</td>
			        <td>
								<input type="text" name="d_40_011_phone" id="d_40_011_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    <td></td>
			        <td></td>
			    	</tr>
					</tbody>
					
					<!-- 咪咕动漫 点播记录查询 95 001 -->
					<tbody id="d_95_001" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户号码</td>
			        <td>
								<input type="text" name="d_95_001_phone" id="d_95_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
					      <font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_95_001_begTime" type="text" id="d_95_001_begTime" value="<%=bMon%>" 
			        	onclick="WdatePicker({el:'d_95_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	
			    	<tr>
			        <td class='blue'>结束时间</td>
			        <td colspan="3">
								<input name="d_95_001_endTime" type="text" id="d_95_001_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_95_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- 咪咕动漫 包月记录查询 95 002 -->
					<tbody id="d_95_002" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户号码</td>
			        <td>
								<input type="text" name="d_95_002_phone" id="d_95_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
									<font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_95_002_begTime" type="text" id="d_95_002_begTime" value="<%=bMon%>" 
			        	onclick="WdatePicker({el:'d_95_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	
			    	<tr>
			        <td class='blue'>结束时间</td>
			        <td colspan="3">
								<input name="d_95_002_endTime" type="text" id="d_95_002_endTime" value="<%=mon[0]%>"  
								onclick="WdatePicker({el:'d_95_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  v_must ='1' maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- 咪咕动漫 黑名单查询 95 003 -->
					<tbody id="d_95_003" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户号码</td>
			        <td>
								<input type="text" name="d_95_003_phone" id="d_95_003_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>屏蔽类型</td>
			        <td>
			        	
			        	<select name="d_95_003_type" id="d_95_003_type" >
			        		<option value="1">短信</option>
			        		<option value="2">彩信</option>
			        		<option value="3">集团彩漫</option>
			        		<option value="4">Wap Push</option>
			        		<option value="5">动漫导视</option>
			        		<option value="7">动漫杂志（短信）</option>
			        		<option value="8">动漫杂志（彩信）</option>
			        		<option value="9">个人彩漫</option>
			        		<option value="21">限制点播</option>
			        		<option value="22">限制包月</option>
			        		<option value="23">限制漫币消费</option>
			        		<option value="24">限制积分累计</option>
			        		<option value="25">限制购买漫币</option>
			        		<option value="26">限制个人彩漫</option>
			        	</select>
					    </td>
					    
			    	</tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					 咪咕动漫 异常行为用户查询 95 004 
					 -->
					<tbody id="d_95_004" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" name="d_95_004_phone" id="d_95_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
			    	</tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					 咪咕动漫 用户接收状态查询 95 005 
					 -->
					<tbody id="d_95_005" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" name="d_95_005_phone" id="d_95_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
			    	</tr>
					</tbody>
					
					
					<!-- 包月配额查询 -->
					<tbody id="d_95_006" class="tbody_form" style="display:none">
						
									    	<tr>
			        <td class='blue'>用户号码</td>
			        <td  colspan="3">
								<input type="text" name="d_95_006_phone" id="d_95_006_phone" value="<%=activePhone%>"  readonly  class="InputGrey" 
									v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
									<font class="orange">*</font>
					    </td>
					    </tr>
					    
					  <tr>
			       
					    
					    <td class='blue'>查询年份</td>
			        <td>
			        	<input name="d_95_006_year" type="text" id="d_95_006_year" value="<%=j_year_w%>" maxlength="4" v_must='1' />
					       		 
										<font class="orange">(yyyy)*</font>
			        </td>
			        
			         <td class='blue'>查询月份</td>
			        <td>
								<select name="d_95_006_month" type="text" id="d_95_006_month" >
									<option <%if("01".equals(j_month_w)) out.print("selected");%> value="01">01</option>
									<option <%if("02".equals(j_month_w)) out.print("selected");%> value="02">02</option>
									<option <%if("03".equals(j_month_w)) out.print("selected");%> value="03">03</option>
									<option <%if("04".equals(j_month_w)) out.print("selected");%> value="04">04</option>
									<option <%if("05".equals(j_month_w)) out.print("selected");%> value="05">05</option>
									<option <%if("06".equals(j_month_w)) out.print("selected");%> value="06">06</option>
									<option <%if("07".equals(j_month_w)) out.print("selected");%> value="07">07</option>
									<option <%if("08".equals(j_month_w)) out.print("selected");%> value="08">08</option>
									<option <%if("09".equals(j_month_w)) out.print("selected");%> value="09">09</option>
									<option <%if("10".equals(j_month_w)) out.print("selected");%> value="10">10</option>
									<option <%if("11".equals(j_month_w)) out.print("selected");%> value="11">11</option>
									<option <%if("12".equals(j_month_w)) out.print("selected");%> value="12">12</option>
							  </select>
								<font class="orange">(mm)*</font>
					    </td>
					  </tr>
			    	
			    	

					</tbody>
	
	
	
	<!--充值记录查询				-->
					<tbody id="d_95_007" class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户帐号</td>
			        <td>
			        	<input name="d_95_007_account" type="text" id="d_95_007_account" value=""  v_must='1' />
					       		 
										<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>帐号类型</td>
			        <td>
			        	<select name="d_95_007_accounttype" type="text" id="d_95_007_accounttype"  />
					       	<option  value="0">手机号码</option>
									<option  value="1">邮箱</option>
							  </select>
										<font class="orange">*</font>
			        </td>
					  </tr>
					  <tr>
			    		<td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_95_007_begTime" type="text" id="d_95_007_begTime"  value="<%=date_month_3%>"
			        	onclick="WdatePicker({el:'d_95_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_007_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>
			    	
			        <td class='blue'>结束时间</td>
			        <td >
								<input name="d_95_007_endTime" type="text" id="d_95_007_endTime" value="<%=date_month_0%>"  
								onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})" 
								  v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
			     
					</tbody>
					
					
					<!-- 咪咕动漫 漫币消费记录查询 95_008 -->
					<tbody id=d_95_008 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户帐号</td>
			        <td>
  							<input name="d_95_008_account" type="text" id="d_95_008_account" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>帐号类型</td>
			        <td>
  							<select name="d_95_008_accounttype" type="text" id="d_95_008_accounttype"  />
					       	<option  value="0">手机号码</option>
									<option  value="1">邮箱</option>
							  </select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_95_008_begTime" type="text" id="d_95_008_begTime"   value="<%=date_month_3+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_95_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_95_008_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_95_008_endTime" type="text" id="d_95_008_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_95_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_008_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					
				<!-- 咪咕动漫 漫币代购记录查询 95_009 -->
					<tbody id=d_95_009 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户帐号</td>
			        <td>
  							<input name="d_95_009_account" type="text" id="d_95_009_account" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>帐号类型</td>
			        <td>
  							<select name="d_95_009_accounttype" type="text" id="d_95_009_accounttype"  />
					       	<option  value="0">手机号码</option>
									<option  value="1">邮箱</option>
							  </select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_95_009_begTime" type="text" id="d_95_009_begTime"   value="<%=date_month_3+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_95_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_95_009_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_95_009_endTime" type="text" id="d_95_009_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_95_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_009_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					
					
					<!-- 咪咕动漫 包月订购关系历史记录查询 95_010 -->
					<tbody id=d_95_010 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码/邮箱帐号</td>
			        <td>
  							<input type="text" name="d_95_010_phone" id="d_95_010_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
			 
	<input name="d_95_010_begTime" type="text" id="d_95_010_begTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_010_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
																				
			        </td>			        <td class='blue'>结束时间</td>
			        <td>
				
													 
	<input name="d_95_010_endTime" type="text" id="d_95_010_endTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_010_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					    </td>
					  </tr>
					</tbody>
					
					<!-- 咪咕动漫 011	消费记录查询  -->
					<tbody id=d_95_011 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码/邮箱帐号</td>
			        <td>
  							<input type="text" name="d_95_011_phone" id="d_95_011_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
			      
						<input name="d_95_011_begTime" type="text" id="d_95_011_begTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_011_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
																				
			        </td>			        <td class='blue'>结束时间</td>
			        <td>
							
										    
						<input name="d_95_011_endTime" type="text" id="d_95_011_endTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_011_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					    </td>
					  </tr>
					  <tr>
					  <td class='blue'>收费情况</td>
				        <td >
  								<select name = "d_95_011_billinfo" id="d_95_011_billinfo">
  									<option value="0">查询非免费的</option>
  									<option value="1">查询免费的</option>
  									<option value="2">查询免费和收费的</option>
  								</select>
				        </td>
				        
				         <td class='blue'>支付方式</td>
				        <td >
  								<select name = "d_95_011_paytype" id="d_95_011_paytype">
  									<option value="0">全部</option>
  									<option value="1">现金</option>
  									<option value="2">漫币</option>
  									<option value="2">业务保障平台支付（中移动）</option>
  									<option value="2">咪咕支付宝支付（中移动）</option>
  								</select>
				        </td>
					  </tr>
					</tbody>
					
					
					<!-- 咪咕动漫 012	用户账户查询   -->
					<tbody id=d_95_012 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码/邮箱帐号</td>
			        <td>
  							<input type="text" name="d_95_012_phone" id="d_95_012_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>
					</tbody>
					
					
										
					<!-- 咪咕动漫 013	短信上下行查询   -->
					<tbody id=d_95_013 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码/邮箱帐号</td>
			        <td>
  							<input type="text" name="d_95_013_phone" id="d_95_013_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td >&nbsp;</td>
			        <td>
  							&nbsp;
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_95_013_begTime" type="text" id="d_95_011_begTime"   value="<%=date_month_3+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_95_013_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_95_013_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_95_013_endTime" type="text" id="d_95_013_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_95_013_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_013_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					  <tr>
					  <td class='blue'>上/下行</td>
				        <td >
  								<select name = "d_95_013_issx" id="d_95_013_issx">
  									<option value="0">全部</option>
  									<option value="1">上行</option>
  									<option value="2">下行</option>
  								</select>
				        </td>
				        
				         <td class='blue'>接入号</td>
				        <td >
  									<input type="text" name="d_95_013_inno" id="d_95_013_inno" value="" v_must ='1' />
				        </td>
					  </tr>
					</tbody>
					
					
					
					<!-- 咪咕动漫 	014	核查   -->
					<tbody id=d_95_014 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码/邮箱帐号</td>
			        <td>
  							<input type="text" name="d_95_014_phone" id="d_95_014_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					     <td class='blue'>业务/内容ID</td>
			        <td>
			        	<input type="text" name="d_95_014_busiId" id="d_95_014_busiId" value="" v_must="1"
									maxlength="25"  
									 
									onblur = "checkElement(this)"/>
			        	
										<font class="orange">*</font>
			        </td>			        
					  </tr>
					  <tr>

					    	        
			        <td class='blue'>消费时间</td>
			        <td>
							 
										<input name="d_95_014_salTime" type="text" id="d_95_014_salTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_95_014_salTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_014_salTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					    </td>
					    
					    <td class='blue'>BOSSID</td>
			        <td>
			        	<input type="text" name="d_95_014_bossId" id="d_95_014_bossId" value="" v_must="1"
									maxlength="100"  
									 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
			        </td>		
					  </tr>
					  
					</tbody>					
					
					
					<!-- 通信账户支付历史订购查询 70 001 -->
					<tbody id="d_70_001" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户号码</td>
			        <td>
								<input type="text" name="d_70_001_phone" id="d_70_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_70_001_begTime" type="text" id="d_70_001_begTime" value="<%=bMon%>" v_must="1"
			        	onclick="WdatePicker({el:'d_70_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_70_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			    	</tr>
			    	
			    	<tr>
			        <td class='blue'>结束时间</td>
			        <td colspan="3">
								<input name="d_70_001_endTime" type="text" id="d_70_001_endTime" value="<%=mon[0]%>" v_must="1"  
								onclick="WdatePicker({el:'d_70_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								  maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_70_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>
					  </tr>
					</tbody>
					
					
					<!-- 通信账户支付 短信上下行查询 70_002 -->
					<tbody id=d_70_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_70_002_phone" id="d_70_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_70_002_begTime" type="text" id="d_70_002_begTime" value="<%=dateStr1111%>"
			        	onclick="WdatePicker({el:'d_70_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_70_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>					  </tr>
					  <tr>
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_70_002_endTime" type="text" id="d_70_002_endTime" value="<%=dateStr1111%>"
								onclick="WdatePicker({el:'d_70_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_70_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- 通信账户支付 黑名单查询 70_003 -->
					<tbody id=d_70_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_70_003_phone" id="d_70_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					</tbody>
										<!-- 通信账户支付 话费业务查询 70_004 -->
					<tbody id=d_70_004 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_70_004_phone" id="d_70_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
 						</tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_70_004_begTime" type="text" id="d_70_004_begTime" value="<%=dateStr1111%>"
			        	onclick="WdatePicker({el:'d_70_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_70_004_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
			        </td>					  
			     
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_70_004_endTime" type="text" id="d_70_004_endTime" value="<%=dateStr1111%>"
								onclick="WdatePicker({el:'d_70_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_70_004_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>
					  </tr>
					</tbody>
					
					<!-- MobileMarket--MM订购黑名单查询 41_001-->
					<tbody id="d_41_001" class="tbody_form" style="display:none">
							
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td colspan="3">
  								<input type="text" name="d_41_001_phone" id="d_41_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					</tbody>
					
					<!-- MobileMarket--MM订购关系查询 41_002-->
					<tbody id="d_41_002" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td >
  								<input type="text" name="d_41_002_phone" id="d_41_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'>业务类型</td>
				        <td >
  								<select name = "d_41_002_optype" id="d_41_002_optype">
  									<option value="">-请选择-</option>
  									<option value="0">普通全部业务</option>
  									<option value="1">普通点播类业务(按次)</option>
  									<option value="2">普通定制类业务(包月)</option>
  									<option value="10">应用内全部业务</option>
  									<option value="11">应用内点播类业务（按次）</option>
  									<option value="12">应用内定制类业务（包月）</option>
  								</select>
				        </td>
					    </tr>
					    <tr>
					    	<td class="blue">企业代码</td>
					    	<td colspan="3">
					    		<input type="text" name="d_41_002_comNum" id="d_41_002_comNum" value="" v_must ='0' />
					    	</td>
					    </tr>
					     <tr>
									<td class='blue'>开始时间</td>
					        <td>
					        	<input name="d_41_002_begTime" type="text" id="d_41_002_begTime" v_must ='1' value="<%=datestrsmm%>"
					        		onclick="WdatePicker({el:'d_41_002_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
											v_type="dateTime" value=""  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_002_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmddhh24miss)*</font>
					        </td>
					        
					        <td class='blue'>结束时间</td>
					        <td>
										<input name="d_41_002_endTime" type="text" id="d_41_002_endTime" v_must ='1'  value="<%=dateStr5555%>"
											onclick="WdatePicker({el:'d_41_002_endTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})" 
											value="" v_type="dateTime" maxlength="19" onblur = "checkElement(this)"/>
										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_41_002_endTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmddhh24miss)*</font>
					       </td>
					     </tr>
					</tbody>
					
					
					<!-- MobileMarket--用户订购异常行为核查 41_003 -->
						<tbody id="d_41_003" class="tbody_form" style="display:none">
				   		
					     <tr>
									<td class='blue'>查询时间段（开始）</td>
					        <td>
										
									<input type="text" name="d_41_003_begTime" id="d_41_003_begTime" value="<%=dangtiankaishi%>"  v_must ='1'
										onclick="WdatePicker({el:'d_41_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
										
					        </td>
					        
					        <td class='blue'>查询时间段（结束）</td>
					        <td>										
									<input type="text" name="d_41_003_endTime" id="d_41_003_endTime" value="<%=datedangtiande%>"  v_must ='1'
								onclick="WdatePicker({el:'d_41_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_41_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
										
					       </td>
					     </tr>
					     
					     <tr>
				        <td class='blue'>用户手机号码</td>
				        <td >
  								<input type="text" name="d_41_003_phone" id="d_41_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'>应用名称</td>
				        <td >
  								<input type="text" name="d_41_003_appname" id="d_41_003_appname" value="" v_must ='0' />
				        </td>
					    </tr>
					     
					</tbody>
					
					
					
						<!-- MobileMarket--用户短信上下行日志查询 41_004 -->
						<tbody id="d_41_004" class="tbody_form" style="display:none">
				   		
					     <tr>
									<td class='blue'>查询月份</td>
					        <td>
										
										<input type="text" name="d_41_004_month" id="d_41_004_month" value="<%=dangtiankaishi%>"  v_must ='1'
										onclick="WdatePicker({el:'d_41_004_month',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_004_month',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
										
					        </td>
					        
					        <td class='blue'>用户手机号码</td>
				        <td >
  								<input type="text" name="d_41_004_phone" id="d_41_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
					     </tr>
					     
					</tbody>
					
											<!-- MobileMarket--用户轨迹行为核查 41_005 -->
						<tbody id="d_41_005" class="tbody_form" style="display:none">
							
						<td class='blue'>订单号</td>
			        <td colspan="3">
								<input type="text" name="d_41_005_order" id="d_41_005_order" value="" maxlength="50"
								v_must='1' onblur="checkElement(this)"/>
								<font class="orange">*</font>
					    </td>			   		
					     
					</tbody>
					
					<!-- MobileMarket--用户日月限额查询 41_006 -->
					<tbody id="d_41_006" class="tbody_form" style="display:none">
						<tr>
						<td class='blue'>消息类型</td>
			        <td >
								<input type="text" name="d_41_006_type" id="d_41_006_type" value="CCQryMSDNLimitReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>版本</td>
			        <td >
								<input type="text" name="d_41_006_version" id="d_41_006_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>用户手机号码</td>
			        <td colspan="3">
								<input type="text" name="d_41_006_phone" id="d_41_006_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					   </tr>
					</tbody>
					
					<!-- MobileMarket--用户图形验证码查询 41_007 -->
					<tbody id="d_41_007" class="tbody_form" style="display:none">
						<tr>
						<td class='blue'>消息类型</td>
			        <td >
								<input type="text" name="d_41_007_type" id="d_41_007_type" value="CCQryGraphicsVerificationReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>版本</td>
			        <td >
								<input type="text" name="d_41_007_version" id="d_41_007_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>用户手机号码</td>
			        <td colspan="3">
								<input type="text" name="d_41_007_phone" id="d_41_007_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					   </tr>
					</tbody>
					
					<!-- mdo--IVR拨打记录查询-->

					<tbody id="d_99_001" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td colspan="3">

								<input type="text" name="d_99_001_phone" id="d_99_001_phone" value="<%=activePhone%>"  readonly  class="InputGrey"   

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>



					    </tr>

					    <tr>
					    			 <td class='blue'>开始时间</td>

					        <td>

					        	<input type="text" name="d_99_001_begTime" id="d_99_001_begTime" value="<%=date_month_6+" 00:00:00"%>"  v_must ='1'
										onclick="WdatePicker({el:'d_99_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_99_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input type="text" name="d_99_001_endTime" id="d_99_001_endTime" value="<%=date_time_0_%>"  v_must ='1'
								onclick="WdatePicker({el:'d_99_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_99_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>



					    </tr>


					</tbody> 
					
									<!-- mdo--MDO订购关系查询-->

					<tbody id="d_99_002" class="tbody_form" style="display:none">

				   		<tr>

					        <td class='blue'>手机号码</td>

					        <td>

								<input type="text" name="d_99_002_phone" id="d_99_002_phone" value="<%=activePhone%>"  readonly  class="InputGrey"   

								v_must ='1' maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 

								onafterpaste="this.value=this.value.replace(/\D/g,'')"

								onblur = "checkElement(this)"/>

					        	<font class="orange">*</font>

					        </td>
					        
					        <td class='blue'>受理类型</td>

					        <td>

					        	<select id="d_99_002_type">
						      		<option value="0">卓望全部</option>
						      		<option value="1">卓望按次</option>
						      		<option value="2">卓望包月</option>
						      		<option value="3">高阳全部</option>	
								</select>

					        </td>


					    </tr>

					    <tr>
					    	
					    	 <td class='blue'>开始时间</td>

					        <td>

					        	<input type="text" name="d_99_002_begTime" id="d_99_002_begTime" value="<%=date_month_6+" 00:00:00"%>"  v_must ='1'
										onclick="WdatePicker({el:'d_99_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					        	maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_99_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>

					        <td class='blue'>结束时间</td>

					        <td>

								<input type="text" name="d_99_002_endTime" id="d_99_002_endTime" value="<%=date_time_0_%>"  v_must ='1'
								onclick="WdatePicker({el:'d_99_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
								maxlength="19" v_type="date_time" onblur = "checkElement(this)"/>

										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_99_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>

					        </td>



					    </tr>


					</tbody> 
					
					
					<!-- 139邮箱 139邮箱账号信息查询 62_001 -->
					<tbody id=d_62_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>邮箱账号</td>
			        <td>
  							<input name="d_62_001_email" type="text" id="d_62_001_email" value=""  v_must='1' />
								<font class="orange">*</font>用户手机号码/通行证/邮箱别名之一
					    </td>
					  </tr>
					</tbody>
					<!-- 139邮箱 营销类邮件屏蔽查询 62_002 -->
					<tbody id=d_62_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>手机号码</td>
					      <td>
								  <input type="text" name="d_62_002_phone" id="d_62_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 手机导航 和地图订购关系履历查询 54_001 -->
					<tbody id=d_54_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_54_001_phone" id="d_54_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
						</tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_54_001_begTime" type="text" id="d_54_001_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_54_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_54_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
					  
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_54_001_endTime" type="text" id="d_54_001_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_54_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_54_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 手机导航 和地图订购关系状态查询 54_002 -->
					<tbody id=d_54_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_54_002_phone" id="d_54_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
						</tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_54_002_begTime" type="text" id="d_54_002_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_54_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_54_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
					  
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_54_002_endTime" type="text" id="d_54_002_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_54_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_54_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 手机导航 和地图订购黑名单查询 54_003 -->
					<tbody id=d_54_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_54_003_phone" id="d_54_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>类型</td>
			        <td>
  							<select  name="d_54_003_String"  id="d_54_003_String" >
  								<option value="0">订购黑名单</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					
					<!-- 12582业务 订购历史查询 130_001 -->
					<tbody id=d_130_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_130_001_phone" id="d_130_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 12582业务 内容定制关系查询 130_002 -->
					<tbody id=d_130_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_130_002_phone" id="d_130_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 12582业务 下发历史记录查询 130_003 -->
					<tbody id=d_130_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_130_003_phone" id="d_130_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 12582业务 业务黑名单查询 130_004 -->
					<tbody id=d_130_004 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_130_004_phone" id="d_130_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					<!-- 12580业务 12580订购关系查询 50_001 -->
					<tbody id=d_50_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_50_001_phone" id="d_50_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>
					<!-- 12580业务 历史记录查询 50_002 -->
					<tbody id=d_50_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_50_002_phone" id="d_50_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>业务名称</td>
			        <td>
  							<input name="d_50_002_businame" type="text" id="d_50_002_businame" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>操作类型</td>
			        <td>
  							<select name="d_50_002_optype"  id="d_50_002_optype">
  								<option value="0">订购</option>
  								<option value="1">退订</option>
  							</select>

								<font class="orange">*</font>
					    </td>
					    <td class='blue'>业务渠道</td>
			        <td>
  							<select name="d_50_002_busichn"  id="d_50_002_busichn">
  								<option value="0">坐席</option>
  								<option value="1">短信</option>
  								<option value="2">BOSS</option>
  								<option value="3">客户端渠道</option>
  								<option value="4">SIM卡渠道</option>
  								<option value="5WAP">渠道</option>
  								<option value="6">批开渠道</option>
  								<option value="7">互联网渠道</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12580业务 点播记录查询 50_003 -->
					<!-- 12580业务 点播记录查询 50_003 -->
					<tbody id=d_50_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_50_003_phone" id="d_50_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>业务名称</td>
			        <td>
  							<input name="d_50_003_String" type="text" id="d_50_003_String" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
			        <td class='blue'>结束时间</td>
			        <td colspan="3">
								<input name="d_50_003_dateTime" type="text" id="d_50_003_dateTime" value="<%=dateStr1111%>"
								onclick="WdatePicker({el:'d_50_003_dateTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_50_003_dateTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>
					    </td>

					  </tr>
					</tbody>
					<!-- 12590系统平台 拨打记录查询 121_001 -->
					<tbody id=d_121_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_121_001_phone" id="d_121_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>业务接入号</td>
			        <td>
  							<input name="d_121_001_busiinno" type="text" id="d_121_001_busiinno" value=""   />
					    </td>
					  </tr>
					  <tr>

					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_121_001_begTime" type="text" id="d_121_001_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_121_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_121_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_121_001_endTime" type="text" id="d_121_001_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_121_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					
					<!-- 12590系统平台 客户端业务使用查询 121_002 -->
					<tbody id=d_121_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_121_002_phone" id="d_121_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_121_002_begTime" type="text" id="d_121_002_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_121_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_121_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>

			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_121_002_endTime" type="text" id="d_121_002_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_121_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12590系统平台 用户短信上下行查询 121_003 -->
					<tbody id=d_121_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_121_003_phone" id="d_121_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_121_003_begTime" type="text" id="d_121_003_begTime" value="<%=bMon%>"
			        	onclick="WdatePicker({el:'d_121_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_121_003_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_121_003_endTime" type="text" id="d_121_003_endTime" value="<%=bMon%>"
								onclick="WdatePicker({el:'d_121_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_121_003_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>										
					<!-- 12590系统平台 黑名单查询 121_004 -->
					<tbody id=d_121_004 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_121_004_phone" id="d_121_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>黑名单类型</td>
			        <td>
  							<select name="d_121_004_blacklisttype"  id="d_121_004_blacklisttype">
  								<option value="1">拨打业务黑名单</option>
  								<option value="2">客户端业务黑名单</option>
  								<option value="3">短信业务黑名单</option>
  							</select>

								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>		
					
					
					<!-- 卓望mdo短信上下行 47_001 -->
					<tbody id=d_47_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_47_001_phone" id="d_47_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					  </tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_47_001_begTime" type="text" id="d_47_001_begTime" value="<%=date_month_6+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_47_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_47_001_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>

			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_47_001_endTime" type="text" id="d_47_001_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_47_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_47_001_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 卓望mdo订购关系查询 47_002 -->
					<tbody id=d_47_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_47_002_phone" id="d_47_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					      
					  </tr>
					  <tr>
					    <td class='blue'>开始时间</td>
			        <td>
			        	<input name="d_47_002_begTime" type="text" id="d_47_002_begTime"  value="<%=date_month_6+" 00:00:00"%>"
			        	onclick="WdatePicker({el:'d_47_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
			        	v_must ='1' maxlength="19"   onblur = "checkElement(this)"/>
			        	 			<img id = "imgCustStart"
											onclick="WdatePicker({el:'d_47_002_begTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
			        </td>
			        <td class='blue'>结束时间</td>
			        <td>
								<input name="d_47_002_endTime" type="text" id="d_47_002_endTime" value="<%=date_time_0_%>"
								onclick="WdatePicker({el:'d_47_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_47_002_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>

					  </tr>
					  
					       <tr>
					  				<td class='blue'>查询类型</td>
					        <td colspan="3">

					        	<select id="d_47_002_type">
						      		<option value="0">卓望全部</option>
						      		<option value="1">卓望按次</option>
						      		<option value="2">卓望包月</option>
						      		<option value="3">高阳全部</option>	
								</select>

					        </td>
					   </tr>
					        
					</tbody>										
					<!-- 卓望mdo订购关系查询 47_003 -->
					<tbody id=d_47_003 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_47_003_phone" id="d_47_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>			
					
					
			    <tr id='footer'>
			        <td colspan='4'>
			        	  
			            <input type="button"  id="searchBtn" class='b_foot' value="查询" name="search" />		            
			            <input type="button"  id="clearBtn" class='b_foot' value="重置" name="clear" />
			            <input type="button" class="b_foot" id="close" name="close" value="关闭" onclick="guanbis()"/>
			            <input type="button" id="ivr_backEnd"  name="ivr_backEnd" class="b_foot"  value="归档" onClick="goBackEnd();" disabled >	
			            <!--
			            <input type="button" id="ivr_backEnd_temp"  name="ivr_backEnd_temp" class="b_foot"  value="归档_联调测试" onClick="goBackEnd_temp();" >	
			            -->
			        </td>
			    </tr>
				</table>
		</div>

		<IFRAME frameBorder=0 id="resultIframe" name="resultIframe" style="HEIGHT: 400px; overflow-y:auto;WIDTH: 100%; Z-INDEX: 1">
		</IFRAME>
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
