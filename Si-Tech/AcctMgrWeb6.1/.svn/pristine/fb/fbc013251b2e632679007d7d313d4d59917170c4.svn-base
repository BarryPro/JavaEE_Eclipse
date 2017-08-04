package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayTypeInitInDTO extends CommonInDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8373063516735408164L;
	@ParamDesc(path="BUSI_INFO.QUERY_FLAG",cons=ConsType.QUES,type="String",len="1",desc="查询标志",memo="略")
	private String queryFlag;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setQueryFlag(arg0.getObject(getPathByProperName("queryFlag")).toString());

	}

	/**
	 * @return the queryFlag
	 */
	public String getQueryFlag() {
		return queryFlag;
	}

	/**
	 * @param queryFlag the queryFlag to set
	 */
	public void setQueryFlag(String queryFlag) {
		this.queryFlag = queryFlag;
	}
}
