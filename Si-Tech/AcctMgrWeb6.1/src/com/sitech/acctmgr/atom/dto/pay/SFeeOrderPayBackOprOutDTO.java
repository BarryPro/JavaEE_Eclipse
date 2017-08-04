package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeOrderPayBackOprOutDTO extends CommonOutDTO {
	
	private static final long serialVersionUID = -6391264883999766211L;

	@ParamDesc(path="PAYBACKSN_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费冲正流水列表",memo="略")
	private	List<PayOutEntity> paybackSnList = new ArrayList<PayOutEntity>();
	
	@JSONField(name = "PAY_SN" )
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="冲正时间",memo="略")
	protected String totalDate;   //冲正时间


	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setBody("PAYBACKSN_LIST", paybackSnList);
		result.setBody("TOTAL_DATE", totalDate);
		return result;
	}



	/**
	 * @return the paybackSnList
	 */
	public List<PayOutEntity> getPaybackSnList() {
		return paybackSnList;
	}

	/**
	 * @param paybackSnList the paybackSnList to set
	 */
	public void setPaybackSnList(List<PayOutEntity> paybackSnList) {
		this.paybackSnList = paybackSnList;
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
