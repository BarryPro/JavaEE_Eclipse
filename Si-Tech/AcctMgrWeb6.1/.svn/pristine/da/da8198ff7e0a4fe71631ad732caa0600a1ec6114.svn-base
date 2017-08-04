package com.sitech.acctmgr.atom.busi.query;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.query.inter.IOweBill;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.atom.domains.pub.PubWrtoffCtrlEntity;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IDelay;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title: 账单类业务实体层  </p>
 * <p>Description: 查询账单相关的业务实体  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class OweBill extends BaseBusi implements IOweBill {
	
	private IControl	control;
	private IDelay		delay;
	private IBill		bill;
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.query.inter.IOweBill#getHisOweFeeInfo(long)
	 */
	@Override
	public Map<String, Object> getHisOweFeeInfo(long contractNo) {
		
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		Map<String, Object> outMapTmp = null;
		
		// 取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		// 取滞纳金比率
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		outMapTmp = delay.getDelayRate(inMapTmp);
		int iDelayBegin = (Integer) outMapTmp.get("DELAY_BEGIN");
		double dDelayRate = (Double) outMapTmp.get("DELAY_RATE");
		
		List<BillEntity> unPayOweList = bill.getUnpayOweOnBillCycle(contractNo, null);
		
		long lTotalDelayFee = 0;
		long lTotalOweFee = 0;
		List<Map<String, Object>> outOweFeeList = new ArrayList<Map<String,Object>>();
		if(unPayOweList.size() > 0) {

			for (BillEntity unPayOweEnt : unPayOweList) {

				long lDelayFee = 0;
				if (unPayOweEnt.getOweFee() > 0) {
					// 取用户滞纳金
					inMapTmp = new HashMap<String, Object>();
					inMapTmp.put("BILL_BEGIN", unPayOweEnt.getBillBegin());
					inMapTmp.put("OWE_FEE", unPayOweEnt.getOweFee());
					inMapTmp.put("DELAY_BEGIN", iDelayBegin);
					inMapTmp.put("DELAY_RATE", dDelayRate);
					inMapTmp.put("BILL_CYCLE", unPayOweEnt.getBillCycle());
					inMapTmp.put("TOTAL_DATE", Integer.valueOf(sCurDate));
					lDelayFee = delay.getDelayFee(inMapTmp);
				}

				lTotalOweFee += unPayOweEnt.getOweFee();
				lTotalDelayFee += lDelayFee;
				
				Map<String, Object> oweFeeMap = new HashMap<String, Object>();
				oweFeeMap.put("BILL_CYCLE", unPayOweEnt.getBillCycle());
				oweFeeMap.put("OWE_FEE", unPayOweEnt.getOweFee());
				oweFeeMap.put("DELAY_FEE", lDelayFee);
				oweFeeMap.put("SHOULD_PAY", unPayOweEnt.getShouldPay());
				oweFeeMap.put("FAVOUR_FEE", unPayOweEnt.getFavourFee());
				oweFeeMap.put("PAYED_LATER", unPayOweEnt.getPayedLater());
				oweFeeMap.put("PAYED_PREPAY", unPayOweEnt.getPayedPrepay());
				
				outOweFeeList.add(oweFeeMap);
			}
		}
		
		Map<String, Object> outParam = new HashMap<String, Object>();
		outParam.put("OWE_FEE", lTotalOweFee);
		outParam.put("DELAY_FEE", lTotalDelayFee);
		outParam.put("OWEFEE_LIST", outOweFeeList);
		
		return outParam;
	}
	
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.query.inter.IOweBill#getOweDetailList(long)
	 */
	public List<Map<String, Object>> getOweDetailList(long lContractNo) {
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/* 取当前时间 */
		String sTotalDate = "";
		sTotalDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		/* 查询用户划拨账期与标示 */
		PubWrtoffCtrlEntity ctrlEnt = control.getWriteOffFlagAndMonth();
		int iWrtoffFlag = Integer.parseInt(ctrlEnt.getWrtoffFlag());
		int iWrtoffMonth = ctrlEnt.getWrtoffMonth();
		
		String provinceId = control.getProvinceId(lContractNo);
		
		/* 读取滞纳金标志和比率 */
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", lContractNo);
		inMapTmp.put("PROVINCE_ID", provinceId);
		outMapTmp = delay.getDelayRate(inMapTmp);
		double dDelayRate = (Double) outMapTmp.get("DELAY_RATE");
		int iDelayBeginDate = (Integer) outMapTmp.get("DELAY_BEGIN");

		// 取当前账户上的所有库内未冲销账单
		List<Map<String, Object>> outParam = new ArrayList<Map<String, Object>>();
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", lContractNo);
		if (iWrtoffFlag > 0 && iWrtoffMonth != 0) {
			inMapTmp.put("BILL_DAY", CommonConst.BATCHWRTOFF_BILL_DAY);
			inMapTmp.put("NATURAL_MONTH", iWrtoffMonth);
		}
		List<BillEntity> unpayOweList = bill.getUnPayOwe(inMapTmp);
		if (unpayOweList.size() > 0) {
			for (BillEntity unpayOweMap : unpayOweList) {

				long lOweFee = unpayOweMap.getOweFee();
				int iBillBegin = unpayOweMap.getBillBegin();
				int iBillCycle = unpayOweMap.getBillCycle();

				if (lOweFee == 0) {
					continue;
				}

				long lDelayFee = 0;
				if (lOweFee > 0) {
					inMapTmp = new HashMap<String, Object>();
					inMapTmp.put("BILL_BEGIN", iBillBegin);
					inMapTmp.put("OWE_FEE", lOweFee);
					inMapTmp.put("DELAY_BEGIN", iDelayBeginDate);
					inMapTmp.put("DELAY_RATE", dDelayRate);
					inMapTmp.put("BILL_CYCLE", iBillCycle);
					inMapTmp.put("TOTAL_DATE", Integer.valueOf(sTotalDate));
					lDelayFee = delay.getDelayFee(inMapTmp);
				}

				Map<String, Object> tempMap = new HashMap<String, Object>();
				tempMap.put("ACCT_ITEM_CODE", unpayOweMap.getAcctItemCode());
				tempMap.put("OWE_FEE", lOweFee);
				tempMap.put("SHOULD_PAY", unpayOweMap.getShouldPay());
				tempMap.put("FAVOUR_FEE", unpayOweMap.getFavourFee());
				tempMap.put("PAYED_PREPAY", unpayOweMap.getPayedPrepay());
				tempMap.put("PAYED_LATER", unpayOweMap.getPayedLater());
				tempMap.put("DELAY_FEE", lDelayFee);
				tempMap.put("ID_NO", unpayOweMap.getIdNo());
				tempMap.put("CONTRACT_NO", lContractNo);
				tempMap.put("BILL_CYCLE", iBillCycle);
				outParam.add(tempMap);
			}
		} 
		
		return outParam;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.query.inter.IOweBill#getOweFeeInfo(long)
	 */
	@Override
	public Map<String, Object> getOweFeeInfo(long contractNo) {

		List<Map<String, Object>> outOweFeeList = new ArrayList<Map<String,Object>>();
		
		//查询内存账单
		UnbillEntity unbill = bill.getUnbillFee(contractNo);
		long lUnbillFee = unbill.getUnBillFee();
		List<BillEntity> unbillList = unbill.getUnBillList();
		for(BillEntity bill : unbillList) {
			Map<String, Object> temp = new HashMap<String, Object>();
			temp.put("BILL_CYCLE", bill.getBillCycle());
			temp.put("OWE_FEE", bill.getShouldPay() - bill.getFavourFee() - bill.getPayedPrepay() - bill.getPayedLater());
			temp.put("DELAY_FEE", 0);
			temp.put("SHOULD_PAY", bill.getShouldPay());
			temp.put("FAVOUR_FEE", bill.getFavourFee());
			temp.put("PAYED_LATER", bill.getPayedLater());
			temp.put("PAYED_PREPAY", bill.getPayedPrepay());
			outOweFeeList.add(temp);
		}
		
		Map<String, Object> oweFeeHis = getHisOweFeeInfo(contractNo);
		outOweFeeList.addAll((List<Map<String, Object>>)oweFeeHis.get("OWEFEE_LIST"));
		
		Map<String, Object> outParam = new HashMap<String, Object>();
		outParam.put("OWE_FEE", Long.parseLong(oweFeeHis.get("OWE_FEE").toString()) + lUnbillFee);
		outParam.put("UNBILL_FEE", lUnbillFee);
		outParam.put("DELAY_FEE", Long.parseLong(oweFeeHis.get("DELAY_FEE").toString()));
		outParam.put("OWEFEE_LIST", outOweFeeList);
		return outParam;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.query.inter.IOweBill#getOweFeeInfo(long, long)
	 */
	@Override
	public Map<String, Object> getOweFeeInfo(long lContractNo, long lIdNo) {
		// TODO Auto-generated method stub
		return null;
	}


	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.query.inter.IOweBill#getDeadOweFeeInfo(long)
	 */
	@Override
	public Map<String, Object> getDeadOweFeeInfo(Long idNo, Long contractNo) {
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		Map<String, Object> outMapTmp = null;
		
		// 取当前时间
		String curDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		// 取滞纳金比率
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		inMapTmp.put("NET_FLAG", "1");
		outMapTmp = delay.getDelayRate(inMapTmp);
		int delayBegin = (Integer) outMapTmp.get("DELAY_BEGIN");
		double delayRate = (Double) outMapTmp.get("DELAY_RATE");
		
		List<BillEntity> deadOweList = bill.getCycleDeadOwe(idNo,0,null);
		
		long totalDelayFee = 0;
		long totalOweFee = 0;
		List<OweFeeEntity> outOweFeeList = new ArrayList<OweFeeEntity>();
		
		if(deadOweList.size() > 0) {

			for (BillEntity deadOweEnt : deadOweList) {

				long delayFee = 0;
				if (deadOweEnt.getOweFee() > 0) {
					// 取用户滞纳金
					inMapTmp = new HashMap<String, Object>();
					inMapTmp.put("BILL_BEGIN", deadOweEnt.getBillBegin());
					inMapTmp.put("OWE_FEE", deadOweEnt.getOweFee());
					inMapTmp.put("DELAY_BEGIN", delayBegin);
					inMapTmp.put("DELAY_RATE", delayRate);
					inMapTmp.put("BILL_CYCLE", deadOweEnt.getBillCycle());
					inMapTmp.put("TOTAL_DATE", Integer.valueOf(curDate));
					delayFee = delay.getDelayFee(inMapTmp);
				}

				totalOweFee += deadOweEnt.getOweFee();
				totalDelayFee += delayFee;
				
				OweFeeEntity oweFeeEnt = new OweFeeEntity();
				oweFeeEnt.setBillCycle(deadOweEnt.getBillCycle());
				oweFeeEnt.setDelayFee(delayFee);
				oweFeeEnt.setFavourFee(deadOweEnt.getFavourFee());
				oweFeeEnt.setOweFee(deadOweEnt.getOweFee());
				oweFeeEnt.setPayedFee(deadOweEnt.getPayedLater() + deadOweEnt.getPayedPrepay());
				oweFeeEnt.setShouldPay(deadOweEnt.getShouldPay());				
				outOweFeeList.add(oweFeeEnt);
			}
		}
		
		Map<String, Object> outParam = new HashMap<String, Object>();
		outParam.put("OWE_FEE", totalOweFee);
		outParam.put("DELAY_FEE", totalDelayFee);
		outParam.put("OWEFEE_LIST", outOweFeeList);
		return outParam;
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
	
}
