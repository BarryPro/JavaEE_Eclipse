package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.BalanceFlagEnum;
import com.sitech.acctmgr.atom.domains.balance.BookPayoutEntity;
import com.sitech.acctmgr.atom.domains.balance.BookSourceEntity;
import com.sitech.acctmgr.atom.domains.balance.BookTypeEntity;
import com.sitech.acctmgr.atom.domains.balance.BookTypeEnum;
import com.sitech.acctmgr.atom.domains.balance.PrepayEntity;
import com.sitech.acctmgr.atom.domains.balance.ReturnFeeEntity;
import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.base.LoginBaseEntity;
import com.sitech.acctmgr.atom.domains.bill.FeeEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvoMutiMonEntity;
import com.sitech.acctmgr.atom.domains.pay.BatchPayRecdEntity;
import com.sitech.acctmgr.atom.domains.pay.CRMIntellPrtEntity;
import com.sitech.acctmgr.atom.domains.pay.MonthReturnFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayTypeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.query.SpFeeRecycleEntity;
import com.sitech.acctmgr.atom.domains.query.TdUnifyPayEntity;
import com.sitech.acctmgr.atom.domains.query.TransLimitEntity;

/**
 * <p>
 * Title: 预存款核心原子实体类
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author
 * @version 1.0
 */
public interface IBalance {

    /**
	 * 取账户预存：查询预存款，在线或者离线，根据配置实现
	 *
	 * @param CONTRACT_NO
	 *            : 账户ID
	 * @return FLAG：0:无专款预存 1：有专款预存<br/>
	 *         TOTAL_PREPAY：账户总预存<br/>
	 *         PREPAY_FEE：当前预存<br/>
	 *         GPREPAY_FEE：专款预存<br/>
	 */
    Map<String, Object> getConMsgFee(long lContractNo);

    /**
	 * 取账户预存
	 *
	 * @param CONTRACT_NO
	 *            : 账户ID
	 * @param IS_ONLINE
	 *            : 是否在线或离线
	 * @return FLAG：0:无专款预存 1：有专款预存<br/>
	 *         TOTAL_PREPAY：账户总预存<br/>
	 *         PREPAY_FEE：当前预存<br/>
	 *         GPREPAY_FEE：专款预存<br/>
	 */
    Map<String, Object> getConMsgFee(long lContractNo, boolean isOnline);

    /**
	 * 取账本总可使用金额金额
	 *
	 * @param contractNo
	 *            : 账户号码
	 * @param payType
	 *            : 账本类型,如果传null,则取所有可使用账本
	 * @return 账本预存
	 */
    long getAcctBookSum(long contractNo, String payType);

    /**
	 * 名称：取离网账户的总预存
	 *
	 * @param CONTRACT_NO
	 * @return CUR_BALANCE
	 */
    long getAcctBookDeadSum(Map<String, Object> inParam);

    /**
	 * 名称：取账本列表
	 *
	 * @param CONTRACT_NO账户
	 * @return ACCTBOOK_LIST <br/>
	 *         ACCTBOOK_LIST.BALANCE_ID <br/>
	 *         ACCTBOOK_LIST.PAY_TYPE <br/>
	 *         ACCTBOOK_LIST.CUR_BALANCE <br/>
	 * @author LIJXD
	 */
    List<Map<String, Object>> getAcctBookList(Map<String, Object> inParam);
	
	
	/**
	 * 名称：查询转账记录
	 *
	 * @param CONTRACT_NO账户
	 * @return TransFeeEntity <br/>
	 * @author liuyc_billing
	 */
	List<TransFeeEntity> getTransInfo(Map<String, Object> inParam);

    /**
	 * 名称：按条件取离网账户的预存
	 *
	 * @param CONTRACT_NO
	 * @return CUR_BALANCE
	 */
    List<Map<String, Object>> getDeadBookList(Map<String, Object> inParam);

    /**
	 * 取在网可转账本总可使用金额金额
	 *
	 * @param contractNo
	 *            : 账户号码
	 * @param PAY_ATTR
	 *            : 可转账本属性
	 * @return 账本预存
	 */
    long getSumTransFee(long contractNo, String payAttr);

    /**
	 * 取离网可转账本总可使用金额金额
	 *
	 * @param contractNo
	 *            : 账户号码
	 * @param PAY_ATTR
	 *            : 可转账本属性
	 * @return 账本预存
	 */
    long getSumTransDeadFee(long contractNo, String payAttr);

    /**
	 * 获取在网账户多个账本总金额
	 *
	 * @param contractNo
	 *            : 账户号码
	 * @param payTypeStr
	 *            : 账本列表字符串,账本间用逗号分隔，例如：'3','d','0'
	 * @return 账本预存
	 */
    long getSumBalacneByPayTypes(long contractNo, String payTypeStr);

