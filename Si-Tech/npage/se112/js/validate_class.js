/*
 *
 *
 */
var errFlag=0;
var errMsg = {
    required: {
        msg: "必填选项!",
        test: function(obj) {
            return obj.value.length > 0;
        }
    },
    urlDomain: {
        msg: "域名不合法",
        test: function(obj) {
            return !obj.value || /^[^@-]+\.com(\.cn)?$/.test(obj.value);
        }
    },
    commonDomain: {
        msg: "域名不合法",
        test: function(obj) {
            return !obj.value || /(^[A-Za-z0-9\u4e00-\u9fa5]+)((\-([A-Za-z0-9\u4e00-\u9fa5]+))?)(\.([A-Za-z0-9\u4e00-\u9fa5]+)((\-([A-Za-z0-9\u4e00-\u9fa5]+))?))+$/.test(obj.value);
        }
    },
    wapDomian: {
    	msg: "WAP域名不合法",
    	test: function(obj) {
            return !obj.value || /^([A-Za-z0-9])+\.?([A-Za-z0-9])+$/.test(obj.value);
        }
    },
    mastId:{
    	msg: "masId不合法",
      test: function(obj) {
            return !obj.value || /^M.{2}AH.{9}$/.test(obj.value);
    	}
    },
    masStandard:
    {
    	msg: "MAS标准代码不合法",
      test: function(obj) {
            return !obj.value || /^MAH\d{7}$/.test(obj.value);
    	}
    }, 
    mas06Standard:
    {
    	msg: "MAS标准代码不合法",
      test: function(obj) {
            return !obj.value || /^M06AH\d{9}$/.test(obj.value);
    	}
    }, 
    lineSpeed:
    {
    	msg: "带宽不合法",
      test: function(obj) {
            return !obj.value || /^[2468]$|^[1-9][02468]$|^1[0-4][02468]|^15[024]$/.test(obj.value);
    	}
    },
    scale:
    {
    	msg: "比例输入不合法",
      test: function(obj) {
          var objArr=obj.value.split(":");
          if(objArr.length==2 && parseInt(objArr[0])+parseInt(objArr[1])==100)
          {
            return !obj.value || /^([0-9]|[1-9][0-9]):([0-9]|[1-9][0-9])$/.test(obj.value);
          }else
          {
          	return false; 
          }
    	}
    },
    HHmm:{
    		msg:"时间格式为HHmm",
    		test: function(obj) {
            return !obj.value || /^([0-1][0-9]|[2][0-3])[0-5][0-9]$/.test(obj.value);
        	}
    },
    shortNo:{
    		msg:"短号格式以61-69开头",
    		test: function(obj) {
            return !obj.value || /^[6][1-9]\d{4}$/.test(obj.value);
        	}
    },
    email: {
        msg: "邮件地址不合法",
        test: function(obj) {
            return !obj.value || /^[a-z0-9_+.-]+\@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/.test(obj.value);
        }
    },
    dateFormat: {
        msg: "日期格式MM/DD/YYYY",
        test: function(obj) {
            return !obj.value || /^\d{2}\/\d{2}\/\d{2,4}$/.test(obj.value);
            //格式是MM/DD/YYYY	
        }
    },
    url: {
        msg: "网址不合法。",
        test: function(obj) {
            return !obj.value || /^(http|https|ftp):\/\/([a-z0-9-]+\.)+[a-z0-9]{2,4}.*$/.test(obj.value);
        }
    },
    forMoney:{//vflag = 0 不能为负数,vflag = -1 不能为正数
    	msg:["输入格式有误！", "金额不能为负数！", "金额不能为正数！"],
    	test:function(obj){
    		if(!obj.value) return true;
				var num = obj.value;
				var flag=obj.vflag;
				if(flag==null) flag=0;
				num.toString().replace(/\$|\,/g,'');
			
			
				if(isNaN(num))
				{
					return 0;
				}
			
				if(flag==0&&num<0)   // vflag = 0 不能为负数
				{
					return 1;
				}
				if(flag==-1&&num>0)  //vflag = -1 不能为正数
				{
					return 2;
				}
				obj.value=formatAsMoney(num);
				return true;
			//格式化金额
				function formatAsMoney(mnt) {
				    mnt -= 0;
				    mnt = (Math.round(mnt*100))/100;
				    return (mnt == Math.floor(mnt)) ? mnt + '.00'
				              : ( (mnt*10 == Math.floor(mnt*10)) ?
				                       mnt + '0' : mnt);
				}
			}
		},
    idCard: {
        msg: ["号码位数不对", "号码出生日期错误或含有非法字符", "号码校验错误", "地区非法"],
        test: function(obj) {
        		
            var idcard, Y, JYM;
            var S, M;
            var   aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"***",71:"台湾",81:"香港",82:"澳门",91:"国外 ",99:"信息保护 "}  
            idcard=obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
            if(!idcard) return true;
            if(aCity[parseInt(idcard.substr(0,2))]==null) return 3;
	    	var idcard_array = new Array();
            idcard_array = idcard.split("");
            switch (idcard.length) {
            		case 0:
            			return true;
            			break;
                case 15:
                		var Ai=idcard.slice(0,6)+"19"+idcard.slice(6,16);
                    if (!/^\d+$/.test(Ai))  return 1;
    								var yyyy=Ai.slice(6,10) ,  mm=Ai.slice(10,12)-1  ,  dd=Ai.slice(12,14);
    								var d=new Date(yyyy,mm,dd) ,  now=new Date();
    								var year=d.getFullYear() ,  mon=d.getMonth() , day=d.getDate();
    								if (year!=yyyy || mon!=mm || day!=dd || d>now ) return 1;
    								return true;
                    break;
                case 18:
                    //18位身份号码检测
                    //出生日期的合法性检查
                    //闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))
                    //平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))
                    if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                        ereg = /^[1-9][0-9]{5}[12]\d[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式
                    }
                    else {
                        ereg = /^[1-9][0-9]{5}[12]\d[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式
                    }
                    if (ereg.test(idcard)) {
                        //测试出生日期的合法性
                        //计算校验位
                        S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
											    + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
											    + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
											    + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
											    + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
											    + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
											    + (parseInt(idcard_array[6])  + parseInt(idcard_array[16])) * 2
											    + parseInt(idcard_array[7]) * 1
											    + parseInt(idcard_array[8]) * 6
											    + parseInt(idcard_array[9]) * 3;
                        Y = S % 11;
                        M = "F";
                        JYM = "10X98765432";
                        M = JYM.substr(Y, 1); //判断校验位
                        if (idcard_array[17] == 'x')
                            idcard_array[17] = 'X';
                        if(parseInt(idcard.substr(0, 2)) == 99 ){ //为保护客户信息的安全，营业测试时将客户证件号码前两位刷为"99",即"99"开头的证件号码不再验证校验位,上线时需将此处删除
                    				return true;
                    		}else if (M == idcard_array[17]) {
	                            	return true; //检测ID的校验位
	                        		}else {
	                            	return 2;
	                        		}
                    }
                    else {
                        return 1;
                    }
                    break;
                default:
                    return 0;
            }

        }
    },
	c_idCard: {
        msg: ["号码位数不对", "号码出生日期错误或含有非法字符"],
        test: function(obj) {	
            idcard=obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
	    	var idcard_array = new Array();
            idcard_array = idcard.split("");
            switch (idcard.length) {
            	case 0:
            			return true;
            			break;
                case 15:
                		var Ai=idcard.slice(0,6)+"19"+idcard.slice(6,16);
                    	if (!/^\d+$/.test(Ai))  return 1;
						var yyyy=Ai.slice(6,10) ,  mm=Ai.slice(10,12)-1  ,  dd=Ai.slice(12,14);
						var d=new Date(yyyy,mm,dd) ,  now=new Date();
						var year=d.getFullYear() ,  mon=d.getMonth() , day=d.getDate();
						if (year!=yyyy || mon!=mm || day!=dd || d>now ) return 1;
						return true;
                    break;
                case 18:
                    //18位身份号码检测
                    //出生日期的合法性检查
                    //闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))
                    //平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))
                    if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                        ereg = /^[1-9][0-9]{5}[12]\d[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式
                    }
                    else {
                        ereg = /^[1-9][0-9]{5}[12]\d[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式
                    }
                    if (ereg.test(idcard)) {
                        //测试出生日期的合法性
                        return true;
                    }else
                    	return 1;
                    break;
                default:
                    return 0;
            }

        }
    },
    upLetter: {
        msg: "必须为大写英文字母",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[A-Z]+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                //obj.select();
                return false;
            }
            return true;
        }
    },
    lowLetter: {
        msg: "必须为小写英文字母",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[a-z]+$/
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    allLetter: {
        msg: "必须为英文",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[A-Za-z]+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    numOrLetter: {
        msg: "必须为英文或数字",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[A-Za-z0-9]+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
     numAndLetter:{
	  	 msg: "必须为数字和字母的混合",
	      test: function(obj) {
	      		if(!obj.value) return true;
	          var sInput = obj.value;
	          if (sInput&&(!(/^([a-zA-Z]|[0-9]){0,}$/.test(sInput)&&/[a-zA-Z]{1}/.test(sInput)&&/\d{1}/.test(sInput)))) {
                return false;
            }
	          return true;
	      }
  	
  	},
    numLetterChinese: {
        msg: "必须为英文,数字或汉字",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[A-Za-z0-9\u4e00-\u9fa5]+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    postCode: {
        msg: "邮政编码格式错误",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[0-9]{1}(\d){5}$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    commonPhone: {//校验普通电话、传真号码：可以“+”开头，除数字外，可含有“-”
        msg: "电话号码格式错误",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[+]{0,1}((0(\d{2}))?([-]{0,1})([1-9]\d{7})|(0(\d{3}))?([-]{0,1})([1-9]\d{6,7}))$/;
            var sInput = obj.value;
            if (obj.value && sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    andCellphone: {//校验手机、固话、传真号码：可以“+”开头，除数字外，可含有“-”
        msg: "电话号码格式错误",
        test: function(obj) {
        		if(!obj.value) return true;
           	var patrn = /^[+]{0,1}(\d{3,4})?([-]{0,1})?(\d{7,8})$/;
           	//var patrn = /^[+]{0,1}(\d{3,4})([-])?(\d{7,8})$/;   //不能限制长度，故修改为上面
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    cellPhone: {//服务号码
        msg: "服务号码格式错误",
        test: function(obj) {
        	 if(!obj.value) return true;
        	 var patrn=/^[^\u4e00-\u9fa5]{0,}$/;
          // var patrn = /^((\(\d{3}\))|(\d{3}\-))?[12][0358]\d{9}$/;
           // var patrn = /^1[358][39]\d{8}$/;//电信
          //var patrn = /^1[35][0126]\d{8}$/;//联通
          //var patrn = /^1[358][4-9]\d{8}$/;//移动
            var sInput = obj.value;
            if (sInput.search(patrn)==-1) {
                return false;
            }
            return true;
        }
    },
    allCellPhone:{//原手机号码验证
    	 msg: "手机号码格式错误",
        test: function(obj) {
        	if(!obj.value) return true;
          var patrn = /^((\(\d{3}\))|(\d{3}\-))?[12][0358]\d{9}$/;
           // var patrn = /^1[358][39]\d{8}$/;//电信
          //var patrn = /^1[35][0126]\d{8}$/;//联通
          //var patrn = /^1[358][4-9]\d{8}$/;//移动
            var sInput = obj.value;
            if (sInput.search(patrn)==-1) {
                return false;
            }
            return true;
        }
    	},
    forTelecom: {//电信
        msg: "不是电信手机号码",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^1[358][39]\d{8}$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    forUnicom: {//联通
        msg: "不是联通手机号码",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^1[35][0126]\d{8}$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    forMobile: {//移动
        msg: "不是移动手机号码",
        test: function(obj) {
        		if(!obj.value) return true;
           // var patrn = /^1[358][4-9]\d{8}$/;         
            //var patrn = /^1(3[4-9]|47|5[012789]|8[7-8])\d{8}$/;
            var patrn = /^\d{11}$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    ipAddress: {
        msg: "IP地址错误",
        test: function(obj) {
        		if(!obj.value) return true;
            //var pattern = /^(\d{1,2}|1\d\d|1\d?\*|2[0-4][\d*]|2\*|25[0-5]|25\*)(\.(\d{1,2}|1\d\d|1\d?\*|2[0-4][\d*]|2\*|25[0-5]|25\*)){3}$/;
             var pattern = /^([1-9]|[1-9]\d|(1[0-1|3-9]\d|12[0-6|8-9]|2[0-4][0-7]))(\.(\d|[1-9]\d|(1\d{2}|2([0-4]\d|5[0-5])))){3}$/;
            var sInput = obj.value;
            if (sInput.search(pattern) == -1) {
                return false;
            }
            return true;
        }
    },
    num_letter: {
        msg: "必须为数字,英文和下划线",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^\w+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    isSizeOf: {//需要自定义属性v_maxlength,v_minlength
        msg: ["数值大小不在指定范围内","必须为数字"],
        test: function(obj) {
        		if(!obj.value) return true;
            var maxval = parseFloat(obj.v_maxlength);
            var minval = parseFloat(obj.v_minlength);
            //var selval = parseFloat(obj.value);
            if (isNaN(obj.value)) {
                return 1;
            }else{
            	var selval = parseFloat(obj.value);
            }
						var flag = obj.v_flag;
						if(typeof(flag) == "undefined" || flag == "")	flag = "TT" ;
						var lflag = flag.substring(0,1);//flag.split("|")[0];
						var rflag = flag.substring(1,2);//flag.split("|")[1];
			
            if (!isNaN(maxval)) {
            	if(rflag == "T"){
	                if (selval > maxval) {
	                    return 0;
	                }
              }else{
	              	if (selval >= maxval) {
	                    return 0;	
	              	}
            	}
            }
            
            if (!isNaN(minval)) {
	           	if(lflag == "T"){
	                if (selval < minval) {
	                    return 0;
	                }
	           	}else {
	           		if (selval <= minval) {
	                   	return 0;
	               	}	
	           	}
         	}	
            return true;
        }
    },
     isDigLengthOf:{//数值的位数,需要自定义属性v_maxlength,v_minlength
    	 		msg: ["数值位数不在指定范围内","必须为数字"],
        	test: function(obj) {
        			if(!obj.value) return true;
        			var maxlen = parseFloat(obj.v_maxlength);
	            var minlen = parseFloat(obj.v_minlength);
	            var reg = new RegExp("\\s","gi");
	            var val=obj.value.replace(reg, "");
	
	            if (isNaN(obj.value)&&obj.value!="") {
	                return 1;
	            }
	            if (!isNaN(maxlen)) {
	                if ((val+"").length > maxlen) {
	                    return 0;
	                }
	            }
	            if (!isNaN(minlen)) {
	                if ((val+"").length < minlen) {
	                    return 0;
	                }
	            }
	            return true;
	        }
    	},
    isLengthOf: {//需要自定义属性v_maxlength,v_minlength
        msg: "长度不在指定范围内",
        test: function(obj) {
        		if(!obj.value) return true;
            var maxlen = parseFloat(obj.v_maxlength);
            var minlen = parseFloat(obj.v_minlength);
            var val=obj.value.replace(/(^\s*)|(\s*$)/g, "");
            if (!isNaN(maxlen)) {
                if ((val+"").length > maxlen) {
                    return false;
                }
            }
            if (!isNaN(minlen)) {
                if ((val+"").length < minlen) {
                    return false;
                }
            }
            return true;
        }
    },
     byteSize:{
        msg:"输入内容的字节长度不符",
        test:function(obj){
            if(!obj.value) return true;
            var maxlen = parseFloat(obj.v_maxlength);
            var minlen = parseFloat(obj.v_minlength);
            var val=obj.value.replace(/(^\s*)|(\s*$)/g, "");
            var cArr = val.match(/[^\x00-\xff]/ig);  
            var byteLen=val.length + (cArr == null ? 0 : cArr.length);  
             if (!isNaN(maxlen)) {
                if (byteLen > maxlen) {
                    return false;
                }
            }
            if (!isNaN(minlen)) {
                if (byteLen < minlen) {
                    return false;
                }
            }
            return true;
        }
    },
    samePW:{
        msg:"密码不一致，请重新输入",
        test:function(obj)
        {
        	var pw = document.getElementById(obj.v_pw);
    		var confirmPw = document.getElementById(obj.v_confirmPw);
    		if(pw.value!=""&&confirmPw.value!=""&&pw.value != confirmPw.value){
    			return false;
    		}else if(pw.value!=""&&confirmPw.value!=""&&pw.value==confirmPw.value){
    			if(pw.parentNode&&pw.parentNode.errstate)
                {
                    hideErrors(pw);
                    pw.parentNode.removeAttribute("errstate");
                } 
                if(confirmPw.parentNode&&confirmPw.parentNode.errstate)
                {
                    hideErrors(confirmPw);
                    confirmPw.parentNode.removeAttribute("errstate");
                } 
                return true;
    		}
    		return true; 
        }
    },
    posInt: {
        msg: "请输入正整数",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[0-9]*[1-9][0-9]*$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    forInt: {
        msg: "必须为整数",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^-?\d+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    nonNegInt: {
        msg: "必须为非负整数",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^\d+$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    negInt: {
        msg: "必须为负整数！",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^-[0-9]*[1-9][0-9]*$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    notNegReal: {
        msg: "必须为非负实数！",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^[0-9]+((\.{1}?[0-9]{1,13})|(\.{0}?[0-9]{0}))?$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    forReal: {
        msg: "必须为实数！",
        test: function(obj) {
        		if(!obj.value) return true;
            var patrn = /^([-]{0,1})?[0-9]+((\.{1}?[0-9]{1,13})|(\.{0}?[0-9]{0}))?$/;
            var sInput = obj.value;
            if (sInput.search(patrn) == -1) {
                return false;
            }
            return true;
        }
    },
    uploadFile: {//验证上传文件格式，需要自定义属性v_upType
        msg: ["请选择要上传的文件！", "请上传后缀名正确的文件"],
        test: function(obj) {
        		if(!obj.value) return true;
            var fileName = obj.value.replace(/^\s*/, "").replace(/\s*$/, "");
            if (fileName == "") {
                return 0;
            }
            else {
                var pos = fileName.lastIndexOf(".");
                if (pos != -1) {
                    var suf = fileName.substring(pos + 1, fileName.length).toLowerCase();
                    var upType = obj.v_upType.split(",");
                    for (var i = 0; i < upType.length; i++) {
                        if (upType[i] == suf) {
                            return true;
                        }
                    }
                };
                return 1;
            }
            return true;
        }
    },
     compareDate : {
    	msg : "结束日期比开始日期早",
    	test : function(obj){
    		var frontDate = document.getElementById(obj.v_extB);
    		var behindDate = document.getElementById(obj.v_extE);
    		if(frontDate.value!=""&&behindDate.value!=""&&frontDate.value > behindDate.value){
    			return false;
    		}else if(frontDate.value!=""&&behindDate.value!=""&&frontDate.value<behindDate.value){
    			if(frontDate.parentNode&&frontDate.parentNode.errstate)
                {
                    hideErrors(frontDate);
                    frontDate.parentNode.removeAttribute("errstate");
                } 
                if(behindDate.parentNode&&behindDate.parentNode.errstate)
                {
                    hideErrors(behindDate);
                    behindDate.parentNode.removeAttribute("errstate");
                } 
                return true;
    		}
    		return true;
    	}
    },
    yyyy:{//yyyy
    	msg:"日期格式为yyyy",
    	test:function(obj){
    			if(!obj.value) return true;
    			if(getDateFromFormat(obj.value,"yyyy")==0)
    					return false;
    			return true;
    		} 	
    	},
    HHmmss:{//HHmmss
    	msg:"日期格式为HHmmss",
    	test:function(obj){
    			if(!obj.value) return true;
    			if(getDateFromFormat(obj.value,"HHmmss")==0)
    					return false;
    			return true;
    		} 	
    	},
    yyyyMMddHHmmss:{//yyyyMMddHHmmss
    	msg:"日期格式为yyyyMMddHHmmss",
    	test:function(obj){
    			if(!obj.value) return true;
    			if(getDateFromFormat(obj.value,"yyyyMMddHHmmss")==0)
    					return false;
    			return true;
    		} 	
    	},
  	speyyyyMMddHHmmss:{//yyyyMMddHHmmss
  	msg:"日期格式为yyyyMMdd HH:mm:ss",
  	test:function(obj){
  			if(getDateFromFormat(obj.value,"yyyyMMdd HH:mm:ss")==0)
  					return false;
  			return true;
  		} 	
  	},
    MM:{//MM
    	msg:"日期格式为MM",
    	test:function(obj){
    			if(!obj.value) return true;
    			if(getDateFromFormat(obj.value,"MM")==0)
    					return false;
    			return true;
    		} 	
    	},
    dd:{//dd
    	msg:"日期格式为dd",
    	test:function(obj){
    			if(!obj.value) return true;
    			if(getDateFromFormat(obj.value,"dd")==0)
    					return false;
    			return true;
    		} 	
    	},
  	yyyyMMdd:{
  		msg:"日期格式为yyyyMMdd",
  		test:function(obj){
  			if(!obj.value) return true;
  			if(getDateFromFormat(obj.value,"yyyyMMdd")==0)
  					return false;
  			return true;
  		} 	
  	},
  	yyyyMM:{
  		msg:"日期格式为yyyyMM",
  		test:function(obj){
  			if(!obj.value) return true;
  			if(getDateFromFormat(obj.value,"yyyyMM")==0)
  					return false;
  			return true;
  		} 		
  	},
  	yyyyMMddHH:{
  		msg:"日期格式为yyyyMMddHH",
  		test:function(obj){
  			if(!obj.value) return true;
  			if(getDateFromFormat(obj.value,"yyyyMMddHH")==0)
  					return false;
  			return true;
  		}	
  	},
  	"lineyyyyMMdd":{
  		msg:"日期格式为yyyy-MM-dd",
  		test:function(obj){
  			if(!obj.value) return true;
  			if(getDateFromFormat(obj.value,"yyyy-MM-dd")==0)
  					return false;
  			return true;
  		}	
  	},
  	"ColonHHmmss":{
  		msg:"日期格式为HH:mm:ss",
  		test:function(obj){
  			if(!obj.value) return true;
  			if(getDateFromFormat(obj.value,"HH:mm:ss")==0)
  					return false;
  			return true;
  		}	
  	},
  	"lineyyyyMMddHHmmss":{
  		msg:"格式为yyyy-MM-dd HH:mm:ss",
  		test:function(obj){
  			if(!obj.value) return true;
  			if(getDateFromFormat(obj.value,"yyyy-MM-dd HH:mm:ss")==0)
  					return false;
  			return true;
  		}	
  	},
  	moneyFormat:{
  		msg:"必须为带0到2位小数的数值",
  		test:function(obj){
				var objValue=obj.value;
  			if(!objValue) return true;
				if(isNaN(objValue)) return false;
  			var mArr=(objValue+"").split(".");
				if(mArr.length>1){
						if(mArr[1].length==0||mArr[1].length>2) return false;
					}
  			return true;

  		}	

  	},
  	multiMoneyFormat:{
  		msg:["必须为小数","小数点后位数不对"],
  		test:function(obj){
				var objValue=obj.value;
				var decNum = obj.v_decNum;
	  		if(!objValue) return true;
				if(isNaN(objValue)) return 0;
				if(objValue.indexOf("\.")==-1) return 0;
	  		var mArr=(objValue+"").split(".");
				if(mArr.length>1){
							if(mArr[1].length!=decNum) return 1;
						}
	  			return true;
	  		}	
  	},
  	haveSpe:{
			msg:"不能输入\\ / < > \' \" & #等字符",
			test:function(obj)
			{
				if(!obj.value) return true;
				return haveSpe(obj.value);
				function haveSpe(str)
				{
				  var comp="\\/><\'\"&#";
				  var aChar="";
				  for(var i=0;i<str.length;i++)
				  {
					aChar=str.charAt(i);  
					if(comp.indexOf(aChar)!=-1)
						return false;
				  }
				  return true;
				}
			}
		},
		haveSpeForAll:{   //对所有的文本框进行限制
			msg:"不能输入\\ < > \' \" & #等字符",
			test:function(obj)
			{
				if(!obj.value) return true;
				return haveSpe(obj.value);
				function haveSpe(str)
				{
				  var comp="\\><\'\"&#";
				  var aChar="";
				  for(var i=0;i<str.length;i++)
				  {
					aChar=str.charAt(i);  
					if(comp.indexOf(aChar)!=-1)
						return false;
				  }
				  return true;
				}
			}
		},
	for0_9:{
		msg:"必须由数字组成",
		test:function(obj)
			{
				if(!obj.value) return true;
				var numStr="0123456789";
				if(obj.value.length==0)
					return false;
				if (!isMadeOf(obj.value,numStr))
					return false;
				return true;
				function isMadeOf(val,str)
				{
				
					var jj;
					var chr;
					for (jj=0;jj<val.length;++jj){
						chr=val.charAt(jj);
						if (str.indexOf(chr,0)==-1)
							return false;			
					}
					
					return true;
				}
			}
		},
	isServ:{
 		msg:"不符合服务名称格式",
 		test: function(obj) {
        if(!obj.value) return true;
 				var patrn=/^[s]{1}([0-9]|[a-zA-Z]){0,}$/;
 				var sInput=obj.value;
 				if(!patrn.exec(sInput)) return false;
 				return true;
 		}
 	}
		
}
	function hideErrors(elem) {
	    var next_node = elem.parentNode.lastChild;
	    if (next_node && next_node.className == "error_css")
	    {
	        elem.parentNode.removeChild(next_node);
	       // errFlag--;
	     }
	}
	function showErrors(elem, errors) {
		var next_node = elem.parentNode.lastChild;
	    if (!next_node||next_node.className != "error_css") {
	        next_node = document.createElement("span");
	        next_node.className = "error_css";
	        elem.parentNode.appendChild(next_node);
	    }
	    next_node.innerHTML = errors;
	    errFlag++;
	}
	function validateField(elem) {
	    for (var name in errMsg) {
	        var re = new RegExp("(^|\\s)" + name + "(\\s|$)");
	        if (re.test(elem.className)) {
	            var state = errMsg[name].test(elem);
	            if (typeof errMsg[name].msg == 'string' && !state) {
	            		if(elem.id!=""){elem.parentNode.errstate=elem.id}
	            		else{elem.id=(new Date).getTime();elem.parentNode.errstate=elem.id}
	                showErrors(elem, errMsg[name].msg);
	                break;
	            }
	            else if ((errMsg[name].msg.constructor === Array) && (state !== true)) {
	            		if(elem.id!=""){elem.parentNode.errstate=elem.id}
	            		else{elem.id=(new Date).getTime();elem.parentNode.errstate=elem.id}
	                showErrors(elem, errMsg[name].msg[state]);
	                break;
	            }
	            else {
	            		if(elem.parentNode&&elem.parentNode.errstate&&(elem.id==elem.parentNode.errstate||!document.getElementById(elem.parentNode.errstate)||document.getElementById(elem.parentNode.errstate).style.display=='none'||document.getElementById(elem.parentNode.errstate).style.visibility=='hidden'))
	            		{
	                	hideErrors(elem);
	                	elem.parentNode.removeAttribute("errstate");
	              }
	            };
	        }
	    }
	}
	function validateElement(elem) {
	    for (var name in errMsg) {
	        var re = new RegExp("(^|\\s)" + name + "(\\s|$)");
	        if (re.test(elem.className)) {
	            var state = errMsg[name].test(elem);
	            if (typeof errMsg[name].msg == 'string' && !state) {
	            		if(elem.id!=""){elem.parentNode.errstate=elem.id}
	            		else{elem.id=(new Date).getTime();elem.parentNode.errstate=elem.id}
	                showErrors(elem, errMsg[name].msg);
	                return false;
	            }
	            else if ((errMsg[name].msg.constructor === Array) && (state !== true)) {
	            		if(elem.id!=""){elem.parentNode.errstate=elem.id}
	            		else{elem.id=(new Date).getTime();elem.parentNode.errstate=elem.id}
	                showErrors(elem, errMsg[name].msg[state]);
	                return false;  
	            }
	            else {
	            		if(elem.parentNode&&elem.parentNode.errstate&&elem.id==elem.parentNode.errstate)
	            		{
	                	hideErrors(elem);
	                	elem.parentNode.removeAttribute("errstate");
	              }
	            };
	        }
	    }
	    return true;
	}
	$(document).ready(function () {
	    var forms = document.getElementsByTagName("form");
	    for (var j = 0;j < forms.length;j++){
		    for (var i = 0; i < forms[j].elements.length; i++) {
		        //并绑定'change'事件函数
		       /* addEvent(forms[j].elements[i], 'blur', function() {
		            validateField(this);
		        });*/
		       $(forms[j].elements[i]).bind("blur",function(){validateField(this);});
		    }
	  }
	  		//为所有文本框添加特殊字符校验，
		  var inputs = document.getElementsByTagName("input");
			for(var i=0;i<inputs.length;i++){
				if(inputs[i].type=="text"){
					addClass(inputs[i],"haveSpeForAll");
				}
			}
	});
	function checkAll(form){
	    for (var i = 0; i < form.elements.length; i++) {
	    	var v_element=form.elements[i];
	    	var v_display=0;
	    	while(v_element.parentNode&&v_element.parentNode.tagName!="FORM"&&v_element.parentNode.id!="operation_table")
	    	{
	    		if(v_element.parentNode.style.display=="none"||v_element.style.display=="none"||v_element.type=="hidden"||v_element.parentNode.style.visibility=="hidden"||v_element.style.visibility=="hidden")
		    		{
			    		v_display++;
			    	}
			    v_element=v_element.parentNode;
	      }
	      if(v_display!=0&&form.elements[i].parentNode.errstate&&(form.elements[i].parentNode.errstate==form.elements[i].id)){
	      						hideErrors(form.elements[i]);
	                	form.elements[i].parentNode.removeAttribute("errstate");
	      	
	      	}
			 	if(form.elements[i].disabled==false&&v_display==0)
				 	{
						 validateField(form.elements[i]);
					}
				else
					{
						//hideErrors(form.elements[i]);
					}
	    }
	    if($(".error_css")[0]){
	    	var preObj=$(".error_css")[0].previousSibling;
				while(preObj&&preObj.nodeType!=1){
				 	preObj=preObj.previousSibling;
				}
		    //preObj.focus();
		    //焦点定位到第一个校验未通过的元素上
		    if(preObj&&(preObj.type=="text"||preObj.type=="textarea")){
						preObj.focus();
					}else{
						try{
								preObj.focus();
							}catch(e){}
					}
		  }
	}
	
	function checksubmit(form_01){
		errFlag=0;
	    checkAll(form_01);
	    if(errFlag) 
	    {
	    	return false;
	  	}
	  	else
			{
				return true;
			}
	}
	function getDateFromFormat(val,format) 
	 {
	 	if(val=="") return 1;
		val=val+"";
		format=format+"";
		var i_val=0;
		var i_format=0;
		var c="";
		var token="";
		var token2="";
		var x,y;
		var now=new Date();
		var year=now.getYear();
		var month=now.getMonth()+1;
		var date=1;
		var hh=now.getHours();
		var mm=now.getMinutes();
		var ss=now.getSeconds();
	 
		while (i_format < format.length) 
		{
			// Get next token from format string
			c=format.charAt(i_format);
			token="";
			while ((format.charAt(i_format)==c) && (i_format < format.length)) {
				token += format.charAt(i_format++);
				}
			// Extract contents of value based on format token
			if (token=="yyyy" ) 
			{
				 x=4;y=4; 
				 year=getInt(val,i_val,x,y);
				 if (year==null) { return 0; }
				 i_val += year.length;
				 
			}
			else if (token=="MM") 
			{
				month=getInt(val,i_val,token.length,2);
				if(month==null||(month<1)||(month>12)){return 0;}
				i_val+=month.length;
			}
			else if (token=="dd") 
			{
				date=getInt(val,i_val,token.length,2);
				if(date==null||(date<1)||(date>31)){return 0;}
				i_val+=date.length;
			}
	 
			else if (token=="HH")
			{
				hh=getInt(val,i_val,token.length,2);
				if(hh==null||(hh<0)||(hh>23)){return 0;}
				i_val+=hh.length;
			}
			else if (token=="mm") 
			{
				mm=getInt(val,i_val,token.length,2);
				if(mm==null||(mm<0)||(mm>59)){return 0;}
				i_val+=mm.length;
			}
			else if (token=="ss") 
			{
				ss=getInt(val,i_val,token.length,2);
				if(ss==null||(ss<0)||(ss>59)){return 0;}
				i_val+=ss.length;
			}
		 
			else 
			{
				if (val.substring(i_val,i_val+token.length)!=token) {return 0;}
				else {i_val+=token.length;}
			}
		}//while end
		// If there are any trailing characters left in the value, it doesn't match
		if (i_val != val.length) { return 0; }
		// Is date valid for month?
		if (month==2) 
		{
			// Check for leap year
			if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) 
			{ // leap year
				if (date > 29){ return 0; }
			}
			else { if (date > 28) { return 0; } }
		}
		if ((month==4)||(month==6)||(month==9)||(month==11)) 
		{
			if (date > 30) { return 0; }
		}
	 
		var newdate=new Date(year,month-1,date,hh,mm,ss);
		return newdate.getTime();
	}
	function getInt(str,i,minlength,maxlength)
	{
		for (var x=maxlength; x>=minlength; x--) {
			var token=str.substring(i,i+x);
			if (token.length < minlength) { return null; }
			if (isInteger(token)) { return token; }
			}
		return null;
	}
	function isInteger(val)
	{
		var digits="1234567890";
		for (var i=0; i < val.length; i++) {
			if (digits.indexOf(val.charAt(i))==-1)
			{ return false; }
		}
		return true;
	}
	
	function addClass(element,value){ //追加样式，而不是替换样式
	    var ename;
	    if (!element.className) {
	    	element.className = value;
	    	}else{
	    		var sname = element.className.split(" ");
	    		for(var i=0;i<sname.length;i++){
	    			if(sname[i].indexOf(value)==0){
	    				ename = sname[i];
	    			}	
	    		}
	    		if(!ename){
	    			element.className+= " ";
	      		element.className+= value;
	    		}
			}
	 }
	 
	 //当页面上文本框置灰不可用的时候，隐藏其置灰前的验证错误信息
	 function disabledError(elem){
	 		if(elem.parentNode.getAttribute("errstate")){
					 hideErrors(elem);
	         elem.parentNode.removeAttribute("errstate");
			}
 	}