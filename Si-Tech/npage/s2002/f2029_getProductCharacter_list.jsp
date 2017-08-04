<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%
		String opCode = "";
		String opName = "";
    //String workNo = (String)session.getAttribute("workNo");
    //String org_code = (String)session.getAttribute("orgCode");
    String workNo = request.getParameter("workNo");
    String org_code = request.getParameter("orgCode");
    String regionCode=org_code.substring(0,2);	
    String product_OperType	=request.getParameter("product_OperType");
    String p_OperType = request.getParameter("p_OperType");
    String dataConsult = request.getParameter("dataConsult");//wangzn 090927
    String prpValue = "".equals(request.getParameter("prpValue"))?"-1":request.getParameter("prpValue");//yuanqs add 2010/8/27 23:19:27 400改造需求
    String product_add_flag = WtcUtil.repNull((String)request.getParameter("product_add_flag"));
    int siMMSSumFlag = -1; //diling add for EC彩信基本接入号位置标识@2012/5/31
   // out.print("["+dataConsult+"]");
    
    System.out.println("###################### product_add_flag = "+product_add_flag);
    System.out.println("@@@@@@@@@@@@@@@@@@@@@@@product_OperType="+product_OperType);
     System.out.println("@@@@@@@@@@@@@@@@@@@@@@@p_OperType="+p_OperType);
     String typeFlag="one";/*diling add @2012/9/25 */
    
%>
<%
    /*
    SQL语句        sql_content
    选择类型       sel_type   
    标题           title      
    字段1名称      field_name1
    */        
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "M";                                           
    String sPOSpecNumber       = request.getParameter("sPOSpecNumber"      );//商品规格编号 
    String sPOOrderNumber      = request.getParameter("sPOOrderNumber"     );
    String sPOSpecRatePolicyID = request.getParameter("sPOSpecRatePolicyID");
    String sProductSpecNumber = request.getParameter("sProductSpecNumber");//产品规格编号
	String maxgroup = request.getParameter("maxgroup");
	String rowlength=request.getParameter("rowlength");
	int irowlength=Integer.parseInt(rowlength.trim());
       
    if (selType.compareTo("S") == 0) {
        selType = "radio";
    }
    if (selType.compareTo("M") == 0) {
        selType = "checkbox";
    }
    if (selType.compareTo("N") == 0) {
        selType = "";
    }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    
%>

<HEAD>
    <TITLE>产品属性选择
    </TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>

