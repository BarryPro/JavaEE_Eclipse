package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S17951IpFeeInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S17951IpFeeInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.inter.feeqry.I17951IpFeeQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = S17951IpFeeInitInDTO.class, oc = S17951IpFeeInitOutDTO.class)
})
public class S17951IpFeeQry extends AcctMgrBaseService implements I17951IpFeeQry{

	protected IUser user;
	protected IBalance balance;
	protected IAccount account;
	protected IBill bill;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		List<ContractEntity> conList= new ArrayList<ContractEntity>();
		
		S17951IpFeeInitInDTO inDto = (S17951IpFeeInitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		//取用户信息
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long contractNo = uie.getContractNo();
		long idNo = uie.getIdNo();
		
		//取账户预存
		long prepayFee =balance.getAcctBookSum(contractNo, "x");
		
		//
		conList = account.getConList(idNo);
		long unPayOwe =0;
		for(ContractEntity ce:conList) {
			UnbillEntity ube = bill.getUnbillFee(ce.getCon(), idNo, CommonConst.UNBILL_TYPE_BILL_DET);
			List<BillEntity> billList = ube.getUnBillList();
			for(BillEntity be:billList){
				String acctItemCode = be.getAcctItemCode();
				if(acctItemCode.equals("0L30000101")||acctItemCode.equals("0L30000102")||acctItemCode.equals("0L30000103")||acctItemCode.equals("0L30000104")){
					long unBillFee = be.getShouldPay()-be.getFavourFee();
					unPayOwe = unPayOwe+unBillFee;
				}
			}
		}
		
		S17951IpFeeInitOutDTO outDto = new S17951IpFeeInitOutDTO();
		if(prepayFee - unPayOwe>0) {
			outDto.setPrepayFee(prepayFee - unPayOwe);
		}else {
			outDto.setPrepayFee(0);
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
