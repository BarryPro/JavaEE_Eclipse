package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SUnifyPortalInitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4743575933472781980L;
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="15",desc="可用余额",memo="略")
	protected long prepayFee = 0;
	@ParamDesc(path="UNBILL_FEE",cons=ConsType.CT001,type="long",len="15",desc="未出帐话费",memo="略")
	protected long unBillFee = 0;
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="15",desc="上月账单总额",memo="略")
	protected long oweFee = 0;
	@ParamDesc(path="ALL_GPRS",cons=ConsType.CT001,type="long",len="15",desc="当月上网总量",memo="略")
	protected long allGprs = 0;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("unBillFee"), unBillFee);
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("oweFee"), oweFee);
		result.setRoot(getPathByProperName("allGprs"), allGprs);

		return result;
	}

	/**
	 * @return the prepayFee
	 */
	public long getPrepayFee() {
		return prepayFee;
	}

	/**
	 * @param prepayFee the prepayFee to set
	 */
	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	/**
	 * @return the unBillFee
	 */
	public long getUnBillFee() {
		return unBillFee;
	}

	/**
	 * @param unBillFee the unBillFee to set
	 */
	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}

	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	/**
	 * @return the allGprs
	 */
	public long getAllGprs() {
		return allGprs;
	}

	/**
	 * @param allGprs the allGprs to set
	 */
	public void setAllGprs(long allGprs) {
		this.allGprs = allGprs;
	}
}