    /**
	 * 查询账本信息
	 *
	 * @param PAY_TYPE
	 *            : 账本类型
	 * @return
	 */
    Map<String, Object> getBookTypeDict(Map<String, Object> inParam);

    /**
	 * 功能：基于PAY_TYPE、PRIORITY、PAY_ATTR分组，获取帐户帐本总和信息
	 *
	 * @param inParam
	 *            <li>CONTRACT_NO （必传）<br>
	 *            </li> <li>SPECIAL_FLAG （可空）<br>
	 *            </li> <li>PAY_ATTR （可空）<br>
	 *            </li> <li>PAY_TYPE (可空)<br>
	 *            </li> <li>WRTOFF_FLAG (可空)<br>
	 *            </li> <li>WRTOFF_MONTH （可空）<br>
	 *            </li>
	 * @return ACCTBOOK_LIST
	 */
    Map<String, Object> getAcctBookGroup(Map<String, Object> inParam);

    /**
	 * 名称：更新账本余额
	 *
	 * @param BALANCE_ID
	 *            ：账本
	 * @param PAYED_OWE
	 *            ：更改金额
	 * @return
	 */
    int updateAcctBook(Map<String, Object> inParam);

    /**
	 * 名称：更新离网账本余额
	 *
	 * @param BALANCE_ID
	 *            ：账本
	 * @param PAYED_OWE
	 *            ：更改金额
	 * @return
	 */
    int updateAcctBookDead(long balanceId, long payedOwe);

    /**
	 * 名称：0账本移入历史表
	 *
	 * @param CONTRACT_NO
	 *            ：帐号
	 * @param LOGIN_NO
	 *            ：工号
	 * @return
	 */
    void removeAcctBook(long contractNo, String loginNo);
    
    /**
	 * 名称：0账本移入历史表
	 */
    void removeAcctBook(long contractNo, String loginNo, Long updateAccept, String opCode);
    
    void saveAcctbookHis(long contractNo, Long balanceId, String loginNo, Long updateAccept, String updateType, String opCode);

    /**
	 * 名称：
	 *
	 * @param CONTRACT_NO
	 *            账户
	 * @param LOGIN_NO
	 *            工号
	 * @return
	 */
    void removeAcctBookDead(long contractNo, String loginNo,Long updateAccept, String opCode);

    /**
	 * 名称：记录来源表
	 *
	 * @param PAY_SN
	 *            缴费流水
	 * @param CONTRACT_NO
	 *            账户
	 * @param ID_NO
	 *            用户标识
	 * @param BALANCE_ID
	 *            账本标识
	 * @param PAY_TYPE
	 *            账本类型
	 * @param PAY_FEE
	 *            金额
	 * @param STATUS
	 *            状态
	 * @param GROUP_ID
	 *            工号归属
	 * @param LOGIN_NO
	 *            工号
	 * @param BEGIN_TIME
	 *            开始时间
	 * @param END_TIME
	 *            结束时间，可空
	 * @return
	 */
    void saveSource(Map<String, Object> inParamMap);

    void saveSource(PayUserBaseEntity payUserBase, PayBookEntity inBook);

    /**
	 * 名称：记录账本余额表
	 *
	 * @param BALANCE_ID
	 *            : 账本标识ID
	 * @param CONTRACT_NO
	 *            : 账户ID
	 * @param PAY_TYPE
	 *            : 账本类型
	 * @param PAY_FEE
	 *            : 入账金额
	 * @param BEGIN_TIME
	 *            : 账本开始时间
	 * @param END_TIME
	 *            : 账本结束时间，可选入参，默认 "20991231235959"
	 * @param PAY_SN
	 *            : 缴费入账流水
	 * @param PRINT_FLAG
	 *            : 是否打印发票标识，默认为0 (0：未打印；1：月结已打印；2：预存已打印)
	 * @param FOREIGN_SN
	 *            : 外部流水 , 可选入参，接口调用缴费需要传入
	 * @return 无
	 * @author qiaolin
	 */
    void saveAcctBook(Map<String, Object> inParam);

    void saveAcctBook(PayUserBaseEntity payUserBase, PayBookEntity inBook);

    /**
	 * 名称：记录离网账本余额表
	 *
	 * @author guowy
	 */
    void saveAcctBookDead(PayUserBaseEntity payUserBase, PayBookEntity inBook);

