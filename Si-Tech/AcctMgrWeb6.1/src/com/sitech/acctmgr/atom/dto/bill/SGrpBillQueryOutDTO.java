package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.atom.domains.bill.GrpBillDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/11/23.
 */
public class SGrpBillQueryOutDTO extends CommonOutDTO {
    @ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "string", len = "64", desc = "集团客户名称", memo = "")
    private String custName;

    @ParamDesc(path = "UNIT_ID", cons = ConsType.CT001, type = "long", len = "14", desc = "集团编码", memo = "")
    private long unitId;

    @ParamDesc(path = "BILL_RANGE", cons = ConsType.CT001, type = "String", len = "40", desc = "计费周期", memo = "")
    private String billRange;

    @ParamDesc(path = "PRINT_DATE", cons = ConsType.CT001, type = "String", len = "40", desc = "打印日期", memo = "")
    private String printDate;

    @ParamDesc(path = "MANAGER_NAME", cons = ConsType.CT001, type = "string", len = "64", desc = "客户经理姓名", memo = "")
    private String managerName;

    @ParamDesc(path = "MANAGER_PHONE", cons = ConsType.CT001, type = "string", len = "40", desc = "客户经理电话", memo = "")
    private String managerPhone;

    @ParamDesc(path = "TOTAL_REAL", cons = ConsType.CT001, type = "long", len = "14", desc = "集团产品费用总和", memo = "单位：分")
    private long totalReal;

    @ParamDesc(path = "BILL_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "集团按产品展示账单列表", memo = "")
    private List<GrpBillDispEntity> billList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("custName"), custName);
        result.setRoot(getPathByProperName("unitId"), unitId);
        result.setRoot(getPathByProperName("billRange"), billRange);
        result.setRoot(getPathByProperName("printDate"), printDate);
        result.setRoot(getPathByProperName("managerName"), managerName);
        result.setRoot(getPathByProperName("managerPhone"), managerPhone);
        result.setRoot(getPathByProperName("totalReal"), totalReal);
        result.setRoot(getPathByProperName("billList"), billList);
        return result;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public long getUnitId() {
        return unitId;
    }

    public void setUnitId(long unitId) {
        this.unitId = unitId;
    }

    public String getBillRange() {
        return billRange;
    }

    public void setBillRange(String billRange) {
        this.billRange = billRange;
    }

    public String getPrintDate() {
        return printDate;
    }

    public void setPrintDate(String printDate) {
        this.printDate = printDate;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone;
    }

    public long getTotalReal() {
        return totalReal;
    }

    public void setTotalReal(long totalReal) {
        this.totalReal = totalReal;
    }

    public List<GrpBillDispEntity> getBillList() {
        return billList;
    }

    public void setBillList(List<GrpBillDispEntity> billList) {
        this.billList = billList;
    }
}
