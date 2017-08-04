package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class S8250QueryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5892504417787185105L;

	@ParamDesc(path="BUSI_INFO.SELECT_FLAG",cons=ConsType.CT001,type="String",len="1",desc="查询标识",memo="略")
	private String selectFlag;
	
	@ParamDesc(path="BUSI_INFO.REGION_CODE",cons=ConsType.CT001,type="String",len="5",desc="配置地市",memo="略")
	private String regionCode;
	
	@ParamDesc(path="BUSI_INFO.WORK_NO",cons=ConsType.CT001,type="String",len="20",desc="工号",memo="略")
	private String workNo;
	
	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		setWorkNo(arg0.getStr(getPathByProperName("workNo")));
		setSelectFlag(arg0.getStr(getPathByProperName("selectFlag")));
 	}
	
	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getWorkNo() {
		return workNo;
	}

	public void setWorkNo(String workNo) {
		this.workNo = workNo;
	}

	/**
	 * @return the selectFlag
	 */
	public String getSelectFlag() {
		return selectFlag;
	}

	/**
	 * @param selectFlag the selectFlag to set
	 */
	public void setSelectFlag(String selectFlag) {
		this.selectFlag = selectFlag;
	}
	
}
