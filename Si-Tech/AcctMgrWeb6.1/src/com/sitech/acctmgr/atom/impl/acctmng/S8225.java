/**
 *
 */
package com.sitech.acctmgr.atom.impl.acctmng;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.busi.collection.CollCode;
import com.sitech.acctmgr.atom.busi.collection.inter.ICollOrder;
import com.sitech.acctmgr.atom.domains.account.ConTrustEntity;
import com.sitech.acctmgr.atom.domains.bill.BillFeeInfo;
import com.sitech.acctmgr.atom.domains.collection.*;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.query.ExcelDataEntity;
import com.sitech.acctmgr.atom.domains.query.ExcelHeadEntity;
import com.sitech.acctmgr.atom.domains.query.ExcelListEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.*;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.acctmng.I8225;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * <p>Title: 托收管理</p>
 * <p>Description: 托收代码维护，托收清单、错单查询，托收单明细查询</p>
 * <p>Copyright: Copyright (c) 2015</p>
 * <p>Company: SI-TECH </p>
 *
 * @author wangyla
 * @version 1.0
 */

@ParamTypes({@ParamType(c = S8225QryCollBillInDTO.class, m = "qryCollBill", oc = S8225QryCollBillOutDTO.class),
        @ParamType(c = S8225QryCollBillByPhoneInDTO.class, m = "qryCollBillByPhone", oc = S8225QryCollBillByPhoneOutDTO.class),
        @ParamType(c = S8225QryCollBillByConInDTO.class, m = "qryCollBillByCon", oc = S8225QryCollBillByConOutDTO.class),
        @ParamType(c = S8225CollCodeInDTO.class, m = "collCodeOpr", oc = S8225CollCodeOutDTO.class),
        @ParamType(c = S8225CalCollBillInDTO.class, m = "calCollBill", oc = S8225CalCollBillOutDTO.class)
})
public class S8225 extends AcctMgrBaseService implements I8225 {
    private static final String SELECT_TYPE = "q";
    private static final String INSERT_TYPE = "a";
    private static final String UPDATE_TYPE = "u";
    private static final String DELETE_TYPE = "d";

    private IAccount account;
    private IGroup group;
    private ICollOrder collOrder;
    private IControl control;
    private IBill bill;
    private IUser user;
    private ICust cust;
    private IBillDisplayer billDisplayer;
    private IRecord record;
    private CollCode collCode;

