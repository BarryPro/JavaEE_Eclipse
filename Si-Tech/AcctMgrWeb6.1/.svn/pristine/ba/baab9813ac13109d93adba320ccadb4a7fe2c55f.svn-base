package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 缴费出参 paySn对象  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PayOutEntity implements Serializable{
	
	@JSONField(name = "PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="缴费流水",memo="略")
	private long paySn;

	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}

	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PayOutEntity [paySn=" + paySn + "]";
	}

}
