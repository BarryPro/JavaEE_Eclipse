package com.sitech.acctmgr.atom.impl.pay;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.balance.SignAutoPayEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginBaseEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.AutoPayFieldEntity;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.atom.domains.pay.UserSignInfoEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S8297BankOrZfbQueryDetailInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297BankOrZfbQueryDetailOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297MobilePaySignQueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297MobilePaySignQueryOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297QueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297QueryOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297SignInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297SignOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297TerminationInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297TerminationOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297TerminationZfbInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297TerminationZfbOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297UpdateAutoPayInfoInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8297UpdateAutoPayInfoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGoods;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.atom.entity.inter.IUserSign;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.pay.I8297;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(m="sign",c= S8297SignInDTO.class,oc=S8297SignOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "第三方缴费签约关系签约",srvVer = "V10.8.126.0", 
			srvDesc = "第三方缴费签约关系签约",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="termination",c= S8297TerminationInDTO.class,oc=S8297TerminationOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "第三方缴费签约关系解约",srvVer = "V10.8.126.0", 
			srvDesc = "第三方缴费签约关系解约",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
	@ParamType(m="terminationZfb",c= S8297TerminationZfbInDTO.class,oc=S8297TerminationZfbOutDTO.class, 
	
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "支付宝签约关系解约",srvVer = "V10.8.126.0", 
			srvDesc = "boss发起给支付宝签约关系解约后，支付宝确认后回调该接口",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="query",c= S8297QueryInDTO.class,oc=S8297QueryOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "签约关系查询",srvVer = "V10.8.126.0", 
			srvDesc = "签约关系查询",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),		
			
	@ParamType(m="bankOrZfbQueryDetail",c= S8297BankOrZfbQueryDetailInDTO.class,oc=S8297BankOrZfbQueryDetailOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "银行卡、支付宝签约关系查询自动缴费金额、阀值等明细信息",srvVer = "V10.8.126.0", 
			srvDesc = "银行卡、支付宝签约关系查询自动缴费金额、阀值等明细信息",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="updateAutoPayInfo",c= S8297UpdateAutoPayInfoInDTO.class,oc=S8297UpdateAutoPayInfoOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "修改自动缴费限额、阀值等信息",srvVer = "V10.8.126.0", 
			srvDesc = "修改自动缴费限额、阀值等信息",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="mobilePaySignQuery",c= S8297MobilePaySignQueryInDTO.class,oc=S8297MobilePaySignQueryOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "手机支付签约信息查询",srvVer = "V10.8.126.0", 
			srvDesc = "手机支付签约信息查询",srcAttr = "核心",srvLocal = "否",srvGroup = "否")
	
})

public class S8297 extends AcctMgrBaseService implements I8297 {
	
	private ILogin		login;
	private IUser		user;
	private IPayManage	payManage;
	private IRecord		record;
	private IControl	control;
	private IUserSign	userSign;
	private IPreOrder	preOrder;
	private IGroup		group;
	private IGoods		goods;
	private IShortMessage shortMessage;

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8297#sign(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO sign(InDTO inParam) {

		S8297SignInDTO inDto = (S8297SignInDTO)inParam;
		log.info("S8297 sign begin" + inDto.getMbean());
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurDate.substring(0, 6);
		String totalDate = sCurDate.substring(0, 8);
		String time = sCurDate.substring(8, 14);
		
		UserInfoEntity userInfo = user.getUserInfo(inDto.getPhoneNo());
		
		signCheck(inDto.getBusiType(), userInfo.getIdNo());
		
		long loginAccept = control.getSequence("SEQ_SIGN_ID");
		
		//入核心签约关系记录
		LoginBaseEntity loginBase = new LoginBaseEntity();
		loginBase.setLoginNo(inDto.getLoginNo());
		loginBase.setGroupId(inDto.getGroupId());
		loginBase.setOpCode(inDto.getOpCode());
		loginBase.setOpNote(inDto.getOpNote());
		
		UserSignInfoEntity userSignEntity = new UserSignInfoEntity();
		userSignEntity.setIdNo(userInfo.getIdNo());
		userSignEntity.setBusiType(inDto.getBusiType());
		userSignEntity.setPhoneNo(inDto.getPhoneNo());
		userSignEntity.setSignFieldList(inDto.getSignFieldList());
		userSignEntity.setSignSn(inDto.getSignSn());
		userSignEntity.setSignTime(inDto.getSignTime());
		userSignEntity.setLoginAccept(loginAccept);
		userSignEntity.setSignFlag("0");
		
		userSign.saveSignInfo(userSignEntity, loginBase);
		
		//入自动缴费表
		AutoPayFieldEntity autoPayField = new AutoPayFieldEntity();
		if(inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
			long payMoney = 0;
			String payDay = "";
			
			List<FieldEntity> fieldList = inDto.getSignFieldList();
			for(FieldEntity fieldTmp : fieldList){
				if(fieldTmp.getFieldCode().equals("10010001")){
					payMoney = Long.parseLong(fieldTmp.getFieldValue());
				}
				if(fieldTmp.getFieldCode().equals("10010002")){
					payDay = fieldTmp.getFieldValue();
				}
			}
			autoPayField.setPayMoney(payMoney);
			autoPayField.setPayDay(payDay);
			autoPayField.setAutoFlag("1");
		}else if(inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)
				||inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
			
