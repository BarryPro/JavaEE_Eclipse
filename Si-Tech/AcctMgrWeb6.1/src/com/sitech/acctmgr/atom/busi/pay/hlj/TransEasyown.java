package com.sitech.acctmgr.atom.busi.pay.hlj;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.trans.TransAccount;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.dto.pay.S8014InitInDTO;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.jcf.core.exception.BaseException;

/**
*
* <p>Title: 神州行转账  </p>
* <p>Description: 神州行转账余额查询、特殊业务信息查询及处理  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class TransEasyown extends TransAccount {
	
	public String getTransTypes(){
		return "3,d,0";
	}
	
	/* 获取按账本合并后的转账列表 */
	@Override
	public List<TransFeeEntity> getComTranFeeList(long inContractNo){
		List<TransFeeEntity> outList = new ArrayList<TransFeeEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		//神州行转账，转账本为('3', 'd', '0')的预存，预存全转
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
		
		//神州行转账，转账本为('3', 'd', '0')的预存，预存全转
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("PAY_TYPE_STR", getTransTypes());
		
		outList = balance.getAcctBookList(inMap);
		
		return outList;
	}
	
	/* 个性化业务查询 */
	@Override
	public Map<String, Object> getSpecialBusiness(Map<String, Object> inMap){
		S8014InitInDTO inDto = (S8014InitInDTO) inMap.get("IN_DTO");
		String prcId = (String) inMap.get("PRC_ID");
		long outIdNo = inDto.getIdNo();
		List<String> list= Arrays.asList(PayBusiConst.SZX_PRCID);
		/* 非神州行用户不能转账 */
		if (!(list.contains(prcId))) {
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00044"), "该品牌不能预存转存!");
		}
		/* 非有效期用户不能转账 */
		boolean isUserExpire = user.isUserExpire(outIdNo, 1);
		log.info("-----> isUserExpire = " + isUserExpire);
		if (!isUserExpire) {
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00029"), "查不到有效期或用户不是保留期或保号期!");
		}
		/* TODO 手续费信息查询 */
		
		return null;
	}
	
	/*确认服务个性化验证*/
	@Override
	public void checkCfm(Map<String, Object> checkMap){
		PayUserBaseEntity inTransBaseInfo = (PayUserBaseEntity)checkMap.get("IN_TRANS_BASEINFO");
		long contractNo = inTransBaseInfo.getContractNo();
		ContractInfoEntity accountEntity = account.getConInfo(contractNo);
		String contractattType = accountEntity.getContractattType();
		/*不允许为空中充值代理商账户转账 */
		if(contractattType.equals(PayBusiConst.AIR_RECHARGE_CONTYPE)){
			throw new BaseException(AcctMgrError.getErrorCode("8014", "00019"), "转入号码不能是是空中充值代理商号码");
		}
	}
	
	/* 个性化业务处理 */
	@Override
	public void doSpecialBusi(Map<String, Object> inMap){
		/* TODO 转出账户发送停机指令*/
		
		/*实际的手续费>默认的手续费，记录优惠操作记录表*/
		
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.impl.pay.trans.TransType#getOpNote(java.lang.String)
	 */
	@Override
	public String getOpNote(String opNote) {
		if(opNote == null){
			opNote = "神州行余额转账";
		}
		return opNote;
	}
	
}
