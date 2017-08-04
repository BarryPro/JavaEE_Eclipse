package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 空中充值确认出参DTO </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8016CfmOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -16866507808330109L;

	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="缴费流水",memo="略")
	protected long paySn;
	
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String totalDate;
	
	@ParamDesc(path="AGENT_REMAIN_FEE",cons=ConsType.CT001,type="long",len="14",desc="代理商余额",memo="略")
	private long agentRemainFee = 0;
	
	@ParamDesc(path="AGENT_CONTRACT_NAME",cons=ConsType.CT001,type="String",len="60",desc="代理商账户名称",memo="略")
	private String agentContractName;
	
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="long",len="14",desc="充值账户余额",memo="略")
	private long remainFee = 0;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("paySn"), paySn);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		result.setRoot(getPathByProperName("agentRemainFee"), agentRemainFee);
		result.setRoot(getPathByProperName("agentContractName"), agentContractName);
		result.setRoot(getPathByProperName("remainFee"), remainFee);
		return result;
	}



	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public String getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	public long getAgentRemainFee() {
		return agentRemainFee;
	}

	public void setAgentRemainFee(long agentRemainFee) {
		this.agentRemainFee = agentRemainFee;
	}

	public String getAgentContractName() {
		return agentContractName;
	}

	public void setAgentContractName(String agentContractName) {
		this.agentContractName = agentContractName;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

}
