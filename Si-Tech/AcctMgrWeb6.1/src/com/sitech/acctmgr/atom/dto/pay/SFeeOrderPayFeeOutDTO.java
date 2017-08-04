package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeOrderPayFeeOutDTO extends CommonOutDTO {
	
	private static final long serialVersionUID = 5592942102365585613L;

	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="缴费流水",memo="略")
	protected long payAccept;//缴费流水
	
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String totalDate;//缴费日期
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setBody("PAY_ACCEPT", payAccept);
		result.setBody("TOTAL_DATE", totalDate);
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
