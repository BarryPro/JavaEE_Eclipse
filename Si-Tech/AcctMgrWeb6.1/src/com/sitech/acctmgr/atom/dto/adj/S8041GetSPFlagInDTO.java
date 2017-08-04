package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * <p>Title:   查询SP标志入参DTO</p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author liuyc_billing
 * @version 1.0
 */
public class S8041GetSPFlagInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1122204424886535748L;
	
	@ParamDesc(path="BUSI_INFO.REASON_CODE",cons=ConsType.QUES,type="String",len="200",desc="退费原因id",memo="")
	protected String reasonId;
	@ParamDesc(path="BUSI_INFO.REASON_FLAG",cons=ConsType.QUES,type="String",len="200",desc="退费原因id",memo="")
	protected String reasonFlag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setReasonId(arg0.getStr(getPathByProperName("reasonId")));
		setReasonFlag(arg0.getStr(getPathByProperName("reasonFlag")));
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8041";
		}
	}

	

	public String getReasonFlag() {
		return reasonFlag;
	}



	public void setReasonFlag(String reasonFlag) {
		this.reasonFlag = reasonFlag;
	}

	public String getReasonId() {
		return reasonId;
	}


	public void setReasonId(String reasonId) {
		this.reasonId = reasonId;
	}

}
