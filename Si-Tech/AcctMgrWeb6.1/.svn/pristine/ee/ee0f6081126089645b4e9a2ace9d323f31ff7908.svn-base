package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.UnbillPreEntity;
import com.sitech.acctmgr.atom.domains.balance.UnbillVmEntity;
import com.sitech.acctmgr.atom.domains.bill.*;
import com.sitech.acctmgr.atom.domains.collection.CollOweStatusGroupEntity;
import com.sitech.acctmgr.atom.domains.collection.CollectionBillEntity;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.atom.domains.user.BilldayInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserOweEntity;

/**
 * <p>
 * Title:
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
public interface IBill {

    /**
     * 功能：查询未出帐综合帐单信息
     *
     * @param conNo
     * @param idNo
     * @return
     */
    List<UnbillTotEntity> getUnbillBillTotList(Long conNo, Long idNo);

    /**
     * 功能：查询未出帐明细帐单信息
     *
     * @param conNo
     * @param idNo
     * @return
     */
    List<UnbillDetEntity> getUnbillBillDetList(Long conNo, Long idNo);

    /**
     * 功能：查询未出帐销拟销帐结果信息
     *
     * @param conNo
     * @param idNo
     * @return
     */
    List<UnbillVmEntity> getUnbillVMList(Long conNo, Long idNo);

    /**
     * 功能：查询未出帐余额帐本信息
     *
     * @param conNo
     * @param idNo
     * @return
     */
    List<UnbillPreEntity> getUnbillPreList(Long conNo, Long idNo);

    /**
     * 名称：查询离网用户欠费信息
     *
     * @param idNo       必传
     * @param contractNo 可选
     * @param sStatus    可选 不传默认"'1','4'"
     * @return List<BillEntity> BillEntity.NATURAL_MONTH<br/>
     * BillEntity.BILL_CYCLE<br/>
     * BillEntity.BILL_BEGIN<br/>
     * BillEntity.OWE_FEE<br/>
     * BillEntity.SHOULD_PAY<br/>
     * BillEntity.FAVOUR_FEE<br/>
     * BillEntity.PAYED_PREPAY<br/>
     * BillEntity.PAYED_LATER<br/>
     * @author LIJXD
     */
    List<BillEntity> getCycleDeadOwe(long idNo, long contractNo, String sStatus);
    
    
    /**
     * 名称：查询离网用户欠费信息(注：不按账期合并，防止四舍五入导致冲销时出现一分钱误差)
     *
     * @param idNo       必传
     * @param contractNo 可选
     * @param sStatus    可选 不传默认"'1','4'"
     * @return List<BillEntity> BillEntity.NATURAL_MONTH<br/>
     * BillEntity.BILL_CYCLE<br/>
     * BillEntity.BILL_BEGIN<br/>
     * BillEntity.OWE_FEE<br/>
     * BillEntity.SHOULD_PAY<br/>
     * BillEntity.FAVOUR_FEE<br/>
     * BillEntity.PAYED_PREPAY<br/>
     * BillEntity.PAYED_LATER<br/>
     * @author LIJXD
     */
    List<BillEntity> getNotCycleDeadOwe(long idNo, long contractNo, String sStatus);

    /**
     * 取账户/用户的未冲销账单
     *
     * @param CONTRACT_NO       : 账户ID
     * @param ID_NO             : (可选)
     * @param BILL_CYCLE        : (可选)
     * @param MIN_BILL_CYCLE    : (可选)
     * @param MAX_BILL_CYCLE    : (可选)
     * @param MIN_NATURAL_MONTH : (可选)
     * @param MAX_NATURAL_MONTH : (可选)
     * @param BILL_DAY          : (可选)
     * @param NATURAL_MONTH     : (可选)
     * @return List<BillEntity> com.sitech.acctmgr.atom.domains.bill.BillEntity 包含下面节点 <br/>
     * billId BILL_ID </br> idNo ID_NO </br> contractNo CONTRACT_NO </br> oweFee OWE_FEE </br> shouldPay SHOULD_PAY</br> favourFee FAVOUR_FEE </br> payedPrepay PAYED_PREPAY </br> payedLater PAYED_LATER </br> naturalMonth NATURAL_MONTH </br> billCycle BILL_CYCLE</br> billBegin BILL_BEGIN </br> billEnd BILL_END </br> billtype BILL_TYPE </br> billDay BILL_DAY</br> acctItemCode ACCT_ITEM_CODE</br> taxRate TAX_RATE </br> taxFee TAX_FEE</br> payedTax PAYED_TAX </br> cycleType CYCLE_TYPE</br>
     * @author qiaolin
     */
    List<BillEntity> getUnPayOwe(Map<String, Object> inParam);

    /**
     * 名称：按账期分组取账户未冲销费用
     *
     * @param contractNo
     * @return List<Map>: Map<String, Object> <br/>
     * NATURAL_MONTH<br/>
     * BILL_CYCLE<br/>
     * OWE_FEE<br/>
     * SHOULD_PAY<br/>
     * FAVOUR_FEE<br/>
     * PAYED_PREPAY<br/>
     * PAYED_LATER<br/>
     * BILL_BEGIN<br/>
     */
    List<BillEntity> getUnpayOweOnBillCycle(long contractNo, Long idNo);

    /**
     * 功能：查询往月帐单总费用
     *
     * @param contractNo
     * @param idNo
     * @param billCycle
     * @return <p/>
     * TOTAL_OWE_FEE:总欠费<br>
     * TOTAL_PAYED_PREPAY:总划拨金额<br>
     * TOTAL_PAYED_LATER:总缴费冲销金额<br>
     * TOTAL_SHOULD_PAY:<br>
     * TOTAL_FAVOUR_FEE:
     */
    Map<String, Long> getSumUnpayInfo(Long contractNo, Long idNo, Integer billCycle);

    /**
     * 功能：查询往月已冲销帐单总费用
     *
     * @param contractNo
     * @param idNo
     * @param billCycle
     * @return <p/>
     * TOTAL_OWE_FEE:总欠费<br>
     * TOTAL_PAYED_PREPAY:总划拨金额<br>
     * TOTAL_PAYED_LATER:总缴费冲销金额<br>
     * TOTAL_SHOULD_PAY:<br>
     * TOTAL_FAVOUR_FEE:
     */
    Map<String, Long> getSumPayedInfo(Long contractNo, Long idNo, Integer billCycle);

    /**
     * 功能：根据账目项查询往月帐单总费用
     *
     * @param contractNo
     * @param idNo
     * @param billCycle
     * @param parentItemId
     * @param currentLevel
     * @return <p/>
     * TOTAL_OWE_FEE:总欠费<br>
     * TOTAL_PAYED_PREPAY:总划拨金额<br>
     * TOTAL_PAYED_LATER:总缴费冲销金额<br>
     * TOTAL_SHOULD_PAY:<br>
     * TOTAL_FAVOUR_FEE:
     */
    Map<String, Long> getSumUnpayInfoByItems(Long contractNo, Long idNo, Integer billCycle, String parentItemId, String currentLevel);

    /**
     * 功能：根据账目项查询往月已冲销帐单总费用
     *
     * @param contractNo
     * @param idNo
     * @param billCycle
     * @param parentItemId
     * @param currentLevel
     * @return <p/>
     * TOTAL_OWE_FEE:总欠费<br>
     * TOTAL_PAYED_PREPAY:总划拨金额<br>
     * TOTAL_PAYED_LATER:总缴费冲销金额<br>
     * TOTAL_SHOULD_PAY:<br>
     * TOTAL_FAVOUR_FEE:
     */
    Map<String, Long> getSumPayedInfoByItems(Long contractNo, Long idNo, Integer billCycle, String parentItemId, String currentLevel);
    
    /**
     * 功能：获取指定帐期已冲销和未冲销总费用
     *
     * @param contractNo
     * @param billCycle
     * @return <p>
     * 注意：此方法返回值未对phoneNo,及delayFee做赋值
     * </p>
     */
    OweFeeEntity getBillInfo(Long contractNo, Integer billCycle);
    
    /**
     * 功能：获取指定帐期已冲销和未冲销总费用
     *
     * @param contractNo
     * @param idNo
     * @param billCycle
     * @return <p>
     * 注意：此方法返回值未对phoneNo,及delayFee做赋值
     * </p>
     */
    OweFeeEntity getBillInfo(Long contractNo, Long idNo, Integer billCycle);

    /**
     * 功能：按账户查询内存综合账单, 同帐户获取在线还是离线标识
     *
     * @param lContractNo : 账户ID
     * @return
     */
    UnbillEntity getUnbillFee(long lContractNo);

    /**
     * 功能：按账户查询内存综合账单,允许指定在线离线
     *
     * @param lContractNo : 账户ID
     * @param isOnline    : 在线离线标识
     */
    UnbillEntity getUnbillFee(long lContractNo, boolean isOnline);

    /**
     * 功能：按帐户查询未出帐信息
     *
     * @param lContractNo
     * @param sQryType    取值：<li>CommonConst.UNBILL_TYPE_BILL_DET_PRE 明细帐单 + 预存；</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_TOT_PRE 综合帐单 + 预存</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_TOT 综合帐单</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_DET 明细帐单</li>
     *                    <li>CommonConst.UNBILL_TYPE_PRE 预存</li>
     * @param isOnline
     * @return
     */
    UnbillEntity getUnbillFee(long lContractNo, String sQryType, boolean isOnline);

    /**
     * 查询某用户在某账户上的内存欠费信息，根据配置决定在线、离线
     *
     * @param lIdNo       : 用户
     * @param lContractNo ： 账户
     * @param sQryType    : 取值：<li>CommonConst.UNBILL_TYPE_BILL_DET_PRE 明细帐单 + 预存；</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_TOT_PRE 综合帐单 + 预存</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_TOT 综合帐单</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_DET 明细帐单</li>
     *                    <li>CommonConst.UNBILL_TYPE_PRE 预存</li>
     * @return
     */
    UnbillEntity getUnbillFee(long lContractNo, long lIdNo, String sQryType);

    /**
     * 查询某用户在某账户上的内存欠费信息
     *
     * @param lIdNo       查询用户id
     * @param lContractNo 查询账户
     * @param sQryType    : 取值：<li>CommonConst.UNBILL_TYPE_BILL_DET_PRE 明细帐单 + 预存；</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_TOT_PRE 综合帐单 + 预存</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_TOT 综合帐单</li>
     *                    <li>CommonConst.UNBILL_TYPE_BILL_DET 明细帐单</li>
     *                    <li>CommonConst.UNBILL_TYPE_PRE 预存</li>
     * @param isOnline    : 在线离线标识
     * @return
     */
    UnbillEntity getUnbillFee(long lContractNo, long lIdNo, String sQryType, boolean isOnline);

    /**
     * 名称：根据账户号，判断在网账户是否有欠费
     *
     * @param lContractNo
     * @return TRUE:有欠费，FALSE:没有欠费
     * @author qiaolin
     */
    boolean isUnPayOwe(long lContractNo);

    /**
     * 名称：根据账户号，判断在网账户是否有欠费
     *
     * @param lContractNo
     * @param iBillCycle
     * @return TRUE:有欠费，FALSE:没有欠费
     * @author fanck
     */
    boolean isUnPayOwe(long lContractNo, int iBillCycle);

    /**
     * 名称：根据账户号和用户号，判断在网账户是否有欠费
     *
     * @param lContractNo
     * @param iBillCycle
     * @return TRUE:有欠费，FALSE:没有欠费
     * @author fanck
     */
    boolean isUnPayOwe(long lIdNo, long lContractNo, int iBillCycle);

    /**
     * 名称：获取账期开始、结束时间
     *
     * @param idNo
     * @param contractNo
     * @param billMonth
     * @return resultList.BilldayInfoEntity
     * @author qiaolin
     */
    BilldayInfoEntity getBillCycle(long idNo, long contractNo, int billMonth);

    /**
     * 功能：获取用户在付费帐户下指定月份的消费帐单信息
     *
     * @param idNo
     * @param contractNo
     * @param yearMonth
     * @return <br>
     * 返回金额包含：未缴往月费用、已缴往月费用、指定月的未出帐费用
     */
    BillFeeEntity getBillFee(long idNo, long contractNo, int yearMonth);

    /**
     * 功能：获取用户tiaozhangjilu
     *
     * @param idNo
     * @param beginTime
     * @param endTime
     * @return
     */
    List<AdjOweEntity> getAdjOweInfo(long idNo, String beginTime, String endTime, String refundFlag);

    /**
     * 功能：获取查询离网用户各种费用总和
     */
    BillEntity getSumDeadFee(long idNo, long contractNo, String status);

    /**
     * 功能：获取托收单
     *
     * @param contractNo
     * @param billCycle
     * @return CollectionBillEntity
     */
    CollectionBillEntity getCollectionBill(long contractNo, int billCycle);

    /**
     * 功能：获取帐户的托收帐单信息
     *
     * @param contractNo 托收帐户
     * @param billCycle  托收月份
     * @param dealFlag   托收处理标识
     * @param returnCode 托收返回代码
     * @param errorFlag  托收错单标识，取值，null; CommonConst.COLL_ERROR_YES 托收错单；
     * @return
     */
    CollectionBillEntity getCollectionBill(long contractNo, int billCycle, String dealFlag, String returnCode, String errorFlag);

    /**
     * 名称：更新托收账单记录
     *
     * @param contractNo
     * @param billCycle
     * @param returnCode : 可空
     * @param dealFlag
     */
    void updateCollbill(long contractNo, int billCycle, String returnCode, String dealFlag);

    /**
     * 名称：根据账户号、用户号，判断离网账户是否有欠费
     *
     * @param lContractNo
     * @param iBillCycle
     * @param lIdNo
     * @return TRUE:有欠费，FALSE:没有欠费
     * @author fanck
     */
    boolean isDeadUnPayOwe(long lContractNo, int iBillCycle, long lIdNo);

    /**
     * 功能：返回指定托收帐户范围内的未处理的托收帐单信息
     *
     * @param begContract
     * @param endContract
     * @param yearMonth
     * @param disGroupId
     * @param provinceId
     * @return
     */
    List<CollectionBillEntity> getCollBillList(Long begContract, Long endContract, Integer yearMonth, String disGroupId, String provinceId);

    /**
     * 名称：根据账户号、用户号，查询在网用户7大类费用
     *
     * @param lContractNo
     * @param iBillCycle
     * @param lIdNo
     * @param his
     * @return SET_MEAL_FEE 套餐费 VOICE_FEE 语音费 NET_FEE 上网费 MMS_FEE 短彩信费 INCRE_FEE 增值费 COLLECTION_FEE 代收费 OTHER_FEE 其他费
     * @author fanck
     */
    Map<String, Object> getSevenFee(long lContractNo, int iBillCycle, long lIdNo, boolean his);

    /**
     * 名称：根据账户号，查询在网用户7大类费用
     *
     * @param lContractNo
     * @param iBillCycle
     * @return SET_MEAL_FEE 套餐费 VOICE_FEE 语音费 NET_FEE 上网费 MMS_FEE 短彩信费 INCRE_FEE 增值费 COLLECTION_FEE 代收费 OTHER_FEE 其他费
     * @author fanck
     */
    Map<String, Object> getSevenFee(long lContractNo, int iBillCycle);

    /**
     * 名称：根据账户号、用户号，查询在网用户7大类费用
     *
     * @param lContractNo
     * @param iBillCycle
     * @param lIdNo
     * @param billYM
     * @return SET_MEAL_FEE 套餐费 VOICE_FEE 语音费 NET_FEE 上网费 MMS_FEE 短彩信费 INCRE_FEE 增值费 COLLECTION_FEE 代收费 OTHER_FEE 其他费
     * @author fanck
     */
    Map<String, Object> getDeadSevenFee(long lContractNo, int iBillCycle, long lIdNo, int billYM);

    /**
     * 名称：根据账户号，查询在网用户7大类费用
     *
     * @param lContractNo
     * @param iBillCycle
     * @param billYM
     * @return SET_MEAL_FEE 套餐费 VOICE_FEE 语音费 NET_FEE 上网费 MMS_FEE 短彩信费 INCRE_FEE 增值费 COLLECTION_FEE 代收费 OTHER_FEE 其他费
     * @author fanck
     */
    Map<String, Object> getDeadSevenFee(long lContractNo, int iBillCycle, int billYM);

    /**
     * 取账户在线离线开关标志
     *
     * @author xiongjy
     */
    boolean isOnlineForQry(long lContractNo);

    Map<String, Object> getConFeeList(Map<String, Object> inParam);

    /**
     * 功能：查询TD流量信息（经分统计的数据）
     *
     * @param phoneNo
     * @param idNo
     * @return
     */
    TDDataEntity getTdData(String phoneNo, Long idNo);

    /**
     * 功能：获取指定月份的额外费用 tip: 查询ACT_EXFAVOWE_INFO表
     *
     * @param idNo       可空
     * @param contractNo 可空
     * @param yearMonth  查询帐期
     * @return
     */
    ExFavOweFeeEntity getExFeeTotalInfo(Long idNo, Long contractNo, int yearMonth);

    /**
     * 功能：根据pay_type查询冲销计划
     *
     * @param payType
     * @param pageNum
     * @return
     */
    Map<String, Object> getWriteOff(String payType, int pageNum);

    /**
     * 功能：查询账目项列表
     *
     * @param inParam
     * @return
     */
    ItemRelEntity getItemList(Map<String, Object> inParam);

    /**
     * 功能：根据一级账目项查询二级账目项列表
     *
     * @param itemCode
     * @param pageNum
     * @param level
     * @return
     */
    Map<String, Object> getItemRel(String level, String itemCode, int pageNum);

    /**
     * 功能：根据三级账目项查询二级账目项
     *
     * @param itemCode
     * @param parentLevel
     * @return
     */
    Map<String, Object> getItemRelByChild(String itemCode, String parentLevel);

    /**
     * 功能：根据专款类型，查询回收专款时的账目项
     *
     * @param payType
     * @return
     */
    List<WriteOffItemEntity> getDownItem(String payType);

    /**
     * 功能：获取帐目项信息
     *
     * @param acctItemCode 帐目项代码
     * @return 可用属性 <li>itemName</li> <li>acctItemAttr</li>
     */
    BillItemEntity getItemConf(String acctItemCode);

    /**
     * 功能：获取七大类帐目名称
     *
     * @param itemId 七大类代码
     * @return 可用属性 <li>acctItemCode</li> <li>itemName</li>
     */
    BillItemEntity getBillItemConf(String itemId);

    /**
     * 功能：获取帐目项级别关系
     *
     * @param itemId
     * @param parentLevel CommonConst.PARENT_ITEMREL_LEVEL_1: 父节点为一级节点；CommonConst.PARENT_ITEMREL_LEVEL_2：父节点为二级节点
     * @return 可用属性 <li>acctItemCode</li> <li>parentItemId</li> <li>currentLevel</li>
     */
    BillItemEntity getItemRelInfo(String itemId, String parentLevel);

    /**
     * 功能：查询指定账本冲销的账目项
     *
     * @param payType
     * @return
     */
    public List<ItemEntity> getPayTypeItem(String payType);

    /**
     * 功能：获取一级或二级展示帐目项列表
     *
     * @param itemLevel CommnonConst.BILLTTEM_DISP_LEVEL_1：一级帐目项列表； CommonConst.BILLTTEM_DISP_LEVEL_2：二级帐目项列表
     * @return
     */
    List<BillItemEntity> getBillItemList(String itemLevel);

    /**
     * 功能：返回三级帐单帐目项列表
     *
     * @return
     */
    List<BillItemEntity> getAcctItemList();

    /**
     * 功能：查询用户/帐户未出帐欠费信息
     *
     * @param idNo
     * @param contractNo
     * @return
     */
    BillFeeEntity getUnBillOweFee(long idNo, long contractNo);

    /**
     * 功能：获取用户总实收费用
     *
     * @param idNo
     * @param contractNo
     * @param yearMonth
     * @return
     */
    long getRealFee(long idNo, long contractNo, int yearMonth);

    /**
     * 功能：获取已冲销的消费金额
     *
     * @return
     */
    long getPayedOweRealFee(Long idNo, long contractNo, int yearMonth);

    /**
     * 功能：获取税率和税额
     *
     * @return
     */
    Map<String, Object> getTaxFee(long fee, String acctItem);

    /**
     * 功能：取最大billday
     *
     * @return
     */
    int getMaxBillDay(Map<String, Object> inParam);

    /**
     * 功能：按照账本类型，打印标志，用户ID查询指定bill_cycle中的记录,用于月结发票的查询
     *
     * @param inParam
     * @return
     * @author liuhl
     */
    List<Map<String, Object>> getWriteInfo(Map<String, Object> inParam);

    /**
     * 名称：查询账单费用信息
     *
     * @param inMap
     * @return
     */
    Map<String, Long> getSumPayedInfo(Map<String, Object> inMap);

    /**
     * 功能：集团帐户获取按帐目项合并后的帐单列表<br>
     * 注：不查询未出帐账单
     *
     * @param contractNo
     * @param queryYm
     * @return
     */
    List<BillDispDetailEntity> getGrpAllBillList(Long contractNo, int queryYm);

    /**
     * 功能：普通用户某月在帐户下按帐目项合并后的帐单列表<br>
     * 注：含未出帐账单
     *
     * @param idNo
     * @param contractNo
     * @param queryYm
     * @return
     */
    List<BillDispDetailEntity> getAllBillList(Long idNo, Long contractNo, int queryYm);

    /**
     * 名称：获取有陈死账的欠费用户清单
     *
     * @param phoneNo
     * @param payStatus
     * @return
     * @author liuyc_billing
     */
    List<UserOweEntity> qOweUser(String phoneNo, String payStatus);

    /**
     * 名称：获取陈死账欠费的用户基本信息
     *
     * @param idNo
     * @return
     * @author liuyc_billing
     */
    List<UserOweEntity> qOweUserInfo(String phoneNo, long idNo);

    /**
     * 名称：获取陈死账欠费的用户欠费信息
     *
     * @param idNo
     * @param phoneNo
     * @return
     * @author liuyc_billing
     */
    List<UserOweEntity> qOweFeeInfo(String phoneNo, long idNo);

    /**
     * 名称：更新陈死账欠费的用户欠费状态
     *
     * @param idNo
     * @param phoneNo
     * @param billYear
     * @param billMonth
     * @param loginNo
     * @return
     * @author liuyc_billing
     */
    void updateOweUserInfo(String phoneNo, long idNo, String billYear, String billMonth, String loginNo, long paySn, String payedStatus,
                           String oldStatus, String payAccept);

    /**
     * 功能：获取用户托收单的总条数
     *
     * @param contractNo
     * @param yearMonth
     * @return
     */
    int getCollBillCnt(long contractNo, int yearMonth);

    /**
     * 功能：分页查询帐户的托收清单列表
     *
     * @param contractNo
     * @param yearMonth
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<CollOweStatusGroupEntity> getConBillInfo(long contractNo, int yearMonth, int pageSize, int pageNum);

    /**
     * 功能：按状态统计帐户下的托收清单列表
     *
     * @param contractNo
     * @param yearMonth
     * @return
     */
    List<CollOweStatusGroupEntity> getConBillInfo(long contractNo, int yearMonth);

    /**
     * 名称：取账户最小欠费年月，若用户不欠费，最小欠费月置为当前月
     *
     * @return
     * @author xiongjy
     */
    int getMinBillCycle(long lContractNo);

    /**
     * 功能：获取帐户指定帐期欠费帐单的指定帐目项组的费用 <br>
     * 注：大类若不存在帐单则不展示；
     *
     * @param contractNo
     * @param yearMonth
     * @return
     */
    List<ItemGroupBillEntity> getBillListByItemGroup(Long contractNo, int yearMonth, String itemGroupType);

    /**
     * 功能：获取实时欠费明细信息
     */
    Map<String,Object> getBillDetailInfo(Map<String, Object> inMap,int pageNum);

    /**
     * 名称：取dstop_check表中欠费，合帐分享查询用
     *
     * @return
     * @author xiongjy
     */
    Map<String, Object> getStopCheckOwe(long contractNo, int yearMonth);

    /**
     * @param contractNo
     * @param idNo
     * @return
     */
    Map<String, Long> getUnbillDxInfo(long contractNo, long idNo);

    /**
     * 功能：获取已缴清明细账单
     *
     * @param contractNo
     * @param billCycle
     * @return
     */
    List<BillInfoDispEntity> getPayedBillList(long contractNo, int billCycle);

    /**
     * 功能：获取未缴清明细账单
     *
     * @param contractNo
     * @return
     */
    List<BillInfoDispEntity> getUnpayBillList(long contractNo, int billCycle);

    /**
     * 功能：获取已冲销滞纳金
     *
     * @param contractNo
     * @param billCycle
     * @return
     */
    long getPayedDelayFee(long contractNo, int billCycle);

    /**
     * 功能：查询帐户下付费用户帐单列表，按用户分组
     * @param contractNo
     * @param yearMonth
     * @return
     */
    List<BillEntity> getPayedOweGroupById(long contractNo, int yearMonth);

    /**
     * 功能：查询帐户下付费用户帐单列表，按用户分组
     * @param contractNo
     * @param yearMonth
     * @return
     */
    List<BillEntity> getUnPayOweGroupById(long contractNo, int yearMonth);

    /**
     * 功能：将指定月份的帐单插件到业务中间表中
     * @param contractNo 不可空
     * @param idNo 可空，传空时，取到的是帐户下所有帐单
     * @param yearMonth
     */
    void saveMidAllBillFee(long contractNo, long idNo, int yearMonth);

    /**
     * 功能：将指定月份的帐单插件到业务中间表中（离网用户）
     * @param contractNo 不可空
     * @param idNo 可空，传空时，取到的是帐户下所有帐单
     * @param yearMonth
     */
    void saveMidAllBillFeeDead(long contractNo, long idNo, int yearMonth);

    /**
     * 功能：获取指定帐目项类型的帐单明细
     * 注：需要和saveMidAllBillFee联合使用
     * @param contractNo
     * @param idNo
     * @param yearMonth
     * @param itemGroupType
     * @return
     */
    List<ItemGroupBillEntity> getAllBillListDetByItemGroup(Long contractNo, Long idNo, int yearMonth, String itemGroupType);
}