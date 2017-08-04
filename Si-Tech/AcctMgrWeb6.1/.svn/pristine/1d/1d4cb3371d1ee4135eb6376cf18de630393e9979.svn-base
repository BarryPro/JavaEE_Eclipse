package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.GiveInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.GiveRecdEntity;
import com.sitech.acctmgr.atom.domains.pay.MonthReturnFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S2311DetailOutDTO extends CommonOutDTO{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = -153076550617641724L;

	//消费信息
	@JSONField(name="LIST_GIVESUCC")
	@ParamDesc(path="MONTH_RETURN_FEE",cons= ConsType.CT001,type="compx",len="1",desc="赠费详细",memo="略")
	protected MonthReturnFeeEntity monthReturnFee;

	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("monthReturnFee"), monthReturnFee);
		return result;
	}


	/**
	 * @return the monthReturnFee
	 */
	public MonthReturnFeeEntity getMonthReturnFee() {
		return monthReturnFee;
	}


	/**
	 * @param monthReturnFee the monthReturnFee to set
	 */
	public void setMonthReturnFee(MonthReturnFeeEntity monthReturnFee) {
		this.monthReturnFee = monthReturnFee;
	}

}
