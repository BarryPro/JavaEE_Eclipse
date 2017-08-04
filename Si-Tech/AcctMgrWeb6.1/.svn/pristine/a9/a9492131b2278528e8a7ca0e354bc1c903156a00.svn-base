package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
* @Title: 产品统付和一点支付手工划拨实体类
* @Description:  产品统付和一点支付手工划拨实体类
* @Date : 2016年12月20日上午09:27:12
* @Company: SI-TECH
* @author : SUZJ
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class GroupRelConInfo {
	
	@JSONField(name="REL_CON")
	@ParamDesc(path="REL_CON",cons=ConsType.CT001,type="long",len="14",desc="二级账户",memo="略")
	private long relCon;
	
	@JSONField(name="PAY_VALUE")
	@ParamDesc(path="PAY_VALUE",cons=ConsType.CT001,type="long",len="14",desc="支付定额",memo="略")
	private long payValue;
	
	@JSONField(name="REL_PHONENO")
	@ParamDesc(path="REL_PHONENO",cons=ConsType.CT001,type="String",len="14",desc="手机号",memo="略")
	private String relPhoneNo;
	
	@JSONField(name="CON_ENCRYP_NAME")
	@ParamDesc(path="CON_ENCRYP_NAME",cons=ConsType.CT001,type="String",len="14",desc="客户姓名",memo="略")
	private String conEncrypName;

	@JSONField(name="RUN_NAME")
	@ParamDesc(path="RUN_NAME",cons=ConsType.CT001,type="String",len="14",desc="用户状态",memo="略")
	private String runName;
	
	@JSONField(name="REMAIN_FEE")
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="double",len="14",desc="余额",memo="略")
	private double remainFee;

	/**
	 * @return the relCon
	 */
	public long getRelCon() {
		return relCon;
	}

	/**
	 * @param relCon the relCon to set
	 */
	public void setRelCon(long relCon) {
		this.relCon = relCon;
	}

	/**
	 * @return the payValue
	 */
	public long getPayValue() {
		return payValue;
	}

	/**
	 * @param payValue the payValue to set
	 */
	public void setPayValue(long payValue) {
		this.payValue = payValue;
	}

	/**
	 * @return the relPhoneNo
	 */
	public String getRelPhoneNo() {
		return relPhoneNo;
	}

	/**
	 * @param relPhoneNo the relPhoneNo to set
	 */
	public void setRelPhoneNo(String relPhoneNo) {
		this.relPhoneNo = relPhoneNo;
	}

	/**
	 * @return the conEncrypName
	 */
	public String getConEncrypName() {
		return conEncrypName;
	}

	/**
	 * @param conEncrypName the conEncrypName to set
	 */
	public void setConEncrypName(String conEncrypName) {
		this.conEncrypName = conEncrypName;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "GroupRelConInfo [relCon=" + relCon + ", payValue=" + payValue
				+ ", relPhoneNo=" + relPhoneNo + ", conEncrypName="
				+ conEncrypName + ", runName=" + runName + ", remainFee="
				+ remainFee + "]";
	}

	/**
	 * @return the runName
	 */
	public String getRunName() {
		return runName;
	}

	/**
	 * @param runName the runName to set
	 */
	public void setRunName(String runName) {
		this.runName = runName;
	}

	/**
	 * @return the remainFee
	 */
	public double getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(double remainFee) {
		this.remainFee = remainFee;
	}
	
	
	
}
