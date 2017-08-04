package com.sitech.acctmgr.atom.impl.feeqry;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.balance.PrepayEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SBalanceOpenInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SBalanceOpenOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.IBalanceOpen;
import com.sitech.acctmgrint.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({
	@ParamType(m = "query", c = SBalanceOpenInDTO.class, oc = SBalanceOpenOutDTO.class) })
public class SBalanceOpen extends AcctMgrBaseService implements IBalanceOpen{

	private IUser user;
	private IRemainFee remainFee;
	private IBalance balance;
	
	@Override
	public OutDTO query(InDTO inDTO) {
		// TODO Auto-generated method stub
		SBalanceOpenInDTO inDto = (SBalanceOpenInDTO)inDTO;
		SBalanceOpenOutDTO outDto = new SBalanceOpenOutDTO();
		String phoneNo = inDto.getServiceNumber();
		
        String retCode = "0000";
        String retMsg = "成功";
        UserInfoEntity uie = user.getUserEntityByPhoneNo(phoneNo, false);
        if (uie == null) {
            retCode = "4005";
            retMsg = "使用用户手机号码非法（不存在）";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);

            return outDto;
        }
		long contractNo = uie.getContractNo();
		
		OutFeeData outFee = remainFee.getConRemainFee(contractNo);
		long remainFee = outFee.getRemainFee();
		
		PrepayEntity peAll = balance.getAllPrepay(contractNo);
		long CurFeeTotal = remainFee+peAll.getWillPrepayAll();
		
		outDto.setRetCode(retCode);
		outDto.setRetMsg(retMsg);
		outDto.setBalance(String.valueOf(ValueUtils.transFenToYuan(remainFee)));
		outDto.setCurFeeTotal(String.valueOf(ValueUtils.transFenToYuan(CurFeeTotal)));
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
