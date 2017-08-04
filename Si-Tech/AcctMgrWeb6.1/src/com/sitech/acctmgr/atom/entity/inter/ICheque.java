package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.atom.domains.pay.ChequeEntity;

import java.util.List;
import java.util.Map;

public interface ICheque {

    /**
     * 取支票信息
     *
     * @param BANK_CODE
     * @param CHECK_NO
     * @return CNT：支票数
     * @author xiongjy
     */
    int getCheckPrepayInfo(String bank_code, String check_no);

    /**
     * 增加支票信息
     *
     * @param BANK_CODE
     * @param CHECK_NO
     * @return
     * @author xiongjy
     */
    void saveCheckPrepayInfo(Map<String, Object> inParam);

    /**
     * 更改支票信息
     *
     * @param BANK_CODE
     * @param CHECK_NO
     * @return CNT：支票数
     * @author xiongjy
     */
    void updateCheckPrepayInfo(Map<String, Object> inParam);

    /**
     * 删除支票信息
     *
     * @param BANK_CODE
     * @param CHECK_NO
     * @return CNT：支票数
     * @author xiongjy
     */
    void removeCheckPrepayInfo(String bank_code, String check_no);

    /**
     * 查询银行信息
     *
     * @param BANK_CODE 银行代码
     * @param CHECK_NO  支票号码
     * @return CHECK_PREPAY 支票余额
     * @author LIJXD
     */
    long getCheckPrepay(String bankCode, String CheckNo);

    /**
     * 扣除支票金额，插入支票记录表
     *
     * @param BANK_CODE   银行代码
     * @param CHECK_NO    支票号码
     * @param CHECK_PAY   支票扣减金额
     * @param PAY_SN
     * @param LOGIN_GROUP
     * @param LOGIN_NO
     * @param OP_CODE
     * @param REMARK      备注
     * @return
     * @author LIJXD
     */
    void doReduceCheck(ChequeEntity cheque, PayBookEntity inBook);
    
    /**
     * 回退支票金额，插入支票记录表
     *
     * @param BANK_CODE   银行代码
     * @param CHECK_NO    支票号码
     * @param CHECK_PAY   支票扣减金额
     * @param PAY_SN
     * @param LOGIN_GROUP
     * @param LOGIN_NO
     * @param OP_CODE
     * @param REMARK      备注
     * @return
     * @author liuyc_billing
     */
    void doAddCheck(ChequeEntity cheque, PayBookEntity inBook);

    /**
     * 查询银行信息列表
     *
     * @param BANK_CODE    银行代码
     * @param CHECK_NO     支票号码
     * @param CHECK_PREPAY 支票余额
     * @return
     */
    List<Map<String, Object>> getCheckList(Map<String, Object> inMap);
    
    /**
	 * 记录支票使用记录表
	 * @param  表全量字段
	 * @return 
	 */	
	void insCheckOpr(Map<String, Object> inParam);	
	
	 /**
     * 增加支票详细信息
     *
     * @param map
     * @return
     * @author xiongjy
     */
    void saveCheckMsgInfo(Map<String, Object> inParam);
    
    /**
     * 验证银行和支票信息
     *
     * @param 
     * @return
     * @author liuyc
     */
    long getCheckCount(String bankCode,String checkNo);
    
    /**
     * 查询支票记录，主要为了冲正使用
     *
     * @param 
     * @return
     * @author liuyc
     */
    Map<String, Object> getCheckOpr(long paySn);

    
    
    /**
     * 删除支票详细信息
     *
     * @param 
     * @return
     * @author hanfl
     */
    void deleteCheckMsgInfo(String bankCode,String checkNo,Map<String ,Object> inMap);
    
    /**
     * 取支票信息
     *
     * @param BANK_CODE
     * @param CHECK_NO
     * @return 支票信息
     * @author hanfl
     */
    Map<String ,Object> getCheckMsgInfo(String bank_code, String check_no);
    
}
