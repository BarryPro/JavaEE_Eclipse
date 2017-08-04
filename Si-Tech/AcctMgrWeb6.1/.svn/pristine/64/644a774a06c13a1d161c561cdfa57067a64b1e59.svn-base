package com.sitech.acctmgr.atom.busi.pay.hlj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.trans.TransAccount;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;

public class TransSpecial extends TransAccount{
	
	@Override
	public String getTransTypes(){
		
		return "d,1,0,BC,BZ,BQ,BX,BY,EI,EJ";
	}
	
	/* 获取转账列表 */
	@Override
	public List<Map<String, Object>> getTranFeeList(long inContractNo){
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);		
		inMap.put("PAY_TYPE_STR", getTransTypes());
		
		outList = balance.getAcctBookList(inMap);

		return outList;
	}

}
