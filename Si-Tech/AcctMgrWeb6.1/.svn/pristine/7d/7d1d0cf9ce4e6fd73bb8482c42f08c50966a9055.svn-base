package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.domains.account.AccountListEntity;
import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.bill.BillDetailEntity;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.StatusBillInfoEntity;
import com.sitech.acctmgr.atom.domains.bill.StatusDispBill;
import com.sitech.acctmgr.atom.domains.cust.CtCustContactEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.PersonalCustEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserdetaildeadEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SConUserRelInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SConUserRelOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8109InDTO;
import com.sitech.acctmgr.atom.dto.query.S8109OutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.inter.query.I8109;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

import java.util.*;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 *
 * <p>Title:   呆坏账查询</p>
 * <p>Description:  查询用户离网账单费用 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author xiongjy
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(c = S8109InDTO.class,oc=S8109OutDTO.class, m = "query"),
	@ParamType(c = S8109InDTO.class,oc=SConUserRelOutDTO.class, m = "qryUserDeadInfo")
	})
public class S8109 extends AcctMgrBaseService implements I8109 {
	
	protected IUser user;
	protected ICust cust;
	protected IBill bill;
	protected IBillDisplayer billDisplayer;
	protected IRecord record;
	protected IControl control;
	protected IWriteOffer writeOffer;
	protected IGroup group;
	
