package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8293InitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4927146794281931779L;
	@ParamDesc(path="BUSI_INFO.UNIT_INPARAM",cons=ConsType.QUES,type="String",len="20",desc="虚拟集团帐号",memo="略")
	private String uniInparam;
	@ParamDesc(path="BUSI_INFO.QUERY_TYPE",cons=ConsType.QUES,type="String",len="1",desc="查询方式",memo="1:按集团虚拟号码查询，2:按集团虚拟成员查询")
	private String queryType;
	
	public void decode(MBean arg0){
		super.decode(arg0);		
		setUniInparam(arg0.getObject(getPathByProperName("uniInparam")).toString());
		setQueryType(arg0.getObject(getPathByProperName("queryType")).toString());
	}

	/**
	 * @return the uniInparam
	 */
	public String getUniInparam() {
		return uniInparam;
	}

	/**
	 * @param uniInparam the uniInparam to set
	 */
	public void setUniInparam(String uniInparam) {
		this.uniInparam = uniInparam;
	}

	/**
	 * @return the queryType
	 */
	public String getQueryType() {
		return queryType;
	}

	/**
	 * @param queryType the queryType to set
	 */
	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

}
