package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 退费原因删除出参  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8292DelOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2051738856094916726L;
	
	@JSONField(name="OPR_SN")
	@ParamDesc(path="OPR_SN",cons=ConsType.CT001,type="long",len="18",desc="操作流水",memo="略")
	protected long oprSn;
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="int",len="8",desc="操作日期",memo="略")
	protected long totalDate;
	
	
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("OPR_SN",oprSn);
		result.setBody("TOTAL_DATE",totalDate);
		return result;
	}



	/**
	 * @return the oprSn
	 */
	public long getOprSn() {
		return oprSn;
	}



	/**
	 * @param oprSn the oprSn to set
	 */
	public void setOprSn(long oprSn) {
		this.oprSn = oprSn;
	}



	/**
	 * @return the totalDate
	 */
	public long getTotalDate() {
		return totalDate;
	}



	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(long totalDate) {
		this.totalDate = totalDate;
	}

}
