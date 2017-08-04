package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.ReturnFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.query.SmsBackPayEntity;
import com.sitech.acctmgr.atom.domains.query.TotalSmsBackEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SBackPayInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SIvrBackPayInitOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SSmsBackPayInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.feeqry.IBackPayQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "smsQuery", c = SBackPayInitInDTO.class, oc = SSmsBackPayInitOutDTO.class)})
public class SBackPayQry extends AcctMgrBaseService implements IBackPayQry{

	protected IBalance balance;
	protected IUser user;
	protected IRecord record;
	
	@Override
	public OutDTO smsQuery(InDTO inParam) {
		
		List<TotalSmsBackEntity> totalList = new ArrayList<TotalSmsBackEntity>();
		
		SBackPayInitInDTO inDto = (SBackPayInitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String beginTime = inDto.getBeginDate();
		String endTime = inDto.getEndDate();
		
		//查询账户
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long contractNo = uie.getContractNo();
		long idNo = uie.getIdNo();
		
		//查询返费列表
		long recordNum = 0;
		List<ReturnFeeEntity> returnList = balance.getReturnfeeInfo(contractNo, idNo);
		for(ReturnFeeEntity rfe:returnList) {
			TotalSmsBackEntity tsbe = new TotalSmsBackEntity();
			List<SmsBackPayEntity> smsList = new ArrayList<SmsBackPayEntity>();
			
			int beginDate = Integer.parseInt(beginTime.substring(0, 6));
			int endDate = Integer.parseInt(endTime.substring(0, 6));
			long allFee = rfe.getAllFee();
			String payType = rfe.getPayType();
			
			while(beginDate<=endDate) {
				Map<String, Object> inMap = new HashMap<String, Object>();
				inMap.put("CONTRACT_NO", contractNo);
				inMap.put("ID_NO", idNo);
				inMap.put("PAY_TYPE", payType);
				inMap.put("BEGIN_DATE", rfe.getBeginTime());
				inMap.put("END_DATE", rfe.getEndTime());
				inMap.put("SUFFIX", endDate);
				inMap.put("DESC", "DESC");
				List<PayMentEntity> payList = record.getPayMentList(inMap);
				for(PayMentEntity pme : payList) {
					SmsBackPayEntity sbpe = new SmsBackPayEntity();
					sbpe.setOpTime(pme.getOpTime());
					sbpe.setPayMoney(pme.getPayFee());
					sbpe.setPayType(pme.getPayType());	
					smsList.add(sbpe);
					recordNum++;
				}
				
				endDate = DateUtils.addMonth(endDate, -1);
			}
			
			tsbe.setBeginTime(rfe.getBeginTime());
			tsbe.setPayAll(allFee);
			tsbe.setDetailList(smsList);
			totalList.add(tsbe);
		}
		
		SSmsBackPayInitOutDTO outDto = new SSmsBackPayInitOutDTO();
		outDto.setTotalList(totalList);
		outDto.setRecordNum(recordNum);
		return outDto;
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
	
}
