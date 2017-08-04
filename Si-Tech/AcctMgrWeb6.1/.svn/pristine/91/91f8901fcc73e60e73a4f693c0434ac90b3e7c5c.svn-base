package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 缴费确认账本+金额对象  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PayInfoEntity implements Serializable{

	@JSONField(name = "PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",
	memo="账本类型编码取值跟老系统保持一致")
	private String payType;
	
	@JSONField(name = "PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="String",len="14",desc="交费金额",memo="单位:分")
	private String payMoney;
	
	@JSONField(name = "END_TIME")
	@ParamDesc(path="END_TIME",cons=ConsType.CT001,type="String",len="14",desc="账本失效时间",memo="略")
	private String endTime;

	
	@Override
	public String toString() {
		return "PayInfoEntity [PAY_TYPE=" + payType + ", PAY_MONEY="
				+ payMoney  + ", END_TIME="+ endTime  + "]";
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

	/**
	 * @return the payMoney
	 */
	public String getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}
	
	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
