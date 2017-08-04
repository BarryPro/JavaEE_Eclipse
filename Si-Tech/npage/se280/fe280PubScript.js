
		function Business(){
		}
		Business.prototype.setAreaCode = function(areacode){
			this.areacode = areacode;
		};
		Business.prototype.getAreaCode = function(){
			return this.areacode;
		};
		Business.prototype.setBusitype = function(busitype){
			this.busitype = busitype;
		};
		Business.prototype.getBusitype = function(){
			return this.busitype;
		};
		Business.prototype.setBusinessId = function(businessId){
			this.business_id = businessId;
		};
		Business.prototype.getBusinessId = function(){
			return this.business_id;
		};
		
		Business.prototype.setOfferId = function(offerId){
			this.newofferid = offerId;
		};
		Business.prototype.getOfferId = function(){
			return this.newofferid;
		};
		
		Business.prototype.setBeginTime = function(beginTime){
			this.begin_time = beginTime;
		}
		Business.prototype.getBeginTime = function(){
			return this.begin_time;
		};
		Business.prototype.setEndTime = function(endTime){
			this.end_time = endTime;
		}
		Business.prototype.getEndTime = function(){
			return this.end_time;
		};
		Business.prototype.setPropName = function(propName){
			this.prop_name = propName;
		}
		Business.prototype.getPropName = function(){
			return this.prop_name;
		};
		Business.prototype.setPropSex = function(propSex){
			this.prop_sex = propSex;
		}
		Business.prototype.getPropSex = function(){
			return this.prop_sex;
		};
		Business.prototype.setPropBirthday = function(propBirthday){
			this.prop_birthday = propBirthday;
		}
		Business.prototype.getPropBirthday = function(){
			return this.prop_birthday;
		};
		Business.prototype.setPropCardNo = function(prodCardNo){
			this.prop_cardno = prodCardNo;
		}
		Business.prototype.getPropCardNo = function(){
			return this.prop_cardno;
		};
		Business.prototype.setPropDistrict = function(propDistrict){
			this.prop_district = propDistrict;
		}
		Business.prototype.getPropDistrict = function(){
			return this.prop_district;
		};
		Business.prototype.setPropAddress = function(propAddress){
			this.prop_address = propAddress;
		}
		Business.prototype.getPropAddress = function(){
			return this.prop_address;
		};
		Business.prototype.setPropTelephone = function(propTelephone){
			this.prop_tel = propTelephone;
		}
		Business.prototype.getPropTelephone = function(){
			return this.prop_tel;
		};
		Business.prototype.setUserAccounts = function(userAccounts){
			this.user_accounts = userAccounts;
		}
		Business.prototype.getUserAccounts = function(){
			return this.user_accounts;
		};
		Business.prototype.setPropCommunity = function(propCommunity){
			this.prop_community = propCommunity;
		}
		Business.prototype.getPropCommunity = function(){
			return this.prop_community;
		};
		Business.prototype.setOper = function(oper){
			this.oper = oper;
		}
		Business.prototype.getOper = function(){
			return this.oper;
		};
		Business.prototype.setSale_type = function(sale_type){
			this.sale_type = sale_type;
		}
		Business.prototype.getSale_type = function(){
			return this.sale_type;
		};
		Business.prototype.setSale_flag = function(sale_flag){
			this.sale_flag = sale_flag;
		}
		Business.prototype.getSale_flag = function(){
			return this.sale_flag;
		};
		Business.prototype.setSale_code = function(sale_code){
			this.sale_code = sale_code;
		}
		Business.prototype.getSale_code = function(){
			return this.sale_code;
		};
		Business.prototype.setImei = function(imei){
			this.imei = imei;
		}
		Business.prototype.getImei = function(){
			return this.imei;
		};
		Business.prototype.setBrand_name = function(brand_name){
			this.brand_name = brand_name;
		}
		Business.prototype.getBrand_name = function(){
			return this.brand_name;
		};
		Business.prototype.setRes_name = function(res_name){
			this.res_name = res_name;
		}
		Business.prototype.getRes_name = function(){
			return this.res_name;
		};
		Business.prototype.setPrepay_fee = function(prepay_fee){
			this.prepay_fee = prepay_fee;
		}
		Business.prototype.getPrepay_fee = function(){
			return this.prepay_fee;
		};
		/* begin add 添加宽带成员时，新增内容 for 关于开发互联网电视版融合套餐的需求@2014/12/30 */ 
		/* SP企业代码 */
		Business.prototype.setSpEnter_id = function(spEnter_id){
			this.spEnter_id = spEnter_id;
		}
		Business.prototype.getSpEnter_id = function(){
			return this.spEnter_id;
		};
		/* SP业务代码 */
		Business.prototype.setBizBuss_code = function(bizBuss_code){
			this.bizBuss_code = bizBuss_code;
		}
		Business.prototype.getBizBuss_code = function(){
			return this.bizBuss_code;
		};
		/* 机顶盒id */
		Business.prototype.setStb_id = function(stb_id){
			this.stb_id = stb_id;
		}
		Business.prototype.getStb_id = function(){
			return this.stb_id;
		};
		/* 邮政编码 */
		Business.prototype.setPostalCode = function(postalCode){
			this.postalCode = postalCode;
		}
		Business.prototype.getPostalCode = function(){
			return this.postalCode;
		};
		/* 到期是否自动取消 */
		Business.prototype.setAutoCancel = function(auto_cancel){
			this.auto_cancel = auto_cancel;
		}
		Business.prototype.getAutoCancel = function(){
			return this.auto_cancel;
		};
		/* 装机地址 */
		Business.prototype.setAddress_name = function(address_name){
			this.address_name = address_name;
		}
		Business.prototype.getAddress_name = function(){
			return this.address_name;
		};
		/* 宽带账号 */
		Business.prototype.setBroadband_id = function(broadband_id){
			this.broadband_id = broadband_id;
		}
		Business.prototype.getBroadband_id = function(){
			return this.broadband_id;
		};
		/* end add 添加宽带成员时，新增内容 for 关于开发互联网电视版融合套餐的需求@2014/12/30 */ 
