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
	//TODO 还没设置限定条件，和必须的红星
	String opCode     = "e828";
    String opName     = "自有业务办理";
	
    String workNo     = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String workName = (String)session.getAttribute("workName");
    
    
  String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
  
  String dateStr444 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

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
		
		 String dateStr8888 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		 String dateStr8888str =dateStr8888+"01000000";
		 
		 
		//测试写死手机号，上线时去掉
    //activePhone = "15046557789";
    
    String bp_name = "";
    String loginNoPass = (String)session.getAttribute("password");
    String ipAddrss = (String)session.getAttribute("ipAddr");
    String beizhussdese="根据phoneNo=["+activePhone+"]进行查询";
    String orgCode = (String) session.getAttribute("orgCode");
    String strRegionCode = orgCode.substring(0, 2);
%>

        
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=strRegionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="2266" />	
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
      }
    }
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<script type=text/javascript>
  var e828_froms = ""; 
  $(function() {
    $('#shieldBusiTarget').val('0');
    $('input[name="shieldBusi"]').click(function(e){
        e.stopPropagation();
        
        var t = '';
        $('input[name="shieldBusi"]:checked').each(function(i, e){
            if (t == ''){
                t += $(this).val();
            }else {
                t += ',' + $(this).val();
            }
        });
        $('#shieldBusiTarget').val(t);
    });
    
    
    $('#shieldBusiTarget1').val('0');
    $('input[name="shieldBusi1"]').click(function(e){
        e.stopPropagation();
        
        var t = '';
        $('input[name="shieldBusi1"]:checked').each(function(i, e){
            if (t == ''){
                t += $(this).val();
            }else {
                t += ',' + $(this).val();
            }
        });
        $('#shieldBusiTarget1').val(t);
    });
    
    
    
  	 $('#busiType').change(function() {
  	 	var type = $('#busiType').val();
  	 	var opr_type = new Array();
  	 	if(type == '42') {
  	 		opr_type.push('<option value="001">黑名单用户添加或取消</option>');
  	 	}else if(type == '57') {
  	 		opr_type.push('<option value="001">黑名单新增</option>');
  	 		opr_type.push('<option value="002">黑名单删除</option>');
  	 		opr_type.push('<option value="003">营销消息屏蔽</option>');
  	 		opr_type.push('<option value="004">营销消息屏蔽取消</option>');
  	 		/*2014/08/06 9:39:24 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
  	 			加入 灰名单新增 灰名单删除
  	 		*/
  	 		opr_type.push('<option value="005">灰名单新增</option>');
  	 		opr_type.push('<option value="006">灰名单删除</option>');
  	 	}else if(type == '82') {
  	 		opr_type.push('<option value="001">营销短彩信激活或屏蔽</option>');
  	 		opr_type.push('<option value="002">灰名单加载/删除</option>');
  	 		opr_type.push('<option value="003">黑名单加载/删除</option>');
  	 	}else if(type == '72') {
  	 		opr_type.push('<option value="001">短/彩信屏蔽或取消屏蔽</option>');
  	 		opr_type.push('<option value="002">合作渠道黑名单添加</option>');
  	 	}else if(type == '64') {
  	 	
  	 	}	else if(type == '95') {
    	 	opr_type.push('<option value="001">黑名单加载</option>');
    	 	opr_type.push('<option value="002">黑名单取消</option>');
    	 	/*2014/08/06 8:33:56 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
    	 		e828 手机动漫增加 业务补发 异常行为用户操作 用户接收状态恢复
    	 	*/
    	 	opr_type.push('<option value="003">业务补发</option>');
    	 	opr_type.push('<option value="004">灰名单加载/删除</option>');
    	 	opr_type.push('<option value="005">动漫杂志接收状态操作</option>');
    	 	
    	 	opr_type.push('<option value="006">同步退订</option>');
    	 	opr_type.push('<option value="007">核查</option>');
    	 	
    	 	
    	 	//opr_type.push('<option value="008">黑名单批量加载</option>');
    	 	//opr_type.push('<option value="009">黑名单批量删除</option>');
		
  	 	}else if(type == '41') {
  	 		/*MobileMarket 2014/08/05 14:34:32 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知*/
  	 		opr_type.push('<option value="001">MM订购黑名单设置</option>');
  	 		opr_type.push('<option value="002">用户日月限额设置</option>');
  	 		opr_type.push('<option value="003">用户图形验证码设置</option>');
  	 		
  	 	}	else if(type == '70') {
  	 		opr_type.push('<option value="001">黑名单添加</option>');
  	 		opr_type.push('<option value="002">黑名单解除</option>');
  	 	}	else if(type == '62') {
  	 		opr_type.push('<option value="001">营销类邮件屏蔽</option>');
  	 	}	else if(type == '54') {
  	 		opr_type.push('<option value="001">和地图添加订购黑名单</option>');
  	 		opr_type.push('<option value="002">和地图删除订购黑名单</option>');
  	 	}	else if(type == '130') {
  	 		opr_type.push('<option value="001">业务黑名单新增</option>');
  	 		opr_type.push('<option value="002">业务黑名单删除</option>');
  	 	}	else if(type == '121') {
  	 		opr_type.push('<option value="001">黑名单添加</option>');
  	 		opr_type.push('<option value="002">黑名单删除</option>');
  	 		opr_type.push('<option value="003">灰名单添加</option>');
  	 		opr_type.push('<option value="004">灰名单删除</option>');
			
  	 	}else if(type == '47') {
  	 		opr_type.push('<option value="001">黑名单添加</option>');
  	 		opr_type.push('<option value="002">黑名单删除</option>');
  	 	}	
  	 	
  	 	
  	 	$('#oprType').empty().append(opr_type.join(''));
  	 	//$('#oprType[@value="001"]').change();
  	 	/*2014/08/06 9:51:27 gaopeng  修改为下拉列表的第一列改变 这样就不会约束到必须开始是001了*/
  	 	$("#oprType").eq(0).change();
  	 });
  	
  	 $("#busiType[@value='42']").change();
  	 
  	 
	 $('#oprType').change(function() {
	 	var busiType = $('#busiType').val();
		var oprType = $('#oprType').val();
		$('.tbody_form').css('display','none');	
	 	$('#d_' + busiType + '_' + oprType).css('display','block');	
	 });
	 
  	 $('#submitBtn').click(function() {
    		//1. 获得选择的业务类别
    		var busiType = $('#busiType').val();
    		//2. 获得操作类型
    		var oprType = $('#oprType').val();
    		//3. 获取form表单
    		
    		if(!checkObj($('#d_' + busiType + '_' + oprType))){
    			return false;
    		}
    		
    		if(busiType == '95' && oprType == '001'){
    		    if ($('input[name="shieldBusi"]:checked').length <= 0){
    		        rdShowMessageDialog("请至少选择一项被屏蔽业务！");
    		        return;
    		    }
    		}
    		
    		
    		var provCode ='451';
    		var phoneNo = $('#d_' + busiType + '_' + oprType + '_phone').val();
    		if(!phoneNo) {
    			phoneNo = '';	
    		}
    		var resultStr = getValue('d_' + busiType + '_' + oprType);
    		
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
           
    		
    		showLightBox();
    		var packet = new AJAXPacket("fe828_2.jsp","正在获得相关信息，请稍候......");
    		var _data = packet.data;
    		_data.add("busiType",busiType);
    		_data.add("oprType",oprType);
    		_data.add("phoneNo",phoneNo);
    		_data.add("opCode",'<%=opCode%>');
    		_data.add("provCode",provCode);
    		_data.add("infoStr",resultStr);
    		_data.add("jsonstr",jsonstr);
    		core.ajax.sendPacket(packet);
    		packet = null;
  	 });
  	 
  	 
  	 /* liujian 重置 2012-5-4 13:32:02 */
  	 $('#clearBtn').click(function() {
  	 
  	 window.location.href = "fe828_1.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
  	 
  	 	$('input[type="text"]').val('');
		$("select").each(function(){
			$(this).get(0).options[0].selected = true;  
		}); 
		$("#busiType[value=42]").change();
  	 });
  });
 
  function doProcess(package) {
  		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		if(retCode == "000000") {
				rdShowMessageDialog("提交成功！");
		}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
		}
		hideLightBox();
  }
  		
  //获得this.id是id的tbody内的form表单，只限input和select
   function getValue(id) {
    	var arr = new Array();
    	$('#' + id).find('td').each(function(i){
    		var $this = $(this);
    		$this.find('input').not('.ignore').each(function(){
    			arr.push($(this).val());
    		});
    		$this.find('select').each(function(){
    			arr.push($(this).val());
    		});
    	}); 
    	return arr.join('|');
  }
  function check() {
	
  }
  	
  function showBox() {
	showLightBox();
  }
	
  function hideBox() {
	hideLightBox();	
  }
