
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
		/* begin add ��ӿ����Աʱ���������� for ���ڿ������������Ӱ��ں��ײ͵�����@2014/12/30 */ 
		/* SP��ҵ���� */
		Business.prototype.setSpEnter_id = function(spEnter_id){
			this.spEnter_id = spEnter_id;
		}
		Business.prototype.getSpEnter_id = function(){
			return this.spEnter_id;
		};
		/* SPҵ����� */
		Business.prototype.setBizBuss_code = function(bizBuss_code){
			this.bizBuss_code = bizBuss_code;
		}
		Business.prototype.getBizBuss_code = function(){
			return this.bizBuss_code;
		};
		/* ������id */
		Business.prototype.setStb_id = function(stb_id){
			this.stb_id = stb_id;
		}
		Business.prototype.getStb_id = function(){
			return this.stb_id;
		};
		/* �������� */
		Business.prototype.setPostalCode = function(postalCode){
			this.postalCode = postalCode;
		}
		Business.prototype.getPostalCode = function(){
			return this.postalCode;
		};
		/* �����Ƿ��Զ�ȡ�� */
		Business.prototype.setAutoCancel = function(auto_cancel){
			this.auto_cancel = auto_cancel;
		}
		Business.prototype.getAutoCancel = function(){
			return this.auto_cancel;
		};
		/* װ����ַ */
		Business.prototype.setAddress_name = function(address_name){
			this.address_name = address_name;
		}
		Business.prototype.getAddress_name = function(){
			return this.address_name;
		};
		/* ����˺� */
		Business.prototype.setBroadband_id = function(broadband_id){
			this.broadband_id = broadband_id;
		}
		Business.prototype.getBroadband_id = function(){
			return this.broadband_id;
		};
		/* end add ��ӿ����Աʱ���������� for ���ڿ������������Ӱ��ں��ײ͵�����@2014/12/30 */ 
/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� start*/
/*������������ */
		Business.prototype.setConsume_term = function(consume_term){
			this.consume_term = consume_term;
		}
		Business.prototype.getConsume_term = function(){
			return this.consume_term;
		};
/*��������� */
		Business.prototype.setActive_term = function(active_term){
			this.active_term = active_term;
		}
		Business.prototype.getActive_term = function(){
			return this.active_term;
		};
/*����Ԥ�� */		
		Business.prototype.setBase_fee = function(base_fee){
			this.base_fee = base_fee;
		}
		Business.prototype.getBase_fee = function(){
			return this.base_fee;
		};
/*�Ԥ�� */				
		Business.prototype.setFree_fee = function(free_fee){
			this.free_fee = free_fee;
		}
		Business.prototype.getFree_fee = function(){
			return this.free_fee;
		};
/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� end*/		
		Business.prototype.setMach_fee = function(mach_fee){
			this.mach_fee = mach_fee;
		}
		Business.prototype.getMach_fee = function(){
			return this.mach_fee;
		};
/* begin  ����Э�����ü�ͥ�ն˲�ƷӪ��������ͳ�Ʊ���ĺ� @2013/8/8*/
/* ����ϵͳ��ֵ���߽� */
		Business.prototype.setInnet_fee = function(innet_fee){
			this.innet_fee = innet_fee;
		}
		Business.prototype.getInnet_fee = function(){
			return this.innet_fee;
		};
/* ����ϵͳ��ֵ���� */
		Business.prototype.setChoice_fee = function(choice_fee){
			this.choice_fee = choice_fee;
		}
		Business.prototype.getChoice_fee = function(){
			return this.choice_fee;
		};
/* ������ */
		Business.prototype.setCash_pay = function(cash_pay){
			this.cash_pay = cash_pay;
		}
		Business.prototype.getCash_pay = function(){
			return this.cash_pay;
		};
/* ϵͳ��ֵ�ר������� */
		Business.prototype.setOther_fee = function(other_fee){
			this.other_fee = other_fee;
		}
		Business.prototype.getOther_fee = function(){
			return this.other_fee; 
		};
/* ϵͳ��ֵ����ר������� */
		Business.prototype.setHand_fee = function(hand_fee){
			this.hand_fee = hand_fee;
		}
		Business.prototype.getHand_fee = function(){
			return this.hand_fee;
		};
		
