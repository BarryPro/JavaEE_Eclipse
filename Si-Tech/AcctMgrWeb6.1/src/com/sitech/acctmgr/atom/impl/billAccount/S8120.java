package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.query.ProvCriticalEntity;
import com.sitech.acctmgr.atom.dto.acctmng.S8120QryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8120QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.I8120;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = S8120QryInDTO.class, oc = S8120QryOutDTO.class)
})
public class S8120 extends AcctMgrBaseService implements I8120{

	private IBillAccount billAccount;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		S8120QryInDTO inDto = (S8120QryInDTO)inParam;
		String opType = inDto.getOpType();
		String mscId = inDto.getMscId();
		String lacId = inDto.getLacId();
		String cellId = inDto.getCellId();
		String beginTime = inDto.getBeginTime();
		String endTime = inDto.getEndTime();
		
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("OP_TYPE", opType);
		inMap.put("MSC_ID", mscId);
		inMap.put("LAC_ID", lacId);
		inMap.put("CELL_ID", cellId);
		inMap.put("BEGIN_DATE", beginTime);
		inMap.put("END_DATE", endTime);
		List<ProvCriticalEntity> resultList = billAccount.getProvCriticalInfo(inMap);
		S8120QryOutDTO outDto = new S8120QryOutDTO();
		outDto.setResultList(resultList);
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