    /**
	 * 名称：同步账务处理实时销账
	 *
	 * @param PAY_SN
	 * @param CONTRACT_NO
	 * @param BALANCE_ID
	 * @param WRTOFF_FLAG
	 *            :同步标识 1 缴费同步 2 冲销同步
	 * @param REGION_ID
	 * @param STATUS
	 *            : 可空，实销处理 后不同步开机 传4
	 * @param REMARK
	 * @author qiaolin
	 */
    void saveRtwroffChg(Map<String, Object> inParam);

    /**
	 * 名称：查询充值卡 ，CRM 是否打印过发票
	 *
	 * @param cardId
	 *            : 充值卡号
	 * @return boolean ： 如果打过 返回true 否则返回false
	 * @author qiaolin
	 */
    boolean isCrmCardInvPrint(String cardId);

    /**
	 * 名称：根据账户确定除该笔缴费外一段时间内该账户缴费记录条数
	 *
	 * @param PAY_LIST
	 *            : List中每个Map中存放 PAY_SN </br>
	 * @param CONTRACT_NO
	 * @param LOGIN_NO
	 *            : 可空
	 * @param INTERVAL
	 *            : 间隔时间，单位：秒
	 * @return 返回条数
	 * @author qiaolin
	 */
    int getPayCnt(Map<String, Object> inParam);

    /**
	 * 功能：获取帐户指定月份的月初余额
	 *
	 * @param contractNo
	 * @param yearMonth
	 * @param balanceTypeFlag
	 *            期初余额类型 BalanceFlagEnum
	 * @return
	 */
    long getInitialBalance(long contractNo, int yearMonth, BalanceFlagEnum balanceTypeFlag);

    /**
	 * 功能：记录转账记录表
	 */
    void saveTrasfeeInfo(PayUserBaseEntity transOutBaseInfo, PayUserBaseEntity transInBaseInfo, PayBookEntity bookIn, Map<String, Object> inMap);

    /**
	 * 功能：转账笔数查询
	 */
    long qryTransNum(Map<String, Object> inParam);

    List<FeeEntity> getInitialBalance(long contractNo, int yearMonth, BalanceFlagEnum balanceTypeFlag, BookTypeEnum balanceType);

    List<FeeEntity> getInitialBalanceGroupByPayType(long contractNo, int yearMonth, BalanceFlagEnum balanceTypeFlag, BookTypeEnum balanceType);

    /**
	 * 功能：查询集团转账记录
	 */
    List<TransFeeEntity> getJtTrasfeeInfo(String phoneNo, String queryMonth);

    /**
	 * 功能：取账户未生效预存款
	 */
    long getIneffectiveBalance(long contractNo);


    void saveBatchPayMid(Map<String, Object> inParam);

    void saveBatchPayRecd(Map<String, Object> inParam);

    /**
	 * 功能：修改账本表print_flag
	 *
	 * @param PAY_SN
	 * @param CONTRACT_NO
	 * @param SUFFIX
	 * @param PRINT_FLAG
	 * @return
	 **/
    void upAcctBookPrintFlag(Map<String, Object> inParam);

    Map<String, Object> getPayOutList(Map<String, Object> inParam);

    Map<String, Object> getSumPayFeeByPaySn(long paySn, int yearMon, long contractNo, long idNo, String payTypeStr);

    /**
	 * 名称：根据账户用户，查询发票类冲销记录
	 *
	 * @param NATURAL_MONTH
	 *            账期
	 * @param CONTRACT_NO
	 *            账户
	 * @param ID_NO
	 *            用户号
	 * @author fanck
	 */
    List<Map<String, Object>> getMinersFee(long lContractNo, long lIdNo, int iNaturalMon, int yearMon);

	/* 名称：根据账户查询发票类冲销记录
	 * 
	 * @param NATURAL_MONTH 账期
	 * 
	 * @param CONTRACT_NO 账户
	 * 
	 * @param ID_NO 用户号
	 * 
	 * @author fanck */
    List<Map<String, Object>> getMinersFee(long lContractNo, int iNaturalMon, int yearMon);

	/* 名称：修改冲销记录表中print_flag字段
	 * 
	 * @param WRTOFF_SN
	 * 
	 * @param BALANCE_ID
	 * 
	 * @param CONTRACT_NO
	 * 
	 * @param NATURAL_MONTH
	 * 
	 * @param PRINT_FLAG
	 * 
	 * @param SUFFIX
	 * 
	 * @return
	 * 
	 * @author fanck */

    void upWriteOffPrintFlag(Map<String, Object> inParam);

