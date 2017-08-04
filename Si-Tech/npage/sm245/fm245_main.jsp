<%
  /*
   * 功能: m245·实际使用人信息修改 
   * 版本: 1.0
   * 日期: 2015/3/30 
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
  String regionCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 

		/*2017.4.18关于申请取消物联卡及M2M客户开户界面使用人录入的函 。*/
		String m2mFlag = "";
		
%>
		<wtc:service name="sM2mChk" outnum="3"
			routerKey="region" routerValue="<%=regionCode%>" retcode="m2mrc" retmsg="m2mrm" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=loginNo%>"/>
			<wtc:param value = "<%=noPass%>"/>
			<wtc:param value = "<%=phoneNo%>"/>	
			<wtc:param value = ""/>
			<wtc:param value = ""/>
			<wtc:param value = ""/>
		</wtc:service>
		<wtc:array id="outM2mFlag" scope="end" />

<%
	if("000000".equals(m2mrc)){
			if(outM2mFlag.length > 0){

			System.out.println("----duming---------m2mrc--"+m2mrc+"m2mrm"+m2mrm+"outM2mFlag"+outM2mFlag[0][0]);
				m2mFlag = outM2mFlag[0][0];

			}
		}




%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<script src="../public/json2.js" type="text/javascript"></script>   
<script language="JavaScript">
var v_printAccept = "<%=printAccept%>";
function query(){
	$("#queryDiv").hide();
	var phoneNo = "<%=activePhone%>";
	var myPacket = new AJAXPacket("fm245_ajax_queryInfo.jsp","正在提交信息，请稍候......");
  myPacket.data.add("opCode","<%=opCode%>");
  myPacket.data.add("opName","<%=opName%>");
  myPacket.data.add("phoneNo",phoneNo);
  core.ajax.sendPacket(myPacket,doQuery);
  myPacket = null;
}

function doQuery(packet){
	
	//2017.4.18关于申请取消物联卡及M2M客户开户界面使用人录入的函
	if("<%=m2mFlag%>"=="Y"){
	   			
		rdShowMessageDialog("资费有M2M属性，不允许录入实际使用人",3);
		return;
	}
	
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var qPhoneNo = packet.data.findValueByName("qPhoneNo");
	var qCustName = packet.data.findValueByName("qCustName");
	var qRealUserIdType = packet.data.findValueByName("qRealUserIdType");
	var qRealUserIccId = packet.data.findValueByName("qRealUserIccId");
	var qRealUserName = packet.data.findValueByName("qRealUserName");
	var qRealUserAddr = packet.data.findValueByName("qRealUserAddr");
	if(retCode == "000000"){
		if(qRealUserIdType.length == 0 && qRealUserIccId.length == 0 && qRealUserName.length == 0 && qRealUserAddr.length == 0){
			if(rdShowConfirmDialog('没有查询结果！是否进行新增相关信息？')==1){
				//是否需要校验：用户当前的证件类型为“单位客户”下证件类型？？
	    	$("#addBtn").attr("disabled",false); //可进行新增
	    }else{
	    	$("#addBtn").attr("disabled",true);
	    	$("#queryDiv").hide();
	    }
	    if(qPhoneNo.length > 0){
	    	$("#qPhoneNoHid").val(qPhoneNo);
	    }
	    if(qCustName.length > 0){
				$("#qCustNameHid").val(qCustName);
	    }
		}else{
			$("#queryDiv").show();
			$("#qPhoneNo").val(qPhoneNo);
			$("#qCustName").val(qCustName);
			$("#realUserIdType option").each(function(){
	      if($(this).val().indexOf(qRealUserIdType) != -1){ //身份证类型相同
					$(this).attr("selected","true");
					if($(this).val() == "0"){ //身份证
						$("#scan_idCard_two2").css("display","");
						$("#scan_idCard_two222").css("display","");
					}else{ //非身份证
						$("#scan_idCard_two2").css("display","none");
						$("#scan_idCard_two222").css("display","none");
					}
				}
	    });
	    $("input[name='realUserName']").attr("class","InputGrey");
			$("input[name='realUserName']").attr("readonly","readonly");
			$("input[name='realUserAddr']").attr("class","InputGrey");
			$("input[name='realUserAddr']").attr("readonly","readonly");
			$("input[name='realUserIccId']").attr("class","InputGrey");
			$("input[name='realUserIccId']").attr("readonly","readonly");
	    
	    $("#realUserIccId").val(qRealUserIccId);
	    $("#realUserName").val(qRealUserName);
	    $("#realUserAddr").val(qRealUserAddr);
	    
	    $("#realUserIdTypeHid").val(qRealUserIdType);
			$("#realUserIccIdHid").val(qRealUserIccId);
			$("#realUserNameHid").val(qRealUserName);
			$("#realUserAddrHid").val(qRealUserAddr);
			$("#realUserIdType").attr("disabled",true);
			$("#updBtn").val("修改");
		}
	}else{
		rdShowMessageDialog("查询失败！<br>错误代码："+retCode+"<br>错误信息："+retMsg,0);
		return false;
	}
}

