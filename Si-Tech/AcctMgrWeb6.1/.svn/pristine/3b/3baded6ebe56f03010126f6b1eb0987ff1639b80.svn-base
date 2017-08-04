package com.sitech.acctmgr.atom.impl.pay;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.BalanceDetailEntity;
import com.sitech.acctmgr.atom.domains.balance.BalanceDisplayEntity;
import com.sitech.acctmgr.atom.domains.balance.BalanceDisplayListEntity;
import com.sitech.acctmgr.atom.domains.balance.BalanceEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.SBalanceInDTO;
import com.sitech.acctmgr.atom.dto.pay.SBalanceOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.pay.IBalanceDetail;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;


/**
 *
 * <p>
 * Title: 预存明细查询
 * </p>
 * <p>
 * Description: 预存明细查询
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author suzj
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(c = SBalanceInDTO.class, oc = SBalanceOutDTO.class,m = "query")
})
public class SBalanceDetail extends AcctMgrBaseService implements IBalanceDetail{
	
	private IUser user;
	private ICust cust;
	private IGroup group;
	private IRemainFee remainFee;
	private IControl control;
	private IBalance balance;
	private IAccount account;
	
	public OutDTO query(InDTO inParam){
		
		SBalanceInDTO inDto = (SBalanceInDTO)inParam;
		
		List<BalanceDisplayEntity> outConList = new ArrayList<>();
		List<BalanceDisplayListEntity> outList = new ArrayList<BalanceDisplayListEntity>();
		
		// 获取入参信息
		long sumPrePay = 0;
		long allPrepayTotal = 0; // 总生效预存
		long allEffPrepayTotal = 0; // 总未生效预存
		long allExpPrepayTotal = 0; // 总失效预存
		String phoneNo = inDto.getPhoneNo();
		String provinceId = inDto.getProvinceId();
		String loginNo = inDto.getLoginNo();
		log.info("ProvinceId_____________>"+provinceId+"loginNo___--->"+loginNo);
		
		// 获取用户信息
		UserInfoEntity userEnt = user.getUserEntityByPhoneNo(phoneNo, true);
		long idNo = userEnt.getIdNo();
		long custId = userEnt.getCustId();
		CustInfoEntity custEnt = cust.getCustInfo(custId,null);
		String custName = custEnt.getCustName();
		
		// 取当前时间
		String sCurTime = DateUtil.format(new Date(), "yyyy-MM-dd HH:mm:ss");
				
		Date dCurTime = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
		dCurTime = format.parse(sCurTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}		
		
		
		List<ContractEntity> conList = account.getConList(idNo);
		for (ContractEntity conEnt : conList) {
			long contractNo = conEnt.getCon();
			
			// 查询账户基本信息（服务号码、账户号码、归属地、付款方式、未出账话费、当前余额、总欠费、当前预存）
			String sRegionName = "";
			String sPayName = "";
			ContractInfoEntity cie = account.getConInfo(contractNo);
			sPayName = cie.getPayCodeName();
			
			// 取账户归属地
			log.info("groupId---->"+cie.getGroupId()+"provinceId------>"+inDto.getProvinceId());
			ChngroupRelEntity cgre = group.getRegionDistinct(cie.getGroupId(), "2", "230000");
			sRegionName = cgre.getRegionName();
			
			long lUnBillFee = 0;
			long lRemainFee = 0;
			long lOweFee = 0;
			long lPrepayFee = 0;
			OutFeeData outFee = remainFee.getConRemainFee(contractNo);
			lPrepayFee = outFee.getPrepayFee();
			lUnBillFee = outFee.getUnbillFee();
			lOweFee = outFee.getOweFee();
			lRemainFee = outFee.getRemainFee();
			
			// 将账本预存列表分类成当前有效预存、将要生效预存、已经失效预存
			List<BalanceEntity> validList = new ArrayList<BalanceEntity>(); 
			List<BalanceEntity> effDateList = new ArrayList<BalanceEntity>();
			List<BalanceEntity> expDateList = new ArrayList<BalanceEntity>();
			List<BalanceEntity> effList = new ArrayList<BalanceEntity>();
			
			// 合计
			long lPrepayTotal = 0; // 单个账户生效预存
			long lEffPrepayTotal = 0; // 单个账户将要生效预存
			long lExpPrepayTotal = 0; // 单个账户失效预存
			
			// 取账本信息
			Map<String,Object> inMap = new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", contractNo);
			List<Map<String, Object>> acctBookList = balance.getAcctBookInfo(inMap);
			
			// 将账本信息放入 BalanceEntity中
			for(Map<String,Object> acctBookEnt : acctBookList){
				BalanceEntity balEntity  = new BalanceEntity();
				balEntity.setContractNo(contractNo);
				balEntity.setPayType((String)acctBookEnt.get("ACCTBOOK_ITEM"));
				balEntity.setPayTypeName((String)acctBookEnt.get("ACCTBOOK_ITEM_NAME"));
				balEntity.setCurBalance(Long.parseLong(acctBookEnt.get("BALANCE").toString()));
				balEntity.setBackFlag((String)acctBookEnt.get("BACK_FLAG"));
				balEntity.setBackFlagName((String)acctBookEnt.get("BACK_FLAG_NAME"));
				balEntity.setPayFlag((String)acctBookEnt.get("PAY_FLAG"));
				balEntity.setPayFlagName((String)acctBookEnt.get("PAY_FLAG_NAME"));
				balEntity.setSpecialFlag((String)acctBookEnt.get("ACCTBOOK_ITEM_TYPE"));
				balEntity.setSpecialFlagName((String)acctBookEnt.get("ACCTBOOK_ITEM_TYPE_NAME"));
				balEntity.setBeginTime((String)acctBookEnt.get("ACCTBOOK_EFF_DATE"));
				balEntity.setEndTime((String)acctBookEnt.get("ACCTBOOK_EXP_DATE"));
				balEntity.setBalanceId(Long.parseLong(acctBookEnt.get("BALANCE_ID").toString()));
				balEntity.setInitBalance(Long.parseLong(acctBookEnt.get("INIT_BALANCE").toString()));
				balEntity.setPaySn(Long.parseLong(acctBookEnt.get("PAY_SN").toString()));
				Object priority = acctBookEnt.get("PRIORITY");
				balEntity.setPriority(priority.toString());
				
				long lBalance = balEntity.getCurBalance();
				String sEffDate = balEntity.getBeginTime();
				String sExpDate = balEntity.getEndTime();
				
				Date dEffDate = new Date();
				Date dExpDate = new Date();
				try {
					dEffDate = format.parse(sEffDate);
					dExpDate = format.parse(sExpDate);
				} catch (ParseException e) {
					e.printStackTrace();
				} 
				
				if(dEffDate.before(dCurTime) && dExpDate.after(dCurTime)) {
					// 已生效预存
					validList.add(balEntity);
					lPrepayTotal += lBalance;
				} else if(dEffDate.after(dCurTime)){
					// 将要生效预存列表（包含无条件返费）
					effDateList.add(balEntity);
					lEffPrepayTotal += lBalance;
					
					BalanceEntity effBalEnt = new BalanceEntity();
					effBalEnt.setBeginTime(acctBookEnt.get("ACCTBOOK_EFF_DATE").toString());
					effBalEnt.setEndTime(acctBookEnt.get("ACCTBOOK_EXP_DATE").toString());
					effBalEnt.setPayType(acctBookEnt.get("ACCTBOOK_ITEM").toString());
					effBalEnt.setPayTypeName(acctBookEnt.get("ACCTBOOK_ITEM_NAME").toString());
					effBalEnt.setSpecialFlag(acctBookEnt.get("ACCTBOOK_ITEM_TYPE").toString());
					effBalEnt.setSpecialFlagName(acctBookEnt.get("ACCTBOOK_ITEM_TYPE_NAME").toString());
					effBalEnt.setCurBalance(Long.parseLong(acctBookEnt.get("BALANCE").toString()));
					effBalEnt.setContractNo(Long.parseLong(acctBookEnt.get("CONTRACT_NO").toString()));
					effBalEnt.setRemark("无条件返费");
					effList.add(effBalEnt);
				} else if(dExpDate.before(dCurTime)){
					// 已失效预存列表
					expDateList.add(balEntity);
					lExpPrepayTotal += lBalance;
				}
			}
			
			// 总账户预存相加
			allPrepayTotal += lPrepayTotal;
			allEffPrepayTotal += lEffPrepayTotal;
			allExpPrepayTotal += lExpPrepayTotal;
			
			// 有条件返费
			List<BalanceEntity> balanceEntityList = remainFee.getEffList(contractNo);
			if(balanceEntityList != null){
				for(BalanceEntity balEnt:balanceEntityList){
					effList.add(balEnt);
				}
			}
//			effList.addAll(balanceEntityList);
			
			// 账户基本信息
			BalanceDetailEntity balanceDetailEnt = new BalanceDetailEntity();
			balanceDetailEnt.setContractNo(contractNo);
			balanceDetailEnt.setPayName(sPayName);
			balanceDetailEnt.setRegionName(sRegionName);
			balanceDetailEnt.setUnbillFee(lUnBillFee);
			balanceDetailEnt.setRemainFee(lRemainFee);
			balanceDetailEnt.setOweFee(lOweFee);
			balanceDetailEnt.setPrepayFee(lPrepayFee);
			
			// 账户预存信息
			BalanceDisplayListEntity outMap = new BalanceDisplayListEntity();
			log.info("validList------>" + validList);
			log.info("effDateList-------->"+effDateList);
			log.info("expDateList-------->"+expDateList);
			log.info("effList-------->"+effList);
			outMap.setValidList(validList);
			outMap.setEffPrepayList(effDateList);
			outMap.setExpPrepayList(expDateList);
			outMap.setEffList(effList);
			outMap.setBalanceDetailEnt(balanceDetailEnt);
			outList.add(outMap);
		}
		
		SBalanceOutDTO outDto = new SBalanceOutDTO();
		outDto.setAllEffPrepayTotal(allEffPrepayTotal);
		outDto.setAllExpPrepayTotal(allExpPrepayTotal);
		outDto.setAllPrepayTotal(allPrepayTotal);
		outDto.setContractList(outList);
		
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
	 * @return the cust
	 */
	public ICust getCust() {
		return cust;
	}

	/**
	 * @param cust the cust to set
	 */
	public void setCust(ICust cust) {
		this.cust = cust;
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
	
	
	
}
