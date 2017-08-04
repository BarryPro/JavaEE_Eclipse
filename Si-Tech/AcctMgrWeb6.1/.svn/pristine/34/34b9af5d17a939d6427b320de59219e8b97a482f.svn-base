package com.sitech.acctmgr.atom.busi.pay.inter;

import com.sitech.acctmgr.atom.domains.base.LoginBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.DistrictLimitEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.RegionLimitEntity;
import com.sitech.jcf.core.exception.BusiException; 

import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface IPayManage {
	
	/**
	* 名称：
	* @param paysn必须从外部传入
	*/
	public abstract void saveInBook(Map<String, Object> header, PayUserBaseEntity payUserBase, PayBookEntity inBook);
	

	/**
	 * 名称：在网用户退预存款
	 * @param LOGIN_NO 工号
	 * @param GROUP_ID 归属
	 * @param CONTRACT_NO 账户
	 * @param NOT_PAY_TYPE 排除账本5
	 * @param PAY_ATTR2  可退预存属性
	 * @param ID_NO 用户标识
	 * @param YEAT_MONTH  当前年月
	 * @param	MKT_TYPE	: 营销退款类标识： 1 --活动退订补扣个人账务上预存款  2 -- 活动退订 退公共账户上流水对应的预存款
	 * 
	 * @return PAY_ACCEPT 流水
	 * @throws Exception
	 * @author LIJXD
	 */
	public abstract Map<String, Object> doBackMoney(PayUserBaseEntity userBaseInfo,PayBookEntity bookIn);
	
	/**
	 * 名称：离网用户退预存款
	 * @param LOGIN_NO 工号
	 * @param GROUP_ID 归属
	 * @param CONTRACT_NO 账户
	 * @param NOT_PAY_TYPE 排除账本5
	 * @param PAY_ATTR2  可退预存属性
	 * @param ID_NO 用户标识
	 * @param YEAT_MONTH  当前年月
	 * 
	 * @return PAY_ACCEPT 流水
	 * @throws Exception
	 * @author LIJXD
	 */
	public abstract Map<String, Object> doBackMoneyDead(PayUserBaseEntity userBaseInfo,PayBookEntity bookIn);
	
	
	/**
	 * 名称：专款未失效账本转账<br/>
	 * 功能：实现账户专款转账功能<br/>
	 * 1、转出账户金额转出<br/>
	 * 2、转入账户金额转入<br/>
	 * 
	 * @param Header 头字段Map信息
	 * @param BOOK_IN 入账信息实体(PayBookEntity)
	 * @param TRANS_IN 转入账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_OUT 转出账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_TYPE_OBJ  转账类型实例化对象(不同的转账类型，传入对应的实例化对象(实现接口ITransType的对象));该字段可空,如果传null,默认为在网账户转账
	 * @param OP_TYPE 转账类型
	 * @param FOREIGN_SN 外部流水
	 * @param List<Map<String, Object>> transOutBookList 转出账本列表
	 * 
	 * @return long类型转账流水
	 * @throws Exception
	 * @author liuyc_billing
	 */
	public abstract long transBalanceSpecial(Map<String, Object> inParam,List<Map<String, Object>> transOutBookList);
		
	/**
	 * 名称：账户转账
	 * 功能：实现账户转账功能
	 * 1、转出账户金额转出
	 * 2、转入账户金额转入
	 * 
	 * @param Header 头字段Map信息
	 * @param BOOK_IN 入账信息实体(PayBookEntity)
	 * @param TRANS_IN 转入账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_OUT 转出账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_TYPE_OBJ  转账类型实例化对象(不同的转账类型，传入对应的实例化对象(实现接口ITransType的对象));该字段可空,如果传null,默认为在网账户转账
	 * @param OP_TYPE 转账类型
	 * 
	 * @return long类型转账流水
	 * @throws Exception
	 * @author guowy
	 */
	public abstract long transBalance(Map<String, Object> inParam);
	
	/**
	 * 名称：账户转账
	 * 功能：实现账户转账功能, 支持传入转入账本
	 * 1、转出账户金额转出
	 * 2、转入账户金额转入
	 * 
	 * @param Header 头字段Map信息
	 * @param BOOK_IN 入账信息实体(PayBookEntity)
	 * @param TRANS_IN 转入账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_OUT 转出账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_TYPE_OBJ  转账类型实例化对象(不同的转账类型，传入对应的实例化对象(实现接口ITransType的对象));该字段可空,如果传null,默认为在网账户转账
	 * @param OP_TYPE 转账类型
	 * 
	 * @return long类型转账流水
	 * @throws Exception
	 * @author guowy
	 */
	public abstract long transBalance(Map<String, Object> inParam, String inPaytype);
	
	
	/**
	 * 名称：账户转账
	 * 功能：实现账户转账功能, 支持传入转入账本 转出账本
	 * 1、转出账户金额转出
	 * 2、转入账户金额转入
	 * 
	 * @param Header 头字段Map信息
	 * @param BOOK_IN 入账信息实体(PayBookEntity)
	 * @param TRANS_IN 转入账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_OUT 转出账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_TYPE_OBJ  转账类型实例化对象(不同的转账类型，传入对应的实例化对象(实现接口ITransType的对象));该字段可空,如果传null,默认为在网账户转账
	 * @param OP_TYPE 转账类型
	 * 
	 * @return long类型转账流水
	 */
	public abstract long transBalance(Map<String, Object> inParam, String inPaytype, String outPayType);
	
	
	/**
	 * 名称：专款分月转账：实现家庭业务等多条账本专款转账<br/>
	 * 功能：实现账户专款分月转账，分月具体由转账总金额除以分拨月份数决定<br/>
	 * 1、转出账户金额转出<br/>
	 * 2、转入账户金额按月转入<br/>
	 * 
	 * @param Header 头字段Map信息
	 * @param BOOK_IN 入账信息实体(PayBookEntity)
	 * @param TRANS_IN 转入账户基本信息实体(PayUserBaseEntity)
	 * @param TRANS_OUT 转出账户基本信息实体(PayUserBaseEntity)
	 * @param EFFECT_MONTH 分拨月份数
	 * @param BEGIN_DATE 开始时间
	 * @param TRANS_TYPE_OBJ  转账类型实例化对象(不同的转账类型，传入对应的实例化对象(实现接口ITransType的对象));该字段可空,如果传null,默认为在网账户转账
	 * @param OP_TYPE 转账业务类型
	 * @param IN_PAY_TYPE 转入账本类型
	 * 
	 * @return long类型转账流水
	 * @throws Exception
	 * @author liuyc_billing
	 */
	public abstract long specialTrans(Map<String, Object> inParam);
	
	/**
	 * 名称：校验专款转账
	 * 功能：实现账户专款转账的回退的校验工作
	 *
	 * 
	 * @return long类型转账流水
	 * @throws Exception
	 * @author liuyc_billing
	 */
	public abstract long specialTransRollCheck(Map<String, Object> inParam);
	
	/**
	 * 名称：专款转账：主要实现家庭业务等多条账本专款转账
	 * 功能：实现账户专款转账的回退操作
	 * 
	 * @return long类型转账流水
	 * @throws Exception
	 * @author liuyc_billing
	 */
	public abstract long specialTransRollBack(Map<String, Object> inParam);

	/**
	 * 名称：账户转账,包括:转账 转入用户冲销 记录营业员操作日志
	 * @author jiassa
	 */
	public long trans(Map<String, Object> inParam);

	public abstract List<Map<String, Object>> transOut(Map<String, Object> header, PayUserBaseEntity transOutBaseInfo,
			PayBookEntity bookIn, ITransType transType, String inPayType);
	
	
	/**
	 * 名称：交费冲正验证
	 * @param	PAY_SN
	 * @param	LOGIN_NO
	 * @param	YEAR_MONTH		: 缴费年月
	 */
	public abstract void doRollbackCheck(long paySn, String loginNo, int yearMonth, Long contractNo, Map<String, Object> header);
	
	/**
	 * 名称：陈死账回收回退
	 * 功能：回退账单表、冲销表、支出表
	 * 
	 * @param CONTRACT_NO
	 *
	 * @return
	 * @throws BusiException
	 * @author guowy
	 */
	public Map<String, Object> doDeadRollback(Map<String, Object> inParam);
	
	/**
	 * 名称：根据缴费流水取缴费总支出金额、缴费用户数等信息
	 * @param	PAY_SN
	 * @param	SUFFIX			: 年月
	
	 * @return ALL_PAY			: 本次缴费到账金额<br/>
	 * 		  ID_NUMBER			: 本次缴费到账或者发生支出的用户总数
	 * 		  OUT_FEEMSG.PHONE_NO : 入账或者又支出号码
	 * 		  OUT_FEEMSG.PAY_MONEY
	 * 		  OUT_FEEMSG.PREPAY_FEE  : 本次缴费冲销后剩余预存款
	 * 	      OUT_FEEMSG.PAYED_OWE
	 *        OUT_FEEMSG.DELAY_FEE
	 * @author qiaolin
	 */
	public abstract Map<String, Object> getPayOutMsg(long paySn, int yearMonth);

	/**
	 * 名称：缴费冲正回退现金费用<br/>
	 * 回退销账记录、回退账单、回退来源表、回退支出表、回退账本余额、回退开关机、
	 * 隔月或隔笔冲正入异步表做冲销开机、给实时销账、在线计费同步小表<br/>
	 * @param	paySn	       ：要冲正的缴费流水
	 * @param	backPaySn  :冲正流水(可空)
	 * @param	payDate	：要冲正的缴费年月日
	 * @param	loginEntity
	 * 
	 * @return 冲正流水
	 * @author qiaolin
	 */
	public abstract long doRollbackCashFee(long paySn, Long backPaySn, String payDate, LoginBaseEntity loginEntity);
	
	/**
	 * 名称：回退缴费资金受理(缴费、空充、退费)日志记录<br/>
	 * 功能：回退payment表、营业员操作日志记录、发送营业日报等<br/>
	 * @param	Header
	 * @param	PAY_SN		：要冲正的缴费流水
	 * @param	PAY_YM		：要冲正的缴费年月
	 * @param	PAY_DATE	：要冲正的缴费年月日
	 * @param	BACK_PAYSN	: 冲正流水
	 * @param	LOGIN_NO
	 * @param	GROUP_ID	: 工号group_id
	 * @param	OP_CODE
	 * @param	PAY_OPCODE	: 缴费业务的OP_CODE
	 * @param	OP_NOTE
	 * @param	PAY_PATH
	 * @param	PAY_METHOD
	 * @return  SUM_BACKFEE
	 * @author qiaolin
	 */
	public abstract Map<String, Object> doRollbackRecord(Map<String, Object> inParam);
	
	/**
	 * 名称：缴费冲正营销分月返还费用<br/>
	 * 回退来源表、回退账本余额、回退分月返还、回退bathpay表、回退缴费记录表、给实时销账同步小表<br/>
	 * @param	paySn	       ：要冲正的缴费流水
	 * @param	backPaySn  :冲正流水
	 * @param	payDate	：要冲正的缴费年月日
	 * @param	loginEntity
	 * 
	 * @return 冲正流水
	 * @author qiaolin
	 */
	long dRollbackForMr(long paySn, Long backPaysn, String foreignSn, String payDate, LoginBaseEntity loginEntity);
	
	
	/**
	 * 名称：获取要冲正的缴费流水（不同流水）
	 * @param foreignSn
	 * @param payYm
	 * @return List PAY_SN
	 * @return List OP_CODE
	 * @author qiaolin
	 */
	public abstract List<Map<String, Object>> getPaySnByForeign(String foreignSn, String payYm);
	
	public abstract List<Map<String, Object>> getPaySnByForeign(String foreignSn, String payYm, String payType);
	
	/**
	 * 名称：获取离网用户费用支出信息
	 * @param paySn
	 * @param yearMonth
	 * @param inIdNo
	 * 
	 * @return PHONE_NO
	 * @return PAY_MONEY
     * @return PREPAY_FEE
	 * @return PAYED_OWE
	 * @return DELAY_FEE
	 * @return ALL_PAY
	 * @author guowy
	 */
	public Map<String, Object> getDeadPayOutMsg(long paySn, int yearMonth, long inIdNo);

	/**
	 * 名称：转账记录冲正
	 * @param PAY_YM : 要冲正的缴费记录年月
	 * @param PAY_SN : 要冲正的缴费流水
	 * @param BACK_SN : 冲正流水
	 * @param OP_CODE 
	 * @param LOGIN_NO
	 * @param OP_NOTE
	 * @param OP_TIME
	 * @author 
	 */
	public void doRollbackTransfee(Map<String,Object> inParam);
	
	/**
	 * 
	* 名称：提交事务
	* @param 
	* @return 
	* @throws
	 */
	public abstract void commit();
	
	/**
	 * 
	* 名称：回滚事务
	* @param 
	* @return 
	* @throws
	 */
	public abstract void rollback();
	
	/**
	 * 
	 * 名称：政企客户信息入缴费扩展表
	 */
	public void insertZQInfo(Map<String,Object> inMap);
	
	/**
	 * 名称：更新包年专款账本结束日期
	 * @param ForeignSn：老系统移植数据该字段传空
	 * @param beginDate：表示办理时间
	 * @param inParam中 LOGIN_NO, OP_CODE, LOGIN_ACCEPT
	 * 
	 * @author qiaolin
	 */
	public void upAcctbookEndTime(long contractNo, String foreignSn, String payType, String beginDate, String endTime,
			Map<String, Object> inParam);
	
}
	