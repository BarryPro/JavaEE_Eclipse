package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   投诉退费出参DTO</p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guow
 * @version 1.0
 */
public class S8041BackCfmOutDTO  extends CommonOutDTO{	

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3444049747076762095L;
	
	@JSONField(name="BACK_SN")
	@ParamDesc(path="BACK_SN",cons=ConsType.CT001,type="long",len="18",desc="退费冲正流水",memo="略")
	protected long backSn;
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="int",len="8",desc="退费日期",memo="略")
	protected int totalDate;
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("backSn"), backSn);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		return result;
	}

	/**
	 * @return the backSn
	 */
	public long getBackSn() {
		return backSn;
	}

	/**
	 * @param backSn the backSn to set
	 */
	public void setBackSn(long backSn) {
		this.backSn = backSn;
	}

	/**
	 * @return the totalDate
	 */
	public int getTotalDate() {
		return totalDate;
	}


	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

}
