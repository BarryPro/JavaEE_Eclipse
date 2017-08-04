package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：集团打发票
 * 
 * @author liuhl_bj
 *
 */
public class S8241QryInDTO extends CommonInDTO {

	private static final long serialVersionUID = -939270329172640327L;

	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "集团编码", memo = "略")
	private long unitId;

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.CT001, type = "int", len = "20", desc = "开始时间", memo = "略")
	private int beginDate;

	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.CT001, type = "int", len = "20", desc = "结束时间", memo = "略")
	private int endDate;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		unitId = ValueUtils.longValue(arg0.getStr(getPathByProperName("unitId")));
		beginDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginDate")));
		endDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("endDate")));

	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public int getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(int beginDate) {
		this.beginDate = beginDate;
	}

	public int getEndDate() {
		return endDate;
	}

	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

}