<SCRIPT type=text/javascript>
	//wangzn add 2011/12/14 14:12:53 增加一个根据字节数限制长度的函数 BEGIN
	function limitLength(value, byteLength, title, attribute) { 
		var newvalue = value.replace(/[^\x00-\xff]/g, "**"); 
		var length = newvalue.length; 

		//当填写的字节数小于设置的字节数 
		if (length * 1 <=byteLength * 1){ 
			return; 
		} 
		var limitDate = newvalue.substr(0, byteLength); 
		var count = 0; 
		var limitvalue = ""; 
		for (var i = 0; i < limitDate.length; i++) { 
	        var flat = limitDate.substr(i, 1); 
			if (flat == "*") { 
				count++; 
			} 
		} 
      	var size = 0; 
      	var istar = newvalue.substr(byteLength * 1 - 1, 1);//校验点是否为“×” 
   
      	//if 基点是×; 判断在基点内有×为偶数还是奇数 
      	if (count % 2 == 0) { 
	        //当为偶数时 
	        size = count / 2 + (byteLength * 1 - count); 
	        limitvalue = value.substr(0, size); 
      	} else { 
        	//当为奇数时 
	        size = (count - 1) / 2 + (byteLength * 1 - count); 
	        limitvalue = value.substr(0, size); 
      	}	 
	    alert(title + " 最大输入" + byteLength + "个字节（相当于"+byteLength /2+"个汉字）！"); 
	    //document.getElementById(attribute).value = limitvalue; 
	    attribute.val(limitvalue);
	    return false; 
    }
	//wangzn add 2011/12/14 14:12:53 增加一个根据字节数限制长度的函数 END
	//wangzn add 2011/12/14 9:39:49 针对行业手机报产品属性增加校验 BEGIN
	$(document).ready(function(){	//2011/11/10 wanghfa增加
		if(('<%=p_OperType%>'=='0'&&'<%=product_OperType%>'=='')||('<%=p_OperType%>'=='4'&&'<%=product_OperType%>'==''))
		{
			var defaultObj = document.getElementsByName("texCharacterSel910601001")[0];
				if(defaultObj!=undefined) {
			defaultObj.value = "451";
			defaultObj.disabled = true;
			getRinput(defaultObj, "910601001");
			defaultObj = document.getElementsByName("texCharacterSel910601009")[0];
			defaultObj.value = "02";
			defaultObj.disabled = true;
			getRinput(defaultObj, "910601009");
			//$("#texCharacterVal910601001").attr("readOnly", true);
			//$("#texCharacterVal910601001").val("451");
			//$("#List910601001").attr("checked", true);
			//$("#List910601001").attr("disabled", true);
			}
		}
			//不允许下发开始时间 格式如：113400（HHMMSS）
		$("input[@name='texCharacterVal1102241034']").each(function()
		{
			$(this).attr('v_type','time');
			
		});
		//不允许下发结束时间 格式如：113400（HHMMSS）
		$("input[@name='texCharacterVal1102241035']").each(function()
		{
			$(this).attr('v_type','time');
		});
		//集团客户短信接收手机号 11位手机号码，数字
		$("input[@name='texCharacterVal1102240003']").each(function()
		{
			$(this).attr('v_type','mobphone');
		});
		
		//与默认值相同，不能更改
		$("input[@name='texCharacterVal1102240006']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240010']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240019']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240020']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240041']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102240051']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241011']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241013']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241014']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241015']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241016']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241022']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241024']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102241026']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102242015']").each(function(){$(this).attr('readonly',true);});
		$("input[@name='texCharacterVal1102246105']").each(function(){$(this).attr('readonly',true);});
		
		//英文短信/彩信正文签名 填写英文签名，不超过16位
		$("input[@name='texCharacterVal1102240050']").each(function(){$(this).attr('maxlength','16');});
		
		//EC企业码 不填值或者填任意6位以内数字（系统会自动生成一个正确的企业码将其替代）
		$("input[@name='texCharacterVal1102241028']").each(function()
		{
			$(this).attr('maxlength','6');
			$(this).attr('v_type','0_9');
		});
		
		//每月下发的最大条数 9位以内纯数字
		$("input[@name='texCharacterVal1102241032']").each(function()
		{
			$(this).attr('maxlength','9');
			$(this).attr('v_type','int');
		});
		//每月下发的最大条数 9位以内纯数字
		$("input[@name='texCharacterVal1102241033']").each(function()
		{
			$(this).attr('maxlength','9');
			$(this).attr('v_type','int');
		});
		
		//中文短信/彩信正文签名 可以填中文或者英文字符，但总长不可超过8个字（每个英文字母算一个字）
		$("input[@name='texCharacterVal1102241031']").each(function()
		{
			$(this).attr('maxLength','8');
			//$(this).bind('keyup',function (){
			//	limitLength($(this).val(), 8, "中文短信/彩信正文签名", $(this));
			//});
		});
		//备注 100个字节以内，（一个汉字算两个字节）
		$("input[@name='texCharacterVal1102241036']").each(function()
		{
			//$(this).attr('v_maxlength','100');
			$(this).bind('keyup',function (){
				limitLength($(this).val(), 100, "备注", $(this));
			});
		});
	});
	//wangzn add 2011/12/14 9:39:49 针对行业手机报产品属性增加校验 END
	var v_phoneCheck = true;//yuanqs add 2011/5/23 8:45:36 
	function doUpload(retField){
    	document.fPubSimpSel.target="hidden_frame";
      document.fPubSimpSel.encoding="multipart/form-data";
      document.fPubSimpSel.action="f2029_uploadProductCharacter.jsp?retField="+retField;
      document.fPubSimpSel.method="post";
      document.fPubSimpSel.submit();
      loading();
    }
    function doUnLoading(){
      unLoading();
    }
	function preSaveTo()
	{ 	
	  	//wangzn 2010-3-23 14:39:35
	  	if (document.getElementsByName("List910601006")[0] != undefined 
	  		&& document.getElementsByName("List910601006")[0].checked == true 
	  		&& (!forMail(document.getElementsByName("texCharacterVal910601006")[0]))) {	//2011/11/10 wanghfa添加
	  		rdShowMessageDialog("集团客户联系人邮箱不是正确的邮箱！", 1);
	  		return false;
	  	}
	  	if (document.getElementsByName("List910601007")[0] != undefined && document.getElementsByName("List910601007")[0].checked == true) {	//2011/11/10 wanghfa添加
				document.getElementById("texCharacterVal910601007").v_type = "0_9";
				if (!checkElement(document.getElementById("texCharacterVal910601007"))) {
					return false;
				}
				var thePhoneNo = document.getElementById("texCharacterVal910601007").value;
				if (thePhoneNo.length != 11) {
					rdShowMessageDialog("集团客户联系人手机号码长度必须为11位！");
					return false;
				}
				var phoneHead = thePhoneNo.substr(0,3);
				var getdataPacket = new AJAXPacket("f2029_getProductCharacter_checkPhone.jsp","正在查询，请稍候......");
				getdataPacket.data.add("phoneHead",phoneHead);
				core.ajax.sendPacket(getdataPacket, checkPhoneHead);
				getdataPacket = null;
				if(!v_phoneCheck) {
					return false;
				}
	  	}
	  	if (document.getElementsByName("List910601008")[0] != undefined && document.getElementsByName("List910601008")[0].checked == true) {	//2011/11/10 wanghfa添加
				var val = document.getElementsByName("texCharacterVal910601008")[0].value;
				if (val.substring(0,2) != "1:") {
		  		rdShowMessageDialog("企业能力阀值格式错误！", 1);
		  		return false;
				}
				
				var patrn = /^-?\d+$/;
				if(val.substring(2).search(patrn)==-1){
					rdShowMessageDialog("企业能力阀值格式错误！", 1);
					return false;
				} else if (parseInt(val.substring(2)) <= 0) {
					rdShowMessageDialog("企业能力阀值格式错误！", 1);
					return false;
				}
	  	}
	  	/*
	  	if (document.getElementsByName("List910601007")[0] != undefined && document.getElementsByName("List910601007")[0].checked == true) {	//2011/11/10 wanghfa添加
	  		//rdShowMessageDialog("集团客户联系人邮箱不是正确的邮箱！", 1);
	  		return false;
	  	}*/
	  	      /*begin diling add for 是否校验了EC彩信基本接入号 @2012/5/31*/
      var siMMSSumFlagHidd = $("#siMMSSumFlagHidd").val();
      /*
      if((siMMSSumFlagHidd!=-1)&&(v_siMMSCheckFlag=="N")){
        rdShowMessageDialog("提交前，请先进行EC彩信基本接入号的校验！");
	  		return;
      }*/
      /*end diling add@2012/5/31*/
      /*关于申请制作集团客户信息化项目(产品)投资和收益自动化匹配报表的函
		* liangyl 2016-08-22
		* 10985
		*/
      if(undefined!=document.getElementsByName("texCharacterVal10985")[0]&&document.getElementById("List10985").checked==true) {
	  		  var tempValue = document.getElementsByName("texCharacterVal10985")[0].value; //项目编号
	  		  if(tempValue !=""){
	  			ajax_check_F10985();
		  			if(F10985_flag==0) {
	  					return;
		  			}
	  		 	}
	  	}
      
	  	//yuanqs add 2010/8/28 0:38:17 400改造需求 begin
	  	if(undefined!=document.getElementsByName("texCharacterVal4115017007")[0]&&undefined!=document.getElementsByName("texCharacterVal4115017001")[0]) {
	  		  var tempValue = document.getElementsByName("texCharacterVal4115017001")[0].value; //400号码的值
	  		  var tempValue1 = document.getElementsByName("texCharacterVal4115017007")[0].value; //预占单流水号
	  		  if(tempValue !="" && tempValue1 !="" ){
		  		  var tempValue_2 = 0;	//400号码拆分后相加的和
		  		  var tempValue_4 = 0;	//预占单流水号的前5位拆分后相加的喝
		  		  for(var i=0; i<tempValue.length; i++) {	//400号码拆分后相加
		  		  	tempValue_2 = tempValue_2 + parseInt(tempValue.substr(i, 1)); //400号码拆分后相加赋值给tempValue_2
		  		  }
		  			var tempValue_1 = document.getElementsByName("texCharacterVal4115017007")[0].value.substr(4, 1); //预占单流水号的第5位
		  			var tempValue_5 = document.getElementsByName("texCharacterVal4115017007")[0].value.substr(5, 1); //预占单流水号的第6位
		  			var tempValue_3 = document.getElementsByName("texCharacterVal4115017007")[0].value.substr(0, 5); //预占单流水号的前5位
		  			for(var i=0; i<tempValue_3.length; i++) {//预占单流水号的前5位拆分后相加
		  		  	tempValue_4 = tempValue_4 + parseInt(tempValue_3.substr(i, 1));//预占单流水号的前5位拆分后相加赋值给tempValue_4
		  		  }
		  			if(tempValue_1 != tempValue_2%10 || tempValue_5 != tempValue_4%10) {//第5位为400号码的校验位（400号码的10位数字之和的个位数），第6位为前5位数字的校验位（前5位数字之和的个位数）
		  					rdShowMessageDialog("预占单流水号不符合规则");
		  					return;
		  			}
	  		 	}
	  	}
	  	if(undefined!=document.getElementsByName("texCharacterVal4115017032")[0]) {
		  		var checkBoxList = document.getElementsByName("List");
		  		var checkedFlag = false;
		  		for(var i=0; i<checkBoxList.length; i++) {
			  		var rinputValue = document.getElementById("Rinput" + i + "0").value;
			  		if("4115017032" == rinputValue) {
			  				checkedFlag = document.getElementsByName("List")[i].checked;
			  		}
		  		}
	  			var prp = document.getElementsByName("texCharacterVal4115017032")[0].value;
	  			var i_prp = <%=prpValue%>;
	  			if(prp<i_prp&&-1!=i_prp&&checkedFlag) {
	  					rdShowMessageDialog("请先到平台删除号码，再做数量变更");
	  					//return;
	  			}
	  	} 
	  	
	  	//zhouby add   	1112084333, 1112054333, 1112064333 这三种属性值的业务，对附件格式有要求
	  	var fileTypes = {'JPG': true, 'BMP': true, 'JPEG': true, 'PNG': true, 'GIF': true, 'PDF': true,
	  	                  'jpg': true, 'bmp': true, 'jpeg': true, 'png': true, 'gif': true, 'pdf': true};
	  	var fileTypeChecker = {flag : false, code: ''};
	  	
	  	var $files = $('input[name="PosFile_1112054333"], input[name="PosFile_1112084333"], input[name="PosFile_1112064333"]');
	  	$files.each(function(i, e){
	  	    var v = $(this).val();
	  	    if (v == ''){
	  	        return false;
	  	    }
	  	    v = v.substr(v.lastIndexOf('.') + 1);
	  	    if (!fileTypes[v]){
	  	        fileTypeChecker.flag = true;
	  	        var n = $(e).attr('name');
  	          fileTypeChecker.code = n.substr(8);
	  	    }
	  	});
	  	
	  	if (fileTypeChecker.flag){
	  	    var m = "代码为" + fileTypeChecker.code + 
	  	            "的业务，附件的格式或者扩展名必须为如下所列格式之一：JPG、BMP、JPEG、PNG、GIF、PDF";
	  	    rdShowMessageDialog(m);
	  	    return;
	  	}
	
	  	//yuanqs add 2010/8/28 0:38:17 400改造需求 end
	  	document.fPubSimpSel.target="_self";
	    document.fPubSimpSel.encoding="application/x-www-form-urlencoded";
	    document.fPubSimpSel.method="post";
      document.fPubSimpSel.action="#";
	  	
	  	
	  	for (i = 0; i < document.fPubSimpSel.elements.length; i++)
      {
            if (document.fPubSimpSel.elements[i].type == "checkbox"&&document.fPubSimpSel.elements[i].checked)
            {    //判断是否是单选或复选框
                
                	var character_num = document.fPubSimpSel.elements[i].id.substring(4,document.fPubSimpSel.elements[i].id.length);
                
                  if(document.getElementsByName('texCharacterVal'+character_num)[0].type=="hidden"){
                  	doUpload('texCharacterVal'+character_num);
                  	return;
                  }
               
            }
      }
      //yuanqs add 2011/5/13 17:24:42 手机号码限制和邮箱限制
      	if(undefined!=document.getElementById("List9104010002")) {
			v_phoneCheck = true;
			if (document.getElementById("List9104010002").checked) {
				var thePhoneNo = document.getElementById("texCharacterVal9104010002").value;
				if (thePhoneNo.length != 11) {
					rdShowMessageDialog("手机号码长度必须为11位！");
					return false;
				}
				var phoneHead = thePhoneNo.substr(0,3);
				var getdataPacket = new AJAXPacket("f2029_getProductCharacter_checkPhone.jsp","正在查询，请稍候......");
				getdataPacket.data.add("phoneHead",phoneHead);
				core.ajax.sendPacket(getdataPacket, checkPhoneHead);
				getdataPacket = null;
				if(!v_phoneCheck) {
					return false;	
				}
			}
		}
      if(undefined!=document.getElementById("List9104010001")) {
			if (document.getElementById("List9104010001").checked) {
				var theEmail = document.getElementById("texCharacterVal9104010001");
				
				
				if(!forMail(theEmail)) return false;
				
				
				
			}
		}
      
      
      //wuxy add 20110525 移动电话会议需求属性校验
      
      	if(undefined!=document.getElementById("List9105010002")) {
			v_phoneCheck = true;
			if (document.getElementById("List9105010002").checked) {
				var thePhoneNo = document.getElementById("texCharacterVal9105010002").value;
				if (thePhoneNo.length != 11) {
					rdShowMessageDialog("手机号码长度必须为11位！");
					return false;
				}
				var phoneHead = thePhoneNo.substr(0,3);
				var getdataPacket = new AJAXPacket("f2029_getProductCharacter_checkPhone.jsp","正在查询，请稍候......");
				getdataPacket.data.add("phoneHead",phoneHead);
				core.ajax.sendPacket(getdataPacket, checkPhoneHead);
				getdataPacket = null;
				if(!v_phoneCheck) {
					return false;	
				}
			}
		}
		//wuxy add 20110525 移动电话会议需求属性校验
		if(undefined!=document.getElementById("List9105010001")) {
			if (document.getElementById("List9105010001").checked) {
				var theEmail = document.getElementById("texCharacterVal9105010001");
				if(!forMail(theEmail)) return false;
				
			}
		}
      	
	
		
	  	saveTo();
	  }
	
	/* yuanqs add 2011/5/20 15:30:08 增加查询手机号码号段的回调函数 */
	function checkPhoneHead(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var phoneHeadFlag = packet.data.findValueByName("phoneHeadFlag");
			if(retCode == "000000"){
				if (phoneHeadFlag == 0) {
					v_phoneCheck = false;
					rdShowMessageDialog("请填写移动号码！");
					return false;
				}
			}else{
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
		}
	
    function saveTo()
    {	
        var obj4115067011 = document.getElementsByName("texCharacterVal4115067011")[0];
        if(obj4115067011!=undefined){
        	var obj4115061009 = document.getElementsByName("texCharacterVal4115061009")[0];
        	var obj4115062009 = document.getElementsByName("texCharacterVal4115062009")[0];
        	if(obj4115061009!=undefined&&obj4115062009!=undefined){
        		obj4115061009.value = '10657'+obj4115067011.value;
        		obj4115062009.value = obj4115061009.value;
        	}       	
        }

        //add by wangleic 2011-3-31 04:52PM
        var obj4115097011 = document.getElementsByName("texCharacterVal4115097011")[0];
        if(obj4115097011!=undefined){
        	var obj4115091009 = document.getElementsByName("texCharacterVal4115091009")[0];
        	var obj4115092009 = document.getElementsByName("texCharacterVal4115092009")[0];
        	if(obj4115091009!=undefined&&obj4115092009!=undefined){
        		obj4115091009.value = '10657'+obj4115097011.value;
        		obj4115092009.value = obj4115091009.value;
        	}       	
        }

       	var unique_flags = document.getElementsByName("unique");
       	var sss='';
       	for(i = 0; i < unique_flags.length ;i++){ 
        	var ss =  unique_flags[i].id.substring(6,unique_flags[i].id.length);   
        	var l = document.getElementById('List'+ss);  
        	if(unique_flags[i].value!='Y'&&l.checked==true){
        		sss = '"'+unique_flags[i].cname+'"'; 		
        		break;
        	}
        	
        }

        var rIndex;        //选择框索引
        var retValue = ""; //返回值
        var chPos;         //字符位置
        var obj;
        var fieldNo;        //返回域序列号
        var retFieldNum = document.fPubSimpSel.retFieldNum.value;
        var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
        var retNum = retQuence.substring(0, retQuence.indexOf("|"));
	    	var flag = "1";
	    	var position = "";
	    	var charaNumValue="";//属性编码串，这里将所有选中的属性编码拼成此串做属性组的检查
       
        retQuence = retQuence.substring(retQuence.indexOf("|") + 1);
        var tempQuence;
        if (retFieldNum == "")
        {
            return false;
        }
       //返回单条记录
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
        	
            if (document.fPubSimpSel.elements[i].name == "List")
            {    //判断是否是单选或复选框
                if (document.fPubSimpSel.elements[i].checked == true)
                {     //判断是否被选中
                    rIndex = document.fPubSimpSel.elements[i].RIndex;
                    tempQuence = retQuence;
                    for (n = 0; n < retNum; n++)
                    {
                        chPos = tempQuence.indexOf("|");
                        fieldNo = tempQuence.substring(0, chPos);
        			            
                        obj = "Rinput" + rIndex + fieldNo;
                        //alert(document.all(obj).value);
        			    
                        retValue = retValue + document.all(obj).value + "|";
                        tempQuence = tempQuence.substring(chPos + 1);
                        if(document.all("Rinput"+rIndex+"3").value==""){
                        	// alert(document.all("Rinput"+rIndex+"0").mustUploadFlag+"----"+document.all("Rinput"+rIndex+"0").value);
                        	if(/*document.all("Rinput"+rIndex+"1").value!="业务扩展码"&&*/document.all("Rinput"+rIndex+"0").mustUploadFlag!="2"){
	                        	flag="0";
	                        	position="Rinput"+rIndex+"3";
	                       	}
                        }
                        if(fieldNo==0)
                        	charaNumValue = charaNumValue + document.all(obj).value + "^";
                    }
                    retValue = retValue + "^";
                    window.returnValue = retValue;
                }
            }
        }
        //alert("sss"+document.fPubSimpSel.elements.length);
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
        	var rIndex = document.fPubSimpSel.elements[i].RIndex;
        	var obj11 = "Rinput" + rIndex + "4";
        	var obj112 = "Rinput" + rIndex + "5";
        	 //alert(document.all(obj112).value);
        	if (document.fPubSimpSel.elements[i].name == "List")
            {
            	//alert("ss"+document.all.product_OperType.value.trim());
            	if(document.all.product_OperType.value.trim()!="9|")
            	{
            		//wuxy add 20090908 解决多个属性组添加问题，再次添加，不必判断属性必填
            	  //alert(document.all.maxGroup11.value);
            	  
            	if( document.all.maxGroup11.value<=0)
             {
            	if((document.fPubSimpSel.elements[i].checked == false)&&(document.all(obj112).value=="必填"))
            	{
	                rdShowMessageDialog("请选择必填的属性", 0);
					        return false;              		
            	}
             }
                
              }
	            if((document.fPubSimpSel.elements[i].checked == true)&&(document.all(obj11).value!="0"))
	            {
					    for (j = 0; j < document.fPubSimpSel.elements.length; j++)
	        			{
	        				if (document.fPubSimpSel.elements[j].name == "List")
            				{
            					var rIndex = document.fPubSimpSel.elements[j].RIndex;
		        				var obj1 = "Rinput" + rIndex + "4";
		            			if ((document.fPubSimpSel.elements[j].checked == false)&&(document.all(obj11).value==document.all(obj1).value))
		            			{
					            	group_flag=document.all(obj1).value;
					                rdShowMessageDialog("请选择属性归属组为"+group_flag+"的属性", 0);
           							return false;   
					            	break;            				
		            			}
		            		}
	            		}
	
	            }
	           	
        	}
        }
        //alert(charaNumValue);
        //调用函数进行属性配对出现的限制
        if (retValue == "")
        {
            rdShowMessageDialog("请选择信息项！", 0);
            return false;
        }
        if (flag=="0"){
        	rdShowMessageDialog("请填写产品属性值["+document.all(position).name.substring(15)+"]！！！", 0);
        	//document.all(position).focus();
        	return false;
        }
        //opener.document.all.cust_name.className = "InputGrey";
        
    	 //liujian 2012-8-22 11:08:25 添加对日期的校验，如果result[i][11]=1，则只能是yyyy-MM-dd或yyyy/MM/dd begin 
    	 var typeFlagHidd = $("#typeFlagHidd").val();
  	 	 var _allDateOk = true;
  	 	 if(typeFlagHidd=="two"){
        $('.judge_data_type').each(function() {
          var _this = $(this);
          if(_this.parent().parent().find('input[@type=checkbox]:checked').attr("id")) {
            var myregex = new RegExp(/^\d{4}[\/\-]\d{2}[\/\-]\d{2}$/);   // 创建正则表达式
            if ($.trim(_this.val()).length !=0 && !myregex.test(_this.val())){	
            	rdShowMessageDialog("日期格式错误，只能是yyyy-MM-dd或yyyy/MM/dd！");
            	_this.focus();
            	_allDateOk = false;
            	return false;
            }
          }
        });
        if(!_allDateOk) {
          return false;	
        }
  	 	 }
	  	 //liujian 2012-8-22 11:08:25 添加对日期的校验，如果result[i][11]=1，则只能是yyyy-MM-dd或yyyy/MM/dd end 
        
        
     		var ecLongServiceCode = document.getElementsByName('texCharacterVal1102222009')[0];
     		var ecShortBaseCode = document.getElementsByName('texCharacterVal1102221009')[0];
     		
     		if(ecLongServiceCode!=null&&ecShortBaseCode!=null){
     			
     			//alert(ecLongServiceCode.value.substring(0,11));
     			if(!(ecLongServiceCode.value==ecShortBaseCode.value&&ecLongServiceCode.value.substring(0,11)=='12582999928')){
     				rdShowMessageDialog("EC长服务代码和EC短信基本接入号必须相同，并且以12582999928开头！", 0);
     				return false;
     			}
     			
     		}
     		
		var ecLongServiceCode2 = document.getElementsByName('texCharacterVal4115061009')[0];
		var ecShortBaseCode2 = document.getElementsByName('texCharacterVal4115062009')[0];
		
		if(ecLongServiceCode2!=null&&ecShortBaseCode2!=null)
		{
			//wangzn add 2010-8-19 11:21:34
			var ecLongServiceCode2L = document.getElementsByName('List4115061009')[0];
			var ecShortBaseCode2L = document.getElementsByName('List4115062009')[0]; 
			if(ecLongServiceCode2L.checked||ecShortBaseCode2L.checked)
			{
				if(!(ecLongServiceCode2.value==ecShortBaseCode2.value
				&&ecLongServiceCode2.value.substring(0,9)=='106574001'
				&&ecLongServiceCode2.value.length>=15))
				{
					rdShowMessageDialog("EC长服务代码和EC短信基本接入号必须相同，并且以106574001开头,长度为15位！", 0);
					return false;
				}	
			}
		}
     		
		//add by wangleic 2011-3-31 04:55PM
		var ecLongServiceCode2 = document.getElementsByName('texCharacterVal4115091009')[0];
		var ecShortBaseCode2 = document.getElementsByName('texCharacterVal4115092009')[0];
		
		if(ecLongServiceCode2!=null&&ecShortBaseCode2!=null)
		{
			var ecLongServiceCode2L = document.getElementsByName('List4115091009')[0];
			var ecShortBaseCode2L = document.getElementsByName('List4115092009')[0]; 
			if(ecLongServiceCode2L.checked||ecShortBaseCode2L.checked)
			{
				if(!(ecLongServiceCode2.value==ecShortBaseCode2.value
					&&ecLongServiceCode2.value.substring(0,9)=='106574001'
					&&ecLongServiceCode2.value.length>=15))
				{
					rdShowMessageDialog("EC长服务代码和EC短信基本接入号必须相同，并且以106574001开头,长度至少为15位！", 0);
					return false;
				}	
			} 			
		}
		
		/*一卡通业务普通短信	247011009	EC短信基本接入号	106572000*/
		if ( document.getElementsByName('texCharacterVal247011009')[0]!=null )
		{
			if ( document.getElementsByName('List247011009')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247011009')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247011009')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC短信基本接入号必须以 106572000 开头,长度至少为16位！", 0);
					return false;
				}
			}
		}
		
		
		/*一卡通业务普通短信	247012009	EC长服务代码	106572000*/
		if ( document.getElementsByName('texCharacterVal247012009')[0]!=null )
		{
			if ( document.getElementsByName('List247012009')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247012009')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247012009')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC长服务代码 必须以 106572000 开头,长度至少为16位！", 0);
					return false;
				}
			}
		}		
		
		
		/*一卡通业务普通彩信	247021009	EC短信基本接入号	106572000	16       */
		if ( document.getElementsByName('texCharacterVal247021009')[0]!=null )
		{
			if ( document.getElementsByName('List247021009')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247021009')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247021009')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC短信基本接入号 必须以 106572000 开头,长度至少为16位！", 0);
					return false;
				}
			}
		}	
				
		/*一卡通业务普通彩信	247021019	EC彩信基本接入号	106572000	16       */
		if ( document.getElementsByName('texCharacterVal247021019')[0]!=null )
		{
			if ( document.getElementsByName('List247021019')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247021019')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247021019')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC彩信基本接入号 必须以 106572000 开头,长度至少为16位！", 0);
					return false;
				}
			}
		}			
		
		/*一卡通业务普通彩信	247022019	EC长服务代码	106572000	16           */
		if ( document.getElementsByName('texCharacterVal247022019')[0]!=null )
		{
			if ( document.getElementsByName('List247022019')[0]!=null )
			{
				if (!( document.getElementsByName('texCharacterVal247022019')[0].value.substring(0,9)=='106572000' 
					&& document.getElementsByName('texCharacterVal247022019')[0].value.length >=16 ))
				{
					rdShowMessageDialog("EC长服务代码 必须以 106572000 开头,长度至少为16位！", 0);
					return false;
				}
			}
		}	

		/*行业手机报	1102241009	EC短信基本接入号	1065022	14                   */
		if ( document.getElementsByName('texCharacterVal1102241009')[0]!=null )
		{
			if ( document.getElementsByName('List1102241009')[0]!=null )
			{
				if ( ""!=document.getElementsByName('texCharacterVal1102241009')[0].value.trim() )
				{
					if (!( document.getElementsByName('texCharacterVal1102241009')[0].value.substring(0,7)=='1065022' 
						&& document.getElementsByName('texCharacterVal1102241009')[0].value.length >=14 ))
					{
						rdShowMessageDialog("EC短信基本接入号 必须以 1065022 开头,长度至少为14位！", 0);
						return false;
					}							
				}

			}
		}			

		/*行业手机报	1102241019	EC彩信基本接入号	1065022	14                   */
		if ( document.getElementsByName('texCharacterVal1102241019')[0]!=null )
		{
			if ( document.getElementsByName('List1102241019')[0]!=null )
			{
				if (""!=document.getElementsByName('texCharacterVal1102241019')[0].value.trim())
				{
					if (!( document.getElementsByName('texCharacterVal1102241019')[0].value.substring(0,7)=='1065022' 
						&& document.getElementsByName('texCharacterVal1102241019')[0].value.length >=14 ))
					{
						rdShowMessageDialog("EC彩信基本接入号 必须以 1065022 开头,长度至少为14位！", 0);
						return false;
					}					
				}

			}
		}	

		/*行业手机报	1102242019	EC长服务代码	1065022	14                       */
		if ( document.getElementsByName('texCharacterVal1102242019')[0]!=null )
		{
			if ( document.getElementsByName('List1102242019')[0]!=null )
			{
				if ( ""!=document.getElementsByName('texCharacterVal1102242019')[0].value )
				{
					if (!( document.getElementsByName('texCharacterVal1102242019')[0].value.substring(0,7)=='1065022' 
						&& document.getElementsByName('texCharacterVal1102242019')[0].value.length >=14 ))
					{
						rdShowMessageDialog("EC长服务代码 必须以 1065022 开头,长度至少为14位！", 0);
						return false;
					}					
				}

			}
		}			

 		var ecEnglishSign = document.getElementsByName('texCharacterVal4115090050')[0];
 		if(ecEnglishSign!=null){
 			if(ecEnglishSign.value!=''){
     			var patrn = /^[A-Za-z]+$/;
     			var patrn1 = /^[A-Za-z0-9]+$/;
     			if(ecEnglishSign.value.length<17)
     			{
     				if(ecEnglishSign.value.search(patrn)==-1
     					&&ecEnglishSign.value.search(patrn1)==-1){
	     				rdShowMessageDialog("英文短信/彩信正文签名支持纯英文或英文、数字混合使用！", 0);
	     				return false;
     				}
     			}else{
     				rdShowMessageDialog("英文短信/彩信正文签名长度不超过16位！", 0);
	     			return false;
     			}
 			}
 		}

     		var ecECCode = document.getElementsByName('texCharacterVal4115091028')[0];
     		if(ecECCode!=null){
     			if(ecECCode.value!=''){
	     			var patrn2 = /^-?\d+$/;
	     			if(ecECCode.value.length<7){
	     				if(ecECCode.value.search(patrn2)==-1){
		     				rdShowMessageDialog("EC企业码只能填写数字！", 0);
		     				return false;
	     				}
	     			}else{
	     				rdShowMessageDialog("EC企业码长度不超过6位！", 0);
		     			return false;
	     			}
     			}	
     		}

     		var ecChineseSign = document.getElementsByName('texCharacterVal4115091031')[0];
     		if(ecChineseSign!=null){
     			if(ecChineseSign.value!=''){
	     			var patrn3 = /^[A-Za-z]+$/;
	     			var patrn4 = /^[\u4e00-\u9fa5]+$/;
	     			var patrn5 = /^[A-Za-z\u4e00-\u9fa5]+$/;
	     			if(ecChineseSign.value.length<9){
	     				if(ecChineseSign.value.search(patrn3)==-1&&ecChineseSign.value.search(patrn4)==-1&&ecChineseSign.value.search(patrn5)==-1){
		     				rdShowMessageDialog("中文短信/彩信正文签名支持中文或英文字符！", 0);
		     				return false;
	     				}
	     			}else{
	     				rdShowMessageDialog("中文短信/彩信正文签名长度不超过8位！", 0);
		     			return false;
	     			}
     			}
     		}

        //验证格式wangzn 2010-4-12 16:21:50
    	  if(!check(fPubSimpSel)) return false;

    	  var begTime = '';
    	  var endTime = '';
    	  var Rinput331011009 = '';
    	  var Rinput331012009 = '';
    	 
    	  for(var i=0;i<fPubSimpSel.elements.length;i++){
	      	var flag = false;
	      	var obj = fPubSimpSel.elements[i];
	      	if((obj.type=="text"||obj.type=="textarea")&&obj.disabled!=true&&obj.readOnly!=true){
	      		//挂机短信时间验证 wangleic add 2011-4-7 02:23PM
	      		if(obj.name=='texCharacterVal4115091034'){
	      			begTime = obj.value;
	      		}
	      		if(obj.name=='texCharacterVal4115091035'){
	      			endTime = obj.value;
	      		}
	      		if(obj.name=='texCharacterVal331011009'){
	      			Rinput331011009 = obj.value;
	      		}
	      		if(obj.name=='texCharacterVal331012009'){
	      			Rinput331012009 = obj.value;
	      		}
	      		
	      	}
	      }

	      //var dBegin=getDateFromFormat(begTime,"HHmm");
	      //var dEnd=getDateFromFormat(endTime,"HHmm");
	      if(begTime>endTime){
	      	rdShowMessageDialog("开始时间时间不能晚于结束时间！", 0);
	      	return false;
	      }
	      if(Rinput331011009!=''&&Rinput331012009!=''){
     			if(!(Rinput331011009==Rinput331012009&&Rinput331011009.substring(0,11)=='12582999928'&&Rinput331011009.length==16)){
     				rdShowMessageDialog("EC短信基本接入号和EC长服务代码必须相同，并且格式12582999928ABCDE！", 0);
     				return false;
     			}
     			
     		}

    	//  alert(unique_flags.length);
        if(sss!=''){
        	rdShowMessageDialog(sss+"未校验！", 0);
        	return false;
        }

        opener.getProductOrderCharacterRtn(retValue);
        window.close();
    }

    function allChoose()
    {   //复选框全部选中
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //判断是否是单选或复选框
                document.fPubSimpSel.elements[i].checked = true;
            }
        }
    }

    function cancelChoose()
    {   //取消复选框全部选中
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //判断是否是单选或复选框
                document.fPubSimpSel.elements[i].checked = false;
            }
        }
    }
	function chegroup(){
		//var product_id = event.srcElement.parentNode.innerText);
		//var chebox = event.srcElement;
		//if(chebox.checked)
	}
	function checkUnique(uniqueProCharacterNum){
		
		
		var character_value = document.getElementsByName("texCharacterVal"+uniqueProCharacterNum)[0].value;
		var vsPOSpecNumber= document.fPubSimpSel.sPOSpecNumber.value;
	//	alert(uniqueProCharacterNum + "----"+character_value);
		
	//wuxy alter 20091217 添加商品规格编码
		
		var myPacket = new AJAXPacket("f2029_checkUniqueCharacter.jsp","数据校验中......");	
		myPacket.data.add("character_number",uniqueProCharacterNum);
		myPacket.data.add("character_value",character_value);
		myPacket.data.add("sPOSpecNumber",vsPOSpecNumber);
	  myPacket.data.add("verifyType","checkUnique");
	  core.ajax.sendPacket(myPacket);	
	  myPacket=null;				  

	}
	/*begin diling add for 校验EC彩信基本接入号 @2012/5/31*/
	function checkSiMMSInfo(vSiMMSInfo){
	  var myPacket = new AJAXPacket("f2029_ajax_checkSiMMSInfo.jsp","数据校验中......");	
		myPacket.data.add("vSiMMSInfo",vSiMMSInfo);
	  core.ajax.sendPacket(myPacket,doCheckSiMMSInfo);	
	  myPacket=null;		
	}
	
	var v_siMMSCheckFlag = "N";
	function doCheckSiMMSInfo(packet){
	  var retCode = packet.data.findValueByName("retcode");
		var retMsg  = packet.data.findValueByName("retmsg");
		//var siMMSCheckFlag  = packet.data.findValueByName("siMMSCheckFlag");
		if(retCode!="000000"){
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      v_siMMSCheckFlag = "N";
      return;
    }else{
      rdShowMessageDialog("校验成功！",2);
      v_siMMSCheckFlag = "Y";
      return;
    }
	}
	/*end diling add @2012/5/31*/
	
	function doProcess(packet){
		
		error_code = packet.data.findValueByName("errorCode");
		error_msg  = packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var uniqueProCharacterNum = packet.data.findValueByName("inputCharacter_number");
		self.status="";
		if(verifyType=="checkUnique"){
			if(backArrMsg=="0"){
					document.getElementById("unique"+uniqueProCharacterNum).value='Y';
			}else{
					rdShowMessageDialog("该值已经存在！", 0);
			}
			//alert("["+backArrMsg+"]["+error_code+"]["+error_msg+"]");
		}
	}
	function changeUniqueFlag(ProCharacterNum){
		var cUniqueFlag = document.getElementById('unique'+ProCharacterNum);
		//alert(cUniqueFlag);
		if(cUniqueFlag!=null){
			cUniqueFlag.value='N'  ;
		}
		//document.getElementById('unique'+ProCharacterNum).value='N' 
		
	}
	//wangzn 090927
	function showConsult(){
		//window.open("f2029_showConsultPage.jsp?dataConsult=<%=dataConsult%>","","toolbar = 0");
		opener.showConsult('<%=dataConsult%>');
	}
	//wangzn 2010-4-15 16:59:20
	function getRinput(obj,characterNo){
	  var val = obj.options[obj.selectedIndex].value;   
	  var ipt = 'Rinput'+obj.id.substring(9); 
	  document.getElementById(ipt).value=val;
	  if('4115057026'==characterNo){
	    document.getElementById('List4115057017').disabled=true;
	    document.getElementById('List4115057018').disabled=true;
	    document.getElementById('List4115057019').disabled=true;
	                                             
	    document.getElementById('List4115057021').disabled=true;
	    document.getElementById('List4115057022').disabled=true;
	    document.getElementById('List4115057023').disabled=true;
	                                             
	    document.getElementById('List4115057024').disabled=true;
	    document.getElementById('List4115057025').disabled=true;
	  
	  
	    if(val=='1'){
	        document.getElementById('List4115057017').checked=true;
	        document.getElementById('List4115057018').checked=true;
	        document.getElementById('List4115057019').checked=true;
	        
	        document.getElementById('List4115057021').checked=false;
	        document.getElementById('List4115057022').checked=false;
	        document.getElementById('List4115057023').checked=false;
	        
	        document.getElementById('List4115057024').checked=false;
	        document.getElementById('List4115057025').checked=false;
	        	        
	    }else if(val=='2'){
	        document.getElementById('List4115057017').checked=false;
	        document.getElementById('List4115057018').checked=false;
	        document.getElementById('List4115057019').checked=false;
	        
	        document.getElementById('List4115057021').checked=true;
	        document.getElementById('List4115057022').checked=true;
	        document.getElementById('List4115057023').checked=true;
	        
	        document.getElementById('List4115057024').checked=false;
	        document.getElementById('List4115057025').checked=false;
	    
	    }else if(val=='3'){
	        document.getElementById('List4115057017').checked=false;
	        document.getElementById('List4115057018').checked=false;
	        document.getElementById('List4115057019').checked=false;
	        
	        document.getElementById('List4115057021').checked=false;
	        document.getElementById('List4115057022').checked=false;
	        document.getElementById('List4115057023').checked=false;
	        
	        document.getElementById('List4115057024').checked=true;
	        document.getElementById('List4115057025').checked=true;
	    
	    }
	  }
	}
	
	/*关于申请制作集团客户信息化项目(产品)投资和收益自动化匹配报表的函
	* liangyl 2016-08-22
	* 10985
	*/
	var F10985_flag=0;
	function ajax_check_F10985(){
		F10985_flag=0;
		if(document.getElementsByName("texCharacterVal10985")[0].value==""){
			F10985_flag=1;
		}
		else{
			var packet = new AJAXPacket("../se743/ajax_check_F10985.jsp","请稍后...");
	        packet.data.add("F10985_val",document.getElementsByName("texCharacterVal10985")[0].value);//
	    	core.ajax.sendPacket(packet,do_ajax_check_F10985);
	   	 	packet =null;	
		}
	}

	function do_ajax_check_F10985(packet){
	    var error_code = packet.data.findValueByName("code");//返回代码
	    var error_msg =  packet.data.findValueByName("msg");//返回信息
	    if(error_code=="000000"){//操作成功
	    	var result_count =  packet.data.findValueByName("result_count");
	    	if(result_count=="0"){
	    		rdShowMessageDialog("输入的项目编号错误请核对后重新输入!");
	    	}
	    	else{
	    		F10985_flag=1;
	    	}
	    }else{//调用服务失败
		    rdShowMessageDialog(error_code+":"+error_msg);
	    }
	}