    @Override
    public OutDTO qryCollBill(InDTO inParam) {

        S8225QryCollBillInDTO inDto = (S8225QryCollBillInDTO) inParam;
        log.info("inDto=" + inDto.getMbean());

        long contractNo = inDto.getContractNo();
        int billMonth = inDto.getBillCycle();
        String sOpType = inDto.getOpType();
        int pageSize = inDto.getPageSize();
        int pageNum = inDto.getPageNum() == 0 ? 1 : inDto.getPageNum();
        String qryType = inDto.getQryType(); // 1:查询托收月总体信息    2:查询托收账单列表信息

        ConTrustEntity bankInfo = account.getContrustInfo(contractNo);
        if (bankInfo == null) {
            throw new BusiException(AcctMgrError.getErrorCode("8225", "8006"),
                    "账户托收信息不存在!");
        }

        //获取托收月总体信息
        CollBillInfoEntity collBillInfo = new CollBillInfoEntity();
        if (qryType.equals("1")) { //1:查询总体信息
            collBillInfo = collOrder.getCollOrder(contractNo, billMonth, sOpType);
        }

        //获取托收账单列表信息
        int billCollCnt = 0;
        List<CollOweStatusGroupEntity> collBillList = new ArrayList<>();
        if (qryType.equals("2")) {
            //已冲销账单表历史表和年月表最小年月查询
            //获取托收账单列表总数
            billCollCnt = bill.getCollBillCnt(contractNo, billMonth);
            if (billCollCnt > 0) { //若不存在托收的帐单，则不需要再查询一次
                collBillList = bill.getConBillInfo(contractNo, billMonth, pageSize, pageNum);
            }
        }

        S8225QryCollBillOutDTO outDto = new S8225QryCollBillOutDTO();
        outDto.setCollBillInfo(collBillInfo);
        outDto.setCollBillList(collBillList);
        outDto.setCollBillCnt(billCollCnt);

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    @Override
    public OutDTO qryCollBillByPhone(InDTO inParam) {

        S8225QryCollBillByPhoneInDTO inDto = (S8225QryCollBillByPhoneInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        long contractNo = inDto.getContractNo();
        int billMonth = inDto.getBillCycle();
        String phoneNo = inDto.getPhoneNo();

        long custId = 0;
        long idNo = 0;
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
        if (userInfo == null) {
            List<UserDeadEntity> deadUserList = user.getUserdeadEntity(phoneNo, null, null);
            boolean hasRel = false;
            for (UserDeadEntity userDeadInfo : deadUserList) {
                int conCnt = account.cntConUserRel(contractNo, userDeadInfo.getIdNo(), billMonth);
                if (conCnt > 0) {
                    idNo = userDeadInfo.getIdNo();
                    custId = userDeadInfo.getCustId();
                    hasRel = true;
                    break;
                }
            }
            if (!hasRel) {
                throw new BusiException(AcctMgrError.getErrorCode("8225", "20001"), "用户与帐户不存在代付关系");
            }
        } else {
            idNo = userInfo.getIdNo();
            custId = userInfo.getCustId();
        }

        String custName = cust.getCustInfo(custId, null).getBlurCustName();//模糊化后的客户名称

        BillFeeInfo feeInfo = billDisplayer.getBillFee(idNo, billMonth);
        long totalFee = feeInfo.getTotalFee();
        long totalFavour = feeInfo.getFavourFee();

        List<CollPhoneBillDetailEntity> outList = new ArrayList<CollPhoneBillDetailEntity>();
        CollPhoneBillDetailEntity collDetailEnt = null;
        if (feeInfo.getFixedExp() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getFixedExp());
            collDetailEnt.setItemName("套餐及固定费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getCall() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getCall());
            collDetailEnt.setItemName("语音通信费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getMessage() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getMessage());
            collDetailEnt.setItemName("短彩信费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getVideoFee() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getVideoFee());
            collDetailEnt.setItemName("可视电话通信费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getNetPlay() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getNetPlay());
            collDetailEnt.setItemName("上网费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getValueAdded() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getValueAdded());
            collDetailEnt.setItemName("自有增值业务费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getGroupFee() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getGroupFee());
            collDetailEnt.setItemName("集团业务费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getGeneration() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getGeneration());
            collDetailEnt.setItemName("代收费业务费");
            outList.add(collDetailEnt);
        }
        if (feeInfo.getOtherExp() > 0) {
            collDetailEnt = new CollPhoneBillDetailEntity();
            collDetailEnt.setPhoneNo(phoneNo);
            collDetailEnt.setCustName(custName);
            collDetailEnt.setFee(feeInfo.getOtherExp());
            collDetailEnt.setItemName("其他费");
            outList.add(collDetailEnt);
        }

        S8225QryCollBillByPhoneOutDTO outDTO = new S8225QryCollBillByPhoneOutDTO();
        outDTO.setTotalFee(totalFee);
        outDTO.setTotalFavourFee(totalFavour);
        outDTO.setBillList(outList);

        if (log.isDebugEnabled()) {
            log.debug("outDto=" + outDTO.toJson());
        }

        return outDTO;
    }

    @Override
    public OutDTO qryCollBillByCon(InDTO inParam) {
        //获取入参
        S8225QryCollBillByConInDTO inDto = (S8225QryCollBillByConInDTO) inParam;
        log.info("inDto:" + inDto.getMbean());

        long contractNo = inDto.getContractNo();
        int billMonth = inDto.getBillCycle();

        // 获取托收月总体信息
        CollBillInfoEntity collOrderInfo = collOrder.getCollOrder(contractNo, billMonth, null);

        // 返出参数
        String payFeeTmp = String.format("%.2f", collOrderInfo.getPayFee() / 100.0);
        long payNum = collOrderInfo.getPayNum();
        String bankName = collOrderInfo.getBankName();
        String accountNo = collOrderInfo.getAccountNo();
        String codeValue = collOrderInfo.getCodeValue();
        String returnCode = collOrderInfo.getReturnCode();
        String contractName = collOrderInfo.getContractName();
        String regionName = collOrderInfo.getRegionName();

        List<CollOweStatusGroupEntity> collBillList = new ArrayList<>();
        collBillList = bill.getConBillInfo(contractNo, billMonth);

        List<ExcelListEntity> excelDataList = new ArrayList<ExcelListEntity>(); //excel表格每行数据列表
        List<ExcelDataEntity> excelList = new ArrayList<ExcelDataEntity>();  //excel数据列表
        ExcelDataEntity excelDataEnty = new ExcelDataEntity();   //excel数据实体
        for (CollOweStatusGroupEntity collBillEnty : collBillList) {
            String phoneNo = collBillEnty.getPhoneNo();
            String shouldPay = String.format("%.2f", collBillEnty.getShouldPay() / 100.0);
            String favourFee = String.format("%.2f", collBillEnty.getFavourFee() / 100.0);
            String payedPrepay = String.format("%.2f", collBillEnty.getPayedPrepay() / 100.0);
            String payedLater = String.format("%.2f", collBillEnty.getPayedLater() / 100.0);
            String statusName = collBillEnty.getStatusName().trim();

            //拼接excel表格出参
            ExcelListEntity excelColls = new ExcelListEntity();  //excel表格每行数据实体

            String colls = new StringBuilder().append(phoneNo).append("|")
                    .append(shouldPay).append("|")
                    .append(favourFee).append("|")
                    .append(payedPrepay).append("|")
                    .append(payedLater).append("|")
                    .append(statusName).toString();

            excelColls.setValue(colls);
            excelDataList.add(excelColls);
        }

        /*Excel表格构建*/
        String dfExNodeName = "ROOT/BODY/OUT_DATA/ATTR_LIST";
        String attrExcelName = "托收用户清单";
        String excelDataCols = "6";
        String excelSheetName = "用户清单";

        //获取excel表头
        Map<String, Object> inHearMap = new HashMap<String, Object>();
        inHearMap.put("CONTRACT_NO", contractNo);
        inHearMap.put("BILL_CYCLE", billMonth);
        inHearMap.put("REGION_NAME", regionName);
        inHearMap.put("PAY_FEE", payFeeTmp);
        inHearMap.put("PAY_NUM", payNum);
        inHearMap.put("BANK_NAME", bankName);
        inHearMap.put("ACCOUNT_NO", accountNo);
        inHearMap.put("CODE_VALUE", codeValue);
        inHearMap.put("RETURN_CODE", returnCode);
        inHearMap.put("CONTRACT_NAME", contractName);
        List<List<ExcelHeadEntity>> excelHead = this.getExcelHead(inHearMap);
        /*表头实体及其列表*/

        excelDataEnty.setExcelDataCols(excelDataCols);
        excelDataEnty.setExcelDataList(excelDataList);
        excelDataEnty.setExcelSheetName(excelSheetName);
        excelDataEnty.setExcelHeadList(excelHead);
        excelList.add(excelDataEnty);

        S8225QryCollBillByConOutDTO outDto = new S8225QryCollBillByConOutDTO();

        outDto.setDfExNodeName(dfExNodeName);
        outDto.setAttrExcelName(attrExcelName);
        outDto.setExcelList(excelList);

        if (log.isDebugEnabled()) {
            log.debug("outDto:" + outDto.toJson());
        }

        return outDto;
    }

    List<List<ExcelHeadEntity>> getExcelHead(Map<String, Object> inHearMap) {
        List<List<ExcelHeadEntity>> excelHead = new ArrayList<List<ExcelHeadEntity>>();

        List<ExcelHeadEntity> excelHeadList = new ArrayList<ExcelHeadEntity>();  //表头最后一行
        List<ExcelHeadEntity> excelHeadList1 = new ArrayList<ExcelHeadEntity>(); //表头第一行
        List<ExcelHeadEntity> excelHeadList2 = new ArrayList<ExcelHeadEntity>(); //表头第二行
        List<ExcelHeadEntity> excelHeadList3 = new ArrayList<ExcelHeadEntity>(); //表头第三行
        List<ExcelHeadEntity> excelHeadList4 = new ArrayList<ExcelHeadEntity>(); //表头第四行
        ExcelHeadEntity excelHeadEnty = null;
        //表头第一行设置
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("合同号码：");
        excelHeadList1.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("CONTRACT_NO").toString());
        excelHeadList1.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("出帐月份：");
        excelHeadList1.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("BILL_CYCLE").toString());
        excelHeadList1.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("托收金额：");
        excelHeadList1.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("PAY_FEE").toString());
        excelHeadList1.add(excelHeadEnty);
        excelHead.add(excelHeadList1);

        // 表头第二行设置
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("号码数量：");
        excelHeadList2.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("PAY_NUM").toString());
        excelHeadList2.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("托收银行：");
        excelHeadList2.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("BANK_NAME").toString());
        excelHeadList2.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("银行帐号：");
        excelHeadList2.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("ACCOUNT_NO").toString());
        excelHeadList2.add(excelHeadEnty);
        excelHead.add(excelHeadList2);

        // 表头第三行设置
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("客户名称：");
        excelHeadList3.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("CONTRACT_NAME").toString());
        excelHeadList3.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("归属地区：");
        excelHeadList3.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("REGION_NAME").toString());
        excelHeadList3.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("处理状态：");
        excelHeadList3.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue(inHearMap.get("CODE_VALUE").toString());
        excelHeadList3.add(excelHeadEnty);
        excelHead.add(excelHeadList3);

        // 表头第三行设置
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("1");
        excelHeadEnty.setValue("返回代码：");
        excelHeadList4.add(excelHeadEnty);
        excelHeadEnty = new ExcelHeadEntity();
        excelHeadEnty.setCols("5");
        excelHeadEnty.setValue(inHearMap.get("RETURN_CODE").toString());
        excelHeadList4.add(excelHeadEnty);
        excelHead.add(excelHeadList4);

        //表头最后一行设置
        ExcelHeadEntity excelHeadEnty1 = new ExcelHeadEntity();
        ExcelHeadEntity excelHeadEnty2 = new ExcelHeadEntity();
        ExcelHeadEntity excelHeadEnty3 = new ExcelHeadEntity();
        ExcelHeadEntity excelHeadEnty4 = new ExcelHeadEntity();
        ExcelHeadEntity excelHeadEnty5 = new ExcelHeadEntity();
        ExcelHeadEntity excelHeadEnty6 = new ExcelHeadEntity();
        excelHeadEnty1.setCols("1");
        excelHeadEnty1.setValue("服务号码");
        excelHeadList.add(excelHeadEnty1);
        excelHeadEnty2.setCols("1");
        excelHeadEnty2.setValue("应收（元）");
        excelHeadList.add(excelHeadEnty2);
        excelHeadEnty3.setCols("1");
        excelHeadEnty3.setValue("优惠（元）");
        excelHeadList.add(excelHeadEnty3);
        excelHeadEnty4.setCols("1");
        excelHeadEnty4.setValue("已划拨（元）");
        excelHeadList.add(excelHeadEnty4);
        excelHeadEnty5.setCols("1");
        excelHeadEnty5.setValue("新缴费（元）");
        excelHeadList.add(excelHeadEnty5);
        excelHeadEnty6.setCols("1");
        excelHeadEnty6.setValue("状态");
        excelHeadList.add(excelHeadEnty6);
        excelHead.add(excelHeadList);

        return excelHead;
    }

