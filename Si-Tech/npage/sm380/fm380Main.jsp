<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: gaopeng 2016/5/16 15:14:10 关于开发转售业务测试号码开户等功能的需求
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupId =(String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String printAccept = getMaxAccept();
		String orgCode = (String)session.getAttribute("orgCode");
		String custIccid = "";
		
		/*
	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}*/
		
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select t.code_id,t.code_name from pd_unicodedef_dict T where code_class =:code_class order by t.code_id";
    inParamsMail[1] = "code_class="+"ZS002";
	 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="2"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script src="/npage/public/json2.js" type="text/javascript"></script>
	<script src="/npage/sm380/fm380Obj.js" type="text/javascript"></script>
	<script language="javascript">
		
		var v_printAccept = "<%=printAccept%>";
		$(document).ready(function(){
			
		});
		
		function Idcard2(str){
			//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	var cardType ="11";
	if(ret_open==0){
		//alert(v_printAccept+"--"+str);
			//多功能设备RFID读取
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
			if(str=="1"){
				try{
					document.all.pic_name.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.but_flag.value="1";
					document.all.card_flag.value ="2";
				}catch(e){
						
				}
			}
			//alert(ret_getImageMsg);
			//ret_getImageMsg = "0";
			if(ret_getImageMsg==0){
				//二代证正反面合成
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//证件有效期
				var zz =CardReader_CMCC.MutiIdCardAddress; //住址
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //签发机关
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //证件号码
				var base64 =CardReader_CMCC.MutiIdCardPhoto;
				var v_validDates = "";
				if(yxqx.indexOf("\.") != -1){
					yxqx = yxqx.split(".");
					if(yxqx.length >= 3){
						v_validDates = yxqx[0]+yxqx[1]+yxqx[2]; 
					}else{
						v_validDates = "21000101";
					}
				}else{
					v_validDates = "21000101";
				}
				
				if(str == "1"){ //读取客户基本信息
					//证件号码、证件名称、证件地址、有效期
					//xm = "高鹏";
					//zjhm = "232332199001226318";
					//zz = "哈尔滨南岗区嵩山路33号中国移动开发区营业厅后门";
					document.all.custName.value =xm;//姓名
					document.all.idIccid.value =zjhm;//身份证号
					document.all.idAddr.value =zz;//身份证地址
					document.all.idValidDate.value =v_validDates;//证件有效期
					document.all.birthDay.value =cs;//生日
					document.all.birthDayH.value =cs;//生日
					document.all.custSex.value=xb;//性别
		  		document.all.idSexH.value=xb;//性别
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddr").attr("class","InputGrey");
		  		$("#idAddr").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");
		  		
		  		checkIccIdFunc(document.all.idIccid,0,0);
		  		checkCustNameFunc(document.all.custName,0,0);
		  		pubM032Cfm();
		  		
				}else if(str == "31"){ //经办人
					document.all.gestoresName.value =xm;//姓名
					document.all.gestoresIccId.value =zjhm;//身份证号
					//document.all.gestoresAddr.value =zz;//身份证地址
				}else if(str == "57"){ //责任人
					document.all.responsibleName.value =xm;//姓名
					document.all.responsibleIccId.value =zjhm;//身份证号
					//document.all.gestoresAddr.value =zz;//身份证地址
				}
				
				subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字
				
				
				
			}else{
					rdShowMessageDialog("获取信息失败");
					return ;
			}
	}else{
					rdShowMessageDialog("打开设备失败");
					return ;
	}
	//关闭设备
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("关闭设备失败");
		return ;
	}
	
}

function subStrAddrLength(str,idAddr){
	var packet = new AJAXPacket("/npage/sq100/fq100_ajax_subStrAddrLength.jsp","正在获得数据，请稍候......");
	packet.data.add("str",str);
	packet.data.add("idAddr",idAddr);
	core.ajax.sendPacket(packet,doSubStrAddrLength);
	packet = null;
}

