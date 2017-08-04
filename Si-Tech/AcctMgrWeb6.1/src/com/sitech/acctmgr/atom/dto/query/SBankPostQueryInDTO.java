package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2017/1/9.
 */
public class SBankPostQueryInDTO extends CommonInDTO{
    @ParamDesc(path="BUSI_INFO.POST_BANK_CODE",cons= ConsType.QUES,type="String",len="12",desc="局方托收银行代码",memo="略")
    private String postBankCode;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("postBankCode")))) {
            postBankCode = arg0.getStr(getPathByProperName("postBankCode"));
        }
    }

    public String getPostBankCode() {
        return postBankCode;
    }

    public void setPostBankCode(String postBankCode) {
        this.postBankCode = postBankCode;
    }
}
