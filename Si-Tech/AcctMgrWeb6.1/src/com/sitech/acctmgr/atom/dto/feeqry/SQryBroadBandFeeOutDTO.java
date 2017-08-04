package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SQryBroadBandFeeOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2524717556835808608L;
	
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="15",desc="余额",memo="单位：分")
	protected long prepayFee ;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);

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


}