	/* 名称：修改冲销记录表中print_sn字段
	 * 
	 * @param WRTOFF_SN
	 * 
	 * @param BALANCE_ID
	 * 
	 * @param CONTRACT_NO
	 * 
	 * @param NATURAL_MONTH
	 * 
	 * @param PRINT_FLAG
	 * 
	 * @param SUFFIX
	 * 
	 * @return
	 * 
	 * @author fanck */
    void upWriteOffPrintSn(Map<String, Object> inParam);

	/* 名称：查询冲销记录表
	 * 
	 * @param WRTOFF_SN :冲销流水
	 * 
	 * @param BALANCE_ID :账单流水
	 * 
	 * @param ID_NO :用户ID（可空）
	 * 
	 * @return PRINT_FLAG :打印标示
	 * 
	 * @return NATURAL_MONTH :冲销账期
	 * 
	 * @author fanck */
    Map<String, Object> getWrtoffList(Map<String, Object> inParam);

	/* 名称：判断是否打印了预存发票
	 * 
	 * @param PAY_SN: 缴费流水
	 * 
	 * @param CONTRACT_NO: 账户ID
	 * 
	 * @param USER_FLAG : 用户类型，0：在网，1：离网
	 * 
	 * @param BILL_CYCLE : 账期
	 * 
	 * @param SUFFIX
	 * 
	 * @return BREAK_FLAG: 打印标志<br/> */
    String getPFlagAcctbook(Map<String, Object> inParam);

    /**
	 * 名称：修改增值税发票冲销记录表中print_flag字段
	 *
	 * @param WRTOFF_SN
	 * @param BALANCE_ID
	 * @param CONTRACT_NO
	 * @param NATURAL_MONTH
	 * @param PRINT_FLAG
	 * @param SUFFIX
	 * @return
	 * @author fanck
	 */
    void upWriteOffPrintTaxFlag(Map<String, Object> inParam);

    /**
	 * 名称：修改增值税发票冲销记录表中print_flag字段
	 *
	 * @param WRTOFF_SN
	 * @param BALANCE_ID
	 * @param CONTRACT_NO
	 * @param NATURAL_MONTH
	 * @param PRINT_FLAG
	 * @param SUFFIX
	 * @return
	 * @author fanck
	 */
    void uPrintOnePonitInvFlag(Map<String, Object> inParam);

    /**
	 * 名称: 取账本支出总费用信息
	 *
	 * @param SUFFIX
	 *            : 表年月
	 * @param PAY_SN
	 * @param ID_NO
	 *            (可选)
	 * @param BALANCE_ID
	 *            (可选)
	 * @param CONTRACT_NO
	 *            (可选)
	 * @param PAY_TYPE
	 *            (可选)
	 * @return PAY_OWE<br/>
	 *         DELAY_FEE<br/>
	 *         OTHER_FEE<br/>
	 *         REMONTH_FEE<br/>
	 */
    public BookPayoutEntity getPayOutFee(Map<String, Object> inParam);

    InvoMutiMonEntity getInvFeePrimOfWriteOff(long contractNo, long idNo, int billCycle, int yearMon);

    /**
	 * 名称：查询批量赠费总表记录
	 *
	 * @param
	 * @return
	 */
    List<BatchPayRecdEntity> getBatchpayRecd(Map<String, Object> inParam, String inFlag);

	// 更改赠费明细状态：审核、赠送
    void updateBatchPayMid(Map<String, Object> inParam);

	// 更改赠费状态：审核、赠送
    void updateBatchPayRecd(Map<String, Object> inParam);

    /**
	 * 名称： 总对总落地服务获取缴费方式、缴费渠道、缴费方式
	 *
	 * @param servName
	 *            名称
	 * @param busiCode
	 *            业务代码
	 * @param organId
	 *            机构编码
	 * @return PAY_TYPE
	 * @throws
	 */
    Map<String, Object> getPayParameter(String servName, String busiCode, String organId);

    /**
	 * 名称：记录总对总缴费记录表
	 *
	 * @param
	 * @param
	 * @return
	 * @throws
	 */
    void saveTotalPayRecd(Map<String, Object> inParam);

	/* 名称：查询存费送费账本类型
	 * 
	 * @return LIST.PAY_TYPE<br/> */
    List<Map<String, Object>> getGiftPayType();

    /**
	 * 名称：记录 bal_extfee_recd 表
	 *
	 * @param inParam
	 *            OPER_SN
	 * @param inParam
	 *            OP_TYPE
	 * @param inParam
	 *            CONTRACT_NO
	 * @param inParam
	 *            PHONE_NO
	 * @param inParam
	 *            PAY_FEE
	 * @param inParam
	 *            PAY_TYPE
	 * @param inParam
	 *            LOGIN_NO
	 * @param inParam
	 *            STATUS
	 * @param inParam
	 *            REMARK
	 * @param inParam
	 *            OP_CODE
	 * @param inParam
	 *            DELAY_RATE
	 * @param inParam
	 *            GRP_CON_NO
	 * @param inParam
	 *            FOREIGN_SN
	 * @param inParam
	 *            YEAR_MONTH
	 * @author LIXJD
	 */
    void saveExtfeeRecd(Map<String, Object> inParam);

