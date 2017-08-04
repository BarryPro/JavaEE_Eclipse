package com.sitech.acctmgr.atom.impl.query;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.atom.domains.bill.PayItemCodeEntity;
import com.sitech.acctmgr.atom.domains.bill.WriteOffItemEntity;
import com.sitech.acctmgr.atom.dto.query.S8418InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8418InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.I8418;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(c = S8418InitInDTO.class,oc=S8418InitOutDTO.class, m = "query")
	})
public class S8418 extends AcctMgrBaseService implements I8418{

	protected IBalance balance;
	protected IBill bill;
	
	@Override
	public OutDTO query(InDTO inParam) {
		List<PayItemCodeEntity> resultList = new ArrayList<PayItemCodeEntity>();
		Map<String,Object> inMap = new HashMap<String,Object>();
		Map<String,Object> outMap = new HashMap<String,Object>();
		
		S8418InitInDTO inDto = (S8418InitInDTO)inParam;
		String payName = inDto.getPayName();
		
		inMap.put("PAY_NAME", payName);
		try {
			outMap = balance.getBookTypeDict(inMap);			
		}catch(Exception e) {
			throw new BusiException(AcctMgrError.getErrorCode("8418", "00001"), "冲销指定账目项查询失败！");
		}finally {
			
		}
		String payType = outMap.get("PAY_TYPE").toString();
		
		List<ItemEntity> tempList = bill.getPayTypeItem(payType);
		for(ItemEntity tempEntity:tempList) {
			PayItemCodeEntity ieTemp = new PayItemCodeEntity();
			ieTemp.setItemName(tempEntity.getItemName());
			ieTemp.setPayName(payName);
			resultList.add(ieTemp);
		}
		
		S8418InitOutDTO outDto = new S8418InitOutDTO();
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

	/**
	 * @return the bill
	 */
	public IBill getBill() {
		return bill;
	}

	/**
	 * @param bill the bill to set
	 */
	public void setBill(IBill bill) {
		this.bill = bill;
	}
	
}