function doSubStrAddrLength(packet){
	var str = packet.data.findValueByName("str");
	var idAddr = packet.data.findValueByName("idAddr");
	if(str == "1"){ //读取客户基本信息
		document.all.idAddr.value =idAddr;//身份证地址
		document.all.idAddrH.value =idAddr;//身份证地址
		//checkAddrFunc(document.all.idAddr,0,0);
	}else if(str == "31"){ //经办人
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "manage"){ //经办人 旧版
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "j1"){ //读取客户基本信息 旧版
		document.all.idAddr.value =idAddr;//身份证地址
		document.all.idAddrH.value =idAddr;//身份证地址
	}else if(str == "zerenren"){ //责任人 旧版
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}else if(str == "57"){ //责任人 
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}
	
}

/*
	2013/11/18 14:01:09
	gaopeng
	证件类型变更时，证件号码的校验方法
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
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
		objName = "责任人证件号码";
		idTypeVal = document.all.responsibleType.value;
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
		var idTypeText = idTypeVal.split("|")[0];
		
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
		 if(objValueLength != 10){
					rdShowMessageDialog(objName+"必须是10位！");				
					nextFlag = false;
					return false;
			}
			if(objValue.substr(objValueLength-2,1)!="-" && objValue.substr(objValueLength-2,1)!="－") {
					rdShowMessageDialog(objName+"倒数第二位必须是“-”！");				
					nextFlag = false;
					return false;			
			}
		}
		/*营业执照 证件号码号码大于等于4位数字，出现其他如汉字等字符也合规*/
		if(idTypeText == "8"){
		
		 if(objValueLength != 13 && objValueLength != 15 && objValueLength != 18 && objValueLength != 20){
					rdShowMessageDialog(objName+"必须是13位或15位或18位或20位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"不允许录入汉字！");				
					nextFlag = false;
					return false;
			}

		}
		/*法人证书 证件号码大于等于4位字符*/
		if(idTypeText == "B"){
		 if(objValueLength != 12){
					rdShowMessageDialog(objName+"必须是12位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"不允许录入汉字！");				
					nextFlag = false;
					return false;
			}
			
		}
		
	}
	return nextFlag;
}

/*
	2013/11/15 15:33:56 gaopeng 关于进一步提升省级支撑系统实名登记功能的通知  
	注意：只针对个人客户 start
*/  

/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
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
		objName = "责任人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.responsibleType.value;
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
		var idTypeText = idTypeVal.split("|")[0];
		
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
		
		
		if(ifConnect == 0){
		if(nextFlag){
		 if(objType == 0){
		 	/*联系人姓名随客户名称改名而改变*/
			  if(document.all.ownerType.value=="02"){
			    document.frm1100.contactPerson.value = frm1100.custName.value;
			    /*document.all.print.disabled=true;*/
			  }
		 	}	
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
		objName = "责任人联系地址";
		idTypeVal = document.all.responsibleType.value;
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
		var idTypeText = idTypeVal.split("|")[0];
		
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
	/*联动赋值 ifConnect 传0时才赋值，否则不赋值*/
	if(ifConnect == 0){
		if(nextFlag){
			/*证件地址改变时，赋值其他地址*/
			if(objType == 0){
				if(document.all.ownerType.value=="01"){
					
			    document.all.custAddr.value=objValue;
			    document.all.contactAddr.value=objValue;
			    document.all.contactMAddr.value=objValue;
			  }
			}
			/*客户地址改变时，赋值联系人地址和联系人通讯地址*/
			if(objType == 1){
				frm1100.contactAddr.value = objValue;
	  		frm1100.contactMAddr.value = objValue;
			}
			/*联系人地址改变时，赋值联系人通讯地址，2013/12/16 15:20:17 20131216 gaopeng 赋值经办人联系地址联动*/
			if(objType == 2){
				document.all.contactMAddr.value=objValue;
				document.all.gestoresAddr.value=objValue;
				document.all.responsibleAddr.value=objValue;
			}
		}
	}
	
	
}
return nextFlag;
}

function pubM032Cfm(){}