    List<SpFeeRecycleEntity> getSpBookHis(Map<String, Object> inParam);

    /**
	 * 名称：查询营销账本类型
	 *
	 * @return List<PayTypeEntity>
	 * @author xiongjy
	 */
    List<PayTypeEntity> getPayTypeForCrm(String queryFlag);

    /**
	 * 名称：查询代理商转账信息
	 *
	 * @param agt_phone_no
	 * @param total_date
	 *            (可空)
	 * @param phoneno_in
	 *            (可空)
	 * @return List<TransFeeEntity>
	 * @author xiongjy
	 */
    List<TransFeeEntity> getAgentTrasfeeInfo(Map<String, Object> inParam);

    /**
	 * 名称：查询代理商转账总金额
	 *
	 * @param agt_phone_no
	 * @param status
	 *            (可空)
	 * @param year_month
	 * @param flag
	 * @return List<TransFeeEntity>
	 * @author xiongjy
	 */
    TransFeeEntity getSumAgentTrasfee(Map<String, Object> inParam);

    /**
	 * 名称：查询专款类型账本信息
	 *
	 * @param inParam
	 * @return
	 */
    List<BookTypeEntity> getSpPayType(Map<String, Object> inParam);

    /**
	 * 名称：查询营销返费信息
	 *
	 * @param contract_no
	 * @param id_no
	 *            (可空)
	 * @return List<ReturnFeeEntity>
	 * @author xiongjy
	 */
    List<ReturnFeeEntity> getReturnfeeInfo(Long contractNo, Long idNo);

    /**
	 * 名称：查询TD统付缴费信息
	 *
	 * @param contract_no
	 * @param yearMonth
	 * @return List<TdUnifyPayEntity>
	 * @author xiongjy
	 */
    List<TdUnifyPayEntity> getTdTrasfeeInfo(Long contractNo, String yearMonth);

    /**
	 * 名称：查询账户预存
	 *
	 * @param inMap
	 * @return long
	 * @author jiassa
	 */
    long getAcctBookSumByMap(Map<String, Object> inMap);
	
	
	/**
	 * 名称：查询账本预存之和,不涉及出账
	 *
	 * @param inMap
	 * @return long
	 * @author liuyc_billing
	 */
	public long getAcctSumCurBalance(Map<String, Object> inMap);

    /**
	 * 名称：根据缴费流水，获取当前账本冲销的话费和滞纳金金额
	 *
	 * @param inMap
	 * @return
	 * @author liuhl_bj
	 */
    Map<String, Object> getWriteFeeByPaySn(Map<String, Object> inMap);

    /**
	 * 名称：取拆包标志
	 *
	 * @param idNo
	 * @param yearMonth
	 * @return
	 * @author xiongjy
	 */
    String getDisassembleFlag(Long idNo, Integer yearMonth);

    /**
	 * 总对总缴费，该笔 统一支付流水 是否属于重复缴费 是 返回 true 否 返回 false
	 */
    boolean isZdzRepetitionPay(String yearMonth, String transactionId);

    /**
	 * 总对总交易结果查询
	 *
	 * @param SETTLEDATE
	 *            交易账期
	 * @param TRANSACTIONID
	 *            操作流水号
	 * @return BACK_FLAG 冲正标识 0:未冲正 1:冲正
	 */
    Map<String, Object> qTotalPayByTranId(Map<String, Object> inParam);

    /**
	 * 名称：回退总对总缴费记录： update、插入负记录
	 *
	 * @param
	 * @return
	 * @author qiaolin
	 */
    void doRollBackTotalPayRecd(Map<String, Object> inPayMap);

    /**
	 * 名称：查询账本明细信息
	 *
	 * @param CONTRACT_NO
	 * @param VALID_FLAG
	 *            可空 validFlag = 1表示有效期查询 资金有效期查询不包括 专款
	 * @return
	 * @author qiaolin
	 */
    List<Map<String, Object>> getAcctBookInfo(Map<String, Object> inParam);