/*gaopeng 20121126 关于协助配置宜居通资费方案的函 start*/
/*底线消费期限 */
		Business.prototype.setConsume_term = function(consume_term){
			this.consume_term = consume_term;
		}
		Business.prototype.getConsume_term = function(){
			return this.consume_term;
		};
/*活动消费期限 */
		Business.prototype.setActive_term = function(active_term){
			this.active_term = active_term;
		}
		Business.prototype.getActive_term = function(){
			return this.active_term;
		};
/*底线预存 */		
		Business.prototype.setBase_fee = function(base_fee){
			this.base_fee = base_fee;
		}
		Business.prototype.getBase_fee = function(){
			return this.base_fee;
		};
/*活动预存 */				
		Business.prototype.setFree_fee = function(free_fee){
			this.free_fee = free_fee;
		}
		Business.prototype.getFree_fee = function(){
			return this.free_fee;
		};
/*gaopeng 20121126 关于协助配置宜居通资费方案的函 end*/		
		Business.prototype.setMach_fee = function(mach_fee){
			this.mach_fee = mach_fee;
		}
		Business.prototype.getMach_fee = function(){
			return this.mach_fee;
		};
/* begin  关于协助配置家庭终端产品营销方案及统计报表的函 @2013/8/8*/
/* 赠送系统充值底线金 */
		Business.prototype.setInnet_fee = function(innet_fee){
			this.innet_fee = innet_fee;
		}
		Business.prototype.getInnet_fee = function(){
			return this.innet_fee;
		};
/* 赠送系统充值活动金额 */
		Business.prototype.setChoice_fee = function(choice_fee){
			this.choice_fee = choice_fee;
		}
		Business.prototype.getChoice_fee = function(){
			return this.choice_fee;
		};
/* 购机款 */
		Business.prototype.setCash_pay = function(cash_pay){
			this.cash_pay = cash_pay;
		}
		Business.prototype.getCash_pay = function(){
			return this.cash_pay;
		};
/* 系统充值活动专款返还期限 */
		Business.prototype.setOther_fee = function(other_fee){
			this.other_fee = other_fee;
		}
		Business.prototype.getOther_fee = function(){
			return this.other_fee; 
		};
/* 系统充值底线专款返还期限 */
		Business.prototype.setHand_fee = function(hand_fee){
			this.hand_fee = hand_fee;
		}
		Business.prototype.getHand_fee = function(){
			return this.hand_fee;
		};
		