function addInfo(){
	var qPhoneNoHid = $("#qPhoneNoHid").val();
	var qCustNameHid = $("#qCustNameHid").val();
	$("#qPhoneNo").val(qPhoneNoHid);
	$("#qCustName").val(qCustNameHid);
	
	$("#qryBtn").attr("disabled",true);
	$("#addBtn").attr("disabled",true);
	$("#queryDiv").show();
	$("#updBtn").val("确认");
	$("#realUserIccId").val("");
	$("#realUserName").val("");
	$("#realUserAddr").val("");
	$("#qPhoneNo").removeAttr("class");
	$("#qCustName").removeAttr("class");
	$("#realUserIdType").attr("disabled",false);
	
	$("input[name='qPhoneNo']").attr("class","InputGrey");
	$("input[name='qPhoneNo']").attr("readonly","readonly");
	$("input[name='qCustName']").attr("class","InputGrey");
	$("input[name='qCustName']").attr("readonly","readonly");
	$("input[name='realUserName']").attr("class","InputGrey");
	$("input[name='realUserName']").attr("readonly","readonly");
	$("input[name='realUserAddr']").attr("class","InputGrey");
	$("input[name='realUserAddr']").attr("readonly","readonly");
	$("input[name='realUserIccId']").attr("class","InputGrey");
	$("input[name='realUserIccId']").attr("readonly","readonly");
}

function validateRealIdTypes(idtypeVal){
	var qRealUserIdType = $("#realUserIdTypeHid").val();
	var qRealUserIccId = $("#realUserIccIdHid").val();
	var qRealUserName = $("#realUserNameHid").val();
	var qRealUserAddr = $("#realUserAddrHid").val();
	if($("#realUserIdType").val().indexOf(qRealUserIdType) != -1){
		$("#realUserIccId").val(qRealUserIccId);
    $("#realUserName").val(qRealUserName);
    $("#realUserAddr").val(qRealUserAddr);
	}else{
		$("#realUserIccId").val("");
    $("#realUserName").val("");
    $("#realUserAddr").val("");
	}
	if(idtypeVal == "0"){
		document.all.realUserIccId.v_type = "idcard";
		$("#scan_idCard_two2").css("display","");
		$("#scan_idCard_two222").css("display","");
		$("input[name='realUserName']").attr("class","InputGrey");
		$("input[name='realUserName']").attr("readonly","readonly");
		$("input[name='realUserAddr']").attr("class","InputGrey");
		$("input[name='realUserAddr']").attr("readonly","readonly");
		$("input[name='realUserIccId']").attr("class","InputGrey");
		$("input[name='realUserIccId']").attr("readonly","readonly");
		$("input[name='realUserName']").val("");
		$("input[name='realUserAddr']").val("");
		$("input[name='realUserIccId']").val("");
	}else{
		document.all.realUserIccId.v_type = "string";
  	$("#scan_idCard_two2").css("display","none");
		$("#scan_idCard_two222").css("display","none");
		$("input[name='realUserName']").removeAttr("class");
		$("input[name='realUserName']").removeAttr("readonly");
		$("input[name='realUserAddr']").removeAttr("class");
		$("input[name='realUserAddr']").removeAttr("readonly");
		$("input[name='realUserIccId']").removeAttr("class");
		$("input[name='realUserIccId']").removeAttr("readonly");
	}
}