    @Override
    public OutDTO collCodeOpr(InDTO inParam) {

        S8225CollCodeInDTO inDto = (S8225CollCodeInDTO) inParam;
        log.info("inDto=" + inDto.getMbean());

        Map<String, Object> inMapTmp = null;
        CollCodeEntity outCollCode = null;

        String sGroupId = inDto.getGroupId();
        String sOpType = inDto.getOpType();

        long lLoginAccept = control.getSequence("SEQ_SYSTEM_SN");

		/* 取当前年月和当前时间 */
        String sTotaldate = String.format("%8d", DateUtils.getCurDay());

        List<CollCodeEntity> outMapListQry = null;//出参列表
        // s3:验证工号归属，省级及全国工号不参与操作
        String sRegionCode = "";
        if (!this.isProvOrNationLogin(sGroupId, inDto.getProvinceId())) {
            // s4: 获取工号归属的地市级代码region_id
            sRegionCode = group.getRegionDistinct(sGroupId, "2", inDto.getProvinceId()).getRegionCode();

            // s5: 按操作类型执行相应的操作
            if (sOpType.equals(SELECT_TYPE)) {// 托收代码查询
                outMapListQry = new ArrayList<CollCodeEntity>();//出参列表
                List<PubCodeDictEntity> codeList = collCode.getCode(sRegionCode);

                for (PubCodeDictEntity codeMapTmp : codeList) {
                    outCollCode = new CollCodeEntity();
                    outCollCode.setCodeId(codeMapTmp.getCodeId());
                    outCollCode.setCodeValue(codeMapTmp.getCodeValue());
                    outCollCode.setStatus(codeMapTmp.getStatus());
                    outCollCode.setCodeName(codeMapTmp.getCodeComp());
                    outMapListQry.add(outCollCode);
                }

            } else if (sOpType.equals(INSERT_TYPE)) {
                inMapTmp = new HashMap<String, Object>();
                inMapTmp.put("CODE_ID", inDto.getCodeId());
                inMapTmp.put("GROUP_ID", sRegionCode);
                inMapTmp.put("CODE_VALUE", inDto.getCodeValue());
                inMapTmp.put("STATUS", inDto.getCollStatus());
                inMapTmp.put("BEGIN_TIME", sTotaldate);
                inMapTmp.put("LOGIN_NO", inDto.getLoginNo());

                collCode.saveCode(inMapTmp);
            } else if (sOpType.equals(UPDATE_TYPE)) {
                collCode.updateCode(sRegionCode, inDto.getCodeId(),
                        inDto.getCodeValue(), inDto.getCollStatus());

            } else if (sOpType.equals(DELETE_TYPE)) {
                collCode.removeCode(sRegionCode, inDto.getCodeId());
            }

            if (!sOpType.equals(SELECT_TYPE)) {
                LoginOprEntity loe = new LoginOprEntity();
                loe.setLoginSn(lLoginAccept);
                loe.setLoginNo(inDto.getLoginNo());
                loe.setLoginGroup(inDto.getGroupId());
                loe.setTotalDate(0);
                loe.setIdNo(0);
                loe.setPhoneNo("");
                loe.setBrandId("00");
                loe.setPayType("0");
                loe.setPayFee(0);
                loe.setOpCode("8225");
                loe.setRemark("托收代码维护");
                record.saveLoginOpr(loe);
            }
        }

        // s7: 准备出参数据
        S8225CollCodeOutDTO outDto = new S8225CollCodeOutDTO();
        outDto.setCollCodeList(outMapListQry);
        return outDto;
    }

