package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.adj.*;
import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.query.RefundEntity;

/**
 *
 * <p>
 * Title: 调账实体接口
 * </p>
 * <p>
 * Description: 获取调账相关信息
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author guowy
 * @version 1.0
 */
public interface IAdj {

	/**
	 * 名称：获取出账批次--补收9000
	 * 
	 * @param CONTRACT_NO
	 *            账户号码
	 * @param ID_NO
	 *            用户号码
	 * @param YEAR_MONTH
	 *            查询年月
	 * 
	 * @return BILL_DAY
	 * @throws Exception
	 * @author guowy
	 */
	long getBillDay(Long contractNo, Long idNo, String yearMonth);

	/**
	 * 名称：入调账信息表 act_adjowe_info
	 * 
	 * @param 账单实体
	 *            BillEntity
	 * @param 账单基本信息外的调账信息
	 *            AdjExtendEntity
	 * @return
	 * @throws
	 */
	void saveAcctAdjOweInfo(AdjBIllEntity billEnt, AdjExtendEntity adjEntendEnt);
	

	/**
	 * 名称：修改补收记录表中信息
	 * @param billEnt
	 * @param adjEntendEnt
	 */
	void updateAcctAdjOweInfo(AdjBIllEntity billEnt, AdjExtendEntity adjEntendEnt,long opSn);

	/**
	 * 名称：sp信息查询
	 * 
	 * @param SPID
	 *            : 企业代码
	 * @param SERVNAME
	 *            ：业务名词 可空
	 * 
	 * @return SpInfoEntity： SP明细 SpInfoEntity.SPID: 企业代码 SpInfoEntity.BIZCODE
	 *         业务代码 SpInfoEntity.SERVNAME 业务名称
	 * @throws Exception
	 */
	List<SpInfoEntity> getSpList(String spId, String servName);

	/**
	 * 名称：入SP信息表
	 * 
	 * @param
	 * @param
	 * 
	 * @return
	 * @throws Exception
	 */
	void saveSpInfo(Map<String, Object> inParam);

	/**
	 * 名称：投诉退费冲正投诉信息查询
	 * 
	 * @param opSn
	 *            操作流水
	 * @param idNo
	 *            用户号码
	 * 
	 * @return List<AdjExtendEntity>
	 * 
	 * @throws Exception
	 */
	List<AdjExtendEntity> getBackAdjOweInfo(long opSn, long idNo, String adjFlag);

	/**
	 * 名称：根据流水和号码获取sp信息记录数
	 * 
	 * @param opSn
	 *            操作流水
	 * @param phoneNo
	 *            服务号码
	 * 
	 * @return int
	 * 
	 * @throws Exception
	 */
	int getCntSpByOpSn(long opSn, String phoneNo);

	/**
	 * 名称：根据工号或者服务号码查询退费信息
	 * 
	 * @param
	 * @param
	 * 
	 * @return List<AdjExtendEntity>
	 * 
	 * @throws Exception
	 */
	List<AdjExtendEntity> getAdjOweInfo(Map<String, Object> inParam);

	/**
	 * 名称：根据地市代码或者服务号码批量查询退费信息
	 * 
	 * @param
	 * @param
	 * 
	 * @return List<Map<String, Object>
	 * 
	 * @throws Exception
	 */
	List<Map<String, Object>> getBatchAdjOweInfo(Map<String, Object> inParam);

	/**
	 * 名称：根据地市代、退费原因代码查询退费原因信息
	 * 
	 * @param firstCode
	 *            一级退费原因代码
	 * @param secondCode
	 *            二级退费原因代码 可空
	 * @param status
	 *            状态标志 0：不使用，1：非sp 2：sp
	 * @param regionCode
	 *            地市代码
	 * 
	 * @return List<Map<ComplainAdjReasonEntity>>
	 * 
	 * @throws Exception
	 */
	List<ComplainAdjReasonEntity> getAdjReasonInfo(String firstCode, String secondCode, String[] status, String regionCode);

