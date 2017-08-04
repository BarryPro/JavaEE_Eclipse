<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    	//sale_type = 43
    	String printName = "变更幸福家庭成员";
    	
 		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String familyCode = request.getParameter("familyCode");
 		String printOpName = "";
 		/*gaopeng 区分宽带家庭和融合家庭的免填单打印头部展示。2014/01/15 16:46:18*/
 		if(familyCode.equals("KDJT")){
 			printOpName = "宽带家庭";
 		}else if(familyCode.equals("RHJT")){
 			printOpName = "融合家庭";
 		}
 		String familyName = request.getParameter("familyName");
 		String belongGroupId = request.getParameter("belongGroupId");
 		String parentPhone = request.getParameter("parentPhone");
 		String regionCode= (String)session.getAttribute("regCode");
 		String work_no = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
		String printAccept="";
		String[][] familyMemberList = new String[][]{};
		String prodCode = "";
		String create_accept = "";
		System.out.println("---liujian begin----");
%>
		<script>
			//初始化用户列表数组
			var initUserArr = new Array();
			
			/*
			 * 获得服务返回的数据，封装成一些列的js对象
			 * 用户对象
			 * @param {Object} famCode 家庭代码
			 * @param {Object} famName 家庭名称
			 * @param {Object} phone 手机号
			 * @param {Object} role 用户角色 
			 * @param {Object} beginTime 生效时间
			 * @param {Object} endTime 失效时间
			 * @param {Object} editSts 是否可编辑
			 */
			function InitUser(famCode,famName,phone,role,beginTime,endTime,editSts) {
				this.famCode = famCode;
				this.famName = famName;
				this.phone = phone;
				this.role = role;
				this.beginTime = beginTime;
				this.endTime = endTime;
				this.editSts = editSts;
			}	
		</script>
		
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq2"/>
<%
	printAccept = seq;
	create_accept = seq2;
	System.out.println("----liujian-----printAccept=" + printAccept);
%>
	<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
		retmsg="msg1" retcode="code1" outnum="12">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=parentPhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="3"/>
		<wtc:param value="<%=familyCode%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	System.out.println("========== liujian  ====" + code1 + " | " + result1.length);
	if("000000".equals(code1)){
		familyMemberList = result1;
		System.out.println("------------------liujian------------------result1.length=" + result1.length);
		for(int i = 0; i < familyMemberList.length; i++){
			if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
				}
%>
		<script>
			var famCode = '<%=familyCode%>';//家庭代码
			var famName = '<%=familyName%>';//家庭名称
			var phone = '<%=familyMemberList[i][3]%>';//手机号码
			var role = '<%=familyMemberList[i][2]%>';//角色名称
			var beginTime = '<%=familyMemberList[i][4]%>';//生效时间
			var endTime = '<%=familyMemberList[i][5]%>';//失效时间
			//可变更标识：0可；1不可
			var editSts = '<%=familyMemberList[i][11]%>';//编辑状态
			initUserArr.push(new InitUser(famCode,famName,phone,role,beginTime,endTime,editSts));
		</script>
<%			
		}
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code1%>" + "<%=msg1%>");
			window.location="fe280.jsp?activePhone=<%=parentPhone%>";
		</script>
<%
	}
