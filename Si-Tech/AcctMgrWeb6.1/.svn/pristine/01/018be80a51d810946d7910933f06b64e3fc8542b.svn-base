package com.sitech.acctmgr.atom.entity;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.balance.BatchpayInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.SignPayEntity;
import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.bill.DetailEnterEntity;
import com.sitech.acctmgr.atom.domains.cct.UnStopHolidayEntity;
import com.sitech.acctmgr.atom.domains.detail.DetailQryRecord;
import com.sitech.acctmgr.atom.domains.pay.*;
import com.sitech.acctmgr.atom.domains.query.BatchPayErrEntity;
import com.sitech.acctmgr.atom.domains.query.GrpRedEntity;
import com.sitech.acctmgr.atom.domains.query.PayCardEntity;
import com.sitech.acctmgr.atom.domains.record.ActCollBillRecdEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.record.UserChgRecdEntity;
import com.sitech.acctmgr.atom.domains.user.UserOweEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * <p>
 * Title: 操作日志类
 * </p>
 * <p>
 * Description: 存放日志表的操作
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

@SuppressWarnings("unchecked")
public class Record extends BaseBusi implements IRecord {

    private IGroup group;
    private ILogin login;
    private IControl control;

    private IPreOrder preOrder;

    public void saveLoginOpr(LoginOprEntity loginOpr) {
        baseDao.insert("bal_loginopr_info.iLoginOpr", loginOpr);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public void saveQueryOpr(ActQueryOprEntity aqoeEntity, boolean isTouchAuth) {

		/* 取系统时间和当前年月 */
        int iTotalDate = DateUtils.getCurDay();

		/* 取系统流水 */
        long lLoginAccept = aqoeEntity.getQuerySn();
        if (lLoginAccept == 0) {
            lLoginAccept = control.getSequence("seq_system_sn");
        }


        aqoeEntity.setQuerySn(lLoginAccept);
        aqoeEntity.setTotalDate(iTotalDate);

        baseDao.insert("act_queryopr_info.iActQueryOpr", aqoeEntity);

        if (isTouchAuth) {

            String regionCode = group.getRegionDistinct(aqoeEntity.getLoginGroup(), "2", aqoeEntity.getProvinceId()).getRegionCode();

            Map<String, Object> queryInfoMap = new HashMap<String, Object>();
            queryInfoMap.put("Header", aqoeEntity.getHeader());

            //报文OPR_INFO节点内容
            queryInfoMap.put("PAY_SN", lLoginAccept);
            queryInfoMap.put("LOGIN_NO", aqoeEntity.getLoginNo());
            queryInfoMap.put("GROUP_ID", aqoeEntity.getLoginGroup());
            queryInfoMap.put("OP_CODE", aqoeEntity.getOpCode());
            queryInfoMap.put("REGION_ID", regionCode);
            queryInfoMap.put("OP_NOTE", aqoeEntity.getRemark());
            queryInfoMap.put("CUST_ID_TYPE", "1");
            queryInfoMap.put("CUST_ID_VALUE", aqoeEntity.getPhoneNo());
            queryInfoMap.put("OP_TIME", DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS));
            queryInfoMap.put("ID_NO",aqoeEntity.getIdNo());
            queryInfoMap.put("CONTRACT_NO", aqoeEntity.getContactId());

            preOrder.sendQueryCntt(queryInfoMap);
        }

    }

    public void savePayMent(PayUserBaseEntity payUserBase, PayBookEntity inBook) {

        log.debug("savePayMent begin: " + payUserBase.toString() + inBook.toString());

        if (inBook.getOriginalSn() == 0) {
            inBook.setOriginalSn(inBook.getPaySn());
        }

		/* 入缴费记录表bal_payment_yyyymm */
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.putAll(payUserBase.toMap());
        inMapTmp.putAll(inBook.toMap());
        inMapTmp.put("REMARK", inMapTmp.get("OP_NOTE"));
        baseDao.insert("bal_payment_info.iPayment", inMapTmp);
    }