	/**
	 * 名称：查询一级、二级、三级退费原因信息
	 * 
	 * @param codeClass
	 *            退费原因标志 2410：一级退费原因 2411：二级退费原因 2412：三级退费原因
	 * @param codeValue
	 *            二级或者三级对应的其父级退费原因代码
	 * @param groupId
	 *            地市代码
	 * @param status
	 *            状态标志 0：不使用，1：非sp 2：sp
	 * @param codeId
	 * @return
	 */
	List<PubCodeDictEntity> getReaosnCodeList(Long codeClass, String codeValue, String groupId, 
			String[] status, String codeId,String loginNo);

	/**
	 * 名称：根据地市代码、退费标志查询没级原因当前最大退费原因代码
	 * 
	 * @param codeClass
	 *            退费原因标志 2410：一级退费原因 2411：二级退费原因 2412：三级退费原因
	 * @param status
	 *            状态标志 0：不使用，1：非sp 2：sp
	 * @param groupId
	 *            组织代码
	 * 
	 * @return max codeId
	 * 
	 * @throws Exception
	 */
	String getMaxCodeId(Long codeClass, String groupId);

	/**
	 * 名称：判断退费原因是否已经存在
	 * 
	 * @param codeClass
	 *            退费原因标志 2410：一级退费原因 2411：二级退费原因 2412：三级退费原因
	 * @param status
	 *            状态标志 0：不使用，1：非sp 2：sp
	 * @param regionCode
	 *            地市代码
	 * @param codeName
	 *            退费原因
	 * 
	 * @return false：该地市不存在该退费原因 true：该地市存在该退费原因
	 * 
	 * @throws Exception
	 */
	boolean isReasonInfo(Long codeClass, String regionCode, String codeName, String status);

	/**
	 * 名称：新增退费原因如表
	 * 
	 * @param PubCodeDictEntity
	 *            退费原因记录实体
	 * 
	 * @return void
	 * 
	 * @throws Exception
	 */
	void insReason(PubCodeDictEntity adjReasonEnt);

	/**
	 * 名称：判断当前退费原因是否存在下级原因（针对一级二级退费原因）
	 * 
	 * @param codeClass
	 *            退费原因标志 2410：一级退费原因 2411：二级退费原因 2412：三级退费原因
	 * @param status
	 *            状态标志 0：不使用，1：有效
	 * @param regionCode
	 *            地市代码
	 * @param codeValue
	 *            退费原因代码
	 * @param spStatus
	 *            status
	 * 
	 * @return false：退费原因无下级退费原因 true：退费原因有下级退费原因
	 * 
	 * @throws Exception
	 */
	boolean isLowerReason(int codeClass, String regionCode, String codeValue, String status, String[] spStatus);

	/**
	 * 名称：更新退费原因为失效状态
	 * 
	 * @param codeClass
	 *            退费原因标志 2410：一级退费原因 2411：二级退费原因 2412：三级退费原因
	 * @param status
	 *            状态标志 0：不使用，1：有效
	 * @param regionCode
	 *            地市代码
	 * @param codeId
	 *            退费原因代码
	 * 
	 * @return int
	 * 
	 * @throws Exception
	 */
	int updateReasonStatus(int codeClass, String regionCode, String codeId, String status);

	/**
	 * 名称：飞豆信息查询
	 * 
	 * @param phoneNo
	 * @param status
	 *            状态标志 0：不使用，1：有效
	 * @param regionCode
	 *            地市代码
	 * @param codeValue
	 *            退费原因代码
	 * 
	 * @return false：退费原因无下级退费原因 true：退费原因有下级退费原因
	 * 
	 * @throws Exception
	 */
	Map<String, Object> getFDBusiRecd(Map<String, Object> inMap);

	/**
	 * @Description 飞豆订购信息记录飞豆信息记录表
	 * @param Map
	 * @return
	 */
	void insertFDBusiRecd(Map<String, Object> inMap);

	/**
	 * @Description 更新飞豆信息表状态
	 * @param phoneNo
	 * @return
	 */
	void updateFDBusiRecd(Map<String, Object> inMap);
	