</script>

<body>
<form name="frm" action="fe828_2.jsp" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<input type="hidden" value=""  id="jsontext" name="jsontext" />
		<div>
				<table cellspacing=0>
				    <tr>
				        <td class='blue' width="15%">业务类别</td>
				        <td width="35%">
				        	<select id="busiType">
				        		
				        		<option value="42">咪咕阅读</option>
				        		<option value="57">咪咕游戏</option>
				        <!--	<option value="64">手机支付</option> -->
					        	<option value="72">咪咕音乐</option>
					        	<option value="95">咪咕动漫</option>
								<option value="82">咪咕视频</option>
								<option value="41">MobileMarket</option>
								
								<option value="70">通信账户支付</option>
								<option value="62">139邮箱</option>
								<option value="54">手机导航</option>
								<option value="130">12582基地</option>
								<option value="121">12590语音杂志业务</option>
								<option value="47">卓望MDO</option>
								
							</select>
				        </td>
				        <td class='blue' width="15%">操作类型</td>
				        <td width="35%">
				        	<select id="oprType">
							</select>
				        </td>
				    </tr>    
				    <!-- 手机阅读42--黑名单激活或屏蔽-->
				    <tbody id="d_42_001" class="tbody_form" >
				   		<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" value="<%=activePhone%>" name="d_42_001_phone" id="d_42_001_phone" readonly class="InputGrey"  v_must ='1' maxlength="11" 
									onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>类型</td>
					        <td>
								<select>
									<option value="0">短信</option>
									<option value="1">彩信</option>
									<option value="2">Wap Push</option>
									<option value="3">图形验证码</option>
									<option value="4">订购黑名单用户</option>
								</select>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>操作类型</td>
					        <td>
								<select>
									<option value="0">取消</option>
									<option value="1">添加</option>
								</select>
					        </td>
					        <td class='blue'>操作人姓名</td>
					        <td>
								    <input type="text" value="<%=workName%>" maxlength="30" onblur="checkElement(this)"/>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>操作人ID</td>
					        <td>
								<input type="text" value="<%=workNo%>" maxlength="10" onblur = "checkElement(this)"/>
					        </td>
					        <td class='blue'>省份ID</td>
					        <td>
								<input type="hidden" value="451" maxlength="20" class="InputGrey" readonly /><span>黑龙江</span>
					        </td>
					    </tr>
					</tbody>
					
					<!-- 手机游戏57--黑名单新增-->
					<tbody id="d_57_001" class="tbody_form" style="display:none">
				   		<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" value="<%=activePhone%>" name="d_57_001_phone" id="d_57_001_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
									onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onblur = "checkElement(this)"/>
									<font class="orange">*</font>
					        </td>
					        <td class='blue'>名单级别</td>
					        <td>
					        	<select>
					        		<option value="1">禁止所有业务计费</option>
								</select>
							</td>
					    </tr>
					    <tr>
					        <td class='blue'>黑名单来源</td>
					        <td>
								<select>
											<option value="2">客服</option>
					        		<option value="1">BOC</option>					        		
					        		<option value="3">CPID</option>
								</select>
					        </td>
					        <td class='blue'>黑名单添加方式</td>
					        <td>
										<select>
													<option value="1">用户主动要求添加</option>
							        		<option value="2">非用户主动要求添加</option>					        		
										</select>
					        </td>
					        
					    </tr>
					</tbody> 
					
					<!-- 手机游戏--黑名单删除-->
					<tbody id="d_57_002" class="tbody_form" style="display:none">
				   		<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" name="d_57_002_phone" id="d_57_002_phone" value="<%=activePhone%>"  readonly class="InputGrey" v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
								
					        </td>
					        <td class='blue'></td>
					        <td>
					        </td>
					    </tr>
					</tbody> 	
					
					<!-- 手机游戏--营销消息屏蔽-->
					<tbody id="d_57_003" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" name="d_57_003_phone" id="d_57_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>号码来源</td>
			        <td>
			          <select name="d_57_003_resource">
			            <option value="2">用户投诉</option>
			            <option value="0">未知</option>
			            <option value="1">短信上行</option>
			            <option value="3">地市反馈</option>
			          </select>
			        </td>
				    </tr>
				    
				    <tr>
				      <td class="blue">屏蔽范围</td>
				      <td colspan="3">
				        <select name="d_57_003_range">
			            <option value="0">屏蔽短信/push</option>
			            <option value="1">屏蔽彩信</option>
			            <option value="2">屏蔽短信和彩信</option>
			          </select>
			        </td>
				    </tr>
					</tbody> 	
					
					<!-- 手机游戏--营销消息屏蔽取消-->
					<tbody id="d_57_004" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" name="d_57_004_phone" id="d_57_004_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>屏蔽范围</td>
			        <td>
			          <select name="d_57_004_range">
			            <option value="0">屏蔽短信/push</option>
			            <option value="1">屏蔽彩信</option>
			            <option value="2">屏蔽短信和彩信</option>
			          </select>
			        </td>
				    </tr>
					</tbody>
					
					<!-- 2014/08/06 9:40:22 gaopeng 手机游戏--灰名单新增-->
					<tbody id="d_57_005" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" name="d_57_005_phone" id="d_57_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>灰名单来源</td>
			        <td>
			          <select name="d_57_005_range">
			          	<option value="2">客服</option>
			            <option value="1">BOC</option>			            
			            <option value="3">CPID(指特定合作方提交的黑名单用户)</option>
			          </select>
			        </td>
				    </tr>
					</tbody>
					
					<!-- 2014/08/06 9:40:22 gaopeng 手机游戏--灰名单新增-->
					<tbody id="d_57_006" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td colspan="3">
								<input type="text" name="d_57_006_phone" id="d_57_006_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
				    </tr>
					</tbody>
					
					<!-- 无线音乐72--黑名单屏蔽日志查询-->
					<tbody id="d_72_001" class="tbody_form" style="display:none">
						<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" name="d_72_001_phone" id="d_72_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>操作类型</td>
					        <td>
					        	<select>
					        		<option value="2">黑名单添加</option>
					        		<option value="3">黑名单删除</option>
					        	</select>
					        </td>
					    </tr>
					    <tr>
					        <td class='blue'>黑名单类型</td>
					        <td colspan="3">
					        	<select>
					        		<option value="0">全局黑名单</option>
					        		<option value="1">营销黑名单</option>
					        	</select>
					        </td>
					    </tr>
					</tbody>
					
					<!-- 无线音乐72--合作渠道黑名单添加-->
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
			        <td class='blue'>省份</td>
			        <td>
			          <input type="hidden" value="451" class="InputGrey" readonly /><span>黑龙江</span>
			        </td>
				    </tr>
					    
				    <tr>
			        <td class='blue'>操作人员</td>
			        <td colspan="3">
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
				    </tr>
					</tbody>
					
					<!-- 手机视频82--黑名单激活或屏蔽-->
					<tbody id="d_82_001" class="tbody_form" style="display:none">
				   		<tr>
					        <td class='blue'>用户手机号码</td>
					        <td>
								<input type="text" value="<%=activePhone%>" name="d_82_001_phone" id="d_82_001_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
								onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>被屏蔽业务</td>
					        <td>
								<select>
									<option value="1">短信业务</option>
									<option value="2">彩信业务</option>
									<option value="3">WAP业务</option>
								</select>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>操作类型</td>
					        <td>
								<select>
									<option value="0">屏蔽</option>
									<option value="1">激活</option>
								</select>
					        </td>
					        <td class='blue'>操作人姓名</td>
					        <td>
								<input type="text" value="<%=workName%>" maxlength="30" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					    </tr>
					    <tr>
					    	<td class='blue'>操作人ID</td>
					        <td>
								<input type="text" value="<%=workNo%>" maxlength="10" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>省份ID</td>
					        <td>
								<input type="hidden" value="451" maxlength="15" class="InputGrey" readonly/><span>黑龙江</span>
					        </td>
					    </tr>
					</tbody>
					
					<!-- 手机视频82--图形验证码用户添加-->
					<tbody id="d_82_002" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  name="d_82_002_phone" id="d_82_002_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
								onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>图形验证码号码有效期</td>
			        <td>
								<select>
									<option value="1">一个月</option>
									<option value="3">三个月</option>
									<option value="12">十二个月</option>
									<option value="120">长期</option>
								</select>
				        </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>操作人姓名</td>
				      <td>
							  <input type="text" value="<%=workName%>" maxlength="30" v_must ='1' 
								onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
				      </td>
				      
				      <td class='blue'>操作人ID</td>
					    <td>
								<input type="text" value="<%=workNo%>" maxlength="10" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					    </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>省份ID</td>
			        <td>
							  <input type="hidden" value="451" maxlength="15" class="InputGrey" readonly/><span>黑龙江</span>
				      </td>
				      	<!--2014/08/06 9:31:51 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
					 手机视频82--加入操作类型-->
				      <td class='blue'>操作类型</td>
					    <td>
								<select name="">
									<option value="1">添加</option>
									<option value="2">取消</option>
								</select>
					    </td>
				    </tr>
					</tbody>
					
					<!--2014/08/06 9:31:51 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
					 手机视频82--业务黑名单添加和取消-->
					<tbody id="d_82_003" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  name="d_82_003_phone" id="d_82_003_phone"  readonly class="InputGrey"  v_must ='1' maxlength="11" 
								onkeyup="this.value=this.value.replace(/\D/g,'')" 
								onafterpaste="this.value=this.value.replace(/\D/g,'')"
								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>黑名单有效期</td>
			        <td>
								<select>
									<option value="1">一个月</option>
									<option value="3">三个月</option>
									<option value="12">十二个月</option>
									<option value="120">长期</option>
								</select>
				        </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>操作人姓名</td>
				      <td>
							  <input type="text" value="<%=workName%>" maxlength="30" v_must ='1' 
								onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
				      </td>
				      
				      <td class='blue'>操作人ID</td>
					    <td>
								<input type="text" value="<%=workNo%>" maxlength="10" v_must ='1' 
									onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					    </td>
				    </tr>
				    
				    <tr>
			        <td class='blue'>省份ID</td>
			        <td>
							  <input type="hidden" value="451" maxlength="15" class="InputGrey" readonly/><span>黑龙江</span>
				      </td>
				      <td class='blue'>操作类型</td>
					    <td>
								<select name="">
									<option value="1">添加</option>
									<option value="2">取消</option>
								</select>
					    </td>
				    </tr>
					</tbody>
					
					<!-- 手机动漫95--黑名单新增-->
					<tbody id="d_95_001" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' maxlength="11"  name="d_95_001_phone" id="d_95_001_phone"
  								onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>屏蔽类型</td>
			        <td>
								<input type="radio" class="ignore" name="shieldBusi" value="1"><span>短信</span>
								<input type="radio" class="ignore" name="shieldBusi" value="2"><span>彩信</span>
								<input type="radio" class="ignore" name="shieldBusi" value="3"><span>集团彩漫</span>
								<input type="radio" class="ignore" name="shieldBusi" value="4"><span>Wap Push</span>
								<input type="radio" class="ignore" name="shieldBusi" value="5"><span>动漫导视</span>
								<input type="radio" class="ignore" name="shieldBusi" value="7"><span>动漫杂志（短信）</span>
								
								<input type="radio" class="ignore" name="shieldBusi" value="8"><span>动漫杂志（彩信）</span>
								<input type="radio" class="ignore" name="shieldBusi" value="9"><span>个人彩漫</span>
								<input type="radio" class="ignore" name="shieldBusi" value="21"><span>限制点播</span>
								<input type="radio" class="ignore" name="shieldBusi" value="22"><span>限制包月</span>
								<input type="radio" class="ignore" name="shieldBusi" value="23"><span>限制漫币消费</span>
								<input type="radio" class="ignore" name="shieldBusi" value="24"><span>限制积分累计</span>
								<input type="radio" class="ignore" name="shieldBusi" value="25"><span>限制购买漫币</span>
								<input type="radio" class="ignore" name="shieldBusi" value="26"><span>限制个人彩漫</span>

								<input type="hidden" id="shieldBusiTarget" value="">
				      </td>
				    </tr>
				    
				    
					</tbody>
					
					<!-- 手机动漫95--黑名单取消-->
					<tbody id="d_95_002" class="tbody_form" style="display:none">
			   		<tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' maxlength="11"  name="d_95_002_phone" id="d_95_002_phone"
  								onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
								<font class="orange">*</font>
			        </td>
			        
			        <td class='blue'>屏蔽类型</td>
			        <td>
								<input type="radio" class="ignore" name="shieldBusi1" value="1"><span>短信</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="2"><span>彩信</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="3"><span>集团彩漫</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="4"><span>Wap Push</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="7"><span>动漫杂志（短信）</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="8"><span>动漫杂志（彩信）</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="9"><span>个人彩漫</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="21"><span>限制点播</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="22"><span>限制包月</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="23"><span>限制漫币消费</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="24"><span>限制积分累计</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="25"><span>限制购买漫币</span>
								<input type="radio" class="ignore" name="shieldBusi1" value="26"><span>限制个人彩漫</span>

								<input type="hidden" id="shieldBusiTarget1" value="">
				      </td>
				    </tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					 手机动漫 业务补发 95 006 
					 -->
					<tbody id="d_95_003" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户手机号码</td>
			        <td>
								<input type="text" name="d_95_003_phone" id="d_95_003_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
					    <td class='blue'>业务ID</td>
					    <td>
					    	<select name="d_95_003_opId" id="d_95_003_opId">
					    		<option value="0" selected>每日一笑</option>	
					    		<option value="1">漫话天下</option>	
					    		<option value="2">日韩动漫</option>	
					    		<option value="3">时事天下体验版</option>	
					    		<option value="4">漫话天下体验版</option>	
					    		<option value="5">日韩动漫体验版</option>	
					    		<option value="6">每日一笑体验版</option>	
					    		<option value="7">星座漫缘（体验）</option>	
					    		<option value="8">学堂漫语（体验）</option>	
					    		<option value="9">漫画文斋（体验）</option>	
					    		<option value="10">大画体坛（体验）</option>	
					    		<option value="11">漫谈养生（体验）</option>	
					    		<option value="12">英汉动漫（体验）</option>	
					    		<option value="13">星座漫缘</option>	
					    		<option value="14">学堂漫语</option>	
					    		<option value="15">大画体坛</option>	
					    		<option value="16">漫画国学</option>	
					    		<option value="17">漫谈养生</option>	
					    		<option value="18">英汉动漫</option>	
					    		<option value="19">漫话文史（体验）</option>	
					    		<option value="20">漫话文史</option>	
					    		<option value="21">手机动漫杂志-漫话国学</option>	
					    		<option value="22">飞信红钻贵族（包月）</option>	
					    	</select>	
					    </td>
			    	</tr>
			    	<tr>
			        <td class='blue'>补发时间</td>
			        <td colspan="3">
								<input name="d_95_003_opTime" type="text" id="d_95_003_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_95_003_opTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
											v_type="date" value="<%=dateStr22%>"  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_95_003_opTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmdd)*</font>	
					    </td>
					  </tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					 手机动漫 异常行为用户操作 95 007 
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
					    <td class='blue'>操作方式</td>
					    <td>
					    	<select name="d_95_004_opId" id="d_95_004_opId">
					    		<option value="0" selected>增加</option>	
					    		<option value="1">删除</option>	
					    		<option value="2">更新</option>	
					    	</select>	
					    </td>
			    	</tr>
					</tbody>
					
					<!--2014/08/05 8:59:23 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					 手机动漫 用户接收状态恢复 95 008
					 -->
					<tbody id="d_95_005" class="tbody_form" style="display:none">
					  <tr>
			        <td class='blue'>用户手机号码</td>
			        <td colspan="3">
								<input type="text" name="d_95_005_phone" id="d_95_005_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must="1"
									maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
									onafterpaste="this.value=this.value.replace(/\D/g,'')" 
									onblur = "checkElement(this)"/>
							  <font class="orange">*</font>
					    </td>
			    	</tr>
					</tbody>

					
					<!-- MobileMarket-- e828 MM订购黑名单设置 41_003-->
					<tbody id="d_41_001" class="tbody_form" style="display:none">
				   		<tr>
				        <td class='blue'>用户手机号码</td>
				        <td >
  								<input type="text" name="d_41_001_phone" id="d_41_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1' 
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
				        </td>
				        <td class='blue'>动作标识</td>
				        <td >
  								<select name = "d_41_001_optype" id="d_41_001_optype">
  									<option value="1">加入黑名单</option>
  									<option value="2">取消黑名单</option>
  								</select>
					        	<font class="orange">*</font>
				        </td>
					    </tr>
					     <tr>
									<td class='blue'>开始时间</td>
					        <td colspan="3">
					        	<input name="d_41_001_begTime" type="text" id="d_41_001_begTime" v_must ='0'  value="<%=dateStr8888str%>"
					        		onclick="WdatePicker({el:'d_41_001_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
											v_type="dateTime" value=""  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_41_001_begTime',startDate:'%y%M%d',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyymmddhh24miss)*</font>
					        </td>
					     </tr>
					</tbody>
					
					
					<!-- MobileMarket--002	用户日月限额设置 41_002-->
					
					<tbody id=d_41_002 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>消息类型</td>
			        <td >
								<input type="text" name="d_41_002_type" id="d_41_002_type" value="CCSetMSDNLimitReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>版本</td>
			        <td >
								<input type="text" name="d_41_002_version" id="d_41_002_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>用户手机号码</td>
			        <td colspan="3">
								<input type="text" name="d_41_002_phone" id="d_41_002_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					   </tr>
					   
					   	<td class='blue'>日限额</td>
			        <td >
								<input type="text" name="d_41_002_day" id="d_41_002_day" v_type="0_9"  onblur = "checkElement(this)"  value="" maxlength="20"   />
					    </td>			
					    
					    <td class='blue'>月限额</td>
			        <td >
								<input type="text" name="d_41_002_month" id="d_41_002_month" v_type="0_9"  onblur = "checkElement(this)" value="" maxlength="20"  />
					    </td>	
					   </tr>
					 </tbody>  
					   
					<!-- MobileMarket-- 003	用户图形验证码设置 41_003-->
					<tbody id=d_41_003 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>消息类型</td>
			        <td >
								<input type="text" name="d_41_003_type" id="d_41_003_type" value="CCSetGraphicsVerificationReq" maxlength="50"
								 readOnly  />
					    </td>			
					    
					    <td class='blue'>版本</td>
			        <td >
								<input type="text" name="d_41_003_version" id="d_41_003_version" value="1.0.0" maxlength="50"
								 readOnly  />
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>用户手机号码</td>
			        <td >
								<input type="text" name="d_41_003_phone" id="d_41_003_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
					    </td>			
					    
					 
					    <td class='blue'>显示标志</td>
			        <td >
								<select name="d_41_003_flag" id="d_41_003_flag">
									<option value="0">不显示</option>
									<option value="1">显示</option>
								</select>
					    </td>	
					   </tr>
					 </tbody>
					
					
						<!-- 95 咪咕动漫-- 	006	同步退订  -->
						<tbody id=d_95_006 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>用户手机号码/邮箱帐号</td>
			        <td >
								<input type="text" name="d_95_006_phone" id="d_95_006_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>产品ID</td>
			        <td >
								<input type="text" name="d_95_006_pid" id="d_95_006_pid" value="" maxlength="25"  v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>结束时间</td>
			        <td colspan="3">
								<input name="d_95_006_endTime" type="text" id="d_95_006_endTime" value="<%=dateStr%>"
								onclick="WdatePicker({el:'d_95_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_006_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>			
					   </tr>
					 </tbody>
					
						
						<!-- 95 咪咕动漫-- 	007	核查  -->
										<tbody id=d_95_007 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>用户手机号码/邮箱帐号</td>
			        <td >
								<input type="text" name="d_95_007_phone" id="d_95_007_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>产品ID</td>
			        <td >
								<input type="text" name="d_95_007_pid" id="d_95_007_pid" value="" maxlength="25"  v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>消费时间</td>
			        <td colspan="3">
								<input name="d_95_007_endTime" type="text" id="d_95_007_endTime" value="<%=dateStr%>"
								onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
								v_must ='1' maxlength="19"  onblur = "checkElement(this)"/>
  										<img id = "imgCustEnd" 
											onclick="WdatePicker({el:'d_95_007_endTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:false})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd hh24:mi:ss)*</font>
					    </td>			
					   </tr>
					 </tbody>
						<!-- 95 咪咕动漫--  008	黑名单批量加载  -->
						<tbody id=d_95_008 class="tbody_form" style="display:none">
							<tr>
						<td class='blue'>用户手机号码</td>
			        <td >
								<input type="text" name="d_95_008_phone" id="d_95_008_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>&nbsp;</td>
			        <td >
			        	&nbsp;
					    </td>	
					   </tr>
					    <tr>
					<tr>
						<td class='blue'>批量新增清单</td>
			        <td >
								<textarea type="text" name="d_95_008_list" id="d_95_008_list"   ></textarea>
									
									
								 <font class="orange">*</font>
					    </td>		
					    <td colspan="2">
					    	每一行应包括：用户手机号码，屏蔽类型<br>
					    	屏蔽类型:<br>
					    	屏蔽接收：1短信 2彩信 3集团彩漫 4Wap Push 5动漫导视 7动漫杂志（短信）、8动漫杂志（彩信）、9个人彩漫；<br>
								消费限制：21限制点播、22限制包月、23限制漫币消费、24限制积分累计、25限制购买漫币、26限制个人彩漫）<br>

					    </td>	
					   </tr>
					 </tbody>
						
						<!-- 95 咪咕动漫-- 	009	黑名单批量删除  -->
							<tbody id=d_95_009 class="tbody_form" style="display:none">
								<tr>
						<td class='blue'>用户手机号码</td>
			        <td >
								<input type="text" name="d_95_009_phone" id="d_95_009_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>&nbsp;</td>
			        <td >
			        	&nbsp;
					    </td>	
					   </tr>
					    <tr>
					<tr>
						<td class='blue'>批量删除清单</td>
			        <td >
								<textarea type="text" name="d_95_009_list" id="d_95_009_list"   ></textarea>
									
									
								 <font class="orange">*</font>
					    </td>		
					    <td colspan="2">
					    	每一行应包括：用户手机号码，屏蔽类型<br>
					    	屏蔽类型:<br>
					    	屏蔽接收：1短信 2彩信 3集团彩漫 4Wap Push 5动漫导视 7动漫杂志（短信）、8动漫杂志（彩信）、9个人彩漫；<br>
								消费限制：21限制点播、22限制包月、23限制漫币消费、24限制积分累计、25限制购买漫币、26限制个人彩漫）<br>

					    </td>	
					   </tr>
					 </tbody>
											
					
						<!-- 121 12590语音杂志业务-- 	002	黑名单删除  -->
						<tbody id=d_121_002 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>用户手机号码</td>
			        <td >
								<input type="text" name="d_121_002_phone" id="d_121_002_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>省份</td>
			        <td >
								<input type="text" name="d_121_002_s" id="d_121_002_s" value="451" readOnly v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    <tr>
						<td class='blue'>黑名单类型</td>
			        <td >
								<select name="d_121_002_type"  id="d_121_002_type">
  								<option value="1">拨打业务黑名单</option>
  								<option value="2">客户端业务黑名单</option>
  								<option value="3">短信业务黑名单</option>
  							</select>
					    </td>			
					    <td class='blue'>操作人员</td>
			        <td>
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
					   </tr>
					 </tbody>					

