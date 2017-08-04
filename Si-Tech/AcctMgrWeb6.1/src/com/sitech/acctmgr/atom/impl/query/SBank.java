package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cust.PostBankEntity;
import com.sitech.acctmgr.atom.dto.query.SBankPostQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SBankPostQueryOutDTO;
import com.sitech.acctmgr.atom.dto.query.SBankQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SBankQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IBank;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/7.
 */
@ParamTypes({ @ParamType(c = SBankQueryInDTO.class, m = "query", oc = SBankQueryOutDTO.class),
		@ParamType(c = SBankPostQueryInDTO.class, m = "postQuery", oc = SBankPostQueryOutDTO.class)

})
public class SBank extends AcctMgrBaseService implements IBank {
	private IBase base;
	private IGroup group;

	public OutDTO query(InDTO inParam) {
		SBankQueryInDTO inDto = (SBankQueryInDTO) inParam;
		log.debug("inDto=" + inDto.getMbean());

		String bankCode = "";
		if (StringUtils.isNotEmptyOrNull(inDto.getBankCode())) {
			bankCode = inDto.getBankCode();
		}
		List<BankEntity> bankList = base.getBankInfo(inDto.getGroupId(), inDto.getProvinceId(), bankCode, null);

		SBankQueryOutDTO outDto = new SBankQueryOutDTO();
		outDto.setBankList(bankList);

		log.debug("outDto=" + outDto.toJson());
		return outDto;
	}



	@Override
	public OutDTO postQuery(InDTO inParam) {
		SBankPostQueryInDTO inDto = (SBankPostQueryInDTO) inParam;
		log.debug("inDto=" + inDto.getMbean());

		ChngroupRelEntity groupInfo = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());

		List<PostBankEntity> postBankList = base.getPostBankInfo(groupInfo.getRegionCode(), inDto.getPostBankCode());
		List<BankEntity> bankList = new ArrayList<>();
		for (PostBankEntity postBank : postBankList) {
			BankEntity bankEnt = new BankEntity();
			bankEnt.setBankCode(postBank.getPostCode());
			bankEnt.setBankName(postBank.getBankName());
			bankList.add(bankEnt);
		}

		SBankQueryOutDTO outDto = new SBankQueryOutDTO();
		outDto.setBankList(bankList);

		log.debug("outDto=" + outDto.toJson());
		return outDto;
	}

	public IBase getBase() {
		return base;
	}

	public void setBase(IBase base) {
		this.base = base;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}
}
