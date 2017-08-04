package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.text.ParseException;
import java.text.SimpleDateFormat;

@SuppressWarnings("serial")
public class S8123QryInDTO extends CommonInDTO {
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "40", desc = "服务号码", memo = "")
    private String phoneno;

    @ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, type = "string", len = "6", desc = "查询年月", memo = "")
    private int yearmonth;

    @ParamDesc(path = "BUSI_INFO.BUSI_CODE", cons = ConsType.CT001, type = "string", len = "1", desc = "业务代码", memo = "")
    private String busicode;

    @Override
    public void decode(MBean arg0) {

        super.decode(arg0);
        phoneno = arg0.getStr(getPathByProperName("phoneno"));
        yearmonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearmonth")));
        busicode = arg0.getStr(getPathByProperName("busicode"));

        if ("-1".equals(busicode)) {
            throw new BusiException(AcctMgrError.getErrorCode("8123", "00001"), "请输入正确的业务代码");
        }

        String queryMonth = arg0.getStr(getPathByProperName("yearmonth"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        try {
            sdf.parse(queryMonth);
        } catch (ParseException pe) {
            throw new BusiException(AcctMgrError.getErrorCode("8123", "00002"), "请输入正确的日期格式.格式为:YYYYMM");
        }
    }

    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String sPhoneNo) {
        this.phoneno = sPhoneNo;
    }

    public int getYearmonth() {
        return yearmonth;
    }

    public void setYearmonth(int yearmonth) {
        this.yearmonth = yearmonth;
    }

    public String getBusicode() {
        return busicode;
    }

    public void setBusicode(String busicode) {
        this.busicode = busicode;
    }
}