/* end  关于协助配置家庭终端产品营销方案及统计报表的函 @2013/8/8*/
		
		function FamRole(){
			this.length = 0;
			this.businesses = [];
		}
		FamRole.prototype.setPhone = function(phone){
			this.phone_no_subordinate = phone;
		};
		FamRole.prototype.getPhone = function(){
			return this.phone_no_subordinate;
		};
		
		FamRole.prototype.setRoleId = function(roleId){
			this.family_role = roleId;
		};
		FamRole.prototype.getRoleId = function(){
			return this.family_role;
		};
		
		FamRole.prototype.setRoleName = function(roleName){
			this.family_role_name = roleName;
		};
		FamRole.prototype.getRoleName = function(){
			return this.family_role_name;
		};
		
		FamRole.prototype.setMembId = function(membId){
			this.member_role_id = membId;
		};
		FamRole.prototype.getMembId = function(){
			return this.member_role_id;
		};
		
		FamRole.prototype.setPay_type = function(pay_type){
			this.pay_type = pay_type;
		};
		FamRole.prototype.getPay_type = function(){
			return this.pay_type;
		};
		
		FamRole.prototype.getLength = function(){
			return this.length;
		};
		FamRole.prototype.getBusiness = function(i)
		{ 
			 return this.businesses[i];
		}
		
		FamRole.prototype.equals = function(){
			if(FamRole.getPhone() == this.getPhone()){
				return true;
			}
			return false;
		};
		FamRole.prototype.addBusiness = function(business){
			this.businesses[this.length++] = business;
		};
		
		function FamRoleList(){
			this.length = 0;
			this.famRoles = [];
		}
		
		/*zhouby 20130122 修改幸福家庭订购宜居通业务的需求 */
		FamRoleList.prototype.setSpInfo = function(spInfo){
			if (spInfo != ''){
					var tmp = spInfo.split(',');
					this.sp_id = tmp[0];
					this.biz_code = tmp[1];
			} else {
				  this.sp_id = '';
					this.biz_code = '';
			}
		};
		/*end*/
		
		FamRoleList.prototype.addFamRole = function(famRole){
			this.famRoles[this.length++] = famRole;
		}
		FamRoleList.prototype.deleteFamRole = function (i){
			this.famRoles.splice(i,1);
			this.length--;
		}
		FamRoleList.prototype.getFamRole = function(i){
			return this.famRoles[i];
		}
		FamRoleList.prototype.getLength = function(){
			return this.length;
		};
		FamRoleList.prototype.setCreate_accept = function(creat_accept){
			this.create_accept = creat_accept;
		};
		FamRoleList.prototype.getCreate_accept = function(){
			return this.create_accept;
		};
		FamRoleList.prototype.setBack_accept = function(back_accept){
			this.back_accept = back_accept;
		};
		FamRoleList.prototype.getBack_accept = function(){
			return this.back_accept;
		};
		
		FamRoleList.prototype.setChnsource = function(chnsource){
			this.chnsource = chnsource;
		};
		FamRoleList.prototype.getChnsource = function(){
			return this.chnsource;
		};
		FamRoleList.prototype.setopCode = function(opCode){
			this.opCode = opCode;
		};
		FamRoleList.prototype.getopCode = function(){
			return this.opCode;
		};
		FamRoleList.prototype.setLoginNo = function(loginNo){
			this.loginNo = loginNo;
		};
		FamRoleList.prototype.getLoginNo = function(){
			return this.loginNo;
		};
		FamRoleList.prototype.setPassword = function(password){
			this.password = password;
		};
		FamRoleList.prototype.getPassword = function(){
			return this.password;
		};
		FamRoleList.prototype.setPhone_no_master = function(phone_no_master){
			this.phone_no_master = phone_no_master;
		};
		FamRoleList.prototype.getPhone_no_master = function(){
			return this.phone_no_master;
		};
		FamRoleList.prototype.setOp_note = function(op_note){
			this.op_note = op_note;
		};
		FamRoleList.prototype.getOp_note = function(){
			return this.op_note;
		};
		FamRoleList.prototype.setProd_code = function(prod_code){
			this.prod_code = prod_code;
		};
		FamRoleList.prototype.getProd_code = function(){
			return this.prod_code;
		};
		
		FamRoleList.prototype.setImei_code = function(imei_code){
			this.imei_code = imei_code;
		};
		FamRoleList.prototype.getImei_code = function(){
			return this.imei_code;
		};
		
		FamRoleList.prototype.setFamily_code = function(family_code){
			this.family_code = family_code;
		};
		FamRoleList.prototype.getFamily_code = function(){
			return this.family_code;
		};
		FamRoleList.prototype.setPay_money = function(pay_money){
			this.pay_money = pay_money;
		}
		FamRoleList.prototype.getPay_money = function(){
			return this.pay_money;
		};
				/* 初装费 */
		FamRoleList.prototype.setInnet_Fee = function(innet_fee){
			this.innet_fee = innet_fee;
		};
		FamRoleList.prototype.getInnet_Fee = function(){
			return this.innet_fee;
		};
		/* 违约金 */
		FamRoleList.prototype.setFault_Fee = function(fault_fee){
			this.fault_fee = fault_fee;
		};
		FamRoleList.prototype.getFault_Fee = function(){
			return this.fault_fee;
		};
		/* 终端违约金 */
		FamRoleList.prototype.setZd_Fault_Fee = function(zd_fault_fee){
			this.zd_fault_fee = zd_fault_fee;
		};
		FamRoleList.prototype.getZd_Fault_Fee = function(){
			return this.zd_fault_fee;
		};
		/* 广电电视卡号 */
		FamRoleList.prototype.setTv_no = function(tv_no){
			this.tv_no = tv_no;
		};
		FamRoleList.prototype.getTv_no = function(){
			return this.tv_no;
		};
		/* 主卡/副卡办理业务标识 1代表主卡 2代表副卡 */
		FamRoleList.prototype.setBusi_status = function(busi_status){
			this.busi_status = busi_status;
		};
		FamRoleList.prototype.getBusi_status = function(){
			return this.busi_status;
		};
		/* 到期是否自动取消 */
		FamRoleList.prototype.setAutoCancel = function(auto_cancel){
			this.auto_cancel = auto_cancel;
		};
		FamRoleList.prototype.getAutoCancel = function(){
			return this.auto_cancel;
		};
		
		//
		/*
		mainOfferArray存储的是对象
		对象例如 ：
					  {
					  	name : code--资费1
					  	code : code
					  	comment: 资费1描述
						}
		*/
		var mainOfferArray = [];
		
	//FamRoleList.prototype.memberPhoneList = new Array(); //成员手机号列表
	/*	
		function FamOffer() {
			this.mainOfferName = '';
			this.mainOfferCmt = '';
			this.minorOfferName = '';
			this.minorOfferCmt = '';
		}
		FamOffer.prototype.setMainOfferName = function(mainOfferName) {
			this.mainOfferName = mainOfferName;
		}
		FamOffer.prototype.getMainOfferName = function() {
			return this.mainOfferName;
		}
		FamOffer.prototype.setMainOfferCmt = function(mainOfferCmt) {
			this.mainOfferCmt = mainOfferCmt;
		}
		FamOffer.prototype.getMainOfferCmt = function() {
			return this.mainOfferCmt;
		}
		FamOffer.prototype.setMinorOfferName = function(minorOfferName) {
			this.minorOfferName = minorOfferName;
		}
		FamOffer.prototype.getMainOfferName = function() {
			return this.minorOfferName;
		}
		FamOffer.prototype.setMinorOfferCmt = function(minorOfferCmt) {
			this.minorOfferCmt = minorOfferCmt;
		}
		FamOffer.prototype.getMainOfferCmt = function() {
			return this.minorOfferCmt;
		}
		
		FamOffer.prototype.getOfferName(opCode) {
			if(opCode == 'e281') {
			  var nameArr = new Array();
			  nameArr.push(this.mainOfferName);
			  if(this.minorOfferName != null && this.minorOfferName.length > 0) {
			  	nameArr.push(this.minorOfferName);	
			  }
			  return nameArr;
			}
			else if(opCode == 'e282' || opCode == 'e283') {
				return this.minorOfferName;	
			}else if(opCode == 'e284' || opCode == 'e285') {
			  return this.mainOfferName;	
			}
		}
		*/
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
		function frmCfm(){
			showLightBox();
			form1.action="fe280Cfm.jsp";
			form1.submit();
		}
		function showPrtDlg(opcode,DlgMessage,submitCfm){
			//显示打印对话框
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept =$("#printAccept").val();       //流水号
			var printStr = printInfo(opcode);			 		//调用printinfo()返回的打印内容
			var mode_code=null;           							  //资费代码
			var fav_code=null;                				 		//特服代码
			var area_code=null;             				 		  //小区代码
			var opCode=$("#opCode").val();                   	//操作代码
			var phoneNo = $("#parentPhone").val();         //客户电话
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
			
			/*liujian  区别各个角色的成员Id*/
			var familyCode = $("#familyCode").val();
			var familyName = $("#familyName").val();
			var parent_member_Id = "";
			var normal_member_Id = "";
			var other_member_Id = "";
			if(familyCode == "XFJT"){
				/***幸福家庭**/
				parent_member_Id = '70001'; //宜居通家长
				normal_member_Id = '70002'; //普通成员
				other_member_Id = '70004';  //其他成员
			}else if(familyCode == "QWJT"){
				parent_member_Id = "70015";
				normal_member_Id = "70016";
			}else if(familyCode == "JTGX"){
				parent_member_Id = "40003";
				normal_member_Id = "40004";
			}
			//alert("家长：" + getMemberRoleIdByRole("M").toString());
			//alert("成员：" + getMemberRoleIdByRole("O").toString());
			
			
			var offerName = ''; //指定资费名称
			var offerComment = '';//指定资费描述
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //系统资费名称
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //系统资费描述
			var minorOfferNameVal = $("#minorOfferName").val(); //其他成员资费名称
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//其他成员资费描述
			/************
				办理业务名字
				原有幸福家庭的不变
				以后公共的就是家庭名称+opName
			*/
			var businessName = "";
			if(familyCode == "XFJT"){
				businessName = $("#printName").val();
			}else if(familyCode == "ZDGX"){
				/*4G项目 亲情流量共享  市场部不要“申请”俩字，中间一个横杠。*/
				businessName = familyName +"-"+ $("#opName").val();
			}else if(familyCode == "JTGX"){
				businessName = familyName +"--"+ $("#opName").val();
			}else{
				businessName = "申请" + familyName +"--"+ $("#opName").val();
			}
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			/*
			alert(familyCode);
			alert("普通成员：" + normalMemberStr);
			alert("其他成员：" + otherMemberStr);
			alert("系统资费名称："+mainOfferNameVal);
			alert("系统资费描述："+mainOfferCommentVal);
			alert("其他成员资费名称："+minorOfferNameVal);
			alert("其他成员资费描述："+minorOfferCommentVal);
			*/
			/************客户信息************/
			cust_info += "手机号码：" + $("#operPhoneNo").val() + "|";
			cust_info += "客户姓名："+$("#custName").val()+"|";
			/************受理内容************/
			opr_info += "用户品牌：" + $("#smName").val() + "  办理业务：" + businessName +"|";
			opr_info += "操作流水："+$("#printAccept").val() + "  业务操作时间：" + $("#cccTime").val() +"|";
			if(opcode=="e281" || opcode=="e282" || opcode=="e283" || opcode=="e284" || opcode=="e285"){
				if(familyCode == "XFJT"){
					opr_info += getHomeEasyPrintInfo() + "|";
					opr_info += "家庭宜居通固话号码：" + $("#parentPhone").val() + "|";
				}else if(familyCode == "ZDGX"){
					/*4G项目 亲情流量共享  要个性化。*/
					opr_info += "亲情流量共享组主卡号码：" + $("#parentPhone").val() + "|";
				/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
				}else if(familyCode == "JTGX"){
					opr_info += "4G家庭共享套餐群组主卡号码：" + $("#parentPhone").val() + "|";
				}else{
					opr_info += "组建" + familyName + "号码：" + $("#parentPhone").val() + "|";
				}
			}else if(opcode=="e875" || opcode=="e880" || opcode=="e881"){
				opr_info += "申请无限畅打号码：" + $("#parentPhone").val() + "|";
			}
			/*liujian add 对业务分情况*/
			/*
				不同业务展示的免填单的指定资费不同
				幸福家庭成员业务退订：普通成员的资费    对应的opcode=e283
				幸福家庭业务退订    ：宜居通家长的资费  对应的opcode=e284
				幸福家庭签约送礼冲正：宜居通家长的资费  对应的opcode=e285
			*/
			var opr_info_temp = '';
			var note_info1_temp = '';
			
			//alert("opcode=["+opcode+"]"+"\n"+"familyCode=["+familyCode+"]");
			switch(opcode) {
				case 'e281' : 
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
						}
						/*设定指定资费*/
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
						/*只有创建时展示可选成员办理资费*/
						if(familyCode == "XFJT"){
							if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
								opr_info_temp = "可选成员办理资费：" + minorOfferNameVal + "|";
								note_info1_temp = "可选成员办理的资费描述：" + minorOfferCommentVal + "|";
							}
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						if(familyCode == "ZDGX"){
							/*4G项目 亲情流量共享  要个性化。*/
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次增加亲情共享成员号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(mainOfferNameVal.length > 0){
								offerName = mainOfferNameVal;
							}
							if(mainOfferCommentVal.length > 0){
								offerComment = mainOfferCommentVal;
							}
							
							note_info2 += "亲情流量共享业务仅限4G套餐客户办理，当4G套餐取消后，亲情流量共享业务同步结束。"+"|";
						/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
						}else if(familyCode == "JTGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次增加4G家庭共享套餐成员号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(mainOfferNameVal.length > 0){
								offerName = mainOfferNameVal;
							}
							if(mainOfferCommentVal.length > 0){
								offerComment = mainOfferCommentVal;
							}
						}else{
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "加入"+loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							offerName = $("#pubPrtOfferName").val();
							offerComment = $("#pubPrtOfferComments").val();
						}
					}
					break;
				case 'e282' :
					/*
					//需求变化，只要新添加的号码
					//融合所有的成员号码
					if(memberPhoneList.length > 0) {
						otherMemberStr = memberPhoneList.join(',') + "," + otherMemberStr;
					}
					*/
					if(familyCode == "XFJT"){
						opr_info += "本次加入家庭的可选成员手机号码：" + otherMemberStr + "|";
						if(minorOfferNameVal.length > 0){
							offerName = minorOfferNameVal;
						}
						if(minorOfferCommentVal.length > 0){
							offerComment = minorOfferCommentVal;
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						
						if(familyCode == "ZDGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次增加亲情流量共享成员号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(minorOfferNameVal.length > 0){
								offerName = minorOfferNameVal;
							}
							if(minorOfferCommentVal.length > 0){
								offerComment = minorOfferCommentVal;
							}
							/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
						}else if(familyCode == "JTGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次增加4G家庭共享套餐成员号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(minorOfferNameVal.length > 0){
								offerName = minorOfferNameVal;
							}
							if(minorOfferCommentVal.length > 0){
								offerComment = minorOfferCommentVal;
							}
						}else{
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次加入"+loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							offerName = $("#pubPrtOfferName").val();
							offerComment = $("#pubPrtOfferComments").val();
						}
					}
					break;
				case 'e283' :
					if(familyCode == "XFJT"){
						opr_info += "本次退出家庭的成员手机号码：" + otherMemberStr + "|";
						if(minorOfferNameVal.length > 0){
							offerName = minorOfferNameVal;
						}
						if(minorOfferCommentVal.length > 0){
							offerComment = minorOfferCommentVal;
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						
						if(familyCode == "ZDGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次退出亲情流量共享组成员号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(minorOfferNameVal.length > 0){
								offerName = minorOfferNameVal;
							}
							if(minorOfferCommentVal.length > 0){
								offerComment = minorOfferCommentVal;
							}
						/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
						}else if(familyCode == "JTGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次退出4G家庭共享套餐成员号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(minorOfferNameVal.length > 0){
								offerName = minorOfferNameVal;
							}
							if(minorOfferCommentVal.length > 0){
								offerComment = minorOfferCommentVal;
							}
						}else{
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "本次退出"+loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							offerName = $("#pubPrtOfferName").val();
							offerComment = $("#pubPrtOfferComments").val();
						}
					}
					break;
				case 'e284' :	
					if(familyCode == "XFJT"){
						var tempMember = normalMemberStr;
						if(otherMemberStr.length >0) {
							tempMember = normalMemberStr + "," + otherMemberStr;
						}
						opr_info += "家庭成员手机号码：" + tempMember + "|";
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
					/* begin add 新增"流量共享互打优惠" for 关于4G家庭共享套餐业务支撑系统改造的通知@2015/1/12 */
					}else if(familyCode == "JTGX"){
						var tempMember = normalMemberStr;
						if(otherMemberStr.length >0) {
							tempMember = normalMemberStr + "," + otherMemberStr;
						}
						opr_info += "4G家庭共享套餐成员号码：" + tempMember + "|";
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						$.each(memberArr,function(i,n){
							loopMemberId = n[0];
							loopMemberName = n[1];
							opr_info += loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;
				case 'e285' :	
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
						}
						/*设定指定资费*/
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						$.each(memberArr,function(i,n){
							loopMemberId = n[0];
							loopMemberName = n[1];
							opr_info += loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;
				case 'e875' :
				case 'e880' :
				case 'e881' : 
					/*设定指定资费*/
					offerName = $("#pubPrtOfferName").val();
					offerComment = $("#pubPrtOfferComments").val();
					var loopMemberId = "";
					var loopMemberName = "";
					var memberArr = getMemberRoleIdByRole("O");
					$.each(memberArr,function(i,n){
						loopMemberId = n[0];
						loopMemberName = n[1];
						opr_info += "申请无限畅打成员手机号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
					});
					break; 
				case 'i089' :	
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
						}
						/*设定指定资费*/
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						$.each(memberArr,function(i,n){
							loopMemberId = n[0];
							loopMemberName = n[1];
							opr_info += loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;					
				case 'i088' :
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "家庭必选成员手机号码：" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "家庭可选成员手机号码：" + otherMemberStr + "|";
						}
						/*设定指定资费*/
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
						/*只有创建时展示可选成员办理资费*/
						if(familyCode == "XFJT"){
							if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
								opr_info_temp = "可选成员办理资费：" + minorOfferNameVal + "|";
								note_info1_temp = "可选成员办理的资费描述：" + minorOfferCommentVal + "|";
							}
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						$.each(memberArr,function(i,n){
							loopMemberId = n[0];
							loopMemberName = n[1];
							opr_info += "加入"+loopMemberName+"号码：" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;
			}
		
			if(offerName.length > 0){
				if ( "i088" == opcode  )
				{
					if ( "N" == $("#renewType").val() )
					{
						opr_info += "指定资费：" + offerName + "．续签资费生效时间："
							+ $("#exp_time").val() +" |";					
					}
					else
					{
						opr_info += "指定资费：" + offerName + "|";
					}
				}
				else
				{
					opr_info += "指定资费：" + offerName + "|";
				}
			}
			opr_info += opr_info_temp;
			/************注意事项************/
			if(familyCode == "JTGX" && (opcode == "e281" || opcode == "e284")){
				if(offerComment.length > 0){
					note_info1 += "指定资费描述：" + offerComment + "|";
				}
				note_info1 += "备注：" + "|";
				note_info1 += "4G家庭共享套餐，是一种基于家庭群组的流量、语音和WLAN多功能共享业务。副卡客户可以共享主卡客户套餐内所有流量；主卡客户和副客户卡每月可享受群组内本地通话免费时长500分钟；副卡客户可通过使用主卡客户的WLAN账号（最多支持五人同时登陆）的方式共享主卡客户中国内地WLAN免费流量（不包括EDU节点，每月50G封顶）。当副卡客户小于等于两人时，每月收取主卡客户20元月功能使用费，当副卡客户大于等于三人（最多四人）时，每月收取主卡客户30元月功能使用费。仅限4G套餐客户办理，4G套餐取消后，同步取消。" + "|";
			}else{
				note_info1 += "备注：" + "|";
				if(offerComment.length > 0){
					note_info1 += "指定资费描述：" + offerComment + "|";
				}
			}
			note_info1 += note_info1_temp;
			note_info1 += "注意事项：" + "|";
			
			note_info1 += getNote();
		
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		//TODO 可以删掉此方法
		function getPhoneNoByRole(roleId){
			/* 根据memberRoleId获取手机号 */
			var returnStr = "";
			var roleObj;
			
			for(var i = 0; i < familyRoleList.getLength(); i++){
				roleObj = familyRoleList.getFamRole(i);
				if(roleObj.getRoleId() == roleId && roleObj.getMembId() != "70001"){
					returnStr = returnStr + roleObj.getPhone() + ",";
				}
			}
			if(returnStr != ""){
				returnStr = returnStr.substring(0,returnStr.length-1);
			}
			return returnStr;
		}
		
		function getMemberRoleIdByRole(roleId){
			/* 根据memberRoleId获取memberRoleId数组 */
			var returnArr = new Array();
			for(var i = 0; i < familyRoleList.getLength(); i++){
				roleObj = familyRoleList.getFamRole(i);
				if(roleObj.getRoleId() == roleId){
					var re = new RegExp("^"+roleObj.getMembId()+",|,"+roleObj.getMembId()+",|,"+roleObj.getMembId()+"$|^"+roleObj.getMembId()+"$");
					if(!re.test(returnArr.toString())){
						var arr = new Array();
						arr.push(roleObj.getMembId());
						arr.push(roleObj.getRoleName());
						returnArr.push(arr);
					}
				}
			}
			return returnArr;
		}

		/*liujian 通过成员Id获取手机号*/
		function getPhoneNoByMemberId(MemberId){
			/* 根据memberId获取手机号 */
			var returnStr = "";
			var roleObj;
			
			for(var i = 0; i < familyRoleList.getLength(); i++){
				roleObj = familyRoleList.getFamRole(i);
				if(roleObj.getMembId() == MemberId ){
					returnStr = returnStr + roleObj.getPhone() + ",";
				}
			}
			if(returnStr != ""){
				returnStr = returnStr.substring(0,returnStr.length-1);
			}
			return returnStr;
		}
		
		
		function getHomeEasyPrintInfo(){
			var prepayfee;
			var free_fee;
			var consumeTerm;
			var returnEachMon;
			var returnStr = " ";
			var roleObj;
			var businessObj;
			var base_fee;
			var cash_pay; //购机款
			var innet_fee;//赠送系统充值底线金额
			var choice_fee;//赠送系统充值活动金额
			var other_fee;//系统充值活动专款返还期限
			var returnEachMon2;
			for(var i = 0; i < familyRoleList.getLength(); i++){
				roleObj = familyRoleList.getFamRole(i);
				for(var j = 0; j < roleObj.getLength(); j++){
					businessObj = roleObj.getBusiness(j);
					if(businessObj.getBusitype() == "YX"){
						prepayfee = businessObj.getPrepay_fee();
						free_fee = businessObj.getFree_fee();
						consumeTerm = businessObj.getConsume_term();
						base_fee = businessObj.getBase_fee();
						returnEachMon = base_fee / consumeTerm;
						if(base_fee==0){ 
						  returnEachMon = 0;
						}
						cash_pay = businessObj.getCash_pay();
						innet_fee = businessObj.getInnet_fee();
						choice_fee = businessObj.getChoice_fee();
						other_fee = businessObj.getOther_fee();
						returnEachMon2 = innet_fee / other_fee;
						if(innet_fee==0){ 
						  returnEachMon2 = 0;
						}
						/*gaopeng 20121126 关于协助配置宜居通资费方案的函 加入活动预存的打印*/
						  if(prepayfee!=""&&prepayfee!=0){
						    returnStr +=  "预存话费：" + prepayfee + "元  ";
						  }
						  if(free_fee!=""&&free_fee!=0){
						    returnStr +=  "活动预存：" + free_fee + "元  ";
						  }
						  if(returnEachMon!=""&&returnEachMon!=0){
						    returnStr +=  "月返还：" + returnEachMon + "元  ";
						  }
						  if(consumeTerm!=""&&consumeTerm!=0){
						    returnStr +=  "预存款期限：" + consumeTerm + "个月  ";
						  }
						  if(cash_pay!=""&&cash_pay!=0){
						    returnStr +=  "购机款：" + cash_pay + "元  ";
						  }
						  if(choice_fee!=""&&choice_fee!=0){
						    returnStr +=  "一次性返还金额：" + choice_fee + "元  ";
						  }
						  if(innet_fee!=""&&innet_fee!=0){
						    returnStr +=  "按月返还金额：" + returnEachMon2 + "元  ";
						  }
						  if(other_fee!=""&&other_fee!=0){
						    returnStr +=  "返还月份：" + other_fee + "个月  ";
						  }
						  returnStr +=  "礼品名称：宜居通终端一部  ";
					}
				}
			}
			return returnStr;
		}
		function getBusiByOpcode(){
			var returnStr = " ";
			var opCodeVal = $("#opCode").val();
			if(opCodeVal == "e283"){
				returnStr = "成功办理退订幸福家庭套餐，自次月起将不再享受家庭套餐优惠业务，同时主副卡的代付费关系将取消。";
			}else if(opCodeVal == "e284"){
				returnStr = "移动手机号码退订幸福家庭套餐后，自次月起将按照不再享受家庭内业务优惠资费，同时家庭内统一缴、付费关系将解除。";
			}
			return returnStr;
		}

