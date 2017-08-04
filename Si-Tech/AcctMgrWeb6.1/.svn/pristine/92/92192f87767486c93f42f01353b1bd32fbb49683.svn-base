package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SUnifyPortalInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SUnifyPortalInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.feeqry.IUnifyPortalQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = SUnifyPortalInitInDTO.class, oc = SUnifyPortalInitOutDTO.class)
})
public class SUnifyPortalQry extends AcctMgrBaseService implements IUnifyPortalQry{

	protected IUser user;
	protected IBill bill;
	protected IFreeDisplayer freeDisplayer;
	protected IBalance balance;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		Map<String,Long> outMap = new HashMap<String,Long>();
		
		SUnifyPortalInitInDTO inDto = (SUnifyPortalInitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String totalDate = inDto.getTotalDate();
		
		//取默认账户
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long contractNo = uie.getContractNo();
		long idNo = uie.getIdNo();
		
		//取上月时间
		int curYm = DateUtils.getCurYm();
		int lastMonth = DateUtils.addMonth(curYm, -1);
		
		//查询上月账单
		outMap = bill.getSumUnpayInfo(contractNo, null, lastMonth);
		long oweFee = outMap.get("OWE_FEE");
		
		//查询内存欠费
		UnbillEntity ube = bill.getUnbillFee(contractNo, idNo, CommonConst.UNBILL_TYPE_BILL_TOT);
		long unBillFee = ube.getUnBillFee();
		
		//查询上网流量
		//outMap = freeDisplayer.getFreeTotalMap(phoneNo, Integer.parseInt(totalDate), "3");
		//long allGprs = outMap.get("GPRS_USED")+outMap.get("GPRS_OUT_MEAL");
		long allGprs = 0;
		
		//
		long prepayFee = balance.getAcctBookSum(contractNo, null);
		
		SUnifyPortalInitOutDTO outDto = new SUnifyPortalInitOutDTO(); 
		outDto.setAllGprs(allGprs);
		outDto.setOweFee(oweFee);
		outDto.setPrepayFee(prepayFee);
		outDto.setUnBillFee(unBillFee);
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
	 * @return the freeDisplayer
	 */
	public IFreeDisplayer getFreeDisplayer() {
		return freeDisplayer;
	}

	/**
	 * @param freeDisplayer the freeDisplayer to set
	 */
	public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
		this.freeDisplayer = freeDisplayer;
	}
	
}
