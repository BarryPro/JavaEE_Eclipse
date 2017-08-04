package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 投诉退费原因新增  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8292AddInDTO extends CommonInDTO{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1507891820714316913L;
	
	@ParamDesc(path = "BUSI_INFO.REASON_CODE", cons = ConsType.QUES, desc = "退费原因代码", len = "20", type = "string", memo = "略")
	protected String reasonCode;
	@ParamDesc(path = "BUSI_INFO.REASON_NAME", cons = ConsType.CT001, desc = "退费原因", len = "128", type = "string", memo = "略")
	protected String reasonName;
	@ParamDesc(path = "BUSI_INFO.REASON_FLAG", cons = ConsType.CT001, desc = "退费原因标志", len = "1", type = "string", memo = "1:一级原因 2：二级原因 3：三级原因")
	protected String reasonFlag;
	@ParamDesc(path = "BUSI_INFO.SP_FLAG", cons = ConsType.CT001, desc = "sp标志", len = "1", type = "string", memo = "1:非SP原因 2：SP原因 ")
	protected String spFlag;
	 


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setReasonName(arg0.getStr(getPathByProperName("reasonName")));
		setReasonFlag(arg0.getStr(getPathByProperName("reasonFlag")));
		setReasonCode(arg0.getStr(getPathByProperName("reasonCode")));
		setSpFlag(arg0.getStr(getPathByProperName("spFlag")));
	}

	/**
	 * 
	 * @return
	 */
	public String getSpFlag() {
		return spFlag;
	}

	/**
	 * 
	 * @param spFlag
	 */
	public void setSpFlag(String spFlag) {
		this.spFlag = spFlag;
	}


	/**
	 * @return the reasonName
	 */
	public String getReasonName() {
		return reasonName;
	}


	/**
	 * @param reasonName the reasonName to set
	 */
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}


	/**
	 * @return the reasonFlag
	 */
	public String getReasonFlag() {
		return reasonFlag;
	}


	/**
	 * @param reasonFlag the reasonFlag to set
	 */
	public void setReasonFlag(String reasonFlag) {
		this.reasonFlag = reasonFlag;
	}


	/**
	 * @return the reasonCode
	 */
	public String getReasonCode() {
		return reasonCode;
	}


	/**
	 * @param reasonCode the reasonCode to set
	 */
	public void setReasonCode(String reasonCode) {
		this.reasonCode = reasonCode;
	}
}
