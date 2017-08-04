package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


/**
 *
 * <p>Title:   </p>
 * <p>Description:  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class SSpecialFeeCheckInDTO extends CommonInDTO {

	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.IPRE_FLAG",cons=ConsType.CT001,type="String",len="40",desc="预约标志",memo="正常申请：“0”，预约申请：“1”")
	protected String ipreFlag;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setIpreFlag(arg0.getStr(getPathByProperName("ipreFlag")));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the ipreFlag
	 */
	public String getIpreFlag() {
		return ipreFlag;
	}

	/**
	 * @param ipreFlag the ipreFlag to set
	 */
	public void setIpreFlag(String ipreFlag) {
		this.ipreFlag = ipreFlag;
	}
}
