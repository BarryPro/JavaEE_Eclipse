package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.bill.GrpBillDispByStatusEntity;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8412OweBillQryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412OweBillQryOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412QryBillDetailInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412QryBillDetailOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412QryBillInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8412QryBillOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IBillDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.feeqry.I8412;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>
 * Title: 集团综合信息查询
 * </p>
 * <p>
 * Description: 实现集团账单查询等
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuhl_bj
 * @version 1.0
 */
@ParamTypes({ @ParamType(m = "qryBill", c = S8412QryBillInDTO.class, oc = S8412QryBillOutDTO.class),
		@ParamType(m = "qryBillDetail", c = S8412QryBillDetailInDTO.class, oc = S8412QryBillDetailOutDTO.class),
		@ParamType(m = "qryOweBill", c = S8412OweBillQryInDTO.class, oc = S8412OweBillQryOutDTO.class)})
public class S8412 extends AcctMgrBaseService implements I8412 {

	protected IUser user;
	protected IBillDisplayer billDisplayer;
	protected IBill bill;

	public OutDTO qryBill(InDTO inParam) throws Exception {

		S8412QryBillInDTO inDto = (S8412QryBillInDTO) inParam;

		Map<String, Object> inMap = new HashMap<String, Object>();
		List<GrpBillDispByStatusEntity> billList = new ArrayList<GrpBillDispByStatusEntity>();
		//
		long contractNo = inDto.getContractNo();
		long idNo = inDto.getIdNo();
		int beginTimeTmp = inDto.getBeginTime();
		int endTimeTmp = inDto.getEndTime();

		int beginTime = beginTimeTmp / 100;
		int endTime = endTimeTmp / 100;

		// TODO： 根据id_no查询集团产品名称
		String procName = "";

		List<GrpBillDispByStatusEntity> billListTmp = new ArrayList<GrpBillDispByStatusEntity>();
		for (int yearMonth = endTime; yearMonth >= beginTime; yearMonth = DateUtils.addMonth(yearMonth, -1)) {
			inMap.put("BILL_CYCLE", yearMonth);
			Map<String, List<GrpBillDispByStatusEntity>> billMapTmp = billDisplayer.getStatusGrpBill(contractNo, yearMonth);
			List<GrpBillDispByStatusEntity> billTotal = billMapTmp.get("GRP_BILL_TOTAL");
			if (billTotal != null && billTotal.size() >= 0) {
				billListTmp.addAll(billTotal);
			}
		}
		for (GrpBillDispByStatusEntity entity : billListTmp) {
			entity.setProcName(procName);
			entity.setContractNo(contractNo);
			billList.add(entity);
		}

		log.debug("billList:" + billList);
		S8412QryBillOutDTO outDto = new S8412QryBillOutDTO();
		outDto.setBillList(billList);
		return outDto;
	}

	@Override
	public OutDTO qryBillDetail(InDTO inParam) throws Exception {
		S8412QryBillDetailInDTO inDTO = (S8412QryBillDetailInDTO) inParam;
		int billCycle = inDTO.getBillCycle();
		long contractNo = inDTO.getContractNo();
		String status = inDTO.getStatus();
		List<GrpBillDispByStatusEntity> billDispList = new ArrayList<GrpBillDispByStatusEntity>();
		if (status.equals("已缴")) {
			Map<String, List<GrpBillDispByStatusEntity>> billInfo = billDisplayer.getStatusGrpBill(contractNo, billCycle, 1, 1);
			billDispList = billInfo.get("GRP_PAYEDBILL_LIST");
		} else {
			Map<String, List<GrpBillDispByStatusEntity>> billInfo = billDisplayer.getStatusGrpBill(contractNo, billCycle, 2, 1);
			billDispList = billInfo.get("GRP_UNPAYBILL_LIST");
		}

		S8412QryBillDetailOutDTO outDto = new S8412QryBillDetailOutDTO();
		outDto.setBillList(billDispList);
		return outDto;
	}
	
	@Override
	public OutDTO qryOweBill(InDTO inParam) {
		Map<String,Object> inMapTmp = new HashMap<String,Object>();
		Map<String,Object> outMapTmp = new HashMap<String,Object>();
		List<OweFeeEntity> oweFeeList = new ArrayList<OweFeeEntity>();
		
		S8412OweBillQryInDTO inDto = (S8412OweBillQryInDTO)inParam;
		long contractNo = inDto.getContractNo();
		
		boolean isOnline = bill.isOnlineForQry(contractNo);
		inMapTmp.put("CONTRACT_NO", contractNo);
		inMapTmp.put("IS_ONLINE", isOnline);
		outMapTmp = bill.getConFeeList(inMapTmp);
			
		List<Map<String, Object>> tempList = (List<Map<String, Object>>)outMapTmp.get("OWE_INFO_LIST");
		for(Map<String, Object> tempOj:tempList) {
			OweFeeEntity ofe = new OweFeeEntity();
			String phoneNo = tempOj.get("PHONE_NO").toString();
			long billCycle = Long.parseLong(tempOj.get("BILL_CYCLE").toString());
			long oweFee = Long.parseLong(tempOj.get("OWE_FEE").toString());
			long delayFee = Long.parseLong(tempOj.get("DELAY_FEE").toString());
			long shouldPay = Long.parseLong(tempOj.get("SHOULD_PAY").toString());
			long favourFee = Long.parseLong(tempOj.get("FAVOUR_FEE").toString());
			long payedFee = Long.parseLong(tempOj.get("PAYED_PREPAY").toString())+Long.parseLong(tempOj.get("PAYED_LATER").toString());
			ofe.setBillCycle(billCycle);
			ofe.setDelayFee(delayFee);
			ofe.setFavourFee(favourFee);
			ofe.setOweFee(oweFee);
			ofe.setPayedFee(payedFee);
			ofe.setPhoneNo(phoneNo);
			ofe.setShouldPay(shouldPay);
			oweFeeList.add(ofe);
		}
		
		S8412OweBillQryOutDTO outDto = new S8412OweBillQryOutDTO();
		outDto.setOweFeeList(oweFeeList);
		return outDto;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IBillDisplayer getBillDisplayer() {
		return billDisplayer;
	}

	public void setBillDisplayer(IBillDisplayer billDisplayer) {
		this.billDisplayer = billDisplayer;
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
