package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：集团预开发票
 * 
 * @author liuhl_bj
 *
 */
public class S8290QryInDTO extends CommonInDTO {

	private static final long serialVersionUID = -939270329172640327L;

	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "集团编码", memo = "略")
	private long unitId;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		unitId = ValueUtils.longValue(arg0.getStr(getPathByProperName("unitId")));

	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

}
