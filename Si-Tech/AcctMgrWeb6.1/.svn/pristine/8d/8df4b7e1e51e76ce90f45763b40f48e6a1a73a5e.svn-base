package com.sitech.acctmgr.atom.impl.billAccount;

import com.sitech.acctmgr.atom.dto.acctmng.S3104InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S3104OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.I3104;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "cfm", c = S3104InDTO.class, oc = S3104OutDTO.class)
})
public class S3104 extends AcctMgrBaseService implements I3104{
	private IBillAccount billAccount;
	@Override
	public OutDTO cfm(InDTO inParam) {
		S3104InDTO inDto = (S3104InDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		billAccount.saveWlanOpenChg(phoneNo);
		
		//TODO 调用开通接口，待定
		
		S3104OutDTO outDto = new S3104OutDTO();
		return outDto;
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
