package com.sitech.acctmgr.atom.impl.billAccount;

import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SInsRemindCtrlInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SInsRemindCtrlOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.IInsRemindCtrl;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "cfm", c = SInsRemindCtrlInDTO.class, oc = SInsRemindCtrlOutDTO.class)
})
public class SInsRemindCtrl extends AcctMgrBaseService implements IInsRemindCtrl{

	protected IUser user;
	protected IBillAccount billAccount;
	
	@Override
	public OutDTO cfm(InDTO inParam) {
		
		SInsRemindCtrlInDTO inDto = (SInsRemindCtrlInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String opType = inDto.getOpType();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		
		if(opType.equals("QXDXTX")){
			billAccount.saveRemindCtrlInfo(phoneNo, idNo);
		}else if(opType.equals("KTDXTX")){
			billAccount.delRemindCtrlInfo(phoneNo, idNo);
		}
		
		SInsRemindCtrlOutDTO outDto = new SInsRemindCtrlOutDTO();
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
	 * @return the billAccount
	 */
	public IBillAccount getBillAccount() {
		return billAccount;
	}

	/**
	 * @param billAccount the billAccount to set
	 */
	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}
	
}