	public final OutDTO query(InDTO inParam) {
		
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		List<BillDetailEntity> outParamList = new ArrayList<BillDetailEntity>();
		
		String phoneNo = "";
		long contractNo = 0;
		long idNo = 0;
		String loginNo = "";
		String groupId = "";
		//String opType = "";

		long custId = 0;
		long lLoginAccept = 0;
		long sumOweFee = 0;
		int  oweMonthCnt=0;
		long payedFee=0;
		String custTypeName = "";
		
		S8109InDTO inParamDto = (S8109InDTO) inParam;
		// opType=inParamDto.getOpType();
		loginNo = inParamDto.getLoginNo();
		groupId = inParamDto.getGroupId();
		
		phoneNo = inParamDto.getPhoneNo();
		contractNo = inParamDto.getContractNo();
		idNo = inParamDto.getIdNo();
		
		// 取用户基本信息
		List<UserDeadEntity> udeList = user.getUserdeadEntity(null, idNo, null);
		long vContractNo = udeList.get(0).getContractNo();
		custId = udeList.get(0).getCustId();
		
		if (contractNo == 0) {
			contractNo = vContractNo;
		}
		
		// 取客户信息
		CustInfoEntity cie = cust.getCustInfo(custId, null);
		custTypeName = cie.getCustTypeName();
		String custName = cie.getCustName();
		String custLevel = cie.getCustLevelName();
		String custAddress = cie.getCustAddress();
		String idType = cie.getIdTypeName();
		String idIccid = cie.getIdIccid();
		String idAddress = cie.getIdAddress();
		String idValidDate = cie.getIdValiddate();
		
		String contactName = "";
		String contactPhone = "";
		String contactAddress = "";
		CtCustContactEntity ccce = cust.getContactEnt(custId);
		if(ccce != null) {
			contactName = control.pubEncryptData(ccce.getContactName(), 1);
			contactPhone = ccce.getContactPhone();
			contactAddress = control.pubEncryptData(ccce.getContactAddress(),1);
		}

		String sexCode = "";
		String professionId = "";
		String custLove = "";
		String custHabit ="";
		String workCode = "";
		PersonalCustEntity pce = cust.getPersonalCust(custId);
		if(pce!=null) {
			sexCode = pce.getSexCode();
			professionId = pce.getProfessionId();
			custLove = pce.getCustLove();
			custHabit = pce.getCustHabit();
			workCode = pce.getWorkCode();
		}
		
		String custGroupId = cie.getGroupId();
		ChngroupRelEntity cgre = group.getRegionDistinct(custGroupId, "2", "230000");
		String regionName = cgre.getRegionName();
		ChngroupRelEntity cgre1 = group.getRegionDistinct(custGroupId, "3", "230000");
		String groupName = regionName+cgre1.getRegionName();

		/*else if(opType.equals("2")) {
			idIccid = inParamDto.getIdIccid();
			
			//取客户信息
			idIccid = control.pubEncryptData(idIccid,0);
			log.info("idIccid==="+idIccid);
			CustInfoEntity cie = cust.getCustInfo(null,idIccid);
			custId = cie.getCustId();
			custTypeName = cie.getCustTypeName();
			
			//取账户用户
			//UserDeadEntity ude = user.getUserdeadByCustId(custId);
			//phoneNo = ude.getPhoneNo();
			//contractNo = ude.getContractNo();
			//idNo = ude.getIdNo();
		}*/
				
		//取系统时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		String sCurYm = sCurDate.substring(0, 6);
	    
	    //取操作流水
	    lLoginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		//取用户欠费月数、已交金额
		BillEntity be=bill.getSumDeadFee(idNo, contractNo, "1");
		sumOweFee = be.getOweFee();
		payedFee=be.getPayedLater()+be.getPayedPrepay();
		
		List<Map<String, Object>> unPayBillCycleList = writeOffer.getDeadOweBillCycle(idNo, contractNo, "1");
		oweMonthCnt = unPayBillCycleList.size();
		
		for(Map<String,Object> outMapCycle :unPayBillCycleList ) {
			int iBillCycle = Integer.parseInt(outMapCycle.get("BILL_CYCLE").toString());
			
			List<BillDetailEntity> PCAS_01_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_02_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_03_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_04_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_05_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_06_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_07_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_08_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_09_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			List<BillDetailEntity> PCAS_10_BILL_ENT_LIST = new ArrayList<BillDetailEntity>();
			
			/* 取当前年月 */
			int curYm = Integer.parseInt(DateUtil.format(new Date(), "yyyyMM"));
			
			// 获取帐单数据源
			//billDisplayer.saveMidDeadBillFee(contractNo, idNo, iBillCycle);
			inMapTmp.put("ID_NO", idNo);
			inMapTmp.put("CONTRACT_NO", contractNo);
			inMapTmp.put("BILL_CYCLE", iBillCycle);
			inMapTmp.put("STATUS", "1");
			billDisplayer.saveMidDeadBillFee(inMapTmp);
			

			// 获取用户七大类的结果
			inMapTmp = new HashMap<String, Object>();
			safeAddToMap(inMapTmp, "STATUS", CommonConst.STATUS_ONLINE_UNPAY);
			safeAddToMap(inMapTmp, "ID_NO", idNo);
			safeAddToMap(inMapTmp, "BILL_CYCLE", iBillCycle);
			List<StatusBillInfoEntity> billList = billDisplayer
					.getStatusBillInfo(inMapTmp);
			
			for (StatusBillInfoEntity statusBillInfoEntity : billList) {
				int showId = Integer.parseInt(statusBillInfoEntity.getItemId());
				switch(showId){
				case 1:
					BillDetailEntity billDetail_01 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_01_BILL_ENT_LIST.add(billDetail_01);
					break;
				case 2:
					BillDetailEntity billDetail_02 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_02_BILL_ENT_LIST.add(billDetail_02);
					break;
				case 3:
					BillDetailEntity billDetail_03 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_03_BILL_ENT_LIST.add(billDetail_03);
					break;
				case 4:
					BillDetailEntity billDetail_04 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_04_BILL_ENT_LIST.add(billDetail_04);
					break;
				case 5:
					BillDetailEntity billDetail_05 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_05_BILL_ENT_LIST.add(billDetail_05);
					break;
				case 6:
					BillDetailEntity billDetail_06 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_06_BILL_ENT_LIST.add(billDetail_06);
					break;
				case 7:
					BillDetailEntity billDetail_07 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_07_BILL_ENT_LIST.add(billDetail_07);
					break;
				case 8:
					BillDetailEntity billDetail_08 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_08_BILL_ENT_LIST.add(billDetail_08);
					break;
				case 9:
					BillDetailEntity billDetail_09 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_09_BILL_ENT_LIST.add(billDetail_09);
					break;
				case 10:
					BillDetailEntity billDetail_10 = new BillDetailEntity(statusBillInfoEntity, "0");
					PCAS_10_BILL_ENT_LIST.add(billDetail_10);
					break;
				default:
					break;
				}
			}
			//多帐户需要将费用做合并

			// 获取七大类明细结果
			inMapTmp = new HashMap<String, Object>();
			safeAddToMap(inMapTmp, "ID_NO", idNo);
			safeAddToMap(inMapTmp, "BILL_CYCLE", iBillCycle);
			safeAddToMap(inMapTmp, "STATUS", CommonConst.STATUS_ONLINE_UNPAY);
			List<StatusDispBill> detailList = billDisplayer.getStatusBillDetailForTwoLevel(inMapTmp);
			// 整合出参，拼凑结果

			for (StatusDispBill statusDispBill : detailList) {
				int showId = Integer.parseInt(statusDispBill.getParentItemId());
				StatusBillInfoEntity billDetailEnt = new StatusBillInfoEntity();
				billDetailEnt.setItemId(statusDispBill.getItemId());
				billDetailEnt.setItemName(statusDispBill.getItemName());
				billDetailEnt.setShouldPay(statusDispBill.getShouldPay());
				billDetailEnt.setFavourFee(statusDispBill.getFavourFee());
				billDetailEnt.setPayedPrepay(statusDispBill.getPayedPrepay());
				billDetailEnt.setPayedLater(statusDispBill.getPayedLater());
				billDetailEnt.setOweFee(statusDispBill.getOweFee());
				billDetailEnt.setRealFee(statusDispBill.getFee());
				billDetailEnt.setStatusName(statusDispBill.getStatusName());
				billDetailEnt.setBillCycle(statusDispBill.getBillCycle());
				BillDetailEntity billDetail = new BillDetailEntity(billDetailEnt, "1");
				switch(showId){
				case 1:
					PCAS_01_BILL_ENT_LIST.add(billDetail);
					break;
				case 2:
					PCAS_02_BILL_ENT_LIST.add(billDetail);
					break;
				case 3:
					PCAS_03_BILL_ENT_LIST.add(billDetail);
					break;
				case 4:
					PCAS_04_BILL_ENT_LIST.add(billDetail);
					break;
				case 5:
					PCAS_05_BILL_ENT_LIST.add(billDetail);
					break;
				case 6:
					PCAS_06_BILL_ENT_LIST.add(billDetail);
					break;
				case 7:
					PCAS_07_BILL_ENT_LIST.add(billDetail);
					break;
				case 8:
					PCAS_08_BILL_ENT_LIST.add(billDetail);
					break;
				case 9:
					PCAS_09_BILL_ENT_LIST.add(billDetail);
					break;
				case 10:
					PCAS_10_BILL_ENT_LIST.add(billDetail);
					break;
				default:
					break;
				}
			}
			
			outParamList.addAll(PCAS_01_BILL_ENT_LIST);
			outParamList.addAll(PCAS_02_BILL_ENT_LIST);
			outParamList.addAll(PCAS_03_BILL_ENT_LIST);
			outParamList.addAll(PCAS_04_BILL_ENT_LIST);
			outParamList.addAll(PCAS_05_BILL_ENT_LIST);
			outParamList.addAll(PCAS_06_BILL_ENT_LIST);
			outParamList.addAll(PCAS_07_BILL_ENT_LIST);
			outParamList.addAll(PCAS_08_BILL_ENT_LIST);
			outParamList.addAll(PCAS_09_BILL_ENT_LIST);
			outParamList.addAll(PCAS_10_BILL_ENT_LIST);
		}
		
        if(outParamList.size() == 0) {
        	throw new BusiException(AcctMgrError.getErrorCode("8109","60001"), "没有查询到相关费用信息！");
        }
		
	    //插营业操作记录表
		ActQueryOprEntity oprEntity = new ActQueryOprEntity();
		oprEntity.setQueryType("0");
		oprEntity.setOpCode("8109");
		oprEntity.setContactId("");
		oprEntity.setIdNo(idNo);
		oprEntity.setPhoneNo(phoneNo);
		oprEntity.setBrandId("");
		oprEntity.setLoginNo(inParamDto.getLoginNo());
		oprEntity.setLoginGroup(inParamDto.getGroupId());
		oprEntity.setRemark("陈账查询");
		oprEntity.setProvinceId(inParamDto.getProvinceId());
		record.saveQueryOpr(oprEntity, false);
        
		S8109OutDTO outDto = new S8109OutDTO();
		outDto.setCustTypeName(custTypeName);
		outDto.setOweFee(sumOweFee);
		outDto.setOweMonth(oweMonthCnt);
		outDto.setPayedFee(payedFee);
		outDto.setPhoneNo(phoneNo);
		outDto.setOutList(outParamList);
		
		//基本信息
		outDto.setContactAddress(contactAddress);
		outDto.setContactName(contactName);
		outDto.setContactPhone(contactPhone);
		outDto.setCustAddress(custAddress);
		outDto.setCustHabit(custHabit);
		outDto.setCustLevel(custLevel);
		outDto.setCustLove(custLove);
		outDto.setCustName(custName);
		outDto.setCustTypeName(custTypeName);
		outDto.setGroupName(groupName);
		outDto.setIdAddress(idAddress);
		outDto.setIdIccid(idIccid);
		outDto.setIdType(idType);
		outDto.setIdValidDate(idValidDate);
		outDto.setProfessionId(professionId);
		outDto.setSexCode(sexCode);
		outDto.setTypeCode(custTypeName);
		outDto.setWorkCode(workCode);
        return outDto;
                
	}
	
