package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
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
public class SFeeQryIsPayAndExpenseInDTO extends CommonInDTO {
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.OPEN_LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="开户工号",memo="略")
	private String openLoginNo = "";
	@ParamDesc(path="BUSI_INFO.OPEN_TIME",cons=ConsType.CT001,type="String",len="8",desc="开户时间",memo="yyyyMMdd")
	private String openTime = "";
	@ParamDesc(path="BUSI_INFO.OPEN_SN",cons=ConsType.CT001,type="String",len="50",desc="开户流水",memo="略")
	private String openSn = "";
	@ParamDesc(path="BUSI_INFO.OPEN_OP_CODE",cons=ConsType.CT001,type="String",len="20",desc="开户OP_CODE",memo="略")
	private String openOpCode = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		openLoginNo = arg0.getStr(getPathByProperName("openLoginNo"));
		openTime = arg0.getStr(getPathByProperName("openTime"));
		openSn = arg0.getStr(getPathByProperName("openSn"));
		openOpCode = arg0.getStr(getPathByProperName("openOpCode"));
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
	 * @return the openLoginNo
	 */
	public String getOpenLoginNo() {
		return openLoginNo;
	}

	/**
	 * @param openLoginNo the openLoginNo to set
	 */
	public void setOpenLoginNo(String openLoginNo) {
		this.openLoginNo = openLoginNo;
	}

	/**
	 * @return the openTime
	 */
	public String getOpenTime() {
		return openTime;
	}

	/**
	 * @param openTime the openTime to set
	 */
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	/**
	 * @return the openSn
	 */
	public String getOpenSn() {
		return openSn;
	}

	/**
	 * @param openSn the openSn to set
	 */
	public void setOpenSn(String openSn) {
		this.openSn = openSn;
	}

	/**
	 * @return the openOpCode
	 */
	public String getOpenOpCode() {
		return openOpCode;
	}

	/**
	 * @param openOpCode the openOpCode to set
	 */
	public void setOpenOpCode(String openOpCode) {
		this.openOpCode = openOpCode;
	}
	
	
}
