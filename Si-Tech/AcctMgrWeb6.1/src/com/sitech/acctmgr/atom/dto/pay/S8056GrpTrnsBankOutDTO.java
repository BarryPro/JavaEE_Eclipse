package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
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
public class S8056GrpTrnsBankOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8624754795438961440L;

	@JSONField(name = "PAY_SN" )
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="红包冲正流水",memo="略")
	protected long paybackPaysn;  //红包冲正流水
	
	@JSONField(name = "PAY_SN" )
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="冲正时间",memo="略")
	protected String totalDate;   //冲正时间
	

	public S8056GrpTrnsBankOutDTO(){}
	
	public S8056GrpTrnsBankOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.paybackPaysn = mBean.getBodyLong("OUT_DATA.LOGIN_ACCEPT");
		this.totalDate = mBean.getBodyStr("OUT_DATA.TOTAL_DATE");
	}


	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody("LOGIN_ACCEPT", paybackPaysn);
		result.setBody("TOTAL_DATE", totalDate);
		return result;
	}

	/**
	 * @return the paybackPaysn
	 */
	public long getPaybackPaysn() {
		return paybackPaysn;
	}

	/**
	 * @param paybackPaysn the paybackPaysn to set
	 */
	public void setPaybackPaysn(long paybackPaysn) {
		this.paybackPaysn = paybackPaysn;
	}

	/**
	 * @return the totalDate
	 */
	public String getTotalDate() {
		return totalDate;
	}

	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}


}
