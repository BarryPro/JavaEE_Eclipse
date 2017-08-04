package com.sitech.acctmgr.atom.busi.pay;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayOpener;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgrint.atom.busi.intface.ISvcOrder;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.DateUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
/**
 *
 * <p>Title:  缴费开机类 </p>
 * <p>Description: 存放各类开机方法  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class PayOpener extends BaseBusi implements IPayOpener  {
	
	private	IUser			user;
	private	IProd			prod;
	private IRemainFee		remainFee;
	private IGroup			group;
	private IAccount	    account;
	private IControl		control;
	private ISvcOrder 		svcOrder;

	@Override
	public void doConUserOpen(Map<String, Object> Header, PayUserBaseEntity userBase, PayBookEntity inBook, String provinceId) {
		
		log.info("doConUserOpen begin: " + Header + userBase + inBook);
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/**
		 * 判断应急开关是否打开，如果打开则前台开机，否则通过实销或者离线触发信控进行开机
		 */
		String yjkjFlag = control.getPubCodeValue(2016, "YJKJ", null);
		if(yjkjFlag.equals("1")){
			
			log.error("非应急状态，走信控开机！");
			return;
		}
		
		//个性化方法
		sepBusiInfo(Header, userBase, inBook, provinceId);

		long remainFee = getOpenRemainFee(userBase.getContractNo());
		if (remainFee < 0) {

			log.error("账户余额小于0，不开机！账户余额： " + remainFee);
			return;
		}
		
		/* 按优先级遍历账户下的所有付费用户，依次开机 */
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", userBase.getContractNo());
		List<Map<String, Object>> resultList = baseDao.queryForList("cs_conuserrel_info.qByConNoForOpen", inMapTmp);
		for (Map<String, Object> phone : resultList) {
			
			long openIdNo = Long.valueOf(phone.get("ID_NO").toString());
			
			onePhoneOpen(openIdNo, userBase.getContractNo(), Header, inBook, provinceId);
		}
		
	}
	
	/***
	 *给单个号码做开机 
	 */
	protected void onePhoneOpen(long idNo, long contractNo, Map<String, Object> Header, PayBookEntity inBook, String provinceId){
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		//取开机用户基本信息
		
		UserInfoEntity userEntity = user.getUserEntity(idNo, null, null, true);
		String group_id = userEntity.getGroupId();
		String phoneNo =  userEntity.getPhoneNo();
		
		UserDetailEntity userDetailEntity = user.getUserdetailEntity(idNo);
		String oldRun = userDetailEntity.getRunCode();
		int iCardType = userDetailEntity.getCardType();
		String sUserGradeCode = userDetailEntity.getUserGradeCode();

		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(group_id, "2", provinceId);
		String regionCode = groupRelEntity.getRegionCode();

		//判断用户状态是否需要开机
		String codeValue = control.getPubCodeValue(2000, "OPEN_FLAG", null); //可以开机的状态
		if( -1 == codeValue.indexOf(oldRun) ){
			
			log.info("当前用户状态不需要开机id["+idNo+"]run_code["+oldRun+"]");
			
			return;
		}
		
		if(!isOpen(contractNo, idNo)){
			return;
		}
		
		//取信誉度
/*			inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("ID_NO", openIdNo);
		inMapTmp.put("CARD_TYPE", iCardType);
		inMapTmp.put("REGION_CODE", regionCode);
		inMapTmp.put("USER_GRADE_CODE", sUserGradeCode);
		outMapTmp = credit.pGetCreditInfo(inMapTmp);
		long lLimitOwe = Long.parseLong(outMapTmp.get("LIMIT_OWE")
				.toString());

		if (remainFee + lLimitOwe < 0) {
			log.info("账户余额加用户信誉度小于等于0，余额：" + remainFee + "信誉度：" + lLimitOwe);
			continue;
		}*/
		
		//取用户品牌
		UserBrandEntity userbrandEntity = user.getUserBrandRel(idNo);
		String brand_id = userbrandEntity.getBrandId();
		
		/*
		 * 对需要开机用户执行开机操作
		 * 1、记录状态变更记录
		 * 2、给CRM发送消息，用户状态变更
		 * */
		/*1记录状态变更记录*/
/*			inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("TOTAL_DATE", sTotaldate);
		inMapTmp.put("PAY_SN", inParam.get("PAY_SN"));
		inMapTmp.put("ID_NO", openIdNo);
		inMapTmp.put("CONTRACT_NO", contractNo);
		inMapTmp.put("GROUP_ID", group_id);
		inMapTmp.put("BRAND_ID", brand_id);
		inMapTmp.put("PHONE_NO", phoneNo);
		inMapTmp.put("OLD_RUN", oldRun);
		inMapTmp.put("RUN_CODE", "A");
		inMapTmp.put("OP_CODE", inParam.get("OP_CODE"));
		inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
		inMapTmp.put("LOGIN_GROUP", inParam.get("LOGIN_GROUP"));
		inMapTmp.put("REMARK", "缴费开机");
		inMapTmp.put("SUFFIX", sCurYm);
		baseDao.insert("bal_userchg_recd.iUserchgYm",inMapTmp);*/
		
		/*3给CRM发送消息，用户状态变更*/
		Map<String, Object> userChgMap = new HashMap<String, Object>();
		userChgMap.put("LOGIN_ACCEPT", inBook.getPaySn());
		userChgMap.put("ID_NO", String.valueOf(idNo));
		userChgMap.put("PHONE_NO", phoneNo);
		userChgMap.put("RUN_CODE", "A");
		userChgMap.put("OP_TIME", sCurTime);
		userChgMap.put("LOGIN_NO", inBook.getLoginNo());
		userChgMap.put("OP_CODE", inBook.getOpCode());
		userChgMap.put("OWNER_FLAG", "1");
		userChgMap.put("OPEN_FLAG", "2");
		//userChgMap.put("OPEN_FLAG", "1");        //暂时只改状态
		userChgMap.put("GROUP_ID", group_id);
		userChgMap.put("BRAND_ID", brand_id);
		log.info("调用接口opUserStatuInter前： " + userChgMap.toString());
		svcOrder.opUserStatuInter(userChgMap);
		log.info("调用接口opUserStatuInter完成！");
	}
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.pay.IPayOpener#updateExpireTime(java.util.Map)
	 */
	@Override
	public void updateExpireTime(Map<String, Object> inParam) {

		Map<String, Object> inMapTmp = null;/*临时变量:入参*/
		Map<String, Object> outMapTmp = null;/*临时变量:出参*/
		Map<String, Object>	outParam = new HashMap<String, Object>();
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		long add_days = 0;

		log.info( "更新标准神州行有效期 pUpUserExpireTime begin" );
		
		//取当前用户状态
		UserDetailEntity userDetailEntity = user.getUserdetailEntity(Long.parseLong(inParam.get("ID_NO").toString()));
		String run_code = userDetailEntity.getRunCode();
		
		//取用户主产品标识
		UserPrcEntity userPrcEntity = prod.getUserPrcidInfo(Long.parseLong(inParam.get("ID_NO").toString()));
		String prod_prcid = userPrcEntity.getProdPrcid();
		
		//根据缴费金额取有效期延长天数
		String	time_code = "";
		long days = 0;
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("REGION_CODE", (String) inParam.get("REGION_CODE"));
		inMapTmp.put("STATUS", "1");
		inMapTmp.put("PROD_PRCID", prod_prcid);
		inMapTmp.put("PAY_MONEY", inParam.get("PAY_MONEY"));
		result = (Map<String, Object>) baseDao.queryForObject("bal_expirepaytime_conf.qByReginProdMoney", inMapTmp);
		if (result == null) {
			log.info("该用户不需要延长有效期");
			return ;
		} else {
			time_code = (String) result.get("TIME_CODE");
			days = Long.valueOf(result.get("DAYS").toString());
		}
		
		//取可以延长的最长天数
		long max_days = 0;
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put( "REGION_CODE" , (String)inParam.get("REGION_CODE") );
		inMapTmp.put( "STATUS" , "1" );
		result = (Map<String, Object>)baseDao.queryForObject("bal_expirepaytime_conf.qMaxDayByRegin", inMapTmp);
		if ( result == null ){
			log.info("取可以延长的最长天数失败,region_id: " + (String)inParam.get("REGION_CODE") );
			throw new BusiException(AcctMgrError.getErrorCode("8000","00001"), "取可以延长的最长天数失败");
		}else {
			max_days = Long.valueOf(result.get("DAYS").toString());
		}
		
		//取用户到期天数
		int	expire_days = 0;
		String	begin_time = "";
		String oldExpireTime = "";
		String	expire_time = "";
		String	expire_time_type = "";
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put( "ID_NO" , (Long)inParam.get("ID_NO") );
		result = (Map<String, Object>)baseDao.queryForObject("bal_userexpire_info.qUserexpireInfoByIdNo", inMapTmp);
		if ( result == null ){
			log.info("ur_UserExpire_info表中无数据");
			return ;
		}else {
			expire_days = Integer.valueOf(result.get("EXPIREDAYS").toString());
			begin_time = (String)result.get("BEGIN_TIME1");
			expire_time = (String)result.get("EXPIRE_TIME1");
			oldExpireTime = expire_time;
			expire_time_type = (String)result.get("EXPIRE_TIME_TYPE");
		}
		
	    /*延长时间不能超过max_days - expire_days)*/
	    if ( days > max_days - expire_days){
	        add_days = max_days - expire_days;
	    }
	    else{
	        add_days = days;    
	    }
	    
	    //如果该用户有效期已经超过当前时间：即expire_days<0 ，则有效期从当前时间算起,延长时间
	    if (expire_days < 0)
	        add_days = add_days - expire_days;
	    
	    //缴费前用户状态不正常，则开始时间为当前时间，到期时间为：当前时间+延长时间
	    if( !run_code.equals("A") ){
	        expire_time = (String)inParam.get("CUR_TIME");
	        add_days=days;
	    }
	    
	    //计算出延长后的用户有效期
	    expire_time = DateUtil.toStringPlusDays( expire_time, (int)add_days, "yyyyMMddHHmmss" );
	    
	    //更新有效期
	    inMapTmp = new HashMap<String, Object>();
	    inMapTmp.put("ID_NO", (Long)inParam.get("ID_NO"));
	    inMapTmp.put("OLD_EXPIRE", oldExpireTime);
	    inMapTmp.put("EXPIRE_TIME", expire_time);
	    baseDao.update("bal_userexpire_info.uExpire", inMapTmp);
	    
	    //记录有效期变更记录
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("ID_NO", (Long) inParam.get("ID_NO"));
		inMapTmp.put("LOGIN_ACCEPT", (Long) inParam.get("PAY_SN"));
		inMapTmp.put("TOTAL_DATE", Long.valueOf((String)inParam.get("TOTAL_DATE")));
		inMapTmp.put("TIME_CODE", time_code);
		inMapTmp.put("DAYS", add_days);
		inMapTmp.put("LOGIN_NO", (String) inParam.get("LOGIN_NO"));
		inMapTmp.put("OP_CODE", (String) inParam.get("OP_CODE"));
		inMapTmp.put("REMARK", "神州行延长有效期");
		result = (Map<String, Object>)baseDao.insert("bal_expirelist_recd.insert",inMapTmp);
		
		log.info( "更新标准神州行有效期 pUpUserExpireTime end" );
		
		return ;
		
	}
	
	
	public  void cancelExpireTime(Map<String, Object> inParam){
		
		Map<String, Object> inMapTmp = null;/*临时变量:入参*/	
		Map<String, Object> result = new HashMap<String, Object>();
		
		long add_days = 0;

		log.info( "取消标准神州行余额有效期限制 cancelExpireTime begin" );
		
	    //取消有限期限制
	    inMapTmp = new HashMap<String, Object>();
	    inMapTmp.put("ID_NO", (Long)inParam.get("ID_NO"));
	    baseDao.update("bal_userexpire_info.uCEasyOwnExpire", inMapTmp);
	    	    
	    //记录有效期变更记录
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("ID_NO", (Long) inParam.get("ID_NO"));
		inMapTmp.put("LOGIN_ACCEPT", (Long) inParam.get("PAY_SN"));
		inMapTmp.put("TOTAL_DATE", inParam.get("TOTAL_DATE"));
		inMapTmp.put("OP_TIME", inParam.get("TOTAL_DATE"));
		inMapTmp.put("LOGIN_NO", (String) inParam.get("LOGIN_NO"));
		inMapTmp.put("OP_CODE", (String) inParam.get("OP_CODE"));
		inMapTmp.put("REMARK", inParam.get("REMARK"));
		result = (Map<String, Object>)baseDao.insert("bal_expirelist_recd.insert",inMapTmp);
		
		log.info( "取消标准神州行有效期限制 cancelExpireTime end" );
		
		return ;
		
	}
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.pay.inter.IPayOpener#upAwokeTime(long, long, long)
	 */
	@Override
	public boolean upAwokeTime(long lIdNo, int flag) {
		
		String sAwkeCode = "";
		
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("ID_NO", lIdNo);
		
		if(0 == flag || 2 == flag){
			sAwkeCode = "A";
			inMapTmp.put("AWKE_TIME", sAwkeCode);
		}else if(1 == flag){
			sAwkeCode = "PAY:8";
		}

		inMapTmp.put("AWOKE_CODE", sAwkeCode);
		
		baseDao.update("cct_awoketime_info.uAwokeType", inMapTmp);
		
		return true;
	}
	
	
	/**
	* 名称：通用版本，判断开机用户的除缴费账户外的其它代付账户是否欠费
	* @param 
	* @return 
	*/
	protected boolean isOpen(long contractNo, long idNo) {
		
		Map<String, Object> inMapTmp = null;
		
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("ID_NO", idNo);
		inMapTmp.put("VALID", "VALID");
		List<ContractEntity> resultList = (List<ContractEntity>)baseDao.queryForList("cs_conuserrel_info.selectConUserList", inMapTmp);
		for(ContractEntity conEntity: resultList){
			
			if(conEntity.getPayCode().equals("3") || conEntity.getPayCode().equals("E")){	//托收和集团托收不校验
				log.error("托收和集团托收不校验： CON: " + conEntity.getCon());
				continue;
			}
			
			//只有个人类型账户参与校验
			if(!(conEntity.getAttType().equals("0") || conEntity.getAttType().equals("r") 
					||conEntity.getAttType().equals("g"))){
				log.error("账户类型不是个人类，不需要校验： CON: " + conEntity.getCon());
				continue;
			}
			
			long remainFee = getOpenRemainFee(conEntity.getCon());
			if (remainFee < 0) {

				log.error("代付账户账户余额小于0，不开机！账户余额： " + remainFee + " CON:" + conEntity.getCon());
				return false;
			}
		}
		
		return true;
	}
	
	
	protected void sepBusiInfo(Map<String, Object> Header, PayUserBaseEntity userBase, PayBookEntity inBook, String provinceId){
		
		
	}
	
	private long getOpenRemainFee(long contractNo){
		
		OutFeeData feeMap = remainFee.getConRemainFee(contractNo);
		log.error("计算余额结果： " + feeMap.toString());
		
		ContractInfoEntity conEntity = account.getConInfo(contractNo);
		
		if(conEntity.getPayCode().equals("3")){	//托收开机余额计算中不体现未出帐话费
			
			return feeMap.getCommonRemainFee() + feeMap.getUnbillFee();
		}else{
			return feeMap.getCommonRemainFee();
		}
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
	}

	public IRemainFee getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public ISvcOrder getSvcOrder() {
		return svcOrder;
	}

	public void setSvcOrder(ISvcOrder svcOrder) {
		this.svcOrder = svcOrder;
	}

}
