package com.sitech.acctmgr.atom.impl.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.CardQueryEntity;
import com.sitech.acctmgr.atom.domains.pay.CardQueryOutEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.query.PayCardEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S8025CardCfmBy10086InDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025CardCfmBy10086OutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025CardCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025CardCfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025QueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8025QueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I8025;
import com.sitech.common.CrossEntity;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 充值卡缴费  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(m="cfm",c= S8025CfmInDTO.class,oc=S8025CfmOutDTO.class),
	@ParamType(m="cardCfm",c= S8025CardCfmInDTO.class,oc=S8025CardCfmOutDTO.class),
	@ParamType(m="query",c= S8025QueryInDTO.class,oc=S8025QueryOutDTO.class),
	@ParamType(m="cardCfmBy10086",c= S8025CardCfmBy10086InDTO.class,oc=S8025CardCfmBy10086OutDTO.class)
			})
public class S8025 extends AcctMgrBaseService implements I8025{
	
	private ILogin		login;
	private IControl	control;
	private IRecord		record;
	private IUser		user;
	private IBalance	balance;

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8025#cfm(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO cfm(InDTO inParam) {
		
		String sCurTime = control.getSysDate().get("CUR_TIME").toString();
		
		S8025CfmInDTO inDto = (S8025CfmInDTO)inParam;
		String remark = inDto.getRemark();
		String phoneNo = inDto.getPhoneNoPay();
		log.info("s8025 cfm begin" + inDto.getMbean());
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		UserInfoEntity userInfo = user.getUserEntityAllDb(null, phoneNo, null, false);
		if(userInfo == null){
			throw new BusiException(AcctMgrError.getErrorCode("8025", "00002"), "非本省号码不允许充值!");
		}
		
		//没销售不可以充值
		
		//换卡后不允许充值
		
		//没激活不允许充值--需要调用平台接口
		
		
		//3、调用平台接口
		//sprintf(vInMsg,"CARDPIN=%s,MSISDN=%s",vCardPassWd,vReChargePhoneNo);
		MBean inBean = new MBean();
		inBean.setBody("CARDPIN", inDto.getCardPassword());
		inBean.setBody("MSISDN", inDto.getPhoneNoPay());
		Map<String, String> result =CrossEntity.callService("EAI_CARD_PAY", inBean);
		
		log.info("调用PD充值接口返回： " + result.toString());
		String resultString = result.get("RESULT").toString();
		
		String tmp[] = resultString.split("&");
		
		//调用接口失败后反激活
		String payFlag = "";
		payFlag = tmp[1];   //操作结果
//		if(!payFlag.equals("1")){
//			
//			MBean checkBean = new MBean();
//			checkBean.setBody("SEQUENCE", inDto.getCardNo());
//			Map<String, String> result2 =CrossEntity.callService("EAI_TRANS_ACTIVE", checkBean);//反激活
//			throw new BusiException(AcctMgrError.getErrorCode("8025", "00001"), "调用充值接口报错，充值卡已反激活");
//		}
		
		String amount =tmp[3];      //充值卡金额
		String seqNo = tmp[5];      //充值卡号
		String effTime = tmp[4];	//充值卡有效天数 
		
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		//充值卡请求缴费记录
		Map<String, Object> cardRequest = new HashMap<String, Object>();
		cardRequest.put("LOGIN_ACCEPT", loginAccept);
		cardRequest.put("CALL_PHONE", inDto.getPhoneNo());
		cardRequest.put("PHONE_NO", inDto.getPhoneNoPay());
		/*智能网定义的渠道标识 10：短信营业厅, 11：网上营业厅 12：实体营业厅 13：WAP营业厅 14：自助终端，15：10086热线，*/
		cardRequest.put("SERVICE_TYPE", inDto.getChannelId());
		cardRequest.put("KEY_ID", "");
		cardRequest.put("FOREIGN_SN", "");
		cardRequest.put("CARD_PASSWD", inDto.getCardPassword());
		cardRequest.put("CARD_FEE", amount);
		cardRequest.put("CARD_NO", seqNo);
		cardRequest.put("EFFECT_TIME", effTime);
		cardRequest.put("LOGIN_NO", inDto.getLoginNo());
		cardRequest.put("OP_NOTE", remark);
		cardRequest.put("YEAR_MONTH", sCurTime.substring(0, 6));
		balance.iCardPayrequestInfo(cardRequest);
		
		S8025CfmOutDTO outDto = new S8025CfmOutDTO();
		outDto.setPayFlag(payFlag);
		return outDto;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8025#cardCfm(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO cardCfm(InDTO inParam) {
		
