package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SFreeChoiceQueryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/*
	 * @ParamDesc(path = "TOTAL_FAV_FEE", cons = ConsType.CT001, len = "", type
	 * = "long", desc = "总优惠费用", memo = "") private long totalFavFee;
	 * 
	 * @ParamDesc(path = "TOTAL_USED_FEE", cons = ConsType.CT001, len = "10",
	 * type = "long", desc = "已使用费用", memo = "") private long totalUsedFee;
	 * 
	 * @ParamDesc(path = "TOTAL_REMAIN_FEE", cons = ConsType.CT001, len = "10",
	 * type = "long", desc = "剩余优惠费用", memo = "") private long totalRemainFee;
	 */

	@ParamDesc(path = "TOTAL_FAV_TIME", cons = ConsType.CT001, len = "10", type = "long", desc = "总免费时长", memo = "")
	private long totalFavTime;

	@ParamDesc(path = "TOTAL_USED_TIME", cons = ConsType.CT001, len = "10", type = "long", desc = "已使用免费时长", memo = "")
	private long totalUsedTime;

	@ParamDesc(path = "TOTAL_REMAIN_TIME", cons = ConsType.CT001, len = "10", type = "long", desc = "剩余免费时长", memo = "")
	private long totalRemainTime;

	@ParamDesc(path = "TOTAL_FAV_MSG", cons = ConsType.CT001, len = "10", type = "long", desc = "总优惠信息", memo = "")
	private long totalFavMsg;

	@ParamDesc(path = "TOTAL_USED_MSG", cons = ConsType.CT001, len = "10", type = "long", desc = "已优惠信息", memo = "")
	private long totalUsedMsg;

	@ParamDesc(path = "TOTAL_REMAIN_MSG", cons = ConsType.CT001, len = "10", type = "long", desc = "已使用优惠信息", memo = "")
	private long totalRemainMsg;

	@ParamDesc(path = "TOTAL_GPRS", cons = ConsType.CT001, len = "10", type = "long", desc = "总GPRS流量", memo = "")
	private long totalGprs;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		/*
		 * result.setRoot(getPathByProperName("totalFavFee"), totalFavFee);
		 * result.setRoot(getPathByProperName("totalUsedFee"), totalUsedFee);
		 * result.setRoot(getPathByProperName("totalRemainFee"),
		 * totalRemainFee);
		 */

		result.setRoot(getPathByProperName("totalFavTime"), totalFavTime);
		result.setRoot(getPathByProperName("totalUsedTime"), totalUsedTime);
		result.setRoot(getPathByProperName("totalRemainTime"), totalRemainTime);

		result.setRoot(getPathByProperName("totalFavMsg"), totalFavMsg);
		result.setRoot(getPathByProperName("totalUsedMsg"), totalUsedMsg);
		result.setRoot(getPathByProperName("totalRemainMsg"), totalRemainMsg);

		result.setRoot(getPathByProperName("totalGprs"), totalGprs);
		return result;
	}

	public long getTotalGprs() {
		return totalGprs;
	}

	public void setTotalGprs(long totalGprs) {
		this.totalGprs = totalGprs;
	}

	public long getTotalFavTime() {
		return totalFavTime;
	}

	public void setTotalFavTime(long totalFavTime) {
		this.totalFavTime = totalFavTime;
	}

	public long getTotalUsedTime() {
		return totalUsedTime;
	}

	public void setTotalUsedTime(long totalUsedTime) {
		this.totalUsedTime = totalUsedTime;
	}

	public long getTotalRemainTime() {
		return totalRemainTime;
	}

	public void setTotalRemainTime(long totalRemainTime) {
		this.totalRemainTime = totalRemainTime;
	}

	public long getTotalFavMsg() {
		return totalFavMsg;
	}

	public void setTotalFavMsg(long totalFavMsg) {
		this.totalFavMsg = totalFavMsg;
	}

	public long getTotalUsedMsg() {
		return totalUsedMsg;
	}

	public void setTotalUsedMsg(long totalUsedMsg) {
		this.totalUsedMsg = totalUsedMsg;
	}

	public long getTotalRemainMsg() {
		return totalRemainMsg;
	}

	public void setTotalRemainMsg(long totalRemainMsg) {
		this.totalRemainMsg = totalRemainMsg;
	}

}
