package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.BatchpayInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.SignPayEntity;
import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.bill.DetailEnterEntity;
import com.sitech.acctmgr.atom.domains.detail.DetailQryRecord;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.atom.domains.pay.GroupChargeEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.PosPayEntity;
import com.sitech.acctmgr.atom.domains.query.BatchPayErrEntity;
import com.sitech.acctmgr.atom.domains.query.GrpRedEntity;
import com.sitech.acctmgr.atom.domains.query.PayCardEntity;
import com.sitech.acctmgr.atom.domains.record.ActCollBillRecdEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.record.UserChgRecdEntity;
import com.sitech.acctmgr.atom.domains.user.UserOweEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;

/**
 * <p>
 * Title: 记录类
 * </p>
 * <p>
 * Description: 存放营业员操作记录、缴费记录等
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author zhangjp
 * @version 1.0
 */
public interface IRecord {

	// void saveLoginOpr(Map<String, Object> inParam);
	void saveLoginOpr(LoginOprEntity loginOpr);

	/**
	 * 功能：记录操作日志表
	 *
	 * @param aqoeEntity
	 * @param isTouchAuth
	 */
	void saveQueryOpr(ActQueryOprEntity aqoeEntity, boolean isTouchAuth);

	void savePayMent(PayUserBaseEntity payUserBase, PayBookEntity inBook);

	/**
	 * 名称：记录外部缴费控制表bal_paycard_recd
	 *
	 * @param CARD_SN
	 *            :外部流水
	 * @param PAY_LIST
	 *            .PAY_TYPE : 账本类型
	 * @param PAY_LIST
	 *            .PAY_SN
	 * @param TOTAL_DATE
	 * @param LOGIN_NO
	 *            : 缴费工号
	 * @return 无 @
	 * @author qiaolin
	 */
	void savePayCard(Map<String, Object> inParam);

	/**
	 * 名称：POS机缴费信息记录
	 *
	 * @param inParam
	 */
	void savePosPayInfo(PosPayEntity posPayEntity, PayUserBaseEntity payUserBase, PayBookEntity inBook);

	/**
	 * 名称:查询缴费记录表信息
	 *
	 * @param SUFFIX
	 *            : 查询表年月
	 * @param ID_NO
	 *            : 用户号码（可选）
	 * @param CONTRACT_NO
	 *            : 账户号码（可选）
	 * @param PAY_SN
	 *            : 缴费流水（可选）
	 * @param STATUS
	 *            ：状态（可选）
	 * @param BEGIN_DATE
	 *            : 开始年月（可选）
	 * @param END_DATE
	 *            : 结束年月（可选）
	 * @param OP_CODE
	 *            : 模块代码（可选） 传入时加括号和单引号 例如：('8000')或('8000','8104','8107')
	 * @param BEGIN_TIME
	 *            : 开始时间（可选）
	 * @param END_TIME
	 *            : 结束时间（可选）
	 * @param DESC
	 *            : 倒序排列（可选）
	 * @return CNT:返回条数<br/>
	 *         PAYMENT_LIST.PAY_SN<br/>
	 *         PAYMENT_LIST.CONTRACT_NO<br/>
	 *         PAYMENT_LIST.ID_NO<br/>
	 *         PAYMENT_LIST.BRAND_ID<br/>
	 *         PAYMENT_LIST.TOTAL_DATE<br/>
	 *         PAYMENT_LIST.PAY_PATH<br/>
	 *         PAYMENT_LIST.PAY_METHOD<br/>
	 *         PAYMENT_LIST.PAY_TYPE<br/>
	 *         PAYMENT_LIST.PAY_FEE<br/>
	 *         PAYMENT_LIST.CURRENT_PREPAY<br/>
	 *         PAYMENT_LIST.PAY_TIME<br/>
	 *         PAYMENT_LIST.STATUS<br/>
	 *         PAYMENT_LIST.BANK_CODE<br/>
	 *         PAYMENT_LIST.ORIGINAL_SN<br/>
	 *         PAYMENT_LIST.FOREIGN_SN<br/>
	 *         PAYMENT_LIST.FOREIGN_TIME<br/>
	 *         PAYMENT_LIST.GROUP_ID<br/>
	 *         PAYMENT_LIST.LOGIN_NO<br/>
	 *         PAYMENT_LIST.OP_CODE<br/>
	 *         PAYMENT_LIST.OP_TIME<br/>
	 *         PAYMENT_LIST.REMARK<br/>
	 *         PAYMENT_LIST.PHONE_NO<br/>
	 *         PAYMENT_LIST.USER_GROUP_ID<br/>
	 *         @
	 */
	List<PayMentEntity> getPayMentList(Map<String, Object> inParam);

