package com.sitech.acctmgr.atom.busi.pay.hlj;

import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.trans.TransAccount;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.dto.pay.S8014InitInDTO;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcf.core.exception.BusiException;

/**
*
* <p>Title: 在网空中充值拆机余额转账  </p>
* <p>Description: 空中充值拆机余额转账余额查询、特殊业务信息查询及处理  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class TransAirPayAccountClose extends TransAccount {
		
	/* 个性化业务查询 */
	@Override
	public Map<String, Object> getSpecialBusiness(Map<String, Object> inMap){
		S8014InitInDTO inDto = (S8014InitInDTO) inMap.get("IN_DTO");
		TransOutEntity baseInfo = (TransOutEntity)inMap.get("BASE_INFO");
		long idNo = inDto.getIdNo();
		String contractattType = baseInfo.getContractattType();
		/*判断用户是否为空中充值代理商用户*/
//		if(agent.isKcAgentPhone(idNo)){
//			throw new BaseException(AcctMgrError.getErrorCode("8014", "00019"), "该号码不是空中充值代理商");
//		}
		/*如果账户密码输入不为空,验证密码是否正确，如果密码为空的话不进行验证*/
		
		/*判断账户类型是否为空中充值账户’a’*/
		if(!contractattType.equals(PayBusiConst.AIR_RECHARGE_CONTYPE)){
			log.info("非空中充值账户不允许退预存款!");
			throw new BusiException(AcctMgrError.getErrorCode("8014","00025"), "该账户不是空中充值账户不允许退预存款!");
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.impl.pay.trans.TransType#getOpNote(java.lang.String)
	 */
	@Override
	public String getOpNote(String opNote) {
		
		opNote = opNote + "空中充值拆机账户余额转账";
		
		return opNote;
	}
	
	/* 个性化业务处理 */
	@Override
	public void doSpecialBusi(Map<String, Object> inMap){
		
	}
	
	/*确认服务个性化验证*/
	@Override
	public void checkCfm(Map<String, Object> checkMap){
		
	}

}
