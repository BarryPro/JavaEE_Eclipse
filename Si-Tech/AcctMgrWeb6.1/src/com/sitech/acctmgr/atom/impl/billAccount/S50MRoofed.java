package com.sitech.acctmgr.atom.impl.billAccount;

import com.sitech.acctmgr.atom.dto.acctmng.S50MRoofedInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S50MRoofedOutDTO;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.I50MRoofed;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "cfm", c = S50MRoofedInDTO.class, oc = S50MRoofedOutDTO.class)
})

public class S50MRoofed extends AcctMgrBaseService implements I50MRoofed{

	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