    /**
	 * 名称：取账户条件未返还话费信息
	 *
	 * @param CONTRACT_NO
	 *            非空
	 * @param PAY_SN
	 *            可空
	 * @return PAY_TYPE<br/>
	 *         CUR_BALANCE<br/>
	 *         PAY_TYPE_NAME<br/>
	 *         BEGIN_TIME<br/>
	 *         END_TIME<br/>
	 *         PAY_TIME<br/>
	 *         PAY_ATTR<br/>
	 * @author
	 */
    List<Map<String, Object>> getRetAcctBookForRestPay(Map<String, Object> inParam);

    /**
	 * 功能：查询营销活动赠费的有效的账本类型
	 *
	 * @param contractNo
	 * @param foreignSn
	 * @param valid
	 * @return
	 * @author liuhl
	 */
    List<ReturnFeeEntity> getReturnFeeInfo(long contractNo, String foreignSn, String valid);


    /**
	 * 名称：根据转账流水和转账时间取出转账记录信息
	 *
	 * @param transSn
	 * @param payYm
	 * @return
	 */
    boolean isTransInfoByTransSn(long transSn, String payYm);

    /**
	 * 名称：更新冲正时转账记录的状态
	 *
	 * @param transSn
	 */
    void updateStatusByTransSn(long transSn,String payYm);

    /**
	 * 名称：TD冲正
	 *
	 * @param PAY_YM
	 * @param PAY_SN
	 * @param BACK_SN
	 * @param LOGIN_NO
	 * @param OP_CODE
	 * @author SUZJ
	 */
    void insertRollBackTransInfo(Map<String, Object> inParam);

    /**
	 * 名称：查询不满足条件未返话费
	 *
	 * @param lContractNo
	 *            账户号码
	 * @param sForeignSn
	 *            外部流水
	 * @return RESTPAY_LIST.PAY_TYPE<br/>
	 *         RESTPAY_LIST.CUR_BALANCE<br/>
	 *         RESTPAY_LIST.PAY_TYPE_NAME<br/>
	 *         RESTPAY_LIST.BEGIN_TIME<br/>
	 *         RESTPAY_LIST.END_TIME<br/>
	 *         RESTPAY_LIST.PAY_TIME<br/>
	 *         RESTPAY_LIST.PAY_ATTR<br/>
	 *         RESTPAY_LIST.FEE_TYPE<br/>
	 *         PREPAY_FEE 总预存<br/>
	 *         ORD_PREPAY 普通预存<br/>
	 *         PRE_PREPAY 赠费预存<br/>
	 * @throws
	 */
    Map<String, Object> getUnRestPay(long lContractNo, String sForeignSn);

    /**
	 * 名称：查询已返话费
	 *
	 * @param lContractNo
	 *            账户号码
	 * @param sForeignSn
	 *            外部流水
	 * @param sForeignTime
	 *            活动办理时间
	 * @return BATCHPAY_LIST.PAY_TYPE<br/>
	 *         BATCHPAY_LIST.PAY_FEE<br/>
	 *         BATCHPAY_LIST.PAY_TYPE_NAME<br/>
	 *         BATCHPAY_LIST.BEGIN_TIME<br/>
	 *         BATCHPAY_LIST.END_TIME<br/>
	 *         BATCHPAY_LIST.OP_TIME<br/>
	 *         BATCHPAY_LIST.PAY_ATTR<br/>
	 *         BATCHPAY_LIST.FEE_TYPE<br/>
	 *         VALIDED_PAY 总已返费金额<br/>
	 *         ORD_VALIDED 普通预存已返费金额<br/>
	 *         PRE_VALIDED 赠费预存已返费金额<br/>
	 * @throws
	 */
    Map<String, Object> getBatchPayInfo(long lContractNo, String sForeignSn, String sForeignTime);

    /**
	 * 名称：查询未返话费
	 *
	 * @param lContractNo
	 *            账户号码
	 * @param sForeignSn
	 *            外部流水
	 * @return RESTPAY_LIST.PAY_TYPE<br/>
	 *         RESTPAY_LIST.CUR_BALANCE<br/>
	 *         RESTPAY_LIST.PAY_TYPE_NAME<br/>
	 *         RESTPAY_LIST.BEGIN_TIME<br/>
	 *         RESTPAY_LIST.END_TIME<br/>
	 *         RESTPAY_LIST.PAY_TIME<br/>
	 *         RESTPAY_LIST.PAY_ATTR<br/>
	 *         RESTPAY_LIST.FEE_TYPE<br/>
	 *         PREPAY_FEE 总预存<br/>
	 *         ORD_PREPAY 普通预存<br/>
	 *         PRE_PREPAY 赠费预存<br/>
	 * @throws
	 */
    Map<String, Object> getNoUnRestPay(long lContractNo, String sForeignSn);