%>	
<html>
<head>
	<title>家庭产品变更</title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
	<script language="javascript">
		//变更的用户列表数组
		var variedUserArr = new Array();
		var varySubmitBtnSts = -1;//0：两个密码都没验证通过；1：一个验证密码通过；2：两个验证密码通过
		var sourceSts = -1;//-1:正要验证密码，0：没有验证密码；1：验证密码
		var destSts = -1;//-1:正要验证密码，0：没有验证密码；1：验证密码
		var sourceOrDest = -1;//验证哪个手机号密码，0：source；1：dest
		/*
		 * 变更后的用户对象，之所以创建新的对象，便于实现删除和添加操作，而且便于获得变更结果
		 * @param {Object} phone 源手机号
		 * @param {Object} afterPhone 目标手机号
		 * @param {Object} exsitAfterPhone 目标用户是否是家庭成员 如果是则为true，否则为false
		 */
		function VariedUser(phone,afterPhone,exsitAfterPhone) {
			this.phone = phone;
			this.afterPhone = afterPhone;
		//	this.role = role;
			this.exsitAfterPhone = exsitAfterPhone;
		}
		
		/*
		 * 判断初始化用户数组中是否存在目标手机号码
		 * @param {Object} phone 手机号
		 */
		function judgePhoneExsit(phone) {
			return (initUserArr.indexOfByValue(phone,"phone") > -1) ;
		}
		
		/*
		 * 目标手机号码是否是已被变更的手机号码
		 * 1. 已被变更的家庭号码
		 * 2. 已被变更的新加号码
		 * 3. 不能变更的家庭号码
		 * 判断变更用户数组中(afterPhone)是否存在目标手机号码
		 * @param {Object} phone 手机号
		 */
		function judgeDestPhoneUsed(phone) {
			var f1 = variedUserArr.indexOfByValue(phone,'afterPhone') > -1 ;
			var f2 = variedUserArr.indexOfByValue(phone,'phone') > -1;
			var f3 = initUserArr.getElByValue(phone,'phone').editSts == '1';
			return f1 || f2 || f3;
			/*
			return variedUserArr.indexOfByValue(phone,"afterPhone") > -1 
				|| variedUserArr.indexOfByValue(phone,"phone") > -1
				|| initUserArr.getElByValue(phone).editSts == '1';
			*/
		}
		
		function judgeSourcePhoneVarid(phone) {
			return variedUserArr.indexOfByValue(phone,"phone") > -1;
		}
		
		/*
		 * Array新方法indexOfByValue
		 * 判断对象的name属性的val值，是否存在Array中
		 * @param {Object} val
		 * @param {Object} name
		 */
		Array.prototype.indexOfByValue = function(val,name) {
	        for (var i = 0; i < this.length; i++) {
	            if (this[i][name] == val) return i;
	        }
	        return -1;
	    };
		
		/*
		 * Array新方法removeElByValue
		 * 删除数组中的对象，该对象的name属性是val值
		 * @param {Object} val
		 * @param {Object} name
		 */
	    Array.prototype.removeElByValue = function(val,name) {
	        var index = this.indexOfByValue(val,name);
	        if (index > -1) {
	            this.splice(index, 1);
	        }
	    }; 
	    
	    /*
		 * Array新方法removeElsByValue
		 * 删除数组中的多个对象，该对象的name属性是val值
		 * @param {Object} val
		 * @param {Object} name
		 */
		Array.prototype.removeElsByValue = function(val,name) {
	        for (var i = 0; i < this.length; i++) {
	            if (this[i][name] == val)  {
	            	this.splice(i, 1);
	            	i--;
	            }
	        }
	    }; 
		/*
		 * Array新方法getElByValue
		 * 获得数组中的对象，该对象的name属性是val值
		 * @param {Object} val
		 * @param {Object} name
		 */
	    Array.prototype.getElByValue = function(val,name) {
	        for (var i = 0; i < this.length; i++) {
	            if (this[i][name] == val)  {
	            	return this[i];
	            }
	        }
	        return -1;
	    }; 
	   
		//点击“确定”后，暂存到次数
		var tempFamUserArray = new Array();
		//如果没有问题，则存进resultArr
		var resulFamUsertArr = new Array();
		/*
		 * business_id    规则ID
		 * exec_order      订购退订标识： 1订购； 3退订
		 * newofferid     资费代码
		 * busitype       产品类别
		 */
		 var offeriddd1="";
		 var offeriddd2="";
		 var cheoffersid="";
		function Busi(business_id,exec_order,newofferid,busitype) {
			this.business_id = business_id;
			this.exec_order = exec_order;
			this.newofferid = newofferid;
			this.busitype = busitype;
			//alert(business_id+"--"+exec_order+"--"+newofferid+"--"+busitype);
			if(busitype=="AO") {
				if(exec_order=="1") {
			if(cheoffersid=="") {
				offeriddd1 =newofferid;

			}
			if(cheoffersid !="" ) {
				offeriddd2 =newofferid;					
			}
			
			cheoffersid=newofferid;
			
		}
	}
		}
		
		/*
		 * length                规则个数
		 * businesses            规则对象数组
		 * phone_no_subordinate  手机号码
		 * family_role           角色code  M家长  O其他成员
		 * family_role_name      角色名称
		 * member_role_id        成员角色code 类似70001
		 * pay_type              付费方式  G 共享账户
		 */
		function FamUser(length,businesses,phone_no_subordinate,family_role,family_role_name,
					member_role_id,pay_type) {
			this.length = length;
			this.businesses = businesses;
			this.phone_no_subordinate = phone_no_subordinate;
			this.family_role = family_role;
			this.family_role_name = family_role_name;
			this.member_role_id = member_role_id;
			this.pay_type = pay_type;
		}
		
		/*
		 * 最后返给服务的对象，最后用于转成json串
		*/
		function FamUsers(length,famRoles,create_accept,chnsource,opCode,loginNo,password,phone_no_master,
				op_note,prod_code,family_code,pay_money,vary_source_phones,vary_dest_phones) {
			this.length = length;
			this.famRoles = famRoles;
			this.create_accept = create_accept;
			this.chnsource = chnsource;	
			this.opCode = opCode;
			this.loginNo = loginNo;				  	
			this.password = password;
			this.phone_no_master = phone_no_master;	
			this.op_note = op_note;
			this.prod_code = prod_code;	
			this.family_code = family_code;	
			this.pay_money = pay_money;
			this.vary_source_phones = vary_source_phones;				  	
			this.vary_dest_phones = vary_dest_phones;
		}
		
		$(function() {
			$('#opCode').val('<%=opCode%>');
			$('#opName').val('<%=opName%>');
			$('#parentPhone').val('<%=parentPhone%>');
			setvarySubmitBtnDisabled();
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			
			var prodCode = "<%=prodCode%>";
			$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
			$("#familyProdInfo").attr("disabled","true");
			
			initRoleTbodyRefrech();
			
			//变更按钮确定
			$('#varySubmitBtn').click(function() {
				//可以修改源手机号码的问题
				var sourcePhone = $('#sourcePhone').val();
				var destPhone = $('#destPhone').val();
				if(checkPhone(sourcePhone,destPhone)) {
					//1.判断目标手机号码是否是初始化成员中含有的手机号码
					var _flag = judgePhoneExsit(destPhone);
					if(_flag) {
						 //2.1 如果存在则设置源手机号和目标手机号不能再次变更;
						 //	  添加一个变更对象，exsitAfterPhone=true;
						 //    “已变更角色区”添加一条记录
						$('#initRoleTbody').find('input[id="' + sourcePhone + '"]').attr('disabled',true)
						$('#initRoleTbody').find('input[id="' + destPhone + '"]').attr('disabled',true);
						variedUserArr.push(new VariedUser(sourcePhone,destPhone,_flag));
					//	variedUserArr.push(new VariedUser(destPhone,sourcePhone,_flag));
						$('#variedRoleListTb').append('<tr><td>' + sourcePhone + '</td><td>' + destPhone +'</td><td><input type="button" value="删除" class="b_text" onclick="delVariedRec(this)" /></td></tr>');
					}else {
						//2.2 如果不存在则设置源手机号不能再次变更;
						//    添加一个变更对象，exsitAfterPhone=false;
						//    “已变更角色区”添加一条记录
						$('#initRoleTbody').find('input[id="' + sourcePhone + '"]').attr('disabled',true)
						variedUserArr.push(new VariedUser(sourcePhone,destPhone,_flag));
						$('#variedRoleListTb').append('<tr><td>' + sourcePhone + '</td><td>' + destPhone +'</td><td><input type="button" value="删除" class="b_text" onclick="delVariedRec(this)" /></td></tr>');
					}
					$('#varyResetBtn').click();
					//设定"确认"按钮的状态为可编辑状态
					$('#submitBtn').removeAttr('disabled');
				}	  
			});
			//变更输入框重置
			$('#varyResetBtn').click(function() {
				//手机号码重置
				$('#sourcePhone').val('');
				$('#destPhone').val('');
				//密码重置
				$('#familyRoleTab input[name=sourcePhonePwd]').val('');
				$('#familyRoleTab input[name=destPhonePwd]').val('');
			});
			
			//提交按钮
			$('#submitBtn').click(function() {
				//限定：如果没有变更号码不允许点击确定
				if(variedUserArr.length == 0) {
					rdShowMessageDialog('没有可变更的号码！');	
					return false;
				}
				var length = resulFamUsertArr.length;
				var famRoles = resulFamUsertArr;
				var create_accept = '<%=create_accept%>';
				var chnsource = '01';
				var opCode = '<%=opCode%>';
				var loginNo = '<%=work_no%>';
				var password = '<%=password%>';
				var phone_no_master = '<%=parentPhone%>';
				var op_note = '<%=work_no%>做家庭成员变更';
				var prod_code = $('#familyProdInfo').val();
				var family_code = '<%=familyCode%>';
				var pay_money = '0';
				var sps = new Array();
				var dps = new Array();
				for(var i=0,len=variedUserArr.length;i<len;i++) {
					sps.push(variedUserArr[i].phone);
					dps.push(variedUserArr[i].afterPhone);	
				}
				var vary_source_phones = '';
				var vary_dest_phones = '';
				if(sps.length > 0) {
					vary_source_phones = sps.join(',');
				}
				if(dps.length > 0) {
					vary_dest_phones = dps.join(',');
				}
				$('#create_accept').val('<%=create_accept%>');
				var JSONText = JSON.stringify(new FamUsers(length,famRoles,create_accept,chnsource,opCode,loginNo,password,phone_no_master,op_note,prod_code,family_code,pay_money,vary_source_phones,vary_dest_phones),function(key,value){
					return value;
				});
				$('#myJson').val(JSONText);
				<%if(familyCode.equals("KDJT") || familyCode.equals("RHJT")){%>
							printCommit22('<%=opCode%>');
		  	<%}else {%>
				printCommit(opCode);
				<%}%>
			});
			$('#clearBtn').click(function() {
				window.location = 'fe280Vary.jsp?belongGroupId=<%=belongGroupId%>&familyCode=<%=familyCode%>&familyName=<%=familyName%>&opCode=<%=opCode%>&opName=<%=opName%>&parentPhone=<%=parentPhone%>';
			});
		});
		
		//TODO 效率有点低,但是代码易读懂
		function initRoleTbodyRefrech() {
			//设置“家庭现有成员列表”
			$('#initRoleTbody').empty();
			var listTemp = new Array();
			for(var i=0,len=initUserArr.length;i<len;i++) {
				var _RoleUser = initUserArr[i];
				listTemp.push('<tr><td>' + _RoleUser.famCode + '</td>');
				listTemp.push('<td>' + _RoleUser.famName + '</td>');
				listTemp.push('<td>' + _RoleUser.phone + '</td>');
				listTemp.push('<td>' + _RoleUser.role + '</td>');
				listTemp.push('<td>' + _RoleUser.beginTime + '</td>');
				listTemp.push('<td>' + _RoleUser.endTime + '</td>');
				if(_RoleUser.editSts == '1') {
					listTemp.push('<td><input type="button" name="varyBtn" ');
					listTemp.push('onClick="getPhone(this);" diabled value="变更" ');
					listTemp.push('id="' + _RoleUser.phone +'" disabled class="b_text"/></td></tr>');
				}else if(_RoleUser.editSts == '0') {
				if(_RoleUser.role=="宽带家庭宽带成员") {
					listTemp.push('<td><input type="button" name="varyBtn" ');
					listTemp.push('onClick="getPhone(this);" diabled value="变更" ');
					listTemp.push('id="' + _RoleUser.phone +'" disabled class="b_text"/></td></tr>');
					}else {
					listTemp.push('<td><input type="button" name="varyBtn" ');
					listTemp.push('onClick="getPhone(this);" value="变更" ');
					listTemp.push('id="' + _RoleUser.phone +'" class="b_text"/></td></tr>');
					}
				}
			}
			if(initUserArr.length > 0) {
				$('#initRoleTbody').append(listTemp.join(''));
			}
		}
		
		//点击“变更”按钮，实现用当前行的手机号码填充家庭成员变更区的“源手机号码”
		function getPhone(k) {
			var v = k.parentNode.parentNode;
			var phone = $(v).find("td:eq(2)").text();
			$('#sourcePhone').val(phone);
			$('input[name="sourcePhonePwd"]').val('');
			//设置“家庭成员变更”的按钮的不可编辑状态
			setvarySubmitBtnDisabled();
			sourceSts = -1;//-1:正要验证密码，0：没有验证密码；1：验证密码
			sourceOrDest = -1;//验证哪个手机号密码，0：source；1：dest
			
		}
		
		function delVariedRec(k) {
			var v = k.parentNode.parentNode;
			var sourcePhone = $(v).find("td:first").text();
			var destPhone= $(v).find("td").eq(1).text();
			var _user = variedUserArr.getElByValue(sourcePhone,"phone");
			
			//如果是家庭内成员，则设置“家庭现有成员列表”的操作按钮状态
			if(_user && _user.exsitAfterPhone) {
			//	variedUserArr.removeElByValue(destPhone,"phone");
				$('#initRoleTbody').find('input[id="' + destPhone + '"]').removeAttr('disabled');
			}
			variedUserArr.removeElByValue(sourcePhone,"phone");
			//设置“家庭现有成员列表”的操作按钮状态
			$('#initRoleTbody').find('input[id="' + sourcePhone + '"]').removeAttr('disabled');
			//删除resulFamUsertArr中的记录
			resulFamUsertArr.removeElsByValue(sourcePhone,'phone_no_subordinate');
			resulFamUsertArr.removeElsByValue(destPhone,'phone_no_subordinate');
			//删除“已变更角色区”的记录
			var tbody = v.parentNode;
			tbody.removeChild(v);	
			if(variedUserArr.length == 0) {
				$('#submitBtn').attr('disabled',true);
			}
		}
		
		//检测源手机号码和目标手机号码是否可变更  
		function checkPhone(sourcePhone,destPhone) {
			//1. 手机号基础检查
			if(sourcePhone == '' || sourcePhone == null || destPhone == '' || destPhone == null ) {
				 rdShowMessageDialog("家庭成员变更区手机号码都不能为空！");
				 return false;
			}else if(sourcePhone.length != 11 || destPhone.length != 11) {
				 rdShowMessageDialog("家庭成员变更区手机号码位数不对！");
				 return false;
			}
			//2. 源手机号和目标手机号不能一样
			if(sourcePhone == destPhone ) {
				 rdShowMessageDialog("源手机号不能和目标手机号一致！");
				 return false;
			}
			//3. 源手机号码不是可变更的家庭成员角色
			if(!canVaryFamUser(sourcePhone)) {
				return false;
			};
			//4. 源手机号码不能是已被变更的手机号码
			 if(judgeSourcePhoneVarid(sourcePhone)) {
			 	 rdShowMessageDialog("源手机号码已经被变更！");
				 return false;
			 }
			 //5. 目标手机号码是不可变更的家庭成员
			 if(judgeSourcePhoneVarid(sourcePhone)) {
			 	 rdShowMessageDialog("源手机号码已经被变更！");
				 return false;
			 }
			 
			//5. 目标手机号码已被变更
			 if(judgeDestPhoneUsed(destPhone)) {
			 	 rdShowMessageDialog("目标手机号码已经被变更！");
				 return false;
			 }
			 //6. 同角色不允许变更
			 var _el = initUserArr.getElByValue(destPhone,"phone");
			 var _el2 = initUserArr.getElByValue(sourcePhone,"phone");
			 if( _el != -1 && _el != '-1' && _el2 != -1 && _el2 != '-1') {
			 	if(_el.role == _el2.role) {
			 		rdShowMessageDialog("同角色手机号码不允许变更！");
				 	return false;	
			 	}
			 } 
 			//7. 是否通过服务校验
			getPubCheck();
			
			if($("#checkStatus").val() == "1"){
				return true;
			}else {
				return false;
			}
		}
		
		/*
		 *	判断源手机号码是否是可变更的家庭成员角色
		 *	如果flag是false，则不提示dialog
		 */
		function canVaryFamUser(phone) {
			//1. 家庭成员
			if(judgePhoneExsit(phone)) {
				//2. 如果是家庭成员，可变更
				var _user = initUserArr.getElByValue(phone,"phone");
				if(_user.editSts == '0') {
					return true;	
				}else {
					rdShowMessageDialog("源手机号码是不可变更的家庭成员手机号码！");
					return false;	
				}
			}else {
					rdShowMessageDialog("源手机号码不是家庭成员手机号码！");
					return false;	
			}
		}
		
		function getPubCheck(){
			var json = new Array();
			json.push('iFamCode=');
			json.push('<%=familyCode%>');
			json.push('   iProdCode=' + $('#familyProdInfo').val());
			var getdataPacket = new AJAXPacket("fe280VaryCheck.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("sourcePhone",$('#sourcePhone').val());
			getdataPacket.data.add("destPhone",$('#destPhone').val());
			getdataPacket.data.add("sourcePwd",$('input[name=sourcePhonePwd]').val());
			getdataPacket.data.add("opCode",'<%=opCode%>');
			getdataPacket.data.add("famCode",'<%=familyCode%>');
			getdataPacket.data.add("prodCode",$('#familyProdInfo').val());
			core.ajax.sendPacket(getdataPacket,doPubCheckBack);
			getdataPacket = null;
		}
		function doPubCheckBack(packet){
			var ret_code = packet.data.findValueByName("retcode");
			var ret_msg = packet.data.findValueByName("retmsg");
			var chgFlag = packet.data.findValueByName("chgFlag");
			if(ret_code != "000000"){
				$("#checkStatus").val("0");
				rdShowMessageDialog(ret_msg,0);
		  		return false;
			}else{
				if(chgFlag == '1') {
					rdShowMessageDialog(ret_msg);
					return false;
				}else if(chgFlag == '0') {
					$("#checkStatus").val("1");
					//1. 判断当前FamUser的标识位，3则放在最前面，1放在最后
					for(var i=0,len=tempFamUserArray.length;i<len;i++) {
						var user = tempFamUserArray[i];
						for(var j=0,len2=user.businesses.length;j<len2;j++) {
							var busiEl = user.businesses[j];
							if(busiEl.exec_order == '1') {
								resulFamUsertArr.push(user);
							}else if(busiEl.exec_order == '3') {
								resulFamUsertArr.splice(0,0,user);	
							}
							break;
						}
					}				
					tempFamUserArray = [];
					return true;
				}else {
					return false;	
				}
				
			}
		}
		
		function printCommit(opCode){
			var ret = showPrtDlg(opCode,"确实要进行电子免填单打印吗？","Yes");
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
			}
			else{
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
					frmCfm();
				}
			}
			return true;
		}
								function printCommit22(opCode){
			var ret = showPrtDlg22(opCode,"确实要进行电子免填单打印吗？","Yes");
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
			}
			else{
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
					frmCfm();
				}
			}
			return true;
		}
		function frmCfm(){
			form1.action="fe280VaryCfm.jsp";
			form1.submit();
		}
		function showPrtDlg(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                   //打印类型：print 打印 subprint 合并打印
			var billType="1";              			//票价类型：1电子免填单、2发票、3收据
			var sysAccept ='<%=printAccept%>'; //流水号
			
			var printStr = printInfo(opcode);		//调用printinfo()返回的打印内容
			var mode_code=null;           			//资费代码
			var fav_code=null;                		//特服代码
			var area_code=null;             		//小区代码
			var opCode=$("#opCode").val();          //操作代码
			/*家庭解散时，打印免填单流水赋值*/
			if(opCode == "e284"){
				sysAccept = "<%=create_accept%>";
			}
			var phoneNo = '';  //客户电话
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = $("#reqContextPath").val() + "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage ;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opCode+"&sysAccept="+sysAccept+
				"&phoneNo="+phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
			
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}
				function showPrtDlg22(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                   //打印类型：print 打印 subprint 合并打印
			var billType="1";              			//票价类型：1电子免填单、2发票、3收据
			var sysAccept ='<%=printAccept%>'; //流水号
			var printStr = printInfo22(opcode);		//调用printinfo()返回的打印内容
			var mode_code=null;           			//资费代码
			var fav_code=null;                		//特服代码
			var area_code=null;             		//小区代码
			var opCode=$("#opCode").val();          //操作代码
			/*家庭解散时，打印免填单流水赋值*/
			if(opCode == "e284"){
				sysAccept = "<%=create_accept%>";
			}
			var phoneNo = '';  //客户电话
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = $("#reqContextPath").val() + "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage ;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opCode+"&sysAccept="+sysAccept+
				"&phoneNo="+phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
			
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}
		function printInfo(opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			
			/************客户信息************/
			cust_info += "手机号码：" + $("#parentPhone").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：" + '<%=printName%>' +"|";
			opr_info += "操作流水：<%=printAccept%>  业务操作时间：" + '<%=cccTime%>' +"|";
			opr_info += "家庭宜居通固话号码：" + $("#parentPhone").val() + "|";
			//家庭内互换和新号变更合并到一块
			opr_info += getPrint();
			/************注意事项************/
			note_info1 += "备注：" + "|";
			note_info1 += "注意事项：" + "|";
			note_info1 += "1、原成员资费有效期至本月底；|";
			note_info1 += "2、新成员号码资费优惠在下月1日零时生效；|";
			note_info1 += "3、每月仅允许变更一次，每次仅允许变更一个号码|";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
				function printInfo22(opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";


		 qryoffer(offeriddd1);
		 qryoffer1(offeriddd2);
			var retInfo = "";
			
			/************客户信息************/
			cust_info += "手机号码：" + $("#parentPhone").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：<%=printOpName %>资费成员变更"  +"|";
			opr_info += "操作流水：<%=printAccept%>  业务操作时间：" + '<%=cccTime%>' +"|";
			opr_info += "<%=printOpName %>家长号码: " + $("#parentPhone").val() + "|";
			//家庭内互换和新号变更合并到一块
			opr_info += getPrint();
			var zifeim1111 =document.all.offername11.value;
			var zifeimsss1111 =document.all.offercomments11.value;
			var zifeim2222 =document.all.offername22.value;
			var zifeimsss2222 =document.all.offercomments22.value;
			if(zifeim1111 !="") { 
			opr_info+="指定资费："+zifeim1111+"|";
			opr_info+="指定资费描述："+zifeimsss1111+"|";
			}
						if(zifeim2222 !="") { 
			opr_info+="指定资费："+zifeim2222+"|";
			opr_info+="指定资费描述："+zifeimsss2222+"|";
			}
			/************注意事项************/
			note_info1 += "备注：" + "|";
			note_info1 += "注意事项：" + "|";
			note_info1 += "1、原成员资费有效期至本月底；|";
			note_info1 += "2、新成员号码资费优惠在下月1日零时生效；|";
			note_info1 += "3、每月仅允许变更一次，每次仅允许变更一个号码|";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		function qryoffer(offerid) {
				if(offerid !="") {
						var getdataPacket = new AJAXPacket("fe280Vary_qryoffers.jsp","正在提交中，请稍候......");
				getdataPacket.data.add("offerid",offerid);	
				core.ajax.sendPacket(getdataPacket,checkSMZValue1);								

				}
		}
						  function checkSMZValue1(packet) {
		      document.all.offername11.value="";
		      document.all.offercomments11.value="";
		      var offername11 = packet.data.findValueByName("offername");
					var offercomments11 = packet.data.findValueByName("offercomments");
		      document.all.offername11.value=offername11;
		      document.all.offercomments11.value=offercomments11;
		      
		}
				function qryoffer1(offerid) {
				if(offerid !="") {
						var getdataPacket = new AJAXPacket("fe280Vary_qryoffers.jsp","正在提交中，请稍候......");
				getdataPacket.data.add("offerid",offerid);	
				core.ajax.sendPacket(getdataPacket,checkSMZValue11);								

				}
		}
						  function checkSMZValue11(packet) {
		      document.all.offername22.value="";
		      document.all.offercomments22.value="";
		      var offername11 = packet.data.findValueByName("offername");
					var offercomments11 = packet.data.findValueByName("offercomments");
		      document.all.offername22.value=offername11;
		      document.all.offercomments22.value=offercomments11;
		      
		}
		
		//循环variedUserArr，获得免填单内容
		function getPrint() {
			var retArr = new Array();
			//家庭内号码互换
			var oldMust = new Array(); 
			var oldNotMust = new Array();
			//变更成新号码
			var oldUser = new Array();
			var newUser = new Array();
			for(var i=0,len=variedUserArr.length;i<len;i++) {
				var vu = variedUserArr[i];
				if(vu.exsitAfterPhone) {
					//家庭内互换
					var phone = vu.phone;
					var oldPhone = initUserArr.getElByValue(phone,'phone');
					if(oldPhone.role == '可选成员') {
						oldNotMust.push(oldPhone.phone);
						oldNotMust.push('  ');
						oldMust.push(vu.afterPhone);
						oldMust.push('  ');
					}else if(oldPhone.role == '必选成员') {
						oldMust.push(oldPhone.phone);
						oldMust.push('  ');
						oldNotMust.push(vu.afterPhone);
						oldNotMust.push('  ');
					} 
				}else {
					//换乘新号码
					oldUser.push(vu.phone);
					oldUser.push('  ');
					newUser.push(vu.afterPhone);
					newUser.push(' ');
				}
			}
			if(oldUser.length > 0) {
				retArr.push('原家庭成员手机号码：' + oldUser.join('') + '|');
				retArr.push('变更后家庭成员手机号码：' + newUser.join('') + '|');
			}
			if(oldMust.length > 0) {
				retArr.push('原家庭必选成员手机号码：' + oldMust.join('') + '变更为可选成员|');
				retArr.push('原家庭可选成员手机号码：' + oldNotMust.join('') + '变更为必选成员|');
			}
			if(retArr.length > 0){
				return 	retArr.join('');
			}
			return "";
		}
		
		 function chkProductPwd(k){
		 	var v = k.parentNode;
		 	var p = v.parentNode;
		 	var $firInput = $(p).find("input:first");
	        var phone = $firInput.val();
	        var pwd = $(v).find("input:eq(0)").val();
	        if( $firInput.attr('id') == 'sourcePhone' ) {
	        	sourceOrDest = 0;
	        }else if( $firInput.attr('id') == 'destPhone' ) {
	        	sourceOrDest = 1;
	        }
	        var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s7983/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	        checkPwd_Packet.data.add("retType","checkPwd");
	    	checkPwd_Packet.data.add("phone_no",phone);
	    	checkPwd_Packet.data.add("Pwd1",pwd);
	    	core.ajax.sendPacket(checkPwd_Packet);
	    	checkPwd_Packet = null;
	    }
	    
	    function doProcess(packet){
	        var retType = packet.data.findValueByName("retType");
	        var retCode = packet.data.findValueByName("retCode");
	        var retMessage=packet.data.findValueByName("retMessage");
	
			var backArrMsg = packet.data.findValueByName("backArrMsg");
			var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
			var backArrMsg2=packet.data.findValueByName("backArrMsg2");
	        
	        self.status="";
	        if(retType == "checkPwd") //集团客户密码校验
	        {
	            if(retCode == "000000")
	            {
	                var retResult = packet.data.findValueByName("retResult");
	                if (retResult == "false") {
	                    rdShowMessageDialog("用户密码校验失败，请重新输入！",0);
	                    return false;	        	
	                } else {
	                	if(sourceOrDest == '0') {
	                		sourceSts = 1;
	                	}else if(sourceOrDest == '1') {
	                		destSts = 1;
	                	}
	                	//只有当两个都验证密码，才能点击确定
	                	if(sourceSts == '1' && destSts == '1') {
	                		$('#varySubmitBtn').removeAttr('disabled');
	                	}
	                    rdShowMessageDialog("用户密码校验成功！",2);
	                    
	                }
	            }
	            else
	            {
	                rdShowMessageDialog("用户密码校验出错，请重新校验！",0);
	                return false;
	            }
	        }
	        else{
	            rdShowMessageDialog("错误代码："+retCode+"错误信息："+retMessage+"",0);
	            return false;
	        }
	    }
	    
	    //设置"家庭成员变更"按钮为不可点击状态
	    function setvarySubmitBtnDisabled() {
	    	$('#varySubmitBtn').attr('disabled',true);
	    }
	    
	    function setDestSts(k) {
	    	if(k == '0') {
	    		sourceSts = -1;
	    	}else if(k == '1') {
	    		destSts = -1;	
	    	}
	    	setvarySubmitBtnDisabled();
	    }
	    
	    function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			$("#custName").val(custName);
			$("#smName").val(smName);
			
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
		<%@ include file="/npage/common/pwd_comm.jsp" %>
	<div class="title">
		<div id="title_zi">家庭产品变更</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">家庭产品信息</td>
			<td>
				<select id="familyProdInfo" name="familyProdInfo" >
					<option value ="">--请选择--</option>
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
						<wtc:sql>
							SELECT prod_code, prod_name
							  FROM sfamilyprodinfo
							 WHERE family_code = '?' AND GROUP_ID = '?'
						</wtc:sql>
						<wtc:param value="<%=familyCode%>"/>
						<wtc:param value="<%=belongGroupId%>"/>
					</wtc:qoption>
				</select>
			</td>
		</tr>
	</table>
	<div class="title" id="famMembListContent">
		<div id="title_zi">家庭现有成员列表</div>
	</div>
	<table id="familyMemberList">
		<thead>
			<tr>
				<th>家庭代码</th>
				<th>家庭名称</th>
				<th>手机号码</th>
				<th>角色名称</th>
				<th>生效时间</th>
				<th>失效时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="initRoleTbody">
		</tbody>
				
	</table>
	<div id="items">
		<div class="item-col2 col-1">
			<div class="title" >
				<div id="title_zi">家庭成员变更</div>
			</div>	
			<table cellspacing="0" id="familyRoleTab">
				<tr>
					<td class="blue">&nbsp;&nbsp;源手机号</td>
					<td>
						<input type="text" id="sourcePhone" name="sourcePhone"  maxlength="11" 
							v_type="mobphone" v_must="1" 
							onkeyup="this.value=this.value.replace(/\D/g,'');setDestSts(0)" 
							onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
					</td>
					<td class="blue">密码</td>
					<td>
						<jsp:include page="/npage/common/pwd_8.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="sourcePhonePwd"  />
			                <jsp:param name="pwd" value=""  />
			            </jsp:include>
			            <input type='button' class='b_text' name='chk_productPwd' onClick='chkProductPwd(this)' value='校验' />
			            <font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td class="blue">目标手机号</td>
					<td>
						<input type="text" id="destPhone" name="destPhone" maxlength="11" 
							v_type="mobphone" v_must="1" 
							onkeyup="this.value=this.value.replace(/\D/g,'');setDestSts(1);"
							onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
					</td>
					<td class="blue">密码</td>
					<td>
						<jsp:include page="/npage/common/pwd_8.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="destPhonePwd"  />
			                <jsp:param name="pwd" value=""  />
			            </jsp:include>
			            <input type='button' class='b_text' name='chk_productPwd' onClick='chkProductPwd(this)' value='校验' />
			            <font class="orange">*</font>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td align="center">
						<input type="button" class="b_foot" value="确定" id="varySubmitBtn" name="varySubmitBtn">
						&nbsp;&nbsp;&nbsp;
						<input type="button" class="b_foot" value="重置" id="varyResetBtn" name="varyResetBtn">
					</td>
				</tr>
			</table>
		</div>
		
		<div class="item-row2 col-2">
			<div class="title" >
				<div id="title_zi">已变更成员区</div>
			</div>	
			<table cellspacing="0" id="addRoleTab">
				<tr>
					<th width="25%">源手机号码</th>
				<!--	<th>角色名称</th> -->
					<th>目标手机号码</th>
					<th>操作</th>
				</tr>
				<tbody id="variedRoleListTb">
				</tbody>
			</table>
		</div>
	</div>
	
	<input type="hidden" value="" id="checkStatus" /><!-- 0：正常；1：异常 -->
	<!-- 免填单需要的参数 begin-->
	<input type="hidden" id="reqContextPath" value="<%=request.getContextPath()%>" />
	<input type="hidden" id="printAccept" value="" />
	<input type="hidden" name="custName" id="custName" value=""/>
	<input type="hidden" name="smName" id="smName" value=""/>
	<!-- 免填单需要的参数 end-->
	<!-- 需要传递的参数 begin-->
	<input type="hidden" value="" id="myJson" name="myJson" /> 
	<input type="hidden" value="" id="opCode" name="opCode" />
	<input type="hidden" value="" id="opName" name="opName" />
	<input type="hidden" value="" id="create_accept" name="create_accept" />
	<input type="hidden" value="" id="parentPhone" name="parentPhone" />
	<input type="hidden" value="" id="offername11" name="offername11" />
	<input type="hidden" value="" id="offercomments11" name="offercomments11" />
		<input type="hidden" value="" id="offername22" name="offername22" />
	<input type="hidden" value="" id="offercomments22" name="offercomments22" />


	<!-- 需要传递的参数 end-->
	
	<table>
		<tr> 
			<td id="footer"> <div align="center"> 
			<input name="submitBtn" id="submitBtn" type="button" disabled class="b_foot" value="确认" />
			&nbsp; 
			<input name="reset" id="clearBtn" type="button" class="b_foot" value="清除" />
			&nbsp; 
			<input name="reset" type="button" class="b_foot" value="返回" onclick="goBack()" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>


<script>
	function goBack(){
		location="fe280.jsp?activePhone=<%=parentPhone%>";
	}
</script>