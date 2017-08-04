package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.SevenBillDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class S8102QryBillDetailOutDTO extends CommonOutDTO {

    private static final long serialVersionUID = 4521280734848881591L;
    @ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "")
    private String phoneNo;
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "查询的帐户号码", memo = "")
    private long contractNo;
    @ParamDesc(path = "MAIN_PRC_NAME", cons = ConsType.CT001, type = "String", len = "120", desc = "用户主订价资费名称", memo = "")
    private String mainPrcName;
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, type = "int", len = "6", desc = "查询帐期", memo = "YYYYMM")
    private int yearMonth;
    @ParamDesc(path = "QUERY_TYPE", cons = ConsType.CT001, type = "String", len = "10", desc = "查询类型", memo = "")
    private String queryType;
    @ParamDesc(path = "TOTAL_SHOULD", cons = ConsType.CT001, type = "long", len = "20", desc = "总消费金额", memo = "单位：分")
    private long totalShould;
    @ParamDesc(path = "TOTAL_FAV", cons = ConsType.CT001, type = "long", len = "20", desc = "总优惠费", memo = "单位：分")
    private long totalFavFee;
    @ParamDesc(path = "TOTAL_REAL", cons = ConsType.CT001, type = "long", len = "20", desc = "总实收费", memo = "单位：分")
    private long totalRealFee;
    @ParamDesc(path = "TOTAL_OWE", cons = ConsType.CT001, type = "long", len = "20", desc = "总欠费", memo = "单位：分")
    private long totalOweFee;
    @ParamDesc(path = "FEE_INFO", cons = ConsType.PLUS, type = "complex", len = "1", desc = "账单列表", memo = "List类型")
    private List<SevenBillDispEntity> billInfoList;


    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("phoneNo"), phoneNo);
        result.setRoot(getPathByProperName("contractNo"), contractNo);
        result.setRoot(getPathByProperName("mainPrcName"), mainPrcName);
        result.setRoot(getPathByProperName("yearMonth"), yearMonth);
        result.setRoot(getPathByProperName("queryType"), queryType);
        result.setRoot(getPathByProperName("totalShould"), totalShould);
        result.setRoot(getPathByProperName("totalFavFee"), totalFavFee);
        result.setRoot(getPathByProperName("totalRealFee"), totalRealFee);
        result.setRoot(getPathByProperName("totalOweFee"), totalOweFee);
        result.setRoot(getPathByProperName("billInfoList"), billInfoList);
        return result;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public String getMainPrcName() {
        return mainPrcName;
    }

    public void setMainPrcName(String mainPrcName) {
        this.mainPrcName = mainPrcName;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public String getQueryType() {
        return queryType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    public long getTotalShould() {
        return totalShould;
    }

    public void setTotalShould(long totalShould) {
        this.totalShould = totalShould;
    }

    public long getTotalFavFee() {
        return totalFavFee;
    }

    public void setTotalFavFee(long totalFavFee) {
        this.totalFavFee = totalFavFee;
    }

    public long getTotalRealFee() {
        return totalRealFee;
    }

    public void setTotalRealFee(long totalRealFee) {
        this.totalRealFee = totalRealFee;
    }

    public long getTotalOweFee() {
        return totalOweFee;
    }

    public void setTotalOweFee(long totalOweFee) {
        this.totalOweFee = totalOweFee;
    }

    public List<SevenBillDispEntity> getBillInfoList() {
        return billInfoList;
    }

    public void setBillInfoList(List<SevenBillDispEntity> billInfoList) {
        this.billInfoList = billInfoList;
    }
}
