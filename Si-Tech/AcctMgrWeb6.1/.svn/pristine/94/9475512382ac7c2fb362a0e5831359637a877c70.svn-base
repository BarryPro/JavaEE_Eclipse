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
public class SFeeOrderUpBeginEndTimeOutDTO extends CommonOutDTO {
	
	private static final long serialVersionUID = 5592942102365585613L;

	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="14",desc="操作流水",memo="略")
	protected long loginAccept;
	
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="操作日期",memo="略")
	protected String totalDate;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setBody("PAY_ACCEPT", loginAccept);
		result.setBody("TOTAL_DATE", totalDate);
		return result;
	}


	public long getLoginAccept() {
		return loginAccept;
	}


	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
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
