package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SKdRemainOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="SPECIAL_REMAIN",cons=ConsType.CT001,type="long",len="15",desc="包年剩余费用",memo="单位：分")
	protected long specialRemain ;
	@ParamDesc(path="COMMON_AVAILABLE",cons=ConsType.CT001,type="long",len="15",desc="可用预存款",memo="单位：分")
	protected long commonAvailable ;
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="40",desc="当前账本类型",memo="")
	protected String payType ;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("specialRemain"), specialRemain);
		result.setRoot(getPathByProperName("commonAvailable"), commonAvailable);
		result.setRoot(getPathByProperName("payType"), payType);

		return result;
	}

	/**
	 * @return the specialRemain
	 */
	public long getSpecialRemain() {
		return specialRemain;
	}

	/**
	 * @param specialRemain the specialRemain to set
	 */
	public void setSpecialRemain(long specialRemain) {
		this.specialRemain = specialRemain;
	}

	/**
	 * @return the commonAvailable
	 */
	public long getCommonAvailable() {
		return commonAvailable;
	}

	/**
	 * @param commonAvailable the commonAvailable to set
	 */
	public void setCommonAvailable(long commonAvailable) {
		this.commonAvailable = commonAvailable;
	}

	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}

}