var chkPhoneFlag = false;
/*校验开户号码服务*/
function chkPhoneFunc(){
	
		var phoneNo = $.trim($("#phoneNo").val());
		var accountNum = $.trim($("#accountNum").val());
		var idIccid = $.trim($("#idIccid").val());
		
		if(phoneNo.length == 0 ){
			rdShowMessageDialog("请输入手机号码！");
			return false;
		}
		if(accountNum.length == 0 ){
			rdShowMessageDialog("请输入员工编号！");
			return false;
		}
		if(idIccid.length == 0 ){
			rdShowMessageDialog("请输入证件号码！");
			return false;
		}
		var idTypeSelect = $.trim($("#idTypeSelect").find("option:selected").val().split("|")[0]);
		/*ajax start*/
		var getdataPacket = new AJAXPacket("/npage/sm380/fm380ChkPhone.jsp","正在获得数据，请稍候......");
		
		var iLoginAccept = "<%=printAccept%>";
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=workNo%>";
		var iLoginPwd = "<%=noPass%>";
		var iPhoneNo = phoneNo;
		var iUserPwd = "";
		
		
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd",iUserPwd);
		getdataPacket.data.add("iOprtype","1");
		getdataPacket.data.add("iEmployeeNum",accountNum);
		getdataPacket.data.add("iIdType",idTypeSelect);
		getdataPacket.data.add("iIdIccId",idIccid);
		
		core.ajax.sendPacket(getdataPacket,doRetRegion);
		getdataPacket = null;
	
}

function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000"){
				chkPhoneFlag = true;
				rdShowMessageDialog("校验成功！",2);
				$("#b_emptySimOpen").attr("disabled","");
			}else{
				chkPhoneFlag = false;
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				$("#b_emptySimOpen").attr("disabled","disabled");
				return false;
			}
		}


function emptySimOpenFunc(){
		/*
		if(!chkPhoneFlag){
			return false;
		}*/
 
		document.all.cardtype_bz.value="k";
			 /*获取开户号码*/
  		 var phone = $("input[name='phoneNo']").val();
  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
        * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("/npage/s1104/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("读卡类型出错!");
    		 return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("读卡类型出错!");
    		return false ;
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
      	valueStr = retInfo1.substring(0,chPos);
      	var chPos1 = valueStr.indexOf("=");
      	valueStr1 = valueStr.substring(chPos1+1);
      	retInfo1 = retInfo1.substring(chPos+1);
      	retVal[i]=valueStr1;
        	
    	} 
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("读卡类型出错!");
    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("读卡类型出错!");
    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");
  			 
    		 return false;   
    	}
    	//alert("返回的sim卡类型：-----"+rescode_strstr);
    	//rescode_strstr = "10001";
  		 /****取SIM卡类型结束******/
    		 var path = "<%=request.getContextPath()%>/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "生成SIM卡号码";
    	       
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		//alert("准备获取随机SIM卡号：---"+retInfo);
    		/*可以进行资源校验*/
    		document.all.checksimN.disabled=false;
    		 if(typeof(retInfo) == "undefined")     
    			{	
    				return false;
    			}
    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));
    		document.all.simCode.value=simsim;
    		document.all.simType.value=(cardcard).trim();
    		document.all.simTypeCfm.value=(cardcard).trim();
    		
    		
    		if((typetype).trim()=="null"){
    			
  			}else{
	 				document.all.simTypeName.value=(typetype).trim();
  			}
}

