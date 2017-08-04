package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 缴费查询入参DTO  </p>
 * <p>Description: 缴费查询入参DTO  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class SCheckConCheckRemainFeeInDTO extends CommonInDTO {
	
	private static final long serialVersionUID = 1655753234641396939L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.CHECK_FEE",cons=ConsType.CT001,type="String",len="14",desc="校验金额",memo="单位：分")
	private long checkFee;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		checkFee = Long.parseLong(arg0.getStr(getPathByProperName("checkFee")));
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
	 * @return the checkFee
	 */
	public long getCheckFee() {
		return checkFee;
	}

	/**
	 * @param checkFee the checkFee to set
	 */
	public void setCheckFee(long checkFee) {
		this.checkFee = checkFee;
	}

}
