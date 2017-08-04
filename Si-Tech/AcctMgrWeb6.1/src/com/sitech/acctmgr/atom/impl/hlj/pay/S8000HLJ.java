package com.sitech.acctmgr.atom.impl.hlj.pay;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayOutUserData;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pub.PubWrtoffCtrlEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.domains.user.UsersvcAttrEntity;
import com.sitech.acctmgr.atom.dto.pay.*;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.atom.impl.pay.S8000;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static org.apache.commons.collections.MapUtils.safeAddToMap;


@ParamTypes({ 
	@ParamType(m="init",c= S8000InitInDTO.class,oc=S8000InitOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "缴费校验服务",srvVer = "V10.8.126.0", 
			srvDesc = "缴费校验服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="cfm",c= S8000CfmInDTO.class,oc=S8000CfmOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "缴费确认服务",srvVer = "V10.8.126.0", 
			srvDesc = "缴费确认服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),

	@ParamType(m="cfmDiscount",c= S8000CfmDiscountInDTO.class,oc=S8000CfmDiscountOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "折扣率缴费",srvCnName = "折扣率缴费确认服务",srvVer = "V10.8.126.0", 
			srvDesc = "折扣率缴费确认服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="check",c= S8000CheckInDTO.class,oc=S8000CheckOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "外部缴费成功校验",srvName = "com_sitech_acctmgr_inter_pay_I8000Svc_check", srvCnName = "外部缴费成功校验",srvVer = "V10.8.126.0", 
			srvDesc = "外部缴费成功校验",srcAttr = "核心",srvLocal = "否",srvGroup = "否")
			})

public class S8000HLJ extends S8000 {
	
	/**
	 *黑龙江个性化缴费限制 
	 */
	protected void querySepBusiInfo(Map<String, Object>inParam) {
		
		IUser	user = super.getUser();
		IAccount account = super.getAccount();
		
		log.debug("黑龙江缴费业务个性化限制querySepBusiInfo begin: " + inParam.toString());
		
		S8000InitInDTO inDto = (S8000InitInDTO)inParam.get("IN_DTO");
		String phoneNo = inParam.get("PHONE_NO").toString();
		if(phoneNo.equals("99999999999")){		//没有号码的账户缴费 不校验号码相关规则
			return;
		}
		
		UserInfoEntity uie = user.getUserEntity(null, phoneNo, null, true);
		UserDetailEntity userdetailEntity = user.getUserdetailEntity(uie.getIdNo());
		
		if(userdetailEntity.getRunCode().equals("P") || userdetailEntity.getRunCode().equals("p")){
			
			throw new BusiException(AcctMgrError.getErrorCode("8000","20005"), "该号码未竣工，不允许缴费！");
		}
		
		if(user.isGroupSlaveCard(uie.getIdNo())){
			
			throw new BusiException(AcctMgrError.getErrorCode("8000","20006"), "该号码为集团客户合账分享副卡用户,由主卡用户为其付费,不允许缴费！");
		}
		
		//不允许单独对捆绑营销案宽带账号进行缴费
		if(user.IsNetBinding(phoneNo)){
			throw new BusiException(AcctMgrError.getErrorCode("8000","20007"), "不允许单独对捆绑营销案宽带账号进行缴费!");
		}
		
		//不允许家庭宽带成员缴费
		if(user.IsNetMember(uie.getIdNo())){
			throw new BusiException(AcctMgrError.getErrorCode("8000","20008"), "家庭宽带成员号码，不允许缴费!");
		}
		
		//不允许个人捆绑宽带缴费
		if(user.IsNetPerson(uie.getIdNo())){
			throw new BusiException(AcctMgrError.getErrorCode("8000","20009"), "个人捆绑宽带用户，不允许缴费!");
		}
		
		//不允许流量伴侣副卡
		if(user.IsNetMate(uie.getIdNo())){
			
			//验证账户CONTRACT_NO是否为默认账户，如果不是默认账户，且是该ID的代付账户，则允许缴费
			List<ContractEntity> conList = account.getConList(uie.getIdNo());
			
			for(ContractEntity con : conList){
				if (con.getBillOrder()==99999999 && Long.parseLong(inParam.get("CONTRACT_NO").toString()) == con.getCon()){
					throw new BusiException(AcctMgrError.getErrorCode("8000","20010"), "流量伴侣副卡,不允许缴费!");
				}
			}
		}
		
		//如果是集团宽带品牌，查看是否有品牌为JD的集团宽带为当前用户代付费，如果有，则不允许当前用户缴费
		UserBrandEntity ube = user.getUserBrandRel(uie.getIdNo());
		String brandId = ube.getBrandId();
		check2330(uie.getIdNo(),brandId,inDto.getOpCode());
		
		//通过网厅，只能为品牌为2330kf、2330kd、2330kg品牌的宽带用户缴费
		if(uie != null && uie.getMasterServId().equals("1002") && "02".equals(inDto.getPayPath())){
			checkNet(brandId);
		}
	}
	

	protected  void cfmSepBusiInfo(Map<String, Object>inParam){
		
		IUser	user = super.getUser();
		IBill	bill = super.getBill();
		IControl control = super.getControl();
		IAccount account = super.getAccount();
		
		PayUserBaseEntity userBase = (PayUserBaseEntity)inParam.get("PAY_USERBASE");
		PayBookEntity     bookIn = (PayBookEntity)inParam.get("PAY_BOOKIN");
		
		UserDetailEntity userDetail = null;
		if(userBase.getIdNo() != 0){
			userDetail = user.getUserdetailEntity(userBase.getIdNo());
		}
		
		if(user.isGroupSlaveCard(userBase.getIdNo())){
			
			throw new BusiException(AcctMgrError.getErrorCode("8000","20006"), "该号码为集团客户合账分享副卡用户,由主卡用户为其付费,不允许缴费！");
		}
		
		//不允许单独对捆绑营销案宽带账号进行缴费
		if(user.IsNetBinding(userBase.getPhoneNo())){
			throw new BusiException(AcctMgrError.getErrorCode("8000","20007"), "不允许单独对捆绑营销案宽带账号进行缴费!");
		}
		
		//不允许家庭宽带成员缴费
		if(user.IsNetMember(userBase.getIdNo())){
			throw new BusiException(AcctMgrError.getErrorCode("8000","20008"), "家庭宽带成员号码，不允许缴费!");
		}
		// 不允许个人捆绑宽带缴费
		if (user.IsNetPerson(userBase.getIdNo())) {
			throw new BusiException(AcctMgrError.getErrorCode("8000", "20009"), "个人捆绑宽带用户，不允许缴费!");
		}
		
		//不允许流量伴侣副卡
		if(user.IsNetMate(userBase.getIdNo())){
			
			//验证账户CONTRACT_NO是否为默认账户，如果不是默认账户，且是该ID的代付账户，则允许缴费
			List<ContractEntity> conList = account.getConList(userBase.getIdNo());
			
			for(ContractEntity con : conList){
				if (con.getBillOrder()==99999999 && userBase.getContractNo() == con.getCon()){
					throw new BusiException(AcctMgrError.getErrorCode("8000","20010"), "流量伴侣副卡,不允许缴费!");
				}
			}
			
		}
		
		//划得来平台个性化业务限制
		if(bookIn.getLoginNo().equals("huadel")){
			
			if(userDetail != null && !userDetail.getRunCode().equals("A")){
				
				throw new BusiException(AcctMgrError.getErrorCode("8000","20001"), "状态非正常,不允许划得来平台充值,run_code: " + userDetail.getRunCode());
			}
			
			if(bookIn.getPayFee() > 50000){
				
				throw new BusiException(AcctMgrError.getErrorCode("8000","20002"), "单笔充值金额不能超过500元");
			}
			
			boolean isOwe = bill.isUnPayOwe(userBase.getContractNo());
			if (isOwe) {
				
				throw new BusiException(AcctMgrError.getErrorCode("8000","20003"), "该号码欠费,不允许缴费");
			}
			
			PubWrtoffCtrlEntity wrtoffCtrlEntity = control.getWriteOffFlagAndMonth();
			if (wrtoffCtrlEntity.getWrtoffFlag().equals("1")) { // 出账期间
				
				throw new BusiException(AcctMgrError.getErrorCode("8000","20004"), "出账期间不允许划得来平台充值");
			}
			
		}
		
		//如果是集团宽带品牌，查看是否有品牌为JD的集团宽带为当前用户代付费，如果有，则不允许当前用户缴费
		check2330(userBase.getIdNo(), userBase.getBrandId(), "8000");
		
	}
	
	protected void sendPayMsg (PayUserBaseEntity userBase, PayBookEntity bookIn)  {
		
		IUser  		user = getUser();
		IAccount	account = getAccount();
		IControl	control = getControl();
		IShortMessage shortMessage = getShortMessage();
		
		log.info("发送短信sendPayMsg begin");
		
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		String sPayPath = bookIn.getPayPath();
		
		//获取缴费下发号码(账户缴费时根据配置获取号码)
		Map<String, Object> smsTmp = getSmsPhone(userBase);
		if(smsTmp == null){
			log.debug("没有找到下发短信号码");
			return;
		}
		String smsPhone = smsTmp.get("SMS_PHONE").toString();

		String phoneNo = smsPhone; //真正要下发短信的号码
		boolean internetOfThingsPhone = user.isInternetOfThingsPhone(smsPhone);
		if(internetOfThingsPhone){
			phoneNo = user.getAddServiceNo(user.getUserEntity(null, smsPhone, null, true).getIdNo(), "16");
			log.debug("转换后的下发短信号码: " + phoneNo);
		}
		
		//一些品牌不发送短信  GH
/*		String notBrand = control.getPubCodeValue(2103, "BRAND_ID", null);
		if(-1 != notBrand.indexOf(userBase.getBrandId())){
			
			log.debug("该品牌不发送短信");
			return;
		}*/
		
		//某些工号缴费不发送短信
		{
		
		
		}
		
		/*
		 * 判断是否是校园宽带资费不发送短信  select * from pub_codedef_dict where code_class = '2021'
		 **/
		if(userBase.getIdNo()!=0 && isNotSmsPrcid(userBase.getIdNo())){
			
			log.error("该用户订购了校园宽带资费，不下发短信!");
			return;
		}
		
		Map<String, Object> mapTmp = new HashMap<String, Object>();
		MBean inMessage = new MBean();
		
		if(sPayPath.equals(PayBusiConst.CARDPATH)){             //1.充值卡缴费发送短信
			
				//非物联网号码，调用是否需要做推荐资费办理 校验通过 短信模板 BOSS_0158
				/*默认短信
				*BOSS_0162:尊敬的客户，您于${year}年${month}月${day}日成功充值${pay_money}元。友情提示:如果您订购了GPRS业务，停机后缴费复机时需重启手机来恢复GPRS的使用。您可为亲友间的通话慷慨买单了，业务详情及办理请发送“亲情网”至10086。中国移动
				*/
				mapTmp.put("year", sCurTime.substring(0, 4));
				mapTmp.put("month", sCurTime.substring(4, 6));
				mapTmp.put("day", sCurTime.substring(6, 8));
				mapTmp.put("pay_money", ValueUtils.transFenToYuan(bookIn.getPayFee()));
				inMessage.addBody("TEMPLATE_ID", "311200800001");
			
		}else if(sPayPath.equals(PayBusiConst.BAKN_PATH)){		//银行短信
				
				//非物联网号码，调用CRM接口 判断是否需要推荐资费办理
				/**默认短信 BOSS_0044，校验通过 短信模板 BOSS_0158
				 * BOSS_0044:尊敬的${sm_name}品牌客户，您通过银行交纳移动话费成功，交费金额为${pay_money}元。友情提示:如果您订购了GPRS业务，停机后缴费复机时需重启手机来恢复GPRS的使用。您可为亲友间的通话慷慨买单了，业务详情及办理请发送“亲情网”至10086。
				 */
				mapTmp.put("sm_name", userBase.getBrandName());
				mapTmp.put("pay_money", ValueUtils.transFenToYuan(bookIn.getPayFee()));
				
				inMessage.addBody("TEMPLATE_ID", "311200800002");
			
		}else{				//其它普通短信
			
			boolean isDefalltUser = account.isDeflaultUser(userBase.getContractNo());
			if(isDefalltUser){		//有默认用户
				
				if(internetOfThingsPhone){
					
					/**
					 *BOSS_0157:尊敬的${sm_name}品牌客户，交费成功，本次交费金额为${pay_money}元。友情提示:如果您订购了GPRS业务，停机后缴费复机时需重启手机来恢复GPRS的使用。您可为亲友间的通话慷慨买单了，业务详情及办理请发送“亲情网”至10086。
					 **/
					mapTmp.put("sm_name", userBase.getBrandName());
					mapTmp.put("pay_money", ValueUtils.transFenToYuan(bookIn.getPayFee()));
					inMessage.addBody("TEMPLATE_ID", "311200800003");
					
				}else{		//非物联网号码，调用接口 需要推荐资费 BOSS_0158 ，默认 账户缴费 BOSS_0150，号码缴费BOSS_0157
					
					/**
					 *BOSS_0157:尊敬的${sm_name}品牌客户，交费成功，本次交费金额为${pay_money}元。友情提示:如果您订购了GPRS业务，停机后缴费复机时需重启手机来恢复GPRS的使用。您可为亲友间的通话慷慨买单了，业务详情及办理请发送“亲情网”至10086。
					 *BOSS_0150:对帐号为${contract_no}的帐户交费成功，交费金额为${pay_money}元！友情提示:您可为亲友间的通话慷慨买单了，业务详情及办理请发送“亲情网”至10086
					 **/
					mapTmp.put("sm_name", userBase.getBrandName());
					mapTmp.put("contract_no", userBase.getContractNo());
					mapTmp.put("pay_money", ValueUtils.transFenToYuan(bookIn.getPayFee()));
					
					if(smsTmp.get("TEMPLATE_ID")!=null&&!"".equals(smsTmp.get("TEMPLATE_ID").toString())){		//获取服务号码方法输出短信模板
						inMessage.addBody("TEMPLATE_ID",smsTmp.get("TEMPLATE_ID").toString());
					}else{		//非宽带
						if(userBase.isPhoneFlag()){
							inMessage.addBody("TEMPLATE_ID", "311200800003");
						}else{
							inMessage.addBody("TEMPLATE_ID", "311200800004");
						}
					}

				}
				
			}else{					//没有默认用户
				
				/***
				 * 对帐号为${contract_no}的帐户交费成功，交费金额为${pay_money}元！友情提示:您可为亲友间的通话慷慨买单了，业务详情及办理请发送“亲情网”至10086${sms_release}
				 */
				
				mapTmp.put("contract_no", userBase.getContractNo());
				mapTmp.put("pay_money", ValueUtils.transFenToYuan(bookIn.getPayFee()));
				
				inMessage.addBody("TEMPLATE_ID", "311200800004");
			}
		}

		inMessage.addBody("PHONE_NO", phoneNo);
		inMessage.addBody("LOGIN_NO", bookIn.getLoginNo());;
		inMessage.addBody("OP_CODE", bookIn.getOpCode());
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("DATA", mapTmp);
		
		String flag = control.getPubCodeValue(2011, "DXFS", null);         // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag.equals("0")){
			inMessage.addBody("SEND_FLAG", 0);
		}else if(flag.equals("1")){
			inMessage.addBody("SEND_FLAG", 1);
		}else if(flag.equals("2")){
			return;
		}
		log.info("发送短信内容：" + inMessage.toString());
		shortMessage.sendSmsMsg(inMessage, 1);
	
	}

	/*
	 * 只为配置过账户对应的下发短信号码或者账户只对应一个号码的用户下发缴费提醒短信
	 * 获取账户配置对应的号码
	 * 账户只对应一个用户 -- 该号码为下发短信号码，否则不下发短信
	 * */
	private Map<String, Object> getSmsPhone(PayUserBaseEntity userBase){
		
		IAccount	account = getAccount();
		IUser		user = getUser();
		IShortMsg	shortMsg = getShortMsg();
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		Map<String, Object> outParam = new HashMap<String, Object>();

		String shortMsgPhone = shortMsg.getConSmsPhone(userBase.getContractNo());
		if(shortMsgPhone != null){
			outParam.put("SMS_PHONE", shortMsgPhone);
			return outParam;
		}
		
		UserInfoEntity userEntity = user.getUserEntityByPhoneNo(userBase.getPhoneNo(), false);
		if(userEntity != null && userEntity.getMasterServId().equals("1002")){
			//宽带发送宽带联系人号码
			UsersvcAttrEntity uae = user.getUsersvcAttr(userEntity.getIdNo(), "23B103");
			
			if(uae == null ){
				return null;
			}
			
			outParam.put("SMS_PHONE", uae.getAttrValue());
			outParam.put("TEMPLATE_ID", "311200800005");
			return outParam;
		}
		
		
		//如果号码缴费，则返回缴费号码做为下发短信号码
		if(userBase.isPhoneFlag()){
			outParam.put("SMS_PHONE", userBase.getPhoneNo());
			return outParam;
		}else{
			
			int userCnt = account.cntConUserRel(userBase.getContractNo(), null, null);
			if(userCnt == 1){
				
				List<ContractEntity> conList = account.getUserList(userBase.getContractNo());
				outParam.put("SMS_PHONE", user.getUserEntityByIdNo(conList.get(0).getId(), true).getPhoneNo());
				return outParam;
			}else{
				
				return null;
			}
		}

	}
	
	protected String getSendPayType(){
		
		return "T";
	}
	/**
	 * 如果是集团宽带品牌，查看是否有品牌为JD的集团宽带为当前用户代付费，如果有，则不允许当前用户缴费
	 **/
	private void check2330(long idNo, String brandId, String opCode) {
		IUser user = super.getUser();
		IAccount account  = super.getAccount();
		// 限制2330ki品牌用户不允许缴费
		if ("2330ki".equals(brandId)) {
			List<ContractEntity> cont = account.getConList(idNo);

			for (ContractEntity con : cont) {
				if (con.getBillOrder() == 99999999 ) {
					continue;
				} else {
					// 若有品牌为"JD"的用户为集团宽带品牌用户付费，则弹出提示信息
					Long contractNo = con.getCon();

					UserInfoEntity userInfo = user.getUserEntityByConNo(contractNo, true);
					idNo = userInfo.getIdNo();
					UserBrandEntity ube = user.getUserBrandRel(idNo);

					if ("2310JD".equals(ube.getBrandId())) {
						log.info("该账户品牌为集团宽带品牌且有品牌为\"2310JD\"的用户为当前用户付费,不允许缴费");
						throw new BusiException(AcctMgrError.getErrorCode(opCode, "00027"),
 "该账户品牌为集团宽带品牌且有品牌为\"2310JD\"" + "的用户为当前用户付费,不允许缴费 ");
					}
				}
			}
		}
	}
	
	/**
	 * @param brandId
	 * 2330kf 2330kd 2330kg  只有这3个品牌允许网厅缴费缴费 2017.5.8追加
	 */
	private void checkNet(String brandId) {
		if(!"2330kd".equals(brandId)&&!"2330kf".equals(brandId)&&!"2330kg".equals(brandId)){
			throw new BusiException(AcctMgrError.getErrorCode("8000","20010"), brandId+"品牌不允许通过网站交费!");
		}
	}
	
	/**
	 * 功能判断用户是否订购了不发短信的资费
	 * 目前配置了校园宽带: 校园宽带资费不发送短信  select * from pub_codedef_dict where code_class = '2021'
	 */
	private boolean isNotSmsPrcid(long idNo){
		IProd prod = super.getProd();
		IControl control = super.getControl();
		
		Set<String> prcids = control.getCodeId(2021L, "XYKD_NOT_SMS");
		
		List<UserPrcEntity> userPrcList = prod.getPdPrcId(idNo, true);
		for(UserPrcEntity tmp : userPrcList){
			if(prcids.contains(tmp.getProdPrcid())){
				
				log.debug("用户订购了该不发短信的资费：" + tmp.getProdPrcid());
				return true;
			}
		}
		
		return false;
	}
	
}
