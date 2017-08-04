package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.atom.domains.base.BankEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2017/1/9.
 */
public class SBankPostQueryOutDTO extends CommonOutDTO{
    @ParamDesc(path="BANK_LIST",cons= ConsType.STAR,type="compx",len="18",desc="账户ID",memo="略")
    private List<BankEntity> bankList;

    @Override
    public MBean encode() {
        MBean result=super.encode();
        result.setRoot(getPathByProperName("bankList"),bankList);
        return result;
    }

    public List<BankEntity> getBankList() {
        return bankList;
    }

    public void setBankList(List<BankEntity> bankList) {
        this.bankList = bankList;
    }

}
