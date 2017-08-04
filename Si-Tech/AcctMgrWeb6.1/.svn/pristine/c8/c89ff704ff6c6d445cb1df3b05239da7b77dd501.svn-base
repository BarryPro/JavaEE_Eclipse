package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8081PrintInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;


	@ParamDesc(path = "BUSI_INFO.PAY_SN", cons = ConsType.CT001, type = "long", len = "20", desc = "流水", memo = "略")
	private long paySn;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		paySn = ValueUtils.longValue(arg0.getStr(getPathByProperName("paySn")));
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

}
