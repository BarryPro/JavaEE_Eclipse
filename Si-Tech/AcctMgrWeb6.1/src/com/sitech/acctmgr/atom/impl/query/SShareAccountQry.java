package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ConUserRelEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.query.SubCardEntity;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserRelEntity;
import com.sitech.acctmgr.atom.dto.query.ShareAccountQryInDTO;
import com.sitech.acctmgr.atom.dto.query.ShareAccountQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.IShareAccountQry;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({
    @ParamType(m = "query", c = ShareAccountQryInDTO.class, oc = ShareAccountQryOutDTO.class)
})
public class SShareAccountQry extends AcctMgrBaseService implements IShareAccountQry{

	private IUser user;
	private IRemainFee remainFee;
	private ICust cust;
	private IBill bill;
	private IAccount account;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		ShareAccountQryInDTO inDto = (ShareAccountQryInDTO) inParam;
		ShareAccountQryOutDTO outDto = new ShareAccountQryOutDTO();
		List<SubCardEntity> subList = new ArrayList<SubCardEntity>();
		String phoneNo = inDto.getPhoneNo();
		String flag = inDto.getFlag();
		String opCode = inDto.getOpCode();
		
		if (!opCode.equals("7327") && !opCode.equals("d979")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "12004"), "验证合账分享op_code失败!");
		}
		
		/**
		 ** 为了区别，家庭合帐与传统合帐的查询，引入op_code 做为条件限制。 d979为家庭合帐分享查询的op_code，
		 * 转换为d977（家庭合帐分享办理）时的op_code
		 **/
		if (opCode.equals("d979")) {
			opCode = "d977";
		}
		
		/******** 取当前时间和6个月之前年月 *********/
		String curYm = String.valueOf(DateUtils.getCurYm());
		String cmpYm = String.valueOf(DateUtils.addMonth(DateUtils.getCurYm(), -6));
		
		/* 主卡查询 */
		if (flag.equals("0")) {
			UserInfoEntity uie = user.getUserInfo(phoneNo);
			String stateFlag = uie.getRunCode();
			String mainName = uie.getRunName();
			long idNo = uie.getIdNo();
			long contractNo = uie.getContractNo();
			
			long billFee = 0;
			String flag1 = "";
			long oweFee=0;
			if (stateFlag.equals("B") || stateFlag.equals("C")) {
				Map<String,Object> outMap = bill.getStopCheckOwe(contractNo, Integer.parseInt(curYm));
				if(outMap!=null) {
					oweFee = Long.parseLong(outMap.get("OWE_FEE").toString());
					billFee = Long.parseLong(outMap.get("BILL_OWE").toString());
				}

				billFee = billFee + oweFee;
				flag1 = "0";
			}
			
			// 查询副卡信息			
			List<UserRelEntity> slaveList = user.getSlaveId(idNo, opCode);
			if(slaveList==null) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "12004"), "没有合帐分享副卡!");
			}
			for (UserRelEntity ure : slaveList) {
				long slaveId = ure.getSlaveId();
				String beginYm = ure.getEffDate();
				String endYm = ure.getExpDate();
				
				UserInfoEntity uieSlave = user.getUserEntity(slaveId, null, null, true);
				long slaveContract = uieSlave.getContractNo();
				String slavePhone = uieSlave.getPhoneNo();
				long custId = uieSlave.getCustId();
				
				// 取最大限额
				long limitPay = 0;
				ConUserRelEntity cure = account.getConUserRelInfo(slaveContract, slaveId);
				if(cure!=null){
					double payValue = cure.getPayValue();
					limitPay = (long)payValue;
				}
				
				UserDetailEntity ude = user.getUserdetailEntity(slaveId);
				String subName = ude.getRunName();
				String stateFlag1 = ude.getRunCode();
				
				String flag2 = "";
				long billFee1 = 0;
				if (stateFlag1.equals("B") || stateFlag1.equals("C")) {
					OutFeeData outFee = remainFee.getConRemainFee(contractNo);
					long payFee = outFee.getUnbillFee();
					
					// TODO 取dstop_check费用，待定
					Map<String,Object> outMap = bill.getStopCheckOwe(slaveContract, Integer.parseInt(curYm));
					long oweFee1 = Long.parseLong(outMap.get("OWE_FEE").toString());;
					billFee1 = Long.parseLong(outMap.get("BILL_OWE").toString());
					billFee1 = billFee1 + oweFee1;
					
					if (limitPay - payFee > 0) {
						flag2 = "0";
					} else {
						flag2 = "1";
					}
				}
				
				// 取客户名称
				CustInfoEntity cie = cust.getCustInfo(custId, null);
				String custName = cie.getBlurCustName();
				
				long sumPayFee = 0;
				if (!beginYm.equals(curYm)) {
					int tmpYm = (Integer.parseInt(cmpYm) >= Integer.parseInt(beginYm)) ? Integer.parseInt(cmpYm) : Integer.parseInt(beginYm);
					while (tmpYm <= Integer.parseInt(curYm)) {
						Map<String, Long> outMap = bill.getSumUnpayInfo(contractNo, slaveId, tmpYm);
						sumPayFee = sumPayFee + outMap.get("OWE_FEE");
						tmpYm = DateUtils.addMonth(tmpYm, 1);
					}
				}
				
				// 取未出帐话费
				OutFeeData outFee = remainFee.getConRemainFee(slaveContract);
				long unBillFee = outFee.getUnbillFee();
				long nowPay = 0;
				nowPay = (limitPay >= unBillFee) ? unBillFee : limitPay;
				nowPay = limitPay;// //???老系统这样是不是有问题
				
				SubCardEntity subEntity = new SubCardEntity();
				subEntity.setBeginYm(beginYm);
				subEntity.setPhoneNo(phoneNo);
				subEntity.setCustName(custName);
				subEntity.setLimitPay(limitPay);
				subEntity.setSumPayFee(sumPayFee);
				subEntity.setNowPay(nowPay);
				subEntity.setStateFlag1(stateFlag1);
				subEntity.setFlag2(flag2);
				subEntity.setBillFee1(billFee1);
				subEntity.setSubName(subName);
				subList.add(subEntity);
			}
			
			outDto.setStateFlag(stateFlag);
			outDto.setFlag1(flag1);
			outDto.setBillFee(billFee);
			outDto.setMainName(mainName);
			outDto.setResultList(subList);
		}else if(flag.equals("1")) {
			//副卡查询
			
			UserInfoEntity uie = user.getUserInfo(phoneNo);
			String stateFlag1 = uie.getRunCode();
			String subName = uie.getRunName();
			long slaveId = uie.getIdNo();
			long slaveContract = uie.getContractNo();
			
			// 取最大限额
			long limitPay = 0;
			ConUserRelEntity cure = account.getConUserRelInfo(slaveContract, slaveId);
			if(cure!=null){
				double payValue = cure.getPayValue();
				limitPay = (long)payValue;
			}
			
			//查询对应的主卡号信息
			UserRelEntity mainEntity = user.getMasterId(slaveId, opCode);
			if(mainEntity==null) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "12004"), "没有合帐分享主卡!");
			}
			long mainId = mainEntity.getMasterId();
			String beginYm = mainEntity.getEffDate();
			
			UserInfoEntity uieMain = user.getUserEntity(mainId, null, null, true);
			long mainContract = uieMain.getContractNo();
			String mainPhone = uieMain.getPhoneNo();
			long custId = uieMain.getCustId();
			
			UserDetailEntity ude = user.getUserdetailEntity(mainId);
			String mainName = ude.getRunName();
			String stateFlag = ude.getRunCode();
			
			long billFee = 0;
			String flag1 = "";
			if (stateFlag.equals("B") || stateFlag.equals("C")) {
				Map<String,Object> outMap = bill.getStopCheckOwe(mainContract, Integer.parseInt(curYm));
				long oweFee = Long.parseLong(outMap.get("OWE_FEE").toString());
				billFee = Long.parseLong(outMap.get("BILL_OWE").toString());
				billFee = billFee + oweFee;
				flag1 = "0";
			}
			
			//取主卡客户名称
			CustInfoEntity cie = cust.getCustInfo(custId, null);
			String custName = cie.getBlurCustName();
			
			String flag2 = "";
			long billFee1 = 0;
			//stateFlag1副卡状态
			if (stateFlag1.equals("B") || stateFlag1.equals("C")) {
				OutFeeData outFee = remainFee.getConRemainFee(mainContract);
				long payFee = outFee.getUnbillFee();
				
				Map<String,Object> outMap = bill.getStopCheckOwe(slaveContract, Integer.parseInt(curYm));
				long oweFee1 = Long.parseLong(outMap.get("OWE_FEE").toString());;
				billFee1 = Long.parseLong(outMap.get("BILL_OWE").toString());
				billFee1 = billFee1 + oweFee1;
				
				if (limitPay - payFee > 0) {
					flag2 = "0";
				} else {
					flag2 = "1";
				}
			}
			
			//计算往月欠费
			long sumPayFee = 0;
			if (!beginYm.equals(curYm)) {
				int tmpYm = (Integer.parseInt(cmpYm) >= Integer.parseInt(beginYm)) ? Integer.parseInt(cmpYm) : Integer.parseInt(beginYm);
				while (tmpYm <= Integer.parseInt(curYm)) {
					Map<String, Long> outMap = bill.getSumUnpayInfo(mainContract, slaveId, tmpYm);
					sumPayFee = sumPayFee + outMap.get("OWE_FEE");
					tmpYm = DateUtils.addMonth(tmpYm, 1);
				}
			}
			
			//计算未出帐话费
			OutFeeData outFee = remainFee.getConRemainFee(slaveContract);
			long unBillFee = outFee.getUnbillFee();
			long nowPay = 0;
			nowPay = (limitPay >= unBillFee) ? unBillFee : limitPay;
			nowPay = limitPay;// //???老系统这样是不是有问题
			
			SubCardEntity subEntity = new SubCardEntity();
			subEntity.setBeginYm(beginYm);
			subEntity.setPhoneNo(phoneNo);
			subEntity.setCustName(custName);
			subEntity.setLimitPay(limitPay);
			subEntity.setSumPayFee(sumPayFee);
			subEntity.setNowPay(nowPay);
			subEntity.setStateFlag1(stateFlag1);
			subEntity.setFlag2(flag2);
			subEntity.setBillFee1(billFee1);
			subEntity.setSubName(subName);
			subList.add(subEntity);
			
			outDto.setStateFlag(stateFlag);
			outDto.setFlag1(flag1);
			outDto.setBillFee(billFee);
			outDto.setMainName(mainName);
			outDto.setResultList(subList);
		}
		
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