    /* (non-Javadoc)
     *
     * @see com.sitech.acctmgr.atom.entity.a#savePayCard(java.util.Map) */
    @Override
    public void savePayCard(Map<String, Object> inParam) {

        Map<String, Object> inMapTmp = null;/* 临时变量:入参 */
        Map<String, Object> mOutParamTmp = null;/* 临时变量:出参 */

        List<Map<String, Object>> payList = (List<Map<String, Object>>) inParam.get("PAY_LIST");
        log.info("qiaolin test1 ");
        for (Map<String, Object> mapTmp : payList) {

            log.info("qiaolin test2 ");
            inMapTmp = new HashMap<String, Object>();
            inMapTmp.put("CARD_SN", inParam.get("CARD_SN"));
            inMapTmp.put("PAY_TYPE", mapTmp.get("PAY_TYPE"));
            inMapTmp.put("PAY_SN", mapTmp.get("PAY_SN"));
            inMapTmp.put("TOTAL_DATE", inParam.get("TOTAL_DATE"));
            inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
            baseDao.insert("bal_paycard_recd.ipaycard", inMapTmp);
        }

        log.info("qiaolin test3 ");

    }

    @Override
    public void savePosPayInfo(PosPayEntity posPayEntity, PayUserBaseEntity payUserBase, PayBookEntity inBook) {

        Map<String, Object> posPayMap = JSON.parseObject(JSON.toJSONString(posPayEntity), Map.class);

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.putAll(posPayMap);
        inMap.putAll(payUserBase.toMap());
        inMap.putAll(inBook.toMap());
        inMap.put("BOSS_ORDER_ID", ValueUtils.getValueFromMap(inMap, "BOSS_ORDER_ID", "0"));
        inMap.put("FOREIGN_NOTE", ValueUtils.getValueFromMap(inMap, "FOREIGN_NOTE", ""));

        baseDao.insert("BAL_POSPAY_RECD.insert", inMap);
    }

    public boolean isTransBind(String groupId, String phoneNo) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        Map<String, Object> outParam = new HashMap<String, Object>();

