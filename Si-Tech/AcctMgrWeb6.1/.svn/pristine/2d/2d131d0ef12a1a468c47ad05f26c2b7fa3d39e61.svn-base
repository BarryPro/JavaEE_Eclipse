package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.prod.UserPdPrcEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/14.
 */
public class SFavTypeQueryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "ID_NO", desc = "用户标识ID", cons = ConsType.CT001, type = "long", len = "18", memo = "")
	private long idNo;

	@ParamDesc(path = "REGION_CODE", desc = "地市代码", cons = ConsType.CT001, type = "String", len = "4", memo = "")
	private String regionCode;

	@ParamDesc(path = "MODE_CODE", desc = "套餐模板代码", cons = ConsType.CT001, type = "String", len = "4", memo = "")
	private String modeCode;

	@ParamDesc(path = "RATE_CODE", desc = "二次批价代码", cons = ConsType.CT001, type = "String", len = "4", memo = "")
	private String rateCode;

	@ParamDesc(path = "FAV_TYPE", desc = "优惠类型", cons = ConsType.CT001, type = "String", len = "3", memo = "")
	private String favType;

	@ParamDesc(path = "FAV_FEE", desc = "优惠费用", cons = ConsType.CT001, type = "long", len = "18", memo = "")
	private long favFee;

	@ParamDesc(path = "FAV_NAME", desc = "优惠项目", cons = ConsType.CT001, type = "String", len = "60", memo = "")
	private String favName = ""; // 优惠项目

	@ParamDesc(path = "FAV_REMAIN", desc = "套餐优惠剩余", cons = ConsType.CT001, type = "long", len = "18", memo = "")
	private long favRemain;

	// @ParamDesc(path = "SPEC_FUND_FLAG", desc = "是否有预存赠机专款", cons = ConsType.CT001, type = "String", len = "1", memo = "0:未办理；1：已办理预存购机")
	// private String specFundFlag;

	@ParamDesc(path = "USER_PDPRC_LIST", desc = "套餐列表", cons = ConsType.STAR, type = "compx", len = "1", memo = "")
	private List<UserPdPrcEntity> userPdPrcList;

	@ParamDesc(path = "RETURN_CODE", desc = "返回码", cons = ConsType.STAR, type = "string", len = "1", memo = "")
	private String returnCodeBody;

	@ParamDesc(path = "SPEC_FUND", desc = "是否有预存赠机等专款", cons = ConsType.STAR, type = "int", len = "1", memo = "")
	private int specFund;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("idNo"), idNo);
		result.setRoot(getPathByProperName("regionCode"), regionCode);
		result.setRoot(getPathByProperName("modeCode"), modeCode);
		result.setRoot(getPathByProperName("rateCode"), rateCode);
		result.setRoot(getPathByProperName("favType"), favType);
		result.setRoot(getPathByProperName("favFee"), favFee);
		result.setRoot(getPathByProperName("favName"), favName);
		result.setRoot(getPathByProperName("favRemain"), favRemain);
		// result.setRoot(getPathByProperName("specFundFlag"), specFundFlag);
		result.setRoot(getPathByProperName("userPdPrcList"), userPdPrcList);
		result.setRoot(getPathByProperName("returnCodeBody"), returnCodeBody);
		result.setRoot(getPathByProperName("specFund"), specFund);
		return result;
	}

	public int getSpecFund() {
		return specFund;
	}

	public void setSpecFund(int specFund) {
		this.specFund = specFund;
	}


	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getModeCode() {
		return modeCode;
	}

	public void setModeCode(String modeCode) {
		this.modeCode = modeCode;
	}

	public String getRateCode() {
		return rateCode;
	}

	public void setRateCode(String rateCode) {
		this.rateCode = rateCode;
	}


	public List<UserPdPrcEntity> getUserPdPrcList() {
		return userPdPrcList;
	}

	public void setUserPdPrcList(List<UserPdPrcEntity> userPdPrcList) {
		this.userPdPrcList = userPdPrcList;
	}

	public String getFavType() {
		return favType;
	}

	public void setFavType(String favType) {
		this.favType = favType;
	}

	public long getFavFee() {
		return favFee;
	}

	public void setFavFee(long favFee) {
		this.favFee = favFee;
	}

	public String getFavName() {
		return favName;
	}

	public void setFavName(String favName) {
		this.favName = favName;
	}

	public long getFavRemain() {
		return favRemain;
	}

	public void setFavRemain(long favRemain) {
		this.favRemain = favRemain;
	}

	public String getReturnCodeBody() {
		return returnCodeBody;
	}

	public void setReturnCodeBody(String returnCodeBody) {
		this.returnCodeBody = returnCodeBody;
	}

}
