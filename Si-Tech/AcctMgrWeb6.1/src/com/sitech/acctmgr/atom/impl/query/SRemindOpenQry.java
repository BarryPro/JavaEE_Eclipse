package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.RemindOpenEntity;
import com.sitech.acctmgr.atom.dto.query.SRemindOpenInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SRemindOpenInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IRemind;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IRemindOpenQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "query", c = SRemindOpenInitInDTO.class, oc = SRemindOpenInitOutDTO.class) })
public class SRemindOpenQry extends AcctMgrBaseService implements
		IRemindOpenQry {

	private IRemind remind;

	@Override
	public OutDTO query(InDTO inParam) {
		SRemindOpenInitInDTO inDTO = (SRemindOpenInitInDTO) inParam;

		List<RemindOpenEntity> remindList = new ArrayList<RemindOpenEntity>();
		String phoneNo = inDTO.getPhoneNo();

		remindList = remind.queryRemindOpenOrOff(phoneNo);

		SRemindOpenInitOutDTO outDTO = new SRemindOpenInitOutDTO();
		outDTO.setRuleList(remindList);

		return outDTO;
	}

	public IRemind getRemind() {
		return remind;
	}

	public void setRemind(IRemind remind) {
		this.remind = remind;
	}

}