/* end  ����Э�����ü�ͥ�ն˲�ƷӪ��������ͳ�Ʊ���ĺ� @2013/8/8*/
		
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
		
		/*zhouby 20130122 �޸��Ҹ���ͥ�����˾�ͨҵ������� */
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
				/* ��װ�� */
		FamRoleList.prototype.setInnet_Fee = function(innet_fee){
			this.innet_fee = innet_fee;
		};
		FamRoleList.prototype.getInnet_Fee = function(){
			return this.innet_fee;
		};
		/* ΥԼ�� */
		FamRoleList.prototype.setFault_Fee = function(fault_fee){
			this.fault_fee = fault_fee;
		};
		FamRoleList.prototype.getFault_Fee = function(){
			return this.fault_fee;
		};
		/* �ն�ΥԼ�� */
		FamRoleList.prototype.setZd_Fault_Fee = function(zd_fault_fee){
			this.zd_fault_fee = zd_fault_fee;
		};
		FamRoleList.prototype.getZd_Fault_Fee = function(){
			return this.zd_fault_fee;
		};
		/* �����ӿ��� */
		FamRoleList.prototype.setTv_no = function(tv_no){
			this.tv_no = tv_no;
		};
		FamRoleList.prototype.getTv_no = function(){
			return this.tv_no;
		};
		/* ����/��������ҵ���ʶ 1�������� 2������ */
		FamRoleList.prototype.setBusi_status = function(busi_status){
			this.busi_status = busi_status;
		};
		FamRoleList.prototype.getBusi_status = function(){
			return this.busi_status;
		};
		/* �����Ƿ��Զ�ȡ�� */
		FamRoleList.prototype.setAutoCancel = function(auto_cancel){
			this.auto_cancel = auto_cancel;
		};
		FamRoleList.prototype.getAutoCancel = function(){
			return this.auto_cancel;
		};
		
		//
		/*
		mainOfferArray�洢���Ƕ���
		�������� ��
					  {
					  	name : code--�ʷ�1
					  	code : code
					  	comment: �ʷ�1����
						}
		*/
		var mainOfferArray = [];
		
	//FamRoleList.prototype.memberPhoneList = new Array(); //��Ա�ֻ����б�
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
			var ret = showPrtDlg(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
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
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept =$("#printAccept").val();       //��ˮ��
			var printStr = printInfo(opcode);			 		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           							  //�ʷѴ���
			var fav_code=null;                				 		//�ط�����
			var area_code=null;             				 		  //С������
			var opCode=$("#opCode").val();                   	//��������
			var phoneNo = $("#parentPhone").val();         //�ͻ��绰
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
			
			/*liujian  ���������ɫ�ĳ�ԱId*/
			var familyCode = $("#familyCode").val();
			var familyName = $("#familyName").val();
			var parent_member_Id = "";
			var normal_member_Id = "";
			var other_member_Id = "";
			if(familyCode == "XFJT"){
				/***�Ҹ���ͥ**/
				parent_member_Id = '70001'; //�˾�ͨ�ҳ�
				normal_member_Id = '70002'; //��ͨ��Ա
				other_member_Id = '70004';  //������Ա
			}else if(familyCode == "QWJT"){
				parent_member_Id = "70015";
				normal_member_Id = "70016";
			}else if(familyCode == "JTGX"){
				parent_member_Id = "40003";
				normal_member_Id = "40004";
			}
			//alert("�ҳ���" + getMemberRoleIdByRole("M").toString());
			//alert("��Ա��" + getMemberRoleIdByRole("O").toString());
			
			
			var offerName = ''; //ָ���ʷ�����
			var offerComment = '';//ָ���ʷ�����
			var normalMemberStr = getPhoneNoByMemberId(normal_member_Id);
			var otherMemberStr = getPhoneNoByMemberId(other_member_Id);
			var mainOfferNameVal = $("#mainOfferName").val(); //ϵͳ�ʷ�����
			var mainOfferCommentVal = $("#mainOfferComment").val().trim(); //ϵͳ�ʷ�����
			var minorOfferNameVal = $("#minorOfferName").val(); //������Ա�ʷ�����
			var minorOfferCommentVal = $("#minorOfferComment").val().trim();//������Ա�ʷ�����
			/************
				����ҵ������
				ԭ���Ҹ���ͥ�Ĳ���
				�Ժ󹫹��ľ��Ǽ�ͥ����+opName
			*/
			var businessName = "";
			if(familyCode == "XFJT"){
				businessName = $("#printName").val();
			}else if(familyCode == "ZDGX"){
				/*4G��Ŀ ������������  �г�����Ҫ�����롱���֣��м�һ����ܡ�*/
				businessName = familyName +"-"+ $("#opName").val();
			}else if(familyCode == "JTGX"){
				businessName = familyName +"--"+ $("#opName").val();
			}else{
				businessName = "����" + familyName +"--"+ $("#opName").val();
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
			alert("��ͨ��Ա��" + normalMemberStr);
			alert("������Ա��" + otherMemberStr);
			alert("ϵͳ�ʷ����ƣ�"+mainOfferNameVal);
			alert("ϵͳ�ʷ�������"+mainOfferCommentVal);
			alert("������Ա�ʷ����ƣ�"+minorOfferNameVal);
			alert("������Ա�ʷ�������"+minorOfferCommentVal);
			*/
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#operPhoneNo").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��" + businessName +"|";
			opr_info += "������ˮ��"+$("#printAccept").val() + "  ҵ�����ʱ�䣺" + $("#cccTime").val() +"|";
			if(opcode=="e281" || opcode=="e282" || opcode=="e283" || opcode=="e284" || opcode=="e285"){
				if(familyCode == "XFJT"){
					opr_info += getHomeEasyPrintInfo() + "|";
					opr_info += "��ͥ�˾�ͨ�̻����룺" + $("#parentPhone").val() + "|";
				}else if(familyCode == "ZDGX"){
					/*4G��Ŀ ������������  Ҫ���Ի���*/
					opr_info += "���������������������룺" + $("#parentPhone").val() + "|";
				/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
				}else if(familyCode == "JTGX"){
					opr_info += "4G��ͥ�����ײ�Ⱥ���������룺" + $("#parentPhone").val() + "|";
				}else{
					opr_info += "�齨" + familyName + "���룺" + $("#parentPhone").val() + "|";
				}
			}else if(opcode=="e875" || opcode=="e880" || opcode=="e881"){
				opr_info += "�������޳�����룺" + $("#parentPhone").val() + "|";
			}
			/*liujian add ��ҵ������*/
			/*
				��ͬҵ��չʾ�������ָ���ʷѲ�ͬ
				�Ҹ���ͥ��Աҵ���˶�����ͨ��Ա���ʷ�    ��Ӧ��opcode=e283
				�Ҹ���ͥҵ���˶�    ���˾�ͨ�ҳ����ʷ�  ��Ӧ��opcode=e284
				�Ҹ���ͥǩԼ����������˾�ͨ�ҳ����ʷ�  ��Ӧ��opcode=e285
			*/
			var opr_info_temp = '';
			var note_info1_temp = '';
			
			//alert("opcode=["+opcode+"]"+"\n"+"familyCode=["+familyCode+"]");
			switch(opcode) {
				case 'e281' : 
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
						}
						/*�趨ָ���ʷ�*/
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
						/*ֻ�д���ʱչʾ��ѡ��Ա�����ʷ�*/
						if(familyCode == "XFJT"){
							if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
								opr_info_temp = "��ѡ��Ա�����ʷѣ�" + minorOfferNameVal + "|";
								note_info1_temp = "��ѡ��Ա������ʷ�������" + minorOfferCommentVal + "|";
							}
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						if(familyCode == "ZDGX"){
							/*4G��Ŀ ������������  Ҫ���Ի���*/
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "�����������鹲���Ա���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(mainOfferNameVal.length > 0){
								offerName = mainOfferNameVal;
							}
							if(mainOfferCommentVal.length > 0){
								offerComment = mainOfferCommentVal;
							}
							
							note_info2 += "������������ҵ�����4G�ײͿͻ�������4G�ײ�ȡ����������������ҵ��ͬ��������"+"|";
						/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
						}else if(familyCode == "JTGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "��������4G��ͥ�����ײͳ�Ա���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
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
								opr_info += "����"+loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							offerName = $("#pubPrtOfferName").val();
							offerComment = $("#pubPrtOfferComments").val();
						}
					}
					break;
				case 'e282' :
					/*
					//����仯��ֻҪ����ӵĺ���
					//�ں����еĳ�Ա����
					if(memberPhoneList.length > 0) {
						otherMemberStr = memberPhoneList.join(',') + "," + otherMemberStr;
					}
					*/
					if(familyCode == "XFJT"){
						opr_info += "���μ����ͥ�Ŀ�ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
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
								opr_info += "���������������������Ա���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(minorOfferNameVal.length > 0){
								offerName = minorOfferNameVal;
							}
							if(minorOfferCommentVal.length > 0){
								offerComment = minorOfferCommentVal;
							}
							/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
						}else if(familyCode == "JTGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "��������4G��ͥ�����ײͳ�Ա���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
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
								opr_info += "���μ���"+loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							offerName = $("#pubPrtOfferName").val();
							offerComment = $("#pubPrtOfferComments").val();
						}
					}
					break;
				case 'e283' :
					if(familyCode == "XFJT"){
						opr_info += "�����˳���ͥ�ĳ�Ա�ֻ����룺" + otherMemberStr + "|";
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
								opr_info += "�����˳����������������Ա���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
							});
							
							if(minorOfferNameVal.length > 0){
								offerName = minorOfferNameVal;
							}
							if(minorOfferCommentVal.length > 0){
								offerComment = minorOfferCommentVal;
							}
						/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
						}else if(familyCode == "JTGX"){
							$.each(memberArr,function(i,n){
								loopMemberId = n[0];
								loopMemberName = n[1];
								opr_info += "�����˳�4G��ͥ�����ײͳ�Ա���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
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
								opr_info += "�����˳�"+loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
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
						opr_info += "��ͥ��Ա�ֻ����룺" + tempMember + "|";
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
					/* begin add ����"�����������Ż�" for ����4G��ͥ�����ײ�ҵ��֧��ϵͳ�����֪ͨ@2015/1/12 */
					}else if(familyCode == "JTGX"){
						var tempMember = normalMemberStr;
						if(otherMemberStr.length >0) {
							tempMember = normalMemberStr + "," + otherMemberStr;
						}
						opr_info += "4G��ͥ�����ײͳ�Ա���룺" + tempMember + "|";
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
							opr_info += loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;
				case 'e285' :	
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
						}
						/*�趨ָ���ʷ�*/
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
							opr_info += loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;
				case 'e875' :
				case 'e880' :
				case 'e881' : 
					/*�趨ָ���ʷ�*/
					offerName = $("#pubPrtOfferName").val();
					offerComment = $("#pubPrtOfferComments").val();
					var loopMemberId = "";
					var loopMemberName = "";
					var memberArr = getMemberRoleIdByRole("O");
					$.each(memberArr,function(i,n){
						loopMemberId = n[0];
						loopMemberName = n[1];
						opr_info += "�������޳����Ա�ֻ����룺" + getPhoneNoByMemberId(loopMemberId) + "|";
					});
					break; 
				case 'i089' :	
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
						}
						/*�趨ָ���ʷ�*/
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
							opr_info += loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
						});
						offerName = $("#pubPrtOfferName").val();
						offerComment = $("#pubPrtOfferComments").val();
					}
					break;					
				case 'i088' :
					if(familyCode == "XFJT"){
						if(normalMemberStr != null && normalMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + normalMemberStr + "|";
						}
						if(otherMemberStr != null && otherMemberStr.length > 0) {
							opr_info += "��ͥ��ѡ��Ա�ֻ����룺" + otherMemberStr + "|";
						}
						/*�趨ָ���ʷ�*/
						if(mainOfferNameVal.length > 0){
							offerName = mainOfferNameVal;
						}
						if(mainOfferCommentVal.length > 0){
							offerComment = mainOfferCommentVal;
						}
						/*ֻ�д���ʱչʾ��ѡ��Ա�����ʷ�*/
						if(familyCode == "XFJT"){
							if($.trim(otherMemberStr) != '' && otherMemberStr != null && minorOfferNameVal.length > 0){
								opr_info_temp = "��ѡ��Ա�����ʷѣ�" + minorOfferNameVal + "|";
								note_info1_temp = "��ѡ��Ա������ʷ�������" + minorOfferCommentVal + "|";
							}
						}
					}else{
						var loopMemberId = "";
						var loopMemberName = "";
						var memberArr = getMemberRoleIdByRole("O");
						$.each(memberArr,function(i,n){
							loopMemberId = n[0];
							loopMemberName = n[1];
							opr_info += "����"+loopMemberName+"���룺" + getPhoneNoByMemberId(loopMemberId) + "|";
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
						opr_info += "ָ���ʷѣ�" + offerName + "����ǩ�ʷ���Чʱ�䣺"
							+ $("#exp_time").val() +" |";					
					}
					else
					{
						opr_info += "ָ���ʷѣ�" + offerName + "|";
					}
				}
				else
				{
					opr_info += "ָ���ʷѣ�" + offerName + "|";
				}
			}
			opr_info += opr_info_temp;
			/************ע������************/
			if(familyCode == "JTGX" && (opcode == "e281" || opcode == "e284")){
				if(offerComment.length > 0){
					note_info1 += "ָ���ʷ�������" + offerComment + "|";
				}
				note_info1 += "��ע��" + "|";
				note_info1 += "4G��ͥ�����ײͣ���һ�ֻ��ڼ�ͥȺ���������������WLAN�๦�ܹ���ҵ�񡣸����ͻ����Թ��������ͻ��ײ������������������ͻ��͸��ͻ���ÿ�¿�����Ⱥ���ڱ���ͨ�����ʱ��500���ӣ������ͻ���ͨ��ʹ�������ͻ���WLAN�˺ţ����֧������ͬʱ��½���ķ�ʽ���������ͻ��й��ڵ�WLAN���������������EDU�ڵ㣬ÿ��50G�ⶥ�����������ͻ�С�ڵ�������ʱ��ÿ����ȡ�����ͻ�20Ԫ�¹���ʹ�÷ѣ��������ͻ����ڵ������ˣ�������ˣ�ʱ��ÿ����ȡ�����ͻ�30Ԫ�¹���ʹ�÷ѡ�����4G�ײͿͻ�����4G�ײ�ȡ����ͬ��ȡ����" + "|";
			}else{
				note_info1 += "��ע��" + "|";
				if(offerComment.length > 0){
					note_info1 += "ָ���ʷ�������" + offerComment + "|";
				}
			}
			note_info1 += note_info1_temp;
			note_info1 += "ע�����" + "|";
			
			note_info1 += getNote();
		
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		
		//TODO ����ɾ���˷���
		function getPhoneNoByRole(roleId){
			/* ����memberRoleId��ȡ�ֻ��� */
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
			/* ����memberRoleId��ȡmemberRoleId���� */
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

		/*liujian ͨ����ԱId��ȡ�ֻ���*/
		function getPhoneNoByMemberId(MemberId){
			/* ����memberId��ȡ�ֻ��� */
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
			var cash_pay; //������
			var innet_fee;//����ϵͳ��ֵ���߽��
			var choice_fee;//����ϵͳ��ֵ����
			var other_fee;//ϵͳ��ֵ�ר�������
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
						/*gaopeng 20121126 ����Э�������˾�ͨ�ʷѷ����ĺ� ����Ԥ��Ĵ�ӡ*/
						  if(prepayfee!=""&&prepayfee!=0){
						    returnStr +=  "Ԥ�滰�ѣ�" + prepayfee + "Ԫ  ";
						  }
						  if(free_fee!=""&&free_fee!=0){
						    returnStr +=  "�Ԥ�棺" + free_fee + "Ԫ  ";
						  }
						  if(returnEachMon!=""&&returnEachMon!=0){
						    returnStr +=  "�·�����" + returnEachMon + "Ԫ  ";
						  }
						  if(consumeTerm!=""&&consumeTerm!=0){
						    returnStr +=  "Ԥ������ޣ�" + consumeTerm + "����  ";
						  }
						  if(cash_pay!=""&&cash_pay!=0){
						    returnStr +=  "�����" + cash_pay + "Ԫ  ";
						  }
						  if(choice_fee!=""&&choice_fee!=0){
						    returnStr +=  "һ���Է�����" + choice_fee + "Ԫ  ";
						  }
						  if(innet_fee!=""&&innet_fee!=0){
						    returnStr +=  "���·�����" + returnEachMon2 + "Ԫ  ";
						  }
						  if(other_fee!=""&&other_fee!=0){
						    returnStr +=  "�����·ݣ�" + other_fee + "����  ";
						  }
						  returnStr +=  "��Ʒ���ƣ��˾�ͨ�ն�һ��  ";
					}
				}
			}
			return returnStr;
		}
		function getBusiByOpcode(){
			var returnStr = " ";
			var opCodeVal = $("#opCode").val();
			if(opCodeVal == "e283"){
				returnStr = "�ɹ������˶��Ҹ���ͥ�ײͣ��Դ����𽫲������ܼ�ͥ�ײ��Ż�ҵ��ͬʱ�������Ĵ����ѹ�ϵ��ȡ����";
			}else if(opCodeVal == "e284"){
				returnStr = "�ƶ��ֻ������˶��Ҹ���ͥ�ײͺ��Դ����𽫰��ղ������ܼ�ͥ��ҵ���Ż��ʷѣ�ͬʱ��ͥ��ͳһ�ɡ����ѹ�ϵ�������";
			}
			return returnStr;
		}

