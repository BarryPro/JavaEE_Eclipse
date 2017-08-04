package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by liuhl_bj on 2016/8/9.
 */
public class SGrpUserByUnitIdInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, desc = "集团编码", len = "15", type = "string", memo = "手机号码")
	private String unitId;

	// @ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, desc =
	// "在网离网标志", len = "1", type = "string", memo = "0:在网，1：离网")
	// private int flag;

	@Override
	public void decode(MBean mBean) {
		unitId = mBean.getStr(getPathByProperName("unitId"));
		// flag = Integer.parseInt(mBean.getStr(getPathByProperName("flag")));
	}

	/*
	 * public int getFlag() { return flag; }
	 * 
	 * public void setFlag(int flag) { this.flag = flag; }
	 */

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

}