	/**
	 * 名称：记录托收缴费日志记录
	 *
	 * @param ActCollBillRecdEntity
	 */
	public void saveCollbillRecd(ActCollBillRecdEntity in);

	/**
	 * 名称：安保部详单查询录入
	 *
	 * @param dee
	 *            DetailEnterEntity
	 */
	void saveDetailEnter(DetailEnterEntity dee);

	/**
	 * 功能：安保详单录入用户信息查询
	 *
	 * @param idNo
	 * @return
	 */
	DetailEnterEntity getDetailEnterInfo(Long idNo);

	/**
	 * 功能：更新安保详单录入记录的状态信息
	 * 
	 * @param idNo
	 */
	void updateDetailEnterInfo(Long idNo);
	
	/**
	 * 功能：安保详单查询记录查询
	 * 
	 * @param inParam
	 */
	Map<String, Object> getDetailRecordMap(Map<String, Object> inParam, int pageNum);
	
	/**
	 * 名称：验证虚拟集团是否存在
	 *y
	 */
	public long cntVirtualGrp(long unitId);

	/**
	 * 名称：虚拟集团添加
	 *
	 * @param vge
	 *            VirtualGrpEntity
	 */
	void saveVirtualGrp(VirtualGrpEntity vge);

	/**
	 * 名称：虚拟集团删除
	 */
	void delVirtualGrp(String unitId, long loginAccept);

	/**
	 * 名称：虚拟集团成员添加
	 */
	void saveVirtualDetail(VirtualGrpEntity vge);

	/**
	 * 名称：虚拟集团成员删除
	 */
	void delVirtualDetail(String unitId, String phoneNo, long contractNo, long loginAccept);

	public Map<String, Object> getPayMentListByCust(Map<String, Object> inParam);

	/**
	 * 名称:获取外部渠道缴费信息
	 *
	 * @param cardSn
	 *            :外部缴费流水 可空
	 * @param paySn
	 *            :缴费流水 可空
	 * @param loginNo
	 *            :操作工号 可空
	 * @return List<PayCardEntity>
	 */
	List<PayCardEntity> getPayCardList(String cardSn, Long paySn, String loginNo);

	/**
	 * 名称：集团自由划拨导入
	 *
	 * @param GroupChargeEntity
	 */
	public void saveGroupChargeRecd(Map<String, Object> inParam);

	/**
	 * 名称：查询参与集团自由划拨的号码
	 *
	 * @param grpCon
	 */
	List<GroupChargeEntity> getGroupChargeRecdList(long grpCon);

	/**
	 * 名称：删除集团自由划拨记录
	 *
	 * @param grpCon
	 */
	public int delGroupChargeRecdByGrp(long grpCon);

	/**
	 * 名称：集团自由划拨成功,导入his表，删除record表
	 *
	 * @param phoneNo
	 * @param oldAccept
	 */
	public void saveGroupChargeHis(Map<String, Object> inParam);

	/**
	 * 名称：集团自由划拨失败,导入err表，删除record表
	 *
	 * @param phoneNo
	 * @param oldAccept
	 */
	public void saveGroupChargeErr(Map<String, Object> inParam);

	/**
	 * 名称：查询集团自由划拨成功的号码
	 *
	 * @param grpCon
	 * @param beginTime
	 *            yyyymmdd
	 * @param endTime
	 *            yyyymmdd
	 */
	List<GroupChargeEntity> getGroupChargeHisList(long grpCon, String beginTime, String endTime);

	/**
	 * 名称：查询集团自由划拨失败的号码
	 *
	 * @param grpCon
	 * @param beginTime
	 *            yyyymmdd
	 * @param endTime
	 *            yyyymmdd
	 */
	List<GroupChargeEntity> getGroupChargeErrList(long grpCon, String beginTime, String endTime);

	/**
	 * 名称：查询月转账累计金额
	 *
	 * @return List<PayTypeEntity>
	 * @author suzj
	 */
	long getMonthTransFee(long contractNo);

	/**
	 * 名称：节假日免停信息记录
	 *
	 * @author xiongjy
	 */
	public void saveHolidayUnStop(String phoneNo, Long idNo, String groupId, String regionCode,String creditClass);

	/**
	 * 名称：查询系统充值失败记录
	 *
	 * @param phone_no
	 * @param beginTime
	 *            yyyymm
	 * @param endTime
	 *            yyyymm
	 * @param region_code
	 */
	public List<BatchPayErrEntity> getBatchPayErr(Map<String, Object> inParam);

	/**
	 * 名称：根据trans_sn查询转账记录
	 *
	 * @param transSn
	 * @param yearMonth
	 * @return
	 */
	public TransFeeEntity getTransInfo(long transSn, int yearMonth);

