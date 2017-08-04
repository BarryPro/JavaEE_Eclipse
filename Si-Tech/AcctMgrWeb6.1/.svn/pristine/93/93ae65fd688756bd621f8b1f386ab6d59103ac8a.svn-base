package com.sitech.acctmgr.atom.busi.pay.trans;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.ITransType;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IAgent;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcf.core.exception.BusiException;

/**
*
* <p>Title:  非实名制离网账户转余额查询、特殊业务查询 </p>
* <p>Description: 非实名制离网账户转余额查询、特殊业务查询 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author suzj
* @version 1.0
*/
public class NotRealTrans extends BaseBusi implements ITransType{
	
	protected IRemainFee remainFee;
	protected IControl control;
	protected IAccount account;
	protected IBalance balance;
	protected IAgent agent;
	protected IUser user;

	@Override
	public String getTransTypes() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getTranFee(long inContractNo) {
		long transFee = 0;
		long contractNo = inContractNo;
		long transFeeTmp = 0;
		long remainMoney = 0;
		long idNo = 0;
		
		List<UserDeadEntity> userDeadEnt = user.getUserdeadEntity(null, null, contractNo);
		idNo = userDeadEnt.get(0).getIdNo();
		log.info("TransType getTranFee inParam contractNo["+inContractNo+"]");
		
		transFeeTmp = balance.getSumTransDeadFee(contractNo,"0");
		
		/* 获取账户余额*/
		OutFeeData feeDate = remainFee.getDeadConRemainFee(idNo, contractNo, 1.00);
		if (feeDate != null) {
			remainMoney = feeDate.getRemainFee();
		}
		
		/*可转余额判断*/
		transFee = remainMoney < transFeeTmp ? remainMoney : transFeeTmp ;
		if (transFee < 0) {
			transFee = 0;
		}
		
		return transFee;
	}

	@Override
	public List<TransFeeEntity> getComTranFeeList(long inContractNo) {
		List<TransFeeEntity> outList = new ArrayList<TransFeeEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("TRANS_FLAG", "0");  //账本可转属性  0：表示可转  1：表示不可转
	
		outList = remainFee.getBookListDead(inMap);
		
		return outList;
	}
	
	@Override
	public Map<String, Object> getSpecialBusiness(Map<String, Object> inMap) {
		TransOutEntity baseInfo = (TransOutEntity)inMap.get("BASE_INFO");
		long idNo = (long)inMap.get("ID_NO");
		long contractNo = baseInfo.getContractNo();
		ContractDeadInfoEntity accountEntity = account.getConDeadInfo(contractNo);
		String conTypeString = control.getPubCodeValue(2019, "ZHLXXZ", null);
		if(conTypeString.indexOf(accountEntity.getContractattType()) != -1){
			throw new BusiException(AcctMgrError.getErrorCode("8014","00026"), "专款帐户不允许在此处转账,contract_no: " + contractNo);	
		}
		if(user.isRealName(idNo,"2")){
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00031"), "实名制用户，请到8014做离网转账！");
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> getTranFeeList(long inContractNo) {
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);		
		inMap.put("TRANS_FLAG", "0");  //账本可转属性  0：表示可转  1：表示不可转
			
		outList = balance.getDeadBookList(inMap);
		
		return outList;
	}

	@Override
	public String getOpNote(String opNote) {
		opNote = opNote + "[2:离网]";
		
		return opNote;
	}

	@Override
	public void doSpecialBusi(Map<String, Object> inMap) {
		PayUserBaseEntity baseInfo = (PayUserBaseEntity)inMap.get("IN_TRANS_BASE_INFO");
		PayUserBaseEntity outBaseInfo = (PayUserBaseEntity)inMap.get("OUT_TRANS_BASE_INFO");
		long contractNo = baseInfo.getContractNo();
		long inIdNo = baseInfo.getIdNo();
		long idNo = outBaseInfo.getIdNo();
		ContractInfoEntity accountEntity = account.getConInfo(contractNo);
		String conTypeString = control.getPubCodeValue(2019, "ZHLXXZ", null);
	
		if(conTypeString.indexOf(accountEntity.getContractattType()) != -1){
			throw new BusiException(AcctMgrError.getErrorCode("8014","00026"), "专款帐户不允许在此处转账,contract_no: " + contractNo);	
		}
		if(user.isRealName(idNo,"2")){
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00031"), "实名制用户，请到8014做离网转账！");
		}
		if(user.isRealName(inIdNo,"1")){
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00043"), "转入用户必须为实名制用户！");
		}
	}

	@Override
	public void transFeeSendMsg(Map<String, Object> inMap) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkCfm(Map<String, Object> checkMap) {
		PayUserBaseEntity inTransBaseInfo = (PayUserBaseEntity)checkMap.get("IN_TRANS_BASEINFO");
		long contractNo = inTransBaseInfo.getContractNo();
		ContractInfoEntity accountEntity = account.getConInfo(contractNo);
		String contractattType = accountEntity.getContractattType();
		/*不允许为空中充值代理商账户转账 */
		if(contractattType.equals(PayBusiConst.AIR_RECHARGE_CONTYPE)){
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00019"), "转入号码不能是是空中充值代理商号码");
		}
		
	}

	@Override
	public void checkRegionLimit(String regionGroup,
			String limitType, long transFee) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @return the remainFee
	 */
	public IRemainFee getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
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
	 * @return the balance
	 */
	public IBalance getBalance() {
		return balance;
	}

	/**
	 * @param balance the balance to set
	 */
	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	/**
	 * @return the agent
	 */
	public IAgent getAgent() {
		return agent;
	}

	/**
	 * @param agent the agent to set
	 */
	public void setAgent(IAgent agent) {
		this.agent = agent;
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
	
}
