package com.sitech.acctmgr.atom.busi.pay.trans;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;

public class TransAccountRel extends TransAccount {
	
	public String getTransTypes(){
		return "0";
	}
	
	/* 获取按账本合并后的转账列表 */
	@Override
	public List<TransFeeEntity> getComTranFeeList(long inContractNo){
		List<TransFeeEntity> outList = new ArrayList<TransFeeEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("PAY_TYPE_STR", getTransTypes());
		
		outList = remainFee.getBookList(inMap);

		return outList;
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
	
	/*地市月限额验证*/
	public void checkRegionLimit(String regionGroup,String limitType,long transFee){
		
	}
	
}
