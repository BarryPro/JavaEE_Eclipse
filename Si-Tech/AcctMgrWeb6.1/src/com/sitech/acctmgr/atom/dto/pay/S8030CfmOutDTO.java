package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 托收缴费确认出参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8030CfmOutDTO extends CommonOutDTO{

	private static final long serialVersionUID = -5755246998730318004L;
	
	@JSONField(name="PAY_ACCEPT")
	@ParamDesc(path="PAY_ACCEPT",cons=ConsType.STAR,type="Long",len="14",desc="缴费流水",memo="略")
	protected long payAccept;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.STAR,type="String",len="8",desc="缴费时间",memo="略")
	protected String totalDate;
	

	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("payAccept"), payAccept);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		return result;
	}


	/**
	 * @return the payAccept
	 */
	public long getPayAccept() {
		return payAccept;
	}


	/**
	 * @param payAccept the payAccept to set
	 */
	public void setPayAccept(long payAccept) {
		this.payAccept = payAccept;
	}


	/**
	 * @return the totalDate
	 */
	public String getTotalDate() {
		return totalDate;
	}


	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

}