	@Override
	public OutDTO qryUserDeadInfo(InDTO inParam) {
		S8109InDTO inParamDto = (S8109InDTO)inParam;
		String idIccid = inParamDto.getIdIccid();

		//取客户信息
		idIccid = control.pubEncryptData(idIccid,0);
		log.info("idIccid==="+idIccid);
		
		//取账户用户
		List<UserDeadEntity> userDeadEntList = user.getUserdeadByCustId(idIccid);
		List<AccountListEntity> outList = new ArrayList<>(); // 定义出参列表

		for (UserDeadEntity userDeadEnt : userDeadEntList) {

			AccountListEntity accEnt = new AccountListEntity();
			String phoneNo = userDeadEnt.getPhoneNo();
			long idNo = userDeadEnt.getIdNo();
			long custId = userDeadEnt.getCustId();
			long contractNo = userDeadEnt.getContractNo();

			CustInfoEntity custEnt = cust.getCustInfo(custId, null);
			String custName = custEnt.getCustName();

			accEnt.setIdNo(idNo);
			accEnt.setPhoneNo(phoneNo);
			accEnt.setCustId(custId);
			accEnt.setContractNo(contractNo);
			accEnt.setCustName(custName); // 解密后客户名称

			outList.add(accEnt);
		}

		// 出参信息
		SConUserRelOutDTO outDTO = new SConUserRelOutDTO();
		outDTO.setConList(outList);
		outDTO.setCnt(outList.size());

		log.debug(outDTO.toJson());

		return outDTO;
	}


	/**
	 * @return the billDisplayer
	 */
	public IBillDisplayer getBillDisplayer() {
		return billDisplayer;
	}

	/**
	 * @param billDisplayer the billDisplayer to set
	 */
	public void setBillDisplayer(IBillDisplayer billDisplayer) {
		this.billDisplayer = billDisplayer;
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