	/**
	 * 名称：飞豆充值记录查询
	 * 
	 * @param phoneNo
	 * @param status
	 *            状态标志 0：不使用，1：有效
	 * @param regionCode
	 *            地市代码
	 * @param codeValue
	 *            退费原因代码
	 * 
	 * @return false：退费原因无下级退费原因 true：退费原因有下级退费原因
	 * 
	 * @throws Exception
	 */
	List<Map<String, Object>> queryFDBusiRecd(Map<String, Object> inMap);

	/**
	 * 名称：查询普通退费列表
	 * 
	 * @param inParam
	 * @return
	 */
	// List<RefundEntity> getRefundList(Map<String, Object> inMap);
	List<RefundEntity> getRefundList1(Map<String, Object> inParam);

	/**
	 * 名称：查询sp退费列表
	 * 
	 * @param inParam
	 * @return
	 */
	List<RefundEntity> getSpRefund1(Map<String, Object> inParam);

	/**
	 * 名称：查询退费列表
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	List<RefundEntity> getRefundList(Map<String, Object> inParam);
	
	/**
	 * 名称：查询SP退费列表
	 * 
	 * @author liuyc_billing
	 * @param inParam
	 * @return
	 */
	List<RefundEntity> getSPBack(Map<String, Object> inParam);
	
	
	/**
	 * 名称：查询SP退费详单列表（针对一键退费的详单中间表）
	 * 
	 * @author liuyc_billing
	 * @param inParam
	 * @return
	 */
	List<BalCustRefundEntity> listSPInfo(Map<String, Object> inParam);
	
	/**
	 * 名称：插入SP退费详单列表（针对一键退费的详单中间表）
	 * 
	 * @author liuyc_billing
	 * @param inParam
	 * @return
	 */
	void insertSPInfo(List<Map<String, Object>> iList);

	/**
	 * 名称:查询gprs退费或梦网及自有业务退费
	 * 
	 * @author liuhl
	 * @param inParam
	 * @return
	 */
	List<RefundEntity> getGprsOrMonternetRefund(Map<String, Object> inParam);

	/**
	 * 名称：查询退费名称
	 * 
	 * @author liuhl
	 * 
	 * @param codeClass
	 *            2412:三级 2411：二级 2410：一级
	 * @param reasonCode
	 * @param status
	 *            查询gprs退费和梦网及自有业务退费时传入status=4
	 * @return
	 */
	String reasonName(String codeClass, String reasonCode, String status);

	/**
	 * 名称:插入批量补收错误表
	 *
	 * @author jiassa
	 * @param BatchAdjErrEntity
	 * @return
	 */
	public void saveBatchadjErr(BatchAdjInfoEntity batchAdjInfoEntity,String errType,String errCode,String errMsg);
	/**
	 * 名称:插入批量中间表
	 *
	 * @author jiassa
	 * @param BatchAdjInfoEntity
	 * @return
	 */
	public void saveBatchadjInfo(BatchAdjInfoEntity object);

	/**
	 * 名称:获取某月补收金额
	 *
	 * @author jiassa
	 * @param Map
	 * @return
	 */
	public long getMonthFee(Map<String,Object> inParm);
	
	/**
	 * 名称:获取某月负补收金额
	 *
	 * @author jiassa
	 * @param Map
	 * @return
	 */
	public long getMinusMonthFee(Map<String, Object> inParm);

	/**
	 * 名称:获取补收账目项
	 *
	 * @author jiassa
	 * @param Map
	 * @return
	 */
	public List<ItemEntity> getAdjItemList();

	/**
	 * 名称:根据品牌标识获取账目项
	 *
	 * @author liuyc_billing
	 * @param Map
	 * @return
	 */
	public List<ItemEntity> getAdjItemByBrandId(Map<String,Object> inParm);

	/**
	 * 名称：记录小额支付记录表
	 *
	 * @param inParam
	 * @return
	 */
	public void saveMicroPayInfo(Map<String, Object> inParam);
	
	/**
	 * 名称：更新小额支付记录
	 * 
	 * @param inParam
	 */
	public void updateMicroPayInfo(Map<String, Object> inParam);
	
	/**
	 * 名称：获取小额支付记录
	 * 
	 * @param inParam
	 */
	public List<MicroPayEntity> queryMicroPayInfo(Map<String, Object> inParam);


}
