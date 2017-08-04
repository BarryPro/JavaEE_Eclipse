package com.sitech.acctmgr.atom.busi.pay.hlj;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.busi.pay.inter.IPayOpener;
import com.sitech.acctmgr.atom.busi.pay.inter.ITransType;
import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.busi.pay.trans.TransFactory;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.GroupchgInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IDelay;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.jcfx.dt.MBean;

public class YDZFAutoTrans extends BaseBusi {
	
	private IControl 	 control;
	private IAccount 	 account;
	private IPayOpener 	 payOpener;
	private IWriteOffer  writeOffer;
	private IRecord 	 record;
	private IUser 		 user;
	private IGroup 		 group;
	private ILogin 		 login;
	private IDelay		 delay;
	private IPayManage 	 payManage;
	private TransFactory transFactory;
	
	
	public void trans(long outCon,long inCon,long payfee,String payFlag,String opNote){
		String curTime = control.getSysDate().get("CUR_TIME").toString();
		String curYm = curTime.substring(0, 6);
		int totalDate = Integer.parseInt(curTime.substring(0, 8));
		
		String loginNo = "system";
		LoginEntity  loginEntity = login.getLoginInfo(loginNo, CommonConst.DEFAULT_PROVINCE_ID);
		
		PayUserBaseEntity inTransBaseInfo = getCfmBaseInfo(inCon, CommonConst.DEFAULT_PROVINCE_ID);
		PayUserBaseEntity outTransBaseInfo = getYDZFBaseInfo(outCon, CommonConst.DEFAULT_PROVINCE_ID);

		/*入账实体设值*/
		PayBookEntity bookIn = new PayBookEntity();
		bookIn.setBeginTime(curTime);
		bookIn.setGroupId(loginEntity.getGroupId());
		bookIn.setLoginNo(loginNo);
		bookIn.setOpCode("8020");
		bookIn.setOpNote(opNote);
		bookIn.setPayFee(payfee);
		bookIn.setPayMethod("0");
		bookIn.setPayPath("98");
		bookIn.setTotalDate(totalDate);
		bookIn.setFactorOne(payFlag);//1是全额付费 0是定额付费
		bookIn.setYearMonth(Long.parseLong(curYm));
		
		MBean mbeanTmp = new MBean();
		Map<String, Object> header = mbeanTmp.getHeader();
		header.put("DB_ID", "B1");
		

		ITransType transType = transFactory.createTransFactory("TransAccountRel",true);
		Map<String, Object> inTransCfmMap = new HashMap<String, Object>();
		safeAddToMap(inTransCfmMap, "Header", header);
		safeAddToMap(inTransCfmMap, "TRANS_TYPE_OBJ", transType); //转账类型实例化对象
		safeAddToMap(inTransCfmMap, "TRANS_IN", inTransBaseInfo);  //转入账户基本信息
		safeAddToMap(inTransCfmMap, "TRANS_OUT", outTransBaseInfo); //转出账户基本信息
		safeAddToMap(inTransCfmMap, "BOOK_IN", bookIn); //入账实体
		safeAddToMap(inTransCfmMap, "OP_TYPE", "YDZF"); //转账类型
		safeAddToMap(inTransCfmMap, "TRANS_TYPE_OBJ", transType);
		/*转账*/
		long paySn = payManage.transBalance(inTransCfmMap);
		
		//取滞纳金优惠率
		
		//转入账户做冲销、开机
		inTransCfmMap = new HashMap<String, Object>();
		safeAddToMap(inTransCfmMap, "Header", header);
		safeAddToMap(inTransCfmMap, "CONTRACT_NO", inCon);
		safeAddToMap(inTransCfmMap, "PAY_SN", paySn);
		safeAddToMap(inTransCfmMap, "PHONE_NO", inTransBaseInfo.getPhoneNo());
		safeAddToMap(inTransCfmMap, "LOGIN_NO", loginNo);
		safeAddToMap(inTransCfmMap, "OP_CODE", "8020");
		safeAddToMap(inTransCfmMap, "GROUP_ID", loginEntity.getGroupId());
		safeAddToMap(inTransCfmMap, "PAY_PATH", "98");
		safeAddToMap(inTransCfmMap, "DELAY_FAVOUR_RATE", 0);
		writeOffer.doWriteOff(inTransCfmMap);
		
		//开机
		//payOpener.doConUserOpen(header, inTransBaseInfo, bookIn, CommonConst.DEFAULT_PROVINCE_ID);
		
		//支付账户记录营业员操作日志表
		LoginOprEntity outTransOpr = new LoginOprEntity();
		outTransOpr.setBrandId(outTransBaseInfo.getBrandId());
		outTransOpr.setIdNo(outTransBaseInfo.getIdNo());
		outTransOpr.setLoginGroup(loginEntity.getGroupId());
		outTransOpr.setLoginNo(loginNo);
		outTransOpr.setLoginSn(paySn);
		outTransOpr.setOpCode("8020");
		outTransOpr.setOpTime(curTime);
		outTransOpr.setPayFee((-1) * payfee);
		outTransOpr.setPhoneNo(outTransBaseInfo.getPhoneNo());
		outTransOpr.setRemark(opNote);
		outTransOpr.setPayType("0");
		outTransOpr.setTotalDate(totalDate);
		record.saveLoginOpr(outTransOpr);
		
		//插入集团开关机接口表（表新系统暂时还没有）
		
	}
	
	private PayUserBaseEntity getCfmBaseInfo(long contractNo, String provinceId){
		
		String phoneNo = account.getDefaultPhone(contractNo);
		if (phoneNo.equals("")) {
			phoneNo = "99999999999";
		}
		
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
		payUserBase.setNetFlag(true);
		
		return payUserBase;
	}
	
	//获取一点支付账户基本信息
	private PayUserBaseEntity getYDZFBaseInfo(long contractNo,String provinceId){
		//取账户归属
		GroupchgInfoEntity groupChgEntity = group.getChgGroup(null, null, contractNo);
		
		// 缴费用户归属地市
		ChngroupRelEntity groupEntity = group.getRegionDistinct(groupChgEntity.getGroupId(), "2", provinceId);
		String regionId = groupEntity.getRegionCode();
		
		PayUserBaseEntity payUserBase = new PayUserBaseEntity();
		payUserBase.setIdNo(0);
		payUserBase.setPhoneNo("99999999999");
		payUserBase.setContractNo(contractNo);
		payUserBase.setUserGroupId(groupChgEntity.getGroupId());
		payUserBase.setRegionId(regionId);
		payUserBase.setBrandId("XX");
		payUserBase.setNetFlag(true);
		
		return payUserBase;
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
	 * @return the payOpener
	 */
	public IPayOpener getPayOpener() {
		return payOpener;
	}

	/**
	 * @param payOpener the payOpener to set
	 */
	public void setPayOpener(IPayOpener payOpener) {
		this.payOpener = payOpener;
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
	 * @return the transFactory
	 */
	public TransFactory getTransFactory() {
		return transFactory;
	}

	/**
	 * @param transFactory the transFactory to set
	 */
	public void setTransFactory(TransFactory transFactory) {
		this.transFactory = transFactory;
	}

	/**
	 * @return the delay
	 */
	public IDelay getDelay() {
		return delay;
	}

	/**
	 * @param delay the delay to set
	 */
	public void setDelay(IDelay delay) {
		this.delay = delay;
	}
	
}
