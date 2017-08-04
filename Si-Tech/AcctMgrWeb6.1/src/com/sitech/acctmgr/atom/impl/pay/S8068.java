package com.sitech.acctmgr.atom.impl.pay;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayOutUserData;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.pay.S8068InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8068InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IAgent;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.inter.pay.I8068;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title: 空中充值账户缴费查询  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(m="init",c= S8068InitInDTO.class,oc=S8068InitOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "空中充值账户缴费校验服务",srvVer = "V10.8.126.0", 
			srvDesc = "空中充值账户缴费校验服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否")
			})
public class S8068 extends AcctMgrBaseService implements I8068 {

	private ILogin		login;
	private IAgent		agent;
	private	IUser		user;
	private IAccount	account;
	private IGroup		group;
	private ICust		cust;
	private IRemainFee	remainFee;
	private	IProd		prod;
	private IBalance	balance;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8068#init(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO init(InDTO inParam) {
		
		S8068InitInDTO inDto = (S8068InitInDTO)inParam;
		log.info("S8000 init begin" + inDto.getMbean());
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		/*取当前年月和当前时间*/
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		String sCurYm = sCurDate.substring(0, 6);
		
		//1、获取缴费号码
		String phoneNo = getPayPhone(inDto.getPhoneNo(), inDto.getContractNo());
		
		//2、获取缴费账户
		long contractNo = getPayContractNo(inDto.getPhoneNo(), inDto.getContractNo());

		//3. 获取缴费用户(账户)基本资料
		Map<String, Object> baseInfo = getBaseInfo(phoneNo, contractNo, inDto.getProvinceId());
		
		//4. 限制信息
		initCheck(baseInfo, inDto.getPayPath(), inDto.getGroupId(), inDto.getLoginNo(),inDto.getProvinceId());

		//4. 获取余额、欠费信息
		Map<String, Object> outPerMap = new HashMap<String, Object>();
		outPerMap = remainFee.getPayInitInfo(contractNo);
		List<OweFeeEntity> oweFeeList = (List<OweFeeEntity>)outPerMap.get("BILL_INFO_LIST");
		log.debug("调用完虚拟划拨后，账单列表： " + oweFeeList.toString());
		
		//5.个性业务
		Map<String, Object> sepMap = new HashMap<String, Object>();
		sepMap.put("BASE_INFO", baseInfo);
		sepMap.put("IN_DTO", inDto);
		querySepBusiInfo(sepMap);
		
		//6. 出参DTO封装
		S8068InitOutDTO outDto = new S8068InitOutDTO();
		outDto.setUserData((PayOutUserData)baseInfo.get("USER_DATA"));
		outDto.setFeeData((OutFeeData)outPerMap.get("FEE_DATA"));
		outDto.setOwefeeInfoSize(oweFeeList.size());
		outDto.setOwefeeInfo(oweFeeList);
		