			autoPayField.setPayMoney(2000);
			autoPayField.setBalanceLimit(1000);
			autoPayField.setAutoFlag("1");
		}
		userSign.inAutoPay(userSignEntity, autoPayField);
		
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(userInfo.getPhoneNo());
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark(inDto.getOpNote());
		record.saveLoginOpr(in);
		
		ChngroupRelEntity groupEntity = group.getRegionDistinct(userInfo.getGroupId(), "2", inDto.getProvinceId());
		
		//同步统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", groupEntity.getRegionCode());
		oprCnttMap.put("OP_NOTE", "签约完成");
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", userInfo.getPhoneNo());
		oprCnttMap.put("OP_TIME", sCurDate);
		preOrder.sendOprCntt(oprCnttMap);
		
		//发送短信
		if (inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)) {
			sendSignSms(inDto.getPhoneNo(), inDto.getLoginNo(), inDto.getOpCode(),autoPayField.getPayMoney());
		} else if (inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)
				|| inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)) {
			sendSignSms(inDto.getBusiType(), inDto.getPhoneNo(), inDto.getLoginNo(), inDto.getOpCode());
		}
		
		S8297SignOutDTO outDto = new S8297SignOutDTO();
		if(inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)){
			outDto.setLoginAccept(inDto.getSignSn());
		}
		
		return outDto;
	}
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8297#termination()
	 */
	@Override
	public OutDTO termination(InDTO inParam) {
		
		S8297TerminationInDTO inDto = (S8297TerminationInDTO) inParam;
		log.info("S8297 sign termination" + inDto.getMbean());
		if (StringUtils.isEmptyOrNull(inDto.getGroupId())) {
			LoginEntity loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurDate.substring(0, 6);
		String totalDate = sCurDate.substring(0, 8);
		String time = sCurDate.substring(8, 14);
		
		UserInfoEntity userInfo = user.getUserInfo(inDto.getPhoneNo());
		
		long loginAccept = control.getSequence("SEQ_SIGN_ID");
		
		//校验
		terminationCheck(inDto.getBusiType(), userInfo.getIdNo());
		
		//boss内部签约数据解约,根据业务类型确定  -- 手机支付和银行卡
		if (inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF) || 
				inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)) {

			inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("UPDATE_ACCEPT", loginAccept);
			inMapTmp.put("UPDATE_DATE", totalDate);
			inMapTmp.put("UPDATE_LOGIN", inDto.getLoginNo());
			inMapTmp.put("UPDATE_CODE", inDto.getOpCode());
			userSign.deleteSignInfo(userInfo.getIdNo(), inDto.getBusiType(), inMapTmp);
			
			//boss自动充值数据作废
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("UPDATE_ACCEPT", loginAccept);
			inMap.put("UPDATE_LOGIN", inDto.getLoginNo());
			inMap.put("UPDATE_FLAG", "D");
			userSign.deleteAutoPayInfo(userInfo.getIdNo(),inDto.getBusiType(), inMap);
			
		}
		
		//调用接口,完成平台数据解约--银行卡和支付宝
		if(inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK) ||
				inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
			
			platformTermination(inDto.getBusiType(), userInfo.getIdNo());
		}
		
		//下发短信
		if (inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)||
				inDto.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)	) {
			
			sendTeminationSms(inDto.getBusiType(), inDto.getPhoneNo(),inDto.getLoginNo() , inDto.getOpCode());
		}
		
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(userInfo.getPhoneNo());
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark(inDto.getOpNote());
		record.saveLoginOpr(in);
		
		ChngroupRelEntity groupEntity = group.getRegionDistinct(userInfo.getGroupId(), "2", inDto.getProvinceId());
		
		//同步统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", groupEntity.getRegionCode());
		oprCnttMap.put("OP_NOTE", inDto.getOpNote());
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", userInfo.getPhoneNo());
		oprCnttMap.put("OP_TIME", sCurDate);
		preOrder.sendOprCntt(oprCnttMap);
		
		S8297TerminationOutDTO outDto = new S8297TerminationOutDTO();
		
		return outDto;
	}
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8297#terminationZfb(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO terminationZfb(InDTO inParam) {
		
		S8297TerminationZfbInDTO inDto = (S8297TerminationZfbInDTO) inParam;
		log.info("S8297 terminationZfb begin" + inDto.getMbean());
		if (StringUtils.isEmptyOrNull(inDto.getGroupId())) {
			LoginEntity loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurDate.substring(0, 6);
		String totalDate = sCurDate.substring(0, 8);
		String time = sCurDate.substring(8, 14);
		
		UserInfoEntity userInfo = user.getUserInfo(inDto.getPhoneNo());
		
		long loginAccept = control.getSequence("SEQ_SIGN_ID");
		
		String busiType = "1003";  //该接口提供给支付宝平台调用确认，业务类型写死支付宝

		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("UPDATE_ACCEPT", loginAccept);
		inMapTmp.put("UPDATE_DATE", totalDate);
		inMapTmp.put("UPDATE_LOGIN", inDto.getLoginNo());
		inMapTmp.put("UPDATE_CODE", inDto.getOpCode());
		userSign.deleteSignInfo(userInfo.getIdNo(), busiType, inMapTmp);
		
		//boss自动充值数据作废
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UPDATE_ACCEPT", loginAccept);
		inMap.put("UPDATE_LOGIN", inDto.getLoginNo());
		inMap.put("UPDATE_FLAG", "D");
		userSign.deleteAutoPayInfo(userInfo.getIdNo(),busiType, inMap);

		//下发短信
		sendTeminationSms(busiType, userInfo.getPhoneNo(), inDto.getLoginNo(), inDto.getOpCode());
		
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(userInfo.getPhoneNo());
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark(inDto.getOpNote());
		record.saveLoginOpr(in);
		
		S8297TerminationZfbOutDTO outDto = new S8297TerminationZfbOutDTO();
		
		return outDto;
	}

	
	public OutDTO query(InDTO inParam){
		
		S8297QueryInDTO inDto = (S8297QueryInDTO)inParam;
		
		String busiType = "";
		String busiName = "";
		
		UserInfoEntity userInfo = user.getUserEntity(null, inDto.getPhoneNo(), null, true);
		
		//BOSS侧签约关系查询：联动优势易充值、支付宝易充值、手机支付易充值
		UserSignInfoEntity userSignInfo = userSign.getUserSignInfo(userInfo.getIdNo());
		if(userSignInfo == null){
			
			busiType = "000000";
			busiName = "该用户办未办理任何业务";
		}else{
			
			busiType = userSignInfo.getBusiType();
			if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)){
				busiName = "该用户办理了联动优势易充值业务";
			}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
				busiName = "该用户办理了拓展易充值业务";
			}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
				busiName = "该用户办理了手机支付自动缴费业务";
			}
		}
		
		//总对总签约关系查询，包括 总对总主号签约 和 副号签约
		int zdzFlag = userSign.isZdzSign(userInfo.getIdNo());
		if(zdzFlag == 1){
			busiType = "2001";
			busiName = "该用户已办理总对总主号签约业务";
		}else if(zdzFlag == 2){
			busiType = "2002";
			busiName = "该用户已办理总对总副号签约业务";
		}
	
				
		S8297QueryOutDTO outDto = new S8297QueryOutDTO();
		outDto.setPhoneNo(userInfo.getPhoneNo());
		outDto.setBusiType(busiType);
		outDto.setBusiName(busiName);
		return outDto;
	}
	
	
	public OutDTO bankOrZfbQueryDetail(InDTO inParam){
		
		S8297BankOrZfbQueryDetailInDTO inDto = (S8297BankOrZfbQueryDetailInDTO)inParam;
		
		String busiType = "";
		String busiName = "";
		String flag = "0";		//是否签约联动优势银行卡易充值或者支付宝易充值 0：未签约 1：签约
		
		UserInfoEntity userInfo = user.getUserEntity(null, inDto.getPhoneNo(), null, true);
		
		UserSignInfoEntity userSignInfo = userSign.getUserSignInfo(userInfo.getIdNo());
		if(userSignInfo == null){
			
			busiType = "000000";
			busiName = "该用户办未办理任何业务";
			flag = "0";
			throw new BusiException(AcctMgrError.getErrorCode("8297","00010"), "用户没有办理第三方缴费签约业务");
		}else{
			
			busiType = userSignInfo.getBusiType();
			if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)){
				busiName = "该用户办理了联动优势银行卡易充值业务";
				flag = "1";
			}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
				busiName = "该用户办理了支付宝易充值业务";
				flag = "1";
			}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
				busiName = "该用户办理了手机支付自动缴费业务";
			}
		}
		
		//如果是支付宝签约，获取支付商编号，签约协议号
		String payNum = "";
		String signNum = "";
		List<Map<String, Object>> signAddInfoList = userSign.getUserSignAddInfo(userSignInfo.getIdNo(), busiType, null);
		for(Map<String, Object> tmpMap : signAddInfoList){
			if(tmpMap.get("FIELD_CODE").toString().equals("10030001")){
				
				payNum = tmpMap.get("FIELD_VALUE").toString();
			}
			if(tmpMap.get("FIELD_CODE").toString().equals("10030002")){
				
				signNum = tmpMap.get("FIELD_VALUE").toString();
			}
		}
		
		//获取自动缴费信息
		long payMoney = 0;			//自动缴费金额
		long thresholdValue = 0;	//阀值，缴费临界值
		String autoFlag = "";		//自动缴费标识
		
		SignAutoPayEntity sape = userSign.getAutoPay(userSignInfo.getIdNo());
		
		if(sape!=null){
			payMoney = sape.getPayMoney();
			thresholdValue = sape.getBalanceLimit();
			autoFlag = sape.getAutoFlag();
		}
		
		S8297BankOrZfbQueryDetailOutDTO outDto = new S8297BankOrZfbQueryDetailOutDTO();
		outDto.setBusiType(busiType);
		outDto.setBusiName(busiName);
		outDto.setFlag(flag);
		outDto.setSignTime(userSignInfo.getSignTime());
		outDto.setPayMoney(payMoney);
		outDto.setThresholdValue(thresholdValue);
		outDto.setAutoFlag(autoFlag);
		outDto.setPayNum(payNum);
		outDto.setSignNum(signNum);
		
		return outDto;
	}

	
	public OutDTO mobilePaySignQuery(InDTO inParam){
		
		S8297MobilePaySignQueryInDTO inDto = (S8297MobilePaySignQueryInDTO)inParam;
		
		String busiType = PayBusiConst.SIGN_BUSI_TYPE_SJZF;
		String busiName = "手机支付签约";
		
		UserInfoEntity userInfo = user.getUserEntity(null, inDto.getPhoneNo(), null, true);
		
		long payMoney = 0;		//自动缴费金额
		String payDay = "";	    //代扣时间
		String loginNo ="";		//开通工号
		String opTime="";		//开通时间
		UserSignInfoEntity userSignInfo = new UserSignInfoEntity();
		if(!userSign.isSign(userInfo.getIdNo(), busiType)){
			
			busiType = "0000";
			throw new BusiException(AcctMgrError.getErrorCode("8297","00009"), "用户没有办理手机支付自动缴费业务签约");
	   }else{
		   
		   userSignInfo = userSign.getUserSignInfo(userInfo.getIdNo());
		   busiType = userSignInfo.getBusiType();
		   if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
				busiName = "手机支付自动缴费业务签约";
			}
		   
			//具体查询手机支付签约属性值，自动缴费金额和时间。从自动缴费表中获取
			SignAutoPayEntity sape = userSign.getAutoPay(userSignInfo.getIdNo());
			
			if(sape!=null){
				payMoney = sape.getPayMoney();
				payDay = sape.getPayDay();
				loginNo = sape.getLoginNo();
				opTime = sape.getOpTime();
			}
	   }
		
		
		long loginAccept = control.getSequence("SEQ_SIGN_ID");
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String totalDate = sCurDate.substring(0, 8);
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(userInfo.getPhoneNo());
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark("第三方缴费查询");
		record.saveLoginOpr(in);
		
		S8297MobilePaySignQueryOutDTO outDto = new S8297MobilePaySignQueryOutDTO();
		outDto.setBusiType(busiType);
		outDto.setBusiName(busiName);
		outDto.setSignTime(userSignInfo.getSignTime());
		outDto.setPayMoney(payMoney);
		outDto.setPayDay(payDay);
		outDto.setLoginNo(loginNo);
		outDto.setOpTime(opTime);
		
		return outDto;
	}
	
	
	
	public OutDTO updateAutoPayInfo(InDTO inParam){
		
		S8297UpdateAutoPayInfoInDTO inDto = (S8297UpdateAutoPayInfoInDTO)inParam;
		if (StringUtils.isEmptyOrNull(inDto.getGroupId())) {
			LoginEntity loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		UserInfoEntity userInfo = user.getUserEntity(null, inDto.getPhoneNo(), null, true);
		
		//BOSS侧签约关系查询：联动优势易充值、支付宝易充值、手机支付易充值
		String busiType = "";		// 业务类型：1001:手机支付自动缴话费签约关系.  1002:银行卡自动缴话费签约关系(联动优势).1003:支付宝签约关系
		UserSignInfoEntity userSignInfo = userSign.getUserSignInfo(userInfo.getIdNo());
		if(userSignInfo == null){
			
			busiType = "000000";
			throw new BusiException(AcctMgrError.getErrorCode("8297","00005"), "用户没有办理自动缴费签约业务");
		}else{
			
			busiType = userSignInfo.getBusiType();
		}
		
		updateAutoPayCheck(userSignInfo, inDto);
		
		long loginAccept = control.getSequence("SEQ_SIGN_ID");
		
		//1：设置金额，2：设置阀值，3：设置开关，4：设置（金额+阀值），5：开通（金额+阀值+开关）
		String updateFlag = inDto.getUpdateFlag();
		if(updateFlag.equals("1")){
			
			uPayMoney(userSignInfo, inDto.getPayMoney(), inDto.getLoginNo(), sCurTime, loginAccept);
		}else if(updateFlag.equals("2")){
			
			uBalanceLimit(userSignInfo, inDto.getThresholdValue(), inDto.getLoginNo(), sCurTime, loginAccept);
		}else if(updateFlag.equals("3")){
			
			uAutoFlag(userSignInfo, inDto.getAutoFlag(), inDto.getLoginNo(), sCurTime, loginAccept);
		}else if(updateFlag.equals("4")){
			
			uPayMoneyAndBalanceLimit(userSignInfo.getIdNo(), inDto.getPayMoney(), inDto.getThresholdValue(), inDto.getLoginNo(), sCurTime, loginAccept);
		}else if(updateFlag.equals("5")){
			
			uPayMoneyAndBalanceLimitAndAutoflag(userSignInfo, inDto.getPayMoney(), inDto.getThresholdValue(), inDto.getLoginNo(), sCurTime, loginAccept);
		}
		
		//发送短信
		if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)||
				busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
			
			sendUpdateMsg(inDto);
		}
		
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(userInfo.getIdNo());
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(userInfo.getPhoneNo());
		in.setPayType("");
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(sCurTime.substring(0, 8)));
		in.setRemark("自动缴费修改");
		record.saveLoginOpr(in);
		
		ChngroupRelEntity groupEntity = group.getRegionDistinct(userInfo.getGroupId(), "2", inDto.getProvinceId());
	
		//同步统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", groupEntity.getRegionCode());
		oprCnttMap.put("OP_NOTE", "自动缴费修改");
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", userInfo.getPhoneNo());
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);
		
		S8297UpdateAutoPayInfoOutDTO outDto = new S8297UpdateAutoPayInfoOutDTO();
		return outDto;
	}
	
	protected void signCheck(String busiType, long idNo){
		
		if(userSign.isSign(idNo, busiType)){
			
			log.info("用户已经签约该业务");
			throw new BusiException(AcctMgrError.getErrorCode("8297","00001"), "用户已经签约该业务!id: " + idNo);
		}
		
		//用户有无办理其它签约业务
		UserSignInfoEntity userSignInfo = userSign.getUserSignInfo(idNo);
		if(userSignInfo != null){
			
			log.info("用户已经办理第三方缴费签约业务");
			throw new BusiException(AcctMgrError.getErrorCode("8297","00003"), "用户已经办理第三方缴费签约业务 " + idNo);
		}
		
		//总队总签约校验
		int zdzFlag = userSign.isZdzSign(idNo);
		if(zdzFlag == 1 || zdzFlag == 2){
			
			log.info("用户已经办理总对总签约业务");
			throw new BusiException(AcctMgrError.getErrorCode("8297","00004"), "用户已经办理总对总签约业务 " + idNo);

		}
		
		//手机支付，判断用户是否办理手机支付签约
		if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
			//手机支付 sp_id 698000  biz_code 00000001  对应的定价：MS540124300
			if(!goods.isOrderGoods(idNo, "MS540124300")){
				throw new BusiException(AcctMgrError.getErrorCode("8297","00011"), "用户没有办理手机支付,不能签约手机支付自动缴费业务");
			}
		}
		
	}
	
	
	protected boolean terminationCheck(String busiType, long idNo){
		
		if(!userSign.isSign(idNo, busiType)){
			
			log.info("用户没有签约该业务");
			throw new BusiException(AcctMgrError.getErrorCode("8297","00002"), "用户没有签约该业务!id: " + idNo);
		}
		
		return true;
	}
	
	/**
	* 名称：调用平台接口做解约
	* @param 
	*/
	protected boolean platformTermination(String busiType, long idNo){
		
		if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
			
		}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)){
			
			
		}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
			
			
		}
		
		return true;
	}
	
	
	/**
	* 名称：银行卡、支付宝 签约发送短信

	*/
	protected void sendSignSms (String busiType, String phoneNo, String loginNo, String opCode){
		
		if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
			
			Map<String, Object> mapTmp = new HashMap<String, Object>();
			Map<String, Object> mapTmp2 = new HashMap<String, Object>();
			MBean inMessage = new MBean();
			
			//BOSS_6019: 尊敬的客户，您已成功签约易充值服务，欢迎您的使用。【中国移动】${sms_release}
			inMessage.addBody("TEMPLATE_ID", "311200829701");

			inMessage.addBody("PHONE_NO", phoneNo);
			inMessage.addBody("LOGIN_NO", loginNo);;
			inMessage.addBody("OP_CODE", opCode);
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
			
			//BOSS_6024: 尊敬的客户，您已成功签约易充值服务，并默认开通“自动充值”功能，当您当前可用余额少于10元时，将自动从您签约银行卡中划款20元为本机充值。修改自动充值阈值请发送“ZDJFYZ +金额”到10086。修改自动充值单次金额请发送“ZDJFJE+金额”到10086。【中国移动】
			inMessage.setBody("TEMPLATE_ID", "311200829702");
			inMessage.setBody("DATA", mapTmp2);
			shortMessage.sendSmsMsg(inMessage, 1);
		}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)){
			Map<String, Object> mapTmp = new HashMap<String, Object>();
			MBean inMessage = new MBean();
			//BOSS_6024: 尊敬的客户，您已成功签约易充值服务，并默认开通“自动充值”功能，当您当前可用余额少于10元时，将自动从您签约银行卡中划款20元为本机充值。修改自动充值阈值请发送“ZDJFYZ +金额”到10086。修改自动充值单次金额请发送“ZDJFJE+金额”到10086。【中国移动】
			inMessage.setBody("TEMPLATE_ID", "311200829702");
			inMessage.addBody("PHONE_NO", phoneNo);
			inMessage.addBody("LOGIN_NO", loginNo);;
			inMessage.addBody("OP_CODE", opCode);
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
			
			shortMessage.sendSmsMsg(inMessage, 1);
		}
		
	}
	
	/**
	 * 名称：手机签约短信下发
	 *
	 */
	protected void sendSignSms(String phoneNo, String loginNo, String opCode, Long payMoney) {
		Map<String, Object> mapTmp = new HashMap<String, Object>();
		MBean inMessage = new MBean();
		mapTmp.put("msg_content1", "每月27日自动完成缴费，每次缴费"+ValueUtils.transFenToYuan(payMoney)+"元");
		//BOSS_49285 尊敬的用户，您已成功开通手机支付自动交话费功能，交费规则为${msg_content1}，我们将按此规则为您自动交费。【中国移动】${sms_release} 
		//msg_content1 老系统是： sprintf(vOpenRule,"每月27日自动完成缴费，每次缴费%.2f元",dHoldFee) 

		inMessage.setBody("TEMPLATE_ID", "311200829707");
		inMessage.addBody("PHONE_NO", phoneNo);
		inMessage.addBody("LOGIN_NO", loginNo);
		;
		inMessage.addBody("OP_CODE", opCode);
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("DATA", mapTmp);

		String flag = control.getPubCodeValue(2011, "DXFS", null); // 0:直接发送
																	// 1:插入短信接口临时表
																	// 2：外系统有问题，直接不发送短信
		if (flag.equals("0")) {
			inMessage.addBody("SEND_FLAG", 0);
		} else if (flag.equals("1")) {
			inMessage.addBody("SEND_FLAG", 1);
		} else if (flag.equals("2")) {
			return;
		}
		shortMessage.sendSmsMsg(inMessage, 1);
	}
	
	
	/**
	* 名称：解约发送短信

	*/
	private void sendTeminationSms(String busiType, String phoneNo, String loginNo, String opCode) {
			Map<String, Object> mapTmp = new HashMap<String, Object>();
			MBean inMessage = new MBean();
			inMessage.addBody("PHONE_NO", phoneNo);
			inMessage.addBody("LOGIN_NO", loginNo);;
			inMessage.addBody("OP_CODE", opCode);
			inMessage.addBody("CHECK_FLAG", true);
			
			String flag = control.getPubCodeValue(2011, "DXFS", null);         // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
			if(flag.equals("0")){
				inMessage.addBody("SEND_FLAG", 0);
			}else if(flag.equals("1")){
				inMessage.addBody("SEND_FLAG", 1);
			}else if(flag.equals("2")){
				return;
			}
			
			if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
				mapTmp.put("msg", "尊敬的用户，您已成功取消手机支付自动交话费功能。【中国移动】");
				inMessage.addBody("TEMPLATE_ID", "311200000001");
			}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)){
				inMessage.addBody("TEMPLATE_ID", "311200829708");
			}else if(busiType.equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
				inMessage.addBody("TEMPLATE_ID", "311200829708");
			}
			
			inMessage.addBody("DATA", mapTmp);
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
		
	}

	private String getSpid(String loginNo){
		
		if(loginNo.substring(0, 6).equals("newweb")){	//网厅
			return "M0451002";
		}else if(loginNo.substring(0, 6).equals("newsms")){	//短厅
			return "Z3451001";
		}else if(loginNo.substring(0, 6).equals("186100")){	//IVR
			return "Z5451001";
		}else{
			return "Z6451000";
		}
	}
	
	private void uPayMoney(UserSignInfoEntity userSignInfo, Long payMoney, String loginNo, String curTime, long loginAccpet){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UPDATE_ACCEPT", loginAccpet);
		inMap.put("UPDATE_LOGIN", loginNo);
		inMap.put("UPDATE_FLAG", "U");
		int num = userSign.uAutoPay(userSignInfo.getIdNo(), payMoney, null, null, inMap);
		if(num == 0){
			//入自动缴费表
			UserSignInfoEntity userSignTmp = new UserSignInfoEntity(userSignInfo);
			userSignTmp.setOpTime(curTime);
			userSignTmp.setLoginNo(loginNo);
			
			AutoPayFieldEntity autoPayField = new AutoPayFieldEntity();
			autoPayField.setPayMoney(payMoney);
			autoPayField.setBalanceLimit(0);
			autoPayField.setAutoFlag("0");
			
			userSign.inAutoPay(userSignTmp, autoPayField);
		}
	}
	
	private void uBalanceLimit(UserSignInfoEntity userSignInfo, long balanceLimit, String loginNo, String curTime, long loginAccpet){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UPDATE_ACCEPT", loginAccpet);
		inMap.put("UPDATE_LOGIN", loginNo);
		inMap.put("UPDATE_FLAG", "U");
		int num = userSign.uAutoPay(userSignInfo.getIdNo(), null, balanceLimit, null, inMap);

		if (num == 0) {
			//入自动缴费表
			UserSignInfoEntity userSignTmp = new UserSignInfoEntity(userSignInfo);
			userSignTmp.setOpTime(curTime);
			userSignTmp.setLoginNo(loginNo);

			AutoPayFieldEntity autoPayField = new AutoPayFieldEntity();
			autoPayField.setPayMoney(0);
			autoPayField.setBalanceLimit(balanceLimit);
			autoPayField.setAutoFlag("0");

			userSign.inAutoPay(userSignTmp, autoPayField);
		}
	}
	
	private void uAutoFlag(UserSignInfoEntity userSignInfo, String autoFlag, String loginNo, String curTime, long loginAccpet){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UPDATE_ACCEPT", loginAccpet);
		inMap.put("UPDATE_LOGIN", loginNo);
		inMap.put("UPDATE_FLAG", "U");
		int num = userSign.uAutoPay(userSignInfo.getIdNo(), 2000L, 1000L, autoFlag, inMap);
		
		if (num == 0) {
			//入自动缴费表
			UserSignInfoEntity userSignTmp = new UserSignInfoEntity(userSignInfo);
			userSignTmp.setOpTime(curTime);
			userSignTmp.setLoginNo(loginNo);

			AutoPayFieldEntity autoPayField = new AutoPayFieldEntity();
			autoPayField.setPayMoney(2000);
			autoPayField.setBalanceLimit(1000);
			autoPayField.setAutoFlag(autoFlag);

			userSign.inAutoPay(userSignTmp, autoPayField);
		}
	}
	
	private void uPayMoneyAndBalanceLimit(long idNo, Long payMoney, long balanceLimit, String loginNo, String curTime, long loginAccpet){
		
		if(!userSign.isAutoPay(idNo)){
			
			throw new BusiException(AcctMgrError.getErrorCode("8297","00006"), "用户没有开通自动缴费!id: " + idNo);
		}
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UPDATE_ACCEPT", loginAccpet);
		inMap.put("UPDATE_LOGIN", loginNo);
		inMap.put("UPDATE_FLAG", "U");
		int num = userSign.uAutoPay(idNo, payMoney, balanceLimit, null, inMap);
		if (num != 1) {

			throw new BusiException(AcctMgrError.getErrorCode("0000", "00074"), "修改自动缴费属性出错!id: " + idNo);
		}
	}
	
	private void uPayMoneyAndBalanceLimitAndAutoflag(UserSignInfoEntity userSignInfo, Long payMoney, long balanceLimit, String loginNo, String curTime, long loginAccpet){
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UPDATE_ACCEPT", loginAccpet);
		inMap.put("UPDATE_LOGIN", loginNo);
		inMap.put("UPDATE_FLAG", "U");
		int num = userSign.uAutoPay(userSignInfo.getIdNo(), payMoney, balanceLimit, "1", inMap);
		
		if (num == 0) {
			//入自动缴费表
			UserSignInfoEntity userSignTmp = new UserSignInfoEntity(userSignInfo);
			userSignTmp.setOpTime(curTime);
			userSignTmp.setLoginNo(loginNo);

			AutoPayFieldEntity autoPayField = new AutoPayFieldEntity();
			autoPayField.setPayMoney(payMoney);
			autoPayField.setBalanceLimit(balanceLimit);
			autoPayField.setAutoFlag("1");

			userSign.inAutoPay(userSignTmp, autoPayField);
		}
	}
	
	protected void updateAutoPayCheck(UserSignInfoEntity userSign, S8297UpdateAutoPayInfoInDTO inDto){
		
		if(userSign.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_YHK)||
		   userSign.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_ZFB)){
			
			if(!inDto.getUpdateFlag().equals("2") && !inDto.getUpdateFlag().equals("3")){
				
				long payMoney = inDto.getPayMoney();
				//银行卡、支付宝签约，修改自动缴费金额只能修改为 20、30、50、100、150、200、250、300、350、400、450、500元
				if( !(payMoney == 2000 || payMoney == 3000 || payMoney == 5000 || payMoney == 10000 ||
					payMoney == 15000 || payMoney == 20000 || payMoney == 25000 || payMoney == 30000 ||
					payMoney == 35000 || payMoney == 40000 || payMoney == 45000 || payMoney == 50000) ){
					
					throw new BusiException(AcctMgrError.getErrorCode("8297","00007"), "自动充值金额设置错误,只能为20、30、50、100、150、200、250、300、350、400、450、500元");
				}
			}
		}else if(userSign.getBusiType().equals(PayBusiConst.SIGN_BUSI_TYPE_SJZF)){
			
			if(!inDto.getUpdateFlag().equals("2") && !inDto.getUpdateFlag().equals("3")){
				
				long payMoney = inDto.getPayMoney();
				if( payMoney > 10000000 ){
					
					throw new BusiException(AcctMgrError.getErrorCode("8297","00007"), "自动充值金额设置错误,最多为100000元");
				}
			}
			
			if(!inDto.getUpdateFlag().equals("1") &&!inDto.getUpdateFlag().equals("3")){
				
				throw new BusiException(AcctMgrError.getErrorCode("8297","00008"), "手机支付自动缴费只能修改金额和开关");
			}
		}
	}
	
	protected void sendUpdateMsg(S8297UpdateAutoPayInfoInDTO inDto){
		
		//1：设置金额，2：设置阀值，3：设置开关，4：设置（金额+阀值），5：开通（金额+阀值+开关）
		String updateFlag = inDto.getUpdateFlag();
		
		Map<String, Object> mapTmp = new HashMap<String, Object>();
		MBean inMessage = new MBean();
		inMessage.addBody("PHONE_NO", inDto.getPhoneNo());
		inMessage.addBody("LOGIN_NO", inDto.getLoginNo());;
		inMessage.addBody("OP_CODE", inDto.getOpCode());
		inMessage.addBody("CHECK_FLAG", true);
		
		String flag = control.getPubCodeValue(2011, "DXFS", null);         // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag.equals("0")){
			inMessage.addBody("SEND_FLAG", 0);
		}else if(flag.equals("1")){
			inMessage.addBody("SEND_FLAG", 1);
		}else if(flag.equals("2")){
			return;
		}
		
		if(updateFlag.equals("1")){
			
			//修改缴费金额短信
			/*
			*BOSS_6013:尊敬的客户，您已成功设置自动充值金额，金额为${pay_money}元。设置自动充值阀值请发送“ZDJFFZ +金额”到10086。中国移动${sms_release}
			*/
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(inDto.getPayMoney()));
			mapTmp.put("sms_release", "");
			inMessage.addBody("DATA", mapTmp);
			inMessage.addBody("TEMPLATE_ID", "311200829703");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
		}else if(updateFlag.equals("2")){
			
			//修改阀值短信
			/*
			*BOSS_6012:尊敬的客户，您已成功设置自动充值阀值，阀值为${pay_money}元。设置自动充值单次金额请发送“ZDJFJE+金额”到10086。中国移动${sms_release}
			*/
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(inDto.getThresholdValue()));
			mapTmp.put("sms_release", "");
			inMessage.addBody("DATA", mapTmp);
			inMessage.addBody("TEMPLATE_ID", "311200829704");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
		}else if(updateFlag.equals("3")){
			
			if(inDto.getAutoFlag().equals("1")){
				
				//开通自动缴费开关
				/*
				*BOSS_6010:尊敬的客户，您已成功开通自动充值服务。默认阈值为10元，默认单次充值金额为50元，如修改自动充值阈值请发送“ZDJFYZ +金额”到10086。如修改自动充值单次金额请发送“ZDJFJE+金额”到10086。中国移动${sms_release}
				*/
				mapTmp.put("sms_release", "");
				inMessage.addBody("DATA", mapTmp);
				inMessage.addBody("TEMPLATE_ID", "311200829705");
				log.info("发送短信内容：" + inMessage.toString());
				shortMessage.sendSmsMsg(inMessage, 1);
			}else{
				
				//关闭自动缴费开关
				/*
				*BOSS_6011:尊敬的客户，您已成功取消自动充值服务，欢迎您再次使用。中国移动${sms_release}
				*/
				mapTmp.put("sms_release", "");
				inMessage.addBody("DATA", mapTmp);
				inMessage.addBody("TEMPLATE_ID", "311200829706");
				log.info("发送短信内容：" + inMessage.toString());
				shortMessage.sendSmsMsg(inMessage, 1);
			}
		}else if(updateFlag.equals("4")){
			
			//修改缴费金额短信
			/*
			*BOSS_6013:尊敬的客户，您已成功设置自动充值金额，金额为${pay_money}元。设置自动充值阀值请发送“ZDJFFZ +金额”到10086。中国移动${sms_release}
			*/
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(inDto.getPayMoney()));
			mapTmp.put("sms_release", "");
			inMessage.addBody("DATA", mapTmp);
			inMessage.addBody("TEMPLATE_ID", "311200829703");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
			
			//修改阀值短信
			/*
			*BOSS_6012:尊敬的客户，您已成功设置自动充值阀值，阀值为${pay_money}元。设置自动充值单次金额请发送“ZDJFJE+金额”到10086。中国移动${sms_release}
			*/
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(inDto.getThresholdValue()));
			mapTmp.put("sms_release", "");
			inMessage.setBody("DATA", mapTmp);
			inMessage.setBody("TEMPLATE_ID", "311200829704");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
		}else if(updateFlag.equals("5")){
			
			//修改缴费金额短信
			/*
			*BOSS_6013:尊敬的客户，您已成功设置自动充值金额，金额为${pay_money}元。设置自动充值阀值请发送“ZDJFFZ +金额”到10086。中国移动${sms_release}
			*/
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(inDto.getPayMoney()));
			mapTmp.put("sms_release", "");
			inMessage.addBody("DATA", mapTmp);
			inMessage.addBody("TEMPLATE_ID", "311200829703");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
			
			//修改阀值短信
			/*
			*BOSS_6012:尊敬的客户，您已成功设置自动充值阀值，阀值为${pay_money}元。设置自动充值单次金额请发送“ZDJFJE+金额”到10086。中国移动${sms_release}
			*/
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(inDto.getThresholdValue()));
			mapTmp.put("sms_release", "");
			inMessage.setBody("DATA", mapTmp);
			inMessage.setBody("TEMPLATE_ID", "311200829704");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
			
			//开通自动缴费开关
			/*
			*BOSS_6010:尊敬的客户，您已成功开通自动充值服务。默认阈值为10元，默认单次充值金额为50元，如修改自动充值阈值请发送“ZDJFYZ +金额”到10086。如修改自动充值单次金额请发送“ZDJFJE+金额”到10086。中国移动${sms_release}
			*/
			mapTmp.clear();
			mapTmp.put("sms_release", "");
			inMessage.setBody("DATA", mapTmp);
			inMessage.setBody("TEMPLATE_ID", "311200829705");
			log.info("发送短信内容：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
		}
	}


	public IShortMessage getShortMessage() {
		return shortMessage;
	}


	public void setShortMessage(IShortMessage shortMessage) {
		this.shortMessage = shortMessage;
	}


	public IGoods getGoods() {
		return goods;
	}


	public void setGoods(IGoods goods) {
		this.goods = goods;
	}


	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IPayManage getPayManage() {
		return payManage;
	}

	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IUserSign getUserSign() {
		return userSign;
	}

	public void setUserSign(IUserSign userSign) {
		this.userSign = userSign;
	}
}
