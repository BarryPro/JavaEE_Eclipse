package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SUserRunTimeQryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="OUT_DATE",cons= ConsType.CT001,type="string",len="8",desc="预拆时间",memo="略")
	private String outDate;
	@ParamDesc(path="STOP_TIME",cons=ConsType.CT001,type="string",len="8",desc="局拆日期",memo="略")
	private String stopTime;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("outDate"), outDate);
		result.setRoot(getPathByProperName("stopTime"), stopTime);
		return result;
	}

	/**
	 * @return the outDate
	 */
	public String getOutDate() {
		return outDate;
	}

	/**
	 * @param outDate the outDate to set
	 */
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}

	/**
	 * @return the stopTime
	 */
	public String getStopTime() {
		return stopTime;
	}

	/**
	 * @param stopTime the stopTime to set
	 */
	public void setStopTime(String stopTime) {
		this.stopTime = stopTime;
	}
}
