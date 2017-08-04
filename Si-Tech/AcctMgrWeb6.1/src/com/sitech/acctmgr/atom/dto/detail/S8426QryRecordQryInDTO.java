package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8426QryRecordQryInDTO extends CommonInDTO {
	
	private static final long serialVersionUID = -5723254279006496638L;

	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.CT001, desc = "开始时间", len = "8", type = "string", memo = "按照时间段查询详单查询记录，开始日期，格式为YYYYMMDD")
	private String beginTime;
	
	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.CT001, desc = "结束时间", len = "8", type = "string", memo = "按照时间段查询详单查询记录，结束日期，格式为YYYYMMDD")
	private String endTime;
	
	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, desc = "每页展示条数", len = "2", type = "int", memo = "")
	private int pageNum;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		if(!arg0.getStr(getPathByProperName("beginTime")).isEmpty()){
			beginTime = arg0.getStr(getPathByProperName("beginTime"));
		}
		if(!arg0.getStr(getPathByProperName("endTime")).isEmpty()){
			endTime = arg0.getStr(getPathByProperName("endTime"));
		}
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("pageNum")))) {
			pageNum = ValueUtils.intValue(arg0.getStr(getPathByProperName("pageNum")));
		}
	}
	
	
	

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
}
