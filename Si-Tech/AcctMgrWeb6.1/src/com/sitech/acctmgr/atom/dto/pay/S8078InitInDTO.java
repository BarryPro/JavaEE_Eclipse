package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8078InitInDTO extends CommonInDTO {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, desc = "统付账户", len = "14", type = "long", memo = "略")
    private long  contractNo;
	
	@Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        if (StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("contractNo")))){
			setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		}else {
			contractNo=0;
		}
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}
	
	
	
}
