package com.sitech.acctmgr.atom.busi.pay.hlj;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.trans.TransAccount;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.dto.pay.S8014InitInDTO;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.util.DateUtil;

/**
*
* <p>Title: 空中充值转账  </p>
* <p>Description: 空中充值业务：空中充值代理商账户向普通用户做转账动作  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author qiaolin
* @version 1.0
*/
public class TransKcAgent extends TransAccount {
	
	private static final String PAY_TYPE_STR = "0,1";

	/* 获取可转金额 */
	@Override
	public long getTranFee(long inContractNo) {
		
		long transFee = 0;
		long contractNo = inContractNo;
		
		log.info("TransKcAgent getTranFee inParam contractNo["+inContractNo+"]");
		
		//空中充值转账，转账账本为0 1账本
		transFee = balance.getSumBalacneByPayTypes(contractNo,PAY_TYPE_STR);

		return transFee;
	}
	
	/* 获取转账列表 */
	@Override
	public List<Map<String, Object>> getTranFeeList(long inContractNo){
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		//空中充值转账，转账账本为0 1账本
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("PAY_TYPE_STR", PAY_TYPE_STR);
		
		outList = balance.getAcctBookList(inMap);
		
		return outList;
	}

	public String getOpNote(String opNote) {
		if(opNote == null){
			opNote = "空中充值";
		}
		return opNote;
	}

}
