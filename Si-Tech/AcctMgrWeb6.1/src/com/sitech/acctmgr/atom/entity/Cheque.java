package com.sitech.acctmgr.atom.entity;

import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.atom.domains.pay.ChequeEntity;
import com.sitech.acctmgr.atom.entity.inter.ICheque;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.core.exception.BusiException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cheque extends BaseBusi implements ICheque {

	@Override
	public int getCheckPrepayInfo(String bank_code, String check_no) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("BANK_CODE", bank_code);
		inMap.put("CHECK_NO", check_no);
		Map<String, Object> result = (Map<String, Object>) baseDao
				.queryForObject("bal_checkprepay_info.qry", inMap);
		return Integer.parseInt(result.get("CNT").toString());
	}

	@Override
	public void saveCheckPrepayInfo(Map<String, Object> inParam) {
		
		baseDao.insert("bal_checkprepay_info.insert", inParam);
	}

	@Override
	public void updateCheckPrepayInfo(Map<String, Object> inParam) {
		
		baseDao.update("bal_checkprepay_info.update", inParam);
	}

	@Override
	public void removeCheckPrepayInfo(String bank_code, String check_no) {
		
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("BANK_CODE", bank_code);
		inMap.put("CHECK_NO", check_no);
		baseDao.delete("bal_checkprepay_info.del", inMap);
	}

	@Override
	public long getCheckPrepay(String bankCode, String CheckNo) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("BANK_CODE", bankCode);
		inMap.put("CHECK_NO", CheckNo);
		Map<String, Object> result = (Map<String, Object>) baseDao
				.queryForObject("bal_checkprepay_info.qPrepay", inMap);
		if (result == null) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00080"),
					"支票号码不存在");
		}
		long lCheckPrepay = Long.parseLong(result.get("CHECK_PREPAY")
				.toString());
		return lCheckPrepay;
	}

	@Override
	public void doReduceCheck(ChequeEntity cheque, PayBookEntity inBook) {
		
		Map<String, Object> inMap = new HashMap<>();
		inMap.putAll(cheque.toMap());
		inMap.putAll(inBook.toMap());
		inMap.put("CHECK_PAY", inMap.get("PAY_FEE"));
		
		// 扣减支票金额
		int iCnt = baseDao.update("bal_checkprepay_info.subFee", inMap);
		if (iCnt == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00015"),
					"支票不存在或者余额不足");
		}
		// 插入支票记录表
		baseDao.insert("bal_checkopr_recd.ins", inMap);
	}
	
	@Override
	public void doAddCheck(ChequeEntity cheque, PayBookEntity inBook) {
		Map<String, Object> inMap = new HashMap<>();
		inMap.putAll(cheque.toMap());
		inMap.putAll(inBook.toMap());
		inMap.put("CHECK_PAY", inMap.get("PAY_FEE"));
		
		// 增加支票金额
		int iCnt = baseDao.update("bal_checkprepay_info.subFee", inMap);
		// 插入支票记录表
		baseDao.insert("bal_checkopr_recd.ins", inMap);
	}
	
	@Override
	public long getCheckCount(String bankCode,String checkNo) {
		Map inMap = new HashMap();
		inMap.put("BANK_CODE", bankCode);
		inMap.put("CHECK_NO", checkNo);
		long cnt = (Long) baseDao.queryForObject("bal_checkmsg_info.qCheckNoCount", inMap);

		return cnt;
	}

	@Override
	public List<Map<String, Object>> getCheckList(Map<String, Object> inMap) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		resultList = (List<Map<String, Object>>) baseDao.queryForList(
				"bal_checkprepay_info.qPrepayBank", inMap);

		return resultList;
	}
	
	@Override
	public void insCheckOpr(Map<String, Object> inParam){
		// 插入支票记录表
		baseDao.insert("bal_checkopr_recd.ins", inParam);
	}
	
	@Override
	public Map<String, Object> getCheckOpr(long paySn) {
		// TODO Auto-generated method stub
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PAY_SN", paySn);
		Map<String, Object> outMap =new HashMap<String, Object>();
		outMap = (Map<String, Object>) baseDao.queryForObject("bal_checkopr_recd.qryCheckOpr", inMap);
		return outMap;
	}
	
	@Override
	public  void saveCheckMsgInfo(Map<String, Object> inParam){
		baseDao.insert("bal_checkmsg_info.iBalCheckMsgInfo", inParam);
	}

	@Override
	public void deleteCheckMsgInfo(String bankCode, String checkNo ,Map<String ,Object> updateInfo) {

		// 插入bal_checkmsg_his表
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("BANK_CODE", bankCode);
		inMap.put("CHECK_NO", checkNo);
		inMap.put("UPDATE_ACCEPT", updateInfo.get("UPDATE_ACCEPT"));
		inMap.put("UPDATE_TYPE", "D");
		inMap.put("UPDATE_DATE", updateInfo.get("UPDATE_DATE"));
		inMap.put("UPDATE_LOGIN", updateInfo.get("UPDATE_LOGIN"));
		inMap.put("UPDATE_CODE", updateInfo.get("UPDATE_CODE"));
		baseDao.insert("bal_checkmsg_info_his.ins",inMap);

		Map<String, Object> delMap = new HashMap<String, Object>();
		delMap.put("BANK_CODE", bankCode);
		delMap.put("CHECK_NO", checkNo);
		baseDao.delete("bal_checkmsg_info.del", delMap);

	}

	@Override
	public Map<String, Object> getCheckMsgInfo(String bank_code, String check_no) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("BANK_CODE", bank_code);
		inMap.put("CHECK_NO", check_no);
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject(
				"bal_checkmsg_info.query",inMap);
		return result;
	}


}