function writechg(){
					/*
				 retsimcode = "0";
    		 //retsimno = "898602A40875F5367932";
    		 retsimno = document.all.simCode.value;
    		 cardstatus = "3";
    		 if(retsimcode=="0"){rdShowMessageDialog("写卡成功");
	    		 document.all.writecardbz.value="0";
	    		 document.all.simCode.value=retsimno;
	    		 document.all.simCodeCfm.value=retsimno;
	    		 document.all.cardstatus.value=cardstatus;
	    		 document.all.cfmBtn.disabled=false;
    		 
    		 }*/
	//return true;
	if(document.all.simCode.value==""){
		rdShowMessageDialog("sim卡号不能是空!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = $("input[name='phoneNo']").val().trim();
  			document.all.b_write.disabled=true;
  			//alert(986);
    		 var path = "<%=request.getContextPath()%>/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    		 path = path + "&sim_type=" +document.all.simTypeCfm.value;
    		 path = path + "&sim_no=" +document.all.simCode.value;
    		 path = path + "&op_code=" +"<%=opCode%>";
    	         path = path + "&phone=" + phone + "&pageTitle=" + "写卡";
    	         path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for 关于哈分公司申请优化远程写卡操作步骤的请示
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		 if(typeof(retInfo) == "undefined")     
    			{	
    				 
    				document.all.writecardbz.value="1"; 
    				document.all.b_write.disabled=false;
    				document.all.cfmBtn.disabled=true;   //写卡失败不能提交 hejwa add 
    				rdShowMessageDialog("写卡失败");
    				return false;   
    				
    			}
    		 //retInfo = "0||3|kahao";
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2));
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3));
    		 var cardNo=oneTok(oneTok(retInfo,"|",4));
    		 //alert("卡号是：retsimcode="+retsimcode+",retsimno="+retsimno+",cardstatus="+cardstatus+",cardNo="+cardNo);
    		 //retsimcode = "0";
    		 //retsimno = "898602A40875F5367932";
    		 //retsimno = document.all.simCode.value;
    		 //cardstatus = "3";
    		 if(retsimcode=="0"){rdShowMessageDialog("写卡成功");
	    		 document.all.writecardbz.value="0";
	    		 document.all.simCode.value=retsimno;
	    		 document.all.simCodeCfm.value=retsimno;
	    		 document.all.cardstatus.value=cardstatus;
	    		 document.all.cardNo.value=cardNo;
	    		 
	    		 document.all.cfmBtn.disabled=false;
    		 
    		 }else{
    		 	document.all.writecardbz.value="1";
    		 	document.all.cfmBtn.disabled=true;
    		 	rdShowMessageDialog("写卡失败");
    		 }
	}
	else{
		rdShowMessageDialog("实卡不能写卡");
		document.all.cfmBtn.disabled=true;   //写卡失败不能提交 hejwa add 
		document.all.b_write.disabled=true;
		return false;
	}
}

