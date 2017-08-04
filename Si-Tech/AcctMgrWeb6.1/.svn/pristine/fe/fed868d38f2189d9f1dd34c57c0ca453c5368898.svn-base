package com.sitech.acctmgr.atom.impl.query;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.query.SAgentOprDmInDTO;
import com.sitech.acctmgr.atom.dto.query.SAgentOprDmOutDTO;
import com.sitech.acctmgr.atom.dto.query.SAgentOprInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SAgentOprInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IAgentOprQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(m = "query", c = SAgentOprInitInDTO.class, oc = SAgentOprInitOutDTO.class),
	@ParamType(m = "queryDm", c = SAgentOprDmInDTO.class, oc = SAgentOprDmOutDTO.class)
})
public class SAgentOprQry extends AcctMgrBaseService implements IAgentOprQry{

	protected IUser user;
	protected IControl control;
	protected IBalance balance;
	protected IRecord record;
	protected IAccount account;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		Map<String,Object> inMap = new HashMap<String,Object>();
		String returnInfo = "";
		LoginOprEntity loe = new LoginOprEntity();
		
		SAgentOprInitInDTO inDto = (SAgentOprInitInDTO)inParam;
		String agtPhoneNo = inDto.getAgtPhoneNo();
		String queryFlag = inDto.getQueryType();
		
		//取代理商账户
		ContractInfoEntity cie = account.getAgtInfo(agtPhoneNo);
		long contractNo = cie.getContractNo();
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		String curYm = sCurDate.substring(0, 6);
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		int recordNum=0;
		String[] shortMsg ={};
		if(queryFlag.equals("1")){			
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("FLAG", "1");
			inMap.put("YEAR_MONTH", curYm);
			List<TransFeeEntity> transList = balance.getAgentTrasfeeInfo(inMap);
			
			for(TransFeeEntity tfe:transList) {
				if(returnInfo.isEmpty()) {
					returnInfo += tfe.getOpTime()+" "+tfe.getPhonenoIn()+"#"+tfe.getTransFee();
				}else {
					returnInfo +=";"+tfe.getOpTime()+" "+tfe.getPhonenoIn()+"#"+tfe.getTransFee();
				}
								
				if(recordNum==6){
					break;
				}
				recordNum++;
				
			}
			loe.setRemark("查24小时内最近6条交易记录");
		} else if (queryFlag.equals("2")) {
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("TOTAL_DATE", inDto.getOprDate());
			inMap.put("FLAG", "2");
			inMap.put("YEAR_MONTH", inDto.getOprDate().substring(0,6));
			List<TransFeeEntity> transList = balance.getAgentTrasfeeInfo(inMap);

			for (TransFeeEntity tfe : transList) {
				if (returnInfo.isEmpty()) {
					returnInfo += tfe.getOpTime() + " " + tfe.getPhonenoIn() + "#" + tfe.getTransFee();
				} else {
					returnInfo += ";" + tfe.getOpTime() + " " + tfe.getPhonenoIn() + "#" + tfe.getTransFee();
				}
				
				if (recordNum == 200) {
					break;
				}
				recordNum++;

			}
			loe.setRemark("短信方式查指定日期内交易明细");
		}else if(queryFlag.equals("3")) {
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("FLAG", "3");
			inMap.put("PHONE_NO", inDto.getPhoneNo());
			inMap.put("YEAR_MONTH", curYm);
			List<TransFeeEntity> transList = balance.getAgentTrasfeeInfo(inMap);
			
			for (TransFeeEntity tfe : transList) {
				if (returnInfo.isEmpty()) {
					returnInfo += tfe.getTransSn() + " " + tfe.getOpTime() + " " + tfe.getTransFee();
				} else {
					returnInfo += ";" + tfe.getTransSn() + " " + tfe.getOpTime() + " " + tfe.getTransFee();
				}
				
				if (recordNum == 200) {
					break;
				}
				recordNum++;

			}
			loe.setRemark("短信方式查24小时内号码交易明细");
		}
		
		//send short message
		if(inDto.getLoginNo().equals("rrrrrr")) {
			int recNo=0;
			if (recordNum%5 == 0)
			{
				recNo = recordNum / 5;
			}else{
				recNo = recordNum / 5 +1;
			}
			
			for(int i=0;i<recNo;i++)
			{
				int iRow = i+1;
				//String sendShortMsg = "短信"+String.valueOf(k+1);
			}
			
			
		}
		
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(0);
		loe.setPhoneNo(agtPhoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode("xxxx");
		record.saveLoginOpr(loe);
		
		SAgentOprInitOutDTO outDto = new SAgentOprInitOutDTO();
		outDto.setReturnInfo(returnInfo);
		outDto.setLoginAccept(String.valueOf(loginAccept));
		return outDto;
	}

	@Override
	public OutDTO queryDm(InDTO inParam) {
		
		Map<String,Object> inMap = new HashMap<String,Object>();
		
		SAgentOprDmInDTO inDto = (SAgentOprDmInDTO)inParam;
		String agtPhoneNo = inDto.getAgtPhoneNo();
		String loginPasswd = inDto.getLoginPasswd();
		String agentPasswd = inDto.getAgentPasswd();
		String queryFlag = inDto.getQueryFlag();
		
		// TODO 工号权限验证
		
		//获取空中充值帐户信息
		ContractInfoEntity cie = account.getAgtInfo(agtPhoneNo);
		long contractNo = cie.getContractNo();
		String conPasswd = cie.getContractPasswd();
		
		//取代理商预存
		long prepayFee =balance.getAcctBookSum(contractNo, "0");
		
		// TODO 判断密码是否正确
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		String curYm = sCurDate.substring(0, 6);
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		long paySum = 0;
		long payMoney = 0;
		long unPaySum = 0;
		long unPayMoney = 0;
		if(queryFlag.equals("0")){
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("FLAG", "1");
			inMap.put("YEAR_MONTH", curYm);
			TransFeeEntity tfe = balance.getSumAgentTrasfee(inMap);
			paySum = tfe.getContractnoIn();
			payMoney = tfe.getTransFee();
			
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("YEAR_MONTH", curYm);
			inMap.put("FLAG", "1");
			inMap.put("STATUS", "1");
			TransFeeEntity untfe = balance.getSumAgentTrasfee(inMap);
			unPaySum = untfe.getContractnoIn();
			unPayMoney = untfe.getTransFee();
		}else {
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("YEAR_MONTH", curYm);
			TransFeeEntity tfe = balance.getSumAgentTrasfee(inMap);
			paySum = tfe.getContractnoIn();
			payMoney = tfe.getTransFee();
			
			inMap.put("AGT_PHONE_NO", agtPhoneNo);
			inMap.put("YEAR_MONTH", curYm);
			inMap.put("STATUS", "1");
			TransFeeEntity untfe = balance.getSumAgentTrasfee(inMap);
			unPaySum = untfe.getContractnoIn();
			unPayMoney = untfe.getTransFee();
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(0);
		loe.setPhoneNo(agtPhoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode("xxxx");
		record.saveLoginOpr(loe);
		
		SAgentOprDmOutDTO outDto = new SAgentOprDmOutDTO();
		outDto.setPaySum(unPaySum);
		outDto.setPayMoney(unPayMoney);
		outDto.setUnPaySum(unPaySum);
		outDto.setUnPayMoney(unPayMoney);
		outDto.setPrepayFee(prepayFee);
		outDto.setLoginAccept(String.valueOf(loginAccept));
		return outDto;
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
	
}
