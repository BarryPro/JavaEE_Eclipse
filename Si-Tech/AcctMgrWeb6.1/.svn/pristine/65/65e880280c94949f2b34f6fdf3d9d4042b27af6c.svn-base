package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:  缴费冲正确认入参DTO </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8056checkInDTO extends CommonInDTO{

	private static final long serialVersionUID = -6244438000347788966L;
	
	@JSONField(name="PAY_DATE")
	@ParamDesc(path="BUSI_INFO.PAY_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String payDate;
	
	@JSONField(name="FOREIGN_SN")
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="long",len="14",desc="要冲正的外部流水",memo="略")
	protected String foreignSn;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8056";//设置默认值
		}
		
		payDate = arg0.getStr(getPathByProperName("payDate"));
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
	}

	
	
	/**
	 * @return the payDate
	 */
	public String getPayDate() {
		return payDate;
	}

	/**
	 * @param payDate the payDate to set
	 */
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	/**
	 * @return the foreignSn
	 */
	public String getForeignSn() {
		return foreignSn;
	}

	/**
	 * @param foreignSn the foreignSn to set
	 */
	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

}

