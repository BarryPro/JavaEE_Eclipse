package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8293BatchInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.RELPATH", cons = ConsType.CT001, desc = "相对路径", len = "100", type = "string", memo = "略")
	private String relPath;
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setRelPath(arg0.getStr(getPathByProperName("relPath")));
	}

	/**
	 * @return the relPath
	 */
	public String getRelPath() {
		return relPath;
	}

	/**
	 * @param relPath the relPath to set
	 */
	public void setRelPath(String relPath) {
		this.relPath = relPath;
	}
}
