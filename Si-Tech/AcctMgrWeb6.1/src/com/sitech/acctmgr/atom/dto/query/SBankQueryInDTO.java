package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/7.
 */
public class SBankQueryInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.BANK_CODE", cons = ConsType.QUES, type = "String", len = "12", desc = "银行代码", memo = "略")
	private String bankCode;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("bankCode")))) {
			bankCode = arg0.getStr(getPathByProperName("bankCode"));
		}
    }

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

}
