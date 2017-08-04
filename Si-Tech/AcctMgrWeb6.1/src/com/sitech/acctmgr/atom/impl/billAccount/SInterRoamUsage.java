package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.InterRoamProdInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SInterRoamUsageQryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SInterRoamUsageQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.IInterRoamUsage;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = SInterRoamUsageQryInDTO.class, oc = SInterRoamUsageQryOutDTO.class)
})
public class SInterRoamUsage extends AcctMgrBaseService implements IInterRoamUsage{

	protected IBillAccount billAccount;
	
	@Override
	public OutDTO query(InDTO inParam) {
		SInterRoamUsageQryInDTO inDTO = (SInterRoamUsageQryInDTO)inParam;
		 log.debug("inDTO=" + inDTO.getMbean());

	    String phoneNo = inDTO.getPhoneNo();
	    
	    List<InterRoamProdInfoEntity> irpieList =  billAccount.getInterRoamUsage(phoneNo);
	    
	    SInterRoamUsageQryOutDTO outDTO = new SInterRoamUsageQryOutDTO();
	    outDTO.setInfoList(irpieList);
	    
	    log.debug("outDTO=" + outDTO.toJson());
		return outDTO;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}
	
}