	/**
	 * 查询转账记录
	 * 
	 * @param inMap
	 * @return
	 */
	List<TransFeeEntity> getTransInfo(Map<String, Object> inMap);

	/**
	 * 根据服务号码和查询转账记录
	 * 
	 * @param phoneNoOut
	 * @param yearMonth
	 * @param pageNum
	 * @return
	 */
	Map<String, Object> getTransInfo(String phoneNoOut, int yearMonth, int pageNum);

	/**
	 * 名称：查询30、50、80的缴费
	 *
	 * @param idno
	 * @param yearMonth
	 * @param contractNo
	 * @param loginNo
	 * @return
	 */
	public int getCntPayFlag(Map<String, Object> inMap);

	/**
	 * 名称：是否存在预开普通发票
	 * 
	 * @param
	 */
	public boolean isPreInv(long contractNo, Long loginAccept, Long invFee);

	/**
	 * 名称：查询赠费记录
	 * 
	 * @param
	 */
	public List<BatchpayInfoEntity> getBatchPayInfo(Long contractNo, Long idNo, Integer yearMonth);

	/**
	 * 名称：移动商城，赠送与返还话费汇总
	 * 
	 * @param
	 */
	public List<BatchpayInfoEntity> getBatchPayInfoByCon(long contractNo);

	/**
	 * 名称：移动商城，赠送与返还话费明细
	 * 
	 * @param
	 */
	public List<Map<String, Object>> getBatchPayByTime(Map<String, Object> inParam);

	/**
	 * 名称：查询陈死账欠费已收回金额
	 * 
	 * @param Map
	 * @return
	 * @author liuyc_billing
	 */
	public Map<String, Object> getPayedFee(Map<String, Object> inParam);

	/**
	 * 名称：记录催欠缴费记录
	 * 
	 * @param UserOweEntity
	 * @param opCode
	 * @param opTime
	 * @param payedOwe
	 * @return
	 * @author liuyc_billing
	 */
	void savePressPayMent(UserOweEntity oweInfo, String opCode, long payedOwe);
	
	/**
	 * 名称：查询催欠缴费记录
	 * 
	 * @param Map
	 * @return
	 * @author liuyc_billing
	 */
	Map<String,Object> queryPressPayMent(Map<String, Object> inParam);
	
	/**
	 * 名称：更新催欠缴费记录
	 * 
	 * @param Map
	 * @return
	 * @author liuyc_billing
	 */
	void updatePressPayMent(Map<String, Object> inParam);
	
	/**
	 * 名称：获取某月某账户缴费总金额
	 * 
	 * @author qiaolin
	 */
	long getSumPayFee(long contractNo, int yearMonth, String notOpCode, String notForeignSn);
	
	/**
	 * 名称：获取用户状态变更时间
	 * 
	 * @author xiongjy
	 */
	public List<UserChgRecdEntity> getUserChgRecd(long idNo,String yearMonth);
	
	/**
	 * 名称：记录缴费扩展表BAL_PAYEXTEND_INFO
	 * 
	 * @author qiaolin
	 */
	public abstract void savePayextend(PayUserBaseEntity payUserBase, PayBookEntity inBook, FieldEntity field,Map<String, Object> header);
	
	/**
	 * 名称：更新托收记录回退标识
	 */
	public abstract void updCollbillRecd(long contractNo, long billCycle, long loginAccept);
	

	/**
	 * 名称：签约用户主动缴费记录插入
	 */
	public void iSignPay(SignPayEntity signPay);

	/**
	 * 名称：查询操作记录
	 * 
	 * @param inMap
	 * @return
	 */
	LoginOprEntity getLoginOpr(Map<String, Object> inMap);
	
	/**
	 * 名称：查询集团转账成功和失败记录
	 * 
	 * @param inMap
	 * @return
	 */
	public List<GrpRedEntity> getJtRedInfo(Map<String, Object> inMap);
	
	/**
	 * 名称：根据年月和ID_NO查询充值卡记录
	 * 
	 */
	public List<PayCardEntity> getPayCardList(Map<String,Object> inMap);
	
	/**
	 * 功能：获取已发送优惠推荐短信的次数
	 * @param phoneNo 服务号码
	 * @param queryYM 查询年月
	 * @param queryType 查询类型 “gprs”表示推荐短信下发
	 * @param opCode 操作代码
	 * @param loginNo 操作工号(非newapp)
	 * @return
	 */
	int getSmsSendCount(String phoneNo, int queryYM, String queryType, String opCode, String loginNo);
	
	/**
	 * 功能：获取红包转账条数
	 */
	public int getJtRedInfoCount(Map<String, Object> inMap);

}