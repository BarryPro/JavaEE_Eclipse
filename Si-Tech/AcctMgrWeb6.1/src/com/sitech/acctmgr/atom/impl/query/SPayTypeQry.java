package com.sitech.acctmgr.atom.impl.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.pay.PayTypeEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SJudgePayTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.SJudgePayTypeOutDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.IPayTypeQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = SPayTypeInitInDTO.class, oc = SPayTypeInitOutDTO.class),
	@ParamType(m = "judgePayType", c = SJudgePayTypeInDTO.class, oc = SJudgePayTypeOutDTO.class)
})
public class SPayTypeQry extends AcctMgrBaseService implements IPayTypeQry{
	protected IBalance balance;
	protected IUser user;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		SPayTypeInitInDTO inDto = (SPayTypeInitInDTO)inParam;
		String queryFlag = inDto.getQueryFlag();
		
		List<PayTypeEntity> list = balance.getPayTypeForCrm(queryFlag);
		
		SPayTypeInitOutDTO outDto = new SPayTypeInitOutDTO();
		outDto.setPayTypeList(list);
		return outDto;
	}
	
	@Override
	public OutDTO judgePayType(InDTO inParam) {

		SJudgePayTypeInDTO inDto = (SJudgePayTypeInDTO)inParam;
		SJudgePayTypeOutDTO outDto = new SJudgePayTypeOutDTO();
		String phoneNo = inDto.getPhoneNo();
		String payType = inDto.getPayType();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long contractNo = uie.getContractNo();
		String runCode = uie.getRunCode();
		
		String judgeFlag = "";
		String reasonNote = "";
		String effectTime = "";
		if(!runCode.equals("A")) {
			judgeFlag="0";
			reasonNote="该用户处于非在网状态，不能办理业务";
		}
		
		int cnt = balance.getCntByPayType(contractNo, payType);
		if(cnt>0) {
			judgeFlag="0";
			reasonNote="该用户已订购本次业务，不能重复订购";
		}else {
			judgeFlag="1";
		}
		if(judgeFlag.equals("1")) {
			effectTime=DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS);
		}
		outDto.setJudgeFlag(judgeFlag);
		outDto.setEffectTime(effectTime);
		outDto.setReasonNote(reasonNote);
		return outDto;
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


	
}