        inMap.put("GROUP_ID", groupId);
        inMap.put("PHONE_NO", phoneNo);
        outParam = (Map<String, Object>) baseDao.queryForObject("bal_transbind_recd.getBindNumByGroup", inMap);
        int ibindNum = Integer.parseInt(outParam.get("COUNT").toString());
        if (ibindNum > 0) {
            return true;
        } else {
            return false;
        }

    }

    @Override
    public List<PayMentEntity> getPayMentList(Map<String, Object> inParam) {
        Map<String, Object> outParam = new HashMap<String, Object>();
        Map<String, Object> inMap = new HashMap<String, Object>();

        inMap.put("SUFFIX", inParam.get("SUFFIX"));

        if (inParam.get("ID_NO") != null && !inParam.get("ID_NO").equals("")) {
            inMap.put("ID_NO", (Long) inParam.get("ID_NO"));
        }

        if (inParam.get("CONTRACT_NO") != null && !inParam.get("CONTRACT_NO").equals("")) {
            inMap.put("CONTRACT_NO", (Long) inParam.get("CONTRACT_NO"));
        }

        if (inParam.get("PAY_SN") != null && !inParam.get("PAY_SN").equals("")) {
            inMap.put("PAY_SN", (Long) inParam.get("PAY_SN"));
        }

        if (inParam.get("PAY_TYPE") != null && !inParam.get("PAY_TYPE").equals("")) {
            inMap.put("PAY_TYPE", (String) inParam.get("PAY_TYPE"));
        }

        if (inParam.get("STATUS") != null && !inParam.get("STATUS").equals("")) {
            inMap.put("STATUS", (String) inParam.get("STATUS"));
        }

        if (inParam.get("BEGIN_DATE") != null && !inParam.get("BEGIN_DATE").equals("")) {
            inMap.put("BEGIN_DATE", Integer.parseInt(inParam.get("BEGIN_DATE").toString()));
        }

        if (inParam.get("END_DATE") != null && !inParam.get("END_DATE").equals("")) {
            inMap.put("END_DATE", Integer.parseInt(inParam.get("END_DATE").toString()));
        }

        if (inParam.get("BEGIN_TIME") != null && !inParam.get("BEGIN_TIME").equals("")) {
            inMap.put("BEGIN_TIME", (String) inParam.get("BEGIN_TIME"));
        }

        if (inParam.get("CONTRACT_NO_LIST") != null && !inParam.get("CONTRACT_NO_LIST").equals("")) {
            inMap.put("CONTRACT_NO_LIST", inParam.get("CONTRACT_NO_LIST"));
        }

        if (inParam.get("END_TIME") != null && !inParam.get("END_TIME").equals("")) {
            inMap.put("END_TIME", (String) inParam.get("END_TIME"));
        }

        if (inParam.get("DESC") != null && !inParam.get("DESC").equals("")) {
            inMap.put("DESC", "DESC");
        }

        if (inParam.get("FOREIGN_SN") != null && !inParam.get("FOREIGN_SN").equals("")) {
            inMap.put("FOREIGN_SN", inParam.get("FOREIGN_SN"));
        }

        if (inParam.get("ACCPERT_PAYTYPE") != null && !inParam.get("ACCPERT_PAYTYPE").equals("")) {
            inMap.put("ACCPERT_PAYTYPE", inParam.get("ACCPERT_PAYTYPE"));
        }

        if (inParam.get("NOT_PAY_SN") != null && !inParam.get("NOT_PAY_SN").equals("")) {
            inMap.put("NOT_PAY_SN", inParam.get("NOT_PAY_SN"));
        }
        if (inParam.get("NOT_FOREIGN_SN") != null && !inParam.get("NOT_FOREIGN_SN").equals("")) {
            inMap.put("NOT_FOREIGN_SN", inParam.get("NOT_FOREIGN_SN"));
        }
        if (inParam.get("OP_TIME") != null && !inParam.get("OP_TIME").equals("")) {
            inMap.put("OP_TIME", inParam.get("OP_TIME"));
        }

        if (inParam.get("OP_CODE") != null && !inParam.get("OP_CODE").equals("")) {
            inMap.put("OP_CODE", (String) inParam.get("OP_CODE"));
        }

        if (inParam.get("OP_CODE_LIST") != null && !inParam.get("OP_CODE_LIST").equals("")) {
            inMap.put("OP_CODE_LIST", inParam.get("OP_CODE_LIST"));
        }

        if (inParam.get("NOT_OP_CODES") != null && !inParam.get("NOT_OP_CODES").equals("")) {
            inMap.put("NOT_OP_CODES", inParam.get("NOT_OP_CODES"));
        }

        if (inParam.get("REMARK") != null && !inParam.get("REMARK").equals("")) {
            inMap.put("REMARK", inParam.get("REMARK"));
        }
        if (inParam.get("NOT_PAY_TYPES") != null && !inParam.get("NOT_PAY_TYPES").equals("")) {
            inMap.put("NOT_PAY_TYPES", inParam.get("NOT_PAY_TYPES"));
            log.debug("NOT_PAY_TYPES:" + inParam.get("NOT_PAY_TYPES"));
        }
        if (inParam.get("SYSTEM_PAY_TYPE") != null && !inParam.get("SYSTEM_PAY_TYPE").equals("")) {
            inMap.put("SYSTEM_PAY_TYPE", inParam.get("SYSTEM_PAY_TYPE"));
        }

        if (inParam.get("PAY_SN_LIST") != null && !inParam.get("PAY_SN_LIST").equals("")) {
            inMap.put("PAY_SN_LIST", inParam.get("PAY_SN_LIST"));
        }

        log.debug("record 的查询缴费记录参数：" + inMap);
        List<PayMentEntity> resultList = baseDao.queryAllDbList("bal_payment_info.qBalPayMent", inMap);

        return resultList;
    }

    public void saveCollbillRecd(ActCollBillRecdEntity in) {

        if (in.getReturnCode() == null) {
            in.setReturnCode("00");
        }
        if (in.getBackFlag() == null) {
            in.setBackFlag("0");
        }

        baseDao.insert("act_collbill_recd.iCollbillRecd", in);
    }

    public void saveDetailEnter(DetailEnterEntity dee) {
        if (this.getDetailEnterInfo(dee.getIdNo()) != null) {
            throw new BusiException(AcctMgrError.getErrorCode("8291", "00003"), "不允许重复录入！");
        }
        baseDao.insert("act_detailqueryenter_info.insert", dee);
    }

    @Override
    public DetailEnterEntity getDetailEnterInfo(Long idNo) {
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", idNo);
        DetailEnterEntity result = (DetailEnterEntity) baseDao.queryForObject("act_detailqueryenter_info.qryDetailEnterInfo", inMap);

        return result;
    }

    @Override
    public void updateDetailEnterInfo(Long idNo) {
        Map<String, Object> inMap = new HashMap<>();
        safeAddToMap(inMap, "ID_NO", idNo);
        baseDao.update("act_detailqueryenter_info.updDetailEnterInfo", inMap);
    }

    @Override
    public Map<String, Object> getDetailRecordMap(Map<String, Object> inParam, int pageNum) {
    	Map<String, Object> outMap = baseDao.queryForPagingList("act_queryopr_info.qryRecordList", inParam, pageNum, 10);
        
        List<DetailQryRecord> recordList = (List<DetailQryRecord>) outMap.get("result");
        int sum = ValueUtils.intValue(outMap.get("sum"));
        
        outMap = new HashMap<String, Object>();
        outMap.put("RECORD_LIST", recordList);
        outMap.put("SUM", sum);
        return outMap;
    }

    @Override
    public long cntVirtualGrp(long unitId) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("UNIT_ID", unitId);
        long count = (long) baseDao.queryForObject("bal_virtualgrp_info.qryCount", inMap);
        return count;
    }

    public void saveVirtualGrp(VirtualGrpEntity vge) {
        baseDao.insert("bal_virtualgrp_info.insert", vge);
    }

    public void delVirtualGrp(String unitId, long loginAccept) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("UNIT_ID", unitId);
        inMap.put("LOGIN_ACCEPT", loginAccept);
        long count = (long) baseDao.queryForObject("bal_grppreinv_info.qryCount", inMap);
        if (count > 0) {
            throw new BusiException(AcctMgrError.getErrorCode("8293", "00002"), "虚拟集团下有未回收发票,不允许删除! inParam:[ " + inMap.toString() + " ]");
        }

        // 插入历史表
        baseDao.insert("bal_virtualgrp_his.insert", inMap);

        // 删除原表数据
        baseDao.delete("bal_virtualgrp_info.delete", inMap);

        // 删除成员表数据
        baseDao.insert("bal_grpuserrel_his.insert", inMap);
        baseDao.delete("bal_grpuser_rel.delete", inMap);

    }

    public void saveVirtualDetail(VirtualGrpEntity vge) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("UNIT_ID", vge.getUnitId());
        inMap.put("PHONE_NO", vge.getGrpPhoneNo());
        inMap.put("CONTRACT_NO", vge.getGrpContractNo());
        long count = (long) baseDao.queryForObject("bal_grpuser_rel.qryCount", inMap);
        if (count > 0) {
            throw new BusiException(AcctMgrError.getErrorCode("8293", "00007"), "该成员已存在! inParam:[ " + inMap.toString() + " ]");
        }

        baseDao.insert("bal_grpuser_rel.insert", vge);

    }

    public void delVirtualDetail(String unitId, String phoneNo, long contractNo, long loginAccept) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("UNIT_ID", unitId);
        inMap.put("LOGIN_ACCEPT", loginAccept);
        inMap.put("PHONE_NO", phoneNo);
        inMap.put("CONTRACT_NO", contractNo);
        long count = (long) baseDao.queryForObject("bal_grppreinv_info.qryCount", inMap);
        if (count > 0) {
            throw new BusiException(AcctMgrError.getErrorCode("8293", "00008"), "虚拟集团该成员下有未回收发票,不允许删除! inParam:[ " + inMap.toString() + " ]");
        }

        // 删除成员表数据
        baseDao.insert("bal_grpuserrel_his.insert", inMap);
        baseDao.delete("bal_grpuser_rel.delete", inMap);

    }

    public List<PayCardEntity> getPayCardList(String cardSn, Long paySn, String loginNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();

        if (StringUtils.isEmptyOrNull(cardSn) && StringUtils.isEmptyOrNull(paySn) && StringUtils.isEmptyOrNull(loginNo)) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "00004"), "入参不能同时为空！");
        }

        if (StringUtils.isNotEmptyOrNull(cardSn)) {
            inMap.put("CARD_SN", cardSn);
        }

        if (paySn > 0 || StringUtils.isNotEmptyOrNull(paySn)) {
            inMap.put("PAY_SN", paySn);
        }

        if (StringUtils.isNotEmptyOrNull(loginNo)) {
            inMap.put("LOGIN_NO", loginNo);
        }

        List<PayCardEntity> resultList = (List<PayCardEntity>) baseDao.queryForList("bal_paycard_recd.qPaycard", inMap);
        return resultList;
    }

    @Override
    public List<PayCardEntity> getPayCardList(Map<String, Object> inMap) {
        List<PayCardEntity> resultList = (List<PayCardEntity>) baseDao.queryForList("bal_paycard_recd.qryByPayType", inMap);
        return resultList;
    }

    /* (non-Javadoc)
     *
     * @see com.sitech.acctmgr.atom.entity.inter.IRecord#getPayMentListByCust(long, int, int) */
    @Override
    public Map<String, Object> getPayMentListByCust(Map<String, Object> inParam) {
        Map<String, Object> outParam = new HashMap<String, Object>();
        List<Map<String, Object>> resultList = baseDao.queryForList("bal_payment_info.qBalPayMentByCust", inParam);
        if (resultList == null) {
            outParam.put("CNT", 0);
        } else {
            outParam.put("CNT", resultList.size());
        }
        outParam.put("PAYMENT_LIST", resultList);

        return outParam;
    }

    @Override
    public void saveGroupChargeRecd(Map<String, Object> inParam) {
        baseDao.insert("bal_groupcharge_recd.iGrpChargeRecd", inParam);
    }

    @Override
    public List<GroupChargeEntity> getGroupChargeRecdList(long grpCon) {
        List<GroupChargeEntity> outList = new ArrayList<GroupChargeEntity>();

        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("GROUP_CONTRACT_NO", grpCon);
        List<GroupChargeEntity> groupList = (List<GroupChargeEntity>) baseDao.queryForList("bal_groupcharge_recd.qryRecdList", inMapTmp);
        return groupList;
    }

    @Override
    public int delGroupChargeRecdByGrp(long grpCon) {
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("GROUP_CONTRACT_NO", grpCon);
        int delCnt = baseDao.delete("bal_groupcharge_recd.delRecdByGrpCon", inMapTmp);
        return delCnt;
    }

    @Override
    public void saveGroupChargeHis(Map<String, Object> inParam) {

        // 插入his表
        baseDao.insert("bal_groupcharge_his.iGrpErrByRecd", inParam);
        // 删除recd表
        baseDao.delete("bal_groupcharge_recd.delRecdByPhoneSn", inParam);
    }

    @Override
    public void saveGroupChargeErr(Map<String, Object> inParam) {

        // 插入his表
        baseDao.insert("bal_groupcharge_err.iGrpErrByRecd", inParam);
        // 删除recd表
        baseDao.delete("bal_groupcharge_recd.delRecdByPhoneSn", inParam);
    }

    @Override
    public List<GroupChargeEntity> getGroupChargeHisList(long grpCon, String beginTime, String endTime) {
        // TODO Auto-generated method stub
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("GROUP_CONTRACT_NO", grpCon);
        inMapTmp.put("BEGIN_TIME", beginTime);
        inMapTmp.put("END_TIME", endTime);

        List<GroupChargeEntity> groupList = baseDao.queryForList("bal_groupcharge_his.qryHisList", inMapTmp);

        return groupList;
    }

    @Override
    public List<GroupChargeEntity> getGroupChargeErrList(long grpCon, String beginTime, String endTime) {
        
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("GROUP_CONTRACT_NO", grpCon);
        inMapTmp.put("BEGIN_TIME", beginTime);
        inMapTmp.put("END_TIME", endTime);

        List<GroupChargeEntity> grouplist = baseDao.queryForList("bal_groupcharge_err.qryErrList", inMapTmp);

        return grouplist;
    }

    @Override
    public void saveHolidayUnStop(String phoneNo, Long idNo, String groupId, String regionCode, String creditClass) {

        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        int cnt = (Integer) baseDao.queryForObject("cct_avoidstop_info.qCnt", idNo);
        if (cnt > 0) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "90019"), "该用户已办理免停,无需再办理!");
        }

        // 取生失效时间
        /* 条件：星级+地市+假日开始时间－系统时间在3天之内+假日开始时间大于系统时间 */
        inMapTmp.put("REGION_CODE", regionCode);
        inMapTmp.put("CREDIT_CLASS", creditClass);
        UnStopHolidayEntity ushe = (UnStopHolidayEntity) baseDao.queryForObject("cct_unstopholiday_rel.qry", inMapTmp);
        if (ushe == null) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "90042"), "没有满足条件的配置数据!");
        }
        String effTime = ushe.getBeginTime();
        String expTime = ushe.getEndTime().substring(0, 10) + "5959";

        // 入结果表
        inMapTmp.put("PHONE_NO", phoneNo);
        inMapTmp.put("ID_NO", idNo);
        inMapTmp.put("GROUP_ID", groupId);
        inMapTmp.put("EFF_DATE", effTime);
        inMapTmp.put("EXP_DATE", expTime);
        inMapTmp.put("OP_NOTE", idNo);
        baseDao.insert("cct_avoidstop_info.insert", inMapTmp);
    }

    @Override
    public long getMonthTransFee(long contractNo) {
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CONTRACT_NO", contractNo);
        System.out.println(inMapTmp);
        long monthTransFee = (long) baseDao.queryForObject("bal_transfee_info.qSumMonthTransFee", inMapTmp);
        return monthTransFee;
    }

    @Override
    public List<BatchPayErrEntity> getBatchPayErr(Map<String, Object> inParam) {

        List<BatchPayErrEntity> resultList = (List<BatchPayErrEntity>) baseDao.queryForList("bal_extfee_err.qry", inParam);
        return resultList;
    }

    public Map<String, Object> getPosPayInfo(Map<String, Object> inMap) {

        return null;
    }

    @Override
    public TransFeeEntity getTransInfo(long transSn, int yearMonth) {
        Map<String, Object> inMap = new HashMap<>();
        inMap.put("TRANS_SN", transSn);
        inMap.put("SUFFIX", yearMonth);
        TransFeeEntity transFee = (TransFeeEntity) baseDao.queryForObject("bal_transfee_info.getTransInfo", inMap);
        return transFee;
    }

    @Override
    public Map<String, Object> getTransInfo(String phoneNoOut, int yearMonth, int pageNum) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("SUFFIX", yearMonth + "");
        inMap.put("PHONENO_OUT", phoneNoOut);
        inMap.put("STATUS", "0");
        List<TransFeeEntity> transFeeList = new ArrayList<TransFeeEntity>();
        if (pageNum == 0) {
            transFeeList = baseDao.queryForList("bal_transfee_info.getTransInfo", inMap);
        } else {
            Map<String, Object> outMapTmp = baseDao.queryForPagingList("bal_transfee_info.getTransInfo", inMap, pageNum, 70);
            transFeeList = (List<TransFeeEntity>) outMapTmp.get("result");
        }
        Map<String, Object> outMap = new HashMap<String, Object>();
        outMap.put("TRANS_FEE_LIST", transFeeList);
        outMap.put("SIZE", transFeeList.size());
        return outMap;
    }

    @Override
    public List<TransFeeEntity> getTransInfo(Map<String, Object> inMap) {
        List<TransFeeEntity> transFeeList = baseDao.queryForList("bal_transfee_info.getTransInfo", inMap);

        return transFeeList;
    }

    @Override
    public int getCntPayFlag(Map<String, Object> inMap) {
        return (Integer) baseDao.queryForObject("bal_payment_info.qryCountFlag", inMap);

    }

    public boolean isPreInv(long contractNo, Long loginAccept, Long invFee) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("CONTRACT_NO", contractNo);
        if (loginAccept != null) {
            inMap.put("LOGIN_ACCEPT", loginAccept);
        }
        if (invFee != null) {
            inMap.put("INV_FEE", invFee);
        }
        long count = (long) baseDao.queryForObject("bal_grppreinv_info.qryCount", inMap);
        if (count > 0) {

            return true;
        } else {

            return false;
        }

    }

    @Override
    public List<BatchpayInfoEntity> getBatchPayInfo(Long contractNo, Long idNo, Integer yearMonth) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("CONTRACT_NO", contractNo);
        inMap.put("YEAR_MONTH", yearMonth+"");
        inMap.put("ID_NO", idNo);
        List<BatchpayInfoEntity> resultList = (List<BatchpayInfoEntity>) baseDao.queryForList("bal_batchpay_info.qry", inMap);
        return resultList;
    }

    @Override
    public List<BatchpayInfoEntity> getBatchPayInfoByCon(long contractNo) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("CONTRACT_NO", contractNo);

        List<BatchpayInfoEntity> resultList = (List<BatchpayInfoEntity>) baseDao.queryForList("bal_batchpay_info.getBatchPayByContract", inMap);
        return resultList;
    }

    @Override
    public List<Map<String, Object>> getBatchPayByTime(Map<String, Object> inParam) {
        return baseDao.queryForList("bal_batchpay_info.getBatchPayByTime", inParam);
    }

    @Override
    public Map<String, Object> getPayedFee(Map<String, Object> inParam) {
        List<Map<String, Object>> outList = baseDao.queryForList("bal_presspayment_info.qCashPayInfo", inParam);
        Map<String, Object> outMap = new HashMap<String, Object>();
        if (outList.size() > 0) {
            outMap = outList.get(0);
        }
        return outMap;
    }

    @Override
    public void savePressPayMent(UserOweEntity oweInfo, String opCode, long payedOwe) {
        log.debug("savePayMent begin: " + oweInfo.toString());

		/* 入陈死账缴费记录表bal_presspayment_info */
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.putAll(oweInfo.toMap());
        inMapTmp.put("OP_CODE", opCode);
        inMapTmp.put("PAYED_OWE", payedOwe);
        baseDao.insert("bal_presspayment_info.iPressPayMent", inMapTmp);
    }

    @Override
    public Map<String, Object> queryPressPayMent(Map<String, Object> inParam) {
        List<Map<String, Object>> outList = baseDao.queryForList("bal_presspayment_info.qDeadPayInfo", inParam);
        Map<String, Object> outMap = new HashMap<String, Object>();
        if (outList.size() > 0) {
            outMap = outList.get(0);
        }
        return outMap;
    }

    @Override
    public void updatePressPayMent(Map<String, Object> inParam) {
        baseDao.update("bal_presspayment_info.uPressPayMent", inParam);
    }

    public long getSumPayFee(long contractNo, int yearMonth, String notOpCode, String notForeignSn) {

        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("CONTRACT_NO", contractNo);
        inMap.put("YEAR_MONTH", yearMonth);
        inMap.put("NOT_OP_CODE", notOpCode);
        inMap.put("NOT_FOREIGN_SN", notForeignSn);
        return (Long) baseDao.queryForObject("bal_payment_info.qSumPayfee", inMap);
    }

    @Override
    public List<UserChgRecdEntity> getUserChgRecd(long idNo, String yearMonth) {
        Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("ID_NO", idNo);
        inMap.put("SUFFIX", yearMonth);
        List<UserChgRecdEntity> resultList = (List<UserChgRecdEntity>) baseDao.queryForList("bal_userchg_recd.qryByOptime", inMap);
        return resultList;
    }

    public void savePayextend(PayUserBaseEntity payUserBase, PayBookEntity inBook, FieldEntity field ,Map<String, Object> header) {

        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CONTRACT_NO", payUserBase.getContractNo());
        inMapTmp.put("ID_NO", payUserBase.getIdNo());
        inMapTmp.put("PAY_SN", inBook.getPaySn());
        inMapTmp.put("FOREIGN_SN", inBook.getForeignSn());
        inMapTmp.put("OP_CODE", inBook.getOpCode());
        inMapTmp.put("LOGIN_NO", inBook.getLoginNo());
        inMapTmp.put("FIELD_CODE", field.getFieldCode());
        inMapTmp.put("FIELD_VALUE", field.getFieldValue());
        inMapTmp.put("FIELD_ORDER", "0");
        inMapTmp.put("YEAR_MONTH", inBook.getYearMonth());
        baseDao.insert("bal_payextend_info.ipayextend", inMapTmp);
        
        //同步报表库,按照PAY_SN FIELD_CODE同步
        List<Map<String, Object>> keysList = new ArrayList<Map<String, Object>>(); // 同步报表库数据List
        Map<String, Object> paymentKey = new HashMap<String, Object>();
        paymentKey.put("YEAR_MONTH", inBook.getYearMonth());
        paymentKey.put("PAY_SN", inBook.getPaySn());
        paymentKey.put("CONTRACT_NO", payUserBase.getContractNo());
		paymentKey.put("FIELD_CODE", field.getFieldCode());
		paymentKey.put("TABLE_NAME", "BAL_PAYEXTEND_INFO");
		paymentKey.put("UPDATE_TYPE", "I");
		keysList.add(paymentKey);
		
		Map<String, Object> reportMap = new HashMap<String, Object>();
		reportMap.put("ACTION_ID", "1018");
        reportMap.put("LOGIN_SN", inBook.getPaySn());
        reportMap.put("OP_CODE", inBook.getOpCode());
        reportMap.put("LOGIN_NO", inBook.getLoginNo());
        reportMap.put("KEYS_LIST", keysList);
        
        if (keysList != null && keysList.size() != 0) {
            preOrder.sendReportDataList(header, reportMap);
        }
        
    }

    public void updCollbillRecd(long contractNo, long billCycle, long loginAccept) {

        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CONTRACT_NO", contractNo);
        inMapTmp.put("LOGIN_ACCEPT", loginAccept);
        inMapTmp.put("BILL_CYCLE", billCycle);
        baseDao.update("act_collbill_recd.updBackFlagByAccept", inMapTmp);
    }

    @Override
    public void iSignPay(SignPayEntity signPay) {
        baseDao.insert("bal_signpay_info.iPay", signPay);
    }

    @Override
    public LoginOprEntity getLoginOpr(Map<String, Object> inMap) {
        LoginOprEntity loginOpr = (LoginOprEntity) baseDao.queryForObject("bal_loginopr_info.qLoginOpr", inMap);
        return loginOpr;
    }

    @Override
    public List<GrpRedEntity> getJtRedInfo(Map<String, Object> inMap) {

        List<GrpRedEntity> resultList = new ArrayList<GrpRedEntity>();
        String opType = inMap.get("OP_TYPE").toString();
        if (opType.equals("0")) {
            resultList = baseDao.queryForList("bal_transfee_info.qJtRedNet", inMap);
        } else if (opType.equals("2")) {
            resultList = baseDao.queryForList("bal_transfee_info.qJtRedErrNet", inMap);
        } else if (opType.equals("3")) {
            resultList = baseDao.queryForList("bal_transfee_info.qAllJtRedNet", inMap);
        }
        return resultList;
    }
    
    @Override
	public int getSmsSendCount(String phoneNo, int queryYM, String queryType, String opCode, String loginNo) {
    	Map<String, Object> inMap = new HashMap<String, Object>();
        inMap.put("YEAR_MONTH", queryYM);
        inMap.put("PHONE_NO", phoneNo);
        inMap.put("QUERY_TYPE", queryType);//gprs表示优惠推荐短信下发
        inMap.put("OP_CODE",opCode);
        inMap.put("LOGIN_NO", loginNo);
        int count = (Integer) baseDao.queryForObject("act_queryopr_info.qryCnt", inMap);
		return count;
	}
    
    @Override
    public int getJtRedInfoCount(Map<String, Object> inMap) {

        String opType = inMap.get("OP_TYPE").toString();
        int cnt=0;
        if (opType.equals("0")) {
            cnt = (int)baseDao.queryForObject("bal_transfee_info.qJtRedNetCnt", inMap);
        } else if (opType.equals("2")) {
        	cnt = (int)baseDao.queryForObject("bal_transfee_info.qJtRedErrNetCnt", inMap);
        } else if (opType.equals("3")) {
        	int cnt1=(int)baseDao.queryForObject("bal_transfee_info.qJtRedNetCnt", inMap);
        	int cnt2=(int)baseDao.queryForObject("bal_transfee_info.qJtRedErrNetCnt", inMap);
            cnt = cnt1+cnt2;
        }
        return cnt;
    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }

    public ILogin getLogin() {
        return login;
    }

    public void setLogin(ILogin login) {
        this.login = login;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

    public IPreOrder getPreOrder() {
        return preOrder;
    }

    public void setPreOrder(IPreOrder preOrder) {
        this.preOrder = preOrder;
    }

}