    @Override
    public OutDTO calCollBill(InDTO inParam) {
        S8225CalCollBillInDTO inDTO = (S8225CalCollBillInDTO)inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String sLoginGroupId = inDTO.getGroupId();

        //获取工号地市归属代码
        String sRegionCode = group.getRegionDistinct(sLoginGroupId, "2", inDTO.getProvinceId()).getRegionCode();

        //获取托收状态清单明细信息
        Map<String, Object> inMapTmp = new HashMap<String, Object>();
        safeAddToMap(inMapTmp, "REGION_ID", sRegionCode);
        safeAddToMap(inMapTmp, "BILL_CYCLE", inDTO.getBillCycle());
        safeAddToMap(inMapTmp, "BEGIN_CONTRACT_NO", inDTO.getBeginContractNo());
        safeAddToMap(inMapTmp, "END_CONTRACT_NO", inDTO.getEndContractNo());
        if (StringUtils.isNotEmptyOrNull(inDTO.getCollCode())) {
            safeAddToMap(inMapTmp, "RETURN_CODE", inDTO.getCollCode());
        }
        if (StringUtils.isNotEmptyOrNull(inDTO.getDisGroupId())) {
            safeAddToMap(inMapTmp, "DIS_GROUP_ID", inDTO.getDisGroupId());
        }
        List<CollBillDetailEntity> disDetailList = collOrder.getCollOrderByDis(inMapTmp);

        //合计明细信息
        long lSumDetailPayFee = 0; //托收费用总合，返回明细
        int	iSumDetailPayNum = 0; //托收用户总个数
        List<CollBillDetailEntity> disDetailListOut = new ArrayList<CollBillDetailEntity>();
        for (CollBillDetailEntity disDetailTmpMap : disDetailList) {
            iSumDetailPayNum = iSumDetailPayNum + disDetailTmpMap.getPayNum();
            lSumDetailPayFee = lSumDetailPayFee + disDetailTmpMap.getPayFee();

            String jsonStr = JSON.toJSONString(disDetailTmpMap);
            disDetailListOut.add(JSON.parseObject(jsonStr, CollBillDetailEntity.class));

        }
        log.debug("明细合计 sumPayNum =[" + iSumDetailPayNum +"], sumPayFee=[" + lSumDetailPayFee +"]");

        //获取托收状态清单统计信息
        inMapTmp = new HashMap<String, Object>();
        safeAddToMap(inMapTmp, "REGION_ID", sRegionCode);
        safeAddToMap(inMapTmp, "BILL_CYCLE", inDTO.getBillCycle());
        safeAddToMap(inMapTmp, "BEGIN_CONTRACT_NO", inDTO.getBeginContractNo());
        safeAddToMap(inMapTmp, "END_CONTRACT_NO", inDTO.getEndContractNo());
        if (StringUtils.isNotEmptyOrNull(inDTO.getCollCode())) {
            safeAddToMap(inMapTmp, "RETURN_CODE", inDTO.getCollCode());
        }
        if (StringUtils.isNotEmptyOrNull(inDTO.getDisGroupId())) {
            safeAddToMap(inMapTmp, "DIS_GROUP_ID", inDTO.getDisGroupId());
        }
        List<CollBillStatusGroupEntity> disGroupList = collOrder.getDisBillGroupByName(inMapTmp);
        //合计按托收状态统计托收清单信息
        long lSumGroupPayFee = 0; //托收费用总合，按返回名称分组
        int iSumGroupNum = 0;		//托收帐户总个数
        List<CollBillStatusGroupEntity> disGroupListOut = new ArrayList<CollBillStatusGroupEntity>();
        for (CollBillStatusGroupEntity disGroupTmpMap : disGroupList) {
            iSumGroupNum = iSumGroupNum + disGroupTmpMap.getConNums();
            lSumGroupPayFee = lSumGroupPayFee + disGroupTmpMap.getSumPayFee();

            String jsonStr = JSON.toJSONString(disGroupTmpMap);
            disGroupListOut.add(JSON.parseObject(jsonStr, CollBillStatusGroupEntity.class));
        }
        log.debug("分组合计 托收总帐户数sumConNum =[" + iSumGroupNum +"], sumPayFee=[" + lSumGroupPayFee +"]");

        S8225CalCollBillOutDTO outDTO = new S8225CalCollBillOutDTO();
        //托收状态明细
        outDTO.setDetailList(disDetailListOut);
        outDTO.setSumPayNum(iSumDetailPayNum);
        outDTO.setSumDetailPayFee(lSumDetailPayFee);

        //托收状态统计
        outDTO.setGroupList(disGroupListOut);
        outDTO.setSumConNum(iSumGroupNum);
        outDTO.setSumGroupPayFee(lSumGroupPayFee);

        log.info("outDto=" + outDTO.toJson());

        return outDTO;
    }

    private boolean isProvOrNationLogin(String groupId, String provinceId) {
        int iCurrLevel = 0;
        iCurrLevel = group.getCurrentLevel(groupId, provinceId);

        if (iCurrLevel > 1) {
            return false;
        } else {
            return true;
        }
    }


    public IAccount getAccount() {
        return account;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }

    public ICollOrder getCollOrder() {
        return collOrder;
    }

    public void setCollOrder(ICollOrder collOrder) {
        this.collOrder = collOrder;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public ICust getCust() {
        return cust;
    }

    public void setCust(ICust cust) {
        this.cust = cust;
    }

    public IBillDisplayer getBillDisplayer() {
        return billDisplayer;
    }

    public void setBillDisplayer(IBillDisplayer billDisplayer) {
        this.billDisplayer = billDisplayer;
    }

    public IRecord getRecord() {
        return record;
    }

    public void setRecord(IRecord record) {
        this.record = record;
    }

    public CollCode getCollCode() {
        return collCode;
    }

    public void setCollCode(CollCode collCode) {
        this.collCode = collCode;
    }
}
