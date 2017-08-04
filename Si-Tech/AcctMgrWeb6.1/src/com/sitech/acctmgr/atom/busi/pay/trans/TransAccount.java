package com.sitech.acctmgr.atom.busi.pay.trans;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.ILimitFee;
import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.busi.pay.inter.ITransType;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IAgent;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title:  转账类型可转金额基类 </p>
* <p>Description: 转账类型可转金额查询基类  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author guwoy
* @version 1.0
*/
public class TransAccount extends BaseBusi implements ITransType {
	
	protected IRemainFee remainFee;
	protected IPayManage payManage;
	protected IControl control;
	protected IAccount account;
	protected IBalance balance;
	protected IAgent agent;
	protected IUser user;	
	protected ILimitFee limitFee;
	protected IShortMessage shortMessage;
	
	public String getTransTypes(){
		
		return null;
	}
	
	/*获取可转金额*/
	@Override
	public long getTranFee(long inContractNo){
		long transFeeTmp = 0;
		long remainMoney = 0;
		long transFee = 0;
		long contractNo = inContractNo;
		
		log.info("TransType getTranFee inParam contractNo["+inContractNo+"]");

		/* 取账户可转预存款 */
		if(getTransTypes() == null){
			transFeeTmp = balance.getSumTransFee(contractNo,"0");
		}else{
			log.info("TransType getTranFee inParam payTypes["+getTransTypes()+"]");
			transFeeTmp = balance.getSumBalacneByPayTypes(contractNo,getTransTypes());
		}
		log.info("账户可转预存--->"+transFeeTmp);
		/* 获取账户余额*/
		OutFeeData feeDate = remainFee.getConRemainFee(contractNo);
		if (feeDate != null) {
			remainMoney = feeDate.getRemainFee();
		}
		log.info("账户余额--->"+remainMoney);
		
		/*可转余额判断*/
		transFee = remainMoney < transFeeTmp ? remainMoney : transFeeTmp ;
		if (transFee < 0) {
			transFee = 0;
		}
		log.info("可转余额---->"+transFee);
		return transFee;
	}
	
	/* 获取按账本合并后的转账列表 */
	@Override
	public List<TransFeeEntity> getComTranFeeList(long inContractNo){
		List<TransFeeEntity> outList = new ArrayList<TransFeeEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("TRANS_FLAG", "0");  //账本可转属性  0：表示可转  1：表示不可转
		
		outList = remainFee.getBookList(inMap);

		return outList;
	}
	
	/* 获取转账列表 */
	@Override
	public List<Map<String, Object>> getTranFeeList(long inContractNo){
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);		
		inMap.put("TRANS_FLAG", "0");  //账本可转属性  0：表示可转  1：表示不可转
		
		outList = balance.getAcctBookList(inMap);

