package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.balance.UnbillVmEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.query.VWResultEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SVWResultQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SVWResultQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.I8199;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "query", c = SVWResultQryInDTO.class, oc = SVWResultQryOutDTO.class)})
public class S8199 extends AcctMgrBaseService implements I8199{

	private IAccount account;
	private IUser user;
	private ICust cust;
	private IBill bill;
	private IBalance balance;
	private IRecord record;
	
	@Override
	public OutDTO query(InDTO inParam) {
		List<VWResultEntity> resultList = new ArrayList<VWResultEntity>();
		SVWResultQryInDTO inDto = (SVWResultQryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		long custId = uie.getCustId();
		
		CustInfoEntity cie = cust.getCustInfo(custId, "");
		String custName = cie.getCustName();
		
		List<ContractEntity> ceList = account.getConList(idNo);
		for(ContractEntity ce:ceList) {
			VWResultEntity vre = new VWResultEntity();
			long contractNo = ce.getCon();
			List<UnbillVmEntity> vmList = bill.getUnbillVMList(contractNo, idNo);
			for(UnbillVmEntity ube :vmList) {
				String specailType = "";
				String payTypeName = "";
				String specailFlag = ube.getSpecialFlag();
				if(specailFlag.equals("1")) {
					specailType = "普通预存";
				}else if(specailFlag.equals("0")) {
					specailType = "专款";
				}
				
				//取账本名称
				Map<String,Object> inMap = new HashMap<String,Object>();
				Map<String,Object> outMap = new HashMap<String,Object>();
				String payType = ube.getPayType();
				inMap.put("PAY_TYPE", payType);
				outMap=balance.getBookTypeDict(inMap);
				payTypeName=outMap.get("PAY_TYPE_NAME").toString();
				
				String acctItemCode = ube.getAcctItemCode();
				long shouldPay = ube.getShouldPay();
				long favourFee = ube.getFavourFee();
				long wrtoffFee = ube.getWrtoffFee();
				long balanceFee = ube.getCurBalance();
				long oweFee = shouldPay-favourFee;
				vre.setAcctItemCode(acctItemCode);
				vre.setBalanceFee(balanceFee);
				vre.setContractNo(contractNo);
				vre.setCustName(custName);
				vre.setFavourFee(favourFee);
				vre.setOweFee(oweFee);
				vre.setPayTypeName(payTypeName);
				vre.setPhoneNo(phoneNo);
				vre.setShouldPay(shouldPay);
				vre.setSpecailType(specailType);
				vre.setWrtoffFee(wrtoffFee);
				resultList.add(vre);
			}
		}
		if(resultList.size()==0) {
			throw new BusiException(AcctMgrError.getErrorCode("8199","00001"), "无费用冲销明细！");
		}
		/*
		ActQueryOprEntity oprEntity = new ActQueryOprEntity();
		oprEntity.setQueryType("0");
		oprEntity.setOpCode("8199");
		oprEntity.setContactId("");
		oprEntity.setIdNo(idNo);
		oprEntity.setPhoneNo(phoneNo);
		oprEntity.setBrandId("");
		oprEntity.setLoginNo(inDto.getLoginNo());
		oprEntity.setLoginGroup(inDto.getGroupId());
		oprEntity.setRemark("虚拟销账结果查询");
		oprEntity.setProvinceId(inDto.getProvinceId());
		record.saveQueryOpr(oprEntity, false);
		*/
		SVWResultQryOutDTO outDto = new SVWResultQryOutDTO();
		outDto.setResultList(resultList);
		return outDto;
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
	
}