		S8025CardCfmInDTO inDto = (S8025CardCfmInDTO)inParam;
		
		String sCurTime = control.getSysDate().get("CUR_TIME").toString();
		String totalDate = sCurTime.substring(0, 8);
		
		//3、调用平台接口
		//sprintf(vInMsg,"CARDPIN=%s,MSISDN=%s",vCardPassWd,vReChargePhoneNo);
		MBean inBean = new MBean();
		inBean.setBody("CARDPIN", inDto.getCardPassword());
		inBean.setBody("MSISDN", inDto.getPhoneNoPay());
		Map<String, String> result =CrossEntity.callService("EAI_CARD_PAY", inBean);
		log.info("调用PD充值接口返回： " + result);
		String resultString = result.get("RESULT").toString();
		/*
		 * ATTR  属性名列表。用"&"隔开每个属性名。包括以下属性名：
			INTERFACETYPE   接口类别。标准UASP协议充值固定取值为4。
			OPRESULT     	操作结果。整数，具体含义
										0      错误的卡
										1      操作成功
										2      充值卡已失效。
										3~997     操作不成功。
										998  手机帐户支付充值卡类型不匹配（充值卡为IP卡、彩铃卡）
										999  不能为该用户充值。
			AMOUNT          金额。整数，单位：分。充值成功后，用户帐户金额。
		    COUNTTOTAL      有价卡金额。整数，单位：分。
			ACTIVEDAYS  	用户剩余有效期。整数，单位：天。这次充值后，用户剩余的有效期（从当天算起）。
			SEQUENCE  		充值卡序列号， 17至20的数字串。
			RESULT       	充值结果。用"&"开每个属性值。
		 */
		String tmp[] = resultString.split("&");
		String amount =tmp[3];      //充值卡金额
		String seqNo = tmp[5];      //充值卡号
		String effTime = tmp[4];	//充值卡有效天数 
		
		String payFlag = "";
		payFlag = tmp[1];
		
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		//充值卡请求缴费记录
		Map<String, Object> cardRequest = new HashMap<String, Object>();
		cardRequest.put("LOGIN_ACCEPT", loginAccept);
		cardRequest.put("CALL_PHONE", inDto.getPhoneNo());
		cardRequest.put("PHONE_NO", inDto.getPhoneNoPay());
		/*智能网定义的渠道标识 10：短信营业厅, 11：网上营业厅 12：实体营业厅 13：WAP营业厅 14：自助终端，15：10086热线，*/
		cardRequest.put("SERVICE_TYPE", inDto.getChannelId());
		cardRequest.put("KEY_ID", "");
		cardRequest.put("FOREIGN_SN", "");
		cardRequest.put("CARD_PASSWD", inDto.getCardPassword());
		cardRequest.put("CARD_FEE", amount);
		cardRequest.put("CARD_NO", seqNo);
		cardRequest.put("EFFECT_TIME", effTime);
		cardRequest.put("LOGIN_NO", inDto.getLoginNo());
		cardRequest.put("OP_NOTE", "充值卡接口充值");
		cardRequest.put("YEAR_MONTH", sCurTime.substring(0, 6));
		balance.iCardPayrequestInfo(cardRequest);
		