<!-- 121 12590语音杂志业务-- 	003	灰名单添加  -->
<tbody id=d_121_003 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>用户手机号码</td>
			        <td >
								<input type="text" name="d_121_003_phone" id="d_121_003_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>省份</td>
			        <td >
								<input type="text" name="d_121_003_s" id="d_121_003_s" value="451" readOnly v_must="1"  />
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
					    <tr>
					 
					    <td class='blue'>操作人员</td>
			        <td colspan="3">
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
					   </tr>
					 </tbody>	
<!-- 121 12590语音杂志业务-- 	004	灰名单删除  -->
<tbody id=d_121_004 class="tbody_form" style="display:none">
					<tr>
						<td class='blue'>用户手机号码</td>
			        <td >
								<input type="text" name="d_121_004_phone" id="d_121_004_phone" value="<%=activePhone%>" maxlength="50"
								 readOnly  />
								 <font class="orange">*</font>
					    </td>			
					    
					    <td class='blue'>省份</td>
			        <td >
								<input type="text" name="d_121_002_s" id="d_121_002_s" value="451" readOnly v_must="1"  />
								<font class="orange">*</font>
					    </td>	
					   </tr>
					    
					    <tr>
					 
					    <td class='blue'>操作人员</td>
			        <td colspan="3">
  							<input type="text" maxlength="40"  onblur = "checkElement(this)" maxlength="32"  value="<%=workNo%>"
  							  v_must ='1'  onblur = "checkElement(this)"/><font class="orange">*</font>
				      </td>
					   </tr>
					 </tbody>	

					<!-- 通信账户支付 黑名单添加1 70_001 -->
					<tbody id=d_70_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_70_001_phone" id="d_70_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>添加原因</td>
			        <td>
  							<select name="d_70_001_addres"  id="d_70_001_addres">
  								<option value="7">用户要求屏蔽通信账户服务</option>
  								<option value="8">移动要求屏蔽通信账户服务</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>
	 					<!-- 通信账户支付 黑名单解除1 70_002 -->
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
					    <td class='blue'>解除原因</td>
			        <td>
  							<input name="d_70_002_remres" type="text" id="d_70_002_remres" value=""  v_must='1' />
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>
					
					
					<!-- 139邮箱 营销类邮件屏蔽 62_001 -->
					<tbody id=d_62_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户级别</td>
			        <td>
  							<input name="d_62_001_custlive" type="text" id="d_62_001_custlive" value="3"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>用户所属公司</td>
			        <td>
  							<input name="d_62_001_custcomp" type="text" id="d_62_001_custcomp" value="黑龙江移动"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>用户所属部门</td>
			        <td>
  							<input name="d_62_001_custgroup" type="text" id="d_62_001_custgroup" value="客服"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>推荐人姓名</td>
			        <td>
  							<input name="d_62_001_t_name" type="text" id="d_62_001_t_name" value="<%=workNo%>"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>用户姓名</td>
			        <td>
  							<input name="d_62_001_custname" type="text" id="d_62_001_custname" value="<%=bp_name%>"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>说明备注</td>
			        <td>
  							<input name="d_62_001_opmemo" type="text" id="d_62_001_opmemo" value="客户要求"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>手机号码</td>
					      <td colspan="3">
								  <input type="text" name="d_62_001_phone" id="d_62_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					  </tr>
					</tbody>					
					
					
					<!-- 手机导航 和地图添加订购黑名单 54_001 -->
					<tbody id=d_54_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_54_001_phone" id="d_54_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>类型</td>
			        <td>
  							<select name="d_54_001_type"  id="d_54_001_type">
  								<option value="0">订购黑名单</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 手机导航 和地图删除订购黑名单 54_002 -->
					<tbody id=d_54_002 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td>
								  <input type="text" name="d_54_002_phone" id="d_54_002_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>
					    <td class='blue'>类型</td>
			        <td>
  							<select name="d_54_002_type"  id="d_54_002_type">
  								<option value="0">订购黑名单</option>
  							</select>
								<font class="orange">*</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12582业务 业务黑名单新增 130_001 -->
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
					    <td class='blue'>屏蔽类型</td>
			        <td>
  							<select name="d_130_001_type"  id="d_130_001_type">
  								<option value="0">表示全部</option>
  								<option value="1">表示短信</option>
  								<option value="2">表示彩信</option>
  							</select>

								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>添加原因</td>
			        <td>
  							<input name="d_130_001_addres" type="text" id="d_130_001_addres" value="10086"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>操作员</td>
			        <td>
  							<input name="d_130_001_oprworkno" type="text" id="d_130_001_oprworkno" value="<%=workNo%>"  v_must='1' />
								<font class="orange">*“编码-描述”形式</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>屏蔽产品编码</td>
			        <td colspan="3">
  							<input name="d_130_001_prodcode" type="text" id="d_130_001_prodcode" value=""  v_must='0' />
								<font class="orange">产品编码大写</font>
					    </td>

					  </tr>
					</tbody>					
					<!-- 12582业务 业务黑名单删除 130_002 -->
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
					    <td class='blue'>屏蔽类型</td>
			        <td>
  							<select name="d_130_002_type"  id="d_130_002_type">
  								<option value="0">表示全部</option>
  								<option value="1">表示短信</option>
  								<option value="2">表示彩信</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>删除原因</td>
			        <td>
  							<input name="d_130_002_delres" type="text" id="d_130_002_delres" value="10086"  v_must='1' />
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>操作员</td>
			        <td>
  							<input name="d_130_002_oprworkno" type="text" id="d_130_002_oprworkno" value="<%=workNo%>"  v_must='1' />
								<font class="orange">*“编码-描述”形式</font>
					    </td>
					  </tr>
					  <tr>
					    <td class='blue'>屏蔽产品编码</td>
			        <td>
  							<input name="d_130_002_prodcode" type="text" id="d_130_002_prodcode" value=""  v_must='0' />
								<font class="orange">产品编码大写</font>
					    </td>

					  </tr>
					</tbody>					
					
					<!-- 12590系统平台 黑名单添加11 121_001 -->
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
					    <td class='blue'>省份</td>
			        <td>
  							<input name="d_121_001_String" type="text" id="d_121_001_String" value="451"  v_must='1'  readonly class="InputGrey"  />
								<font class="orange">*</font>
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
					  <tr>
					    <td class='blue'>黑名单类型</td>
			        <td>
  							<select name="d_121_001_String"  id="d_121_001_String">
  								<option value="1">拨打业务黑名单</option>
  								<option value=" 2">客户端业务黑名单</option>
  								<option value="3">短信业务黑名单</option>
  							</select>
								<font class="orange">*</font>
					    </td>
					    <td class='blue'>操作人员</td>
			        <td>
  							<input name="d_121_001_String" type="text" id="d_121_001_String" value=""  v_must='1' />
								<font class="orange">*“编码-描述”形式</font>
					    </td>

					  </tr>
					</tbody>					
					
						<!-- 卓望mdo 黑名单添加11 47_001 -->
					<tbody id=d_47_001 class="tbody_form" style="display:none">
					  <tr>
					    <td class='blue'>用户手机号码</td>
					      <td >
								  <input type="text" name="d_47_001_phone" id="d_47_001_phone" value="<%=activePhone%>"  readonly class="InputGrey"  v_must ='1'
  								maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" 
  								onafterpaste="this.value=this.value.replace(/\D/g,'')"
  								onblur = "checkElement(this)"/>
					        	<font class="orange">*</font>
					      </td>

					    <td class='blue'>屏蔽终止时间</td>
			        <td>
									<input name="d_47_001_opTime" type="text" id="d_47_001_opTime" v_must ='1' 
					        		onclick="WdatePicker({el:'d_47_001_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
											 value="2050-01-01" readonly  maxlength="19" onblur = "checkElement(this)"/>
					       		<img id = "imgCustStart" 
											onclick="WdatePicker({el:'d_47_001_opTime',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
										<font class="orange">(yyyy-mm-dd)*</font>	
			        </td>
			        
					  </tr>
					  <tr>
					    <td class='blue'>操作人员</td>
			        <td colspan="3">
  							<input name="d_47_001_String" type="text" id="d_121_001_String" value="<%=workNo%>"  v_must='1' maxlength="50"/>
								<font class="orange">*“编码-描述”形式</font>
					    </td>

					  </tr>
					</tbody>
					
									<!-- 卓望mdo 黑名单删除11 47_002 -->
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
					</tbody>		
					
					
										
			    <tr id='footer'>
			        <td colspan='4'>
			            <input type="button"  id="submitBtn" class='b_foot' value="执行" name="submitBtn" />
			            <input type="button"  id="clearBtn" class='b_foot' value="重置" name="clear" />
			            <input type="button" class="b_foot" id="close" name="close" value="关闭" onclick="removeCurrentTab()"/>
			        </td>
			    </tr>
				</table>
		</div>
		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
