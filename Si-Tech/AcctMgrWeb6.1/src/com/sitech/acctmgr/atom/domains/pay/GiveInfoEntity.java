package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;


/**
 * 
* @Title:   []
* @Description: 批量赠费导入明细实体类
* @Date : 2016年1月3日下午12:21:24
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class GiveInfoEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2800722172659847979L;

	public GiveInfoEntity() {
		
	}

	
	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.QUES,type="string",len="18",desc="赠送费用",memo="略")
	private String payFee;

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="string",len="18",desc="赠费号码",memo="略")
	private String phoneNo;

	@JSONField(name="AUDIT_FLAG")
	@ParamDesc(path="AUDIT_FLAG",cons=ConsType.QUES,type="string",len="18",desc="审核状态",memo="略")
	private String auditFlag;
	
	@JSONField(name="AUDIT_NAME")
	@ParamDesc(path="AUDIT_NAME",cons=ConsType.QUES,type="string",len="18",desc="审核状态名称",memo="略")
	private String auditName;
 
	@JSONField(name="ACT_SN")
	@ParamDesc(path="ACT_SN",cons=ConsType.CT001,type="string",len="32",desc="操作流水",memo="略")
	private String actSn;
	
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.CT001,type="string",len="512",desc="备注",memo="略")
	private String remark;
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the payFee
	 */
	public String getPayFee() {
		return payFee;
	}

	/**
	 * @param payFee the payFee to set
	 */
	public void setPayFee(String payFee) {
		this.payFee = payFee;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the auditFlag
	 */
	public String getAuditFlag() {
		return auditFlag;
	}

	/**
	 * @param auditFlag the auditFlag to set
	 */
	public void setAuditFlag(String auditFlag) {
		this.auditFlag = auditFlag;
	}

	/**
	 * @return the auditName
	 */
	public String getAuditName() {
		return auditName;
	}

	/**
	 * @param auditName the auditName to set
	 */
	public void setAuditName(String auditName) {
		this.auditName = auditName;
	}

 
 

	/**
	 * @return the actSn
	 */
	public String getActSn() {
		return actSn;
	}

	/**
	 * @param actSn the actSn to set
	 */
	public void setActSn(String actSn) {
		this.actSn = actSn;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "GiveInfoEntity [payFee=" + payFee + ", phoneNo=" + phoneNo + ", auditFlag=" + auditFlag + ", auditName="
				+ auditName + ", actSn=" + actSn + ", remark=" + remark + "]";
	}
 
	 
	 
}