		S8025CardCfmOutDTO outDto = new S8025CardCfmOutDTO();
		outDto.setTotalDate(totalDate);
		outDto.setPayFlag(payFlag);
		return outDto;
	}
	
	public OutDTO cardCfmBy10086(InDTO inParam) {
		
		S8025CardCfmBy10086InDTO inDto = (S8025CardCfmBy10086InDTO)inParam;
		log.info("充值卡充值cardCfmBy10086 begin: " + inDto.getMbean());
		LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String sCurTime = control.getSysDate().get("CUR_TIME").toString();
		String totalDate = sCurTime.substring(0, 8);
		
		//3、调用平台缴费接口
		/*
		 *sprintf(vStrInTmp, "transaction_id=%s,request_number=%s,user_number=%s,request_timestamp=%s,service_type=%s,Voucher_number=%s",
		 				iTransactionId, iReqNumber, iUserNumber, iRequestTime, iServiceType, iVoucherNumber);
	   *sprintf(vInputStr_TMP, ",Category=04,sub_command=01,Opcode=0101,command_status=0,sou_addr=0x20,des_addr=0x20,seq_no=0x30,%s", vStrInTmp);			
	   *vMsgLen = getRquestStrLen(vInputStr_TMP, sCommandStr); //这里取到的是整个报文的实际长度
	   *sprintf(vInputStr, "%s%d%s",sCommandStr, vMsgLen, vInputStr_TMP);
       */
		
		/*智能网定义的渠道标识 10：短信营业厅, 11：网上营业厅 12：实体营业厅 13：WAP营业厅 14：自助终端，15：10086热线，*/
		String channelId = "";		//智能网定义的渠道标识
		if(inDto.getChannelId().equals("06")){
			channelId = "15";
		}else{
			
			throw new BusiException(AcctMgrError.getErrorCode("8025", "00015"), "传入渠道标识有误");
		}
		
		MBean inBean = new MBean();
/*		inBean.setBody("Category", "04");
		inBean.setBody("sub_command", "01");
		inBean.setBody("Opcode", "0101");
		inBean.setBody("command_status", "0");
		inBean.setBody("sou_addr", "0x20");
		inBean.setBody("seq_no", "0x30");*/
		inBean.setBody("transaction_id", inDto.getForeignSn());    //流水号
		inBean.setBody("request_number", inDto.getPhoneNo());	   //充值主叫号码
		inBean.setBody("user_number", inDto.getPhoneNoPay());	   //被充值手机号码
		inBean.setBody("request_timestamp", sCurTime);
		inBean.setBody("service_type", channelId);
		inBean.setBody("Voucher_number", inDto.getCardPassword());	//充值卡密码
		Map<String, String> result = CrossEntity.callService("EAI_CARD10086_PAY", inBean);
		log.info("调用PD充值接口返回： " + result);
		/*新系统平台返回的字符串，应用集成平台给进行拆分
		 *第1～4位：充值结果代码 RETN:详细信息：0000  充值成功
1001  充值卡不存在
1002  充值卡已充值
1003  充值卡状态异常（未激活、加锁、失效等）
1004  充值系统执行错误
1005  充值用户进入黑名单
1006  充值用户超过待充次数
1007  充值用户号段不存在
1008  boss返回超时
1009  操作不成功（包括boss返回失败）
1010  业务数据未配置
1011  映射表数据配置错误
1012  被充值用户归属SCP返回超时

		     第5～16位：充值卡金额，单位分。AMOUNT
                         第17～20位：有效期，单位天。ACTIVEDAYS
                         第21～40位：充值卡序列号。SEQNO
          {SEQNO=15058080236241682, RETN=0000, 
             status_description=000100920000000000003000000015058080236241682                               , 
             ACTIVEDAYS=0000, AMOUNT=0000000000003000}
		 **/
		String retn = result.get("RETN").toString();  //充值结果代码
		String amount = "";      //充值卡金额
		String seqNo = "";      //充值卡号
		String effTime = "";	//充值卡有效天数 
		if(retn.equals("0000")){
			amount = String.valueOf(Long.parseLong(result.get("AMOUNT").toString()));
			seqNo = result.get("SEQNO").toString();	
			effTime = result.get("ACTIVEDAYS").toString();
		}else{
			if(retn.equals("1001")){ //充值卡密码错误, 调用更新黑名单接口
				blackUpdate(inDto.getForeignSn(), inDto.getPhoneNo(), sCurTime, "1");
			}
			//调用更新黑名单接口
			errCode(retn);
		}
		
		//成功更新黑名单，清除黑名单信息
		blackUpdate(inDto.getForeignSn(), inDto.getPhoneNo(), sCurTime, "0");
		
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		//充值卡请求缴费记录
		Map<String, Object> cardRequest = new HashMap<String, Object>();
		cardRequest.put("LOGIN_ACCEPT", loginAccept);
		cardRequest.put("CALL_PHONE", inDto.getPhoneNo());
		cardRequest.put("PHONE_NO", inDto.getPhoneNoPay());
		cardRequest.put("SERVICE_TYPE", channelId);
		cardRequest.put("KEY_ID", inDto.getKeyId());
		cardRequest.put("FOREIGN_SN", inDto.getForeignSn());
		cardRequest.put("CARD_PASSWD", inDto.getCardPassword());
		cardRequest.put("CARD_FEE", amount);
		cardRequest.put("CARD_NO", seqNo);
		cardRequest.put("EFFECT_TIME", effTime);
		cardRequest.put("LOGIN_NO", inDto.getLoginNo());
		cardRequest.put("OP_NOTE", inDto.getRemark());
		cardRequest.put("YEAR_MONTH", sCurTime.substring(0, 6));
		balance.iCardPayrequestInfo(cardRequest);
		
		UserInfoEntity userInfo = user.getUserInfo(inDto.getPhoneNoPay());
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(userInfo.getPhoneNo());
		in.setPayType("");
		in.setPayFee(Long.parseLong(amount));
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.valueOf(totalDate));
		in.setRemark(inDto.getRemark());
		record.saveLoginOpr(in);
		
		S8025CardCfmBy10086OutDTO outDto = new S8025CardCfmBy10086OutDTO();
		outDto.setCardFee(amount);
		outDto.setCardNo(seqNo);
		outDto.setRetn(retn);
		return outDto;
	}
	
	public OutDTO query(InDTO inParam){
		
		S8025QueryInDTO inDto = (S8025QueryInDTO)inParam;
		List<CardQueryEntity> cardList = inDto.getCardList();
		
		String sCurTime = control.getSysDate().get("CUR_TIME").toString();
		
		List<CardQueryOutEntity> cardOutList = new ArrayList<CardQueryOutEntity>();
		for(CardQueryEntity cardTmp : cardList){
			
			//获取充值卡缴费信息
			List<PayCardEntity> cardPayList = record.getPayCardList(cardTmp.getCardSn(), null, null);
			long paySn = cardPayList.get(0).getPaySn();
			int  totalDate = cardPayList.get(0).getTotalDate();
			int yearMonth = totalDate/100;
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("SUFFIX", yearMonth);
			inMap.put("PAY_SN", paySn);
			List<PayMentEntity> paymentList = record.getPayMentList(inMap);
			PayMentEntity payEntity = paymentList.get(0);
			
			CardQueryOutEntity cardOut = new CardQueryOutEntity();
			cardOut.setPhoneNo(payEntity.getPhoneNo());
			cardOut.setPayMoney(payEntity.getPayFee());
			cardOut.setOpTime(payEntity.getOpTime());
			cardOut.setCardSn(cardTmp.getCardSn());
			cardOutList.add(cardOut);
		}
		
		S8025QueryOutDTO outDto = new S8025QueryOutDTO();
		outDto.setCardPayList(cardOutList);
		return outDto;
	}
	
	
	private void errCode(String retn) {

		String errCode = "";
		String errMsg = "";
		switch (retn) {
		case "1001": //充值卡密码错误
			errCode = "00001";
			errMsg = "充值卡密码输入错误";
			break;

		case "0008":
			errCode = "00002";
			errMsg = "有价卡密码输入不合法";
			break;

		case "1002":
			errCode = "00003";
			errMsg = "充值卡已充值";
			break;

		case "1003":
			errCode = "00004";
			errMsg = "充值卡状态异常";
			break;

		case "1004":
			errCode = "00005";
			errMsg = "充值系统执行错误";
			break;

		case "1005":
			errCode = "00006";
			errMsg = "充值用户进入黑名单";
			break;

		case "1006":
			errCode = "00007";
			errMsg = "充值用户超过待充次数";
			break;

		case "1007":
			errCode = "00008";
			errMsg = "充值用户号段不存在";
			break;

		case "1008":
			errCode = "00009";
			errMsg = "调用BOSS服务返回超时";
			break;

		case "1009":
			errCode = "00010";
			errMsg = "业务办理失败";
			break;

		case "1010":
			errCode = "00011";
			errMsg = "业务数据未配置";
			break;

		case "1011":
			errCode = "00012";
			errMsg = "映射表数据配置错误";
			break;

		case "1012":
			errCode = "00013";
			errMsg = "被充值用户归属SCP返回超时";
			break;

		case "2009":
			errCode = "00014";
			errMsg = "主叫号码属于黑名单";
			break;

		default:
			errCode = "00015";
			errMsg = "未知错误";
			break;

		}
		throw new BusiException(AcctMgrError.getErrorCode("8025", errCode), errMsg);
	}
	
	/*
	 *flag 1: 增加黑名单次数  0：清楚黑名单 
	 **/
	private void blackUpdate(String foreignSn, String phoneNo, String cTime, String flag){
		
		MBean inBean = new MBean();
		inBean.setBody("transaction_id", foreignSn);    //流水号
		inBean.setBody("user_number", phoneNo);	   //被充值手机号码
		inBean.setBody("request_timestamp", cTime);
		inBean.setBody("fault_times", flag);
		Map<String, String> result = CrossEntity.callService("EAI_CARD10086_BLACKUPDATE", inBean);
		log.info("调用PD黑名单更新接口返回： " + result);

	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

}