function checksim(){
	
	if(document.all.phoneNo.value == "")
    {
        rdShowMessageDialog("请输入服务号码！",0);
        document.all.phoneNo.focus();
        return ;
    }
    
    var giveliyana = document.all.phoneNo.value.trim();
    
    
    
    var operType = document.all.newSmCode.value;
    var sim_type = document.all.simTypeCfm.value;
    if(document.all.simCode.value == "")
    {
        rdShowMessageDialog("请输入SIM卡号码！",0);
        return false;
    } 
   
    
		var checkResource_Packet = new AJAXPacket("/npage/s1104/f1104_5.jsp","正在进行资源校验，请稍候......");
		checkResource_Packet.data.add("retType","checkResource");
    checkResource_Packet.data.add("sIn_Phone_no",giveliyana);
    checkResource_Packet.data.add("sIn_OrgCode","<%=orgCode%>");
    checkResource_Packet.data.add("sIn_Sm_code",operType);
    checkResource_Packet.data.add("sIn_Sim_no",document.all.simCode.value);
    /*begin diling add for 关于对特殊号码审批专项测试结果进行优化的需求 增加参数：custIccid @2012/5/28 */
    checkResource_Packet.data.add("custIccid","<%=custIccid%>");
    /*end diling add*/
    checkResource_Packet.data.add("sIn_Sim_type",sim_type);
    checkResource_Packet.data.add("workno","<%=workNo%>");
    checkResource_Packet.data.add("innetType",document.all.innetType.value);
    
    checkResource_Packet.data.add("offerId","0");
    
    
    var nuCardType = document.all.cardTypeN.value;
		if(nuCardType=="1"){
			//空卡开户
			checkResource_Packet.data.add("simType",document.all.simTypeCfm.value);
		}else{
			checkResource_Packet.data.add("simType","");
		}
		checkResource_Packet.data.add("simTypeOne","");
    
    var szph = "aaa";
   	
    checkResource_Packet.data.add("zph",szph);
    checkResource_Packet.data.add("sIn_cardtype",document.all.cardtype_bz.value);
		core.ajax.sendPacket(checkResource_Packet,doChecksim2,false);
		checkResource_Packet=null;  
		
		
	}
	
	function doChecksim2(packet){
		rdShowMessageDialog("资源校验成功！");
		if(document.all.cardtype_bz.value=='k'){
			document.all.b_write.disabled=false;
		}
	}
	
	function doChecksim(packet){
					
		var retCode = packet.data.findValueByName("retCode");
		var retMessage = packet.data.findValueByName("retMessage");
		
		var isGoodNo = packet.data.findValueByName("isGoodNo");
		var prepayFee = packet.data.findValueByName("prepayFee");
		var mode_dxpay = packet.data.findValueByName("mode_dxpay"); 
		document.all.prepayFee.value = prepayFee;		
		document.all.isGoodNo.value = isGoodNo;
 		document.all.modedxpay.value = mode_dxpay;
 		 if(retCode=="0"||retCode=="000000"){
    	
    	    //getFee();   //得到费用参数
				    	   var tempSimType = $("#simType").val().trim();
				    	    if(tempSimType>="10013" && tempSimType<="10015"){
												if(tempSimType=='10013' && tempSimType!='bgn'){
												rdShowMessageDialog("只有业务品牌是全球通的用户才能用全球64KOTA卡！");
												return false;}
												if(tempSimType=='10014' && tempSimType!='bdn'){
												rdShowMessageDialog("只有业务品牌是动感地带的用户才能用动感地带64KOTA卡！");
												return false;}
												if(tempSimType=='10015' && tempSimType!='bzn'){
												rdShowMessageDialog("只有业务品牌是神洲行的用户才能用神洲行64KOTA卡！");
												return false;}
										}
		            rdShowMessageDialog("资源校验成功！");
		            //漫游改造需求 ningtn
		            	var romaphoneNo = $("#phoneNo").val();//取出号码
									var romaphoneNo3 = romaphoneNo.substring(0,3);//取出号码前3位
									/* gaopeng 20120914  begin 删除array里面的157号段*/
									var gheadArrs = new Array("045","046","451");
									if(findStrInArr(romaphoneNo3,gheadArrs)){
										setNoneRoma(myArrs,false,false);
										var roma2042Arrs = new Array("2042");
										setNoneRoma(roma2042Arrs,true,true);
									}
								
								document.all.checksimN.disabled=true;
		            
						 if(document.all.cardtype_bz.value=='k'){
				  			document.all.b_write.disabled=false;
				  		}
			  		
				  	document.all.phoneNo.readOnly=true;
					  document.all.phoneNo.className="InputGrey";	
					  document.all.simCode.readOnly=true;
					  document.all.simCode.className="InputGrey";			
					  
    	}else{
    	    	retMessage = retMessage + "[errorCode8:" + retCode + "]";
    				rdShowMessageDialog(retMessage,0);
    				return false;
    	}
}
function findStrInArr(str1,arrObj){
	var reFlag = false;
	$.each(arrObj,function(i,n){
		if(n == str1){
			reFlag = true;
		}
	});
	return reFlag;
}

function setNoneRoma(romaArr,checkedFlag,disFlag){
		$.each(romaArr,function(i,n){
			if($("#" + n + "").length > 0){
				var romaName = $("#" + n + "").attr("name").substr(9);
				var romaAttr = $("#"+ n +"").attr("checked");
				if(checkedFlag){
					if(romaAttr != "true"){
						$("#"+ n +"").attr("checked","true");
						showDetailProd2(n,romaName,$("#"+ n +"")[0],1);
					}
				}else{
					if(romaAttr){
						$("#"+ n +"").removeAttr("checked");
						showDetailProd2(n,romaName,$("#"+ n +"")[0],1);
					}
				}
				if(disFlag){
					$("#"+ n +"").attr("disabled","true");
				}else{
					$("#"+ n +"").removeAttr("disabled");
				}
			}
		});
}

