package com.sitech.acctmgr.atom.impl.feeqry;
 
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.BalanceDisplayEntity;
import com.sitech.acctmgr.atom.domains.balance.EffBalanceEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8148QueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8148QueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.I8148;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;


/**
 *
 * <p>
 * Title: 资金有效期查询
 * </p>
 * <p>
 * Description: 查询用户或账户预存情况
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author yankma
 * @version 1.0
 */
@ParamTypes({ @ParamType(c = S8148QueryInDTO.class, oc = S8148QueryOutDTO.class, m = "query") })
public class S8148 extends AcctMgrBaseService implements I8148 {
	protected IUser user;
	protected IAccount account;
	protected IRemainFee remainFee;
	protected IBalance balance;
	protected IGroup group;


	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.query.I8148#query(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO query(InDTO inParam) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		Map<String, Object> outMap = null;
		
		int iQueryType = 0;
		String phoneNo = "";
		long lContractNo = 0;
		
		// 入参DTO
		S8148QueryInDTO in = (S8148QueryInDTO) inParam;
		iQueryType = in.getQueryType();
		phoneNo = in.getPhoneNo();
		lContractNo = in.getContractNo();
		
		// 根据入参信息取账户信息
		if (iQueryType == 0) {
			UserInfoEntity uie = user.getUserInfo(phoneNo);
			if(lContractNo == 0) {
				lContractNo = uie.getContractNo();
			}
		}
		
		// 取当前时间
		String sCurTime = DateUtil.format(new Date(), "yyyy-MM-dd HH:mm:ss");
		
		Date dCurTime = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			dCurTime = format.parse(sCurTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// 查询账户基本信息（服务号码、账户号码、归属地、付款方式、未出账话费、当前余额、总欠费、当前预存）
		String sRegionName = "";
		String sPayName = "";
		ContractInfoEntity cie = account.getConInfo(lContractNo);
		sPayName = cie.getPayCodeName();
		
		// 取账户归属地
		ChngroupRelEntity cgre = group.getRegionDistinct(cie.getGroupId(), "2", in.getProvinceId());
		sRegionName = cgre.getRegionName();
		
		long lUnBillFee = 0;
		long lRemainFee = 0;
		long lOweFee = 0;
		long lPrepayFee = 0;
		OutFeeData outFee = remainFee.getConRemainFee(lContractNo);
		lPrepayFee = outFee.getPrepayFee();
		lUnBillFee = outFee.getUnbillFee();
		lOweFee = outFee.getOweFee();
		lRemainFee = outFee.getRemainFee();
		
		if(lRemainFee < 0) {
			lRemainFee = 0;
		}
		
		// 将账本预存列表分类成当前有效预存、将要生效预存、已经失效预存
		List<BalanceDisplayEntity> validList = new ArrayList<BalanceDisplayEntity>(); 
		List<BalanceDisplayEntity> effDateList = new ArrayList<BalanceDisplayEntity>();
		List<BalanceDisplayEntity> expDateList = new ArrayList<BalanceDisplayEntity>();
		List<EffBalanceEntity> effList = new ArrayList<EffBalanceEntity>();
		
		// 合计
		long lPrepayTotal = 0;
		long lEffPrepayTotal = 0;
		long lExpPrepayTotal = 0;
		
		// 取账本信息
		inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", lContractNo);
		List<Map<String, Object>> acctBookList = balance.getAcctBookInfo(inMap);
		
		for(Map<String, Object> acctBookMap : acctBookList) {
			// 取营销活动名称（待实现）
			String sMarketName = "";
			
			acctBookMap.put("CONTRACT_NO", lContractNo);
			acctBookMap.put("MARKET_NAME", sMarketName);
			
			long lBalance = Long.parseLong(acctBookMap.get("BALANCE").toString());
			String sEffDate = acctBookMap.get("ACCTBOOK_EFF_DATE").toString();
			String sExpDate = acctBookMap.get("ACCTBOOK_EXP_DATE").toString();
			
			Date dEffDate = new Date();
			Date dExpDate = new Date();
			try {
				dEffDate = format.parse(sEffDate);
				dExpDate = format.parse(sExpDate);
			} catch (ParseException e) {
				e.printStackTrace();
			} 
			
			if(dEffDate.before(dCurTime) && dExpDate.after(dCurTime)) {
				String jsonStr = JSON.toJSONString(acctBookMap);
				validList.add(JSON.parseObject(jsonStr,BalanceDisplayEntity.class));
				lPrepayTotal += lBalance;
			} else if(dEffDate.after(dCurTime)){
				String jsonStr = JSON.toJSONString(acctBookMap);
				effDateList.add(JSON.parseObject(jsonStr,BalanceDisplayEntity.class));
				lEffPrepayTotal += lBalance;
				
				EffBalanceEntity effBalEnt = new EffBalanceEntity();
				effBalEnt.setAcctBookEffDate(acctBookMap.get("ACCTBOOK_EFF_DATE").toString());
				effBalEnt.setAcctBookExpDate(acctBookMap.get("ACCTBOOK_EXP_DATE").toString());
				effBalEnt.setAcctBookItem(acctBookMap.get("ACCTBOOK_ITEM").toString());
				effBalEnt.setAcctBookItemName(acctBookMap.get("ACCTBOOK_ITEM_NAME").toString());
				effBalEnt.setAcctBookItemType(acctBookMap.get("ACCTBOOK_ITEM_TYPE").toString());
				effBalEnt.setAcctBookItemTypeName(acctBookMap.get("ACCTBOOK_ITEM_TYPE_NAME").toString());
				effBalEnt.setBalance(Long.parseLong(acctBookMap.get("BALANCE").toString()));
				effBalEnt.setContractNo(Long.parseLong(acctBookMap.get("CONTRACT_NO").toString()));
				effBalEnt.setRemark("无条件返费");
				effList.add(effBalEnt);
			} else if(dExpDate.before(dCurTime)){
				String jsonStr = JSON.toJSONString(acctBookMap);
				expDateList.add(JSON.parseObject(jsonStr,BalanceDisplayEntity.class));
				lExpPrepayTotal += lBalance;
			}
		}
		
		// 取条件返费金额
		inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", lContractNo);
		inMap.put("STATUS", "1");
		log.info("inMap------------" + inMap);
		System.out.println("balance--->"+balance);
		List<Map<String, Object>> retBalList = balance.getRetAcctBookForRestPay(inMap);
		for(Map<String, Object> retBal : retBalList) {
			String sBeginTime = retBal.get("BEGIN_TIME").toString();
			String sEndTime = retBal.get("END_TIME").toString();
			EffBalanceEntity effBalEnt = new EffBalanceEntity();
			effBalEnt.setAcctBookEffDate(sBeginTime.substring(0, 4) + "-" + sBeginTime.substring(4, 6) + "-" + sBeginTime.substring(6));
			effBalEnt.setAcctBookExpDate(sEndTime.substring(0, 4) + "-" + sEndTime.substring(4, 6) + "-" + sEndTime.substring(6));
			effBalEnt.setAcctBookItem(retBal.get("PAY_TYPE").toString());
			effBalEnt.setAcctBookItemName(retBal.get("PAY_TYPE_NAME").toString());
			effBalEnt.setAcctBookItemType(retBal.get("PAY_ATTR").toString().substring(0, 1));
			effBalEnt.setAcctBookItemTypeName(retBal.get("PAY_ATTR").toString().substring(0, 1).equals("0") ? "专项预存款" : "普通预存款");
			effBalEnt.setBalance(Long.parseLong(retBal.get("CUR_BALANCE").toString()));
			effBalEnt.setContractNo(lContractNo);
			effBalEnt.setRemark("有条件返费");
			effList.add(effBalEnt);
		}
		
		Collections.sort(effDateList, new BalanceDisComp());
		Collections.sort(validList, new BalanceDisComp2());
		Collections.sort(expDateList, new BalanceDisComp2());
		Collections.sort(effList, new EffBalanceComp());
		
		S8148QueryOutDTO out = new S8148QueryOutDTO();
		out.setPhoneNo(phoneNo);
		out.setContractNo(lContractNo);
		out.setPayName(sPayName);
		out.setRegionName(sRegionName);
		out.setUnBillFee(lUnBillFee);
		out.setRemainFee(lRemainFee);
		out.setOweFee(lOweFee);
		out.setPrepayFee(lPrepayFee);

		out.setPrepayTotal(lPrepayTotal);
		out.setEffPrepayTotal(lEffPrepayTotal);
		out.setExpPrepayTotal(lExpPrepayTotal);
		
		out.setValidList(validList);
		out.setEffDateList(effDateList);
		out.setExpDateList(expDateList);
		out.setEffList(effList);
		
		return out;
	}
	
