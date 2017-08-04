package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.BillDisp1LevelEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/6/29.
 */
public class S8164QryOutBillInfo extends CommonOutDTO {

    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", type = "String", desc = "客户号码", memo = "")
    private String phoneNo;
    @ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, len = "60", type = "String", desc = "客户名称", memo = "")
    private String custName;
    @ParamDesc(path = "BRAND_NAME", cons = ConsType.CT001, len = "8", type = "String", desc = "品牌名称", memo = "")
    private String brandName;
    @ParamDesc(path = "BILL_RANGE", cons = ConsType.CT001, len = "60", type = "String", desc = "计费周期", memo = "")
    private String billRange;
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "40", type = "long", desc = "帐户号码", memo = "未明确涵义，需要再确认")
    private long contractNo;

    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "8", type = "long", desc = "应收总和", memo = "")
    private long shouldPay;
    @ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "优惠总和", memo = "")
    private long favourFee;
    @ParamDesc(path = "REAL_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "实收总和", memo = "")
    private long realFee;
    @ParamDesc(path = "DETAIL_1_LIST", cons = ConsType.CT001, len = "", type = "complex", desc = "一级帐目项帐单明细", memo = "")
    private List<BillDisp1LevelEntity> detailList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("shouldPay"),shouldPay);
        result.setRoot(getPathByProperName("favourFee"),favourFee);
        result.setRoot(getPathByProperName("realFee"),realFee);

        result.setRoot(getPathByProperName("phoneNo"),phoneNo);
        result.setRoot(getPathByProperName("custName"),custName);
        result.setRoot(getPathByProperName("brandName"),brandName);
        result.setRoot(getPathByProperName("billRange"),billRange);
        result.setRoot(getPathByProperName("contractNo"),contractNo);
        result.setRoot(getPathByProperName("detailList"),detailList);

        return result;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getBillRange() {
        return billRange;
    }

    public void setBillRange(String billRange) {
        this.billRange = billRange;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public long getShouldPay() {
        return shouldPay;
    }

    public void setShouldPay(long shouldPay) {
        this.shouldPay = shouldPay;
    }

    public long getFavourFee() {
        return favourFee;
    }

    public void setFavourFee(long favourFee) {
        this.favourFee = favourFee;
    }

    public long getRealFee() {
        return realFee;
    }

    public void setRealFee(long realFee) {
        this.realFee = realFee;
    }

    public List<BillDisp1LevelEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<BillDisp1LevelEntity> detailList) {
        this.detailList = detailList;
    }
}