/*2016/5/27 14:44:26 gaopeng 提交操作*/
		function nextStep(){
			
			if(!check(f1)){
				return false;
			}
			
			var newtfStr = "";
			$("input[name='tef'][checked]").each(function(){
				var thisval = $(this).val();
				if(newtfStr.length == 0){
					newtfStr = thisval;
				}else{
					newtfStr += ";"+thisval;
				}
			});
			if(newtfStr.length == 0){
				rdShowMessageDialog("请选择特服信息！");
				return false;
			}
			
			/* 审批公文编号 */
			var spgwNum = $.trim($("#spgwNum").val());
			var accountNum = $.trim($("#accountNum").val());
			var idTypeSelect = $.trim($("#idTypeSelect").find("option:selected").val().split("|")[0]);
			var custName = $.trim($("#custName").val());
			var idIccid = $.trim($("#idIccid").val());
			var idAddr = $.trim($("#idAddr").val());
			var contactPhone = $.trim($("#contactPhone").val());
			var simCode = $.trim($("#simCode").val());
			var phoneNo = $.trim($("#phoneNo").val());
			var cardNo = document.all.cardNo.value;
			
			var paramBelong		= new	param();
			
			paramBelong.setAPPROVAL_ID(spgwNum);	
			paramBelong.setLOGIN_NO(accountNum);
			paramBelong.setID_TYPE(idTypeSelect);
			paramBelong.setID_NUM(idIccid);
			paramBelong.setCUST_NAME(custName);
			paramBelong.setCUST_ADDR(idAddr);
			paramBelong.setPHONE_NO(contactPhone);
			paramBelong.setSIM_NO(simCode);
			paramBelong.setiCardNo(cardNo);
			
			/*拼json串*/
			var myJSONText = JSON.stringify(paramBelong,function(key,value){
				return value;
			});
		
			//alert(myJSONText);
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm380/fm380Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=printAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("ioprtype","1001");
			getdataPacket.data.add("vOldParam","");
			getdataPacket.data.add("vNewParam",newtfStr);
			getdataPacket.data.add("custinfostr",myJSONText);
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("开户成功！",2);
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			}
			resetPage();
		}
		
		function resetPage(){
			
			window.location.href="/npage/sm380/fm380Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				
		}

	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<div class="title">
			<div id="title_zi">基本信息</div>
		</div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">审批公文编号</td>
	  		<td width="30%">
	  			<input type="text" id="spgwNum" v_must="1" name="spgwNum"  maxlength="40" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<font class=orange>*</font>
	  		</td>
	  		<td width="20%" class="blue">员工编号</td>
	  		<td width="30%">
	  			<input type="text" id="accountNum" v_must="1" name="accountNum"  maxlength="10" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<font class=orange>*</font>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">证件类型</td>
	  		<td width="30%">
	  			<select name="idType" id="idTypeSelect">
	  				<option value="0|身份证">身份证</option>	
	  			</select>
	  		</td>
	  		<td width="20%" class="blue">客户名称</td>
	  		<td width="30%">
	  			<input name=custName id="custName" value=""  v_must=1 v_maxlength=60 v_type="string"   maxlength="60" size=20 index="9"  >
	  		</td>
	    </tr>
	    <tr>
	    	<td width="50%" colspan=2 align=center>
	        <input type="button" name="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()" >
	        <input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="读卡(2代)" onClick="Idcard2('1')" >
        </td>	
	  		<td width="20%" class="blue" >证件号码</td>
	      <td width="30%"> 
        	<input name="idIccid"  id="idIccid"   value=""  v_minlength=4 v_maxlength=20 v_type="string" onChange="change_idType('1')" maxlength="20"   index="11" value="">
        </td>
	    </tr>
	    <tr>
	    	<td width="20%" class="blue" >证件地址</td>
	      <td width="30%"> 
	        <input name=idAddr  id="idAddr" value=""   v_must=1 v_type="addrs"  maxlength="60" v_maxlength=60 size=30 index="12">
	      </td>
	    	<td class="blue" > 
          <div align="left">证件有效期</div>
        </td>
        <td> 
          <input class="button" name="idValidDate" id="idValidDate" v_must=0 v_maxlength=8 v_type="date" readonly  maxlength=8 size="8" index="13" >
        </td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">联系电话</td>
	  		<td width="30%">
	  			<input id="contactPhone" name=contactPhone class="button" v_must=1 v_type="phone" maxlength="20"  index="20" size="20" >
	  		</td>
	    </tr>
	  </table>
	  <div class="title">
			<div id="title_zi">特服信息</div>
		</div>
		<table>
	    <tr>
	  		<td>
	  			<%
	  				if(result_mail.length > 0 && "000000".equals(retCode_mail)){
	  					for(int i=0;i<result_mail.length;i++){
	  							if(i != 0 && i%6==0){
	  								%>
	  							  
	  								<%
	  							}
	  						%>
	  							<input type="checkbox" name="tef" value="<%=result_mail[i][0]%>"/><%=result_mail[i][1]%> &nbsp;
	  						<%
	  					}
	  				}
	  			%>
	  		</td>
	    </tr>
	  </table>
		<div class="title">
			<div id="title_zi">资源信息</div>
		</div>
		<table>
			<tr>
		     <td class="blue">开户号码</td>
				 <td>
				 		<input type="text" name="phoneNo" id="phoneNo" value="" maxlength="11"  onblur="checkElement(this)"/>
			   		<font class=orange>*</font>
			   		<input type="button" class="b_text" name="chkPhone" id="chkPhone" value="校验" onclick="chkPhoneFunc();"/>
			   		<input type="button" id="b_emptySimOpen" name="b_emptySimOpen" value="空卡开户" class="b_text" disabled="disabled" onClick="emptySimOpenFunc()" > 
			   </td>
	    </tr>
	    
	    <tr style="display:none">
		     <td class="blue">空卡开户 </td>
				 <td>
				  	<select align="left" id="cardTypeN" name="cardTypeN"  index="28" onchange="chaCardType()">
			        <option value="0" >否</option>
			        <option value="1" selected>是</option>
			      </select>	
			   </td>
	    </tr>
	    
	    <tr  id="tr_serviceNo1">
			  <td class="blue"  id="th_simInfo"> SIM卡号 </td>
			  <td colspan="6"  id="td_simInfo">
			  	<input name="simType" id="simType" type=hidden value="">
			  	<input name=simTypeName type=text  readonly index="11" Class="InputGrey">
			  	<input type='text' name='simCode' id='simCode' maxlength="20" class="required numOrLetter" value="">
			  	<input type="button" id="checksimN" name="checksimN" value="资源校验" class="b_text" onClick="checksim()" disabled> <font class="orange">*</font>
			  	<input type="button" name="b_write" value="写卡" class="b_text" onClick="writechg()" disabled > 
			  	</td>
			</tr>
	  </table>
	</div>
	 <div>
	 
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="cfmBtn" name="cfmBtn"  type="button" value="确认&打印" disabled="disabled"  onclick="nextStep();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
			</tr>
		</table>
	
	</div>
	<input type="hidden" name="birthDay" id="birthDay" />
	<input type="hidden" name="birthDayH" id="birthDayH" value=""/>
	<input type="hidden" name="custSex" id="custSex" value=""/>
	<input type="hidden" name="idSexH" id="idSexH" value=""/>
	<input type="hidden" name="idAddrH" id="idAddrH" value=""/>
	
	<input type="hidden" name="card_flag" value="">  <!--身份证几代标志-->
	<input type="hidden" name="pa_flag" value="">  <!--证件标志-->
  <input type="hidden" name="m_flag" value="">   <!--扫描或者读取标志，用于确定上传图片时候的图片名-->
  <input type="hidden" name="sf_flag" value="">   <!--扫描是否成功标志-->
  <input type="hidden" name="pic_name" value="">   <!--标识上传文件的名称-->
  <input type="hidden" name="up_flag" value="0">
  <input type="hidden" name="but_flag" value="0"> <!--按钮点击标志-->
  <input type="hidden" name="upbut_flag" value="0"> <!--上传按钮点击标志-->
  <input name="cardtype_bz" type="hidden" value="s">	
  <input type="hidden" name="simTypeCfm" id="simTypeCfm"   />
	<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />
	<input type="hidden" name="newSmCode" value="dn"/>
	<input type="hidden" name="innetType" id="innetType" value="01"/><!-- 代表普通开户 -->
	<input type="hidden" name="prepayFee" id="prepayFee"   />
	<input type="hidden" name="isGoodNo" id="isGoodNo"   />
	<input type="hidden" name="modedxpay" id="modedxpay"   />
	<input name="cardstatus" type=hidden value="">
	<input name="cardNo" type=hidden value="">
	<input name="writecardbz" type=hidden value="">
	
	

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>                             

<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<%@ include file="/npage/sq100/interface_provider.jsp" %>
</html>
