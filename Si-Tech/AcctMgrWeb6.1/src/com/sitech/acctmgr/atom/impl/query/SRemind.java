package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.dto.query.SQryShortRemindAuthInDTO;
import com.sitech.acctmgr.atom.dto.query.SQryShortRemindAuthOutDTO;
import com.sitech.acctmgr.inter.query.IRemind;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "queryShortRemindAuth", c = SQryShortRemindAuthInDTO.class, oc = SQryShortRemindAuthOutDTO.class) })
public class SRemind implements IRemind {
	com.sitech.acctmgr.atom.entity.inter.IRemind remind;

	@Override
	public OutDTO queryShortRemindAuth(InDTO inparam) {
		// TODO Auto-generated method stub
		SQryShortRemindAuthInDTO inDTO = (SQryShortRemindAuthInDTO) inparam;

		String phoneNo = inDTO.getPhoneNo();
		int count = remind.queryShortRemindAuth(phoneNo);

		SQryShortRemindAuthOutDTO outDto = new SQryShortRemindAuthOutDTO();
		if (count == 0) {
			outDto.setRtnCode("000002");
			outDto.setRtnMsg("用户没有权限接收短信提醒");
		}

		return outDto;
	}

	public com.sitech.acctmgr.atom.entity.inter.IRemind getRemind() {
		return remind;
	}

	public void setRemind(com.sitech.acctmgr.atom.entity.inter.IRemind remind) {
		this.remind = remind;
	}

}
