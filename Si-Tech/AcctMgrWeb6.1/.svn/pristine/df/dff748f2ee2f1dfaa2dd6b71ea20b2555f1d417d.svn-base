package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.AgentEntity;
import com.sitech.acctmgr.atom.domains.pay.PayInfoEntity;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S2302InitInDTO extends CommonInDTO {
	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, type = "string", len = "1", desc = "页数", memo = "")
	private String pageNum;

	@ParamDesc(path="BUSI_INFO.REGION_GROUPID",cons=ConsType.CT001,type="String",len="10",desc="地市group_id",memo="略")
	private String regionGroupId;
	
	@ParamDesc(path="BUSI_INFO.DISTRICT_GROUPID",cons=ConsType.CT001,type="String",len="10",desc="区县group_id",memo="略")
	private String districtGroupId;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPageNum(arg0.getStr(getPathByProperName("pageNum")));
		setRegionGroupId(arg0.getStr(getPathByProperName("regionGroupId")));
		if(StringUtils.isEmptyOrNull(regionGroupId) || "Value".equals(regionGroupId)){
			
			throw new BusiException(getErrorCode(opCode, "01001"), "地市必须选择传入");
		}
		setDistrictGroupId(arg0.getStr(getPathByProperName("districtGroupId")));
		if(StringUtils.isEmptyOrNull(districtGroupId) || "Value".equals(districtGroupId)){
			
			throw new BusiException(getErrorCode(opCode, "01002"), "区县必须选择传入");
		}
		
	}

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public String getRegionGroupId() {
		return regionGroupId;
	}

	public void setRegionGroupId(String regionGroupId) {
		this.regionGroupId = regionGroupId;
	}

	public String getDistrictGroupId() {
		return districtGroupId;
	}

	public void setDistrictGroupId(String districtGroupId) {
		this.districtGroupId = districtGroupId;
	}
	

}
