
<%
  
    String dangqianDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<script type="text/javascript">

/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFunc16New(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = "";
	var gestoresName="";
	var responsibleName="";
	var realUserName="";
	
	if(objType == 0){
		objName = "客户名称";
		//s_idtype
		if(typeof(document.all.idType)!="undefined"){
			idTypeVal = document.all.idType.value;
		}
		else if(typeof(document.all.s_idtype)!="undefined"){
			idTypeVal = document.all.s_idtype.value;
		}
		
		if(typeof(document.all.gestoresName)!="undefined"){
			gestoresName = document.all.gestoresName.value;
		}
		if(typeof(document.all.responsibleName)!="undefined"){
			responsibleName = document.all.responsibleName.value;
		}
		if(typeof(document.all.realUserName)!="undefined"){
			realUserName = document.all.realUserName.value;
		}
	}
	//if(objType == 1){
	//	objName = "联系人姓名";
	//	if(typeof(document.all.idType)=="undefined"){
	//		idTypeVal = document.all.s_idtype.value;
	//	}
	//	else{
	//		idTypeVal = document.all.idType.value;
	//	}
	//}
	/*2013/12/16 11:24:47 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人姓名*/
	if(objType == 1){
		objName = "经办人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.gestoresIdType.value;
		
	}
	if(objType == 2){
		objName = "责任人姓名";
		/*规则按照责任人证件类型*/
		idTypeVal = document.all.responsibleType.value;
		
	}
	if(objType == 3){
		objName = "实际使用人姓名";
		/*规则按照实际使用人姓名证件类型*/
		idTypeVal = document.all.realUserIdType.value;
	}	
	
	idTypeVal = $.trim(idTypeVal);
	
	/*只针对个人客户*/
	var opCode = "<%=request.getParameter("opCode")%>";
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
			if(idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 4){
					rdShowMessageDialog(objName+"长度4个汉字（8个字节）及以上！");
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
		     
         if(objValue==gestoresName){
        	 rdShowMessageDialog("客户名称和经办人名称不能相同!");
				nextFlag = false;
				return false;
         }
			if(objValue==responsibleName){
				rdShowMessageDialog("客户名称和责任人名称不能相同!");
				nextFlag = false;
				return false;
         }
			if(objValue==realUserName){
				rdShowMessageDialog("客户名称和使用人名称不能相同!");
				nextFlag = false;
				return false;
         }
		     
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr16New2(code); //校验
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
            /*2014/9/2 8:56:11 gaopeng 哈分公司申请优化开户名称限制的请示 */
       }else{
    	   
					/*获取含有中文汉字的个数以及'“·”或“.”'的个数*/
					var m = /^[\u4E00-\u9FA5]*$/;
					var chinaLength = 0;
					var juhaoLength = 0;
					var juhaoLength2 = 0;
					for (var i = 0; i < objValue.length; i ++){
			          var code = objValue.charAt(i);//分别获取输入内容
			          var flag = m.test(code);
			          /*先校验括号*/
			          if(forJuHao(code)&&idTypeText == "0"){
						juhaoLength ++;
			          }
			          else if(forJuHao2(code)){
						juhaoLength2++;
			          }
			          else if(flag){
			          	chinaLength ++;
			          }
			          
			    }
			    var machLength = chinaLength + juhaoLength+juhaoLength2;
					/*括号的数量+汉字的数量 != 总数量时 提示错误信息(这里需要注意一点，中文括号也是中文。。。所以这里只进行英文括号的匹配个数，否则会匹配多个)*/
					if(objValueLength != machLength || chinaLength == 0){
						if(idTypeText == "0"){
							rdShowMessageDialog(objName+"只包含简体汉字与“·”或“.”（包括半角全角的各类·和.）！");
						}
						else{
							rdShowMessageDialog(objName+"只包含简体汉字与“·”（包括半角全角的各类·）！");
						}
						
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"长度2个汉字（4个字节）及以上！");
							
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
					rdShowMessageDialog(objName+"不能全为阿拉伯数字！");
					/*赋值为空*/
					obj.value = "";
					nextFlag = false;
					return false;
				}
				if(objValueLength <= 3){
					rdShowMessageDialog(objName+"必须大于三个字符！");
					nextFlag = false;
					return false;
				}
				var chinaLength = 0;
				var kuohaoLength = 0;
				var shuziLength = 0;
				var m = /^[\u4E00-\u9FA5]*$/;
				var juhaoLength = 0;
				for (var i = 0; i < objValue.length; i ++){
		          var code = objValue.charAt(i);//分别获取输入内容
		          var flag = m.test(code);
		          /*先校验括号*/
		          if(forJuHao2(code)){
		          	kuohaoLength ++;
		          }
		          else if(flag){
		        	  
		          }
		          else{
		          	chinaLength ++;
		          }
				}
		          var machLength = chinaLength + kuohaoLength;
				if(objValueLength != machLength || chinaLength == 0){
					rdShowMessageDialog(objName+"除“·”外 ，不能有汉字符号！");
					/*赋值为空*/
					obj.value = "";
					
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
		     var SZ_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr16New(code); //校验
			//alert(key);
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
            if(key == "SZ"){
            	SZ_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            var machESH = KH_length + EH_length+SZ_length;
            
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH && objValueLength != machESH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文、英文+数字或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
			if("<%=opCode%>" != "g049"&&"<%=opCode%>" != "4977"&&"<%=opCode%>" != "m413"){
				if (ifConnect == 0) {
					if (nextFlag) {
						if (objType == 0) {
							if (typeof (document.all.t_comm_name) != "undefined") {
								$("input[type=text][name=t_comm_name]").val(objValue);
							} else {
								if ($("input[type=text][name=custName]").val().length > 5) {
									$("input[type=text][name=contactPerson]").val($("input[type=text][name=custName]").val().substring(0, 5));
								} else {
									$("input[type=text][name=contactPerson]").val($("input[type=text][name=custName]").val());
								}
							}
						}
					}
				}
			}
		}
		return nextFlag;
	}

	function checkIccIdFunc16New(obj, objType, ifConnect) {

		var nextFlag = true;
		var idTypeVal = "";
		if (objType == 0) {
			var objName = "证件号码";
			if (typeof (document.all.idType) != "undefined") {
				idTypeVal = document.all.idType.value;
			} else if (typeof (document.all.s_idtype) != "undefined") {
				idTypeVal = document.all.s_idtype.value;
			} else if (typeof (document.all.custIdType) != "undefined") {
				idTypeVal = document.all.custIdType.value;
			}
		}
		if (objType == 1) {
			objName = "经办人证件号码";
			idTypeVal = document.all.gestoresIdType.value;

		}
		if (objType == 2) {
			objName = "责任人证件号码";
			idTypeVal = document.all.responsibleType.value;

		}
		if (objType == 3) {
			objName = "实际使用人姓名";
			/*规则按照实际使用人姓名证件类型*/
			idTypeVal = document.all.realUserIdType.value;
		}

		/*只针对个人客户*/
		var opCode = "<%=WtcUtil.repStr(request.getParameter("opCode"),"")%>";
	if(""==opCode){
		opCode = "<%=WtcUtil.repStr(request.getParameter("vopcode"),"")%>";
	}
	/*获取输入框的值*/
	var objValue = obj.value;
	//alert(objValue);
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
			if(objType == 0){
				if(opCode=="1210"||opCode=="m349"||opCode=="i067"){
					$("#gestoresInfo1").css("display","");
					$("#gestoresInfo2").css("display","");
				}
				else{
					$("#gestoresInfo1").css("display","none");
					$("#gestoresInfo2").css("display","none");
				}
			}
			
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"必须是18位！");
					nextFlag = false;
					return false;
			}
			if(objValue.length>14){
				if(!forIdCard(obj)){
					nextFlag = false;
					return false;
				}
    			var cust_b_date = objValue.substring(6,14);
    			cust_b_date = cust_b_date.substring(0,6);
    			//alert(cust_b_date);
    			//cust_b_date = "200611";//测试临时写死
    			
				//判断是否小于10岁大于120岁(精确到月)
				var cm_month = bijiao_month(cust_b_date,"<%=dangqianDate%>");
				
			//alert("月份差cm_month=["+cm_month+"]");
			//alert(cm_month>10*12&&cm_month<120*12);
			//alert((cm_month/1)>(10*12));
			//alert((cm_month/1)<(120*12));
				if(cm_month>(10*12)&&cm_month<(120*12)){
					if(objType==0&&opCode!="1210"){
						$("#gestoresInfo1").css("display","none");
				    	$("#gestoresInfo2").css("display","none");
					}
				}
				else{
					if(objType == 1||objType == 2||objType == 3){
						rdShowMessageDialog("责任人、经办人、使用人如果是身份证和户口薄，年龄在10-120岁(精确到月)之外不允许办理!");
						nextFlag = false;
						return false;
					}
					if(objType==0){
						$("#gestoresInfo1").css("display","");
				    	$("#gestoresInfo2").css("display","");
				    	/*经办人姓名*/
				      	document.all.gestoresName.v_must = "1";
				      	/*经办人地址*/
				      	document.all.gestoresAddr.v_must = "1";
				      	/*经办人证件号码*/
				      	document.all.gestoresIccId.v_must = "1";
					}
					
				}
    		}else{
    			rdShowMessageDialog("获取身份证位数错误["+objValue+"]");
    			reSetThis();
    		}
		}
		/*军官证 警官证 外国公民护照时 证件号码大于等于6位字符*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			var kongge = /^[^\s]+$/;
			var flag = kongge.test(objValue);
			if(!flag){
				rdShowMessageDialog(objName+"不含空格,TAB,回车键!");
				nextFlag = false;
				return false;
			}
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"必须大于等于六位字符！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为港澳通行证的，证件号码为9位或11位，并且首位为英文字母“H”或“M”(只可以是大写)，其余位均为阿拉伯数字。*/
		if(idTypeText == "3"){
			var kongge = /^[^\s]+$/;
			var flag = kongge.test(objValue);
			if(!flag){
				rdShowMessageDialog(objName+"不含空格,TAB,回车键!");
				nextFlag = false;
				return false;
			}
			
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
					rdShowMessageDialog(objName+"除首字母之外，其余位必须是阿拉伯数字!");
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
			var kongge = /^[^\s]+$/;
			var flag = kongge.test(objValue);
			var subStatus=0;
			var jieguoStr="";
			if(flag){
				if(objValue.indexOf("TW")==0){
					jieguoStr=objValue.substring(2);
					var zifu = /^[A-Z0-9\(\)]*$/;
					var zifuflag = zifu.test(jieguoStr);
					if(zifuflag){
						subStatus=2;//前2位“TW”或 “LXZH”字符，后面是阿拉伯数字、英文大写字母与半角“（）”的组合，这三种类型都要存在，且只有这三种类型的字符
					}
				}
				else if(objValue.indexOf("LXZH")==0){
					jieguoStr=objValue.substring(4);
					var zifu = /^[A-Z0-9\(\)]*$/;
					var zifuflag = zifu.test(jieguoStr);
					if(zifuflag){
						subStatus=2;//前2位“TW”或 “LXZH”字符，后面是阿拉伯数字、英文大写字母与半角“（）”的组合，这三种类型都要存在，且只有这三种类型的字符
					}
				}
				
				if(objValueLength == 11 || objValueLength == 12){
					jieguoStr=objValue.substring(0,10);
					if(jieguoStr % 2 != 0 && jieguoStr % 2 != 1){
					}
					else{
						subStatus=3;//证件号码为11-12位，前10位为阿拉伯数字；
					}
				}
				
				if(objValueLength == 8){
					if(objValue % 2 != 0 && objValue % 2 != 1){
					}
					else{
						subStatus=4;//证件号码为11-12位，前10位为阿拉伯数字；
					}
				}
			}
			else{
				subStatus=1;
			}
			if(subStatus==1){
				rdShowMessageDialog(objName+"不含空格,TAB,回车键!");
				return false;
			}
			else if(subStatus==0){
				rdShowMessageDialog("1.前2位“TW”或 “LXZH”字符，后面是阿拉伯数字、英文大写字母与半角“（）”的组合。<br/>2.证件号码为11-12位，前10位为阿拉伯数字。<br/>3.证件号码为8位时，均为阿拉伯数字。");
				return false;
			}
		}
		/*组织机构代 证件号码大于等于9位，为数字、“-”或大写拉丁字母*/
		if(idTypeText == "A"){
		 if(objValueLength != 10&&objValueLength != 18){
					rdShowMessageDialog(objName+"必须是10位或18位！");				
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
				    
			var m = /^[\u4E00-\u9FA5]*$/;
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
		 if(objValueLength != 12&&objValueLength != 18){
					rdShowMessageDialog(objName+"必须是12位或18位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u4E00-\u9FA5]*$/;
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
		/*调用原有逻辑*/
		//rpc_chkX16new('idType','idIccid','A');
	}else if(opCode == "1993"){
		//rpc_chkX16new('idType','idIccid','A');
	}
	return nextFlag;
}


function bijiao_month(be_date,cu_date){
	
	var cm_month_result = 0;
	
	var be_in_date = be_date;
	var cu_in_date = cu_date;
	
	var be_year_date  = be_in_date.substring(0,4);
	var be_month_date = be_in_date.substring(4,6);
	
	while(be_in_date!=cu_in_date){
			var tempMonth = Number(be_month_date);
			tempMonth = tempMonth + 1;
			
			if(tempMonth<10){
					be_month_date = "0" + tempMonth;
			}else if(tempMonth>12){
					be_month_date = "01";
					be_year_date = Number(be_year_date) + 1;
			}else{
					be_month_date = "" + tempMonth;
			}
			
			be_in_date = be_year_date + be_month_date;
			cm_month_result ++ ;
	}
	return cm_month_result;
}


function forJuHao(obj){
	var m = /^[\.\．\·\u2022\u25aa]*$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}

function forJuHao2(obj){
	var m = /^[\·\u2022\u25aa]*$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}

function checkNameStr16New(code){
	/* gaopeng 2014/01/17 9:50:35 优先匹配括号 因为括号可能是中文也可能是英文，优先返回KH 保证逻辑不失误*/
		if(forEnKuoHao16New(code)) return "KH";//括号
    if(forA2sssz116New(code)) return "EH"; //英语
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
    if(forHanZi116New(code)) return "CH"; //汉字
    if(forShuzi16New(code)) return "SZ"; //数字
    

}
function checkNameStr16New2(code){
	/* gaopeng 2014/01/17 9:50:35 优先匹配括号 因为括号可能是中文也可能是英文，优先返回KH 保证逻辑不失误*/
		if(forKuoHao16New(code)) return "KH";//括号
    if(forA2sssz116New(code)) return "EH"; //英语
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
    if(forHanZi116New(code)) return "CH"; //汉字
    if(forShuzi16New(code)) return "SZ"; //数字
    

}
function forEnKuoHao16New(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forKuoHao16New(obj){ //允许输入括号·.． 这几种副号
	var m = /^[\(\)\（\）\·\.\．]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
//匹配由26个英文字母组成的字符串
function forA2sssz116New(obj)
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
function forHanZi116New(obj)
{
	var m = /^[\u4E00-\u9FA5]+$/;
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
function forShuzi16New(obj)
{
	var m = /^[0-9]+$/;
	var flag = m.test(obj);
	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}

</SCRIPT>	