    /**
	 * 名称：查询本月支付账户是否向被支付账户做划拨
	 *
	 * @param contractOut
	 * @param contractIn
	 * @return isPayOrNot
	 * @author suzj
	 */
    boolean deleteHavePayCon(long contractOut, long contractIn);

    /**
	 * 名称：插入空中充值代理商网厅缴费限制表
	 */
    void saveAgentCheck(Map<String, Object> inParam);

    /**
	 * 名称：是否允许空中充值代理商账户网厅缴费
	 */
    boolean isAgentCheck(String phoneNo, long contractNo);

    /**
	 * 名称：判断账本类型是否存在
	 *
	 * @author qiaolin
	 */
    boolean isPayTypeExist(String payType);

    /**
	 * 名称：入融合充值,充值卡充值请求记录表
	 *
	 * @author qiaolin
	 */
    void iCardPayrequestInfo(Map<String, Object> inParam);

    /**
	 * 名称：记录转账失败记录表
	 *
	 * @param transOutBaseInfo
	 * @param transInBaseInfo
	 * @param bookIn
	 * @param inMap
	 * @author suzj
	 */
    void saveTransFeeErrInfo(PayUserBaseEntity transOutBaseInfo, PayUserBaseEntity transInBaseInfo, PayBookEntity bookIn, Map<String, Object> inMap);

    List<Map<String, Object>> getBatchPayMid(Map<String, Object> inParam);

    /**
	 * 名称：记录按月返费接口表bal_monthreturnfee_info
	 *
	 * @author qiaolin
	 */
    void iMonthReturnFeeInfo(Map<String, Object> inParam);

    /**
	 * 名称：记录 bal_batchpay_info
	 *
	 * @param ACT_ID
	 * @param PHONE_NO
	 * @param ID_NO
	 * @param REGION_CODE
	 * @param CONTRACT_NO
	 * @param TOTAL_DATE
	 * @param PAY_TYPE
	 * @param PAY_FEE
	 * @param PAY_SN
	 * @param LOGIN_NO
	 * @param BEGIN_TIME
	 * @param END_TIME
	 * @param FOREIGN_SN
	 * @author qiaolin
	 */
    boolean saveBatchpay(Map<String, Object> inParam);

    /**
	 * 名称：记录 bal_returnacctbook_info
	 *
	 * @param BALANCE_ID
	 * @param CONTRACT_NO
	 * @param PAY_TYPE
	 * @param INIT_BALANCE
	 * @param CUR_BALANCE
	 * @param BALANCE_TYPE
	 * @param BEGIN_TIME
	 * @param END_TIME
	 * @param PAY_SN
	 * @param STATUS
	 * @param BILL_CYCLE
	 * @param PRINT_FLAG
	 * @param FOREIGN_SN
	 * @param FOREIGN_TIME
	 * @param PUB_CON
	 * @author qiaolin
	 */
    boolean saveReturnAcctbook(Map<String, Object> inParam);

    /**
	 * 名称：判断账本类型是否存在
	 *
	 * @author hanfl
	 */
    boolean isPayTypeExist(long contractNo);

    /**
	 * 名称：过户工单相关
	 *
	 * @return
	 */
    int updateAcctBookEndTime(long contractNo);

    /**
	 * 名称：更新账本结束时间
	 *
	 * @return
	 */
    int upAcctboookEndTime(long contractNo, long balanceId, String endTime);

    /**
	 * 一点支付更新冲销表中的记录
	 *
	 * @param paySn
	 * @param contractNo
	 * @param yearMonth
	 * @param beginYm
	 * @param endYm
	 */
	void updateFlagForOnePay(long paySn, long printSn, long contractNo, int yearMonth, int beginYm, int endYm);

    /**
	 * 取操作员转账红包费用
	 */
    long getTransFeeByUnitId(String unitId, String contactPhone);

    /**
	 * 转账红包限额规则
	 */
    List<TransLimitEntity> getTransLimit(Map<String, Object> inParam);

    /**
	 * 获取帐户的帐本来源信息。
	 *
	 * @param args
	 *            <ul>
	 *            <li>BEGIN_TIME <i>STRING</i> 账期开始时间，格式YYYYMMDD HH24:MI:SS (可选)</li>
	 *            <li>END_TIME <i>STRING</i> 账期结束时间，格式YYYYMMDD HH24:MI:SS (可选)</li>
	 *            <li>CONTRACT_NO <i>LONG</i> 账户标识</li>
	 *            <li>ID_NO <i>LONG</i> 用户标识 (可选)</li>
	 *            <li>YEAR_MONTH <i>STRING</i> 帐务年月 (可选)</li>
	 *            </ul>
	 * @return
	 */
    List<BookSourceEntity> getBookSourceList(Map<String, Object> args);
    
