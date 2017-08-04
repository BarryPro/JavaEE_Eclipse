package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/5.
 */
public class SCollectionBillQueryInDTO extends CommonInDTO{
    private static final long serialVersionUID = -1L;

    @ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, desc = "托收账户", len = "18", type = "long", memo = "略")
    private long contractNo;
    
    @ParamDesc(path = "BUSI_INFO.QUERY_YM", cons = ConsType.CT001, desc = "查询年月", len = "6", type = "int", memo = "略")
    private int queryYm;
    
    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        contractNo = Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString());
        queryYm = Integer.parseInt(arg0.getObject(getPathByProperName("queryYm")).toString());
    }

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getQueryYm() {
		return queryYm;
	}

	public void setQueryYm(int queryYm) {
		this.queryYm = queryYm;
	}

    
}
