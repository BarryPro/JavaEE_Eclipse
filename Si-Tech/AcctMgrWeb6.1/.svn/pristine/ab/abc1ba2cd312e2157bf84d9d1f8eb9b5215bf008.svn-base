package com.sitech.acctmgr.atom.impl.billAccount;

import com.sitech.acctmgr.atom.dto.query.SSmsRightJudgeInDTO;
import com.sitech.acctmgr.atom.dto.query.SSmsRightJudgeIsGprsCmdInDTO;
import com.sitech.acctmgr.atom.dto.query.SSmsRightJudgeIsGprsCmdOutDTO;
import com.sitech.acctmgr.atom.dto.query.SSmsRightJudgeOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.billAccount.ISmsRightJudge;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = SSmsRightJudgeInDTO.class, oc = SSmsRightJudgeOutDTO.class),
	@ParamType(m = "isGprsCmd", c = SSmsRightJudgeIsGprsCmdInDTO.class, oc = SSmsRightJudgeIsGprsCmdOutDTO.class)
})
public class SSmsRightJudge extends AcctMgrBaseService implements ISmsRightJudge{

	protected IBillAccount billAccount;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		SSmsRightJudgeInDTO inDto = (SSmsRightJudgeInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		int count = billAccount.getCntRemindCtrlFav(phoneNo);
		if(count==0){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00075"), "用户没有权限升级流量包！");
		}
		
		SSmsRightJudgeOutDTO outDto = new SSmsRightJudgeOutDTO();
		return outDto;
	}
	
	public OutDTO isGprsCmd(final InDTO inParam){
		
		SSmsRightJudgeIsGprsCmdInDTO inDto = (SSmsRightJudgeIsGprsCmdInDTO)inParam;
		
		boolean flag = billAccount.isGprsCmd(inDto.getPhoneNo());
		String outFlag = "";
		if(flag){
			outFlag = "1";
		}else{
			outFlag = "0";
		}
		
		SSmsRightJudgeIsGprsCmdOutDTO outDto = new SSmsRightJudgeIsGprsCmdOutDTO();
		outDto.setGprsFlas(outFlag);
		
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
