<%
  /*
   * 功能: 资费与终端分离目标用户导入 g982
   * 版本: 1.0
   * 日期: 2013/9/17
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
	brandSb.append("<option value ='all'>所有品牌</option>");
	for(int i=0; i<result_brand.length; i++) {
		  brandSb.append("<option value ='").append(result_brand[i][0]).append("'>")
						 .append(result_brand[i][1])
						 .append("</option>");
	}
	
	//获取所有的当前地市
	//lj. 绑定参数
	String sql_select2 = "select a.region_name from sregioncode a where a.region_code=:regioncode";
	String srv_params2 = "regioncode=" + regionCode;
	
	String regionCodeStr = "";
%>
	<wtc:service name="TlsPubSelCrm" outnum="3" retcode="retCode_region" retmsg="retMsg_region">
		<wtc:param value="<%=sql_select2%>"/>
		<wtc:param value="<%=srv_params2%>"/>
	</wtc:service>
	<wtc:array id="result_regioncode" scope="end"/>
<%
  if("000000".equals(retCode_region)){
    if(result_regioncode.length>0){
      regionCodeStr = result_regioncode[0][0];
    }
  }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script>
	var bankInstalArr = new Array();
	$(function() {		
		//设置手机品牌的下拉列表
		$('#phone_brand').append("<%=brandSb.toString()%>");
	    //展示对应地市
	    $('#region_code').val("<%=regionCodeStr%>");
	});
	/*************************切换手机品牌*****************************/
  function changeBrand(){
  	//获得手机品牌
  	var brand = $('#phone_brand').val();
  	//把所有设置成空
  	$("#phone_type").empty();
  	
  	if(brand=="all"){ //如选择所有品牌，则手机类型则只能展示所有类型
  	  var txt = '<option value="-1" >--请选择--</option>';
  	  txt = txt + '<option value="all" >所有机型</option>';
  	  $('#phone_type').append(txt);
  	}else{
  	  var packet = new AJAXPacket("srv.jsp","正在获得相关信息，请稍候......");
      var _data = packet.data;
      _data.add("sale_type","<%=sale_type%>");
      _data.add("brand_code",$('#phone_brand').val());
      _data.add("method","apply_getPhoneTypes");
      core.ajax.sendPacket(packet,getPhoneType);
      packet = null;
  	}
  }
			
	function getPhoneType(package){
	  var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		var result = package.data.findValueByName("result");
		if(retCode == "000000") {
			//填充手机类型
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
		/*************************提交按钮注册事件****************************/
		function nextStep() {
		  var slecopFlag =$("input[@name=opFlag][@checked]").val();
		  if(slecopFlag=="one"){ //增加
		    printCommit();	
		  }else if(slecopFlag=="two"){ //删除
		    queryInfo();
		  } else if(slecopFlag=="search"){ //条件查询
		    if (!validateCommonSearch()){
		      return;
		    }
		    commonSearch();
		  }  else { //流水查询
		    if (!forPosInt($('input[name="loginAccept"]')[0])){
		        return;
		    }
		    loginAcceptSearch();
		  }
		}
		
		function validateCommonSearch(){
		    var phone_brand = $('#phone_brand').val();//品牌
            var phone_type = $('#phone_type').val();//型号
            
		    if (phone_brand == '-1'){
		        rdShowMessageDialog('请选择品牌！', 0);
		        return false;
		    }
		    
		    if (phone_type == '-1'){
		        rdShowMessageDialog('请选择型号！', 0);
		        return false;
		    }
		    
		    return true;
		}
		
		function commonSearch(){
		    var phone_brand = $('#phone_brand').val();//品牌
            var phone_type = $('#phone_type').val();//型号
            var packet = new AJAXPacket("fg982_ajax_search.jsp","正在获得数据，请稍候......");
        	packet.data.add("phone_brand",phone_brand);
        	packet.data.add("phone_type",phone_type);
        	packet.data.add("region_code","<%=regionCode%>");
        	core.ajax.sendPacketHtml(packet,doQuery);
        	packet = null;
		}
		
		function loginAcceptSearch(){
            var packet = new AJAXPacket("fg982_ajax_loginAcceptSearch.jsp","正在获得数据，请稍候......");
        	packet.data.add("loginAccept",$('input[name="loginAccept"]').val());
        	packet.data.add("region_code",'<%=regionCode%>');
        	core.ajax.sendPacketHtml(packet,doQuery);
        	packet = null;
		}
		
		function queryInfo(){
		  var phone_brand = $('#phone_brand').val();//品牌
      var phone_type = $('#phone_type').val();//型号
      var packet = new AJAXPacket("fg982_ajax_queryDel.jsp","正在获得数据，请稍候......");
    	packet.data.add("phone_brand",phone_brand);
    	packet.data.add("phone_type",phone_type);
    	packet.data.add("regionCode","<%=regionCode%>");
    	core.ajax.sendPacketHtml(packet,doQuery);
    	packet = null;
		}
		
    function doQuery(data){
      //找到添加表格的div
			var markDiv=$("#intablediv"); 
			markDiv.empty().append(data);
      var retCode = $("#retCode").val();
      var retMsg = $("#retMsg").val();
      if(retCode!="000000"){
        rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
        return false;
      }
    }
    
    /*************************删除提交按钮事件****************************/
    function subDelInfo(){
      var slecdelQryRadio =$("input[@name=delQryRadio][@checked]");
      if(typeof(slecdelQryRadio)=="undefined"){
        rdShowMessageDialog("请选择一条数据进行操作！",1);
        return false;
      }
  		var regionCode = $("input[@name=delQryRadio][@checked]").attr("v_regionCode");
  		var phone_brand = $("input[@name=delQryRadio][@checked]").attr("v_phoneBrand");
      var phone_type = $("input[@name=delQryRadio][@checked]").attr("v_phoneType");
      var begin_time = $("input[@name=delQryRadio][@checked]").attr("v_beginTime");
      var end_time = $("input[@name=delQryRadio][@checked]").attr("v_endTime");
      document.frm.action="fg982_del_cfm.jsp?regionCode="+regionCode+"&phone_brand="+phone_brand+"&phone_type="+phone_type+"&begin_time="+begin_time+"&end_time="+end_time;
      document.frm.submit();
      return true;
		}
	/*************************清除按钮注册事件****************************/
	function clearInfo(){
			$('#phone_brand').val("-1");
			//$('#phone_brand').change();
			changeBrand();
			$('#begin_time').val("");
			$('#end_time').val("");
	}
		
		
	function printCommit() {
	  //getAfterPrompt();
	  var begin_time = $("#begin_time").val();
	  var end_time = $("#end_time").val();
	  if($('#phone_brand').val()=="-1"){
		  rdShowMessageDialog("请选择手机品牌!");
			$('#phone_brand').focus();
			return false;
		}
		if($('#phone_type').val()=="-1"){
		  rdShowMessageDialog("请选择手机类型!");
			$('#phone_type').focus();
			return false;
		}
		if(!check(document.frm)){
			return false;
		}else{
		  hiddenTip(document.frm.begin_time);
		  hiddenTip(document.frm.end_time);
		}
		if(begin_time.substr(0,8)>end_time.substr(0,8))
    {
      rdShowMessageDialog("开始时间应小于结束时间，请重新输入！");
      return false;
    }
		
		if(frm.feefile.value.length<1){
			rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
			document.frm.feefile.focus();
			return false;
		}
		setOpNote();
		frmCfm();
	}
	
  function setOpNote(){
    if(document.all.remark.value==""){
      document.all.remark.value = "操作员：<%=loginNo%>进行了资费与终端分离目标用户导入"; 
    }
    return true;
  }
  
  function frmCfm(){
    var phone_brand = $('#phone_brand').val();
    var phone_type = $('#phone_type').val();
    var begin_time = $('#begin_time').val();
    var end_time = $('#end_time').val();
    var remark = $('#remark').val();
    document.frm.action="fg982_upFile.jsp?phone_brand="+phone_brand+"&phone_type="+phone_type+"&begin_time="+begin_time+"&end_time="+end_time+"&remark="+remark;
    document.frm.submit();
    return true;
  }
  
  function operFlags(obj){
    if(obj.value=="one"){ //新增
      $("#regionTr").css("display","none");
      $("#timeTr").css("display","");
      $("#fileTr1").css("display","");
      $("#fileTr2,#brand").css("display","");
      //$('#reset_btn').click();
      clearInfo();
      $('#next_step').val("确定");
      $("#intablediv").empty();
      $('#loginAccept').hide();
    }else if(obj.value=="two"){
      $("#regionTr,#brand").css("display","");
      $("#timeTr").css("display","none");
      $("#fileTr1").css("display","none");
      $("#fileTr2").css("display","none");
      //$('#reset_btn').click();
      clearInfo();
      $('#next_step').val("查询");
      $("#intablediv").empty();
      $('#loginAccept').hide();
    } else if(obj.value=="search"){
      $("#regionTr,#brand").css("display","");
      $("#timeTr").hide();
      $("#fileTr1").css("display","none");
      $("#fileTr2").css("display","none");
      clearInfo();
      $('#next_step').val("查询");
      $("#intablediv").empty();
      $('#loginAccept').hide();
    } else {
      $("#regionTr,#fileTr2").hide();
      $("#timeTr,#fileTr1,#brand").hide();
      clearInfo();
      $('#next_step').val("查询");
      $("#intablediv").empty();
      $('#loginAccept').show();
    }
  }

//-->
</script>
</head>
<body>
  <form name="frm" method="post" action="fg982_upFile.jsp" ENCTYPE="multipart/form-data">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span><%=opName%></div>
		</div>
		<table cellspacing="0">
    	<tr> 
    		<td class="blue" width="20%">操作类型</td>
    		<td colspan="3">
    			<input type="radio" name="opFlag" value="one" checked onclick="operFlags(this)">新增&nbsp;&nbsp;
    			<input type="radio" name="opFlag" value="two" onclick="operFlags(this)">删除&nbsp;&nbsp;
    			<input type="radio" name="opFlag" value="search" onclick="operFlags(this)">条件查询&nbsp;&nbsp;
    			<input type="radio" name="opFlag" value="loginAcceptSearch" onclick="operFlags(this)">流水查询&nbsp;&nbsp;
    		</td>
    	</tr>
    	
    	<tr id="regionTr" style="display:none"> 
    		<td class="blue" width="20%">地市</td>
    		<td colspan="3">
    			<input type="text" name="region_code" id="region_code" value="" class="InputGrey" readonly />
    		</td>
    	</tr>
    	
		<tr id="brand"> 
			<td class="blue">手机品牌</td>
			<td> 
				<select id="phone_brand" name="phone_brand" onchange="changeBrand()">
				</select>
				<font color="orange">*</font>
			</td>
			<td class="blue">手机类型 </td>
			<td> 
				<select id="phone_type" name="phone_type">
				</select>
				<font color="orange">*</font>
			</td>
		</tr>  
		
		<tr id="timeTr">
		  <td class="blue">开始时间</td>
			<td width="39%">
				<input type="text" name="begin_time" id="begin_time" size="20" maxlength="8" v_must="1" value=""  onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd 00:00:00',readOnly:true,alwaysUseStartDate:true})">
				<font color="orange">*</font>
			</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text" name="end_time" id="end_time" size="20" maxlength="8" v_must="1" value="" onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd 23:59:59',readOnly:true,alwaysUseStartDate:true})">
				<font color="orange">*</font>
			</td>
		</tr>
	
      <tr id="fileTr1"> 
        <td class="blue">数据文件</td>
        <td width="30%" colspan="3"> 
          <input type="file" name="feefile">
          <font color="orange">*</font>
        </td>
      </tr>
      <tr id="fileTr2"> 
        <td colspan="4">说明：<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>。<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注意号码的正确性，否则会造成错误的目标用户录入</font>:<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机号码  回车<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13604511234 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13704511234 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13804511234 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13904511234 
        </td>
      </tr>
      
      <tr id="loginAccept" style="display: none;">
        <td class="blue">流水</td>  
        <td colspan="3"><input type="text" value="" name="loginAccept"/></td>  
      </tr>
      
    	<tr> 
    		<td colspan="4" align="center" id="footer"> 
    			<input class="b_foot" type=button name="next_step" id="next_step" value="确定" index="2" onclick="nextStep()">    
    			<input class="b_foot" type=button name="reset_btn" id="reset_btn" value="清除" onclick="clearInfo()"/>
    			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
    		</td>
    	</tr>
    	
		 </table>
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="remark" id="remark" value="">
			<div id="intablediv"></div>
		  <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
