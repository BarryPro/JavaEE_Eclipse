package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.bill.TDDataEntity;
import com.sitech.acctmgr.atom.dto.query.STdGprsQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.STdGprsQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.ITdGprs;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/22.
 */
@ParamTypes({@ParamType(c = STdGprsQueryInDTO.class, m = "query", oc = STdGprsQueryOutDTO.class)})
public class STdGprs extends AcctMgrBaseService implements ITdGprs {
    private IBill bill;

    @Override
    public OutDTO query(InDTO inParam){

        STdGprsQueryInDTO inDTO = (STdGprsQueryInDTO) inParam;

        TDDataEntity tdDataEnt = bill.getTdData(inDTO.getPhoneNo(), null);
        if (tdDataEnt == null) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "50007"), "该用户没有通过TD网络产生GPRS流量！");
        }

        STdGprsQueryOutDTO outDTO = new STdGprsQueryOutDTO();
        outDTO.setTdGprsData(tdDataEnt.getGprsData());

        return outDTO;

    }

    public IBill getBill() {
        return bill;
    }

    public void setBill(IBill bill) {
        this.bill = bill;
    }
}
