package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl
 *
 */
public class SMonthShareQryInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.CT001, desc = "用户ID", len = "15", type = "long", memo = "略")
	private long idNo = 0;

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, desc = "标志", len = "1", type = "string", memo = "X:查询主资费信息   Y:查询资费明细项")
	private String flag;

	@ParamDesc(path = "BUSI_INFO.EFFECT_FLAG", cons = ConsType.CT001, desc = "生效或者预约资费标志", len = "1", type = "string", memo = "0：生效  1：预约")
	private String effectFlag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))) {
			idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
		}

		if (StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))
				&& StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00110"), "服务号码和ID_NO不能同时为空");
		}

		flag = arg0.getStr(getPathByProperName("flag"));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("effectFlag")))) {
			effectFlag = arg0.getStr(getPathByProperName("effectFlag"));
		}
		
		if (flag.equals("Y") && StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("effectFlag")))) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00110"), "查询明细传入资费是否在生效期内");
		}
	}

	public String getEffectFlag() {
		return effectFlag;
	}

	public void setEffectFlag(String effectFlag) {
		this.effectFlag = effectFlag;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

}