    /**
	 * 名称：获取话费红包集团管理员数量
	 * 
	 * @param inParam
	 * @return
	 */
    long getTransFeeLimitNum(Map<String, Object> inParam);
    
    /**
	 * 名称：更新话费红包集团管理员限额
	 * 
	 * @param inParam
	 */
    void upTransFeeLimit(Map<String,Object> inParam);

	/**
	 * 名称：按照账本类型获取金额
	 * 
	 * @author liuhl_bj
	 * @param contractNo
	 * @return
	 */
	List<Map<String, Object>> getBookPrePayByPayType(long contractNo);
	
	/**
	 * 名称：根据缴费流水和账户获取该笔缴费入账冲销账单和滞纳金总额
	 * 
	 */
	long getSumPayoutFee(long paySn, long contractNo, long yearMonth);
	
	/**
	 * 名称：根据缴费流水和账户获取该笔缴费预存款总额
	 * 
	 */
	long getSumCurbookFee(long paySn, long contractNo, long yearMonth);
	
	/**
	 * 名称：获取可用预存(可用专款预存,可用普通预存,可用总预存)
	 * 
	 * @author xiongjy
	 * @param contractNo
	 * @return
	 */
	public PrepayEntity getValidSum(long contractNo);
	
	/**
	 * 名称：获取预存(失效预存,将要生效预存,生效预存,总预存)
	 * 
	 * @author xiongjy
	 * @param contractNo
	 * @return
	 */
	public PrepayEntity getAllPrepay(long contractNo);
	
	/**
	 * 名称:查询智能终端CRM缴费信息
	 * 
	 * @author suzj
	 * @param
	 * @return
	 */
	List<Map<String,Object>> getIntellInfo(String payTypes,String notOpCode,String loginNo,int changeYM,int changeDate,long paySn);
	
	/**
	 * 名称：将CRM缴费信息插入临时表
	 * 
	 * @author suzj
	 */
	void insertIntellInfo(List<Map<String,Object>> list);
	
	/**
	 * 名称：将CRM缴费信息做总计
	 * 
	 * @author suzj
	 */
	void insertTotalIntellInfo(long loginAccept);
	
	/**
	 * 名称：获取CRM缴费汇总信息
	 */
	List<CRMIntellPrtEntity> queryIntellInfo(long loginAccept);
	
	/**
	 * 名称：将CRM缴费明细信息做汇总插入临时表
	 * 
	 * @author suzj
	 */
	void insertCollectIntellInfo(Map<String,Object> inMap);
	
	/**
	 * 名称：获取总对总缴费渠道
	 * 
	 * @author xiongjy
	 */
	public String getTotalPayPath(long yearMonth,String transId);

	/**
	 * 名称：根据balanceId查询账本的当前余额和初始余额
	 * 
	 * @author liuhl_bj
	 * @param balanceId
	 * @return
	 */
	Map<String, Object> getAccountInfo(long balanceId);
	
	/**
	 * 名称：增加、修改、删除话费话费加油包配置表
	 * 
	 * @author xiongjy
	 */
	public void oprTransLimit(Map<String, Object> inParam);
	
	/**
	 * 名称：判断用户当前是否已办理了某款营销案
	 * 
	 * @author xiongjy
	 */
	public int getCntByPayType(long contractNo,String payType);
	
	/**
	 * 名称：查询手工系统充值导入详细记录
	 * 
	 * @author hanfl
	 */
	public MonthReturnFeeEntity getMonthReturnFeeDeail(Map<String, Object> inParam);
	
	/**
	 * 名称：入包年取消记录表BAL_YEARCANCEL_INFO
	 * 
	 * @param contractNo
	 * @param ID_NO
	 * @param PHONE_NO
	 * @param CONTRACT_NO
	 * @param PAY_TYPE
	 * @param PENAL_SUM_FLAG
	 *            收取违约金标识 N：不收取 Y：收取
	 * @param TOTAL_DATE
	 * @param LOGIN_ACCEPT
	 * @param ORI_FOREIGN_SN
	 * @param FOREIGN_SN
	 * @param REMARK
	 * @param BACK_YM
	 * @author qiaolin
	 */
	public void inYearCalcle(Map<String, Object> inParam, LoginBaseEntity loginBase);

	/**
	 * 查询是否有违约金
	 * 
	 * @author liuhl_bj
	 * 
	 * @param idNo
	 * @param contractNo
	 * @param payType
	 * @return
	 */
	int hasDedit(long idNo, long contractNo, String payType);
	
}