	private class BalanceDisComp implements Comparator<BalanceDisplayEntity> {

		public int compare(BalanceDisplayEntity o1, BalanceDisplayEntity o2) {
			
			String effDate1 = o1.getAcctBookEffDate();
			String effDate2 = o2.getAcctBookEffDate();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				Date dEffDate1 = format.parse(effDate1);
				Date dEffDate2 = format.parse(effDate2);
				
				if(dEffDate1.before(dEffDate2)) {
					return -1;
				} else if(dEffDate1.after(dEffDate2)) {
					return 1;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			return 0;
		}

	}
	
	private class BalanceDisComp2 implements Comparator<BalanceDisplayEntity> {

		@Override
		public int compare(BalanceDisplayEntity o1, BalanceDisplayEntity o2) {
			
			String expDate1 = o1.getAcctBookExpDate();
			String expDate2 = o2.getAcctBookExpDate();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				Date dExpDate1 = format.parse(expDate1);
				Date dExpDate2 = format.parse(expDate2);
				
				if(dExpDate1.before(dExpDate2)) {
					return -1;
				} else if(dExpDate1.after(dExpDate2)) {
					return 1;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			return 0;
		}

	}
	
	private class BillComp implements Comparator<Map<String, Object>> {

		@Override
		public int compare(Map<String, Object> o1, Map<String, Object> o2) {
			
			int iBillCycle1 = Integer.parseInt(o1.get("BILL_CYCLE").toString());
			int iBillCycle2 = Integer.parseInt(o2.get("BILL_CYCLE").toString());
			
			if(iBillCycle1 < iBillCycle2) {
				return 1;
			} else if(iBillCycle1 > iBillCycle2){
				return -1;
			}
			
			return 0;
		}

	}
	
	public class EffBalanceComp implements Comparator<EffBalanceEntity> {

		@Override
		public int compare(EffBalanceEntity o1, EffBalanceEntity o2) {
			
			String effDate1 = o1.getAcctBookEffDate();
			String effDate2 = o2.getAcctBookEffDate();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				Date dEffDate1 = format.parse(effDate1);
				Date dEffDate2 = format.parse(effDate2);
				
				if(dEffDate1.before(dEffDate2)) {
					return -1;
				} else if(dEffDate1.after(dEffDate2)) {
					return 1;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			return 0;
		}

	}

	@Override
	public OutDTO paySourceOut(InDTO inParam) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OutDTO writeoff(InDTO inParam) {
		// TODO Auto-generated method stub
		return null;
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
	
	

}