		return outDto;
		
	}

	/**
	 *功能：获取缴费号码，如果传入缴费号码，则按照入参中返回，否则根据账户获取，通用规则，获取账户下优先级最高的号码
	 */
	protected String getPayPhone(String phoneNo, Long contractNo){
		
			return phoneNo;
	}
	
	/***
	 *功能：获取缴费账户，如果传入账户，则按照入参中返回，否则根据缴费号码获取，获取号码对应的空中充值账户
	 */
	private long getPayContractNo(String phoneNo, Long contractNo){
		
		if(contractNo != null && contractNo != 0){
			return contractNo;
		}else{
			
			long agentCon = agent.getAgentCon(phoneNo);
			if(agentCon == 0){
				
				log.info("号码不存在对应的空中充值账户! PHONE_NO: " + phoneNo);
				throw new BusiException(AcctMgrError.getErrorCode("8068","00001"), "号码不存在对应的空中充值账户!");
			}else{
				
				return agentCon;
			}
		}
	}
	
	private Map<String, Object> getBaseInfo(String phoneNo, long contractNo, String provinceId){
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		UserInfoEntity userEntity = user.getUserInfo(phoneNo);
		UserPrcEntity prcEntity = prod.getUserPrcidInfo(userEntity.getIdNo());
		
		//查询账户信息
		ContractInfoEntity conEntity = account.getConInfo(contractNo);
		
		//查询账户地市归属信息
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(conEntity.getGroupId(), "2", provinceId);
		String regionId = groupRelEntity.getRegionCode();
		String regionName = groupRelEntity.getRegionName();
		
		//查询客户信息
		CustInfoEntity custEntity = cust.getCustInfo(conEntity.getCustId(), null);
		
		//查询账户下付费用户个数
		int iUserCnt = account.cntConUserRel(contractNo, null, null);
		
		//取用户信誉度
		long limitOwe = 0;
		
		Map<String, Object> outMap = new HashMap<String, Object>();
		outMap.put("PHONE_NO", phoneNo);
		outMap.put("ID_NO", userEntity == null ? 0 : userEntity.getIdNo());
		outMap.put("REGION_ID", regionId);
		outMap.put("REGION_NAME", regionName);
		outMap.put("GROUP_ID", conEntity.getGroupId());
		outMap.put("BRAND_ID", userEntity.getBrandId());
		outMap.put("RUN_CODE", userEntity.getRunCode());
		
		PayOutUserData userData = new PayOutUserData();
		userData.setBrandName(userEntity.getBrandName());
		userData.setContractattType(conEntity.getContractattType());
		userData.setContractattTypeName(conEntity.getContractattTypeName());
		userData.setContractName(conEntity.getBlurContractName());
		userData.setContractNo(contractNo);
		userData.setCustLevelName(custEntity.getCustLevelName());
		userData.setCustName(custEntity.getCustName());
		switch(userEntity.getOwnerType()){
			case 1: userData.setOwerTypeName("个人");
			case 2: userData.setOwerTypeName("家庭");
			case 3: userData.setOwerTypeName("集团");
			case 4: userData.setOwerTypeName("团体");
		}
		userData.setLimitOwe(limitOwe);
		userData.setPayCode(conEntity.getPayCode());
		userData.setPaycodeName(conEntity.getPayCodeName());
		userData.setPhoneNo(phoneNo);
		userData.setProductName(prcEntity.getProdPrcName());
		userData.setRunCode(userEntity.getRunCode());
		userData.setRunName(userEntity.getRunName());
		userData.setUserCnt(iUserCnt);
		userData.setUserGroupName(regionName);
		
		outMap.put("USER_DATA", userData);
		
		return outMap;
	}
	
	protected void initCheck(Map<String, Object> inMap, String payPath, String loginGroupId, String loginNo, String provinceId){

		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		//前台工号不允许异地缴费
		boolean flag = true;
		if(flag){
			
			//取工号归属地市
			ChngroupRelEntity groupRelEntity = group.getRegionDistinct(loginGroupId, "2", provinceId);
			String regionId = groupRelEntity.getRegionCode();
			if(!inMap.get("REGION_ID").equals(regionId)){
				
				log.info("前台工号不允许跨地市缴纳空中充值预存款!" + "conRegion: " + inMap.get("REGION_ID") + "loginRegion" + regionId);
				throw new BusiException(AcctMgrError.getErrorCode("8068","00002"), "前台工号不允许跨地市缴纳空中充值预存款!");
			}
		}
		
		PayOutUserData userData = (PayOutUserData)inMap.get("USER_DATA");
		//非空中充值账户不允许空中充值账户缴费
		if(!userData.getContractattType().equals(PayBusiConst.AIR_RECHARGE_CONTYPE)){
			
			log.info("非空中充值账户不允许在该模块缴费! con: " + userData.getContractNo());
			throw new BusiException(AcctMgrError.getErrorCode("8068","00003"), "非空中充值账户不允许在该模块缴费!");
		}
		
		//dagtbaseMsg 验证是否做绑定
		if(!agent.isKcAgentPhone(userData.getPhoneNo(), String.valueOf(userData.getContractNo()))){
			throw new BusiException(AcctMgrError.getErrorCode("8068","00005"), "此空中充值账户已关闭,请咨询当地渠道管理人员!");
		}
		
		if(payPath.equals("02")){
			if(!balance.isAgentCheck(userData.getPhoneNo(), userData.getContractNo())){
				throw new BusiException(AcctMgrError.getErrorCode("8068","00004"), "该代理商没有申请网厅空中充值账户缴费权限!");
			}
		}
	}

	protected  void querySepBusiInfo(Map<String, Object>inParam){
		
		
	}

	
	
	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IAgent getAgent() {
		return agent;
	}

	public void setAgent(IAgent agent) {
		this.agent = agent;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IRemainFee getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
	}

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
	}
	
}