		return outList;
	}
	
	/*个性化业务信息查询*/
	@Override
	public Map<String, Object> getSpecialBusiness(Map<String, Object> inMap){
		
		TransOutEntity baseInfo = (TransOutEntity)inMap.get("BASE_INFO");
		long contractNo = baseInfo.getContractNo();
		ContractInfoEntity accountEntity = account.getConInfo(contractNo);
		String conTypeString = control.getPubCodeValue(2019, "ZHLXXZ", null);
		
		if(conTypeString.indexOf(accountEntity.getContractattType()) != -1){
			throw new BusiException(AcctMgrError.getErrorCode("8014","00026"), "专款帐户不允许在此处转账,contract_no: " + contractNo);	
		}
		return null;
	}

		
	/*转账备注信息*/
	@Override
	public String getOpNote(String opNote) {
		if(opNote == null){
			opNote = "[1:在网转账]";
		}else{
			opNote = opNote + "[1:在网]";
		}
		return opNote;	
	}
	
	/*确认服务个性化验证*/
	@Override
	public void checkCfm(Map<String, Object> checkMap){
		PayUserBaseEntity inTransBaseInfo = (PayUserBaseEntity)checkMap.get("IN_TRANS_BASEINFO");
		long contractNo = inTransBaseInfo.getContractNo();
		ContractInfoEntity accountEntity = account.getConInfo(contractNo);
		String contractattType = accountEntity.getContractattType();
		/*不允许为空中充值代理商账户转账 */
		if(contractattType.equals(PayBusiConst.AIR_RECHARGE_CONTYPE)){
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00019"), "转入号码不能是是空中充值代理商号码");
		}
	}
	
	/* 个性化业务处理 */
	@Override
	public void doSpecialBusi(Map<String, Object> inMap){
//		String payPath = (String)inMap.get("PAY_PATH");
//		if(!payPath.equals("11")){
			PayUserBaseEntity baseInfo = (PayUserBaseEntity)inMap.get("IN_TRANS_BASE_INFO");
			long contractNo = baseInfo.getContractNo();
			log.info("GrpProduct------------>" + contractNo);
			ContractInfoEntity accountEntity = account.getConInfo(contractNo);
			String conTypeString = control.getPubCodeValue(2019, "ZHLXXZ", null);
		
			if(conTypeString.indexOf(accountEntity.getContractattType()) != -1){
				throw new BusiException(AcctMgrError.getErrorCode("8014","00026"), "专款帐户不允许在此处转账,contract_no: " + contractNo);	
//			}
		}
	}
	
	/* 发送短信 */
	@Override
	public void transFeeSendMsg(Map<String, Object> inMap){
		log.info("------>transFeeSendMsg inParm:" + inMap.entrySet());
		
		String outPhoneNo = (String)inMap.get("OUT_PHONE_NO");
		String inPhoneNo = (String)inMap.get("IN_PHONE_NO");
		long outContractNo = (long)inMap.get("OUT_CONTRACT_NO");
		long inContractNo = (long)inMap.get("IN_CONTRACT_NO");
		long payFee = (long)inMap.get("TRANS_FEE");
		String loginNo = (String)inMap.get("LOGIN_NO");
		String opCode = (String)inMap.get("OP_CODE");
		
		/**
		 * 预存款转移成功，转入手机号为$IN_PHONE_NO 转出帐号为$OUT_CONTRACT_NO，转出手机号为$OUT_PHONE_NO，转移金额为$MONEY元！
		 */
		Map<String, Object> outMapTmp = new HashMap<String, Object>();
		outMapTmp.put("in_phone_no", inPhoneNo);
		outMapTmp.put("out_phone_no",outPhoneNo);
		outMapTmp.put("out_contract_no", outContractNo);
		outMapTmp.put("pay_money", ValueUtils.transFenToYuan(payFee));
		outMapTmp.put("sms_release", "");
		
		MBean outMessage = new MBean();
		outMessage.addBody("PHONE_NO", outPhoneNo);
		outMessage.addBody("LOGIN_NO", loginNo);;
		outMessage.addBody("OP_CODE", opCode);
		outMessage.addBody("CHECK_FLAG", true);
		outMessage.addBody("TEMPLATE_ID", "311200801401");
		outMessage.addBody("DATA", outMapTmp);
		log.info("发送短信内容：" + outMessage.toString());
		
		String flag = control.getPubCodeValue(2011, "DXFS", null);  // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag.equals("0")){
			outMessage.addBody("SEND_FLAG", 0);
		}else if(flag.equals("1")){
			outMessage.addBody("SEND_FLAG", 1);
		}else if(flag.equals("2")){
			return;
		}
		
		shortMessage.sendSmsMsg(outMessage, 1);
		
		/**
		 * 预存款转移成功，转出手机号为$OUT_PHONE_NO 转入手机号为$IN_PHONE_NO，转移金额为$MONEY元，转入帐号为$IN_CONTRACT_NO
		 */
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("in_phone_no", inPhoneNo);
		inMapTmp.put("out_phone_no",outPhoneNo);
		inMapTmp.put("in_contract_no", inContractNo);
		inMapTmp.put("pay_money", ValueUtils.transFenToYuan(payFee));
		inMapTmp.put("sms_release", "");
		
		MBean inMessage = new MBean();
		inMessage.addBody("PHONE_NO", inPhoneNo);
		inMessage.addBody("LOGIN_NO", loginNo);;
		inMessage.addBody("OP_CODE", opCode);
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("TEMPLATE_ID", "311200801404");
		inMessage.addBody("DATA", inMapTmp);
		log.info("发送短信内容：" + inMessage.toString());
		
		String flag1 = control.getPubCodeValue(2011, "DXFS", null);  // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag1.equals("0")){
			inMessage.addBody("SEND_FLAG", 0);
		}else if(flag1.equals("1")){
			inMessage.addBody("SEND_FLAG", 1);
		}else if(flag1.equals("2")){
			return;
		}
		
		shortMessage.sendSmsMsg(inMessage, 1);
		
	}

	/*地市月限额验证*/
	public void checkRegionLimit(String regionGroup,String limitType,long transFee){
		
		Map<String,Object> judgeMap = new HashMap<String,Object>();
		Map<String,Object> msgMap = new HashMap<String,Object>();
		
		msgMap.put("REGION_GROUP", regionGroup);
		msgMap.put("LIMIT_TYPE", limitType);
		msgMap.put("TRANS_FEE", transFee);
		
		//地市月限额
		limitFee.regionMonthLimit(msgMap);
		
		//更新地市月限额信息
		limitFee.updateMonthRegionLimit(transFee, regionGroup, limitType);
	}
	
	public IPayManage getPayManage() {
		return payManage;
	}

	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
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
	 * @return the shortMessage
	 */
	public IShortMessage getShortMessage() {
		return shortMessage;
	}

	/**
	 * @param shortMessage the shortMessage to set
	 */
	public void setShortMessage(IShortMessage shortMessage) {
		this.shortMessage = shortMessage;
	}

	/**
	 * @return the limitFee
	 */
	public ILimitFee getLimitFee() {
		return limitFee;
	}

	/**
	 * @param limitFee the limitFee to set
	 */
	public void setLimitFee(ILimitFee limitFee) {
		this.limitFee = limitFee;
	}
	
}
