package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   补收查询入参DTO</p>
 * <p>Description:  对补收查询入参进行解析成MBean，并检验入参的正确性 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8010CfmOutDTO  extends CommonOutDTO{	
      
	/**
	 * 
	 */
	private static final long serialVersionUID = 1181292050222069303L;

	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="18",desc="补收流水",memo="略")
	protected long paySn;
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="int",len="8",desc="补收日期",memo="略")
	protected int totalDate;
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("paySn"), paySn);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		return result;
	}


	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}


	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
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
