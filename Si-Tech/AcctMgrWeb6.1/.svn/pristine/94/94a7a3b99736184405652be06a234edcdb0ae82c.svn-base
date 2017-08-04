package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.query.GrpFeeEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8422InitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8422InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.I8422;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = S8422InitInDTO.class, oc = S8422InitOutDTO.class, m = "query") })
public class S8422 extends AcctMgrBaseService implements I8422{

	private IAccount account;
	private IUser user;
	private IProd prod;
	private IBalance balance;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		List<GrpFeeEntity> resultList = new ArrayList<GrpFeeEntity>();
		S8422InitInDTO inDto = (S8422InitInDTO)inParam;
		String unitId = inDto.getUnitId();
		
		List<UserInfoEntity> grpList = user.getGrpUserInfoByUnitId(Long.parseLong(unitId));
		for(UserInfoEntity uie:grpList) {
			String phoneNo = "";
			String contractName = "";
			long prepayFee =0;
			String prcName ="";
			long idNo = uie.getIdNo();
			phoneNo = uie.getPhoneNo();
			UserPrcEntity upe = prod.getUserPrcidInfo(idNo);
			prcName = upe.getProdPrcName();
			List<ContractEntity> ceList = account.getConList(idNo); 
			for(ContractEntity ce:ceList) {
				if(ce.getBillOrder()==99999999) {
					continue;
				}
				long contractNo = ce.getCon();
				contractName = ce.getAccountName();
				prepayFee = balance.getAcctBookSum(contractNo, "");
				
				GrpFeeEntity gfe = new GrpFeeEntity();						
				gfe.setBankName(contractName);
				gfe.setContractNo(contractNo);
				gfe.setOfferName(prcName);
				gfe.setPhoneNo(phoneNo);
				gfe.setPrepayFee(prepayFee);
				resultList.add(gfe);
			}
			
		}
		
		S8422InitOutDTO outDto = new S8422InitOutDTO();
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
	 * @return the prod
	 */
	public IProd getProd() {
		return prod;
	}

	/**
	 * @param prod the prod to set
	 */
	public void setProd(IProd prod) {
		this.prod = prod;
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
	
}
