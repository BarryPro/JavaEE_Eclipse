package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 欠费催缴确认服务出参 </p>
* <p>Description:   </p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8076CfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5270226760309349340L;
	

	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="40",desc="账户号码",memo="略")
	protected long contractNo;
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="40",desc="流水",memo="略")
	protected	long paySn;
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("paySn"), paySn);
		return result;
	}




	public long getContractNo() {
		return contractNo;
	}


	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}




	public long getPaySn() {
		return paySn;
	}




	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}


}
