package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.TdUnifyPayEntity;
import com.sitech.acctmgr.atom.dto.query.S8420InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8420InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.I8420;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(c = S8420InitInDTO.class,oc=S8420InitOutDTO.class, m = "query")
	})
public class S8420 extends AcctMgrBaseService implements I8420{

	protected IBalance balance;
	
	@Override
	public OutDTO query(InDTO inParam) {
		List<TdUnifyPayEntity> resultList = new ArrayList<TdUnifyPayEntity>();
		S8420InitInDTO inDto = (S8420InitInDTO)inParam;
		String yearMonth = inDto.getYearMonth();
		long contractNo = inDto.getContractNo();
		
		resultList = balance.getTdTrasfeeInfo(contractNo, yearMonth);
		
		S8420InitOutDTO outDto = new S8420InitOutDTO();
		outDto.setResultList(resultList);
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
	
}
