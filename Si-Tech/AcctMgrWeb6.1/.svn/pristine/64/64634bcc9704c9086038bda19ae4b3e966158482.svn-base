package com.sitech.acctmgr.atom.dto.feeqry;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPhonePayNewInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="PHONE_NO和BROAD_BAND_PHONE不能同时为空，传其中一个参数")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="String",len="8",desc="开始时间",memo="年月日")
	private String beginDate = "";
	@ParamDesc(path="BUSI_INFO.END_DATE",cons=ConsType.CT001,type="String",len="8",desc="结束时间",memo="年月日")
	private String endDate = "";
	@ParamDesc(path="BUSI_INFO.BROAD_BAND_PHONE",cons=ConsType.CT001,type="String",len="20",desc="宽带号码",memo="PHONE_NO和BROAD_BAND_PHONE不能同时为空，传其中一个参数")
	private String broadBandPhone = "";

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))){
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("broadBandPhone")))){
			broadBandPhone = arg0.getStr(getPathByProperName("broadBandPhone"));
		}
		if (StringUtils.isEmptyOrNull(phoneNo) && StringUtils.isEmptyOrNull(broadBandPhone)){
			throw new BusiException(getErrorCode("0000", "01002"), "PHONE_NO和BROAD_BAND_PHONE不能同时为空");
		}
		beginDate = arg0.getStr(getPathByProperName("beginDate"));
		endDate = arg0.getStr(getPathByProperName("endDate"));
		if(Integer.parseInt(beginDate) > Integer.parseInt(endDate)) {
			throw new BusiException("0000", "00001", "开始时间不能大于结束时间");
		}
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
	 * @return the beginDate
	 */
	public String getBeginDate() {
		return beginDate;
	}

	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the broadBandPhone
	 */
	public String getBroadBandPhone() {
		return broadBandPhone;
	}

	/**
	 * @param broadBandPhone the broadBandPhone to set
	 */
	public void setBroadBandPhone(String broadBandPhone) {
		this.broadBandPhone = broadBandPhone;
	}
}
