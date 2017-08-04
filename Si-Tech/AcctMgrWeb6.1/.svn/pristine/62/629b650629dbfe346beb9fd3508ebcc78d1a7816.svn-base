package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SOweIotQryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="long",len="15",desc="余额",memo="单位:分")
	protected long remainFee ;
	@ParamDesc(path="QUERY_TIME",cons=ConsType.CT001,type="String",len="14",desc="查询时间",memo="略")
	protected String queryTime ;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("remainFee"), remainFee);
		result.setRoot(getPathByProperName("queryTime"), queryTime);
		
		return result;
	}

	/**
	 * @return the queryTime
	 */
	public String getQueryTime() {
		return queryTime;
	}

	/**
	 * @param queryTime the queryTime to set
	 */
	public void setQueryTime(String queryTime) {
		this.queryTime = queryTime;
	}

	/**
	 * @return the remainFee
	 */
	public long getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}
}

