package com.sitech.acctmgr.atom.impl.pay;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.domains.account.ConTrustEntity;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.collection.CollectionBillEntity;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.record.ActCollBillRecdEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.GroupchgInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S8030CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8030CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8030InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8030InitOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8030getConNoInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8030getConNoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.ICheque;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I8030;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

import java.util.*;

/**
 *
 * <p>
 * Title: 托收缴费业务基类	</p>
 * Description: 托收缴费业务基类，定义托收缴费流程和公共实现</p>
 * Copyright: Copyright (c) 2014
 * Company: SI-TECH
 * 
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({ 
	
	@ParamType(m="getConNo",c= S8030getConNoInDTO.class,oc=S8030getConNoOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "托收缴费查询托收账户",srvVer = "V10.8.126.0", 
			srvDesc = "托收缴费查询托收账户",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="init",c= S8030InitInDTO.class,oc=S8030InitOutDTO.class, 
			routeKey ="12",routeValue = "cntract_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "托收缴费查询校验服务",srvVer = "V10.8.126.0", 
			srvDesc = "托收缴费查询校验服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="cfm",c= S8030CfmInDTO.class,oc=S8030CfmOutDTO.class, 
			routeKey ="12",routeValue = "cntract_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "托收缴费确认服务",srvVer = "V10.8.126.0", 
			srvDesc = "托收缴费确认服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否")

			})
public class S8030 extends AcctMgrBaseService implements I8030 {

	private IBill 		bill;
	private IAccount 	account;
	private IGroup		group;
	private IUser 		user;
	private IPreOrder 	preOrder;
	private IRecord 	record;
	private IWriteOffer writeOffer;
	private IControl	control;
	private ICheque		cheque;
	private IPayManage	payManage;
	private	IBase		base;
	private ILogin		login;
	
	
	/**
	 * 名称：托收缴费查询托收账户
	 * 
	 * @param LOGIN_NO
	 * @param PHONE_NO
	 * 
	 * @return AGENT_CONTRACT.ID_NO
	 * @return AGENT_CONTRACT.CONTRACT_NO
	 * @return AGENT_CONTRACT.CONTRACT_NAME
	 * @return AGENT_CONTRACT.CONTRACTATT_NAME
	 * @author qiaolin
	 */
	public final OutDTO getConNo(final InDTO inParam) {

		S8030getConNoInDTO inDto = (S8030getConNoInDTO) inParam;
		String phoneNo = inDto.getPhoneNo();

		log.info("托收缴费查询托收账户getContractNo begin" + inParam.getMbean());

		UserInfoEntity userEntity = user.getUserEntity(null, phoneNo, null, true);
		
		//获取托收账户列表
		List<ContractEntity> conList = account.getCollectionConList(userEntity.getIdNo());

		S8030getConNoOutDTO outDto = new S8030getConNoOutDTO();
		outDto.setCollection(conList);

		log.info("托收缴费查询托收账户getContractNo end! outParam:" + outDto.toJson());

		return outDto;
	}

	/**
	 * 名称：托收缴费查询 1.Dto参数校验 2.获取托收单信息 3.取托收账户信息 4.获取银行信息 5.获取托收账户某个年月的账单（已冲销+未冲销）
	 * 
	 * @param LOGIN_NO
	 * @param CONTRACT_NO
	 * @param YEAR_MONTH	: 查询年月
	 * 
	 * @return PAY_ACCEPT 	: 缴费流水 可以传出多个流水，中间用逗号分隔
	 * @return TOTAL_DATE 	: 缴费日期
	 * @author qiaolin
	 */
	public final OutDTO init(final InDTO inParam) {

		S8030InitInDTO inDto = (S8030InitInDTO) inParam;
		log.info("托收缴费查询 S8030.init begin: " + inDto.getMbean());
		
		String loginNo = inDto.getLoginNo();
		long inContractNo = inDto.getContractNo();
		String inYm = inDto.getYearMonth();
		int billCycle = Integer.parseInt(inYm);

		//获取托收账户账单信息
		CollectionBillEntity collectionBill = bill.getCollectionBill(inContractNo, billCycle);
		if (collectionBill == null) {
			log.info("该托收单不存在，或已经处理");
			throw new BusiException(AcctMgrError.getErrorCode("8030", "00003"),
					"该托收单不存在，或已经处理");
		}
		
		// 2.获取托收账户信息
		ContractInfoEntity  contractEntity = account.getConInfo(inContractNo);
		if (contractEntity == null) {
			log.info("获取托收账户信息失败contract_no : " + inContractNo);
			throw new BusiException(AcctMgrError.getErrorCode("8030", "00000"),
					"获取托收账户信息失败contract_no : " + inContractNo);
		}
		GroupchgInfoEntity groupchgEntity = group.getChgGroup(null, null, inContractNo);
		String conGroupId = groupchgEntity.getGroupId();
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(conGroupId, "2", inDto.getProvinceId());
		String regionName = groupRelEntity.getRegionName();

		// 3.获取银行信息
		ConTrustEntity accBank = account.getContrustInfo(inContractNo);
		if(accBank == null){
			log.info("获取托收账户银行信息失败");
			throw new BusiException(AcctMgrError.getErrorCode("8030", "00001"),"获取托收账户银行信息失败");
		}
		String bankCode =accBank.getBankCode();
		
		BankEntity bankEntity = base.getBankInfo(conGroupId, inDto.getProvinceId(), accBank.getBankCode(), null).get(0);
		if (bankEntity == null) {
			log.info("银行代码无对应的银行名称失败!bank_code : " + bankCode);
			throw new BusiException(AcctMgrError.getErrorCode("8030", "00000"),
					"银行代码无对应的银行名称,bank_code : " + bankCode);
		}
		String bankName = bankEntity.getBankName();

		// 5.获取托收账户下所有用户某个年月的账单信息（已冲销+未冲销)
		List<OweFeeEntity> feeList = getAllBill(inContractNo, billCycle);
			
		// 拼装出参
		S8030InitOutDTO outDto = new S8030InitOutDTO();
		outDto.setBankCode(bankCode);
		outDto.setBankName(bankName);
		outDto.setRegionName(regionName);
		outDto.setPayFee(collectionBill.getPayFee());
		outDto.setPayNum(collectionBill.getPayNum());
		outDto.setContractName(contractEntity.getBlurContractName());
		outDto.setAccountNo(accBank.getAccountNo());
		outDto.setOweFeeList(feeList);

		log.info("托收缴费查询 S8030.init end! 报文： " + outDto.toJson());

		return outDto;

	}

	/**
	 * 名称：托收缴费确认 1.Dto参数校验 2.取用户基本信息 3.缴费入账 4.实时冲销账户欠费 5.更新托收记录表 6.记录托收日志
	 * 7.记录营业员操作日志 8.给CRM发送营业日报
	 * 
	 * @param LOGIN_NO: 工号，非空
	 * @param LOGIN_PASSWORD: 工号密码，非空
	 * @param GROUP_ID: 工号组织机构归属，非空
	 * @param OP_CODE: 模块编码，写死传入8000
	 * 
	 * @return PAY_ACCEPT : 缴费流水 可以传出多个流水，中间用逗号分隔
	 * @return TOTAL_DATE : 缴费日期
	 * @author qiaolin
	 */
	public final OutDTO cfm(final InDTO inParam) {

		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;

		S8030CfmInDTO inDto = (S8030CfmInDTO) inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		log.info("托收缴费查询 S8030.cfm begin : " + inDto.getMbean());

		/* 取当前年月和当前时间 */
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		/*
		 *缴费确认必要校验 
		 **/
		cfmCheck(inDto.getOpCode(), Long.parseLong(inDto.getPayMoney()));
		
		String phoneNo = getPayPhone(inDto.getPhoneNo(), inDto.getContractNo());
		long contractNo = inDto.getContractNo();
		
		//3、获取缴费确认需要基本资料
		PayUserBaseEntity payUserBase = getCfmBaseInfo(phoneNo, contractNo, inDto.getProvinceId());
		if(inDto.getPhoneNo()!=null && !inDto.getPhoneNo().equals("99999999999"))
			payUserBase.setPhoneFlag(true);
		else
			payUserBase.setPhoneFlag(false);
		
		//获取托收账户账单信息
		CollectionBillEntity collectionBill = bill.getCollectionBill(contractNo, inDto.getYearMonth());
		if (collectionBill == null) {
			log.info("该托收单不存在，或已经处理");
			throw new BusiException(AcctMgrError.getErrorCode("8030", "00001"),"该托收单不存在，或已经处理");
		}
		if(Long.parseLong(inDto.getPayMoney()) != collectionBill.getPayFee()){
			
			throw new BusiException(AcctMgrError.getErrorCode("8030", "00002"),"缴费金额与托收账单金额不一致");
		}
		
		long paySn = control.getSequence("SEQ_PAY_SN");
		PayBookEntity bookIn = new PayBookEntity();
		bookIn.setPaySn(paySn);
		bookIn.setTotalDate(Integer.parseInt(sTotalDate));
		bookIn.setPayPath(inDto.getPayPath());
		bookIn.setPayMethod(inDto.getPayMethod());
		bookIn.setPayType(inDto.getPayType());
		bookIn.setPayFee(collectionBill.getPayFee());
		bookIn.setStatus("0");
		bookIn.setBeginTime(sCurTime);
		bookIn.setPrintFlag("");
		bookIn.setYearMonth(Long.parseLong(sCurYm));
		bookIn.setLoginNo(inDto.getLoginNo());
		bookIn.setGroupId(inDto.getGroupId());
		bookIn.setOpCode(inDto.getOpCode());
		bookIn.setOpNote(inDto.getPayNote());
		
		//实时入账
		payManage.saveInBook(inDto.getHeader(), payUserBase, bookIn);
		
		//4.入payment表
		record.savePayMent(payUserBase, bookIn);

		//5.冲销欠费
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("Header", inDto.getHeader());
		inMapTmp.put("PAY_SN", paySn);
		inMapTmp.put("CONTRACT_NO", contractNo);
		inMapTmp.put("LOGIN_NO", inDto.getLoginNo());
		inMapTmp.put("GROUP_ID", inDto.getGroupId());
		inMapTmp.put("OP_CODE", inDto.getOpCode());
		inMapTmp.put("PAY_PATH", inDto.getPayPath());
		inMapTmp.put("BILL_YM", inDto.getYearMonth());
		writeOffer.doWriteOff(inMapTmp);
			
		// 5.更新托收账单
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		inMapTmp.put("BILL_CYCLE", inDto.getYearMonth());
		bill.updateCollbill(contractNo, inDto.getYearMonth(), null, "1");

		Map<String, Object> collBillKey = new HashMap<String, Object>();
		collBillKey.put("CONTRACT_NO", contractNo);
		collBillKey.put("BILL_CYCLE", inDto.getYearMonth());
		Map<String, Object> reportMap1 = new HashMap<String, Object>();
		reportMap1.put("ACTION_ID", "1009");
		reportMap1.put("KEY_DATA", collBillKey);
		reportMap1.put("LOGIN_SN", paySn);
		reportMap1.put("OP_CODE", inDto.getOpCode());
		reportMap1.put("LOGIN_NO", inDto.getLoginNo());
		preOrder.sendReportData(inDto.getHeader(), reportMap1);

		//6.记录托收日志
		ActCollBillRecdEntity collbillRecd = new ActCollBillRecdEntity();
		collbillRecd.setContractNo(contractNo);
		collbillRecd.setBillCycle(inDto.getYearMonth());
		collbillRecd.setTotalDate(Integer.parseInt(sTotalDate));
		collbillRecd.setLoginAccept(paySn);
		collbillRecd.setPayFee(collectionBill.getPayFee());
		collbillRecd.setFetchNo(sCurYm);
		collbillRecd.setOpCode(inDto.getOpCode());
		collbillRecd.setLoginNo(inDto.getLoginNo());
		collbillRecd.setGroupId(collectionBill.getGroupId());
		collbillRecd.setOrgId(inDto.getGroupId());
		collbillRecd.setRemark(inDto.getPayNote());
		record.saveCollbillRecd(collbillRecd);

		List<Map<String, Object>> datatList = new ArrayList<Map<String, Object>>();
		Map<String, Object> snKey = new HashMap<String, Object>();
		snKey.put("CONTRACT_NO", contractNo);
		snKey.put("BILL_CYCLE", inDto.getYearMonth());
		snKey.put("LOGIN_ACCEPT", paySn);
		snKey.put("TABLE_NAME", "ACT_COLLBILL_RECD");
		snKey.put("UPDATE_TYPE", "I");
		datatList.add(snKey);
		Map<String, Object> reportMap = new HashMap<String, Object>();
		reportMap.put("ACTION_ID", "1008");
		reportMap.put("KEYS_LIST", datatList);
		reportMap.put("LOGIN_SN", paySn);
		reportMap.put("OP_CODE", inDto.getOpCode());
		reportMap.put("LOGIN_NO", inDto.getLoginNo());
		preOrder.sendReportDataList(inDto.getHeader(), reportMap);
		
		// 7.记录营业员操作日志
		LoginOprEntity loginOprEn = new LoginOprEntity();
		loginOprEn.setLoginNo(inDto.getLoginNo());
		loginOprEn.setLoginGroup(inDto.getGroupId());
		loginOprEn.setLoginSn(paySn);
		loginOprEn.setIdNo(payUserBase.getIdNo());
		loginOprEn.setPhoneNo(phoneNo);
		loginOprEn.setBrandId(payUserBase.getBrandId());
		loginOprEn.setTotalDate(Long.parseLong(sTotalDate));
		loginOprEn.setPayType(inDto.getPayType());
		loginOprEn.setPayFee(collectionBill.getPayFee());
		loginOprEn.setOpCode(inDto.getOpCode());
		loginOprEn.setRemark(inDto.getPayNote());
		record.saveLoginOpr(loginOprEn);

		// 4、向其他系统同步数据（目前：CRM营业日报、BOSS报表、统一接触）
		List<Map<String, Object>> keysList=new ArrayList<Map<String,Object>>();
		Map<String, Object> paymentKey = new HashMap<String, Object>();
		paymentKey.put("YEAR_MONTH", sCurYm);
		paymentKey.put("CONTRACT_NO", contractNo);
		paymentKey.put("PAY_SN", paySn);
		paymentKey.put("ID_NO", payUserBase.getIdNo());
		paymentKey.put("PAY_TYPE", inDto.getPayType());
		paymentKey.put("TABLE_NAME", "BAL_PAYMENT_INFO");
		paymentKey.put("UPDATE_TYPE", "I");
		keysList.add(paymentKey);
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("PAY_SN", paySn);
		inMapTmp.put("LOGIN_NO", inDto.getLoginNo());
		inMapTmp.put("GROUP_ID", inDto.getGroupId());
		inMapTmp.put("OP_CODE", inDto.getOpCode());
		inMapTmp.put("PHONE_NO", phoneNo);
		inMapTmp.put("BRAND_ID", payUserBase.getBrandId());
		inMapTmp.put("BACK_FLAG", "0");
		inMapTmp.put("OLD_ACCEPT", paySn);
		inMapTmp.put("OP_TIME", sCurTime);
		inMapTmp.put("OP_NOTE", inDto.getPayNote());
		inMapTmp.put("ACTION_ID", "1001");
		//inMapTmp.put("KEY_DATA", paymentKey);
		inMapTmp.put("REGION_ID", payUserBase.getRegionId());
		inMapTmp.put("KEYS_LIST", keysList);
		if (payUserBase.isPhoneFlag()) {

			inMapTmp.put("CUST_ID_TYPE", "1"); // 0客户ID;1-服务号码;2-用户ID;3-账户ID
			inMapTmp.put("CUST_ID_VALUE", phoneNo);
		} else {

			inMapTmp.put("CUST_ID_TYPE", "3"); // 0客户ID;1-服务号码;2-用户ID;3-账户ID
			inMapTmp.put("CUST_ID_VALUE", String.valueOf(contractNo));
		}
		inMapTmp.put("Header", inDto.getHeader());
		preOrder.sendData2(inMapTmp);

		S8030CfmOutDTO outDto = new S8030CfmOutDTO();
		outDto.setPayAccept(paySn);
		outDto.setTotalDate(sTotalDate);
		log.info("托收缴费查询 S8030.cfm end!: " + outDto.toJson());
		return outDto;

	}
	
	
	/**
	 *功能：获取缴费号码，如果传入缴费号码，则按照入参中返回，否则根据账户获取，通用规则，获取账户下优先级最高的号码
	 */
	protected String getPayPhone(String phoneNo, Long contractNo){
		
		if(phoneNo != null && !phoneNo.equals("")){
			
			return phoneNo;
		}else{
			
			String defPhone = account.getPayPhoneByCon(contractNo);
			if (defPhone.equals("")) {
				defPhone = "99999999999";
			}
			
			return defPhone;
		}
	}

	/**
	* 名称：缴费确认必有校验
	* @param opCode
	* @param payMoney
	*/
	protected void cfmCheck(String opCode, long payMoney) {
		
		/*缴费限额*/
		long payLimitFee = control.getLimitFee(opCode, 0L, "TSJF");
		if (payMoney > payLimitFee) {
			log.info("托收缴费[ " + payMoney / 100 + " ]元，超过限额 [ "
					+ payLimitFee / 100 + " ]元！");
			throw new BusiException(AcctMgrError.getErrorCode(
					opCode, "00010"), "托收缴费[ " + payMoney
					/ 100 + " ]元，超过限额 [ " + payLimitFee / 100 + " ]元！");
		}
	}
	
	private PayUserBaseEntity getCfmBaseInfo(String phoneNo, long contractNo, String provinceId){
		
		UserInfoEntity userInfo = null;
		String brandId = "XX";
		long   idNo = 0;
		if(!phoneNo.equals("99999999999")){
			
			userInfo = user.getUserInfo(phoneNo);
			idNo = userInfo.getIdNo();
			brandId = userInfo.getBrandId();
		}
		
		//取账户归属
		GroupchgInfoEntity groupChgEntity = group.getChgGroup(null, null, contractNo);
		
		// 缴费用户归属地市
		ChngroupRelEntity groupEntity = group.getRegionDistinct(groupChgEntity.getGroupId(), "2", provinceId);
		String regionId = groupEntity.getRegionCode();
		
		PayUserBaseEntity payUserBase = new PayUserBaseEntity();
		payUserBase.setIdNo(idNo);
		payUserBase.setPhoneNo(phoneNo);
		payUserBase.setContractNo(contractNo);
		payUserBase.setUserGroupId(groupChgEntity.getGroupId());
		payUserBase.setRegionId(regionId);
		payUserBase.setBrandId(brandId);
		
		return payUserBase;
	}
	
	private List<OweFeeEntity> getAllBill(long contractNo, int billCycle){
		
		List<OweFeeEntity> outList = new ArrayList<OweFeeEntity>();
		
		List<ContractEntity> conList = account.getUserList(contractNo);
		for(ContractEntity conEntity : conList){
			
			OweFeeEntity oweFeeEntity = bill.getBillInfo(contractNo, conEntity.getId(), billCycle);
			String phoneNo = "";
			UserInfoEntity userEntity = user.getUserEntity(conEntity.getId(), null, null, false);
			if(userEntity == null){
				
				List<UserDeadEntity>  userDeadList = user.getUserdeadEntity(null, conEntity.getId(), null);
				phoneNo = userDeadList.get(0).getPhoneNo();
			}else{
				
				phoneNo = userEntity.getPhoneNo();
			}
			oweFeeEntity.setPhoneNo(phoneNo);
			outList.add(oweFeeEntity);
		}
		
		return outList;
	}

	
	/**
	 * @return the login
	 */
	public ILogin getLogin() {
		return login;
	}

	/**
	 * @param login the login to set
	 */
	public void setLogin(ILogin login) {
		this.login = login;
	}

	/**
	 * @return the bill
	 */
	public IBill getBill() {
		return bill;
	}

	/**
	 * @param bill the bill to set
	 */
	public void setBill(IBill bill) {
		this.bill = bill;
	}

	/**
	 * @return the account
	 */
	public IAccount getAccount() {
		return account;
	}

	/**
	 * @param account the account to set
	 */
	public void setAccount(IAccount account) {
		this.account = account;
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	/**
	 * @return the preOrder
	 */
	public IPreOrder getPreOrder() {
		return preOrder;
	}

	/**
	 * @param preOrder the preOrder to set
	 */
	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

	/**
	 * @return the writeOffer
	 */
	public IWriteOffer getWriteOffer() {
		return writeOffer;
	}

	/**
	 * @param writeOffer the writeOffer to set
	 */
	public void setWriteOffer(IWriteOffer writeOffer) {
		this.writeOffer = writeOffer;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}

	/**
	 * @return the cheque
	 */
	public ICheque getCheque() {
		return cheque;
	}

	/**
	 * @param cheque the cheque to set
	 */
	public void setCheque(ICheque cheque) {
		this.cheque = cheque;
	}

	/**
	 * @return the payManage
	 */
	public IPayManage getPayManage() {
		return payManage;
	}

	/**
	 * @param payManage the payManage to set
	 */
	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
	}

	/**
	 * @return the base
	 */
	public IBase getBase() {
		return base;
	}

	/**
	 * @param base the base to set
	 */
	public void setBase(IBase base) {
		this.base = base;
	}

}