</SCRIPT>
<FORM method=post name="fPubSimpSel">
	<input name="sPOSpecNumber" id="sPOSpecNumber" type="hidden" value='<%=sPOSpecNumber%>'>
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">产品属性选择</div></div>	

<table cellspacing="0" style="table-layout:fix">
    <tr align="center">
        <th>产品属性代码</th>
        <th>产品属性名</th>      
        <th>枚举值</th>
        <th>产品属性值</th>   
        <th>属性归属组</th>
        <th>是否必填</th>   
    </TR>
    <% //绘制界面表头
        chPos = fieldName.indexOf("|");
        out.print("");
        String titleStr = "";
        int tempNum = 0;
        while (chPos != -1) {
            valueStr = fieldName.substring(0, chPos);
            titleStr = "";
            out.print(titleStr);
            fieldName = fieldName.substring(chPos + 1);
            tempNum = tempNum + 1;
            chPos = fieldName.indexOf("|");
        }
        out.print("");
    %>
    

<wtc:service name="s9100DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="9"/>
		<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<!-- yuanqs add 2010/8/27 23:47:01 400改造需求 begin -->
<input type="hidden" id="prpValue" name="prpValue" />
<!-- yuanqs add 2010/8/27 23:47:01 400改造需求 end -->

    <%
            String tbclass="";
            String v_maxlength = "maxlength=\"256\"";//wuxy alter 20110527接口规范升级限制最大长度256
            for (int i = 0; i < result.length; i++) {
            	System.out.println("zhouby>>>>result["+i+"][0]=="+result[i][0]+"---");
		        System.out.println("zhouby>>>>result["+i+"][1]=="+result[i][1]+"---");
		        System.out.println("zhouby>>>>result["+i+"][2]=="+result[i][2]+"---");
		        System.out.println("zhouby>>>>result["+i+"][3]=="+result[i][3]+"---");
		        System.out.println("zhouby>>>>result["+i+"][4]=="+result[i][4]+"---");
		        System.out.println("zhouby>>>>result["+i+"][5]=="+result[i][5]+"---");
		        System.out.println("zhouby>>>>result["+i+"][6]=="+result[i][6]+"---");
		        System.out.println("zhouby>>>>result["+i+"][7]=="+result[i][7]+"---");
		        System.out.println("zhouby>>>>result["+i+"][8]=="+result[i][8]+"---");
		        System.out.println("zhouby>>>>result["+i+"][9]=="+result[i][9]+"---");
		        System.out.println("zhouby>>>>result["+i+"][10]=="+result[i][10]+"---");
		        System.out.println("zhouby>>>>result["+i+"][11]=="+result[i][11]+"<br>");
            	String dis_flag="";
            	//wuxy alter 20090923 启用配置功能
            	//if((product_OperType.indexOf("9")!=-1)&&(result[i][1].equals("4115057017")||result[i][1].equals("4115011201")||result[i][1].equals("4115061201")||result[i][1].equals("4115057023")||result[i][1].equals("4115057021")))
            	if((product_OperType.indexOf("9")!=-1)&&"1".equals(result[i][6]))	
            		dis_flag="disabled";
            		
            	//wangzn 090913
            	if("4".equals(p_OperType)&&"1".equals(result[i][6])){
            		dis_flag="disabled";
            	}
            	tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < 6; j++) {
                String disflag="";
                String chkflag="";
                String isFile = "";
                //wuxy alter 20090911 支持商品修改中新增产品
                if(p_OperType.equals("0")||(product_OperType.trim().equals("")&&p_OperType.equals("4"))){
	                /* if(result[i][2].equals("业务扩展码")){
	                    	disflag="disabled";
	                    	chkflag="checked";
	                 }*/ //wangzn 090916
	                 if("2".equals(result[i][5])){
            		     disflag="disabled";
            		     chkflag="checked";
            	     }
                 }
                 
                 String checkBoxLabel = "";
                 if(irowlength==0&&(p_OperType.equals("0")||p_OperType.equals("4")&&product_add_flag.equals("1"))&&(result[i][5]).trim().equals("1")){
                    checkBoxLabel = " checked disabled ";
                 }
                
                 System.out.println("rendi test result["+i+"]["+j+"]="+result[i][j]);
                    if (j == 0) {
                    System.out.println("result["+i+"]["+j+"]="+result[i][j]);
                    //System.out.println("---------------diling-------------result["+i+"]["+j+"]="+result[i][j]);
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input onclick='chegroup();'  id='List"+(result[i][1]).trim()+"'     type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" +dis_flag+ "  "+chkflag+" "+disflag+" "+checkBoxLabel+">";
                        }
                        typeStr = typeStr +(result[i][1]).trim()+"<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][1]).trim() + "'  mustUploadFlag='"+(result[i][5]).trim()+"'           readonly></TD>";
                    }else if ( j == 1){  
                    	if("1102241019".equals(result[i][j])){
                        siMMSSumFlag = i ;                        
                      }
                      System.out.println("---------------2029-------------siMMSSumFlag="+siMMSSumFlag);   
                        inputStr = inputStr + "<TD class='"+tbclass+"'>" + (result[i][2]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" + (result[i][2]).trim() + "'  readonly></TD>";
                    }else if ( j == 2){
                        inputStr = inputStr + "<TD class='"+tbclass+"'><div style='word-break:break-all;'>"+(result[i][3]).trim() +"</div><input type='hidden' " +" id='Rinput" + i + j + "' value='" + (result[i][3]).trim() + "'readonly>&nbsp;</TD>";
                    }else if ( j == 3){
                    	  // wangzn 2010-4-23 17:06:41
                    	  if("1".equals(result[i][10])){
                    	     inputStr = inputStr + "<TD class='"+tbclass+"' align=left>"
                    	     +"<input type='hidden'  id='Rinput" + i + j + "'  name='texCharacterVal"+result[i][1]+"'      value='"+result[i][9]+"'    onPropertyChange=changeUniqueFlag('"+result[i][1]+"') "+disflag+">"
                    	     +"    	<input type=\"file\" name=\"PosFile_"+result[i][1]+"\" id=\"PosFile\" class=\"button\" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />";
                    	     inputStr = inputStr + "</TD>";
                    	     continue;
                    	  }
                    	
                    	  //wangzn 2010-4-15 10:11:51
                    	  String inputType = "text";
                    	  if(!"".equals((result[i][3]).trim())&&(result[i][3].trim().split(",").length>1)){
                    	     inputType = "hidden";
                    	  }
                    	  String defVal = result[i][9];
                    	  
                        if("331011010".equals(result[i][1])||"4115061010".equals(result[i][1])){
                           Date    date = new Date();
                           SimpleDateFormat df  = new SimpleDateFormat("yyyy/MM/dd");
                           GregorianCalendar gc = new GregorianCalendar();
                           gc.setTime(date); 
                           String  time=df.format(gc.getTime());
                           defVal = time;
                        }
                        
                        if("4115061031".equals(result[i][1])){
                            v_maxlength = "maxlength=\"8\"";
                        }
                    	
                    	//wangzn 2010-4-12 13:41:48
                    	  String v_type = "";
                    	  if("331011034".equals(result[i][1])||"4115061034".equals(result[i][1])||"4115091034".equals(result[i][1])||"4115091035".equals(result[i][1])){
                    	  	v_type = "v_type=time";//HHMISS
                    	  }
                    	  if("331010004".equals(result[i][1])||"331011010".equals(result[i][1])||"4115017020".equals(result[i][1])||"4115027020".equals(result[i][1])||"4115037020".equals(result[i][1])||"4115047020".equals(result[i][1])||"4115057020".equals(result[i][1])||"4115061038".equals(result[i][1])||"4115060004".equals(result[i][1])||"4115061010".equals(result[i][1])){
                    	  	v_type = "v_type=date2";//YYYY/MM/DD
                    	  }
                    	  if("4115057018".equals(result[i][1])){
                    	  	v_type = "v_type=time2";//HHMM
                    	  }
                    	  //System.out.println("---liujian---" + i + "-----result["+i+"][11]="+result[i][11]);
                    	  //liujian 2012-8-22 11:08:25 添加对日期的校验，如果result[i][11]=1，则只能是yyyy-MM-dd或yyyy/MM/dd
                    	  if(result[i][11] != null && result[i][11].equals("1")) {
                    	      //System.out.println("---liujian---" + i + "------result["+i+"][11]="+result[i][11]);
                    	      v_type = "";
                    	      typeFlag = "two";
                    	  		inputStr = inputStr + "<TD class='"+tbclass+"' align=left><input type='"+inputType+"' " +
                                " id='Rinput" + i + j + "'  name='texCharacterVal"+result[i][1]+"'    class='judge_data_type'  value='"+defVal+"'    onPropertyChange=changeUniqueFlag('"+result[i][1]+"') "+disflag+" "+v_type+" "+v_maxlength+" >";
	                           System.out.println("---liujian--11111-----v_type="+v_type);
	                           System.out.println("---liujian-d--11111-----typeFlag="+typeFlag );
	                      }else {
	                         typeFlag = "one";
	                         //System.out.println("---liujian---2222222-----v_type="+v_type);
	                    		inputStr = inputStr + "<TD class='"+tbclass+"' align=left><input type='"+inputType+"' " +
                                " id='Rinput" + i + j + "'  name='texCharacterVal"+result[i][1]+"'      value='"+defVal+"'    onPropertyChange=changeUniqueFlag('"+result[i][1]+"') "+disflag+" "+v_type+" "+v_maxlength+" >";
	                      }
                        
                        //wangzn 2010-4-15 10:11:42
                        if(!"".equals((result[i][3]).trim())&&(result[i][3].trim().split(",").length>1)){
                          String[] selDatas = result[i][3].trim().split(",");
                          inputStr = inputStr +"<select style='width:150px;' id='RinputSel"+i+j+"' name=texCharacterSel"+result[i][1]+" onchange='getRinput(this,\""+result[i][1]+"\")' >";
                          inputStr = inputStr + "<option value=''>...请选择...</options>";
                          for(int ij = 0;ij<selDatas.length;ij++){
                           inputStr = inputStr + "<option value='"+selDatas[ij]+"'>"+selDatas[ij]+"</options>";
                          }
                          inputStr = inputStr + "</select>";
                        }
                        if("1".equals(result[i][7])){
                        	inputStr = inputStr + "&nbsp<input class=b_text type=button value=校验 onClick=checkUnique('"+result[i][1]+"');><input type=hidden id=unique"+result[i][1]+" name=unique value='N' cname="+result[i][2]+"  >";
                        }
                        /*begin diling add for 若是EC彩信基本接入号，则增加校验按钮*/
                        if(i==siMMSSumFlag){
                          inputStr = inputStr + "&nbsp<input class=b_text type=button value=校验 onClick=checkSiMMSInfo(document.getElementById('Rinput" + i + j + "').value);><input type=hidden id=siMMSInfo"+result[i][1]+" name='siMMSInfo' value='N' cname="+result[i][2]+"  >";
                        }
                        System.out.println("---------------2029-------------siMMSSumFlag="+siMMSSumFlag);
                         /*end diling add @2012/5/31*/
                        inputStr = inputStr + "</TD>";
                    }
                    else if ( j == 4){
                    	String charaterGroup = "";
                    	if((result[i][4]).trim().equals("0"))
                    	{
                    		charaterGroup="0";
                    		
                    	}else if(result[i][4].equals("")){
                    		charaterGroup = result[i][4];
                    	}else if((maxgroup.trim()).equals("")){
                    		charaterGroup = result[i][4];
                    	}
                    	else{
                    		charaterGroup =String.valueOf(Integer.parseInt(result[i][4].trim())+Integer.parseInt(maxgroup.trim()));
                    	}
                        inputStr = inputStr +"<TD class='"+tbclass+"'><input type='hidden' class='InputGrey' readonly  id='Rinput" + i + j + "' value='" + charaterGroup + "'>"+charaterGroup+"</TD>";
                    }else if ( j ==5){
                    	String tempResult = "";
                    	if((result[i][5]).trim().equals("0")){
                    		tempResult="非必填";
                    	}else if((result[i][5]).trim().equals("1")){
                    		tempResult="必填";
                    	}else if((result[i][5]).trim().equals("2")){
                    		tempResult="必空";
                    	}else if((result[i][5]).trim().equals("3")){
                    		tempResult="不传";
                    	}
                        inputStr = inputStr + "<TD class='"+tbclass+"'><input class='InputGrey' readonly  type='text' " +
                                " id='Rinput" + i + j + "' value='" + tempResult + "'></TD>";
                    }                    	
                    
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
    %>
    </tr>
</table>

<!------------------------------------------------------>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <%
                    if (selType.compareTo("checkbox") == 0) {
                        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选 class='b_foot'>&nbsp");
                        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选 class='b_foot'>&nbsp");
                    }
                %>

                <%
                    if (selType.compareTo("") != 0) {
                %>
                <input class='b_foot' name=commit onClick="preSaveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <%
                    }
                %>
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
                <input class='b_foot' name=consult onClick="showConsult()" style="cursor:hand" type=button value=参照 <%if(dataConsult==null||"".equals(dataConsult)||"null".equals(dataConsult)){%>style='display:none' <%}%> >&nbsp;<!-- wangzn 090928 -->
            </TD>
        </TR>
    </TBODY>
</TABLE>
<!------------------------>
<input type="hidden" name="retFieldNum" value=3>
<input type="hidden" name="retQuence" value="<%=retQuence%>" >
<input type="hidden" name="product_OperType" value="<%=product_OperType%>" >
<input type="hidden" name="maxGroup11" value="<%=irowlength%>" >
<input type="hidden" name="siMMSSumFlagHidd" id="siMMSSumFlagHidd" value="<%=siMMSSumFlag%>" >
<input type="hidden" name="typeFlagHidd" id="typeFlagHidd" value="<%=typeFlag%>" >

<!------------------------>

</div>
</div>
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
</FORM>
</BODY>
</HTML>    
