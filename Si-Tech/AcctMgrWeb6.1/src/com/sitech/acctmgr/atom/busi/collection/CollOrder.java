package com.sitech.acctmgr.atom.busi.collection;

import com.sitech.acctmgr.atom.busi.collection.inter.ICollOrder;
import com.sitech.acctmgr.atom.domains.account.ConTrustEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.collection.*;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.jcf.core.exception.BusiException;

import java.util.List;
import java.util.Map;
@SuppressWarnings("unchecked")
public class CollOrder extends BaseBusi implements ICollOrder {

    private IAccount account;
    private IBase base;
    private IControl control;
    private IGroup group;
    private IBill bill;

    /**
     * <p>
     * Description: 获取托收单总表信息
     * </p>
     *
     * @param contractNo 帐户号码
     * @param yearMonth  托收账期
     * @param inFlag     查询类型 NORMAL：用户清单 ERROR：托收错单
     * @return 出参<br/>
     * CONTRACT_NO 帐户号码 <br/>
     * BILL_CYCLE 托收账期 <br/>
     * PAY_FEE 托收金额 <br/>
     * PAY_NUM 托收用户个数 <br/>
     * DEAL_FLAG 处理标志 0：未处理 1：已处理 <br/>
     * DEAL_NAME 处理状态名称 <br/>
     * BANK_CODE 托收银行代码<br/>
     * BANK_NAME 托收银行名称 <br/>
     * CONTRACT_NAME 帐户名称<br/>
     * REGION_NAME 帐户归属地市名称<br/>
     * ACCOUNT_NO 托收银行账户 <br/>
     * RETURN_CODE 托收返回代码 <br/>
     * CODE_VALUE 托收返回代码名称<br/>
     * COLL_GROUP_ID 托收机构代码<br/>
     */
    @Override
    public CollBillInfoEntity getCollOrder(long contractNo, int yearMonth, String inFlag) {

        String errorFlag = null;
        if (inFlag != null && inFlag.equals("ERROR")) {
            errorFlag = CommonConst.COLL_ERROR_YES;
        }
        CollectionBillEntity billInfo = bill.getCollectionBill(contractNo, yearMonth, null, null, errorFlag);
        if (billInfo == null) {
            throw new BusiException(AcctMgrError.getErrorCode("8225", "80004"), "托收单不存在或已经处理!");
        }

        long payNum = billInfo.getPayNum();
        String dealFlag = billInfo.getDealFlag();
        String collCode = billInfo.getReturnCode();
        String dealName = dealFlag.equals("1") ? "已处理" : "未处理";

        // 获取托收帐户信息
        ConTrustEntity conTrustInfo = account.getContrustInfo(contractNo);
        if (conTrustInfo == null) {
            throw new BusiException(AcctMgrError.getErrorCode("8225", "80005"), "托收帐户银行信息不存在!");
        }

        /*获取托收帐户归属地市名称*/
        ContractInfoEntity conInfo = account.getConInfo(contractNo);
        String conGroupId = conInfo.getGroupId();
        ChngroupRelEntity regionInfo = group.getRegionDistinct(conGroupId, "2", control.getProvinceId(contractNo));
        String regionName = regionInfo.getRegionName();
        String regionId = regionInfo.getRegionCode();

        String bankName = base.getBankInfo(conGroupId, control.getProvinceId(contractNo), conTrustInfo.getBankCode()).getBankName();
        conTrustInfo.setBankName(bankName);

        // 取托收代码名称
        String codeValue = control.getPubCodeValue(1003, collCode, regionId); //collretname

        CollBillInfoEntity collBillInfo = new CollBillInfoEntity();
        collBillInfo.setContractNo(contractNo);
        collBillInfo.setBillCycle(yearMonth);
        collBillInfo.setPayFee(billInfo.getPayFee());
        collBillInfo.setPayNum(payNum); //托收用户个数
        collBillInfo.setDealFlag(dealFlag);
        collBillInfo.setDealName(dealName);
        collBillInfo.setBankCode(conTrustInfo.getBankCode());
        collBillInfo.setBankName(conTrustInfo.getBankName());
        collBillInfo.setRegionName(regionName);
        collBillInfo.setContractName(conInfo.getBlurContractName());
        collBillInfo.setAccountNo(conTrustInfo.getAccountNo()); // 托收银行帐户
        collBillInfo.setReturnCode(collCode);
        collBillInfo.setCodeValue(codeValue);
        collBillInfo.setCollGroupId(billInfo.getGroupId());

        return collBillInfo;
    }

    /**
     * @param inParam <br/>
     *                REGION_ID 归属地市行政代码 <br/>
     *                BILL_CYCLE 查询帐期 <br/>
     *                BEGIN_CONTRACT_NO 帐户开始号段，可不传 <br/>
     *                END_CONTRACT_NO 帐户结束号段，可不传 <br/>
     *                RETURN_CODE 托收返回代码，可不传，则查询全部 <br/>
     *                DIS_GROUP_ID 区县归属组织机构代码，可不传，则查询全地市<br/>
     * @return LIST<br/>
     * CONTRACT_NO 托收帐户号码<br/>
     * RETURN_CODE 托收返回代码<br/>
     * COLL_NAME 托收状态<br/>
     * PAY_NUM 托收用户数<br/>
     * PAY_FEE 托收金额<br/>
     * BILL_CYCLE 托收帐期<br/>
     */
    @Override
    public List<CollBillDetailEntity> getCollOrderByDis(
            Map<String, Object> inParam) {
        List<CollBillDetailEntity> result = (List<CollBillDetailEntity>)baseDao.queryForList("act_collbill_info.qCollBillByDisCode", inParam);
        return result;
    }

    /**
     * @param inParam <br/>
     *                REGION_ID 归属地市行政代码 <br/>
     *                BILL_CYCLE 查询帐期 <br/>
     *                BEGIN_CONTRACT_NO 帐户开始号段，可不传 <br/>
     *                END_CONTRACT_NO 帐户结束号段，可不传 <br/>
     *                RETURN_CODE 托收返回代码，可不传，则查询全部 <br/>
     *                DIS_GROUP_ID 区县归属组织机构代码，可不传，则查询全地市<br/>
     * @return LIST<br/>
     * RETURN_CODE 托收返回代码<br/>
     * COLL_NAME 托收状态<br/>
     * CON_NUMS 托收帐户数<br/>
     * PAY_FEE 托收金额<br/>
     */
    @Override
    public List<CollBillStatusGroupEntity> getDisBillGroupByName(
            Map<String, Object> inParam) {
        List<CollBillStatusGroupEntity> result = (List<CollBillStatusGroupEntity>)
                baseDao.queryForList("act_collbill_info.qDisBillGroupByName", inParam);
        return result;
    }


    public IAccount getAccount() {
        return account;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }

    public IBase getBase() {
        return base;
    }

    public void setBase(IBase base) {
        this.base = base;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

    public IGroup getGroup() {
        return group;
    }

    public void setGroup(IGroup group) {
        this.group = group;
    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }
}
