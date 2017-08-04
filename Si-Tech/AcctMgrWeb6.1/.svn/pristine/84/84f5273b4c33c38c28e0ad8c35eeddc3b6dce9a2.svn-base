package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/7.
 */
public class SCollectionFileCreateInDTO extends CommonInDTO {

    @ParamDesc(path = "BUSI_INFO.BEG_CONTRACT", cons = ConsType.CT001, len = "6", type = "int", desc = "开始合同", memo = "托收帐户号码")
    private long begContract;

    @ParamDesc(path = "BUSI_INFO.END_CONTRACT", cons = ConsType.CT001, len = "6", type = "int", desc = "结束合同", memo = "托收帐户号码")
    private long endContract;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, len = "6", type = "int", desc = "托收帐期", memo = "格式：YYYYMM")
    private int yearMonth;

    @ParamDesc(path = "BUSI_INFO.POST_BANK_CODE", cons = ConsType.CT001, len = "6", type = "String", desc = "局方托收银行", memo = "")
    private String postBankCode;

    @ParamDesc(path = "BUSI_INFO.OPER_TYPE", cons = ConsType.CT001, len = "5", type = "String", desc = "费用代码", memo = "")
    private String operType;

    @ParamDesc(path = "BUSI_INFO.ENTER_CODE", cons = ConsType.CT001, len = "5", type = "String", desc = "企业代码", memo = "")
    private String enterCode;

    @ParamDesc(path = "BUSI_INFO.DISTRICT_CODE", cons = ConsType.CT001, len = "20", type = "String", desc = "区县代码", memo = "")
    private String districtCode;
    

	@Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        
        begContract = Long.parseLong(arg0.getStr(getPathByProperName("begContract")));
        endContract = Long.parseLong(arg0.getStr(getPathByProperName("endContract")));
        yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
        postBankCode = arg0.getStr(getPathByProperName("postBankCode"));
        operType = arg0.getStr(getPathByProperName("operType"));
        enterCode = arg0.getStr(getPathByProperName("enterCode"));
        districtCode = arg0.getStr(getPathByProperName("districtCode"));

    }

    public long getBegContract() {
        return begContract;
    }

    public void setBegContract(long begContract) {
        this.begContract = begContract;
    }

    public long getEndContract() {
        return endContract;
    }

    public void setEndContract(long endContract) {
        this.endContract = endContract;
    }

    public int getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(int yearMonth) {
        this.yearMonth = yearMonth;
    }

    public String getPostBankCode() {
        return postBankCode;
    }

    public void setPostBankCode(String postBankCode) {
        this.postBankCode = postBankCode;
    }

    public String getOperType() {
        return operType;
    }

    public void setOperType(String operType) {
        this.operType = operType;
    }

    public String getEnterCode() {
        return enterCode;
    }

    public void setEnterCode(String enterCode) {
        this.enterCode = enterCode;
    }

	public String getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}
    
    
    
}
