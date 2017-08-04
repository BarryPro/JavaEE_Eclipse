package com.sitech.acctmgr.atom.domains.pay;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* <p>Title: 智能终端CRM缴费报表展示实体  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2017</p>
* <p>Company: SI-TECH </p>
* @author suzj
* @version 1.0
*/
public class CRMIntellPrtEntity implements Serializable {
	
	@JSONField(name="BRAND_NAME")
	@ParamDesc(path="BRAND_NAME",cons=ConsType.CT001,type="String",len="20",desc="品牌",memo="略")
	private String brandName;
	
	@JSONField(name="PAY_NUM")
	@ParamDesc(path="PAY_NUM",cons=ConsType.CT001,type="Integer",len="10",desc="数量",memo="略")
	private int payNum;
	
	@JSONField(name="OP_NAME")
	@ParamDesc(path="OP_NAME",cons=ConsType.CT001,type="String",len="30",desc="操作模块",memo="略")
	private String opName;
	
	@JSONField(name="PAY_NAME")
	@ParamDesc(path="PAY_NAME",cons=ConsType.CT001,type="Stirng",len="20",desc="付费类型",memo="略")
	private String payName;
	
	@JSONField(name="LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="Long",len="20",desc="流水",memo="略")
	private long loginAccept;
	
	@JSONField(name="PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="Long",len="20",desc="缴费金额",memo="略")
	private long payMoney;

	/**
	 * @return the brandName
	 */
	public String getBrandName() {
		return brandName;
	}

	/**
	 * @param brandName the brandName to set
	 */
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	/**
	 * @return the payNum
	 */
	public int getPayNum() {
		return payNum;
	}

	/**
	 * @param payNum the payNum to set
	 */
	public void setPayNum(int payNum) {
		this.payNum = payNum;
	}

	/**
	 * @return the opName
	 */
	public String getOpName() {
		return opName;
	}

	/**
	 * @param opName the opName to set
	 */
	public void setOpName(String opName) {
		this.opName = opName;
	}

	/**
	 * @return the payName
	 */
	public String getPayName() {
		return payName;
	}

	/**
	 * @param payName the payName to set
	 */
	public void setPayName(String payName) {
		this.payName = payName;
	}

	/**
	 * @return the loginAccept
	 */
	public long getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CRMIntellPrtEntity [brandName=" + brandName + ", payNum="
				+ payNum + ", opName=" + opName + ", payName=" + payName
				+ ", loginAccept=" + loginAccept + ", payMoney=" + payMoney
				+ "]";
	}
	
}