//修改数据
function updInfo(obj){



	//alert($(obj).val());
	if($(obj).val() == "修改"){
		$("#updBtn").val("确认");
		$("#realUserIdType").attr("disabled",false);
		if($("#realUserIdType").val() == "0"){
			
		}else{
			$("#realUserIccId").removeAttr("class");
			$("#realUserName").removeAttr("class");
			$("#realUserAddr").removeAttr("class");
			$("#qPhoneNo").removeAttr("readonly");
			$("#qCustName").removeAttr("readonly");
			$("#realUserIccId").removeAttr("readonly");
			$("#realUserName").removeAttr("readonly");
			$("#realUserAddr").removeAttr("readonly");
		}
	}else{
		if(!check(document.frm)) return false;
		
	if(!checkCustNameFunc(document.all.realUserName,3,1)){
		return false;
	}

	if(!checkAddrFunc(document.all.realUserAddr,5,1)){
				return false;
		}

	if(!checkIccIdFunc(document.all.realUserIccId,2,1)){
						return false;
	}
		
		
		
		if(rdShowConfirmDialog('确认要提交信息吗？')==1){
      document.frm.action="fm245_ajax_subInfo.jsp";
			document.frm.submit();
     }
		
	}
}





/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserName.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "客户名称";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "联系人姓名";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人姓名*/
	if(objType == 2){
		objName = "经办人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "实际使用人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.realUserIdType.value;
	}
	
	idTypeVal = $.trim(idTypeVal);
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	var objValue1 = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*有临时、代办字样的都不行*/
		if(objValue.indexOf("临时") != -1 || objValue.indexOf("代办") != -1){
					rdShowMessageDialog(objName+"不能带有‘临时’或‘代办’字样！");
					
					nextFlag = false;
					return false;
			
		}
		
		/*客户名称、联系人姓名均要求“大于等于2个中文汉字”，外国公民护照除外（外国公民护照客户名称必须大于3个字符，不全为阿拉伯数字)*/
		
		/*如果不是外国公民护照*/
		if(idTypeText != "6"){
			/*原有的业务逻辑校验 只允许是英文、汉字、俄文、法文、日文、韩文其中一种语言！*/
			
			/*2014/08/27 16:14:22 gaopeng 哈分公司申请优化开户名称限制的请示 要求单位客户时，客户名称可以填写英文大小写组合 目前先搞成跟 idTypeText == "3" || idTypeText == "9" 一样的逻辑 后续问问可不可以*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"必须大于等于2个汉字！");
					nextFlag = false;
					return false;
				}
				 var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*获取含有中文汉字的个数以及'()（）'的个数*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^·|\.|\．*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//分别获取输入内容
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*先校验括号*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*括号的数量+汉字的数量 != 总数量时 提示错误信息(这里需要注意一点，中文括号也是中文。。。所以这里只进行英文括号的匹配个数，否则会匹配多个)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"必须输入中文或中文与括号的组合(括号可以为中文或英文括号“()（）”)！");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"必须大于等于2个中文汉字！");
							
							nextFlag = false;
							return false;
						}
					}
					/*原有逻辑
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"最多输入6个汉字！");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*如果是外国公民护照 校验 外国公民护照客户名称(后续添加了联系人姓名也同理(sunaj已确定))必须大于3个字符，不全为阿拉伯数字*/
		if(idTypeText == "6"){
			/*如果校验客户名称*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"不能全为阿拉伯数字!");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"必须大于三个字符!");
						
						nextFlag = false;
						return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            if(objValue1.charAt(0).trim() == ""){
                rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
                
                nextFlag = false;
                return false;
              }
            var key = checkNameStr1(code); //校验
            alert("key:"+key);
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
		
		
		
	}	
	return nextFlag;
}


/*
	2013/11/18 11:15:44
	gaopeng
	客户地址、证件地址、联系人地址校验方法
	“客户地址”、“证件地址”和“联系人地址”均需“大于等于8个中文汉字”
	（外国公民护照和台湾通行证除外，外国公民护照要求大于2个汉字，台湾通行证要求大于3个汉字）
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
		if(document.all.realUserAddr.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "证件地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "客户地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "联系人地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "联系人通讯地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "经办人联系地址";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "实际使用人联系地址";
		idTypeVal = document.all.realUserIdType.value;
	}
		
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*获取含有中文汉字的个数*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*如果既不是外国公民护照 也不是台湾通行证 */
		if(idTypeText != "6" && idTypeText != "5"){
			/*含有至少8个中文汉字*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"必须含有至少8个中文汉字！");
				/*赋值为空*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*外国公民护照 大于2个汉字*/
	if(idTypeText == "6"){
		/*大于2个中文汉字*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"必须含有大于2个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*台湾通行证 大于3个汉字*/
	if(idTypeText == "5"){
		/*含有至少3个文汉字*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"必须含有大于3个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	证件类型变更时，证件号码的校验方法
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserIccId.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var idTypeVal = "";
	if(objType == 0){
		var objName = "证件号码";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "经办人证件号码";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "实际使用人证件号码";
		idTypeVal = document.all.realUserIdType.value;
	}
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*1、身份证及户口薄时，证件号码长度为18位*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"必须是18位！");
					
					nextFlag = false;
					return false;
			}
		}
		/*军官证 警官证 外国公民护照时 证件号码大于等于6位字符*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"必须大于等于六位字符！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为港澳通行证的，证件号码为9位或11位，并且首位为英文字母“H”或“M”(只可以是大写)，其余位均为阿拉伯数字。*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须是9位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"首字母必须是‘H’或‘M’！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母之后的所有信息*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"除首字母之外，其余位必须是阿拉伯数字！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为
			台湾通行证 
			证件号码只能是8位或11位
			证件号码为11位时前10位为阿拉伯数字，
			最后一位为校验码(英文字母或阿拉伯数字）；
			证件号码为8位时，均为阿拉伯数字
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须为8位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*8位时，均为阿拉伯数字*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
			}
			/*11位时，最后一位可以是英文字母或阿拉伯数字，前10位必须是阿拉伯数字*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"前十位必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"第11位必须为阿拉伯数字或英文字母！");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*组织机构代 证件号码大于等于9位，为数字、“-”或大写拉丁字母*/
		if(idTypeText == "A"){
			var m = /^([0-9\-A-Z]*)$/;
			var flag = m.test(objValue);
			if(!flag){
					rdShowMessageDialog(objName+"必须由数字、‘-’、或大写字母组成！");
					
					nextFlag = false;
					return false;
			}
			if(objValueLength < 9){
					rdShowMessageDialog(objName+"必须大于等于9位！");
					
					nextFlag = false;
					return false;
				
			}
		}
		/*营业执照 证件号码号码大于等于4位数字，出现其他如汉字等字符也合规*/
		if(idTypeText == "8"){
			var m = /^[0-9]+$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum < 4){
					rdShowMessageDialog(objName+"包含至少4个数字！");
					
					nextFlag = false;
					return false;
			}
			/*20131216 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 界面中的证件类型为“营业执照”时，要求证件号码的位数为15位字符*/
			if(objValueLength != 15){
					rdShowMessageDialog(objName+"必须为15个字符！");
					nextFlag = false;
					return false;
			}
		}
		/*法人证书 证件号码大于等于4位字符*/
		if(idTypeText == "B"){
			if(objValueLength < 4){
					rdShowMessageDialog(objName+"必须大于等于4位！");
					
					nextFlag = false;
					return false;
			}
			
		}


	}else if(opCode == "1993"){

	}
	return nextFlag;
}


function forKuoHao(obj){ //允许输入括号·.． 这几种副号
	var m = /^(\(?\)?\（?\）?)\·|\.|\．+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forEnKuoHao(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forHanZi1(obj)
  {
  	var m = /^[\u0391-\uFFE5]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		//showTip(obj,"必须输入汉字！");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  	return true;
  }
  
  //匹配由26个英文字母组成的字符串
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"必须为字母！");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  
  	return true;
  }
  
  
  function checkNameStr(code){
			/* gaopeng 2014/01/17 9:50:35 优先匹配括号 因为括号可能是中文也可能是英文，优先返回KH 保证逻辑不失误*/
				if(forKuoHao(code)) return "KH";//括号
		    if(forA2sssz1(code)) return "EH"; //英语
		    var re2 =new RegExp("[\u0400-\u052f]");
		    if(re2.test(code)) return "RU"; //俄文
		    var re3 =new RegExp("[\u00C0-\u00FF]");
		    if(re3.test(code)) return "FH"; //法文
		    var re4 = new RegExp("[\u3040-\u30FF]");
		    var re5 = new RegExp("[\u31F0-\u31FF]");
		    if(re4.test(code)||re5.test(code)) return "JP"; //日文
		    var re6 = new RegExp("[\u1100-\u31FF]");
		    var re7 = new RegExp("[\u1100-\u31FF]");
		    var re8 = new RegExp("[\uAC00-\uD7AF]");
		    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //韩国
		    if(forHanZi1(code)) return "CH"; //汉字
    
   }
  function checkNameStr1(code){
		/* gaopeng 2014/01/17 9:50:35 优先匹配括号 因为括号可能是中文也可能是英文，优先返回KH 保证逻辑不失误*/
			if(forKuoHao(code)) return "KH";//括号
	    if(forA2sssz1(code)) return "EH"; //英语
	    var re2 =new RegExp("[\u0400-\u052f]");
	    if(re2.test(code)) return "RU"; //俄文
	    var re3 =new RegExp("[\u00C0-\u00FF]");
	    if(re3.test(code)) return "FH"; //法文
	    var re4 = new RegExp("[\u3040-\u30FF]");
	    var re5 = new RegExp("[\u31F0-\u31FF]");
	    if(re4.test(code)||re5.test(code)) return "JP"; //日文
	    var re6 = new RegExp("[\u1100-\u31FF]");
	    var re7 = new RegExp("[\u1100-\u31FF]");
	    var re8 = new RegExp("[\uAC00-\uD7AF]");
	    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //韩国
	    if(forHanZi1(code)) return "CH"; //汉字
	    /*add 20170527身份证类型为外国公民护照校验客户姓名中间可以为空格*/
	    if(forKuoHao16New1(code)) return "EH";//英文符号

}
  /*add 20170527身份证类型为外国公民护照校验客户姓名中间可以为空格*/
  function forKuoHao16New1(obj){ //允许输入括号·.． 这几种副号
		var m = /^[\s]+$/;
	  	var flag = m.test(obj);
	  	//alert(flag);
	  	if(flag){
	  		return true;
	  	}else{
	  		return false;
	  	}
	}


</script> 
 
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">           
    <tr>
    	<td class="blue">用户号码</td>
    	<td colspan="3">
	    	<input type="text" id="phoneNo" name="phoneNo" value="<%=activePhone%>" class="InputGrey" readonly />
    	</td>
    </tr>
		<tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="qryBtn" id="qryBtn"  class="b_foot" value="查询" onclick="query()" />
				&nbsp;
				<input type="button" name="addBtn" id="addBtn"  class="b_foot" value="新增" onclick="addInfo()" disabled />
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="关闭" onclick="removeCurrentTab()" />
			</td>
		</tr>
	</table>
	<div id="queryDiv" style="display:none">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询结果</div>
			</div>
			<table cellspacing="0">           
		    <tr>
		    	<td class="blue">客户名称</td>
		    	<td>
			    	<input type="text" id="qCustName" name="qCustName" value="" class="InputGrey" readonly />
			    	<font class=orange>*</font>
		    	</td>
		    	<td class="blue">手机号码</td>
		    	<td>
			    	<input type="text" id="qPhoneNo" name="qPhoneNo" value="" class="InputGrey" readonly />
			    	<font class=orange>*</font>
		    	</td>
		    </tr>
		    <%@ include file="/npage/sm245/realUserInfo.jsp" %>
				<tr> 
					<td align="center" id="footer" colspan="4"> 
						<input type="button" name="updBtn" id="updBtn"  class="b_foot" value="修改" onclick="updInfo(this)">
					</td>
				</tr>
			</table>
	</div>
</div>
	<input type="hidden" id="qPhoneNoHid" name="qPhoneNoHid" value="" />
	<input type="hidden" id="qCustNameHid" name="qCustNameHid" value="" />
	<input type="hidden" id="realUserIdTypeHid" name="realUserIdTypeHid" value="" />
	<input type="hidden" id="realUserIccIdHid" name="realUserIccIdHid" value="" />
	<input type="hidden" id="realUserNameHid" name="realUserNameHid" value="" />
	<input type="hidden" id="realUserAddrHid" name="realUserAddrHid" value="" />
	<input type="hidden" name="custId" value="0" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
</HTML>